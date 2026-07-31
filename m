Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3512BE05A;
	Fri, 31 Jul 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517864; cv=fail; b=JrE1mwNwmMHr9HmDg4gnFRMokU1lMK9LvFcv5PXV/N5FIuPLSwmQrE0DTfQpJwNrFIwTm8FcKN+SGXPaMUVYR434SGwrhk7PhYfON+Kmz8Y23sxtsAv+hOkfWJ2JfO57Ka2IBX6xoMvFnuwhQoIDmkJbUxpt//MWf+MYctOT2dw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517864; c=relaxed/simple;
	bh=E+HoAFyDwTMgpewmTTZJQ9hlk92RkRaYWn7LxvJVX1I=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dywATkkQKXsQ32k1NEWLvdTo7LCaAqFj1l13u4lP6tfL+R9rd0EJ1Wi4sEqBorWjKeavEgI9LnOGiBZt2uafkXGCi4w5L+EZGRadp5xhD5JE3GjcEngJZ6Yq//GYDG0aS2AroUlkjmVuI8d/rrbbh7bXVJLDHEMI4a8xPCfKeXo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kLoOipH0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kLoOipH0; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kLoOipH0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kLoOipH0"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=y8akWaIvDEOdqE+GnyX9blq/Eq7sAI08qxtCkCU6a/0R5f0qe1M5ouw3r527LwVkiDGpHo1WG/wHpcRB+HiD3f3WY34eYNZ5M/TLTGPZcNnP1hlp80hxOYwQ5iul7TRaJ5BtHUal3DX6mXLGTBIGYXaNwu694jt4pgWWJJL5Q1ZIrFlyblpqt5qQnVP6w1ZhljxyXC8zBLD64+HfsXJIx9dGCEwdu7VNjok1L8qAo/qsG7yW98TUY5LWp2G8U5im+1iSaaZBlPzJZPvLT0/EE4A8sQVBOg0Ow9mjP6hSHIt9RRTI604TiRogdJtCQhUrKijOdhSZ0v/ruCjixQSa4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twqmqFfg7xQjIhvS1lslIDpp9TU99Ff1L5SaF6cx8p8=;
 b=PNSnp8p6httThDArl6fWu/9kPd2qfnif46db3r5fbgor28NfpLE5b+OH9Ab3Wft9CbB6msDjJj355P9hq6UsVr2Ulw8SIzcpTjNqdJa3OSZCUO2XOAX8W3HFGDjzmi/vkQjr5+UnEVzhKLqzuHGsnaQKk0gRWrF4/hG8st0YqB6U0Bxu+gvQWOnA6ZoxnA9xQIAx29L21IhDWS2XEd7joz3A5LiJ+7lM24VYB7Vx/3CM721fZZmeMH4U4W0wQDq7n0QqOT+KBjvxH5aqBGCF6O1ak0ACERenSXzkN8d5PR5ezfXSP1h8XLnGOAqD7PsJKuX9+9f2CMNrPXlZUeytRA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=hpe.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twqmqFfg7xQjIhvS1lslIDpp9TU99Ff1L5SaF6cx8p8=;
 b=kLoOipH0BlhRgZ7Uop2HiQoystvKh8mUbxAclzxnW28GTXknOqRZFG4Y9saPO8KsmUf4cVP+laktm7A4lvZ6rMFpZqONTBdu+WRHm3KIAo2xBtacr/n1uKDbGA51tl+NTeT/FSb2yAFZWnOY7OPgyamojMq93grxoeIjZBMTEAo=
Received: from AM8P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::7)
 by GV1PR08MB8475.eurprd08.prod.outlook.com (2603:10a6:150:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 17:10:54 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::8d) by AM8P191CA0002.outlook.office365.com
 (2603:10a6:20b:21a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 17:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Fri, 31 Jul 2026 17:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AobdSuaHglBhwrNz00itU8SbtE0jlINIYPmEuxCKVYCBrCv5UNRjPIs0WQ7zIJMqGd5a7NZr4+DnnTjWhSvz6GgxYapCG8k0XztKcLH2k/L3qe3ghU7BzVCvezQoX4nEw/sBI8icZW1DsFV6Y3TYn9x4EXfKKnO91eScy8sqxAwEFO6E28hE4AaUncjWSxo0BxCfaHGRftVvrPd9QNcL1rvXog0LmqVSDTeHjbKSOH+yUElaWXa/cSrohNVqetlnq7Ot3MHLgWdwEzbXSldlSzN6JXV5m9+rD/eh7/4LZ1+Eq2JtgwqLOX5iT9UXEWsor2fohkjrNGDJ8cdSqYwvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twqmqFfg7xQjIhvS1lslIDpp9TU99Ff1L5SaF6cx8p8=;
 b=SiiBcnISl32n+gsdMaqDlapYDBiAceSlp/AhqnBEIaA8IG5ztZxi32eXXojZZdTamPeayw9kGGp8kaOJXdPc9jEMmfroDwRZ48SRQEPcAjruiDCCvDyS3lwtDE77t4VyHhCsEFLWFCJ9eovOwEUiL2wxXyc8vp4TMm/oxKzVIPM9uZMoG0jOCsY/O23z7OFC0XNjUA7JQUeK9/Im35y7prHpxfE4+fGP+7LicxR34ziv6BnEw46+CnSI2hYyI9H3VVaKLCku5yqvE9uRkOXHsIrO4QCmezYxnAXieEPFPLgyc9WDX8KH0VHpkLLVPeLTyVxmNBmppUFLrpNct3K3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twqmqFfg7xQjIhvS1lslIDpp9TU99Ff1L5SaF6cx8p8=;
 b=kLoOipH0BlhRgZ7Uop2HiQoystvKh8mUbxAclzxnW28GTXknOqRZFG4Y9saPO8KsmUf4cVP+laktm7A4lvZ6rMFpZqONTBdu+WRHm3KIAo2xBtacr/n1uKDbGA51tl+NTeT/FSb2yAFZWnOY7OPgyamojMq93grxoeIjZBMTEAo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DB3PR08MB9010.eurprd08.prod.outlook.com (2603:10a6:10:42b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 17:09:50 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 17:09:50 +0000
Message-ID: <c08b7cb7-9b53-4a47-abc6-ae6c7d67d91d@arm.com>
Date: Fri, 31 Jul 2026 18:09:48 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Steve Wahl <steve.wahl@hpe.com>,
 "Anderson, Russ" <russ.anderson@hpe.com>, Robin Holt <robinmholt@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: sgi-gru: Remove SGI GRU driver
To: Dimitri Sivanich <sivanich@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <amywpyZgGWyhzBjZ@hpe.com> <amyzGw1-MVLpNH-d@hpe.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <amyzGw1-MVLpNH-d@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::15) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DB3PR08MB9010:EE_|AM3PEPF0000A794:EE_|GV1PR08MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f5798c-42f4-4f21-1764-08deef26add6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 Ys0+AEQV/LB3TOS0mRgaWDpTpYTo+Hi9MJuQ4pKXwn2cgsNRUkLYigoGwfDypkyd00YXbquwyzkj5NmhTuozPMm/Cha31fv78Ur4dpTLV4Fl9VhT7qVl1QKe2puu7xHK/N1fBIwxDBPPDp/Kf6Agox1XqlCdm4qBxnsiEX8shiEiMBuq8FNent1TgijhBir+Hu24FUPn/X1D/TZ6Ka5eqXbFAEk/BsLfGvdNZg1sOh3a1W2b429BfIYQ7geDUds5GE7fRbcb+AgRBsIYL0orPP31HD8XmK0nLCeTab+Lg9tc8FjHSMlIsleqgBDXWCnoPaTXgMUIart+FB2jOfeLjHhCLCXXBzrQps6Gzxhq3j+WNyNy5B6t3aoMjClqiUESYPx8qJOSvmL8fJ07U7rmmlUeMOzbyCPthRjtPLO3bLUEmbiya1gW5WEFGJ7LZZG7pGzYxGYbljF8od0mo7rKokafHvZmVJmMuX452oAiCfMVCnSMqJqVHwM/O0x5jOyIGLmKFOfaW+BN8AEgkVwhmtUwrbXa/6pSupljWfHnN6apySxtJTQAvvJmI8QO0CjZ6jhEJV3xm74uiA0VfotE6RRkZ/HWE3ezHe8bhV9ydOZr5eZzblt3+fBEq3FwSNJOsB/TOORNeaLpviFylAkPCsKinbuk1B/B31zBXKqSSf0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 CJy9X60EQncUHhf5YygF1Mso3/ctWHweiQYIFYwrW2TPwAiVAm26ZC9qY0MVSMsjIhFYYDgwrvujALo1kSz96x3IPJA8Iq2fARDRj6XOk5fkV4ifiX5Rhl2PGSxpFItHUDkKs/MBzCwK3qoZ2dsON/whUrCCJArCjVoga2f18ASh3IOXBPWQ61IHw6g1bs9FooL/bJ/NX3dfUL/54NjJB9jQS3wp/CpLIpZKycGEwLi4qoDHHkVL+4Q2QO+c1moK9Q+JdrWSpJovVUXHtq0sYB3gBmPq7hIIzAHZhM376dKux+KO7Gw1EtxYS1su+zDOCLkYKzRom8bd3/YYAn3dHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9010
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d3313251-ec9f-4def-2f56-08deef2687d3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|14060799003|23010399003|82310400026|1800799024|376014|7416014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	z9Jdt1YBL9Qbyr5qKv1Lv3NGzgTDxuZQVRVgOgVcubMIZPIuzqLZDkw0iPE/pQ9MmiiPORC8/Hvkyg+w/JBHQ9fN2oCyw0eicFYzThX2N/naFRtXIW19YEZQh0TZ8cYLESPNmzZVkRs9VO8X+t9WkdqCjZ/PY9TnLSxPJzBsJx7QhsRAAPuRl8GzzRw4Yip91+Vvd3hnCyFTbv26ixgXapvSWNu3tsAcAOJIJJB2QhmAFQk0WJR2HxLCUQyLMiSuyFfyJOGeObUPU+OoWajeNGAiPBr/JTPB2/zPN460vu5sbR50v7MWaVF3OOfE7OJ7cZaEHAehGGqci5F5g/gCI2lc63pi/6rvQ+3NZQL68lUsCKhvmMXk3yiBW74Y3Qbu7DLmTmFvuYLooNExe+O0IufcFG4PFDVZ5LJatgfdZWtz17jlIte4pbJY7LQduBU4KA6cTx7KHxo30EM+ebSrkuNYCCraOXM/IJzl+AEC2+YUxQDhR/WSQoNEFnbLlf4DYo3qd2TcnVOqK7lz5Q57Ll3L0lGs9KmOfbZdggo16DN/v8nbOtJNpZUIPG+9gdcEIjNp6V0XMR0sYKEa8KoLX2ysxCOqnccplEIWFM6qE5cby8Aw618rQhlNmRLRVhAzdoFnAN1CdRdO0WEd0f+7qhhFhxiGKOzGvUM6nDSlMqDHelmh30fzerDLRo3pcMtMug7pqOr7P/bn7Qnv7PaDvQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(14060799003)(23010399003)(82310400026)(1800799024)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IlSD2FNJd09DK3j8VwkVkr6oXkwejKvc00JA2Pm4tNWacUk5AYdWCrT2djCvCPcVqMO0rOj/dyo/7enSzLLMh9wJGNy8Kz7rTzkw4UQZfYcPXX+NSQCGDMbXTXtFUmnLWruFxO+1gCLXz26db9NPyklSoYMlx5B5Sb0zJyn08FotbC5VPqWGnmlB/qIdCftjzdq/N79MvSJYIjha+lFS6a+r3ycirUzw5+tPmyryMjupdbhR7feHyfEaGzJucEUC8b890FVK8Vq/3UZJ8hQcN91gVp1Vzyf1rCGxrF2GmtWtauDjC7S8QyTcvXw14tud+eT8oLwR/s2rlg1QX78jke07GXbU6b6tIyl/8G8c9lVY4CksafgYvnIgYt371Eszfu592NETdT2fS85ri2CuU/vVzKAojcDPF7SnGqOPolKA0lYiYWZddBr237zvDo7Q
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 17:10:53.6606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f5798c-42f4-4f21-1764-08deef26add6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8475

On 31/07/2026 3:37 pm, Dimitri Sivanich wrote:
> Due to security concerns, remove the SGI GRU driver, which cannot be used
> on anything newer than the long time unsupported UV2 platform.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
Acked-by: Muhammad Usama Anjum <usama.anjum@arm.com>

-- 
Thanks,
Usama

