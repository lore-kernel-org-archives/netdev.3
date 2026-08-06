Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3303C98BF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013037; cv=none; b=TpwErFdgyIOoJo6kTLDTMBOZAAptjtCQAK4BlDu9Z77MAWRJYkTaJhHEqrMVXm3YRbnsJ3VCq7WNNBa6UPvQUA1mb/RtTDMalbdQQ2itIBylnmJjJLM/fZ09LKFWvGHQqs1CK5GNsDfwq/TOaptYrq8A6mHm7KkOc+NxYjHVU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013037; c=relaxed/simple;
	bh=toagF6wGDpgWgcJ1jXH04T+LY5W8YJa3OWyp3lAhKUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHysYJf1SnZM3uU+6RbL69lB7xKXSdv+10iSh14WWwKOZanDLkA/Bfqc37dKfv85uq4vVgDC9bAUJi5/X/HIr92CJLuM9b7mjw0i+B/eAluYCMUxweApPuaEYGazPycOTo8gWzUGk/SgCNdo2OFrQJ2NkOLV1IASmkYJJR5gDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JonjBtYg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JonjBtYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786013033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hODUFmD0fD3oJxenzooE0VB5ZkcG0vkeRE9JkV/fVdc=;
	b=JonjBtYgUZWeGWSTMFa1NtOagqFMWxel1972q0gwAfrdu9aq7+5Ja+IZMai4rVK7dh26qs
	4hOlbrEbJRtC6STE0KLogwGvs/jITgkdPgynzM9luCUvVRm+3KykuzhqzW09txz15wOPrD
	qs5cdCsIBUHGt5bhmXzwlUyo3zmBx4U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-OivDxvpiOYa_L-3r3bmT-g-1; Thu,
 06 Aug 2026 06:43:48 -0400
X-MC-Unique: OivDxvpiOYa_L-3r3bmT-g-1
X-Mimecast-MFC-AGG-ID: OivDxvpiOYa_L-3r3bmT-g_1786013026
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65FD01956089;
	Thu,  6 Aug 2026 10:43:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3786422;
	Thu,  6 Aug 2026 10:43:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Selvamani.Rajagopal@onsemi.com
Cc: parthiban.veerasooran@microchip.com,
	andrew+netdev@lunn.ch,
	pier.beruto@onsemi.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH net v5 3/4] net: ethernet: oa_tc6: Disable tx queues on fatal error
Date: Thu,  6 Aug 2026 12:43:40 +0200
Message-ID: <20260806104340.151169-1-pabeni@redhat.com>
In-Reply-To: <20260729-fix-race-condition-and-crash-v5-3-3906bc485daf@onsemi.com>
References: <20260729-fix-race-condition-and-crash-v5-3-3906bc485daf@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [3]: [PATCH net v5 3/4] net: ethernet: oa_tc6: Disable tx queues on fatal error ---
commit e2e6581c7bb33d3713f9dc8fab5b2d869c2c7d89
Author: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

net: ethernet: oa_tc6: Disable tx queues on fatal error

This adds a netif_tx_disable() call to oa_tc6_disable_traffic() so that
the TX queues are stopped when the disable_traffic flag is set, on the
grounds that there is no recovery from that state short of a driver
reload.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 421f72e6f71e3..bb644509c32b3 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -730,6 +730,10 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
>  	skb = oa_tc6_detach_waiting_tx_skb(tc6);
>  	spin_unlock_bh(&tc6->tx_skb_lock);
>  
> +	/* disable_traffic, when set, is a point of no return to working
> +	 * state. TX queues are disabled.
> +	 */
> +	netif_tx_disable(tc6->netdev);

[Severity: Medium]
[Finding: main-1-0]
[Sources: opus-5]
The comment describes this as "a point of no return to working state", but
netif_tx_disable() only sets the reversible per-queue __QUEUE_STATE_DRV_XOFF
bit.  Is that enough to make the state stick?

The only in-tree consumer clears it again on every open, without looking at
tc6->disable_traffic:

drivers/net/ethernet/microchip/lan865x/lan865x.c:lan865x_net_open() {
	ret = lan865x_hw_enable(priv);
	...
	phy_start(netdev->phydev);

	netif_start_queue(netdev);
}

So after oa_tc6_disable_traffic() runs, an ordinary

	ip link set dev X down
	ip link set dev X up

re-enables the queues, while tc6->disable_traffic stays true (it is only
ever set, never cleared), the SPI interrupt stays disabled by
disable_irq_nosync() in the threaded IRQ handler and INT_MASK0 masks all
device interrupts.  Frames then land in the pre-existing drop branch:

drivers/net/ethernet/oa_tc6.c:oa_tc6_start_xmit() {
	if (tc6->disable_traffic) {
		spin_unlock_bh(&tc6->tx_skb_lock);
		oa_tc6_drop_tx_skb(tc6, skb);
		return NETDEV_TX_OK;
	}
}

Is an interface that looks operational but silently swallows every frame the
intended end state here?

There is also an ordering aspect: oa_tc6_init() arms the threaded IRQ with
devm_request_threaded_irq() and then calls irq_wake_thread(), which happens
before the consumer's register_netdev() in lan865x_probe().  If a fatal
error is detected during that window, the queue disable is applied to a
netdev that has not been registered yet and is then undone by the first
open.  Would netif_device_detach(), netif_carrier_off(), or having ndo_open
consult the tc6 fatal state express this more durably, or should the comment
and commit message be reworded to match what the code actually does?

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]
A second question about the same call, regarding what userspace can observe.
The v4 changelog notes the carrier-off change was reverted, so the carrier
stays up while every txq has DRV_XOFF set.  With the queues stopped,
netif_xmit_stopped() is true and ndo_start_xmit is never called again, so the
per-frame accounting in the disable_traffic branch of oa_tc6_start_xmit():

	oa_tc6_drop_tx_skb(tc6, skb);	/* netdev->stats.tx_dropped++ */

becomes unreachable.  Packets are instead dropped at the qdisc, and qdisc
drops are not folded into rtnl_link_stats64.tx_dropped (only dev->stats and
dev->core_stats are; the enqueue-drop path only does qdisc_qstats_drop()).
Does that mean ip -s link reports zero errors and zero drops for a device
that is permanently dead?

lan865x_netdev_ops also registers no .ndo_tx_timeout:

drivers/net/ethernet/microchip/lan865x/lan865x.c:
static const struct net_device_ops lan865x_netdev_ops = {
	.ndo_open		= lan865x_net_open,
	.ndo_stop		= lan865x_net_close,
	.ndo_start_xmit		= lan865x_send_packet,
	...
};

so __netdev_watchdog_up() never arms dev_watchdog() and there is no
"transmit queue timed out" message either.  Link monitors and
carrier-driven aggregators such as bonding, team and bridge would still see
UP/LOWER_UP with no errors, and senders stall rather than getting drops.

Could the commit message document this loss of device-level drop accounting,
or could the dead state be made observable with netif_device_detach() /
netif_carrier_off() or another persistent error indication?
-- 
This is an AI-generated review.

