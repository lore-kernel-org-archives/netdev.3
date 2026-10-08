Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95B47D477;
	Thu,  8 Oct 2026 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452417; cv=none; b=m7EG9jutHrbfyzqPCdVTpA5g/zE4VXkc7+nGzGVYxfbXGySRD/q0hXheNLX2a0QEO2RyLwfxGX2wOoZP2btRAb0Oy3QB8vAGfrGqiu8ZOEY7vYKZUIQw+v4ErO2NIfyd0KlRT+ozRB6SFOe3L8uDJ6Zf5WnXxq7ycmHMyZMEF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452417; c=relaxed/simple;
	bh=/MxfPTNzQ7r7Rak+uLL0rYxFu+P+OADBjczhqv+99IY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzrSiRIxvVApVb7X53VKNsIChFkWwK7OwYR3gDlqveLCiNANuhGISxDVCvnq5MrwhqueDulLYvqorDNWx6NczDdtzwRkpl8LgcNLOJs6x7mB93L6Ij5lQu7Rn5REzoWbU+cOTTjg8ozT5TDAAoR++8nK6y8Iv070MTnB0NjGi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7whQAW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7whQAW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5251F00893;
	Thu,  8 Oct 2026 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791452415;
	bh=da5K52sQCw+Wj6QVlsFLkEn9GQr3SSszWxbYORTZG0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z7whQAW8INUC5Cu75y8hK2qEb3GuKt6fgxl7vFWNuQaQ15Ikj23kByDwupW6Q15jU
	 5SQ+M2laFUKT3773ovHba4S25MB+/ClEDTdJgZCppu/gDqCiWVK/j1bKgMLm9Q4Uys
	 HdCpAeQBcR2P8lpKDS7h7QKX6PRXrMYufEdMhrvc+484Mk8wzskYPDNWnbwgjW3L1x
	 zGvLWPvMoQK9rFI6rHqtGrLb+toILH7v+LY0dtPYhY8wXQm/Y77Odv6LS6XTfgSXKD
	 StMeG+rMKQU3uLOr2nss07716sI9GFyBAwQZJQK6ZMYJeV1SO9xd5Z1eJwZqjWiFgu
	 QOmT9T2NXeLiQ==
Subject: Re: [PATCH net-next v3 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Thu, 08 Oct 2026 09:40:14 +0000
Message-ID: <179145241435.434549.3651092628869076790@kernel.org>
In-Reply-To: <20261007-nb-genet-mtu-nn-v2-v3-6-74a796c019ce@tipi-net.de>
References: <20261007-nb-genet-mtu-nn-v2-v3-6-74a796c019ce@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bcmgenet_xmit()
  (drivers/net/ethernet/broadcom/genet/bcmgenet.c), any frame whose…
- [Low] The commit message describes the transmit stall (Tx DMA will not
  halt, bcmgenet_init_dma() fails, the interface cannot be reopened) as…

--

net: bcmgenet: pad transmit frames out of the packet ready window

This patch picks a lower transmit packet ready threshold for MTUs where
the longest frame would end just past it. It pads frames that end within
64 bytes past the threshold so they clear the window. Frames longer than
the threshold that ask for checksum offload get their checksum computed
in software.

> A frame that ends a few bytes past the transmit packet ready threshold
> stops the transmitter as soon as a shorter frame follows. Tx DMA then
> refuses to halt, so every later bcmgenet_init_dma() fails and the interface
> cannot be opened again.

[Severity: Low]

Can this stall happen at this commit? genet does not set max_mtu or
provide ndo_change_mtu yet, so the MTU stays capped at the ether_setup()
default:

net/ethernet/eth.c:ether_setup() {
    ...
	dev->max_mtu		= ETH_DATA_LEN;
    ...
}

With an MTU of 1500, ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN stays well
below 3840. bcmgenet_tx_pkt_rdy_thld() therefore returns ENET_THLD_MAX
and tx_thld_len is 3840. Neither new branch in bcmgenet_xmit() can then
be reached.

The message does say "Nothing below an MTU of 3809 is affected". The new
code only becomes reachable with the later "net: bcmgenet: allow the MTU
to be changed" patch.

Could the message say that nothing reaches this code until the MTU limit
is raised later in the series?

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 4a4b0c46f8986..17c8318c20388 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2176,6 +2181,29 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto out;
>  	}
>  

[ ... ]

> +	/* Keep the frame out of the window just past the threshold */
> +	if (unlikely(skb->len > priv->tx_thld_len &&
> +		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
> +		if (skb_put_padto(skb, priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			goto drop;
> +		}
> +	}

[Severity: Medium]

What happens here when the GENET is the conduit for a DSA switch that
uses a tail tag? By the time the skb reaches bcmgenet_xmit(), the tagger
has already written the tag into the last bytes of the frame. This
skb_put_padto() then appends zeros after the tag.

The DSA core pads before tagging so that the conduit never has to add
bytes after a tail tag:

net/dsa/user.c:dsa_user_xmit() {
    ...
	if (dev->needed_tailroom)
		eth_skb_pad(skb);
    ...
}

For KSZ9477-class switches the tag holds the egress port mask, the
priority, and the override bit for link-local frames:

net/dsa/tag_ksz.c:ksz9477_xmit() {
    ...
	if (is_link_local_ether_addr(hdr->h_dest))
		val |= KSZ9477_TAIL_TAG_OVERRIDE;

	*tag = cpu_to_be16(val);
    ...
}

lan937x_xmit() also always sets LAN937X_TAIL_TAG_VALID.

After padding, would the switch read an all-zero tag in place of these
fields, with the real tag left inside the payload? HSR/PRP RCT trailers
look like they would be corrupted the same way.

The commit message says these protocols "see the zeros instead". The
switch, though, would read the zeros as forwarding instructions: no port
mask, no override bit and no valid bit. Depending on the switch, the
frame could be dropped, forwarded by address lookup or flooded, whatever
egress port the host chose. That could break standalone port isolation,
and link-local frames would lose their forced egress port.

This path opens up once later patches in the series raise max_mtu. If a
user port MTU is raised above roughly 3806, dsa_user_change_mtu() calls
dev_set_mtu(conduit, new_conduit_mtu), which moves the conduit into the
MTU range that has the window. After that, whoever sends the traffic
decides whether a frame lands in the window, for example through the UDP
datagram size, IP fragment tails, or forwarded traffic.

Instead of padding after the trailer, would it be safer to check
netdev_uses_dsa() here and drop the frame? Another option would be to
refuse conduit MTUs that reach the window.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce%40tipi-net.de
