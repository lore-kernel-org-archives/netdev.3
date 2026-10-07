Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607A4CC63C;
	Wed,  7 Oct 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415007; cv=none; b=B102v3opBu/NM4nN0e3kEjDmDCT4Bx9fspf4WroA1OoZy8d+jfj1inmzdVmxUCUHQp9lGHNzsi5Uy300ZNXqfYz3BMy5qU7Kx8wJQuldYZSyKOlu4Zh76mQMIsYNWtpsiQ7AWPhZR7DvcxkqfD+YFPlHzFzg5NtdrMl7HfbW/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415007; c=relaxed/simple;
	bh=zuJeUJF/NzZSz3lqVEzrBi1UFtVpZaVXAmbRT9Q45ic=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPQXqfhW2eCj8XwAiH76iCR0iUkCC5pRL8WhsWyjFl2xXm0QtWQaFaXcl64ICOSgKPf9nEw9kA80G875KvcaNxEShTdGOmA/4L7PY0Nliw5XjVlu/TjIaCNE0GDYrCfpC3q2kN0WR7X2RJ9QumgouyzmeC0X51ftVxzcKZ7faoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1SWsTZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1SWsTZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081BB1F000FF;
	Wed,  7 Oct 2026 23:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415005;
	bh=yodQAvH4G4xCdufSt9BsNzOnrk4PQaCFZSm8g0XDfpU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I1SWsTZaut1Ir1YAfwglNlk/MtpMw+340slqOL/axGmAQ6d95tGMUKha7n1lSLY7U
	 ppBGJPAr/K4SIQ18H7Whp3UfMal6wdnKuf1u6hl9YSCmlPMJpGK5/ayxMOjKllCDMg
	 AJ2Y4s4M4TW3gZb8NAC3m/aNcmZf25EgMTQmygJYopVRWidd4pz4sxSdD4fmJLh8pL
	 vxfte/OZpMcYFQM1q3uKGTzTtbTiCirtDGsDHFh5nOT69ZgId0AhpqSmoTEoiTnAEN
	 XLNKGICciAINDbPlqbgcEcsOczNVg1MZV+EQCdLli701zBbhpUEWG9rEjiaFsEmBFc
	 kp0ZwScEysTSQ==
Subject:
 Re: [PATCH net 3/3] ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl
From: netdev-bot+sashiko@kernel.org
To: vjardin@free.fr
Cc: yangbo.lu@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kory.maincent@bootlin.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, ioana.ciornei@nxp.com
Date: Wed, 07 Oct 2026 23:16:44 +0000
Message-ID: <179141500461.434549.18154635092466251146@kernel.org>
In-Reply-To:
 <20261006-for-upstream-qoriq-ptp-extts-flags-v1-3-b4a161b92832@free.fr>
References:
 <20261006-for-upstream-qoriq-ptp-extts-flags-v1-3-b4a161b92832@free.fr>
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

- [Low] This patch sets `.supported_extts_flags = PTP_RISING_EDGE |
  PTP_STRICT_FLAGS` in `ptp_qoriq_caps` (drivers/ptp/ptp_qoriq.c).

--

ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl

The patch sets .supported_extts_flags in ptp_qoriq_caps to
PTP_RISING_EDGE | PTP_STRICT_FLAGS. As a result, PTP_EXTTS_REQUEST2 requests
are no longer rejected with -EOPNOTSUPP by the PTP core. It also makes the
core reject falling edge requests, which the hardware does not support.

> diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
> index 76272e5ac5b85..bcd29104effe7 100644
> --- a/drivers/ptp/ptp_qoriq.c
> +++ b/drivers/ptp/ptp_qoriq.c
> @@ -355,6 +355,7 @@ static const struct ptp_clock_info ptp_qoriq_caps = {
>  	.n_per_out	= 0,
>  	.n_pins		= 0,
>  	.pps		= 1,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,

[Severity: Low]
Does this also change the behaviour of the legacy PTP_EXTTS_REQUEST ioctl
on qoriq clocks? The commit message doesn't mention it.

For the legacy ioctl, ptp_extts_request() in drivers/ptp/ptp_chardev.c
masks the flags to the V1 set, which still includes PTP_FALLING_EDGE. It
never adds PTP_STRICT_FLAGS:

	} else {
		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
		memset(req.extts.rsv, 0, sizeof(req.extts.rsv));
	}

Whether the edge bits are treated as hints depends only on what the driver
declares, not on which ioctl was used:

	if (!(supported_extts_flags & PTP_STRICT_FLAGS))
		supported_extts_flags |= PTP_EXTTS_EDGES;
	/* Reject unsupported flags */
	if (req.extts.flags & ~supported_extts_flags)
		return -EOPNOTSUPP;

Before this patch, supported_extts_flags was 0. Legacy requests with
PTP_FALLING_EDGE, or with PTP_RISING_EDGE | PTP_FALLING_EDGE to mean either
edge, were accepted and timestamped on the rising edge.

With this patch, those same legacy requests return -EOPNOTSUPP. For
example, testptp -e N -E 2 or -E 3 in tools/testing/selftests/ptp issues
PTP_EXTTS_REQUEST with PTP_FALLING_EDGE set. That worked on qoriq before
this patch and fails after it.

The rejection itself looks consistent with how the core treats strict
drivers. It also matches dpaa2-ptp and enetc_ptp, which use the same flag
set.

However, the subject and first paragraph describe a PTP_EXTTS_REQUEST2-only
fix, and present the legacy ioctl as the path that already works:

    A driver that does not set
    .supported_extts_flags still accepts the legacy PTP_EXTTS_REQUEST ioctl,
    but every PTP_EXTTS_REQUEST2 request is rejected with -EOPNOTSUPP

The last paragraph says "a falling edge request is rejected", but it doesn't
say this also applies to legacy PTP_EXTTS_REQUEST users. It also doesn't
mention the rising plus falling "either edge" case.

The Fixes: tag makes this a likely stable backport. Could the commit message
say explicitly that legacy PTP_EXTTS_REQUEST callers asking for a falling
edge or both edges will now get -EOPNOTSUPP?

>  	.adjfine	= ptp_qoriq_adjfine,
>  	.adjtime	= ptp_qoriq_adjtime,
>  	.gettime64	= ptp_qoriq_gettime,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832%40free.fr
