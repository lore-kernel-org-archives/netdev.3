Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D53126A0;
	Fri,  4 Sep 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482235; cv=none; b=aWqZZxELEgU2wUyU45IfNGcygzJB0MF0i75Ba6siv8uLexYTHXO4DUhK6Xz2xQeDqFExXUOrXK/MirNch1zR3dgpT46tDMvcGxeFEHVWbVoBn+oj9UMsnf/jj7U9z4L2HRbEyaTpb4G/rujY2yvdIHzgBTAAzkmHOYzKFAmPlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482235; c=relaxed/simple;
	bh=rxMHPAmCAEvl/uMEbtTwkQ8X0uIgPDvmAoT7QX05Hoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyM4IVotX/z//5AbfFJGWxNm0vcp3IiAb7g+B2OtMcQkON7EZ1PN2dgzqc9jlUIm90U135gioD+zwRRmaLGwh3Pt2u0oupfPMOwIze3uQPSnCIPPLmA85W70w9XOnTuIF/1AKU5H2Z0wXibZmEzRQrnIDD9LEPrZKrxgEKI7nPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqZOHtAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqZOHtAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C915F1F000E9;
	Fri,  4 Sep 2026 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482234;
	bh=PCqPYylojdkkJfDDfDSTr5k+f+4kMYWTMYRN76l4tKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqZOHtAW7dxLi3WnxB+E0L5jG84FB0+sgeh2pRn3L//yNKdh/a3JCqXcAU9QDEXu6
	 XOHZaCfGReAzz17+K//LvRDITXnXTxdG1u0JtAnSQkYljHibuVSElfMlm98RMp7CiC
	 YJRZ3vRcrwQ6NTqll6cjPB/g5jz2lQ79MMuS6E20GdZ/PVtRsmgm/XmA0JIQ8MeElX
	 X8Kay161hFsLXw10kWk5+HpwbUJPJbcJk/3FFh01mjPGHyyjgVdy6XFLTxyB+iHqtc
	 LETCMgFUqGspEcDIz6o905LPCbOrsQDoWBA+nAKQUwQ/Jk8sqfHLS7a5n1RcK5qTEe
	 IF07H2azGElBg==
From: Jakub Kicinski <kuba@kernel.org>
To: marex@nabladev.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	yiconghui@gmail.com,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v1] net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down
Date: Thu,  3 Sep 2026 17:37:12 -0700
Message-ID: <20260904003712.3484001-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901173925.96183-1-marex@nabladev.com>
References: <20260901173925.96183-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down

Per the KSZ8851 errata (DS80000716D, Module 3), a software power-down
followed by a power-on can leave the receiver circuit non-functional. This
patch implements the documented workaround by dropping both transitions into
PMECR_PM_SOFTDOWN, in ks8851_write_mac_addr() and ks8851_net_stop().

Link: https://ww1.microchip.com/downloads/en/DeviceDoc/80000716D.pdf

> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> index 4afbb40bc0e4a..cd8dfca22720b 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -143,9 +143,6 @@ static int ks8851_write_mac_addr(struct net_device *dev)
>  		ks8851_wrreg16(ks, KS_MAR(i), val);
>  	}
>  
> -	if (!netif_running(dev))
> -		ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
> -
>  	ks8851_unlock(ks);
>  
>  	return 0;

[Severity: Low]
This isn't a bug, but should the two comments describing the software
power-down state be updated in the same patch?

After this hunk, ks8851_write_mac_addr() still carries this comment above
its remaining ks8851_set_powermode() call:

	/*
	 * Wake up chip in case it was powered off when stopped; otherwise,
	 * the first write to the MAC address does not take effect.
	 */
	ks8851_set_powermode(ks, PMECR_PM_NORMAL);

Nothing in the driver can put the chip into software power-down anymore, so
the "in case it was powered off when stopped" precondition can no longer
occur. A grep of the tree confirms PMECR_PM_SOFTDOWN has no users left,
only its definition in ks8851.h, and the two remaining
ks8851_set_powermode() call sites in ks8851_write_mac_addr() and
ks8851_net_start() both write PMECR_PM_NORMAL.

Since the commit message uses that very call site as the argument that
dropping the power-down here is safe, would it help to note in the comment
that the PM_NORMAL write is kept deliberately (e.g. referencing the errata),
so a later cleanup does not remove it or reintroduce the SOFTDOWN
transition?

> @@ -506,8 +503,6 @@ static int ks8851_net_stop(struct net_device *dev)
>  	/* shutdown TX process */
>  	ks8851_wrreg16(ks, KS_TXCR, 0x0000);
>  
> -	/* set powermode to soft power down to save power */
> -	ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
>  	ks8851_unlock(ks);

[Severity: Low]
Related to the above: the kernel-doc for ks8851_net_stop() just above this
function still promises the low power transition that is being removed here:

	/**
	 * ks8851_net_stop - close network device
	 * @dev: The device being closed.
	 *
	 * Called to close down a network device which has been active. Cancel any
	 * work, shutdown the RX and TX process and then place the chip into a low
	 * power state whilst it is not being used.
	 */

The post-patch body only masks IER/ISR, zeroes RXCR1/TXCR, drains ks->txq
and calls free_irq(), with no PMECR access left. Should that last sentence
be dropped or reworded to mention the errata, so readers of
ks8851_suspend()->ks8851_net_stop() are not told a low power transition
happens?
-- 
pw-bot: cr
