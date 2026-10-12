Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5344519A3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794697; cv=fail; b=KPaTfyAfRhTHr9DTUHKQ82e7Q7rSC7iFgzSbmJwqsgb9ysHaVvVjPaG1M6wsji5U62AWyB2t6l9w2wIVwFcVq4+QVdN2Y/8MJmj1LBROP3Peki005vz4PTexz6IgPjD//FoQXOhYkHh+MbyxDqoWpzVtpCuCMWZakpPRvDvydQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794697; c=relaxed/simple;
	bh=3tyOfKpqdW7LuTtTMt298rQTK4qxak8t/46GcjhXmMw=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qta4gL4pBiGT7DY25oRd9eUOhr64vZ6Hk6wFdGOeZlBLr7+Z5RNc2gK5MV39GEeGHRA8CPEojEFY9mMaZiY2sIIHijuu5lBI73ZA6T8D+ltomPOpjx6dVKuhP2/BRi846ZER4dCwTSgyk8RLnuGBOHaXXQYkOLX57KmxGhZo2oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eNAjxqir; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eNAjxqir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITq5Jg9wNgVoLqTie2DZaWqkGeZ1KC/hGFUOvmioaoo5OCntpz0laWRde7JWTsWxvIKFmkGHMK880evS0XJSZg8awoilr4o/P4for5LxEdIVJ1ATVQS/5v6CBxzid438wfJUTIIPuI7oe3eRL6ndmuZXzf8R+oWWY5vEFzlwgG3HFM4PuxpVrtunEZ8lbO36KpPyyNtwd24CW047bqQ+FT072BoXZFKTv/5VKiIMgTuKK8Qau8yC2xGmqFqiA+mbg0ZIMiYjJH8zQxz5BqNRi7PNzKWFOMOafuzFRMFccFLyXSyS6gcEALsILxaRYOMPkVuhFeD4m8F9CxV1+RhlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tyOfKpqdW7LuTtTMt298rQTK4qxak8t/46GcjhXmMw=;
 b=lnpTaRe6brc1uRuWNW8aG/3J44u692he+xuW8dmgHb+4Ry34JdffhMsnbu/f9JYvqVph5MBBBE+Qp8VDHiFNksvY+qQCgXFGP9RcrTz3oXuYAuKgH+DyM0NI9uMDpE9GGO6PsTcfz+mo9RLTHPRsArdyWDaIMV+sBobeaf0dCzxVJgfpp6+QoIFWV39yd2Q9bKzV9qeeHqsV7cel9B5o0/bfgROvTwtza3H4CydOai4IeJaINshLRJ9IK+3igR+A9Jv9APtIgiZa0wBx7dphIC2jbjOepGTf/gLVS5nnoikzoP733CoKlaomInULNTyo7Id02KT627G6sdJ4q3fMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tyOfKpqdW7LuTtTMt298rQTK4qxak8t/46GcjhXmMw=;
 b=eNAjxqirm/IGqg7wAq3XCFm3XSNI/lfW0larH61n+Fd1suN2sKYKkCxAkTewDqLIQcY5uqRMKvZXTXPfH6gOFStaeCMrK420MQqBEHMf52u8zfu5a2GEyALbVhklrfAec4WsnwzRqkcEBJUo3wkHjNAvHxOXpdehhT99YrKyglDot3ZBNgwzcgZX97+SowfOTc9KL6yy4AzkxzD8KJxcKX/YXU4etHA9TdFD/x0QnHSdbaZH0lQyLw+L1+b8o4N5y/ZGyQusdwk99VTTIXA+nzn/x7MpQj8MLmJtelT0F4btrRrbkjcYVvQ+zPfu61uNKuO8i4BCFyZBpQveJgIj1A==
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 08:44:51 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::38) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 08:44:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 08:44:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 01:44:37 -0700
Received: from tuxedo (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 01:44:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <alok.a.tiwarilinux@gmail.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum: Remove redundant return in
 KVDL free function
In-Reply-To: <20261011115227.21760-1-alok.a.tiwari@oracle.com> (Alok Tiwari's
	message of "Sun, 11 Oct 2026 04:52:22 -0700")
References: <20261011115227.21760-1-alok.a.tiwari@oracle.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Mon, 12 Oct 2026 10:44:28 +0200
Message-ID: <87h5ir8g0j.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: c91f2164-7b1f-4d08-9227-08df283d1456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|10067099003|13003099007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Awiz/hQiVN3JdCitga+gSMiuP+qlXZi1iFA1CAM6R1Hk7O9uVXAtdrlPVU06I3J2FaZM69n4wyGfFSuqGzhdkRoalxFjG+Y1ebsAHjifZi7v/uybTeDHM0uAHGmSJJZYMgSk9cLw2hJ+svYahggAz+PuttiPRGa4lakOj43rMUzecmbJTTwNiG3/CzVm0QB8eifVIRqoAJj2OndW0/cD4ZHf0Yg11nLQjCaPDineTv5pOHfhucAAQszFvW9QwhLZdMmMYYkF2MM4Z3bmitMtmktEWdDHdOTgJVKydGGGYq2+sNNgLALc4x61wKGHXi+FxpkIBMF57kESSricnAUqx4vt/gBTnIMYx4qAR2KtgH2FTfb9N5kRHrlJzgPA4Y0zMvIwS9P7bZ6CRb/P4Cb6IwfvHY4JhUiFNLVfeuxv5a+e4KNWJY6zBTWvkD5OrdB4FFksE3YLV4faHHRgm15WCs3tA4d+gPpN45o9z9BeN04T9IDTbaQ/sO5/kWsSF2QQHEfKh52qYaWzCEV737GDvQl27+hli+qPDjHLinB88j95rxCDLnso+sNWMcbPdYZlIoTVfXrxWfNkHSvmlRLeSUFOIQY8dJydzE1aN4XY8i2I2sRlWYsTsiYS79t3pe/wNFhu0rW6VE6QQsHxwVwv7nMBZiDYuFPqUPHyqd8+qCL2eh5rB3L7WS1QxB0XO7RWwVSunJOKSgMcTRquoTyj1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(13003099007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/5qHM6rhkW2tCH5Xbz/i5NEmB2bHGo3izRfKfQzOMp8iGSHJ9OQP6XSLRDJKoIXg8ZgCj7cVF4BLQLe5RynZ/kBhviBnEWvWzU0+2umxSNpyk2qaQbZCCRGvx6pY2748howd1GWxf7jNOtcwxd1WO3oq2ATDHJ3+GxhxIF8NQxQsXJPSKGNRliB/s8+6TjNFv+VkZf2afVBIK8jyHUdbEjPt0GukaWmiBsmoQUH+XdegcbTPQq2d1Jxr4J/TD0Iw08Ya1NmK8jwMu/T4CP+YfbISzB8EKXyywtda1uTBBQ3HwCV+yj90DOEo/+gM/fDkirm1edoJ6BoHkI6+3PKT2iF5dy/AtHKgjnLtTEZAwJSnbuGDjcRXlMxiftoryeXrtYyHwF4K2ppsLz9dy3NbWZ1ES2WXvvWSUFUpfWe8jM1zoWpF/ZWLS46BvG6taUeK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 08:44:50.7222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91f2164-7b1f-4d08-9227-08df283d1456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

Alok Tiwari <alok.a.tiwari@oracle.com> writes:

> Call mlxsw_sp2_kvdl_part_free() directly instead of returning its void
> expression from mlxsw_sp2_kvdl_free().
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks for the patch, however:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

This is pure coding style patch. The original code is not canonical, but
is correct and understandable to anyone who understands C. Sorry, but
let's not have this.

pw-bot: rejected
