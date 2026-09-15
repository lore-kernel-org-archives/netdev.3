Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46E4A3D52
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461912; cv=none; b=TK+EIngjfcerq++6pQMBmOybzAeMbzg/vFxRRaZvlYv5DZAS3C33kBCJqb2dk257SmeP3spcseAf0Co6lrOrDb6PPPIoPaiFGs2DCkKhvz5y2QEMQr1VbrTmQLvthyqGR4zHS6eoTba0GTmNcLhiDPwl/ZiQPvNE4SSKkVIm/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461912; c=relaxed/simple;
	bh=n01FY5o+GO5C64Irv1p+UvT3ad9BDV2sd38DYKwHISw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbztKri8WfOk1juFl0K0x4dpZZtZkXsp/bGQVbCgDGZaEmgUar+DNbZSRqkJOPFITJq6GywLt44zsJ6cnyEhzchZN5+8PE04c4UbrrlT7GHPw+3+p0rEmsmx0P5C1jReSlRAp77ccRQJy4w+W/6JLMiKUclNl4J1CpBDHH8qkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDDzD06+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDDzD06+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789461908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7/oozdRrzfelXfsglh8Hfb9OORRp47+WOib7pc6U2g=;
	b=MDDzD06+X5PwG5sKUA22ZsQAoGlBh59fnw+TNAPvH9pDZmM0+n651EYtEIgNMietbdCjXI
	2SyMKZtm9rZOCldlGhVNazeZg5QS63aO7LX8YF0pi0Z2MmL81M+Y/aq+f9XJAVDW4Eyxsa
	9OH29jXRtS2Ewa+MI6XASrcBAsSB3F4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-7lU-r5hLP7C9T5ONUmjI3w-1; Tue,
 15 Sep 2026 04:45:05 -0400
X-MC-Unique: 7lU-r5hLP7C9T5ONUmjI3w-1
X-Mimecast-MFC-AGG-ID: 7lU-r5hLP7C9T5ONUmjI3w_1789461903
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B351955D69;
	Tue, 15 Sep 2026 08:45:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09093180049F;
	Tue, 15 Sep 2026 08:44:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net RESEND 2/2] net: macb: Use all-frame timestamping for PTPv1 RX filters
Date: Tue, 15 Sep 2026 10:38:49 +0200
Message-ID: <20260915083849.72030-1-pabeni@redhat.com>
In-Reply-To: <178911388671.25348.11008812384009904081.macb-resend-2@khu.ac.kr>
References: <178911388671.25348.11008812384009904081.macb-resend-2@khu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: macb: Use all-frame timestamping for PTPv1 RX filters

The two PTPv1 L4 filters used to be accepted by gem_set_hwtst() while
leaving rx_bd_control at TSTAMP_DISABLED, so receive timestamping ended up
off even though a nonempty filter was reported back. They are now folded
into the existing all-frame arm alongside HWTSTAMP_FILTER_PTP_V1_L4_EVENT,
which reports HWTSTAMP_FILTER_ALL.

No Link: tags in the commit header.

A few observations on the surrounding code in gem_set_hwtst(), all of them
about behaviour that predates this change.

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index 51659bbdfac9a..2ffc46b81264e 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -430,10 +430,6 @@ int gem_set_hwtst(struct net_device *netdev,
>  	switch (tstamp_config->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		break;
> -	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -		break;
> -	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> -		break;
>  	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:

[Severity: Medium]
This isn't a bug introduced by this patch, but while the new arm reports
HWTSTAMP_FILTER_ALL (which is advertised), the sibling PTPv2 arm right below
reports a filter value the driver never advertises:

drivers/net/ethernet/cadence/macb_main.c:gem_get_ts_info() {
	info->rx_filters =
		(1 << HWTSTAMP_FILTER_NONE) |
		(1 << HWTSTAMP_FILTER_ALL);
}

drivers/net/ethernet/cadence/macb_ptp.c:gem_set_hwtst() {
		rx_bd_control =  TSTAMP_ALL_PTP_FRAMES;
		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
}

That value is then stored in bp->tstamp_config and handed back by
gem_get_hwtst() on every later SIOCGHWTSTAMP, so ethtool -T and
SIOCGHWTSTAMP describe different capability sets. Should the PTPv2 arm
either report HWTSTAMP_FILTER_ALL too, or should gem_get_ts_info() advertise
HWTSTAMP_FILTER_PTP_V2_EVENT?

> @@ -448,6 +444,8 @@ int gem_set_hwtst(struct net_device *netdev,
>  		regval = macb_readl(bp, NCR);
>  		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));

[Severity: High]
This is a pre-existing issue and not something this patch introduces, but is
this read-modify-write of NCR safe without bp->lock? Every other NCR
read-modify-write in the driver is serialized, and macb_tx_lpi_set() even
states the rule:

drivers/net/ethernet/cadence/macb_main.c:macb_tx_lpi_set() {
	lockdep_assert_held(&bp->lock);

	ncr = macb_readl(bp, NCR);
	old = ncr;
	...
}

drivers/net/ethernet/cadence/macb_main.c:macb_start_xmit() {
	spin_lock(&bp->lock);
	macb_tx_lpi_wake(bp);
	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
	spin_unlock(&bp->lock);
}

gem_set_hwtst() runs under rtnl from ndo_hwtstamp_set, which does not
exclude the xmit path, the EEE LPI work, macb_mac_link_up(), or the hardirq
RXUBR workaround. Can the unlocked write back lose a bit another context
just set? For example the RXUBR errata path in macb_interrupt() toggles RE:

drivers/net/ethernet/cadence/macb_main.c:macb_interrupt() {
		ctrl = macb_readl(bp, NCR);
		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
		wmb();
		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
}

If gem_set_hwtst() samples NCR inside that window and then writes back with
RE cleared, does receive stay off until the next reconfiguration? The same
question applies to gem_ptp_set_one_step_sync(), which this function calls
for TX_ON and ONESTEP_SYNC, including for the two filters added here:

drivers/net/ethernet/cadence/macb_ptp.c:gem_ptp_set_one_step_sync() {
	reg_val = macb_readl(bp, NCR);

	if (enable)
		macb_writel(bp, NCR, reg_val | MACB_BIT(OSSMODE));
	else
		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));
}

Since the RXUBR handler runs in hardirq context, would the irqsave variant
of the lock be needed on the configuration side?

>  		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>  	case HWTSTAMP_FILTER_ALL:
>  		rx_bd_control = TSTAMP_ALL_FRAMES;

Two more items in the same function and driver, outside the hunks:

[Severity: Medium]
This is a pre-existing issue that this patch does not touch, but in
gem_set_hwtst() the HWTSTAMP_TX_OFF arm is a bare break:

	switch (tstamp_config->tx_type) {
	case HWTSTAMP_TX_OFF:
		break;
	case HWTSTAMP_TX_ONESTEP_SYNC:
		tx_bd_control = TSTAMP_ALL_FRAMES;
		break;

and OSSMODE is only touched for the other two values:

	if (tstamp_config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
		gem_ptp_set_one_step_sync(bp, 1);
	else if (tstamp_config->tx_type == HWTSTAMP_TX_ON)
		gem_ptp_set_one_step_sync(bp, 0);

After HWTSTAMP_TX_ONESTEP_SYNC followed by HWTSTAMP_TX_OFF, does NCR.OSSMODE
stay set so the MAC keeps rewriting originTimestamp in transmitted Sync
frames while SIOCGHWTSTAMP reports transmit timestamping as off? Should the
TX_OFF case call gem_ptp_set_one_step_sync(bp, 0) as well? The symmetric
case, NCR.SRTSM never being cleared when moving away from the PTPv2 arm,
looks like the same shape of problem.

[Severity: Medium]
Also pre-existing rather than something this patch changes: is the
timestamping configuration lost across suspend/resume? macb_resume()
rewrites NCR from scratch:

drivers/net/ethernet/cadence/macb_main.c:macb_resume() {
	macb_writel(bp, NCR, MACB_BIT(MPE));
	macb_init_hw(bp);
	macb_set_rx_mode(netdev);
	macb_restore_features(bp);
	...
}

which clears SRTSM and OSSMODE, and none of the callees reprogram the
descriptor capture registers. gem_ptp_set_ts_mode() is the only writer of
GEM_TXBDCTRL and GEM_RXBDCTRL:

drivers/net/ethernet/cadence/macb_ptp.c:gem_ptp_set_ts_mode() {
	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));
}

and it is reachable only from gem_set_hwtst(). Does that leave the hardware
at its reset default after resume while gem_get_hwtst() still reports the
pre-suspend filter, now including HWTSTAMP_FILTER_ALL for the two PTPv1
filters remapped here? Should the resume path replay bp->tstamp_config
through gem_ptp_set_ts_mode()?
-- 
This is an AI-generated review.

