Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52D46AF0D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429819; cv=none; b=lG4GqA+TLE/OSAazkztgWZ4aIbk7VTYQvm7UrcpMdvaWhlPHAIsblgbsQkCYbIft2bdymF6ff+YpDiJznbRBYIhZ5+gQrUyG5P9UutN3CZg1ICcZ713uiNRPskRDdF5qr5cY6+9GUse8zwoRTxn9exFFoW9vp76n9ogGitoV1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429819; c=relaxed/simple;
	bh=pC11yBNjYZZ/t9l4RN7KL7DLTd/iUzs7JTf64xp+cqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6caPPfS1f9t67omeSbn9DwrFn6eAk0CDWXxo4c5kITceeh/zXxn6mwf1XxUMGlgpkTRIMiIR34+jNCCiPcpFnllrVuwri0el8NQjxXENeHMA5Vi6m43yHhN8iBMwihhe/3xRQX0SJc40GhEWmqCzpkEjrKutuvVVtW+uF0G8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JC4W9DiP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8aefP9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC4W9DiP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8aefP9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788429805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boQRXRabhO6WEWfFvB6cTq0LSA/DWIvL+EtoFzd/5jQ=;
	b=JC4W9DiPw0D51Y9Uo1oVHwMZ236k5nfln6X1DMQ78LDO+sjR7Km/H/XHyfqQ3zMCzgUWKD
	ic+gOi8yEGWURKnNTQLOJ0RL9udgA//hhEZAiShlqt+F1ttQhxfX78w/9IU3qNr05guYcp
	qxBJav4WhbrFvSIb4+BqlFXGtrbegLs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-1vZZwQPUPrG_TdJTXSqA_g-1; Thu, 03 Sep 2026 06:03:23 -0400
X-MC-Unique: 1vZZwQPUPrG_TdJTXSqA_g-1
X-Mimecast-MFC-AGG-ID: 1vZZwQPUPrG_TdJTXSqA_g_1788429803
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso19222715e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788429802; x=1789034602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boQRXRabhO6WEWfFvB6cTq0LSA/DWIvL+EtoFzd/5jQ=;
        b=P8aefP9fnGKieNwQemj30E9Z/YSSY3EXhZlhWCDpUoehIKuWLzQlX4l/A3dPUazjvX
         V8Fj1YrbVgHzZn+0FSo+LtKaHLEAQ0AomsaCXMXYYLmjVhVcHKi1Iaj0YPeUAA0nvOiU
         Wy8APBXOHAjkF1bCzIEw4hPgZhjIb+g+Uso1LgNAbXIhweYu16jVCNhM/rXmLbGedZrX
         bgJQ10xYW/14Nc28DZlv/PNNWZfKHrvynx3nA95Byg7nanQfVU7XNi89n2DVWEKIjNVR
         Hf9L1WlxxFHtedOLTpLrDF4UQQqQ/+AsfFf3hLg19ZeZ0X2y4ei6xXAYkgQLb0i+F1Ug
         vd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788429802; x=1789034602;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boQRXRabhO6WEWfFvB6cTq0LSA/DWIvL+EtoFzd/5jQ=;
        b=EVUuqJ2NZaIV4KPL6euXUSES0kJqeCNnWICtjpQBbNHs38T85AZuV3e7QYuYh1P5lq
         H9NYBp4GONFtUCGuj4T2Y3JCH2AVqexb6QBJGBFzrHx9ufRpXbYLUMN6PN7QXbzah3yF
         gOCZRLPIcBYoZw3gU8c6HbBVF6rc52T12/P7/rfYSbjat7ifnFZVrzn5SBm9mLOrSdKK
         o2xZJQRq9MrTCrHIE3hPVJWFuc9c7uF8eb81aabPQvHs64ooPX4I1cZMIhjVIp8gJ1ZK
         nRFcfUChutyCaji9vdp00+VLwS6UwJ1JA07wisDE/pDy1+oc27P5RDq0wtFycGuJalCf
         jbbw==
X-Forwarded-Encrypted: i=1; AKwUvBxnfcDLo6LAWhta9ZYhCUZ+Bu8hdr1u60L1zJW83K1uHShp5dwqsILej00HTbzzxDW07vDTG2M=@vger.kernel.org
X-Gm-Message-State: AFuF++k6DcqbyX5HnPvTpcsKp8U6d8ZbVcXPx2r1I+JGDi+eptvZ3mZY
	z+TmznYKCaFz4syuJXkBm6+Ov/zlHwWcDYH4bfARDBYB6C/dEciwerlgWKeWLBhHSO22/wBqnsp
	xvm4FAPDIqcFEoUWRITaRI5GLVAiXEjiauJ49mIzI+sy25gLCcbrIuoc7K36S5u314A==
X-Gm-Gg: AYBFou1T/7oWpTy8I0cRPLBYXSNNdIXSS4CFj9jN964qOXUC55/yAe7DkvuEX40Brkc
	GTvwCfOOxDAVqw8hkw54pXmLYwC0eJjAFF9lIY/K24Sj6kSKT+goknPW+037wKifbEai5K6i0A3
	5wZ6TIzvuEQKzh4Nq5KqW78B3x1OV85sJwrDWGKcgpwC5H9Ttf6dDCYALKQKpm3un+YvtFuXSmr
	ZmxLa0u2gpyN2alEWMC02rcjpMKQJxapfAJ65Y6c+qLrKCALbV4nckci4t9IeAdZ5LIm4CW4kNP
	B885YT0uTnip3ZzjTx5Kp+bX4nL6X7RrSYACUb8JYpgXj1KYe6ctXP+C8CvIy10kbbyb9TIT4o6
	91jpIC7e96Q8aC8mmEfw9HIQbJcHWGIgkun+GTtkAFDCSg5YCKWi+Pcd+r1MfWx/FjtYheXECig
	==
X-Received: by 2002:a05:600c:698d:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49cf4e14cb9mr13527415e9.16.1788429802426;
        Thu, 03 Sep 2026 03:03:22 -0700 (PDT)
X-Received: by 2002:a05:600c:698d:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49cf4e14cb9mr13526165e9.16.1788429801903;
        Thu, 03 Sep 2026 03:03:21 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dadddsm67031615e9.9.2026.09.03.03.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 03:03:20 -0700 (PDT)
Message-ID: <2d9afdd1-2d97-428d-b25c-1462bcea15df@redhat.com>
Date: Thu, 3 Sep 2026 12:03:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3] net: stmmac: drop the queue-0 pinning for GSO
 frames
To: netdev-bot+sashiko@kernel.org, lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260831-stmmac_select_queue-tso-fix-v3-1-d9c215fe7a85@oss.qualcomm.com>
 <178837492226.3394541.13110256562881802796@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178837492226.3394541.13110256562881802796@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 8:48 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 1
> 
> - [High] Removing .ndo_select_queue silently disables hardware TSO/USO
>   for most GSO flows on all in-tree stmmac platforms that mark every TX…
> - [Medium] The patch's stated safety property — 'stmmac_features_check()
>   already validates each GSO frame against the capabilities of the queue…
> - [Medium] The patch deletes the hardware fact that the removed comment
>   carried ('There is no way to determine the number of TSO/USO capable…
> - [Low] The commit claims to fix a real user-visible offload defect
>   ('This also fixes the case where queue 0 is not TSO-capable while…
> 
> --
> 
> net: stmmac: drop the queue-0 pinning for GSO frames
> 
> This drops stmmac_select_queue() and its .ndo_select_queue entry so GSO
> frames are no longer pinned to TX queue 0. The changelog argues the pinning
> is redundant because stmmac_features_check() already validates each GSO
> frame against the capabilities of the queue it is mapped to. Non-GSO
> traffic keeps going through netdev_pick_tx().
> 
> Link: https://lore.kernel.org/r/20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com
> Link: https://lore.kernel.org/r/20260807-stmmac_select_queue-tso-fix-v1-1-4c4787bad02b@oss.qualcomm.com
> 
>>From the changelog:
> 
>> This also fixes the case where queue 0 is not TSO-capable while other
>> queues are, which previously forced all TSO traffic into software GSO.
> 
> [Severity: Low]
> Since this is described as a fix, should it carry a Fixes tag? The queue-0
> pinning being removed came in with commit 4993e5b37e8b ("net: stmmac:
> Re-work the queue selection for TSO packets"), which in turn fixed
> c5acdbee22a1 ("net: stmmac: Send TSO packets always from Queue 0").
> 
> The removal also depends on the per-queue checks in
> stmmac_features_check() added by commit b55dfb173ce8 ("net: stmmac: move
> check for hardware checksum supported") and the surrounding series. Without
> those, backporting this alone removes the only thing that steered GSO
> frames to a capable queue.
> 
> Could the changelog name those prerequisites so stable triage has
> something to work from?
> 
> The claimed defect itself looks describable from DT, via
> stmmac_mtl_setup():
> 
> 	plat->tx_queues_cfg[queue].coe_unsupported =
> 		of_property_read_bool(q_node, "snps,coe-unsupported");
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 66ae365e1c89f..25121d6d84995 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -6428,24 +6428,6 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>>  	}
>>  }
>>  
>> -static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,
>> -			       struct net_device *sb_dev)
>> -{
>> -	int gso = skb_shinfo(skb)->gso_type;
>> -
>> -	if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6 | SKB_GSO_UDP_L4)) {
>> -		/*
>> -		 * There is no way to determine the number of TSO/USO
>> -		 * capable Queues. Let's use always the Queue 0
>> -		 * because if TSO/USO is supported then at least this
>> -		 * one will be capable.
>> -		 */
>> -		return 0;
>> -	}
> 
> [Severity: High]
> Does this lose hardware TSO/USO for most GSO flows on the in-tree
> platforms that mark every TX queue above queue 0 as TBS?
> 
> dwmac-intel.c, dwmac-imx.c, dwmac-mediatek.c, dwmac-qcom-ethqos.c and
> stmmac_pci.c all do the equivalent of intel_mgbe_common_data():
> 
> 	/* Default TX Q0 to use TSO and rest TXQ for TBS */
> 	if (i > 0)
> 		plat->tx_queues_cfg[i].tbs_en = 1;
> 
> That becomes STMMAC_TBS_AVAIL at open time in __stmmac_setup_dma_desc(),
> with no ETF qdisc involved:
> 
> 	int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
> 
> 	/* Setup per-TXQ tbs flag before TX descriptor alloc */
> 	tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> 
> and stmmac_tso_channel_permitted() then returns false for those channels:
> 
> 	/* TSO and TBS cannot co-exist */
> 	return !(priv->dma_conf.tx_queue[chan].tbs & STMMAC_TBS_AVAIL);
> 
> The commit message says stmmac_features_check() "validates each GSO frame
> against the capabilities of the queue it is mapped to", but the check only
> demotes the frame, it does not move it:
> 
> 	if (skb_is_gso(skb)) {
> 		if (!stmmac_tso_channel_permitted(priv, queue) ||
> 		    !stmmac_tso_valid_packet(skb))
> 			features &= ~NETIF_F_GSO_MASK;
> 
> So with the selector gone, netdev_pick_tx() hashes GSO flows over all N
> queues and roughly (N-1)/N of TCP/UDP-GSO flows on these boards end up
> segmented in software by validate_xmit_skb() rather than by the MAC. Is
> that intended, and if so could the changelog mention the throughput and
> CPU cost instead of describing the change as removing something that is
> "no longer needed"?
> 
> Would a capability-aware queue selection (or a per-queue TSO map consulted
> by the selector) be needed to keep the "Q0 is the TSO queue" contract those
> platforms document?
> 
>> -
>> -	return netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
>> -}
>> -
> 
> [Severity: Medium]
> The deleted comment records a hardware fact: there is no way to determine
> which TX DMA channels were synthesized with the TSO data path. DWMAC and
> XGMAC only expose a single global TSOEN bit, surfaced as
> priv->dma_cap.tsoen, and stmmac_hw_setup() programs TSE from it for every
> non-TBS channel without any readback:
> 
> 	if (priv->dma_cap.tsoen && priv->plat->flags & STMMAC_FLAG_TSO_EN) {
> 		for (chan = 0; chan < tx_cnt; chan++) {
> 			if (!stmmac_tso_channel_permitted(priv, chan))
> 				continue;
> 
> 			stmmac_enable_tso(priv, priv->ioaddr, 1, chan);
> 		}
> 	}
> 
> stmmac_features_check() only knows about tx_queues_cfg[queue].coe_unsupported
> and TBS, so on a part where only a subset of channels implement TSO it
> cannot clear NETIF_F_GSO_MASK, and stmmac_xmit() then hands the frame to
> stmmac_tso_xmit() on a channel whose DMA does not implement TSE. That
> programs an MSS context descriptor plus TDES3 in TSE/THL/payload-length
> form on a channel that decodes those bits as CIC and frame length.
> 
> Is there evidence that all channels are TSO-capable on the supported parts?
> If not, would a per-queue tso capability consulted by
> stmmac_features_check() be the replacement for the removed workaround?
> 
>>  static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
>>  {
>>  	struct stmmac_priv *priv = netdev_priv(ndev);
>> @@ -7302,7 +7284,6 @@ static const struct net_device_ops stmmac_netdev_ops = {
>>  	.ndo_eth_ioctl = stmmac_ioctl,
>>  	.ndo_get_stats64 = stmmac_get_stats64,
>>  	.ndo_setup_tc = stmmac_setup_tc,
>> -	.ndo_select_queue = stmmac_select_queue,
> 
> [Severity: Medium]
> Does the "features_check validates the queue it is mapped to" argument hold
> on the AF_PACKET PACKET_QDISC_BYPASS path? __dev_direct_xmit() runs the
> feature validation before assigning the real queue:
> 
> net/core/dev.c:__dev_direct_xmit() {
> 	...
> 	skb = validate_xmit_skb_list(skb, dev, &again);
> 	if (skb != orig_skb)
> 		goto drop;
> 
> 	skb_set_queue_mapping(skb, queue_id);
> 	...
> }
> 
> and with .ndo_select_queue gone, packet_pick_tx_queue() takes the else
> branch, so queue_id can be any queue:
> 
> net/packet/af_packet.c:packet_pick_tx_queue() {
> 	...
> 	skb_record_rx_queue(skb, cpu % dev->real_num_tx_queues);
> 	if (ops->ndo_select_queue) {
> 		queue_index = ops->ndo_select_queue(dev, skb, NULL);
> 		queue_index = netdev_cap_txqueue(dev, queue_index);
> 	} else {
> 		queue_index = netdev_pick_tx(dev, skb, NULL);
> 	}
> 	...
> }
> 
> The mapping stmmac_features_check() reads via skb_get_queue_mapping() is
> therefore (cpu % real_num_tx_queues) + 1, not queue_id. When the evaluated
> queue is TSO-permitted but the queue actually used is not, NETIF_F_GSO_MASK
> survives and stmmac_xmit() dispatches unconditionally:
> 
> 	if (skb_is_gso(skb))
> 		return stmmac_tso_xmit(skb, dev);
> 
> Before this patch the same ordering existed but was harmless, because
> packet_pick_tx_queue() consulted ndo_select_queue and GSO frames always
> went out on queue 0. Is something needed to close that now?
> 
> Separately, that mapping can be real_num_tx_queues itself when
> cpu % real_num_tx_queues == real_num_tx_queues - 1. Can this read past
> priv->plat->tx_queues_cfg[] and priv->dma_conf.tx_queue[] in
> stmmac_features_check() when real_num_tx_queues == MTL_MAX_TX_QUEUES?
FTR the above looks like a giant slop to me. The main point is that the
pre-patch ndo_select_queue() is IMHO very bad, as e.g. it would cause
OoO and unfair queues load. Dropping it is the right thing to do.

/P

