Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC13A4F47
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461536; cv=none; b=TDNCE0vYJoWO7s6hzvYDJ0zZQKZDsGqmo9/lUMLYFehBMXFzmEpFpJqqYZAVjDG6FvMaKHq+rgQUXP6RX/Av3cPCy8Vtu3kYibRC8cuLKzZj9Dnu83XEq8+U8F2gwE7uKnldR1ylNDEQ6Vgy2noIHI1kTpMGMAQ7Zn6qKueAjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461536; c=relaxed/simple;
	bh=PmAlNaVoW6WDiKOvty/3z/+Xv8BfHbEI30u3GF10bC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0n/jfvXl/vq17yL/iEcIwHC+IZwEujDrGnGJFT4rMHKxDU//bWJpwAZD5AU/bgdLX6uD9R0cwM6jDvvxULs9yVZF2yHwRCcCupMQr8y7eLeF/HakY9th3NKOw1JvgeXnSsQr5R5OSxZU7FIm7LbzYzf/b+rq1Q1ijmBvpOeB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+nte5ax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+nte5ax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789461533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ehSxidN9kKTCmVpgH+gSlUIAf/GxkvQJrzHZAwyKwo=;
	b=a+nte5ax8FPsj9czOR/q4XsuU1iTObWAIgqrC2EGcvCsO1NvQ0KRtMdXC9VP1XWKmptp60
	Xu/yUmTsR4KaZVoNHWmiOQzXSk6J798c+tbeVze5fmBAZJf8BlpT9XnVIZzRtkKta3s4Ql
	X5agh6aD6epSaYGhhqjiOo6oICTZNNU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-UXMCkD7lPY-rjKgFJ8dg1g-1; Tue,
 15 Sep 2026 04:38:51 -0400
X-MC-Unique: UXMCkD7lPY-rjKgFJ8dg1g-1
X-Mimecast-MFC-AGG-ID: UXMCkD7lPY-rjKgFJ8dg1g_1789461529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 388D11802159;
	Tue, 15 Sep 2026 08:38:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 184E9180025F;
	Tue, 15 Sep 2026 08:38:44 +0000 (UTC)
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
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on rejected timestamp requests
Date: Tue, 15 Sep 2026 10:38:39 +0200
Message-ID: <20260915083839.71546-1-pabeni@redhat.com>
In-Reply-To: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
References: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: macb: Preserve one-step mode on rejected timestamp requests

This moves the gem_ptp_set_one_step_sync() calls in gem_set_hwtst() out of
the tx_type switch and down past the rx_filter validation, so a request
rejected with -ERANGE no longer changes NCR.OSSMODE.  The cached
bp->tstamp_config and the TXBDCTRL/RXBDCTRL programming are unchanged.

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index e5195d7dac1d5..51659bbdfac9a 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -418,11 +418,9 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_TX_OFF:
>  		break;
>  	case HWTSTAMP_TX_ONESTEP_SYNC:
> -		gem_ptp_set_one_step_sync(bp, 1);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	case HWTSTAMP_TX_ON:
> -		gem_ptp_set_one_step_sync(bp, 0);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	default:
> @@ -460,6 +458,11 @@ int gem_set_hwtst(struct net_device *netdev,
>  		return -ERANGE;
>  	}
>  
> +	if (tstamp_config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
> +		gem_ptp_set_one_step_sync(bp, 1);
> +	else if (tstamp_config->tx_type == HWTSTAMP_TX_ON)
> +		gem_ptp_set_one_step_sync(bp, 0);
> +
>  	bp->tstamp_config = *tstamp_config;

[Severity: High]
Does this leave the same hardware/cache divergence reachable for the
HWTSTAMP_TX_OFF transition that the commit message sets out to remove?

Neither arm of the new conditional runs for HWTSTAMP_TX_OFF, but the next
statement caches the request unconditionally and the call after it programs
TXBDCTRL = TSTAMP_DISABLED:

	if (tstamp_config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
		gem_ptp_set_one_step_sync(bp, 1);
	else if (tstamp_config->tx_type == HWTSTAMP_TX_ON)
		gem_ptp_set_one_step_sync(bp, 0);

	bp->tstamp_config = *tstamp_config;

	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)

So for the sequence

  SIOCSHWTSTAMP{tx_type = HWTSTAMP_TX_ONESTEP_SYNC}   -> OSSMODE = 1
  SIOCSHWTSTAMP{tx_type = HWTSTAMP_TX_OFF}            -> returns 0

gem_get_hwtst() then reports HWTSTAMP_TX_OFF via

	*tstamp_config = bp->tstamp_config;

while gem_ptp_set_one_step_sync() in macb_ptp.c is the only writer of
MACB_BIT(OSSMODE) in the driver, so One Step Synchro Mode stays enabled in
NCR.  Does the MAC then keep rewriting the originTimestamp of transmitted
PTP Sync frames?  The driver assumes it does elsewhere, since
ptp_one_step_sync() in macb_main.c is used to suppress software FCS/CRC
insertion for exactly those frames.

Would an unconditional call be preferable to the two-arm conditional, for
example:

	gem_ptp_set_one_step_sync(bp,
				  tstamp_config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC);

[Severity: Medium]
This isn't a bug introduced by this patch, but while the call site is being
moved, is the read-modify-write inside gem_ptp_set_one_step_sync()
sufficiently serialized?

	reg_val = macb_readl(bp, NCR);

	if (enable)
		macb_writel(bp, NCR, reg_val | MACB_BIT(OSSMODE));
	else
		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));

The SRTSM update in the rx_filter switch of gem_set_hwtst() does the same
thing:

		regval = macb_readl(bp, NCR);
		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));

Both run from process context with BHs enabled and without bp->lock, while
other NCR updaters take bp->lock, for example macb_tx_restart() from
NAPI/softirq context:

	spin_lock(&bp->lock);
	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
	spin_unlock(&bp->lock);

and macb_tx_lpi_set(), which asserts it:

	lockdep_assert_held(&bp->lock);

	ncr = macb_readl(bp, NCR);

Can a concurrent locked writer's bit be lost if it lands between the
macb_readl() and macb_writel() here?  In the worst case the stale write-back
would drop MACB_BIT(RE) | MACB_BIT(TE) just restored by macb_mac_link_up(),
leaving RX/TX disabled while the stack considers the link up; more commonly
a TSTART or TXLPIEN update is lost.  The same unlocked pattern already
exists in macb_mac_link_up() after it releases bp->lock and in the RXUBR
errata path of macb_interrupt(), so this predates the patch, but would
wrapping both NCR read-modify-writes in gem_set_hwtst() with
spin_lock_irqsave(&bp->lock, ...) be the right direction?

[Severity: Low]
This is a pre-existing inconsistency rather than something this patch
introduces, but since gem_set_hwtst() is being touched: gem_get_ts_info()
in macb_main.c advertises only

	info->rx_filters =
		(1 << HWTSTAMP_FILTER_NONE) |
		(1 << HWTSTAMP_FILTER_ALL);

while the rx_filter switch in gem_set_hwtst() accepts the nine
HWTSTAMP_FILTER_PTP_V2_* values and reports back a filter the ts_info
bitmap says is unsupported:

		rx_bd_control =  TSTAMP_ALL_PTP_FRAMES;
		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;

Neither the legacy ioctl path via net_hwtstamp_validate() nor the ethtool
netlink tsconfig path checks the request against the driver's advertised
bitmap, so userspace can end up with an rx_filter value that is absent from
the supported set.  Should HWTSTAMP_FILTER_PTP_V2_EVENT be added to
info->rx_filters?

For reference, the related concern about HWTSTAMP_FILTER_PTP_V1_L4_SYNC and
HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ returning success while leaving
rx_bd_control at TSTAMP_DISABLED is addressed later in this series by "net:
macb: Use all-frame timestamping for PTPv1 RX filters", which folds both
cases into the TSTAMP_ALL_FRAMES arm.
-- 
This is an AI-generated review.

