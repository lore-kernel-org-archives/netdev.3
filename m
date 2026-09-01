Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28143846E;
	Tue,  1 Sep 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248023; cv=fail; b=Yi2YcGuq5zeCopNIvBPt04tMatMZC7EhpFXmJhFiXoLBhJdGtNJ0RHhedAMlPA6+6M80zP3xJM4jh7/URlHtdCtsnRiZ9r9Mc3QwczqXIWfdh31klmiaRMglj12XlNhJbcptYG9CQjya+9QELjB26OWf3lkb8YoqnoirqKgkDrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248023; c=relaxed/simple;
	bh=ewuZGCzM8B3C0daPN9oyAEDZBkgtTR8Uv6CIX+0mbfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l+fWttZ+EutU5eIyujlv9ZEi8YH6m916S9I0aoM2DXF4BIx1FbZS8ZUXCc/0pzcuxsvTR53u49frnOVf9YDnkMqLlp3YO0kL9b5OO8woyLYPqTVyhbF3URSKsuKNzMihsixLFMgImLVQVYLCRC5TR/dE0d5v+8WjRd02EzGGLIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Jy/x9OO2; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Jy/x9OO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh4P82hZ9ufqgQa7OHtSFMnbcDQ2EK+8RFEir8SkYyfBE25N0g1Mx7DLsqYmLE6cKUUQLES8ckHIQLoclSRjrrHfUOGAUOihLxcRA1/ypfRZ0a/FDBKrfUP1dv2Vzl8/dz3t7SIuBXy9b6OJm0AophaSMYZZml4Io/kZcc/QZ4sHmSfls6E9vZzhb0fjoBeXCE7XjgX8M3SirVbScrwOFkT8RI7ZGRTvv+mgx6H+4An1JrRBgjszfNyc8PnIyTJYq7aSCmyoyCALin3gasJDsN5oDPrNhvnXDJgUCFRoDsIbzqRa62HYedB7gTkIdvvHT6bsvJIgGWj5b3s061gKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPgVgyUxOXuHj9KnGx3BV8CxHTqn5InN3T6v8yMqnhA=;
 b=y7LI6ukY8vu2NOV4v47+RTMbjjJfHM9RTIF8Ad99d9xr6D/2LGJG/sFPBpzKItbZZcjG6Or2oCtBQk/m0l2TYd+YjrabtQrRQc1nZtc03DGZmrKEsvMfQ189W4EmBPT4ApqLiopyXxwjLYnu8J8gS4NJOiJi/wA0aCwkBsfVr54Pjrg3bksAaxDaglayGnMOOS+T4G0I6aMQ1g1hGKaUrREXdX0Cxn7YRAiA9ufOgFPLFIdbtoS7TvAycAmly9Lr8AW5cUuQOpQgRF+tsF3rFj74Uv49KaoNSXmRC4pNJ/Qge/W8A0KYOxAa7B4PyoKm708FWbDibodl3AEYcPtKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPgVgyUxOXuHj9KnGx3BV8CxHTqn5InN3T6v8yMqnhA=;
 b=Jy/x9OO2LVRmEkVQk4NJXvKQYJ5ugp0o9+oDIdxbXcUsq2wmNDg/zDGEyetPTpkzk/cutGJIB92pA0bInAJn6Gkw5Cn2OO+KBZLNhRcOby6NbDoVIesMoU2G8/GRVImEpk05vyfUogm6mTqqRtjWjKmX7GxuinMpxFpONRbR9SVlqSm8tUX92TjrMylltlViKx87KU1TCtsEmNyrzrULIm1PGv+Dan37808E/0VbIcZV5wHs+8mZ9IUMb33eRNWAvUfDD4Ggk4sT0mS7O4o7Y/67UDrk7gYOT0XJrC5t9W5fbcOTaNQqlZzjcVPNrQI59K2LJt4snvlTm4fkOFGQxA==
Received: from AS4P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::11)
 by DB4PR10MB6920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:33:36 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::31) by AS4P191CA0012.outlook.office365.com
 (2603:10a6:20b:5d5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 07:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 07:33:36 +0000
Received: from ENXDAG1NODE4.st.com (10.75.129.197) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 09:30:54 +0200
Received: from [10.48.87.85] (10.48.87.85) by ENXDAG1NODE4.st.com
 (10.75.129.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 09:33:34 +0200
Message-ID: <3326ff38-75c3-4218-b537-17077f3faa4e@foss.st.com>
Date: Tue, 1 Sep 2026 09:33:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2 1/5] dt-bindings: net: add phy-supply property
 for stm32
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linusw@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260812091122.566439-1-christophe.roullier@foss.st.com>
 <20260812091122.566439-2-christophe.roullier@foss.st.com>
 <20260812195828.GA724768-robh@kernel.org>
Content-Language: fr
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <20260812195828.GA724768-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE4.st.com
 (10.75.129.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|DB4PR10MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: bb82eb40-2125-446c-c93a-08df07fb5576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ia9RuAsjnKd+F7/pwoGdZmzqJIYzluSdPV68mho0wlAE/OLnV2UJQtWHHCXr5G1dIH/NgXgVebW6FdgdSNiGhvsU43xiPR/u0LgR8WAJDwwI40UxwKP3k6kfgYqNuut7UGtAj/+7i+TwChGW6t9HPpaCXT4aZD64JCkYRcczcp5T5HlyUyNjdtrsJ6XkoxOL56wXLVGle5+smbCWLbZEbjTwXFrpyL+5wHviUQh7XLx+nxlMrnObk9oKPVJVeVsEf3hJLjqSOA6fOK9zQGKoSUmD0C4lfouDdZS01Q8LjBxUBK0m8keRLoFYCwkd2uJwEA9D7IgbfruORfTGN5EwRDXxmy/9eKNwkWMkcFSz1O1x7AuNLwhlyixIBTVGX83wl2TC2cVnsasD4UVzdMipaNBgMVJo3ccQr2TQnFMLq6s3Xo8zMm6HasTvzD5x6iNjY4/cCd54d+LvDjliZoJPnR1MVKmhztSPnnvO9W0OUqNlVFd2syegY5v8G1UvG6OWjmb3mU+FtoWquZaR5HWr8pcvSp7guI61gPCU3V45Hl2ZMd+2Mvt/j/4vk89f7Mk66aVVvpp8fthRNadBSfUFpxjtVwDfhrv/9nLAMyy5WVjD2eJg31N4umZ4JC2t0OpJ8X9uTI24crk9mF1leQjQ8WdZpg2/LU3Z5gZ+3MHOI5X72xEfKT1Crf+UiYNURE0S
X-Forefront-Antispam-Report:
	CIP:164.130.1.88;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mXu6N9bKxnX9QAMh6vGLaLCEOvVcLv9kFFtI04S5GZoFkyTykcbVkVx2kkA+MbxQQIBT6ZCxoy+bOORxO1j9poFTTdRN3Vn/uDNf5OrHuAyq0kChE+w/r/aSS/DcDG/+gx9LZRDgBbHF0eQQCpYjP/+IGodD6AxdcFC25ipTwxp4wOSaCswjhsXiAzE+2p169DW+9aGRo6x8wq0zH7kM0J119U7wbDB7cb66qZJLpGvvq1EQrqWLSAmLmAZvMvkDaNX+uIuxScUIplaH40DkOMIcmaMBPcfiJcu0dtO8Xft49ZfOgNTSWQ7VN40ZSx9Fshz5lRunPRoAVKygNrP7yp7m3HvGcAx4qkneLEPPLbimf09JJNfOudb1YQgRehu4cbMHPNse2o5/IIBkiUd5ohYwEKYBEUcQLTggO6FXP3I+E9kM5L/nHI6cYcAXqVue
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:33:36.1128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb82eb40-2125-446c-c93a-08df07fb5576
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.88];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6920


Le 12/08/2026 à 21:58, Rob Herring a écrit :
> On Wed, Aug 12, 2026 at 11:11:18AM +0200, Christophe Roullier wrote:
>> Phandle to a regulator that provides power to the PHY. This
>> regulator will be managed during the PHY power on/off sequence.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> index 987254900d0da..0c7eb1ccadd47 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> @@ -99,6 +99,9 @@ properties:
>>         encompases the glue register, the offset of the control register and
>>         the mask to set bitfield in control register
>>   
>> +  phy-supply:
>> +    description: PHY regulator
> Which phy? There can be multiple for ethernet. In any case, doesn't
> really matter because either is wrong. The supply(ies) for a device go
> in that device's DT node. This node is not a PHY.
>
> Rob

Hi Rob,

Ok I will update my description with :   "Regulator that powers the 
Ethernet PHY."

To manage this regulator on Ethernet glue, I based my work on the 
examples of :

   - allwinner,sun4i,

   - allwinner,sun7i

   - allwinner,sun8i

   - fsl,fec

   - rockchip-dwmac

   - rockchip,emac

For me it is normal that PHY Ethernet regulator is managed by MAC glue 
because it is mandatory to power ON Ethernet PHY chip BEFORE MDIO scan.

Let me know if that works for you

Regards,

Christophe.



