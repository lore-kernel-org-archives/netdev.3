Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742560;
	b=IEE6br62ACV3QhZ/wcgMrSoNMf1qvcwAOnFAjKIDVlj7wP06Icm1q6EB4OGhbTBWs52b
	 1tzzCehgbfqTZG9eu1vYu2R4IIBfk146oIxk38Qxebp1phSSR9cF/TLA43orzr9oYjwFA
	 3vte2v0rMZK/xi+VFSMSSByjA542kq2gZRsBGs5tcY8ieZakJxW4tdluuqa8rh68WZoQ1
	 aoSB53Q8mIfCQdQfVnBIDXw66jkGDvtyK5xY/j0UBL6d6rSabfIcLa8AimyiUimrRKGXn
	 hG3U9Ka0kX2Ks9WCpzex855YbCM9FMWTpncZUgVaKBAsgvkjG9jRlUSIwqDNdY1Lr2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742560;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2IprmoDY5fbRuPolNXZmUEvIC9+7kKskVxlbsDQR3xU=;
	b=Nv0CUffcr7xAaSevXce5Rxspgru3jfy9RqaczHOYbsIzPdNYt0qc1dAWVQIduUEKuEri
	 K2KGbqv4OjCD9mg6t/qMfF39P8urml2cZG8wNESlttuRGbBvRpil96b42HSTnQO9mVcWH
	 xuTsSWrKx0au7/lNrKJ1TVVIzfu44mpGMiYGH8WCeAKC5T2kj3yioyyIDoHnEBbmtUp+X
	 5w+kRDnpEHU4VWXZ/2RJ9f/Vas9FehfNo2njhZv31JSzeDiMMyRXOseBplIdRThMbIEun
	 KjHR1427SqysMCkapGgUO+uVE7S9XRmZ+524lyuA4Bb1c9+Ch/SGLWwQZi6rSvj3wbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuYKjSKT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CD606A324;
	Tue,  3 Nov 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuYKjSKT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B921F000C1;
	Tue,  3 Nov 2026 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742560;
	bh=2IprmoDY5fbRuPolNXZmUEvIC9+7kKskVxlbsDQR3xU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YuYKjSKT1kpDcyFQhGEe6/Hxh0jiRwMOMvayfSBFEdmEijvSEi+uxrEsy2NYQ9UGl
	 Wyu9pZwSOlK0rVwEiChFhR9fYY0Qnk9PMYAgRiRLzuHJ1234U8fZmgwen1jsun3fcA
	 9dtHZOUJdL/xSCfXyfmaDTW6OemJlFTArUkL98uxTtmgvE3iEhM43LG18K1Mlcyhte
	 28KRMSgeNFEeYgxZ6MUv3gi6iVawP3JYenWPJciBbceIVBB9ipBCLODs/wJvwxhZXl
	 jWQKY3NwftndZCCmfMdlFmfaqLFyZYTCOcf6i5Ko0ed7R8Q7NwK8z0KYnRjJ2VlEXl
	 xNK6EuVIIZjpA==
Subject:
 Re: [PATCH net] net: bgmac: keep the maximum RX frame within one RX buffer
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 21:49:18 +0000
Message-ID: <179374255874.488856.3433103491850996503@kernel.org>
In-Reply-To: <20261102214746.9274-1-rosenp@gmail.com>
References: <20261102214746.9274-1-rosenp@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the patch tries to close the case where
  bgmac_dma_rx_read() reads a dma64 continuation buffer as a new frame…
- [Low] The commit message says UMAC_MAX_FRAME_LEN is programmed 'from
  the MTU plus a VLAN tagged Ethernet header and the FCS, as bcmgenet…

--

net: bgmac: keep the maximum RX frame within one RX buffer

This patch sets UMAC_MAX_FRAME_LEN to the MTU plus a VLAN tagged
Ethernet header and the FCS. It also lowers max_mtu to BGMAC_RX_MAX_MTU
(1514), so that the largest frame the MAC accepts fits in one 1536 byte
RX buffer. In addition, bgmac_chip_init() now uses the current MTU, and
bgmac_change_mtu() now updates net_dev->mtu.

> Program UMAC_MAX_FRAME_LEN from the MTU plus a VLAN tagged Ethernet header
> and the FCS, as bcmgenet does for the same UniMAC register, and limit
> max_mtu so that the resulting frame fits in one RX buffer.

[Severity: Low]
Is the comparison to bcmgenet accurate? init_umac() in bcmgenet.c writes
a fixed value that does not depend on the MTU:

    bcmgenet_umac_writel(priv, ENET_MAX_MTU_SIZE, UMAC_MAX_FRAME_LEN);

bcmgenet.h defines that value as:

#define ENET_MAX_MTU_SIZE	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
				 ENET_BRCM_TAG_LEN + ETH_FCS_LEN + ENET_PAD)

That adds up to 1536. It includes room for a 6 byte Broadcom tag and 8
bytes of padding.

bcm4908_enet_set_mtu() does compute the limit from the MTU, but it uses
mtu + ENET_MAX_ETH_OVERHEAD (32), which also leaves room for tags.

Could the commit message stop citing bcmgenet as the precedent for the
mtu + VLAN_ETH_HLEN + ETH_FCS_LEN formula?

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 669eb7ce7d40b..f29568a4190a8 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1110,6 +1110,13 @@ static void bgmac_enable(struct bgmac *bgmac)
>  	}
>  }
>  
> +/* The MAC counts the FCS in the maximum frame length. */
> +static void bgmac_set_max_frame_len(struct bgmac *bgmac, int mtu)
> +{
> +	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN,
> +			 mtu + VLAN_ETH_HLEN + ETH_FCS_LEN);
> +}

[Severity: High]
Does this register write fully close the continuation buffer problem
described in the commit message? The RX side that parses the header is
unchanged.

bgmac_dma_rx_enable() still sets the overflow continue bit. Any frame
longer than BGMAC_RX_MAX_FRAME_SIZE will still spill into the next
descriptor:

    ctl |= BGMAC_DMA_RX_OVERFLOW_CONT;

bgmac_chip_reset() puts CMD_RX_ERR_DISC in the clear mask and sets
CMD_NO_LEN_CHK. So the MAC is not set up to discard errored or
over-length frames before DMA.

bcmgenet_desc_rx() uses the same UniMAC. It receives over-length frames
with DMA_RX_LG set and drops them in software. That suggests the MAC
flags oversize frames instead of always discarding them.

At max_mtu the new limit is 1514 + 18 + 4 = 1536, exactly
BGMAC_RX_MAX_FRAME_SIZE. That leaves no margin for a stacked VLAN tag or
for any extra length the MAC allows.

If a frame longer than 1536 bytes does reach DMA, bgmac_dma_rx_read()
reads the next slot's rx->len and rx->flags from bytes the sender
controls. These are the checks it then relies on:

    if (len > BGMAC_RX_ALLOC_SIZE) {
    ...
    /* Omit CRC. */
    len -= ETH_FCS_LEN;
    ...
    skb_put(skb, BGMAC_RX_FRAME_OFFSET +
            BGMAC_RX_BUF_OFFSET + len);

BGMAC_RX_ALLOC_SIZE includes the alignment padding and skb_shared_info.
That is roughly 1.9 to 2 KB, well above the 1536 bytes the DMA can write
per slot. rx->flags is never checked.

There is also no lower bound. With u16 len, an rx->len of 0..3 wraps to
about 65532 and hits skb_over_panic(). With 64 byte cachelines:

  - a len above about 1602 overruns skb->end, which is also a BUG()
  - a len of 1541..1602 passes stale netdev_alloc_frag bytes up the stack

Other drivers check this in software. b44_rx() bounds the length by the
real buffer size and rejects error flags:

    if ((len > (RX_PKT_BUF_SZ - RX_PKT_OFFSET)) ||
        (rh->flags & cpu_to_le16(RX_FLAG_ERRORS))) {

brcmsmac dma_rx() drains continuation buffers.

The patch is noted as compile tested only. Would it be safer to also
validate in bgmac_dma_rx_read()? For example:

  - drop frames with len > BGMAC_RX_MAX_FRAME_SIZE or
    len < ETH_HLEN + ETH_FCS_LEN
  - check the error and oversize flags
  - skip continuation descriptors, or stop setting
    BGMAC_DMA_RX_OVERFLOW_CONT

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
> index 6fee9a41839c0..ace65789289fc 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.h
> +++ b/drivers/net/ethernet/broadcom/bgmac.h

[ ... ]

> @@ -330,6 +331,9 @@
>  						 BGMAC_RX_FRAME_OFFSET)
>  #define BGMAC_RX_MAX_FRAME_SIZE			1536
>  #define BGMAC_RX_BUF_SIZE			(BGMAC_RX_FRAME_OFFSET + BGMAC_RX_MAX_FRAME_SIZE)
> +/* Largest MTU whose VLAN tagged frames, FCS included, fit in one RX buffer */
> +#define BGMAC_RX_MAX_MTU			(BGMAC_RX_MAX_FRAME_SIZE - VLAN_ETH_HLEN - \
> +						 ETH_FCS_LEN)
>  #define BGMAC_RX_ALLOC_SIZE			(SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) + \
>  						 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102214746.9274-1-rosenp%40gmail.com
