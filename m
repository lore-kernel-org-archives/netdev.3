Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640235;
	b=E+o5fbHjOV7ny4uYczyrJpB+9O2grxYRLeLjG6gRuI+WfnXeswyn3md1DoQBd0NAgVbT
	 KxhvnoCemMXZi7vtzidbRPaX6zwGbK2T9x8hVxOYHJVjL1I9toa8ZHEEi/geb7qySAqUo
	 kVh5u7FucVS7/0p9sZ4rKL9F1v4A1EPK8jhtJHtmD45Wkb4DGOm0udlo/ERshu594xbbJ
	 JqOZCQbmaTlZg5qYkRKcpmbRB2w8jznwfuxOctDb32Pk9dCKBxocnUfedMIiPRFQLbdRN
	 +kAJ0udFB/r6RLt3BygIkjZzOAd0kRgOlbGCHK64MRkTEMSs5w0Ii/Y1wO2WUP1sotw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640235;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wiOrzvAWE54RUecfoYSwa4qYrJQIt8QNmZHHKyYFVK0=;
	b=LD4BoA5mkn+aJHt+mMxRM2LMYI3YSIJZNwsV7cDABbGkEEl4Ydv10gmKM7IH6GrKaAmY
	 I+wGVutKQn2/MJPnYmNSu2jmZiFkLxVctk0CN+Ln9sdpKm6AzK5Jn1ttAFw8i/xsJRMuG
	 sgYA2Gv558WtcWxGghu9XIWOYIeY0SQcVxabRw+vjZn1HONwIK2fzINCkXjcND4svfDdS
	 /IQuqMMK5XjWbHv+PKxCDqMMRwEaSd7W6iGEhRoPC8wneNmISPyHfcsoHYekjEKyTaaTy
	 DJ/Sl2wXgTJ5RBmcQdDpb+8k7TlT7+ikB201urGEhwo104Lk2iIYsihuJx8ecDYk5LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTvaCW2A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD1606A31B;
	Thu, 22 Oct 2026 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTvaCW2A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1965F1F000C1;
	Thu, 22 Oct 2026 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640234;
	bh=wiOrzvAWE54RUecfoYSwa4qYrJQIt8QNmZHHKyYFVK0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nTvaCW2A8PtFlz2WBPFWTQKpyVIVR2r8NgeRnmsZfqMR4MY5ntT96Wkm+8rQDboSS
	 KKQzN2Gnbt26IsIfre9+xrjhGBVXt4sggbZhJQ0AhAaZIo2FfY87bCGK2VywdgEYhg
	 nKJaRQGBp6ErXezG83eUQ17Pb+d+w+NKG4gcQ8lOKAIptCzgkEU/zp87ZdyHqhCam5
	 cVk4qqUONgK9Ep5Ak0iXYXtLkIIHsHoq2APv7zlnACCo2PRtdVqKiR5hnqafvTXi0o
	 0f2rqT8QbgxgBEFRr6Rrwwp8m7VOujOhegcP5v0rjMUkpNtURoXFAIgp9y42MQ+XQ0
	 jMNam+/q5e7+g==
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for
 PTP_EXTTS_REQUEST2 ioctl
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 jacob.e.keller@intel.com, kory.maincent@bootlin.com, s-vadapalli@ti.com,
 c-vankar@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 03:37:13 +0000
Message-ID: <179264023362.3135.17895429756190814680@kernel.org>
In-Reply-To: <20261020003525.1237742-1-jjc@jclark.com>
References: <20261020003525.1237742-1-jjc@jclark.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Adding PTP_STRICT_FLAGS to am65_ptp_info.supported_extts_flags
  in drivers/net/ethernet/ti/am65-cpts.c also changes the legacy…

--

net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl

This patch sets .supported_extts_flags for am65-cpts to
PTP_RISING_EDGE | PTP_STRICT_FLAGS. The PTP core then stops rejecting every
PTP_EXTTS_REQUEST2 for this driver. After the change, PTP_EXTTS_REQUEST2
succeeds for the rising edge and fails with -EOPNOTSUPP for the falling
edge or for both edges.

> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index efbf2ef976a3..df5659ead72f 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -779,6 +779,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp);
>  static struct ptp_clock_info am65_ptp_info = {
>  	.owner		= THIS_MODULE,
>  	.name		= "CTPS timer",
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,

[Severity: Medium]
Does this also change what the legacy PTP_EXTTS_REQUEST ioctl accepts?

In ptp_extts_request(), the v1 branch keeps the edge bits and never sets
PTP_STRICT_FLAGS. Whether the edge bits count only as hints depends just on
the driver's mask:

drivers/ptp/ptp_chardev.c:ptp_extts_request() {
    ...
	} else {
		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
		memset(req.extts.rsv, 0, sizeof(req.extts.rsv));
	}
    ...
	if (!(supported_extts_flags & PTP_STRICT_FLAGS))
		supported_extts_flags |= PTP_EXTTS_EDGES;
	/* Reject unsupported flags */
	if (req.extts.flags & ~supported_extts_flags)
		return -EOPNOTSUPP;
    ...
}

Before this patch, supported_extts_flags was 0 for am65-cpts. A v1 request
with PTP_ENABLE_FEATURE | PTP_FALLING_EDGE, or with both edges set, was
accepted and reached am65_cpts_extts_enable(), which ignores the flags.

Now the mask has PTP_STRICT_FLAGS but not PTP_FALLING_EDGE, so those same
v1 requests return -EOPNOTSUPP before ops->enable() is ever called.

The same check runs when PTP_ENABLE_FEATURE is clear. Through either ioctl,
a disable request that still carries PTP_FALLING_EDGE is now rejected.

One in-tree example is tools/testing/selftests/ptp/testptp.c run with
-e N -E 2 or -E 3. That sends a legacy request with PTP_FALLING_EDGE set:

			extts_request.flags = PTP_ENABLE_FEATURE | edge;
			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
				perror("PTP_EXTTS_REQUEST");

On am65-cpts this worked before the patch. It now fails with
"PTP_EXTTS_REQUEST: Operation not supported".

Rejecting falling edge requests that the hardware can't honour matches how
the core treats other strict, rising-only drivers. However, the commit
message says:

    Only the PTP_EXTTS_REQUEST ioctl still works.

This suggests v1 behaviour does not change. The patch has a Fixes: tag and
is likely to go to stable. Could the commit message say that v1 requests
carrying PTP_FALLING_EDGE are now rejected as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020003525.1237742-1-jjc%40jclark.com
