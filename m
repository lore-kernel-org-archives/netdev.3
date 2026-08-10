Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BD3BADA9;
	Mon, 10 Aug 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358023; cv=fail; b=ipHMuECTCzTtvfG+jvQhdCEKMTmRd9Ai8NkytE7rfw+ncMu1RPbXEUYBfYiWB3yc4+RdA2EYKHavCnPGbs7FD1SbtOynPpapjiNoSKiGipUES/acY9ez4sHYGlyqH5bRibRNOfj73YCg1A6jXEnF221D6Bqf/j3DfVLRnh619Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358023; c=relaxed/simple;
	bh=TaChUf8HebavfXrd4cnzwHb2jFqgPYdKbMC6AMwfduM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a2cUfMdN26jEAJyhvrJmy1WavCcedBNOhH1RVghf9iTY3hcsr1t+b3rVYeNWQYHGYGqRzwYJl5cCKI4InZ84ks0p0sOUFRLqt3s1m2npdLsK44QpECTbvgMbn3phW26M8MzUp2M6VLnXizEIkzSR8poFRGyoQ9UBsteZuF9NNpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjEAfdz/; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjEAfdz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnUUpdbHYTSOZcAuvTBDpWHQ5EAZu2nGqxQrlE2Nprbo6+0FhKzqKHM6YnagOKuJUMJcnMl5YdrCxhpOUtPGB3QQLPvrLOaUzy4tWgBolJaI/lp5HAhsyYde5llmAdZi6cvwE38Zg2Yt79YEOvwfhE8WDGUAsZZk2q+IcqbF9moA559rCoasy1CbmSCOIZzyfltibxdxS0WDhq9Hj4kDlvO4Qh2fOKUsKoFHSDUO+kp6RpXsrqaXC1eSTOa3Er/5X5NAbujd0q2h3lP4W7zowezLiynY/4KbvJwsZ0ezJKSrh7V//NF3zUGTPBRt4TZeXXQt+HlB7UGj/dUyAKd0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkJhlSXDdvP3YTCwethcw2bB8++dfDbBZbTR8wT67VY=;
 b=kZzM3l3WKPGdcK0tkPo4Ry9EmcF6z7droTaUFhDScLthfWS+RjCuown3Mgk5SmKfR4dFKONuwAYuCAsWbSb3GxpRCNuo4HN5DhWPiQkGIDyreyXzeFsduK5UxQCNRvr9nzs1IrkWPUdDlysgzT8b2lXlI++zWw+ILRtb2X5xkm/+kya96af1iJsgcYl2BvufpPaghImNJ7APpn8sFTA6PjYWFlKKaTcS32BJB3JnyD9z+ADiud4LpqPohdLeHa2oHSo8LX6TpN9DyCZB9EIvSMIjbrnXRJ1/VSVgJH17xquqUySSYpnmeM7ydTdl3RKUIsbbK0oIACjAnyoaAnicIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkJhlSXDdvP3YTCwethcw2bB8++dfDbBZbTR8wT67VY=;
 b=mjEAfdz/GWsNoikRBWMEizAHQLwREo0V44CLztxy9voG53J2nSEHBTugXfJzGCjH6t8Wf4xqobrKAOch+O3gtFytwTN1eS54STjtfFGcfGEnjaE6BBBCrUjpXuun47UHIRrAjXdND8PgsBjzFwKGGVUDip4JMU5cwtarRGqtP7xC6cBSaAeUZ27g2xTHrba/+Spo0so2WYQDCN/fFhnWOsyjoVB3+IIwCuIWXhEVPvgX8EhnZPRO7l7t/5KyQY0HQUSwyZgGcForJP7fMpS/9ujmUbLbDWqKjb2R3zXYmIronFZG1fJ6Lk4JtinnRn0Y/6nG3wxXwUES743Ei0VFGA==
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by EAYPR12MB999134.namprd12.prod.outlook.com (2603:10b6:303:2c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:33:37 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a3) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:33:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 03:33:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Aug
 2026 03:33:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Aug 2026 03:33:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aya Levin <ayal@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<linux-kernel@vger.kernel.org>, Oren Sidi <osidi@nvidia.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] devlink: prevent function configuration when port is active
Date: Mon, 10 Aug 2026 13:32:45 +0300
Message-ID: <20260810103245.3162004-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|EAYPR12MB999134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f084e04-bea5-4411-c36b-08def6cad5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|56012099006|10067099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	rtBeLl0DcQLGFGxGfNykf9HJkH4qoWpe9JK4s/lUD70xH6uRiYQ8gN37z3bpyKuN478xUAOGQqK/1RU1W2EuGh2nOTQiD3cG8mkv6mJon+4adMzTjNhLUiVTE/damEmBRS6eGb0zGIl5BSmJW2meCzryiqS9lT9DkUB17TcdByNMUzQyNaEPfcn6+bzvdw2crCE2LTIQs1BRdpilzBeydQA2Cn6gMhuukHq7N+qQnd70qtL4ji8TtUZqApnkW750PYC8OL4BdqMRR6UqvVvPX2pGjthv49FCrKDwqvpiD3lqJOna359e3lbnBTHkcnfNGSTz14tsoZnHZakJ1fJ4xvlcJ3LTAgd8KjaL418mjteqZNmmhsjP0uh1G9AvVYCDDzkp3fKZlQSGeyGORCaCek4Z4Wcq7XjFJoR1XHbR9T5kE71s5reb6hquj3d92eMmlEebP6S7wX4x7LFGAlg2QqTBdMO2ZRSBrvJrbdFnFL9xKhb0wCj6ZgYqWpJdRRB4WmkTTX2pyXS7n8QY9azU/ApIig2tZbxqBrDNBYZhm2+Ef7OmvOhao/+7eq+PUK4UV8rN9t8EByTKQ2/HzJgRAqDFtUwA0vpR4MkPv+1a2PRnIs0RhqMz7ieaJy5deA27M2bgSXd5Bv3U221hIcZVASswQAF9vHi/RTwQin4xIl/gtFMEQ42jBO7e6dqR4qS1ItYQiuqh6ZUY/KGgRYkm5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099006)(10067099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OaPRLs38IQrj2+K32gS/yLT2eszD8bFJDFJw+3OFIbTERyWh2j4gupdk/yvtXIyCb+rfLDlnh9g0u3mlrNCxmkmap65ISHa/rHmqe5HyS/n5Ka8WQ5t/HX1UEGsb2u4wqkqb8Zm8wgrWPAL/Llm3s4jwXtWLNt+2GaJhYN4D4zOQaFxPT4PwUimIaL/OVxShCAwnM7kzsEJZBSPnlHrCZw2jxtQ0oW6vV/0Xin9K5vH78iDD1SyBzNVvKYqWzIv7sGoH19B8AZ8gEszoKeRPRjJBFwpKbz0LQOA4MifnZ0Lg+jC1u+2OUcTsmYTxHoGdXRt9F9RhfeUYC/b/KnjGrDoAlWfAnhKnfMY0Da6fXB1/b9A8aQrXlh3dxCtc4JXrfIiwnNIB1hG0BtrOuuNnv2qxp0jL7wiU0Yrfz9l9Hydpx7sRgCjJHXhQDqoQv6Iq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:33:36.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f084e04-bea5-4411-c36b-08def6cad5b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999134

From: Oren Sidi <osidi@nvidia.com>

Reject port function parameter changes when the port is active.
Enforcing this insures configuration integrity and consistency.

Signed-off-by: Oren Sidi <osidi@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/port.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1528f2d148df..6a9857bf79da 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -708,7 +708,10 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 					  struct netlink_ext_ack *extack)
 {
 	const struct devlink_port_ops *ops = devlink_port->ops;
+	enum devlink_port_fn_opstate opstate;
+	enum devlink_port_fn_state state;
 	struct nlattr *attr;
+	int err;
 
 	if (tb[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] &&
 	    !ops->port_fn_hw_addr_set) {
@@ -721,6 +724,20 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 				    "Function does not support state setting");
 		return -EOPNOTSUPP;
 	}
+	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_SF &&
+	    ops->port_fn_state_get && !tb[DEVLINK_PORT_FN_ATTR_STATE]) {
+		err = ops->port_fn_state_get(devlink_port, &state,
+					     &opstate, extack);
+		if (err)
+			return err;
+
+		if (state == DEVLINK_PORT_FN_STATE_ACTIVE) {
+			NL_SET_ERR_MSG(extack,
+				       "port function parameters can't be configured when port is up");
+			return -EINVAL;
+		}
+	}
+
 	attr = tb[DEVLINK_PORT_FN_ATTR_CAPS];
 	if (attr) {
 		struct nla_bitfield32 caps;

base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe
-- 
2.44.0

