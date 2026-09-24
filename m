Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2743B71BF;
	Thu, 24 Sep 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260176; cv=none; b=Xsuu6ON/1rp+TZPM6bnXZrHRB4woKIpByktQHCcyhKgGQj21bx/T2J/zRWbMyYkHiCS4+YH5u89OPgwywGm8fbl6CdyFNUuj+UqmSPJwupNBACPO+F0v6DJ0MSmEgbsTsn3SswvQAZskx+vZtoErqUnMTEwpDrMQ9FS8zB2Y3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260176; c=relaxed/simple;
	bh=j+Weebl9QALchnVcGsnSVmNWdx+WGCaOao6ZoLaVuFM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTaaIpn9cV8WgiAtbBkuzScd/kNpQazoFqzgotze1Q/5TRaYQ2IG3pVHLY/rMQetLF9q++CypnlSR4etME7F+ObL+hjV9cs027JTx2YYvyt6ieBfce4KyWTrzyEXNhbHzq84nncmmf9anfUvgsc//+ZjFPQnOyK/GoM7UUjwZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRScL33d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRScL33d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D5A1F0089A;
	Thu, 24 Sep 2026 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260167;
	bh=zoKrbMYcShimrgXkLjVeBbZch+rtF8v0KeP6xyOJDAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CRScL33d0aKFyJiZ8O+VitaZcVdHJuiWcg0EKJVjveUavslFd8d867oFOEmidiLnE
	 nMrjEZKx29/1cJnqlIQ0eC9//xlayWf0Yl8kO1aqdjR+J4gm2zUiZt9RAxeWpawuUY
	 2xNdbAy+17TKMcTqZpNcH1wHruYkffIybNX8evf84wmLYzh4UROVfRedulOOutm3F3
	 tmIF/4khszW32EO1ntpCvimMp1Hf6hjJCl0l+e0Sk/K7VqqbKI1IS4v6p0zI2h1plS
	 uXs5mh/pwm2PA/mxOpRAQYJsH6q434yvzz8ZtOXQFnAkvIkCpqTDj499ie68iAAnFR
	 IvSZfKRfDO0/g==
Subject: Re: [PATCH net-next 3/9] ptp: ocp: hand the TMC bus back once on an
 acquire timeout
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:25 +0000
Message-ID: <179026016574.2160803.8724110629391805579@kernel.org>
In-Reply-To: <20260922142829.57740-4-maimon.sagi@gmail.com>
References: <20260922142829.57740-4-maimon.sagi@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Stale documented post-condition on adva_x1_mblaze_acquire(): the
  patch removes the in-function adva_x1_mblaze_release() hand-back but…

--

ptp: ocp: hand the TMC bus back once on an acquire timeout

The patch drops the adva_x1_mblaze_release() call from the -ETIMEDOUT path
of adva_x1_mblaze_acquire(), leaving the hand-back to adva_x1_bus_release()
which adva_x1_bus_claim() already calls for the same error.  A comment is
added in adva_x1_bus_claim() recording that the acquire path no longer does
the hand-back itself.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 510083dc750a5..feb61355078a2 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4526,10 +4526,6 @@ static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
>  			return 0;
>  	}
>  
> -	/* Drop the request we gave up on.  Any error from the hand-back is
> -	 * subsumed by the -ETIMEDOUT we are already returning.
> -	 */
> -	adva_x1_mblaze_release(bp);
>  	return -ETIMEDOUT;
>  }

[Severity: Low]
Should the header comment on adva_x1_mblaze_acquire() be updated along with
this?  It is left untouched just above the function and still promises the
post-condition that this hunk removes:

drivers/ptp/ptp_ocp.c:
    /* Acquire the shared I2C bus from the MicroBlaze firmware.  Returns with no
     * request outstanding on failure, so the firmware is never left granting a
     * segment to a host that has given up waiting for it.
     */
    static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)

After the change, the -ETIMEDOUT return happens with MBLAZE_REQUEST still
programmed:

	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
	for (i = 0; i < MBLAZE_RETRIES; i++) {
		...
	}

	return -ETIMEDOUT;

so the request is outstanding, and the register comment in this file notes
the firmware can take on the order of 670 ms to answer, i.e. the grant may
still be asserted after the helper returns.

There is no misbehaviour in the current tree: adva_x1_bus_claim() is the
only caller, it assigns bp->cpld_adap = adap before calling acquire so the
"if (!adap) return 0;" early-out in adva_x1_bus_release() cannot skip the
hand-back, and it always calls adva_x1_bus_release() on the error.

The concern is only that a future second caller trusting the helper's own
documentation and simply propagating the error would leave the request armed
with no matching MBLAZE_RELEASE after the i2c root adapter lock is dropped.
Could the header comment say instead that the request is left outstanding on
failure and that the caller must run adva_x1_bus_release()?

> @@ -4647,6 +4643,12 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
>  	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>  	bp->cpld_adap = adap;
>  
> +	/* adva_x1_bus_release() runs the hand-back, so the acquire path does
> +	 * not do it itself: both poll for the grant to drop for up to
> +	 * MBLAZE_RETRIES * MBLAZE_RETRY_US with the adapter lock held, and
> +	 * doing it twice only holds the shared controller for longer and
> +	 * logs the same failure twice.
> +	 */
>  	ret = adva_x1_mblaze_acquire(bp);
>  	if (ret) {
>  		adva_x1_bus_release(bp);	/* keeps the acquire error */

This new comment states that the acquire path does not do the hand-back
itself, which is the opposite of what the acquire header still claims, so
the two comments in the tree disagree about the same invariant.  Checking
the end of the series, the acquire header is still unchanged there, so no
later patch reconciles them.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
