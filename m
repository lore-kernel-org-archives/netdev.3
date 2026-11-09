Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267069;
	b=MueAhLie5sdfspjwLY2fOHUh6wAyqx3l28+hTgyEre/lJmGovLjL8ecP5HkmxZOmFxuc
	 jFN+ztXDDpc3KHgqqV+2Fs98d1HWJfs3GlLT26YYLagOhOdO8qeiCYzNyQmFJig7AYqND
	 bcbH4aABAGu0/d18mwAS1g00W29qHzjTOjBm9BmqcvX1UvmJQdmo6bhgg8NPkM4kiHuI3
	 of3/oDZltIGihg2eJZRcqVJFgQWC3K8TRMbP/YKfLbKlk1m+UdSBQXue7NObzMM7+bque
	 POk/S4wU9/uhNVj9YwL+Kh4HCCl27ssaXYsc5YwhENnt9xKKmdI006JMb5DcBftQWdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267069;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uu90JLzf6q6WA1nLCDfkETvyup9H36ekzosWSH+2F7s=;
	b=0keyw3alCIlb/QEmmIVomJHbtsIMZsvVmN/JSZPh2oJ1eWO3T1CMizU/ZZveQKTEPOyM
	 DANxkCkVa9epwuHd+uqKiwBQ3fPfwd2H1X+sFItck56KpQxwenDnSK1p4Ih5VnlOnUopk
	 cuMizGf9IlnO0yWcPh4i6Q5p9J/A+PFqUVtWPpmewP0WzMo2RJyhczowOdmFW1aEi2Dyu
	 a7gvJuwZHozLC3n4QvzdVFu5ujijuons11d8X+TTNgU5tUtEpWRjZtbQPr9Z5Sm13hMdo
	 QXr2ShO32xDVkYqW89i1sQRI2dyP10HE0gxl1tDgLiCyC34DeHycN/T/1DjMFnX5chA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdvUL99H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE87606A332;
	Mon,  9 Nov 2026 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdvUL99H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085EA1F008A2;
	Mon,  9 Nov 2026 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267068;
	bh=uu90JLzf6q6WA1nLCDfkETvyup9H36ekzosWSH+2F7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SdvUL99H1z6ifJXkEkWV65cq4B2Q8ofopqb3s46fkK5FIvm+oequp28P3qpWA1Y4n
	 KRPge3K0j9nugITJzuIvo4/E6OxeUU5rFeiSrajOoiv/KzMM5HGlp94VbloihWUWHk
	 ZzaNCAQdSusnNqTP+UazvBuKfJDi4F80rBIC8CWovE2pHuEr3grzzjJ/pZwdSsQS+w
	 6Rk8NPAMR18GODXs19DP33D2MrRTOcLL4jFr8+zj40mxxLRkC1En8nogfiKK6vcUcE
	 iYQPo1AAcFM0yqYaP/X/HzT4BkalyTqlro0AkaWWpevz1FNJ2K/Flp2/nCy9t6N9+v
	 P3j/T0p+H2M+Q==
Subject: Re: [PATCH net-next 4/6] eth: mpnic: UDP segmentation offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:31:07 +0000
Message-ID: <179426706758.994134.346895450294126427@kernel.org>
In-Reply-To: <20261106-mpnic-lso-v1-4-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-4-e943ff1493e4@gmail.com>
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

- [Medium] With this patch, mpnic_netdev_alloc() advertises
  NETIF_F_GSO_UDP_L4.

--

eth: mpnic: UDP segmentation offload

This commit adds UDP segmentation offload for non-encapsulated udp4/udp6
packets by advertising NETIF_F_GSO_UDP_L4. For GSO skbs, mpnic_tx_lso()
now seeds the UDP checksum with zero length, the same way it already does
for TCP.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> index 3a4aa5be57a19..83be45031a30b 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> @@ -331,7 +331,8 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
>  		NETIF_F_RXCSUM |
>  		NETIF_F_TSO |
>  		NETIF_F_TSO_ECN |
> -		NETIF_F_TSO6;
> +		NETIF_F_TSO6 |
> +		NETIF_F_GSO_UDP_L4;

[Severity: Medium]
Now that NETIF_F_GSO_UDP_L4 is advertised, can UDP GSO skbs shorter than
MPNIC_MIN_FRAME_LEN reach the hardware with the zero padding counted as
payload?

An unprivileged process can set UDP_SEGMENT with a small gso_size and
send a short datagram. For example, IPv4 with gso_size=1 and 2 bytes of
data makes udp_send_skb() build a GSO skb with gso_segs=2 and a 44 byte
frame (14 + 20 + 8 + 2).

mpnic_xmit_frame_ring() pads every skb, GSO or not, before the offload
setup runs:

drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:mpnic_xmit_frame_ring() {
    ...
	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
		goto err_drop;
    ...
}

The frame grows to 60 bytes. Then mpnic_tx_offloads()->mpnic_tx_lso() sets
MPNIC_TWD_FLAG_REQ_LSO with MSS=1 over a buffer that holds 18 bytes after
the 42 byte header, not 2.

If the segmentation engine works from the mapped length, would this send
18 one-byte datagrams instead of 2? 16 of them would be zero-filled and
delivered to the peer application.

That depends on whether the LSO engine uses the buffer length or the
IP/UDP length fields, and the driver source doesn't show which.

Even if the hardware ignores the padding, the accounting is still off.
MPNIC_XMIT_CB(skb)->bytecount, MPNIC_XMIT_CB(skb)->gso_segs and the
hw_gso_wire stat are all computed from shinfo->gso_segs. They won't match
the padded buffer the hardware is asked to segment.

Nothing appears to steer these skbs to software GSO. mpnic_features_check()
only checks an upper bound on gso_size:

drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:mpnic_features_check() {
    ...
	if (skb_is_gso(skb) &&
	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
		return features & ~NETIF_F_GSO_MASK;
    ...
}

In net/core/dev.c, gso_features_check() and gso_within_dev_limits() only
check gso_max_segs and gso_max_size.

Before this patch only TCP GSO reached the driver, and locally generated
TCP GSO frames are well over 60 bytes. The later patch in the series,
"eth: mpnic: add GSO_PARTIAL for other tunnels", still pads every skb and
doesn't add a minimum length check.

Would it make sense to skip the padding for GSO skbs? Another option is to
clear NETIF_F_GSO_MASK in mpnic_features_check() when skb->len is below
MPNIC_MIN_FRAME_LEN.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-mpnic-lso-v1-0-e943ff1493e4%40gmail.com
