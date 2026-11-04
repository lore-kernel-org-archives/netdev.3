Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793779960;
	b=5n8n8m236PkImy1dmn8bUqz1dg3ku8c9C7CzFZQCfBdwojqUVF1AIxs40XckuB+d2acS
	 jYO5U4dfAfVUBZqEvcawFonitZhhozp6vbclxEKsB7sVPyar2xsDkMLnR1STu36bW8NeA
	 MLvomzvQjWbW3yudwqOP7ciw3h5DZ8pFe/b7kmlspiTSdjIdX3NmeuIHMMexVLHk8D38V
	 XkOlcCfPQKhUW4ohbhHxKsRtwuDoiPXWDfue72D5GUBAiWpzMruKpNWFh19sMura2BrYX
	 cdpbXeUCe3R9W2tVyR+E+Iv6DEasB8ZH/7huirIUsKEKxR/uc3zYckqzfL0mXBscHwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779960;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UA9MEKJQpB25YOgONU1k70l/uZVjP0nwPOy+Mrei5ZQ=;
	b=CKHITVEi/Hw+1M3oBRaAvYqSBK0cQ9rer/A+MY+bzLxQSfLp6t6XhqcyA8qWpRNUbpKv
	 IHiPDqkzDRGlmBWZ7nu9aN8r+Skl+mVbNeSCVsvDsdDDaEKQ6zSS26v5i/Vh4on0jXRmY
	 AhxoY1zRrvOjWPVMjakeH5nuxHEAlF+CvEJ/RkpKBLPECROGhVyIU+88MiXKNOgV4NQ2K
	 d+7+pC5imPXLrfupmNz0bwABprFfn5XQl3EzRsRUxpu3ZIgkuH7LHtEoPMcyhQJTCl/qT
	 vW64YhuLc73vrBlRPlwtftQc27y+YQkzGqNWMjogANXONdD0k6UCdBlBYhsMG/OQPhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=UmyIge7T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.8
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F60606A31B;
	Wed,  4 Nov 2026 08:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=UmyIge7T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CePtZPVZRbO+VVDncJY+CQ8q3diZkx8Erc2VbbhR5oP7A/XJMCbnMEr3IN60AtG8c4uCmKlcBIUflqoUUrgq5oqsuPqtVHZtQMUPeUjpIdOIy7CVC8WZ2tQp0xiu0XVLtdUxyf7mYb+3mi1H2epeAouMOy9FwUC5y/epKAZkJgzSk7dntOyKWceba0QWvy1MgxRjnszZcGYTvrvg7Wzp/X0QJGfZ7es2MlCvoQ25Oit0Yg3/XFJzI8CzdRV0vX3uUiS8uxxwNuah+BrPYJ+FaFo0UkvYe7pILNCRivcA1aqv+ny599RLb6k8sWf/hLGaX2UkThkSUXhcSA7iikpVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA9MEKJQpB25YOgONU1k70l/uZVjP0nwPOy+Mrei5ZQ=;
 b=IrX8oyjJf+4ms/OX7o9YI1igSiXf3cSwehsayAdl5shNgAxgOgPRsc6OQIdukp/gTWz9lp6C4u64xbrnuvQX8opZlBlsuqKqX7SRh3L6u2CT/gqNROb0QrF+bzJ8O+fCURzNKoFzZz3lJikddCV+joVnBq718L3UgqlKN1MXOX5192hduo0rgMrc+5C/0XlNuBnEddn8XHW1GbuJQIwLqvrRkD41TAn6xhl90uzWq5Re5duQc8yhjwsQehjkX+vET0U44b9KTWrKH/DMw3daZ35Tg8Nuyx8NuiZLwfmFYAXIp3SdoghFkn97Zjz1OePSaYaGwzc1BS3PAtKu2NknLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA9MEKJQpB25YOgONU1k70l/uZVjP0nwPOy+Mrei5ZQ=;
 b=UmyIge7TO0JDZtZlmuQkGFGaG9A2UK6jmUfCHROspGn/KZJk1AHiVYxf3tPBSFIxlPqkzc+UZaj3lxDc0NT2fqLosu16VHgsyZjNq0OYixPiSMRRb5P3hEx2YbfSNPCl19tgtry4961z7k25g3M0fPuIovK50T/5Q/uYoORZVUokKdNtilAx2G2X2yTljh3cf2oyQT1MJ6XmCBhKy0ZBKSaZ1Cx8kGae/R3c6vxTirRNPW1zEGirkJz8uud3kEqFA7nMiIHbont8Y70GCsBkDDPNfGOBlDCrbyOiYztg61s6+MuBv9P3IpzGxWNjcwJTUnLJLNP3d3yrNXXUzIonxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV1PR03MB989626.namprd03.prod.outlook.com (2603:10b6:408:3f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:12:36 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0569.010; Wed, 4 Nov 2026
 08:12:36 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: stmmac: fpe: pmac and fprq fixes
Date: Wed,  4 Nov 2026 00:12:32 -0800
Message-ID: <20261104081234.10153-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|LV1PR03MB989626:EE_
X-MS-Office365-Filtering-Correlation-Id: 213e48d0-06f0-4584-9f75-08df3a4b62b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|10067099003|18002099003|55112099003|56012099006|11063799006|261021123027099003|261022075727099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	yH2thoIkuVIrZSlE9HXNvBoUpVtk0YewDVY78T9f7Np4tRITPovluVzExcd15rXK5bHP+PJcHdxxqFfJ6M5LVIUq881dkUpTbzTEDByKoLu1CzQUJLMHptU2d4NESCKwRrqKNPJdtDyqVkKyuwSr9k9N1k6ghwMI9pndMSV3TbAfm7XJaMyTC407/YSkuXEUDipJiFVU3agSO2hJoZs9rhrRyPyrNAz8Gau7Xq2BWx4YxWeonI8ay2AuWZC+OqiIxSoUz4NWH+S+vKqE9r51Rb6LjJJyV/fvtUsy/qvVcmSGg/vO67Dg5t6z6N6l17nCB6ZN0peYcS+5gljTCAi0xN7ZG+5hMghOOupvfYnCbGLcvlX2RYUT0zxDCfZbjdzA+b9dSp8+wSy+VbceI7W2q+wh8x9yQBmwN9DtBj5aN8Jww5UdRifqQ/QrfjLhuMZeR9vRe0AXANvHq5w5QYl0inP5mRfifgV/JUGwxBJfegdrIrswYjMtDUPM648DXNvkWc323eTXZrUxUZVN9WqcV0TsaOntaaf85TCBOJtsXL48FI0RQ1phiwwu1NbJ05J72EQ3VRVgQjUvcOYR+WqIfDSwfx9ssTJ8y+EWrsL5yy4BRWSa8AUtfAlKLsT/ZZdv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(10067099003)(18002099003)(55112099003)(56012099006)(11063799006)(261021123027099003)(261022075727099003)(261102123227099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uc7ca17DV05uIR6jouR5sYVkH6rDO+VL0FX0y2+QsZTMzuFhgui+dX0z20AC?=
 =?us-ascii?Q?t5hHdumiCNoI+i5fDCz/KH7ZdnSn4EK+1Vx36PGV+ffIo77zOj9j+Qe5TJ0w?=
 =?us-ascii?Q?Jzt6TC93OI0a0eSLdUuqy4OsEcqLOV25Y/C8wsKkzKjNvu900poTKY38k1/x?=
 =?us-ascii?Q?v3k6h3c4P37d5x+nPe1SFsks07S4FAfFhx0V8kkg81b7nBGa0AcCBlsMBJdK?=
 =?us-ascii?Q?CPHqeVM0H8VBAiF+MoLRIkv7dshc6UkxON5yFlDKVVxIwvuQBT8eNZjAVWvx?=
 =?us-ascii?Q?uEEoQjuTPTNo2WlRO+1xxSu0G/KC2f57DrRHSimlKXlk4pwhmrL8KgtyHQba?=
 =?us-ascii?Q?sHLMNASOadsF5KUEmrX322YKNXF3DqO3vJq2sJh9Rt09KVTseRexBclg9J0J?=
 =?us-ascii?Q?S+zRS02RIkBb5Ly37wufoLH1qYtqiPvMf1eO69RhT5s/ZiI5g/55KD/unr6e?=
 =?us-ascii?Q?3Wbdsf9lFRDJF0AUJzXLkzbrN3K+io7oXIeXTU4TMvYvI5NlaJMuwYysZxB6?=
 =?us-ascii?Q?siZlDvyv52FOuAkmi+1wgk79RTiyUVGuAuWkDto73TCNTCghd2/DgGQ9FroW?=
 =?us-ascii?Q?8cCXCcHLZo6mAvxqWi/Col/9jK0k06sqv9ebpxAE2wHW+h6mBKB8M/hYwLUA?=
 =?us-ascii?Q?3pVF6yu2RhTmAKjshl3Xkl+Jx9ll2yUKaZmu30mHYYugZpod0y8OZFbiNKj9?=
 =?us-ascii?Q?X/trW9geo3jZ/ZB6t2FgGe60Ksd7DuaxH7c5ryk5WJIzFCufApp7iUFkZT7F?=
 =?us-ascii?Q?wOQ94H6DtU/MP4sXjY7fUThzgRcyuOSxmOIibuE7/2Yj6Jl1a0zsD4LOu0e/?=
 =?us-ascii?Q?vvly2hvqaZ5V7KT4JJLSeNWCj/xVCpEjMjPh9NHTUvXuz7sSTHPTATN8FsnG?=
 =?us-ascii?Q?p2LmMAV7DI+EfIe/DxU0YxUmeBtu6A5M9hQY1x0WJhwbeMyyDzSPN3gudLV4?=
 =?us-ascii?Q?VxlQgaHoyxCAwn8Mlwuo82oN/j8UQQFFkXhOBLerg1zzVx53Ag6jSYKft+rb?=
 =?us-ascii?Q?+kOZC9gNYLvXTC6qe0LQSlZVgC2TZz89SvN/xXfheGhO+wivVrztXwbeApxv?=
 =?us-ascii?Q?Gp7LcL4Vr+aqbnXcg6Lm9jDWv8ZB8Ct7Oq0m6A/2b1ztdW0CcEBHFD8HWp0C?=
 =?us-ascii?Q?EUbg5CZsrzabrK06zvyPrlnqjohfAlUjlYWjZS6TWTCtQafGjR1oMxGE493i?=
 =?us-ascii?Q?mPTGw6xEecOJRWzU5icbDsQlZ7kqARyDXGi7uI9lCtHKLYWyG7izTCvQD2R3?=
 =?us-ascii?Q?Et57CP9r3/GS8937lu2Vtu9duwV8GoTGTvJNMc50UxM7WWMQPJEH+hk6lpnM?=
 =?us-ascii?Q?qtCtR/b7LPlZMk/VS9fVhk4P+sQH727mBynBYIcFl3J2zidcUONQ/FZA0JM8?=
 =?us-ascii?Q?qs50n95qbiYJc8HgnnHqZzp+ZGDzu78QhJMeS4F/LLYjuErRAYWeiPQcRplA?=
 =?us-ascii?Q?eQFHtlsWPk5hkAMPjH5mU5n8RGa7kkTSiAtxmJCmLCh7WyKRq10Efa8a4L8D?=
 =?us-ascii?Q?DYLhpHDYrDzLE9Z2yhfS3T2lvYB81etw0Tfd8D/zj9ajMr1lBo28qySyD+lg?=
 =?us-ascii?Q?jDA9Pz+y07TO27wHTi9cyGeF0JUExtnwn20ICZNujfeR+iErw39Cuc/EWVSu?=
 =?us-ascii?Q?pmMkVC2rncjXvBJvJueXtthtCJEKnTJEL3P0LyQwsruAMq/zdZvLMLCd0BjH?=
 =?us-ascii?Q?laIlx0qW1WJ1vp7hFZCEQZruIYdQJZF/LN2PoAlGa49KknNSX9MPQ/1szab3?=
 =?us-ascii?Q?DMW/xGrMYy+WFQVDl8vduBlymJ2fHO80i5XW7cmKYj1GRw5novnkX5aOrSJ0?=
X-MS-Exchange-AntiSpam-MessageData-1: q+wSpnGiABi8Ig==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213e48d0-06f0-4584-9f75-08df3a4b62b2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:12:36.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EKcageIKGuKeOI4k6g/8rjwBGNP47RugOqx1FtvvKRutsVxZCGn6luUdHse4Vq2Ix6Yget4vNkeNqzt4+1U3n4cz4SgCOpuc3FUxOQz53rUUBsXDOWbb34gNHl72bSict/vWFVNk9ANett0QEzyXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR03MB989626

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Two fixes for the stmmac FPE implementation:

- Keep pmac_enabled true in DWMAC since the preemptive MAC is always
  on, enforce this in set_mm(), and only initialize it when FPE is
  actually supported
- Move fprq configuration to stmmac_fpe_configure_pmac() where it
  belongs

v3:
  - Rework stmmac_fpe_init(): gate the pmac_enabled initialization on
    stmmac_fpe_supported() and return early otherwise, so hardware
    without FPE (dma_cap.fpesel clear) no longer gets pmac_enabled set.
    This folds in the v2 "Add missing return in stmmac_fpe_init()" patch
    and fixes the condition that did not reach its intended effect, per
    Paolo Abeni / Sashiko. The separate patch 2/3 from v2 is dropped.
  - v2: https://lore.kernel.org/all/20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com/

v2:
  - Drop u32_replace_bits() in the fprq patch; fprq_mask is not a
    compile-time constant and triggered a __bad_mask build error on x86.
    Keep the open-coded mask/shift update instead.

Nazim Amirul (2):
  net: stmmac: fpe: Enforce pmac_enabled in set_mm and keep it on at
    init
  net: stmmac: fpe: Move fprq configuration to
    stmmac_fpe_configure_pmac()

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 37 ++++++++++++-------
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.43.7

