Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F10392C2E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029719; cv=none; b=q8S+bCaS5l1FxXTvYCfXLt+PUOVmwPjt4FDL/HIHK3mLUmCnNzVbZBb60LrzA6QN3BxRQ5w1WVw18H4Td4RZr/Gir2rxDItsphdh+YEVTkuj6eGk3+6qhI0yiJ80fzFH0uh0Posku9Qu7unY0vTFCtcI/f5L2+xNOlvRN1WXiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029719; c=relaxed/simple;
	bh=n4enrZ+FQ6c91GJdKRJXIiZhgN0WZL5FQLw0AsNr0Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKfVZjKyjdZ3mn/KwqFlKLjPwZckwubtyMUgLPwRCP3PrUvhQMgxkoHgbxvfu7ycNj2ayH8zyKDbrnCadqdBIEwNNk+NoiFGPdT6WIV0vrol82VjKIKLmn3BZfRNnpTA5sr0S6IlhmdpV/ApJ5MLpN8ihR9UW3gZsYixwrsZEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZCPN7cms; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZCPN7cms"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u9sTS/COQK0TNP+zdsgEfylJgdDenBDQ3tXHsCk89OQ=; b=ZCPN7cmsYrI8trnhdkfyXbxopZ
	+aHMkjP6AfRWOQe2Xw3sbdtGMlMbYuJ8CldyvWgPlcif9xqKBPVPUgsywG98M+j7zR8Z682RpGRCM
	XzKxi4+eAuJDIc3ZulZQQE2vO+2QkETkhT/iYknkjoEmB2dMvhuAU7wk6MV63PPbBEpcCXrHwST+p
	65N/CKRLXwuuDVoKt4slKQmxziIpxker+IYtMiJK2nUYMmuYxPxmbGzKVbPfEnZyTHdoT1MxFcHBw
	PdaKcSRIYFX87btRV53rBk+Z68jm+4tBwRmQa7zZQGcDsl3nghFUuGFgrj3ay7TmwVB2WQTTA5Ump
	5edXpufQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvFsI-000000006nJ-3keZ;
	Wed, 25 Feb 2026 14:28:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvFsF-00000000116-3bDX;
	Wed, 25 Feb 2026 14:28:23 +0000
Date: Wed, 25 Feb 2026 14:28:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix .ndo_fix_features()
Message-ID: <aZ8HB-xu9KzYPHdc@shell.armlinux.org.uk>
References: <E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk>
 <20260224173037.7871e5ac@kernel.org>
 <aZ6xqig4zh_Un8R7@shell.armlinux.org.uk>
 <af465a47-264f-4029-943a-fd4222092f9d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af465a47-264f-4029-943a-fd4222092f9d@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 25, 2026 at 02:26:42PM +0100, Andrew Lunn wrote:
> > Then, looking at the "Enable TSO" block of code in stmmac_hw_setup(),
> > it looks to me like we can end up with some queues that have TSO
> > enabled, and others which don't (because TBS has been enabled on the
> > queue.) As far as I'm aware, the network layer doesn't support
> > per-queue TSO.
> 
> There is a software implementation of TSO. See for example:
> 
> commit 3ae8f4e0b98b640aadf410c21185ccb6b5b02351
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Mon May 19 14:00:00 2014 -0300
> 
>     net: mv643xx_eth: Implement software TSO
> 
> You might be able to use this to fill in the gaps.

That'll likely need some major rework to the descriptor handling, which
is also buggy, certainly in the non-TSO path.

stmmac_xmit() does this:

        if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
                if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
                        netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
                                                                queue));
                        /* This is a hard error, log it. */
                        netdev_err(priv->dev,
                                   "%s: Tx Ring full when queue awake\n",
                                   __func__);
                }
                return NETDEV_TX_BUSY;
        }

Then it sets the descriptors, which are consumed as per:

- 1 descriptor if priv->dma_cap.vlins && skb has a vlan
- for non-jumbo:
  - 1 descriptor for skb head (with sarc & tbs)
- for jumbo:
  - if headlen > 8KiB:
    - 1 descriptor for first bmax (2 or 8 KiB) of skb head
        (sets buffer2 of descriptor to data + 4KiB)
    - 1 descriptor for remainder of skb head
        (sets buffer2 of descriptor to data + 4KiB)
  - otherwise:
    - 1 descriptor for skb head
        (sets buffer2 of descriptor to data + 4KiB)
- 1 descriptor per skb fragment

So, the number of descriptors used is 1 + nfrags + overhead, where
overhead is:

overhead += 1 if jumbo > 8KiB is supported
overhead += 1 if priv->dma_cap.vlins

To put it another way:
- if we have a non-jumbo non-vlan skb, then 1 + nfrags descriptors will
  be used.
- if we have a jumbo vlan skb, then 3 + nfrags descriptors will be
  used.

However, the decision to stop the queue is:

        if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
                netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
                          __func__);
                netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
        }

So it doesn't account for the extra descriptor for vlan insertion, nor
does it account for the extra descriptor for a jumbo frame.

In the existing TSO path, the same problem exists - its the same check
for the last test, although the first test is different:

        /* Desc availability based on threshold should be enough safe */
        if (unlikely(stmmac_tx_avail(priv, queue) <
                (((skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1)))) {

This doesn't deal with vlan insertion by the hardware, nor I think
jumbo frames (I may be wrong on that) but it does use an extra
descriptor each time the MSS (as the driver calls it, actually
skb_shinfo(skb)->gso_size) changes on this specific queue. So, it
can be one extra descriptor on top of that +1 above.

The implications of this is that if the descriptors are almost full,
there is the possibility to overwrite the tail descriptor (that the
hardware has yet to process) as, when setting up the descriptors,
the insertion index is merely incremented, and not individually
checked to see whether it's caught up with the tail.

I think the only thing which saves the driver from this is that the
transmit descriptor ring is large (512 entries by default) and
probably never fills up in a way that we hit the boundary condition
that allows descriptor overwrite to occur. However, there is this
comment:

/* TX and RX Descriptor Length, these need to be power of two.
 * TX descriptor length less than 64 may cause transmit queue timed out error.
 * RX descriptor length less than 64 may cause inconsistent Rx chain error.
 */
in drivers/net/ethernet/stmicro/stmmac/common.h, which hints at the
problem here: if we do overflow the tail, the hardware may have already
processed that descriptor, but we haven't yet reaped it. The driver
will be expecting to write to the following descriptor. However, when
we real the tail, the driver will clear it. This results in following
packets being added after a descriptor with the hardware OWN bit clear,
so transmission will stop when the hardware gets to that descriptor,
eventually causing a transmit timeout.

With this driver, it's really a case of "which of its many problems
do we address first" because the more I look at it, the more problems
I'm finding.

The next problem which can be seen in my analysis of the descriptor
usage is - take a close look at the jumbo processing. In some
configurations, the length fields are 11 bits. The jumbo code seems
to know this because it calculates bmax accordingly. However, the
rest of the code just assumes that - even though we can only describe
up to 2KiB (actually 4KiB-1) bytes in the length field and it limits
the length of the first descriptor to that, it then promptly maps the
bytes from 4KiB to the total length to the second buffer in the
descriptor. What happens to the 2KiB..4KiB part of the data in this
case?!?!

I have a huge pile of cleanups to this driver that have helped to
uncover these problems by making the code more readable than it
currently is - and one of the problems is, I'm generating cleanups
and finding problems faster than I can get the changes merged.

During the last cycle, I tried to avoid adding to my set of patches
for this driver during the -rc phase. That hasn't helped. It also
meant that I didn't get any chance to post much else, such as the
Marvell PTP changes.

I was thinking that, when I get stmmac's phylink mess sorted out,
(essentially a few more patches beyond the part 3 RFC I posted today)
I'll stop hacking on stmmac, but stmmac just seems to be far too
broken. It needs someone to be a proper maintainer, someone who is
prepared to say "no" to patches that increase the messy complexity in
the driver that I think has led to a lot of these problems... to say
no to patches that introduce e.g. TBS without first thinking about
its interaction with TSO and whether the upper networking layers can
cope with some but not all queues being TSO capable... etc.

I do feel that, having got involved with stmmac to try and sort out
its bloody abuse of phylink, it's now become a huge mill stone, and
I don't have time to look at phylink / sfp related stuff (which is
why I've hardly been able to look at Maxime's patches.)

Can't we just delete stmmac to put it out of its misery? :D

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
