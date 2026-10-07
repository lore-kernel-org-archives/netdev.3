Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC934D4C9;
	Wed,  7 Oct 2026 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415004; cv=none; b=pGJY2/WH9CGAYmokJdK3UnfPcsnLIknEjXfYICM9UVYWBdkFfhHXz7lLbVWk53TctbR/yEs5B+JVoenhQUH7RF0hQEo4nD4pB15CyvxhCojsXKwOiS74L+hDhGmgJ2mOPvBfOYZcKjcjnyUcC8Kj6AwgIdwiidSajYAOGKKJPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415004; c=relaxed/simple;
	bh=kZ9Yr/PGmtQqW9KEaAtn3on5T1ktFVVQ9yttOwMcZEw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqkKbAbggvWF6TN8VuzD5wiYuLFTHKD+zu2pBn40+xu36fnK48HNmeKLGnCHB2imz3PyDbVhFZ5h0Qb1xahhvN+KjMGtpSJf0fEtSmBFqJJ/6vkyE8Zuw39e/UdllXxg3YHPyb+CStvlbYfiS5wl3iLX3dNRiI3/VJsyeH8pN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp9GPU9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp9GPU9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8341F000FF;
	Wed,  7 Oct 2026 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415003;
	bh=Hq9PkZq6Tc4gFRiogBEHZ8ZE+4O+b+Nj0QIhh9aEDgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cp9GPU9vggdBv51XiKeDS2n401QGmO4dUAHMNTu2vVyJYor3Xg6lZe0PCWda1fzrO
	 32wymrs9M+VKrSO3GFjFIMuxItUObijPt8LT+JHttUvK59rLHXjo8afLNVLpOTwLIy
	 B9g8cmByrVOOn0MMHvDlzhQoODmv+WCJe65y/+zFe2T2dpwAvHGoowRSS6BCHPMfRm
	 2LuYEaYbE+4aSdxKxe9cBZbBeM3jjUDMTzq5Cb2Ou6yurwh2AAMrjn2d+pqADOfScN
	 zYwxw4Sh2UOqbOU0CyfBQYkNBSv///YeuVVrvPPJT5Eqel2ZwDJm1WNyS/Cwg0cMIo
	 zoN7D9z9LY+jw==
Subject:
 Re: [PATCH net 1/3] dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
From: netdev-bot+sashiko@kernel.org
To: vjardin@free.fr
Cc: yangbo.lu@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kory.maincent@bootlin.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, ioana.ciornei@nxp.com
Date: Wed, 07 Oct 2026 23:16:41 +0000
Message-ID: <179141500147.434549.12688861703859466456@kernel.org>
In-Reply-To:
 <20261006-for-upstream-qoriq-ptp-extts-flags-v1-1-b4a161b92832@free.fr>
References:
 <20261006-for-upstream-qoriq-ptp-extts-flags-v1-1-b4a161b92832@free.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Declaring PTP_STRICT_FLAGS in dpaa2_ptp_caps also makes the
  legacy PTP_EXTTS_REQUEST (v1) ioctl strict on DPAA2, and the commit…

--

dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl

This patch sets .supported_extts_flags on dpaa2_ptp_caps to
PTP_RISING_EDGE | PTP_STRICT_FLAGS. With that set, the PTP core accepts
PTP_EXTTS_REQUEST2 on DPAA2 and rejects requests for the falling edge,
which the timer does not support.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
> index 4497e3c0456d1..ac2b873dcf8e6 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
> @@ -78,6 +78,7 @@ static const struct ptp_clock_info dpaa2_ptp_caps = {
>  	.n_per_out	= 3,
>  	.n_pins		= 0,
>  	.pps		= 1,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,

[Severity: Medium]
Does declaring PTP_STRICT_FLAGS here also make the legacy
PTP_EXTTS_REQUEST ioctl strict on DPAA2?

In ptp_extts_request() in drivers/ptp/ptp_chardev.c, v1 requests are
only masked to PTP_EXTTS_V1_VALID_FLAGS. They then go through the same
supported-flags check as v2:

	} else {
		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
		memset(req.extts.rsv, 0, sizeof(req.extts.rsv));
	}
	[ ... ]
	if (!(supported_extts_flags & PTP_STRICT_FLAGS))
		supported_extts_flags |= PTP_EXTTS_EDGES;
	/* Reject unsupported flags */
	if (req.extts.flags & ~supported_extts_flags)
		return -EOPNOTSUPP;

Before this patch, supported_extts_flags was 0. The effective mask was
therefore ENABLE | RISING | FALLING, and v1 accepted any edge
combination as a hint.

After this patch the mask is ENABLE | RISING | STRICT. A v1 request
with PTP_ENABLE_FEATURE | PTP_FALLING_EDGE, or with both edge bits set,
now returns -EOPNOTSUPP before ops->enable() is called.

One in-tree caller hits this. tools/testing/selftests/ptp/testptp.c
run with -e N -E 2 or -E 3 sends the edge through the legacy ioctl:

	extts_request.flags = PTP_ENABLE_FEATURE | edge;
	if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
		perror("PTP_EXTTS_REQUEST");
		extts = 0;

That used to succeed on DPAA2. Now it fails and skips timestamp
collection.

Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
ptp_clock_info") said that the edge flags are "merely 'hints' when
using the old PTP_EXTTS_REQUEST ioctl, and are not expected to be
enforced".

The commit message says falling-edge requests should be rejected. It
doesn't say that legacy v1 users are affected too, including the
both-edges hint case.

Should the commit message mention this change for PTP_EXTTS_REQUEST
users? The later patches in the series apply the same change to ENETC
and generic QorIQ PTP, so it would reach those devices as well.

>  	.adjfine	= ptp_qoriq_adjfine,
>  	.adjtime	= ptp_qoriq_adjtime,
>  	.gettime64	= ptp_qoriq_gettime,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832%40free.fr
