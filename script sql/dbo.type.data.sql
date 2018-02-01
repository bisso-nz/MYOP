SET IDENTITY_INSERT [dbo].[type] ON
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (1, N'mega', CAST(3 AS Decimal(18, 0)), 1, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (2, N'mega', CAST(3 AS Decimal(18, 0)), 2, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (3, N'junior', CAST(1 AS Decimal(18, 0)), 1, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (4, N'junior', CAST(1 AS Decimal(18, 0)), 2, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (5, N'senior', CAST(2 AS Decimal(18, 0)), 2, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (6, N'calzone', CAST(2 AS Decimal(18, 0)), 3, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (7, N'pizza au metre', CAST(5 AS Decimal(18, 0)), 4, 1)
INSERT INTO [dbo].[type] ([Id], [nom], [coefficient], [pizzeria_id], [disponible]) VALUES (8, N'pizza au metre', CAST(4 AS Decimal(18, 0)), 1, 0)
SET IDENTITY_INSERT [dbo].[type] OFF
