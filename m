Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C23DDDC3;
	Wed,  5 Aug 2026 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911978; cv=fail; b=t9ZX/Vcn8BtiKb9CArZT85J6sC5Cr2q41q4qceP8TRgCVOLyaVrq6fTJN2zpvaaAiNKHSk0VYVLsLxMZL4txDtkvZLAsvJkHjdWyBEwJfpXjgIWFNpSwE6EHDMLiLnnAkid+q512jRZx9qoJu5/UkUqXiFhAPXNFMaLjRfbtPss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911978; c=relaxed/simple;
	bh=mZoqlQz8lCY7mLrNVfp6I73rEQHwm9+iwSm9/mkFG+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mWTqDmNFbwEH6CKwlc4mZS32/ndy/Z+d5Os/Eg66ugSxEDdU+P5/TA8Pa48ZIQUIAuoY6XHQFbLh2vPVXOZ+Wv99i/jeI2wf9RTCGFUcTiNSW2vNQNKQdABlBSzcMVrE11Jjivl0nCnBtLnf2AG8I27Y5D/BQtg/TRzX54+8hFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NE3oJ8S2; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NE3oJ8S2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLIavur49PJfBw8cGwB2BcCnLFXX1Bx4L8A4C5oSSozsQxH8Mr5nLr3ACDaBN/uZJ1dF0Z/diDdF1dxgKV4+o4LYipDUOeqj6gTj241DvFmNA50IB8+GipPmHdd9V7wR8jcFqkGjEhM00oT7MttzOIZgiOYS0JLWrqetsN0WPplK2U9ec0VnD23lpHyJhC1QufrJhm6hRtLucf72s9h0VS7NsRwXYS6BIUfHjyP02FnYjF+1ckECnYa6dKi2I8x1NtO9YIqMeMuUrBjzAety5fdNGA6QIV1jaH/bQAWpwIdFctl7jIrpHqHe75ILsvDiym10//5r0MLdHLQeWobSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Snw8UQ2uKVRQw9alsnFu4CmKiKnOFJek0i71AkCPVEc=;
 b=pSl+MgQUnIIz8b1SklF1qHlaNLvLppR/xnq0K6qKgBRxDBc4JUeCZ6/Ypo6p88jtDRXz/yDrvsdZf5av6GuhJFptdo1jiA3jBZQYJPSMVBnWuK1ok85H30IZChDyrg4jAahqYSQ61dgnxu+3ngOCkCTGqUIV2k3h7KuanfP0zGgp3K4Cx2/kcJYv03tX7NIO3PtDe2Pfjlg4mJSn063xYjHtDYzZ/fyr2auDkI+voaEyKO1k2hV+x6+VN2LLzh9PvMD71kOn4A3ZFG8I4Q1EyEnD4akJSF27M2PngQyOvLn952Hv4umn5DmzsNEG1qlE1zYO1ezfUcHlGKaysmNdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snw8UQ2uKVRQw9alsnFu4CmKiKnOFJek0i71AkCPVEc=;
 b=NE3oJ8S2Wp1esEBtWsAr5tiPF13C+z23cmAVSF508Ernmdfc2xykqH1rRmRRy9ldjpUjSOY30rH1NBWaXoJoslBz77+6kJzNBGp7SLpn56Yss5CghYkCd9c6yJUcxqktcKsqill+/QPf+YxneO2n0aEL7+YCtYsUZfiKQklJZXsmX6fqqAAw8JIle3w+1rE2bH4qx671u/0jrqcISVfenkJ31Jt9c2QVGY2lPV3S6b+RX2IKWfqfkYkEJND9ZJPwY4GurduLOTcXear8VRkh4r3kXT7kBOI3m9t4QbfGk5yVdjpxsFKPwL+Oz6Hqc3AQqHKR8Qhx31uC2DRNjeWMdg==
Received: from AM0PR02CA0119.eurprd02.prod.outlook.com (2603:10a6:20b:28c::16)
 by VI0PR10MB9744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:39:32 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::55) by AM0PR02CA0119.outlook.office365.com
 (2603:10a6:20b:28c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:39:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 5 Aug
 2026 08:44:23 +0200
Received: from [10.252.17.63] (10.252.17.63) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 5 Aug
 2026 08:39:30 +0200
Message-ID: <080e5ac0-cb7a-4871-a312-1b60459ab5d2@foss.st.com>
Date: Wed, 5 Aug 2026 08:39:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] net: stmmac: manage error case during
 stmmac_dvr_probe
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<antonio.borneo@foss.st.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
 <20260804132052.205273-5-christophe.roullier@foss.st.com>
 <17bdf6d8-a31d-4601-bbc9-4d7b78897272@lunn.ch>
Content-Language: fr
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <17bdf6d8-a31d-4601-bbc9-4d7b78897272@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|VI0PR10MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 26676093-53e8-4345-de95-08def2bc4e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|1800799024|36860700016|13003099007|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wnpyS/MLTvPba3dMJDwYTUsiUDwbs5tv8gDF4nyC6/3+Y51lW63gvxyLWaugO+KLK+F00Z0cy2sPxHhbfh0Nh+bvphF1X7ngB8ibyopu1HbuWvu4sJay1P2en9y/wUgMBUndk5M3k7qIAEEtEd+k8WCFC3CB5PET8BmCzmwNsc8naAy8xGgqE3gd9vfHEjLoT3SRXZRyUlVT7jKjX0ET+V4tqZsPGM5mWY9px6MpbmBqfIs9xGOdzsQjH2ejfeemNdsqYdQBjBf6oerZVtjQHgA21lIMnHWIzuwKGzFWJ7mfdmhynHPH6Mk3HTdMSVky0A2E0GiZA2i6Ng3H5LJnv1JuBWOI0siBYLEYk2LgUhNYSHI1TkX7O6577xpoFc85NPhkDBUgLAnmFM9yd89bl5AzChPIZSR/FRGlcHVtB0skbDkynX38q6ndyvvFWNh73GqZM+nF/1DSku4cMG2s7wlxY3AvJmR/8abm0X+NQzeqHdCSxo9Kz29QgPFw4JxGrsVfdlqhG3zZkm20zlpE3Q7piEjX4X8Tw9uEbmoxHUdIVHTPbCZMdj/Z4uwmIu/l9QTNUW5IKUJSB/bKKaaMjniCtEm00Ora3TQiwXL2BauIZ9CpLemXY54VoJxBFk0U5dAG8Z2zmOavZHzKNw8SrGn5PVLKCwsB2i0CTolXlsw=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(1800799024)(36860700016)(13003099007)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IzsSawp58E5cFjJuE2rs8UrQ9KBeZahF2Cw60Y7dNGJwJb6A5bXnKBlNyhLBdJtGM/3PaVzSIrwygnpL5HkmGuq9JSktCN/StHDgkrw+3X0w0nmitYKzmtzSh+ZOh3R+DMi8Geelo9M/HMNl0XeRdjo0J36oS6/mFYxuiXj0kDlQC+rQuFhxyTJA4LM7HrFN3Wj1iocPRdonIJb/Na5Ox5k6OQVFDned0owWdOjCghVqY3rY3bIcfX5CfTzwrnQZi6BuaSMZQOKb/1dUzsHyzES1izWY0tIQB35dmebsNcFOCt5QVoRZwjG3ucpKiIsyHlg0R3GMsyPhvIdjvay6bo7FSp2qHrVhGdT+pPC2aswJBWUgR4WVWQ5eYNbOjSox1jqU4YaGSnL+TkQEMDaf2xIXa0LRx3saMnn99eUFX0jjOl0Xq5LmaL5HToFuZgg+
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:39:31.7280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26676093-53e8-4345-de95-08def2bc4e82
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9744

No problem Andrew.

https://lkml.iu.edu/2602.2/02822.html

Le 04/08/2026 à 19:45, Andrew Lunn a écrit :
> On Tue, Aug 04, 2026 at 03:20:52PM +0200, Christophe Roullier wrote:
>> In case of error during stmmac_mdio_register, pm_runtime is not
>> cleaning before exit probe.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> I don't want to accuse you of anything, but Russell has not been
> active for a while, this is v1 of a patchset, so seeing a Reviewed-by:
> by Russell jumped out at me. Can you point me at the archived email
> from Russell. Just doing my due diligence, trust but verify etc.
>
>       Andrew
