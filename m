Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C329A9C3;
	Tue, 15 Sep 2026 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437279; cv=none; b=Dj8f4ymvORFpohQplD9l7V9jcoQX2Bb8So8rgoNMGvMXnm1j2+hc6lENSjwKHKT23Ips2ZDaioHFc9YhwmpGVItNJqOiPyqpmarh4EwFKPrrEjlN2gO76TF8cTHFdkaLt0NU30yaQ7uXvW4F6llKztm79j6SzTrWAdxOm/kxIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437279; c=relaxed/simple;
	bh=gSRSJda7wdgVn5vHA2nhbRUQh2MkD3agL0szSPYT5Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DygWF8iMw5F90A8tg65oBDghQEFs98+KXPetD/TNmqjw4TA58u55DY1auIq8vmqFRIPXR0fqVV9xYTAge+vtG8nPjlr0UScSQa59pO5BiTPWH6QK7TNE094C9fYpG/iu+I/zj466//ygFbAzJJ5s73MKzDJwqi7wmUCFlSCisD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu0ePUUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu0ePUUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD861F00893;
	Tue, 15 Sep 2026 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437277;
	bh=1hOHwSt35CcKU6U5ea7zrEqqqsf03QE6WmlOFPAUaXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mu0ePUUJpzmPpX2DgEm3VsKmhqpKzwWzsB729yJ3f4h8D/SGGs+kO2M6GYvyjq4nT
	 wbuYI3PyJoYqacqKPryNAmt8QF/+HBKOTBzrBle2d5zCUY9JimiQkRfzjcXaTe+cPy
	 9VqRDfbWPqIHi10QtwkaSw6ibVoOoeP2QuNcq4QZVRh8FtA0YzCL/3ZB/4oOYFx8cF
	 HRXnt1JHEx0bkbNhVBMvHg4ELFD6JMlb3GphjnECl1nUht0cYvNHWql1G7IZOm6oDb
	 EzlmsIc7f/nOnvEgEvqhSsMmE+b+zXQcLoPxZP9OClnow7pZsIxdfr5V0TfYYLYDhy
	 eh2Smb7k1XUbA==
From: Jakub Kicinski <kuba@kernel.org>
To: niklas.soderlund+renesas@ragnatech.se
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@pbarker.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/10] net: ethernet: ravb: Move programming of gPTP timer interval
Date: Mon, 14 Sep 2026 18:54:36 -0700
Message-ID: <20260915015436.881118-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-3-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-3-niklas.soderlund+renesas@ragnatech.se>
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
net: ethernet: ravb: Move programming of gPTP timer interval

This moves the GTI write and the GCCR.LTI load request out of
ravb_set_gti() in the main driver logic and into ravb_ptp_init(), so the
programming happens under priv->lock.  ravb_ptp_init() now also seeds
priv->ptp.default_addend from priv->gti_tiv instead of reading GTI back
from the hardware.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 36173a09e2fd..a89f6fe7866f 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1846,20 +1846,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
>  	return error;
>  }
>  
> -static void ravb_set_gti(struct net_device *ndev)
> -{
> -	struct ravb_private *priv = netdev_priv(ndev);
> -	const struct ravb_hw_info *info = priv->info;
> -
> -	if (!(info->gptp || info->ccc_gac))
> -		return;
> -
> -	ravb_write(ndev, priv->gti_tiv, GTI);
> -
> -	/* Request GTI loading */
> -	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> -}
> -

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 43218bc15b15..157fb78209c7 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -321,11 +321,20 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
>  
>  	priv->ptp.info = ravb_ptp_info;
>  
> -	priv->ptp.default_addend = ravb_read(ndev, GTI);
> +	priv->ptp.default_addend = priv->gti_tiv;
>  	priv->ptp.current_addend = priv->ptp.default_addend;
>  
>  	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* Set gPTP Timer Increment Value. */
> +	ravb_write(ndev, priv->ptp.default_addend, GTI);
> +
> +	/* Request GTI loading. */
> +	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +
> +	/* Wait for GIT loading to complete. */
>  	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
> +
>  	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);

[Severity: Medium]
Does this ravb_wait() actually observe the GTI load?  The load request is
GCCR.LTI, but the poll masks GCCR.TCR, and those are separate fields in
ravb.h:

	GCCR_TCR	= 0x00000003,
	GCCR_TCR_NOREQ	= 0x00000000, /* No request */
	GCCR_TCR_RESET	= 0x00000001, /* gPTP/AVTP presentation timer reset */
	GCCR_TCR_CAPTURE = 0x00000003, /* Capture value set in GCCR.TCSS */
	GCCR_LTO	= 0x00000004,
	GCCR_LTI	= 0x00000008,

Setting LTI does not change TCR, and ravb_ptp_tcr_request() both issues and
waits out its TCR request under priv->lock, so no TCR request is outstanding
here.  Doesn't that make the poll return on its first read, leaving the
GTI load unwaited-for?

If so, could the new comment be reworded?  It describes waiting for the
increment load, while the wait is really draining a pending TCR request
before switching GCCR.TCSS.  The comment also spells GTI as "GIT".

The same reasoning applies to the changelog:

  "as the first action of the gPTP init function is to wait for the timer
  interval programming to be acknowledge by the hardware"

Since that first action polls TCR rather than LTI, does the stated
justification for the move still hold?  (There is also a typo, "to be
acknowledge" should be "to be acknowledged".)

There is a follow-on question about the ravb_modify() immediately after the
wait.  It is a read-modify-write of GCCR:

drivers/net/ethernet/renesas/ravb_main.c:ravb_modify() {
	ravb_write(ndev, (ravb_read(ndev, reg) & ~clear) | set, reg);
}

If LTI is still asserted at that point, doesn't this read it back and write
it out again, re-issuing the load request while switching the capture
source?  The driver's own runtime update path treats LTI as the pending
indicator and declines to touch the registers in that state:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_adjfine() {
	gccr = ravb_read(ndev, GCCR);
	if (gccr & GCCR_LTI) {
		spin_unlock_irqrestore(&priv->lock, flags);
		return -EBUSY;
	}
	ravb_write(ndev, addend & GTI_TIV, GTI);
	ravb_write(ndev, gccr | GCCR_LTI, GCCR);
	...
}

Relatedly, the new code writes GTI without first checking that LTI is
clear.  On the re-init paths that reach ravb_ptp_init() from
ravb_set_ringparam() and ravb_tx_timeout_work() (including the "goto out"
case where ravb_stop_dma() failed and the MAC is still running), can a load
requested by a preceding adjfine() be overwritten while still in flight?
Would polling for (GCCR & GCCR_LTI) == 0 before the GTI write, and again
after requesting the load, be the wait that was intended here?

This behaviour is unchanged at the end of the series (c7fa563cd046 still
carries the same comment and the same GCCR_TCR poll).

[Severity: Medium]
This isn't a bug introduced by this patch, but the return value of that
ravb_wait() is discarded, and it was already unchecked before the move.
ravb_wait() can fail:

drivers/net/ethernet/renesas/ravb_main.c:ravb_wait() {
	for (i = 0; i < 10000; i++) {
		if ((ravb_read(ndev, reg) & mask) == value)
			return 0;
		udelay(10);
	}
	return -ETIMEDOUT;
}

On -ETIMEDOUT the code still programs GCCR.TCSS_ADJGPTP and registers the
PTP clock, so the capture source can be reprogrammed with a reset/capture
request still outstanding.  Since ravb_ptp_init() returns void at this
revision there is nothing to propagate, so this would be a separate change
rather than something for this patch.

>  	spin_unlock_irqrestore(&priv->lock, flags);
>
