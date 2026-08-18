Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995D4749E3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058890; cv=none; b=oGIAe4r0M1hgGBUw77Uh2M0CALYu6/WhJcA96SWuuv58UMMHcCuAqBtjF7C7vfilv52KrafKJ1tPVrvNhEQZlL1qT88lm96/XO0w5rDFEsSvJHu4zL1+4ov3qYA8C/Ilb4T8K97g78nvTFqgcNscW8cFBT1vufGZLeMbHt5FJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058890; c=relaxed/simple;
	bh=WadebybLTxKzX/uIT5WedFkmyLjxMr0EJ/AZX/VYYJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9k3Igwv3zCE2UqbgbvJjkSfAYLjv7uPXVnV0XoQI63PlOAxm0EjRSz23nn7cXZRNvFSg6pJMD0sqMrj8lK69GAwK9BbgHlY56C5HUSwXeAbHltxfl1fxxPclInDbixDV79WjFfeXdtqz8u+cbLRgfyUobgcg8pvXrgXCFbVBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeSdsSwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeSdsSwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787058887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EMroiaIUg48X32G2jLX20PAdLW3ke3zvDHklU3nEqQ=;
	b=JeSdsSwaLaCL8NXhsQOaqy+HU/5k43tyiiLGavaT5V9ZaWBiJ8sji2b6lEGJKcnt+r1513
	4ECesbaEhdyIvDqGIxrw/EAjFRfTRaV8GeVI+/wDmVYJ4k7s6LxaA5tZWQLB7pnPZeG2uQ
	dRrNfjCbD3oQ9yWentLSMNXFrgWEP1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-J3TBaDM3M-u5dNUhL5npJA-1; Tue,
 18 Aug 2026 09:14:32 -0400
X-MC-Unique: J3TBaDM3M-u5dNUhL5npJA-1
X-Mimecast-MFC-AGG-ID: J3TBaDM3M-u5dNUhL5npJA_1787058870
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F57A197701C;
	Tue, 18 Aug 2026 13:14:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95EC51944DCD;
	Tue, 18 Aug 2026 13:14:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: nwhitehorn@pa.msu.edu
Cc: netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org
Subject: Re: [PATCH net-next v5 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Tue, 18 Aug 2026 15:14:19 +0200
Message-ID: <20260818131419.191979-1-pabeni@redhat.com>
In-Reply-To: <20260813153705.23407-2-nwhitehorn@pa.msu.edu>
References: <20260813153705.23407-2-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: macb: Poll for link state changes when using the internal PCS.

This sets poll = true on the macb internal SGMII phylink PCS so phylink
arms its periodic link poll timer, letting link state changes be observed
at the PCS instead of at an onboard PHY (for example with an SFP).

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d394f1f43b685..c15a9c7e69d37 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
>  	struct macb *bp = netdev_priv(dev);
>  
>  	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
> +	bp->phylink_sgmii_pcs.poll = true;
>  	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;

[Severity: Low]
This isn't a bug introduced by this patch, but should phylink_usx_pcs also
get poll = true?  The commit message speaks generally about "an offboard
transceiver (e.g. an SFP)" and about polling "when the PCS is active", yet
only the SGMII PCS is updated.

macb_mac_select_pcs() returns &bp->phylink_usx_pcs for
PHY_INTERFACE_MODE_10GBASER, and phylink only arms the timer for the
currently selected PCS:

drivers/net/phy/phylink.c:phylink_pcs_poll_start() {
	if (pl->pcs && pl->pcs->poll && pl->cfg_link_an_mode == MLO_AN_INBAND)
		mod_timer(&pl->link_poll, jiffies + HZ);
}

PHY_INTERFACE_MODE_10GBASER is one of the modes accepted as in-band by
phylink_parse_mode(), so with managed = "in-band-status" the USX PCS ends up
in MLO_AN_INBAND but with poll == false.

macb_usx_pcs_get_state() is a pure register read:

	val = gem_readl(bp, USX_STATUS);
	state->link = !!(val & GEM_BIT(USX_BLOCK_LOCK));

and macb has no phylink_pcs_change()/phylink_mac_change() call anywhere, and
poll_fixed_state/get_fixed_state are only installed for SGMII.  Does that
mean USX_BLOCK_LOCK transitions are only sampled when something else (such
as an SFP loss-of-signal transition) forces a resolve?

The USX PCS behaves exactly as it did before this patch, so this is a
pre-existing gap rather than a new failure.  Could the commit message say
whether leaving the USX PCS unpolled is deliberate?

[Severity: Medium]
This is a pre-existing issue, but arming the poll timer adds one more
asynchronous context that touches the hardware, and macb_suspend() does not
stop phylink on the Wake-on-LAN path:

drivers/net/ethernet/cadence/macb_main.c:macb_suspend() {
	if (!(bp->wol & MACB_WOL_ENABLED)) {
		rtnl_lock();
		phylink_stop(bp->phylink);
		rtnl_unlock();
	...
}

phylink_suspend() is never called either, so with WoL enabled
pl->phylink_disable_state stays 0 and phylink_resolve() keeps running (clocks
stay on because macb_suspend() skips pm_runtime_force_suspend() when
device_may_wakeup() is true).

If the PCS link state changes after the WoL arming sequence, can the resolve
undo it?  macb_mac_link_down() clears the receive engine that magic-packet
and ARP wake detection rely on:

	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
	macb_writel(bp, NCR, ctrl);

and macb_mac_link_up() goes the other way, re-unmasking every queue while
NAPI is disabled and re-enabling RE|TE:

	queue_writel(queue, IER,
		     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
	...
	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

phylink_resolve() does not consult netif_device_present(), so nothing appears
to gate this against the suspended state.

The same 1 Hz poll already existed in the baseline for MLO_AN_FIXED SGMII:

	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
		bp->phylink_config.poll_fixed_state = true;
		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;

and phylink_phy_change()/phylink_sfp_link_down() can already drive a resolve
during a WoL-armed suspend, so this patch only adds another trigger for the
in-band SGMII case.  Would calling phylink_suspend() (or phylink_stop()) on
the WoL path in macb_suspend() be the right fix?
-- 
This is an AI-generated review.

