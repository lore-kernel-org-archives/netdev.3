Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478138;
	b=lYEpKHgNAfcEdZeVyywcpwHT1YFSaXqX5p0VLOw0045BkfYUiH+0laNF3YglQv2zY7ei
	 /czVF3mPFm/sqWqtg5N1RC5J3GHTxGVh7B+wMkWUWQK4HV3o8FxrVtR4kw+TQSXIAr5jZ
	 V6VVy/e7cOjZ6aDng8DQBQiWoMJ/PQbgHJwx+HBZ8lt3Erw0qqEa7AOyECii9vzTIxH5F
	 bAdMilqSPZydf6tbu71bJiEdZnTCAIcjMZrL7VLh/yGIiyymNIw44n+iBWn1Hxk9hZAm+
	 7Wmk+TM8/6X9IRtlC0Gc8qQvNOsX3oWZ/mtUxiS1nMxIZhFuINVVzOeARDa74swxO8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478138;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=c3Uerz6NVXCytr6ykqOceV0YspUsXoDMSUv7FULrkyw=;
	b=w3ph0eKShvgJWfReOpIUMoWNfQRHyXk3tfu0x1DSgIrKxHwwW7B/f/iuzomPG6jwNws7
	 TjUWfz9ehwcbEnZ1dneFsYb1rkVNdMDTOGiVjRrHPCM4AsYW+WcOTCineN8QRzhZs6sdg
	 jT7uJ2whRCize0pTGatupsI8Cn4yf4uiCLreX0ZB9CVQ9IiZDag1lwxpytdvtgWk5WTl4
	 fkohm6gftEwNihZqgxu+WLNWXj+aakP6ZAIEFwqbhiLjB7PXwyk4y2xhWQ4B/RrPMnJFf
	 sOMZedRamPM+X98H2FynuGEC8vdI/4hVD4ypiJY/UAW9Mu0c4AHsd3N8bhBMjlSe+1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GypQxgVu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA12606A895;
	Thu, 12 Nov 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GypQxgVu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C951F00A07;
	Thu, 12 Nov 2026 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478138;
	bh=c3Uerz6NVXCytr6ykqOceV0YspUsXoDMSUv7FULrkyw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GypQxgVuK7RYKnec/3ahLhDPgn7nqYKDh0Kg3WWvfwCVdQUGd3h3voj2frxlM+6Qi
	 z3NI/dAQWtQJ8mKUNDVKBmYVvmGaRYeybH362jCeh6CuxooymGb2iEo/Zd69cf87Fh
	 hxnJ/BRIlV7HkIFy2VuGprKduVtpzo5bP7tNaY3yrTvqh7zUfaRNBiy40ykDX/spfs
	 mIuK6EH1gEzTZYxnUwvFyqqDEfV2fLut+4IqbbqkkCm9wnRNEPCastwFaVqmxtSVWc
	 biYCEr4Ta9+RTto73oyIKxtZ/JtpVs1jA20u3nnwn9VNQjzvIz2HV7GP+fePxQR5Fg
	 RiA6AUIfPOpgA==
Subject: Re: [PATCH net-next v2 4/6] eth: mpnic: UDP segmentation offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 10:08:57 +0000
Message-ID: <179447813712.2199510.12165491734923049464@kernel.org>
In-Reply-To: <20261110-mpnic-lso-v2-4-ccd37b051d08@gmail.com>
References: <20261110-mpnic-lso-v2-4-ccd37b051d08@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds `skb->len < MPNIC_MIN_FRAME_LEN ||` to the
  generic `skb_is_gso(skb)` branch of mpnic_features_check()…

--

eth: mpnic: UDP segmentation offload

This commit adds NETIF_F_GSO_UDP_L4 support for non-encapsulated udp4
and udp6 packets. As for TCP, the UDP checksum is seeded with a zero
length. It also makes mpnic_features_check() fall back to software GSO
for skbs shorter than MPNIC_MIN_FRAME_LEN.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index b78f8599bbe8f..2a0560b7dd19e 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -369,7 +384,8 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
>  		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>  
>  	if (skb_is_gso(skb) &&
> -	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
> +	    (skb->len < MPNIC_MIN_FRAME_LEN ||
> +	     !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size)))
>  		return features & ~NETIF_F_GSO_MASK;

[Severity: Medium]
This check applies to every GSO type. That means TCP GSO skbs shorter
than 60 bytes now fall back to software GSO too, not just UDP ones.

The commit message body only talks about UDP. The only mention of this
check is the v2 changelog below the "---", and that text is dropped when
the patch is applied:

  v2:
  - fall back to SW GSO for skbs shorter than MPNIC_MIN_FRAME_LEN, since
    HW LSO would segment the zero padding as payload

Should the commit message describe the effect on TCP? Or should the
check move into the earlier "eth: mpnic: TCP segmentation offload"
patch?

With only the TSO patch applied, TCP seems to have the same problem. In
that version, mpnic_features_check() rejected GSO only when gso_size
didn't fit MPNIC_TWD_MSS. So a short TCP GSO skb reaches
mpnic_xmit_frame_ring() with HW TSO enabled, and gets padded first:

drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:mpnic_xmit_frame_ring() {
    ...
	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
		goto err_drop;
    ...
}

Then mpnic_tx_lso() seeds the TCP pseudo-checksum from the padded
length:

	payload_len = cpu_to_be16(skb->len - skb_checksum_start_offset(skb));
	csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);

Locally generated TCP GSO skbs are always longer than 60 bytes. A GSO
skb built from a virtio_net_hdr can be shorter, though. Sources include
tun/vhost and packet sockets with a vnet header. Such an skb can carry
a tiny gso_size and only a few bytes of payload.

In that case, wouldn't the receiver get the zero padding as TCP stream
data, with a valid checksum?

The check is still present at the end of the series, so the final tree
is fine. The TSO commit on its own would still corrupt data if someone
bisects to it or backports it alone.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-mpnic-lso-v2-0-ccd37b051d08%40gmail.com
