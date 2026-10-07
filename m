Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE736381E86;
	Wed,  7 Oct 2026 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415005; cv=none; b=FkuLBp1oSV5+vQEpXjcs/xLz6nxnMtAfzZ6X6AEov2XimMISv/LdvO7Yn/cnn3034Q68pGubtwlINr+HcAw1FKhUvE9gtmevUyAOihGGgohl+xkzOg2p3vFZgLzRDApHjwsKMNJq8+eFoCn18WmIedP6lvf5cKDOtbuk7ZnCLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415005; c=relaxed/simple;
	bh=b7xb3IJdabkIzBheqTKta/DxVKziFHJ8eIekFrFk3ec=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u38r63vKF4L5Wpjtuo6PyRj77sAYSntB7rAG5P2avyQu2K4fq9LcYgQ43CiQc757tLHbDDvFVKMBmVD6HBogN3EzAev0o+q9tHdd598sR+5t8QbWzGp8J6pDi6UXHBaL2vlJ/Ht+KNJemvM9LzNtzBDmClaLEe7A0joXc4GKBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZCO/CwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZCO/CwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5281F00893;
	Wed,  7 Oct 2026 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415004;
	bh=ELf3qjHTuctnqDEH2GfCfZCeA3rKpmVzBkaYd+F+6vk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AZCO/CwTpFwdjGoWSBDxR5yd/fJl0YS8xpDLzUWUoy59OL2qjoWhkHyaKoirV1kOu
	 FQr0bbl2lQ5M34xW9rQsDjT7Nec7dENEpIu+IZ/FFYNrxyXPzLgBx5Uu4XS9hM05hX
	 KTJMMu4LX4XShYJ9VwAlsZO8Fh7qo4SOFGA648kptbca4iVAPzRK5AI+QPfeDFpXwU
	 DaBPlhiBy6Ar6uOvn41H1l1Y6qwrza/YukEA3BIHEHHZ7Awd3uB1/QEIvqH+/PQjMR
	 DtEPnljufRifGtqRyKk8eM73W6/It06NvGoCw9IeuQbNuIkEMIx4R+NwnOdycPDvXD
	 ro6Jt8Q8zkoCA==
Subject:
 Re: [PATCH net 2/3] net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
From: netdev-bot+sashiko@kernel.org
To: vjardin@free.fr
Cc: yangbo.lu@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kory.maincent@bootlin.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, ioana.ciornei@nxp.com
Date: Wed, 07 Oct 2026 23:16:43 +0000
Message-ID: <179141500316.434549.14000267648285293868@kernel.org>
In-Reply-To:
 <20261006-for-upstream-qoriq-ptp-extts-flags-v1-2-b4a161b92832@free.fr>
References:
 <20261006-for-upstream-qoriq-ptp-extts-flags-v1-2-b4a161b92832@free.fr>
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

- [Low] The concern: drivers/ptp/ptp_qoriq.c `ptp_qoriq_caps` uses the
  same QorIQ 1588 timer, the same `ptp_qoriq_enable()` and the same…

--

net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl

This patch sets .supported_extts_flags in enetc_ptp_caps to
PTP_RISING_EDGE | PTP_STRICT_FLAGS. Without it, the PTP core rejects
PTP_EXTTS_REQUEST2 requests with -EOPNOTSUPP. The QorIQ 1588 timer that
ptp_qoriq_init() sets up only timestamps the rising edge.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
> index 162cbc8017304..5ffee882d6241 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
> @@ -16,6 +16,7 @@ static struct ptp_clock_info enetc_ptp_caps = {
>  	.n_per_out	= 0,
>  	.n_pins		= 0,
>  	.pps		= 1,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,

[Severity: Low]
Does ptp_qoriq_caps in drivers/ptp/ptp_qoriq.c need the same change?

It uses the same QorIQ 1588 timer, ptp_qoriq_enable() and ptp_qoriq_init()
as ENETC, but this patch leaves its .supported_extts_flags unset.
ptp_extts_request() in drivers/ptp/ptp_chardev.c always adds
PTP_STRICT_FLAGS to PTP_EXTTS_REQUEST2 requests. On eTSEC/FMan clocks
registered through ptp_qoriq_probe(), would every PTP_EXTTS_REQUEST2 still
return -EOPNOTSUPP?

    err = ptp_qoriq_init(ptp_qoriq, base, &ptp_qoriq_caps);

This looks resolved later in the same series. The earlier patch
"dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl" covers dpaa2_ptp_caps.
The later patch "ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl" adds
the same line to ptp_qoriq_caps.

ptp_qoriq_init() has three callers: enetc, dpaa2-ptp and ptp_qoriq. At the
end of the series, all three caps tables declare
PTP_RISING_EDGE | PTP_STRICT_FLAGS. Mentioning that in the commit message
might be useful, since this patch only fixes ENETC.

>  	.adjfine	= ptp_qoriq_adjfine,
>  	.adjtime	= ptp_qoriq_adjtime,
>  	.gettime64	= ptp_qoriq_gettime,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832%40free.fr
