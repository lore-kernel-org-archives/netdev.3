Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793607271;
	b=lUvhoAX0lvlQy/UWmK4pFwVx/SWlp+4dL3/EbeRSXjv7cVZEWcDssnQk1sa4FWunGGc5
	 eMFdEkMoyVG7Dxte2x+p6HiOOyr0jQLvUv3R/yTVk4hRZoOT7tzHA8cqADt3NZibpikrw
	 ZHb6elU+xueytE1I35kXVLDxPoaFAhleRxML2PjKYzU3CXVNmlEVC5ycHPj9ggTVKaC0Y
	 UNXVO5YXOukRIvAw6U73XDFe5WodPw0vaEsYWbv/4rccKPXaoh7ARCuxcvD8C+mmVar93
	 VemzrE+bKVc53V1pHX7dBjD2lZWF9HP5MHy4hle8VkCv3FkBBaSFe19XfpEYOsZhCVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607271;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:CC:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jovyLjkFUlnE6WdunS/8qOSRwgN3EC5HwdUUEms1QH8=;
	b=XepZt2nkxVvNlYgTBa/qSKY37dcRz9v3qVYUTaRtgc5uAaqH/k3vr2tiRt0LQiQhvlQl
	 i9tqRqYk6XNlN0lwh/QOtwhrj7OKtz6DYaJSO646K12WZbd5/CL2hKmIQo48MGgtUOMR/
	 cjKW1F/ZxZJ5/IyJ+C7eFzkaOcDMqvgszcEZ4C73tUHH4aRxv5cTPqA1jwNlog25nDVdx
	 0pLJZVO/KgYesJ+c5quTn5OQopQqZ9KlRoyprPvkz2q5os2r+BmuyQLqgqgsiJSos18Si
	 3TiNqUaUQr3xet3cxRVsZK8WoqJHRealFDrIJX7uUnnEMOT+vxVH4OXZOMlJTCi+CkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=nu8Ul8LG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.17
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DC606A32C;
	Mon,  2 Nov 2026 08:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3DC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=nu8Ul8LG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRaJhWONBKuQVLLxZl4nQuTWTLfxEZ2d9Q6sl888i+Yi0j5gmXqLdhPblEbWfaaK7NegRtgE9hoekC/101WGGf/1c/jUfGfCffq7ZTRctI10bhXgxADc7Zu8OU4blx5WIvxATLC2UWGC2j1l+Q1MtbxbBjgAiHmYCOBhYwxIIkmHZDoeUzcAcfkKaZatRDdbMamipdrSxrM0HQgsZ7AiU6T7fBLXx4mq3wCuSvKpSdHrtH7qe59fnpa2un0x1xq/zmVsRbzJkhjG+G2TLiiw8m7UwcIda2v/tQyZljkXyJ6GzDwmE2l+kUvqiezJapdG/tOuVjG0/VC56AeU0w2k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jovyLjkFUlnE6WdunS/8qOSRwgN3EC5HwdUUEms1QH8=;
 b=gPzznq39qatxYE2CparZAm9neL0u0ZSONqMZv9HSten3eOSM3JHzJemReBbCaxKtRAU9JdeXI7awMI9Jearrv8rIRiHGNFtmNLdqIPboMtC3oX5qfvL0FAoXvrRYszZWf9m3AWJaO1F8oOl7hlXe6Cm27kt7XdVotQOcDhTFAUlrCvDiWWdjRUYuI7U9LrXIgvLjZx1cMGji9QQXUBSmd1AdGPBn80vWVWIOp2ub38Idt/ZsmMZaNarrFkz+nhclRLGmDjUE+l083FJ4MYR5qhTMpC1DCE+qa4YtnTgyHjZD+ZGeTK7oEZ82MbyMxnWW/7IPp2MApnfduJXq6TO2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=163.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jovyLjkFUlnE6WdunS/8qOSRwgN3EC5HwdUUEms1QH8=;
 b=nu8Ul8LG4txktEyFo1yAzfgIds0hEANZPO1E0QqKJCxv7uRxcHrKV2izMwXd9YfbCPPGxPe/XLsPSRo3G1F/eBwXQFS1H6LcWzv4pLPYo8EKowJbjYwDwL0dROuo9sjSyh0DYq8yNd3EiBfTboFY8oKdDeGUXJodBLANjZLEEGKsrMYPDppW9+jSwIjdI0U1QhWX9Lc6+7sYqSmkAG3uhszkYlPsjDUtYMnjs0vLAz4srXrR7JFRQOWyOyWuS662wGD4SPEjh/OFcgwbFTFGaLcrtSNJnxog3QqLj7YNhi+OZ8TtbNFmlX+6Hbtixs3+1gace1fhUuAQDUVZHWhNWA==
Received: from PR1P264CA0190.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::19)
 by MRWPR10MB9601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:501:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 08:14:23 +0000
Received: from ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
 (2603:10a6:102:34d:cafe::b) by PR1P264CA0190.outlook.office365.com
 (2603:10a6:102:34d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 08:14:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6BC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:14:23 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 2 Nov
 2026 09:15:07 +0100
Received: from [10.48.86.230] (10.48.86.230) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 2 Nov
 2026 09:14:22 +0100
Message-ID: <872a93b8-4bd9-4718-89e2-019fd3c5b8ac@foss.st.com>
Date: Mon, 2 Nov 2026 09:14:21 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Subject: Re: [PATCH net v5 2/2] net: stmmac: restore RX descriptor buffer
 addresses on resume
To: Ding Hui <dinghui1111@163.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: <dinghui@lixiang.com>, <xiasanbo@lixiang.com>, <yangchen11@lixiang.com>,
	<liuxuanjun@lixiang.com>, <zhoujing3@lixiang.com>, <fujiahui@lixiang.com>
References: <20261025100636.613670-1-dinghui1111@163.com>
 <20261025100636.613670-3-dinghui1111@163.com>
Content-Language: en-US
In-Reply-To: <20261025100636.613670-3-dinghui1111@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6BC:EE_|MRWPR10MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee9df39-5049-48a3-80c9-08df38b94dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|13003099007|921020|56012099006|4143699003|5023799004|11063799006|261021121427099003|261026140227099003|261022113327099003|261022105027099003|261026121527099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	7UHp7LZGBq6qUNAeA2Pe2y7Lf9CSFlPMGcq9f0eoJIdAwHb0orrda3lTeYYlEgVyBjG/nbDbWnFOrzJd6XB2JagNC4FfqNitexKu+QFo9Tie++gF3ht44eF1w0dYP9HvJcnk6M2whiA/0VwBJZQN/5jLJQzpZjNszy28rHfMhbkm3warXC1RpGuKK14Ite+BnYEPLtofw/rXGDhsMOdKx9+13pZZB76ubX2El99+sb5G2Fqq251UJMLrm0pcuAikPsmHMuRF0LsMJMQ/DI3FPXQl70RT0ZeOQAE2D89ZhhXtXJjDrSAWcTo6vx7dYHDIO38vvmtBzolS424BfVkZkp4DLtu6e+QGxuFcrZqsWfhzxEVhzsDAl49XZPD0XiaioTocPhE+6UwpBRhXiHm8mOGzV9h8kqTuzltlMYnGB5u4go8tfm7DB1Ev02m6ZXWk35fRq+RcDPEL9ZmCZfv1pLCOflZ4vN1edrJdr+FHmkUWKeiW0SL8KInG4l7UgZPY5ESgLHr5/PVv3eEX00QGcPCb+CecRK3igxBYTxV7N8xa8zDU8r8Y7hEHpiHrji9PaI7xuCqsVNXmkqIvmpl+iQ5YdZOdyiv6dBQNoaeNNx4iDSZYHU2JrRIqziPAEXPsFwA/slKKdcyYH/iJFm1rPFkYVl1HvrNXCWrR6k/quCR6ALPwJCIL+Lnd7qTxwtDQ
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(13003099007)(921020)(56012099006)(4143699003)(5023799004)(11063799006)(261021121427099003)(261026140227099003)(261022113327099003)(261022105027099003)(261026121527099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WXmarFeqkR0p1nxpMf+d7qJ7v/zCX3Ipcy4Pfv2DFFT/m/7wwKtm3GJHsP4OIgtwSX46WHm9Bcc6qGzN7CWhH8LE85ffEGkjwjk+4BsNUmZo0TyvHTfXXNEdHMVljcb3iwrVCG6pkFVY6Y/pofhyNN+9p9qJEBWnL8+4E5lcInyx7COi7v9GkiibwYONMxSL9oj4g0PTWGZd+NGPf/CjjCZjqStG3SKcdxSmOe+qQDN7+AdjDQDKvlepBsIgvDZ17F9kBBYHaA34fopRk7mNm1vRVXROHL0wCF66T4NuEm7pAc/Kq6r68hZ4gyYLb0+7Y9FrjWvg3G/XZabpj8uZc5wlLu+PXIyph8djy8Nd0lry+wepfryaodMxW4KvVcOQbg+ztVkHI7C029lBnVm2rTN4Ad1dkPPcxkr/gc4r7EfGLhhbHrg/hdRGtO5PQGsf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:14:23.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee9df39-5049-48a3-80c9-08df38b94dd8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR10MB9601

Hello,

I reproduced this issue on the STM32MP215-DK. I’m using kernel v6.18.
I fixed it similarly to your v5 patch set (cf. 
https://lore.kernel.org/all/20261027150556.51209-2-thomas.bourgoin@foss.st.com/).

I am limited to testing the low-power sequence on the STM32MP215-DK 
because we are currently upstreaming.
I backported your series to the STM32 fork based on v6.18, but I had to 
modify it because of some compilation issues, so I cannot say I tested 
your series as-is.

Overall, I’m okay with your patch, I have a few suggestions:

 > +			stmmac_legacy_serdes_power_down(priv);
 > +			mutex_unlock(&priv->lock);
 > +			rtnl_unlock();
 > +			return ret;
replace these 4 lines with: `goto error_unlock;`

 > @@ -8503,6 +8577,18 @@ int stmmac_resume(struct device *dev)
 >   	stmmac_free_tx_skbufs(priv);
 >   	stmmac_clear_descriptors(priv, &priv->dma_conf);
 >
 > +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
 > +		ret = stmmac_reinit_rx_descriptors(priv, &priv->dma_conf, queue);
 > +		if (ret) {
 > +			netdev_err(ndev, "Failed to restore RX queue %u: %d\n",
 > +				   queue, ret);
 > +			stmmac_legacy_serdes_power_down(priv);
 > +			mutex_unlock(&priv->lock);
 > +			rtnl_unlock();
 > +			return ret;
 > +		}
 > +	}
 > +
 >   	ret = stmmac_hw_setup(ndev);
 >   	if (ret < 0) {
 >   		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);

You could move the calls to `stmmac_free_tx_skbufs()`, 
`stmmac_clear_descriptors()`, and your loop into a dedicated function, 
perhaps something like `stmmac_resume_descriptors()`.

In my PR, I also factorized the loops so there is one for TX and one for 
RX, instead of one loop for TX and RX in `stmmac_clear_descriptors()`, 
one loop for TX in `stmmac_free_tx_skbufs()`, and one loop for RX to 
rebuild them.
By doing this, I managed to remove the `stmmac_free_tx_skbufs()` 
function. It changes the PM sequence a bit, but I think it is okay. I’ll 
let you decide whether you want to do it or not.

 > +	/* GMAC4/XGMAC secondary address writes overwrite the OWN bit. */
 > +	dma_wmb();
 > +	for (i = 0; i < dma_conf->dma_rx_size; i++) {
 > +		buf = &rx_q->buf_pool[i];
 > +		if (rx_q->xsk_pool && !buf->xdp)
 > +			continue;
 > +
 > +		p = stmmac_get_rx_desc(priv, rx_q, i);
 > +		stmmac_set_rx_owner(priv, p, false);
 > +	}

Since on GMAC4/XGMAC we need to set the owner bit after writing the 
secondary address, why do we need to call `stmmac_clear_descriptors()` 
before reinitializing the RX descriptors?
Since `stmmac_clear_descriptors()` is a loop that calls 
`stmmac_init_rx_desc()`, and I verified that all `.init_rx_desc` ops set 
the OWN bit to 1, could we call `stmmac_clear_descriptors()` after 
rebuilding the RX descriptors instead and remove this loop ?

Best regards,

Thomas
