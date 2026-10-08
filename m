Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BF2EA480;
	Thu,  8 Oct 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453836; cv=none; b=aOLPncfVboK2DGDPTntLA5Y5JmWkMQtTqMIYY2aZfUdID0LWwW6rKZW977BozhMcKdsMm91ptSEsWGyceptW1JiLIyp/4UYwcyOUdFjTz6I7snhnlu2G1+ILS1VaHNZIJQ8VOdlcfMtBX/vP+wTW/TpTUm8YreDiwSRgn+NrxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453836; c=relaxed/simple;
	bh=EZo6s7HVLiF7s8bmIx9ZlZPqM7/flU9zhaAArFo0uFg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uur/AQwEn/o0YKbg3etfLfITR2RaLTWZ7oaLWOAnzntV5tHypJoBDijWLyqi9Dpm7gNtF3ml/84wX7+MPLPtugx5dJQrv+0ETeZ45q9av9euw9Qmf/qAreKgBLY1xHbvspdZbAAHi40f1f8M786/lJh3Dq0nRJ44bZTrQBCr9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=OBCx53cH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="OBCx53cH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFA51A1545;
	Thu,  8 Oct 2026 12:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791453828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wCtM3TrL4p1c/kySAbEeTVfJHqoyHvR+bK3Vqjg3Y+4=;
	b=OBCx53cHpXK8zZyEBNytqH0KV7KYM4qlmepc5B4CSzfHQuPQZjYZPFj1lRBflXsNN5Pk5p
	WNLAXt5GhfQzJx0ZR3QtgQ6+J/GOTNyKvw5Sx9y/zsp9ZgtRbVdaPXLje/BbBGGVBTZ7ZV
	8xsMgVrvHI/HjvCjNMrGoXX3Zdqp6j9RwroyxdpqCl/jJ19lTtCYkXP1Tlj/OucVkDmCsR
	vHmUQX2zIyj27pdyy5RQMfvHCb7V4Kb3eqMyT6zbLOpbxFe8kIrbsA0t9/2JNGJB9L0nqY
	84TXyAOfcxO7VIMvz9/S0kkGYv+hSkafEXoMAEzcEJsJMPjErwJPP6sDEWW8pA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 12:03:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org, florian.fainelli@broadcom.com,
 justin.chen@broadcom.com
Cc: opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.stevenson@raspberrypi.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v3 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
In-Reply-To: <179145241435.434549.3651092628869076790@kernel.org>
References: <20261007-nb-genet-mtu-nn-v2-v3-6-74a796c019ce@tipi-net.de>
 <179145241435.434549.3651092628869076790@kernel.org>
Message-ID: <a4d4a29095a7b68ae2345d35074f6e2c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Clashiko

On 8.10.2026 11:40, netdev-bot+sashiko@kernel.org wrote:

> [...]

> [Severity: Medium]
> 
> What happens here when the GENET is the conduit for a DSA switch that
> uses a tail tag? By the time the skb reaches bcmgenet_xmit(), the 
> tagger
> has already written the tag into the last bytes of the frame. This
> skb_put_padto() then appends zeros after the tag.
> 
> The DSA core pads before tagging so that the conduit never has to add
> bytes after a tail tag:
> 
> net/dsa/user.c:dsa_user_xmit() {
>     ...
> 	if (dev->needed_tailroom)
> 		eth_skb_pad(skb);
>     ...
> }
> 
> For KSZ9477-class switches the tag holds the egress port mask, the
> priority, and the override bit for link-local frames:
> 
> net/dsa/tag_ksz.c:ksz9477_xmit() {
>     ...
> 	if (is_link_local_ether_addr(hdr->h_dest))
> 		val |= KSZ9477_TAIL_TAG_OVERRIDE;
> 
> 	*tag = cpu_to_be16(val);
>     ...
> }
> 
> lan937x_xmit() also always sets LAN937X_TAIL_TAG_VALID.
> 
> After padding, would the switch read an all-zero tag in place of these
> fields, with the real tag left inside the payload? HSR/PRP RCT trailers
> look like they would be corrupted the same way.
> 
> The commit message says these protocols "see the zeros instead". The
> switch, though, would read the zeros as forwarding instructions: no 
> port
> mask, no override bit and no valid bit. Depending on the switch, the
> frame could be dropped, forwarded by address lookup or flooded, 
> whatever
> egress port the host chose. That could break standalone port isolation,
> and link-local frames would lose their forced egress port.
> 
> This path opens up once later patches in the series raise max_mtu. If a
> user port MTU is raised above roughly 3806, dsa_user_change_mtu() calls
> dev_set_mtu(conduit, new_conduit_mtu), which moves the conduit into the
> MTU range that has the window. After that, whoever sends the traffic
> decides whether a frame lands in the window, for example through the 
> UDP
> datagram size, IP fragment tails, or forwarded traffic.
> 
> Instead of padding after the trailer, would it be safer to check
> netdev_uses_dsa() here and drop the frame? Another option would be to
> refuse conduit MTUs that reach the window.

I do not think genet is ever a DSA conduit with tail tags. At least none
of the boards I'm aware of + what appears in the tree...

Broadcom switches use a head tag, and genet already reserves
ENET_BRCM_TAG_LEN for it, so padding at the tail wont do any harm. On 
the
Broadcom SoCs that do have an integrated switch the conduit is 
SYSTEMPORT,
not genet, and that driver has the netdev_uses_dsa() checks.

Every tagger listed is a tail tagger for a switch family that is not 
paired
with genet. Reaching this would need an out of tree board wiring one 
behind
a genet SoC and raising the user port MTU past 3808 (not 3806)...

So I would keep the padding and the note in the commit message rather 
than
add a drop path for a configuration that does not exist?

The only other way (which I don't really like), would be to cap the MTU 
when
attached to dsa in _change_mtu():

	/* Padding a frame clear of the window would overwrite a DSA tail tag 
*/
	if (netdev_uses_dsa(dev) && new_mtu > ENET_MAX_PAD_FREE_MTU)
		return -EINVAL;

But if we do this, Clashiko would complain about the case where the dsa 
is
attached after the MTU is already set to something above the thresholds 
...

@Florian / Justin: Anything you are aware of in the stb universe?

Thanks,
Nicolai

