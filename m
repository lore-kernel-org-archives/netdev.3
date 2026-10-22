Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658044;
	b=Bz9hoG9siCIRaz+gpOb85YUizhDvrxIJfjRQKSnhcd0FVxwgrZsQTSNjb5eHQNvSIX+L
	 35iIhKHMxC/+x6ut5V2EBm3QECY7fTojSat75I+PNxZPUY4cOV1inPzbZFWMMRloN7NI3
	 tfeG1udFMrM2ne7EHxX/hLUoC4agtpuXk+1ghDfq8/xfilXK0C5bLmb9kQeEUu632uxJe
	 ZUoozcD3gs//ArflP/zs9soIxXhOmI+vJ0FoTtThpnfKmTZsjNiiYRZP963pI/KJV1rli
	 w91Qcf73owLFcio/BSVJwEU5/oOw72qnRXB8DMzb6xyg9doQemfe4E3ReGMIJPA5zhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Yax36yyXPOjU+t0sLu2tNeMo+58jNxQtj3yAO7yym5E=;
	b=ttMJHh+z6Oq96Doq9sAeNY/XMzwDkNYXtbERS2EQAEgb1byBFM46yGWa04xr1Fu1J0l9
	 1O01uhQua3HvP8eYuNyVFrL08GL5o65Pr3MDi1/CV0GtCj6PHIsNgAU+9Xo0tseiv8ZNY
	 xqH+Wdmha/4d3Zs3fousC8bbgUkAKOt3tR6M74EMmATltsbxz7dj2TOGIgeROd6LGsSu5
	 lgdymD5XLu193feWBB60JUXtmHAOC32qBhfHbOUw4rCajo1dB45XrYGZI5sExhMEedq/K
	 n3epi0iHEXxU5SqDo1VMf8C8x9yAIWFRRRAmkfBI/sbUPdwfFVCvbDexI9+aL0W2yPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C7bQgVoA;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0126606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0126606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C7bQgVoA
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so1999815e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658042; x=1793262842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yax36yyXPOjU+t0sLu2tNeMo+58jNxQtj3yAO7yym5E=;
        b=C7bQgVoAO4RA3HhlsxxWdnOhzaahrxQinb+MEjUCFSl9WedqaMJiMV4w3XHFlwirl3
         Ynm+CBOqgVH+8HTYM0ctuRV3EXPa/5srVyOiIodR0KNGzZ6x4Vmatk5W0gLdUNulB2jQ
         YDTO7tPPUJHjhQ/kCbfbSYfJfkIMiC0EJw3zJFdM2RYmB9gZR6z8dq1ci3rZ1+Qs06mz
         38Q1t5Vy8nTjvXlHhzfJza38tSEcDSLenwHAu6WNBCT1a2nA7MAqY58RVwmV/z2lKTTq
         0JFPT8VN+Y+PENgONSenlJwZSRAC3T0Wy5Y0bF0RrW8UwP2pBYOECkCyhkOSVtTXdLKx
         Rarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658042; x=1793262842;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yax36yyXPOjU+t0sLu2tNeMo+58jNxQtj3yAO7yym5E=;
        b=tPQ6NQJgdSRr0BkQ4q5+bL+Hg1hSYndxpwXRa7sDm2OKT2+eKh4i0VfHu1OQeRQ6pb
         CZV/9VD266a+pxxNy15c9KqzEFAerBHvPzXJLvC3EKX+qS2L+cRPZsramuZp+35F5Xfo
         doDFTbjGhV0KPmMllb6Djp7sDQyVcn9fhqzcSVCPabnOQlRSdINZvTnPUGvSR1vPP5YE
         tDKktuWE/+6PynyVkPYdod4wTv3ZqxEyOxi8Fi6BRWDx2brcBQ1syMYZIseVfKc6Hb33
         IDTp0cDU/aOhsKkZdnZ528ll8jlFnGb9teESOVrxQVM+bNpGOx+hCPd5tsuM+kbKQPfN
         O7Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxw2gOQUc2oYkR1kueSh9t9BW7z3i4ZaO/DUubNcsasfZ8IxqKAzxAf0TxdVSVAsr3sEihtEJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPxbgV6blyWP0qOayverx8QownYOOyVClkjwhcBX9M7OwXcd0x
	PDEszDcGOHLzRNCjd7V+0xuC6hN/j9X7tXi7UqLfMfTpVwVhfQ7/OKZS
X-Gm-Gg: AYBFou39ds9xrgv4zYxVfRRUS3eJo07Bj2ZesOK7h5Ewk90WGAjt/+wwHhUt7MkHPbe
	LqF4F/KICb0PrBp7QsRQX59Fbgvl8rUzTvRrHlHw8GO0AXppUIj3C4LoRhtLTaF2zg+9LF/L4t4
	jdpX/sIox1Yzqa1X3/SMW6ZhmcfRDTPcYiI3DJYU/yMHiN94zzqYrdj3IK3cK0wpgrIHf8sF17W
	Ts6eUGeSdwgmtQWWEXnbX6zDqLjaUEjSx1hY1jQoIG2hd23n12F6yJ1igaCCMjjZDcrkY6mSixX
	akVBq1pJ+VxGC6hzcrSY0DP/5h5HaE9Syw+fTdudutf+xeGpqFwGab0RFWCf2FUy+kkVbhJJjbL
	hB9fzlLb35QyUU7WA76j2/XF3pml7Gxoc95CIF2TIXQpbnahQAR1ex8jkIM0YwI/hnqEMzHoD7q
	PK2H9dinwlaTQXtrMpVkR9BBwgciEuWpy5Kunx9Xlqn22N6ANZG8Fks17WFTJZ1Ar5mF0BqN0MF
	fcDAZ0XhbjTQq4vmBPHB8nbckD7XNvXviF73rnOXTS6hEKCUM4Jlq9RIRlMM5k395wBpTp5K0te
	tUw7PxRFPhl+hGKN
X-Received: by 2002:a05:600c:a49:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4a204b20321mr33355645e9.11.1792658041966;
        Thu, 22 Oct 2026 01:34:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b28f91sm51399915e9.5.2026.10.22.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:34:01 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:33:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: vladimir.oltean@nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Zefir
 Kurtisi <zefir.kurtisi@westermo.com>, Zefir Kurtisi
 <zefir.kurtisi@gmail.com>, netdev@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware
 frame padding
Message-ID: <20261022093359.723c7e93@pumpkin>
In-Reply-To: <20261021145314.1435049-3-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
	<20261021145314.1435049-3-vladimir.oltean@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 17:53:12 +0300
vladimir.oltean@nxp.com wrote:

> The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
> This works, however sending short frames from user space and looking at
> the padding bytes inserted by the MAC at the link partner, we notice on
> LS1028A that the first octet of padding is sometimes not 0.
> 
> This is fine per 802.3, which does not require that the padding is zero.
> 
> However, there is an unproven suspicion that the padding bytes may
> come from internal memories, and unfortunately I couldn't get sufficient
> priority for this octet's origin to be investigated by hardware
> engineers.
> 
> To be defensive and not leak any sensitive information from the SoC,
> let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> have to do anything.
> 
> There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
> things are trivial; we need to call eth_skb_pad(). For GSO, things are
> not simple, because user space may set gso_size to a very small value,
> which could make the GSO super-skb smaller than ETH_ZLEN;

That isn't sensible.
The minimum frame is 64 bytes (including FCS), subtract that, the MAC
header (14 bytes), minimum IP header (20), minimum TCP (20) and that
leaves 6 bytes for user data.
I doubt it is sensible to do GSO for anything under the minimum mtu
(128 bytes rings a bell somewhere).

But does this code allow for the VLAN tag that you forgot about in the
other patch?

I also noticed that the code seems to dma map the fragments for each
gso segment separately, just mapping each skb fragment would be better.
(But that is for another patch series.) 

David

> padding that
> would produce more segments than originally intended. What needs to be
> done is to pad individual segments instead.
> 
> When a GSO segment's hdr_len + data_len is below ETH_ZLEN, append a
> zero-padding data BD and advertise the padded length in the header BD's
> frm_len.
> 
> The padding bytes are always the same zeros, so a single read-only
> DMA-coherent buffer (tx_pad, ETH_ZLEN bytes, zero-initialized by
> dma_alloc_coherent() and never written) is shared by all padding BDs of
> the ring. Like the header BD, a padding BD carries no per-BD DMA address,
> so cleanup does not unmap it. The pad BD becomes the segment's last BD,
> so the F flag and the skb pointer move onto it. Segment checksums are
> unaffected as they are computed over data_len only, before padding.
> 
> The worst-case descriptor reservation grows by one BD per segment.
> The pad BD also counts towards the per-frame chained BD limit (15 on
> LS1028A, including the head and extension BD), so a padded segment may
> use one data BD less.
> 
> Only LS1028A (NETCv1) needs this. On i.MX95 (NETC v4.1), it was observed
> that padding bytes are always zero, and the reference manual also
> documents in "106.3.5.1.2.1.3.7 FCS generation and append on transmit"
> that HTA Transmit pads short frames (including LSO segment frames) with
> zeros before appending the FCS. On LS1028A it does not say this (padding
> seems an exclusively mEMAC task).
> 
> Nonetheless, for simplicity's sake, we keep the unconditional eth_skb_pad()
> call in the common transmit path, but we leave the hardware LSO transmit
> path unpadded in software. The latter is only present on NETC v4.1 and
> later (thus already contains zeroes).
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v4->v5:
> - account for the pad BD in the new enetc_tso_count_descs() helper
>   from "net: enetc: reserve VLAN extension BDs for software TSO",
>   instead of open-coding it in enetc_start_xmit()
> - count the pad BD towards the per-frame chained BD limit, so a padded
>   segment may use one data BD less
> - explain in the commit message why hardware LSO is not affected
> v3->v4:
> - split from "net: enetc: pad short frames in software", bring its own
>   justification:
>   https://lore.kernel.org/netdev/20260921112946.edo5uw6cl7jx6oez@skbuf/
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 61 ++++++++++++++++++--
>  drivers/net/ethernet/freescale/enetc/enetc.h |  6 ++
>  2 files changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index f6b352a3a49c..a9ea124f7835 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -524,7 +524,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
>  				struct enetc_tx_swbd *tx_swbd,
>  				union enetc_tx_bd *txbd, int *i, int hdr_len,
> -				int data_len)
> +				int data_len, int frm_len)
>  {
>  	union enetc_tx_bd txbd_tmp;
>  	u8 flags = 0, e_flags = 0;
> @@ -541,7 +541,7 @@ static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
>  	txbd_tmp.buf_len = cpu_to_le16(hdr_len);
>  
>  	/* first BD needs frm_len and offload flags set */
> -	txbd_tmp.frm_len = cpu_to_le16(hdr_len + data_len);
> +	txbd_tmp.frm_len = cpu_to_le16(frm_len);
>  	txbd_tmp.flags = flags;
>  
>  	/* For the TSO header we do not set the dma address since we do not
> @@ -613,6 +613,22 @@ static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static void enetc_append_tx_pad(struct enetc_bdr *tx_ring, int i, int pad_len)
> +{
> +	struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
> +	union enetc_tx_bd *txbd = ENETC_TXBD(*tx_ring, i);
> +
> +	enetc_clear_tx_bd(txbd);
> +	txbd->addr = cpu_to_le64(tx_ring->tx_pad_dma);
> +	txbd->buf_len = cpu_to_le16(pad_len);
> +	txbd->flags = ENETC_TXBD_FLAGS_F;
> +
> +	tx_swbd->len = pad_len;
> +	tx_swbd->is_eof = true;
> +	tx_swbd->do_twostep_tstamp = false;
> +	tx_swbd->check_wb = false;
> +}
> +
>  static __wsum enetc_tso_hdr_csum(struct tso_t *tso, struct sk_buff *skb,
>  				 char *hdr, int hdr_len, int *l4_hdr_len)
>  {
> @@ -687,7 +703,8 @@ static int enetc_lso_count_descs(const struct sk_buff *skb)
>  
>  static int enetc_tso_count_descs(const struct sk_buff *skb)
>  {
> -	int count = tso_count_descs(skb);
> +	/* +gso_segs to cover one pad BD per segment */
> +	int count = tso_count_descs(skb) + skb_shinfo(skb)->gso_segs;
>  
>  	/* Each segment also needs an extension BD for VLAN insertion */
>  	if (skb_vlan_tag_present(skb))
> @@ -926,6 +943,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  	i = tx_ring->next_to_use;
>  
>  	while (total_len > 0) {
> +		int max_data_bds;
> +		int frm_len;
> +		int pad_len;
>  		char *hdr;
>  
>  		/* Get the BD */
> @@ -937,6 +957,12 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  		data_len = min_t(int, skb_shinfo(skb)->gso_size, total_len);
>  		total_len -= data_len;
>  
> +		/* Pad segments below ETH_ZLEN so the mEMAC does not pad them. */
> +		frm_len = max_t(int, hdr_len + data_len, ETH_ZLEN);
> +		pad_len = frm_len - (hdr_len + data_len);
> +		/* The pad BD counts towards the max chained BD limit */
> +		max_data_bds = priv->max_frags - !!pad_len;
> +
>  		/* prepare packet headers: MAC + IP + TCP */
>  		hdr = tx_ring->tso_headers + i * TSO_HEADER_SIZE;
>  		tso_build_hdr(skb, hdr, &tso, data_len, total_len == 0);
> @@ -944,7 +970,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  		/* compute the csum over the L4 header */
>  		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
>  		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd,
> -					      &i, hdr_len, data_len);
> +					      &i, hdr_len, data_len, frm_len);
>  		bd_data_num = 0;
>  
>  		while (data_len > 0) {
> @@ -966,8 +992,10 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  			csum = csum_block_add(csum, csum2, pos);
>  			pos += size;
>  
> +			/* When padding, the pad BD is the last one, not this */
>  			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
>  						    tso.data, size,
> +						    !pad_len &&
>  						    size == data_len);
>  			if (err) {
>  				if (i == 0)
> @@ -982,12 +1010,19 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  			bd_data_num++;
>  			tso_build_data(skb, &tso, size);
>  
> -			if (unlikely(bd_data_num >= priv->max_frags && data_len))
> +			if (unlikely(bd_data_num >= max_data_bds && data_len))
>  				goto err_chained_bd;
>  		}
>  
>  		enetc_tso_complete_csum(tx_ring, &tso, skb, hdr, pos, csum);
>  
> +		if (pad_len) {
> +			enetc_bdr_idx_inc(tx_ring, &i);
> +			enetc_append_tx_pad(tx_ring, i, pad_len);
> +			tx_swbd = &tx_ring->tx_swbd[i];
> +			count++;
> +		}
> +
>  		if (total_len == 0)
>  			tx_swbd->skb = skb;
>  
> @@ -1050,6 +1085,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  			enetc_unlock_mdio();
>  		}
>  	} else {
> +		if (eth_skb_pad(skb))
> +			return NETDEV_TX_OK;
> +
>  		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
>  			if (unlikely(skb_linearize(skb)))
>  				goto drop_packet_err;
> @@ -2285,8 +2323,18 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
>  		goto err_alloc_tso;
>  	}
>  
> +	res->tx_pad = dma_alloc_coherent(dev, ETH_ZLEN, &res->tx_pad_dma,
> +					 GFP_KERNEL);
> +	if (!res->tx_pad) {
> +		err = -ENOMEM;
> +		goto err_alloc_pad;
> +	}
> +
>  	return 0;
>  
> +err_alloc_pad:
> +	dma_free_coherent(dev, bd_count * TSO_HEADER_SIZE, res->tso_headers,
> +			  res->tso_headers_dma);
>  err_alloc_tso:
>  	enetc_dma_free_bdr(res);
>  err_alloc_bdr:
> @@ -2298,6 +2346,7 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
>  
>  static void enetc_free_tx_resource(const struct enetc_bdr_resource *res)
>  {
> +	dma_free_coherent(res->dev, ETH_ZLEN, res->tx_pad, res->tx_pad_dma);
>  	dma_free_coherent(res->dev, res->bd_count * TSO_HEADER_SIZE,
>  			  res->tso_headers, res->tso_headers_dma);
>  	enetc_dma_free_bdr(res);
> @@ -2425,6 +2474,8 @@ static void enetc_assign_tx_resource(struct enetc_bdr *tx_ring,
>  	tx_ring->tx_swbd = res ? res->tx_swbd : NULL;
>  	tx_ring->tso_headers = res ? res->tso_headers : NULL;
>  	tx_ring->tso_headers_dma = res ? res->tso_headers_dma : 0;
> +	tx_ring->tx_pad = res ? res->tx_pad : NULL;
> +	tx_ring->tx_pad_dma = res ? res->tx_pad_dma : 0;
>  }
>  
>  static void enetc_assign_rx_resource(struct enetc_bdr *rx_ring,
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index d9e91832a9c1..db3b3bad0f59 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -145,6 +145,8 @@ struct enetc_bdr_resource {
>  	};
>  	char *tso_headers;
>  	dma_addr_t tso_headers_dma;
> +	void *tx_pad;
> +	dma_addr_t tx_pad_dma;
>  };
>  
>  struct enetc_bdr {
> @@ -182,6 +184,10 @@ struct enetc_bdr {
>  	/* DMA buffer for TSO headers */
>  	char *tso_headers;
>  	dma_addr_t tso_headers_dma;
> +
> +	/* Shared read-only zero buffer to pad short frames to ETH_ZLEN */
> +	void *tx_pad;
> +	dma_addr_t tx_pad_dma;
>  } ____cacheline_aligned_in_smp;
>  
>  static inline void enetc_bdr_idx_inc(struct enetc_bdr *bdr, int *i)

