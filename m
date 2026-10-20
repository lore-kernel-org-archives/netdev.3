Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525948;
	b=146t4Pw8wTLz9O0iGMevcPY+nRjoIkis/DfPtrnn+CZf+zUXExybgzR9rrcXvEszhDV3
	 EZpEuzkNIsXObXd4Y9ioVsvTPaQXK4FkcIkjYeasLWzMxCuB5HBJYEshYhlFaQ7jz/vVQ
	 UNJvNPaoZnYhfxt3aJ7PmzxM8FV7R/9DMmyDvkbxPGdb+9RAMCakoHXfZmf/0K40A0FMg
	 cpTMBsUZBEeXULDGsUuWrfx5MD9u8YUvKfDHI58OuuLRmrOCMKxYzRKmek5q1/HuqYv+j
	 OPL4YvpbvmuEXgMsBJH5bebZgP3zv3q/HOLVAg2MPNUCOp5LoiEDOpqx+hFJhjdl33Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525948;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TVMsvylpP/ZnU9JYZOI0/TB/0MO1mUWfwPXWOVftonM=;
	b=C36l82CThl96/Tw5wSIT5oIhooyJocGcEeOX976WFC0lqk12b2BBUyUOknEyYS3NMqw0
	 35QGBfpSpexZKDiT8EMndcfpDn2nVfX3V/RfGFcsavdrAk12taCwKGBlTgeIaybb7JxJD
	 /emMR1jrCRZ9+PoVTa3cVbQjPwhbBoTZzYSxnTxRfQenZ0t35trl+9H0vynzvjfFxzCWr
	 oK7iKKod5775zdLXGSshMa5kT1uXoAoN7zBAab+euPPQT/kipCC5zicsyGNQPKmEXck3k
	 ZlwxYrIPSXHBcu3ZEMwSVD65Mur3vJmiRaIncBEkPQWTpfBYxQCfYHqYeJMeSkXlEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFa2proZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F7606A319;
	Tue, 20 Oct 2026 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFa2proZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA0E1F000C9;
	Tue, 20 Oct 2026 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525947;
	bh=TVMsvylpP/ZnU9JYZOI0/TB/0MO1mUWfwPXWOVftonM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mFa2proZX+jUFQnsQlkOl07MzBA5N7X6MsJREKldOAdNk8r/B9Ymng9E7CyxgOAE0
	 PdPm4sj2Aan/brxGWz44oCDxnt7lhQHuu4BX6ApaZDhvVQzFvPKj+Hq589IDsA17a0
	 f99nAgT7dfJyXuIqVKEp3Un15GK8WZFSgQaU0kIOGuxmkJ9N6jYb0EngSZCwh26TS1
	 mP5EuBs7otOlGofdqJwu97gb4O8o+0PaHEXz7ThIID4EeqANADC4uXhtM6TWTrg9on
	 KP3M3CJFcgQ8IL/VNvQv4XK1n16/SPVAbmkf6Zx8zyLuj4SQVexK91eOjjJ+mZR9c5
	 ANfhoFNfzpWiw==
Subject: Re: [PATCH net] net: stmmac: fix rx checksum offload with extended
 descriptors
From: netdev-bot+sashiko@kernel.org
To: todadzealexi19@proton.me
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 19:52:26 +0000
Message-ID: <179252594627.3135.13846678930090028029@kernel.org>
In-Reply-To: <20261016-stmmac-rx-csum-v1-1-986342ec40df@proton.me>
References: <20261016-stmmac-rx-csum-v1-1-986342ec40df@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix leaves its own stated root cause in place.
- [Medium] enh_desc_ext_rx_csum() keeps csum_none whenever RDES0 bit 7
  (RDES0_IPC_CSUM_ERROR) is set (enh_desc.c:116-118).
- [Medium] In stmmac_rx() and stmmac_rx_zc(), stmmac_rx_status() reads
  des0 for the OWN check, and then enh_desc_get_ext_status() reads…

Pre-existing issues:
- [High] The AF_XDP zero-copy RX path ignores the checksum status from
  the descriptor.

--

net: stmmac: fix rx checksum offload with extended descriptors

This patch changes the extended RX status callback so that it returns a
status. enh_desc_get_ext_status() now uses RDES4 to upgrade csum_none
frames to good_frame when the hardware reports a TCP, UDP or ICMP payload
with no header, payload or bypass error. It also fixes
ERDES4_IP_PAYLOAD_TYPE_MASK, and stmmac_rx() and stmmac_rx_zc() now use
the returned status.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> index 0512536012251..7620246f6a441 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> @@ -109,8 +109,26 @@ static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
>  	return ret;
>  }
>  
> -static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
> -				    struct dma_extended_desc *p)
> +static int enh_desc_ext_rx_csum(u32 rdes0, u32 rdes4, int status)
> +{
> +	u32 type = FIELD_GET(ERDES4_IP_PAYLOAD_TYPE_MASK, rdes4);
> +
> +	if (status != csum_none || !(rdes0 & RDES0_FRAME_TYPE) ||
> +	    (rdes0 & RDES0_IPC_CSUM_ERROR))
> +		return status;

[Severity: Medium]
The commit message says RDES0 bit 0 is the Extended Status Available flag
when extended descriptors are used. enh_desc_get_rx_status() still passes
that bit to the COE table as payload_err:

    ret = enh_desc_coe_rdes0(!!(rdes0 & RDES0_IPC_CSUM_ERROR),
                             !!(rdes0 & RDES0_FRAME_TYPE),
                             !!(rdes0 & ERDES0_RX_MAC_ADDR));

This early return only corrects the csum_none rows. With RDES0_FRAME_TYPE
clear and ESA set, the same misread produces table entry 0x1. If bit 7 is
also set, for example timestamp available, it produces 0x3. For both,
enh_desc_coe_rdes0() returns discard_frame:

    else if (status == 0x1)
        ret = discard_frame;
    else if (status == 0x3)
        ret = discard_frame;

Can this still drop valid IEEE 802.3 length-field frames (LLC/SNAP, STP
BPDUs) that carry extended status? On discard_frame, stmmac_rx() and
stmmac_rx_zc() release the buffer. When hwts_rx_en is set, rx_errors is
not incremented either.

The tree doesn't show whether the GMAC sets ESA on 802.3 frames, so this
depends on hardware behaviour.

The commit message says "Everything else keeps the status from RDES0".
That seems to include these discarded frames. Would it be more complete
to stop passing ERDES0_RX_MAC_ADDR into enh_desc_coe_rdes0() for extended
descriptors, instead of overriding only the csum_none subset?

[Severity: Medium]
Is RDES0_IPC_CSUM_ERROR the right bit to test here? With extended
descriptors and advanced timestamping, enh_desc_get_rx_timestamp_status()
reads RDES0 bit 7 as Timestamp Available:

    if (ats) {
        struct dma_extended_desc *p = (struct dma_extended_desc *)desc;
        return (le32_to_cpu(p->basic.des0) & RDES0_IPC_CSUM_ERROR) >> 7;

stmmac_init_timestamping() turns on adv_ts in exactly this configuration:

    else if (priv->extend_desc && priv->dma_cap.atime_stamp)
        priv->adv_ts = 1;

With HW RX timestamping enabled (for example HWTSTAMP_FILTER_ALL), would
every timestamped frame take this early return and get its checksum
verified in software again? The ERDES4_IP_HDR_ERR check just below
already covers IP header errors.

> +	if (!(rdes4 & (ERDES4_IPV4_PKT_RCVD | ERDES4_IPV6_PKT_RCVD)) ||
> +	    (rdes4 & (ERDES4_IP_HDR_ERR | ERDES4_IP_PAYLOAD_ERR |
> +		      ERDES4_IP_CSUM_BYPASSED)))
> +		return status;

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b837e8e27a352..efedd050474ff 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5605,8 +5605,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  			break;
>  
>  		if (priv->extend_desc)
> -			stmmac_rx_extended_status(priv, &priv->xstats,
> -						  rx_q->dma_erx + entry);
> +			status = stmmac_rx_extended_status(priv, &priv->xstats,
> +							   rx_q->dma_erx + entry,
> +							   status);
>  		if (unlikely(status == discard_frame)) {

[Severity: High]
This isn't a bug introduced by this patch, but in stmmac_rx_zc() the
refined status stored here is only compared against discard_frame and
rx_not_ls. stmmac_dispatch_skb_zc() takes no status argument. When coe is
set, it marks every IP frame as verified:

    if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
        skb_checksum_none_assert(skb);
    else
        skb->ip_summed = CHECKSUM_UNNECESSARY;

stmmac_rx(), by contrast, also checks status & csum_none.

dwmac4_wrback_get_rx_status() reports RDES1_IP_HDR_ERROR and
RDES1_IP_PAYLOAD_ERROR as csum_none, not discard_frame. enh_desc also
reports payload errors, bypassed checksums and fragments as csum_none.

With an XDP_PASS verdict, can frames with a bad TCP or UDP checksum reach
the stack as CHECKSUM_UNNECESSARY through
stmmac_rx_zc()->stmmac_dispatch_skb_zc()?

The commit message says "Frames with a bad TCP, UDP or ICMP checksum, over
IPv4 and IPv6 and including fragmented UDP, are still dropped". That looks
true only for stmmac_rx().

>  			xsk_buff_free(buf->xdp);
>  			buf->xdp = NULL;
> @@ -5788,7 +5789,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		prefetch(np);
>  
>  		if (priv->extend_desc)
> -			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
> +			status = stmmac_rx_extended_status(priv, &priv->xstats,
> +							   rx_q->dma_erx + entry,
> +							   status);

[Severity: Medium]
Is a dma_rmb() needed between the OWN check in stmmac_rx_status() and this
read of the extended status? enh_desc_get_ext_status() reads des4
directly:

    u32 rdes4 = le32_to_cpu(p->des4);

stmmac_tx_clean() has the barrier for the matching TX case:

    /* Make sure descriptor fields are read after reading
     * the own bit.
     */
    dma_rmb();

Before this patch, a stale des4 only skewed the extra_stats counters. Now
enh_desc_ext_rx_csum() can upgrade csum_none to good_frame based on RDES4
alone, and stmmac_rx() then sets CHECKSUM_UNNECESSARY.

enh_desc_set_rx_owner() only sets RDES0_OWN, and nothing clears des4 on
refill. On a weakly ordered CPU, could des4 be loaded before the OWN bit
and return the previous frame's clean TCP status, even though the new
frame's RDES4 reports a payload error?

stmmac_rx_zc() has the same gap.

>  		if (unlikely(status == discard_frame)) {
>  			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
>  			buf->page = NULL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-stmmac-rx-csum-v1-1-986342ec40df%40proton.me
