--!strict
--Function overloads: autocomplete works for <=16 tables
type Constructor =
   (<A>                                             (A                                             ) -> A                                                            )
 & (<A, B>                                          (A, B                                          ) -> A & B                                                        )
 & (<A, B, C>                                       (A, B, C                                       ) -> A & B & C                                                    )
 & (<A, B, C, D>                                    (A, B, C, D                                    ) -> A & B & C & D                                                )
 & (<A, B, C, D, E>                                 (A, B, C, D, E                                 ) -> A & B & C & D & E                                            )
 & (<A, B, C, D, E, F>                              (A, B, C, D, E, F                              ) -> A & B & C & D & E & F                                        )
 & (<A, B, C, D, E, F, G>                           (A, B, C, D, E, F, G                           ) -> A & B & C & D & E & F & G                                    )
 & (<A, B, C, D, E, F, G, H>                        (A, B, C, D, E, F, G, H                        ) -> A & B & C & D & E & F & G & H                                )
 & (<A, B, C, D, E, F, G, H, I>                     (A, B, C, D, E, F, G, H, I                     ) -> A & B & C & D & E & F & G & H & I                            )
 & (<A, B, C, D, E, F, G, H, I, J>                  (A, B, C, D, E, F, G, H, I, J                  ) -> A & B & C & D & E & F & G & H & I & J                        )
 & (<A, B, C, D, E, F, G, H, I, J, K>               (A, B, C, D, E, F, G, H, I, J, K               ) -> A & B & C & D & E & F & G & H & I & J & K                    ) 
 & (<A, B, C, D, E, F, G, H, I, J, K, L>            (A, B, C, D, E, F, G, H, I, J, K, L            ) -> A & B & C & D & E & F & G & H & I & J & K & L                )
 & (<A, B, C, D, E, F, G, H, I, J, K, L, M>         (A, B, C, D, E, F, G, H, I, J, K, L, M         ) -> A & B & C & D & E & F & G & H & I & J & K & L & M            )
 & (<A, B, C, D, E, F, G, H, I, J, K, L, M, N>      (A, B, C, D, E, F, G, H, I, J, K, L, M, N      ) -> A & B & C & D & E & F & G & H & I & J & K & L & M & N        )
 & (<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O>   (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O   ) -> A & B & C & D & E & F & G & H & I & J & K & L & M & N & O    )
 & (<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P>(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P) -> A & B & C & D & E & F & G & H & I & J & K & L & M & N & O & P)

--Deep copy of a table with cyclic reference protection
local function Clone(value: any, visited: {[any]: any}?)
	if type(value) ~= "table" then return value end
	
	visited = visited or {}

	if visited[value] then return visited[value] end
	
	local newTable = {}

	visited[value] = newTable

	for i, v in value do newTable[i] = Clone(v, visited) end
	
	setmetatable(newTable, getmetatable(value))
	
	return newTable
end

@native function Mixin(...)
	local self = {}
	
	for i = 1, select("#", ...) do
		local object = select(i, ...)
		
		for i, member in object do
			self[i] = Clone(member)
		end
	end
	
	return self
end

return Mixin :: Constructor