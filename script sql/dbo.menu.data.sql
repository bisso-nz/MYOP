SET IDENTITY_INSERT [dbo].[menu] ON
INSERT INTO [dbo].[menu] ([Id], [nom], [prix]) VALUES (1, N'menu a', CAST(12.00 AS Decimal(4, 2)))
INSERT INTO [dbo].[menu] ([Id], [nom], [prix]) VALUES (2, N'menu b ', CAST(7.00 AS Decimal(4, 2)))
INSERT INTO [dbo].[menu] ([Id], [nom], [prix]) VALUES (3, N'menu c', CAST(15.00 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[menu] OFF
