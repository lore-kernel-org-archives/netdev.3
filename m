Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2D49CF22;
	Tue, 15 Sep 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473276; cv=none; b=FByDz80d4lreTQLdVh8LYHCXdj9R/QbuPVvba550vBkjRELRHoRXPRcUQ+smBzbhVP0EBLL2g1NPIRCRAcIG/lq1SlwY0OznT4Y00oA6b1Y8u72SeiCLHFebh+/ibm5XY/1YiD9wOvgmov7fyL6A/ESW936jhOvWSbE2CcuAqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473276; c=relaxed/simple;
	bh=LpZCKakn0owOIPqmBPsKOp/5PsqTgMQcwmG+yd2qVzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS+/R/M8TbyILX/7pkM9q698gvdeOwA/d6lG9TxdZe9rHczygbhFxk2fM2p1XGP+UullqRWq6OjtUqLn2bAKr4PtjFiPru0255JWbkMIS/T+CdALMx+idtfDktIxQtXmu4K7BOzdgzEFnV/Mv1R3JUNiF/uRG3e5LSaxft/Eo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pEv2juTy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pEv2juTy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12A431A07F5;
	Tue, 15 Sep 2026 11:54:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D671C60498;
	Tue, 15 Sep 2026 11:54:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6087C11C7AFEF;
	Tue, 15 Sep 2026 13:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789473268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=v9HVHg//bqRZX6HPZycNJoFtZb06mU6ET5+6+ELh3es=;
	b=pEv2juTy10gwQZEcB8YU36BR8E4LT9C0GHJxFKbq7PJcG54dQ7cYwZ5uj3Yk+/BDTiebx1
	b/SpbVLjASpJq4Pzhttfcb32yDDv6bt24WabGcx8JoJDsUzW65SE3uTA/DJJKoIo7vAw81
	2jX9VOjekQdEbUGCn/h2TEgs3U2LG+dj/Yge6+lFj4cFvDLj0kFLvBX0V6Vz79+E5XGJRx
	9+pp0uXGjXE3lhRWVA0wv1gtKdyxWZ5pUabnQ29gA2H/MxxLnaTn0TTXh+h/sx3l6juKzD
	EYZJwyu0MY+hRQa8z5aC4dQOJQJfh98tXgndZa5sMNJbccwQq01iIvJPLgwcrQ==
Message-ID: <30bf64df-5b96-40d8-b313-e680b5063ecb@bootlin.com>
Date: Tue, 15 Sep 2026 13:54:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/6] net: stmmac: selftests: Capture all packets
 for vlan checks
To: Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
 alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@esmil.dk, minda.chen@starfivetech.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, jan.petrous@oss.nxp.com,
 ovidiu.panait.rb@renesas.com, Jose.Abreu@synopsys.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 david.laight.linux@gmail.com
References: <20260911212028.1497613-5-maxime.chevallier@bootlin.com>
 <20260915084547.75267-1-pabeni@redhat.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260915084547.75267-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/15/26 10:45, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: stmmac: selftests: Capture all packets for vlan checks
> 
> The VLAN selftests use vlan_vid_add() without a VLAN netdev, so the test
> frame is marked PACKET_OTHERHOST and reaches the handler with a cleared
> skb->vlan_tci.  This patch reuses the DSA proxy mechanism to register an
> ETH_P_ALL handler for the three VLAN tests so validation sees the tag.
> 
> A few questions about the new capture_all path below.
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
>> index 7f5837d1fed94..315c3cf82230e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
>> @@ -242,6 +242,7 @@ struct stmmac_test_priv {
>>  	__be16 packet_type;
>>  	int (*func)(struct sk_buff *skb, struct net_device *ndev,
>>  		    struct packet_type *pt, struct net_device *orig_ndev);
>> +	bool capture_all;
>>  	int double_vlan;
>>  	int vlan_id;Hi,
>>  	int ok;
>> @@ -344,7 +345,7 @@ static void stmmac_sft_add_pack(struct packet_type *pt)
>>  {
>>  	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
>>  
>> -	if (netdev_uses_dsa(tpriv->pt.dev)) {
>> +	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
>>  		tpriv->packet_type = tpriv->pt.type;
>>  		tpriv->func = tpriv->pt.func;
>>  
>>  		/* DSA conduit will report ETH_P_XDSA, so our packet handler
>>  		 * won't match. Let's register a ETH_P_ALL match and filter
>>  		 * manually in stmmac_sft_filter.
>>  		 */
> 
> [Severity: Low]
> This isn't a bug, but the comment now only describes one of the two reasons
> for taking this branch.  For the three VLAN tests pt.type is ETH_P_IP or
> ETH_P_8021Q, which would match at ptype_specific just fine, so the
> "DSA conduit will report ETH_P_XDSA" rationale does not apply there.
> 
> Could the comment also mention the capture_all reason (the tap has to run
> at ptype_all so skb->vlan_tci is still populated), and could the new
> capture_all field get a one-line comment stating that it must be set before
> stmmac_sft_add_pack() is called?
> 
>>  		tpriv->pt.type = htons(ETH_P_ALL);
>>  		tpriv->pt.func = stmmac_sft_filter;
>>  		tpriv->pt.ignore_outgoing = true;
>>  	}
> 
> [Severity: Medium]
> With pt.type set to ETH_P_ALL on priv->dev, stmmac_test_vlan_validate() now
> sees every ingress frame, and it declares the test failed before it has
> established that the frame is a test frame:
> 
> 	if (tpriv->vlan_id) {
> 		if (skb->vlan_proto != htons(proto))
> 			goto out;
> 		if (skb->vlan_tci != tpriv->vlan_id) {
> 			/* Means filter did not work. */
> 			tpriv->ok = false;
> 			complete(&tpriv->comp);
> 			goto out;
> 		}
> 	}
> 
> 	ehdr = (struct ethhdr *)skb_mac_header(skb);
> 	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
> 		goto out;
> 
> The h_dest and magic checks come after this.  Can any ordinary C-tagged
> IPv4 frame on the link (any VID other than 0x123, at least 33 bytes of
> linear data) now abort the VLAN Filter, Double VLAN Filter and VLAN Offload
> tests with a spurious failure for i == 0?  Before this patch the tag was
> cleared for such frames, so the vlan_proto check bailed out first.
> 
> Would it make sense to move the vlan_tci comparison after the destination
> MAC and magic checks so only test frames can set the verdict?

The ethtool selftests as they currently exists are very dependent on external
factors :
 - How was the link negociated (pause, eee)
 - Incoming traffic

So yes, ingress traffic may cause the selftest to fail :( I can move that check
around though for V4 :)

> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but the ETH_P_ALL tap widens the
> set of frames that reach the header parsing in stmmac_test_vlan_validate(),
> which derives offsets from the untrusted IPv4 ihl with only a fixed length
> check:
> 
> 	if (skb_headlen(skb) < (STMMAC_TEST_PKT_SIZE - ETH_HLEN))
> 		goto out;
> 	...
> 	uhdr = (struct udphdr *)((u8 *)ihdr + 4 * ihdr->ihl);
> 	if (uhdr->dest != htons(tpriv->packet->dport))
> 		goto out;
> 
> 	shdr = (struct stmmachdr *)((u8 *)uhdr + sizeof(*uhdr));
> 
> That check covers 33 bytes, which does not include the UDP header, the
> extra +4 double-VLAN offset, or an ihl larger than 5.  A frame with ihl = 15
> makes uhdr->dest be read well past the validated area (and past skb->len for
> a small frame).  The same arithmetic exists in
> stmmac_test_loopback_validate(), so this predates the patch, but would a
> pskb_may_pull() style length check based on the actual ihl be worth adding
> here?
> 
>> @@ -999,6 +1000,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
>>  	tpriv->pt.dev = priv->dev;
>>  	tpriv->pt.af_packet_priv = tpriv;
>>  	tpriv->packet = &attr;
>> +	tpriv->capture_all = true;
> 
> [Severity: Medium]
> This is a pre-existing issue, but the patch makes it observable.  The
> "Means filter did not work" path in stmmac_test_vlan_validate() reports
> failure through the same tpriv->ok = false state that a timeout produces,
> and the loop here treats that state as the expected outcome for i > 0:
> 
> 	wait_for_completion_timeout(&tpriv->comp, STMMAC_LB_TIMEOUT);
> 	ret = tpriv->ok ? 0 : -ETIMEDOUT;
> 	if (ret && !i) {
> 		goto vlan_del;
> 	} else if (!ret && i) {
> 		ret = -EINVAL;
> 		goto vlan_del;
> 	} else {
> 		ret = 0;
> 	}
> 
> So a frame admitted with a non-configured VID (0x124..0x126) is
> indistinguishable from a correctly dropped frame, and the test still passes
> even if the hardware admits every VID.  Before this patch the mismatch
> branch was unreachable because skb->vlan_tci was always cleared; now it is
> reachable but its verdict is discarded.  Could the return value of
> wait_for_completion_timeout() be checked, or a separate "packet was
> admitted" flag be used, so the two cases can be told apart?  The same
> pattern is in __stmmac_test_dvlanfilt().
> 
> [Severity: Medium]
> Also pre-existing rather than introduced here: tpriv->ok, tpriv->comp and
> the on-stack attr are shared between the softirq validator and this loop
> with no serialization, and init_completion() is only called once, outside
> the loop.  With capture_all, an extra complete() is now reachable from the
> "filter did not work" path for any tagged frame with a different VID.
> 
> Since complete() increments comp.done and wait_for_completion_timeout()
> consumes only one, does a surplus completion in one iteration make the next
> wait_for_completion_timeout() return immediately and take the verdict from a
> stale tpriv->ok?  Would a reinit_completion() at the top of each iteration
> help here?
> 
>> @@ -1093,6 +1095,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
>>  	tpriv->pt.dev = priv->dev;
>>  	tpriv->pt.af_packet_priv = tpriv;
>>  	tpriv->packet = &attr;
>> +	tpriv->capture_all = true;
> 
> [Severity: High]
> Does this actually fix the Double VLAN Filter test on the cores that can run
> it?  The test requires priv->dma_cap.vlhash, i.e. the xmac cores, where
> probe sets priv->hw->hw_vlan_en = true and stmmac_hw_setup() programs
> VLAN_TAG_STRIP_ALL together with VLAN_TAG_CTRL_EVLRXS, while
> vlan_vid_add(ETH_P_8021AD, ...) enables S-VLAN recognition.
> 
> The MAC-stripped outer tag is then reported by vlan_rx_hw() in
> stmmac_vlan.c:
> 
> 	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> 
> which hardcodes ETH_P_8021Q, while the validator with double_vlan set wants
> ETH_P_8021AD:
> 
> 	proto = tpriv->double_vlan ? ETH_P_8021AD : ETH_P_8021Q;
> 	...
> 		if (skb->vlan_proto != htons(proto))
> 			goto out;
> 
> So the frame does reach the validator now, but the vlan_proto check takes
> "goto out" without calling complete(), and the test still returns -ETIMEDOUT
> for i == 0 on working hardware unless RX VLAN stripping is turned off.  Is
> the intent that vlan_rx_hw() report the real tag protocol, or that the
> validator accept ETH_P_8021Q for the stripped outer tag?

Heh so since I sent this series, I've received more hardware, including
an dwxgmac2 platform ( finally \o/ )

And yeah this test fails on dwxgmac2 even with this patch :(

I'll address that in V4


> 
>> @@ -1371,6 +1374,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
>>  	tpriv->pt.af_packet_priv = tpriv;
>>  	tpriv->packet = &attr;
>>  	tpriv->vlan_id = 0x123;
>> +	tpriv->capture_all = true;
>>  	stmmac_sft_add_pack(&tpriv->pt);
>>  
>>  	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
> 
> [Severity: High]
> Can this dereference a NULL pointer in softirq context?  attr is
> zero-initialized, so attr.dst is NULL, and the ETH_P_ALL handler is
> published by stmmac_sft_add_pack() before attr.dst is assigned:
> 
> 	tpriv->capture_all = true;
> 	stmmac_sft_add_pack(&tpriv->pt);
> 
> 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
> 	if (ret)
> 		goto cleanup;
> 
> 	attr.dst = priv->dev->dev_addr;
> 
> vlan_vid_add() is not instantaneous here: it does
> pm_runtime_resume_and_get() and a register poll in vlan_write_filter().  A
> frame arriving in that window with vlan_proto ETH_P_8021Q and vlan_tci equal
> to the hard-coded 0x123 passes the tag checks and falls into:
> 
> 	ehdr = (struct ethhdr *)skb_mac_header(skb);
> 	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
> 		goto out;
> 
> which reads 6 bytes from address 0.  stmmac_test_loopback_validate() guards
> the same comparison with "if (dst)", so the pointer does not look like an
> invariant.  The same ordering exists in __stmmac_test_vlanfilt() and
> __stmmac_test_dvlanfilt(), where attr.dst is only set inside the loop.
> Would assigning attr.dst before stmmac_sft_add_pack(), or adding the NULL
> check to this validator, close that window?

Good point, I'll send a V4 then,

Maxime

