Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327554;
	b=acHvxQbZ8TNzCUH9yB1fn9BBdQDkC4t0BqCw7R/bbSQUryTUrbPEcUkdFRSl2tno0f4K
	 gRSOA7qTDv6plhGnNxC4cZM6g52/VsOJxwrLPGTpUiJyp3lAp5F2tVfrWA6dkQj/dZccB
	 lw+IafwhiZYwTMB1nHjYBlCNkoIRSqJxFlYp3UBT7xoxjWpvatOnn7wzi3sXuFALwDw7J
	 POZtikNddPJ2OIIWcBcehY1SKNEI9krC7FxG0zsFHbL8+p4Uyu2IruM7CY2+UCNilAcln
	 UQZah68vHh9fAsx0ohRIB7CcPULPt2Yr+r1lkwYNbxQzXbb1mWy7izuA2wh16GqJTNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327554;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+gUgkeqPN8KtvPgyyfRup7ntfZjuArnwnmqcBVSu5t0=;
	b=ta24ZvLMjTYbZWBIfHmI2mrZ0smC9JClGg+xWVn7DTwJl0gHEifmxJl43qQ1/E8JDMtM
	 12eYVqPie9nDk+eyxtnFDFcGf/fdBqn/cab92nSZZ2/ALRldTDvQQ+j3WhonxhhazgTLZ
	 cF3NxgSAYcETS1ItpWslo0UWficxGrO5s2KeMuwN3jGmhQYggrkE2ZuivOyPXP5MuGpk3
	 lS4GGd93+5vEWXnxBykdHMWyRjEhpOAbo6mIHyGJFJ/0Zh9C6Nfe/nmBqvgrVFJe1PEou
	 RCSIFMbxqB9Ie5DlJfrHNU6ECN9oZ66hhyPaTAtxEOHOfg1FU28NlI7thCRCDB/ameg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meQ30PHe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF4606A31C;
	Tue, 10 Nov 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meQ30PHe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC81F0089F;
	Tue, 10 Nov 2026 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327553;
	bh=+gUgkeqPN8KtvPgyyfRup7ntfZjuArnwnmqcBVSu5t0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=meQ30PHetV1mSyl1bAQRdjVmMcYrkcra+2CsRTC3HHfOlkTxE0+GvZ5BAY2S6+N1f
	 mA8cqpZoo+nM0EXgekISzOszrfvMzMzNcQNi9If43RFS/ok1jZRkvp95X7kURlFTU4
	 wjUBHM8Uxs6novYHWIWHJuoFei966Ehy0PdIPmh0PASIIxvSRvDIJDEIBJ7pDrc/5h
	 dYXhiRSiNAAH/fk9WvjsUvy8+b8XZ6yRgng7oXWK8VFTuNe/fPKG76hwRWTH57H4XS
	 HbqBflbQeYN11hzDPulrBVuf2E1in+34u1W7hCQIkAEVwAz5KcUBQZwO6htPhfatj7
	 hSRedQ/qsdX5A==
Subject: Re: [PATCH net-next v6 02/10] bnge: add NTUPLE/ARFS VNIC
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:12 +0000
Message-ID: <179432755239.994134.11238266136557206975@kernel.org>
In-Reply-To: <20261106093524.838341-3-vikas.gupta@broadcom.com>
References: <20261106093524.838341-3-vikas.gupta@broadcom.com>
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

- [Medium] This patch makes the optional NTUPLE/aRFS VNIC a hard probe
  requirement, and nothing degrades gracefully when firmware grants too…

--

bnge: add NTUPLE/ARFS VNIC

This patch adds a second VNIC for NTUPLE/aRFS. The VNIC is always
allocated, so the function now needs two VNICs and twice the RSS
contexts. NTUPLE is turned on by default at netdev allocation time, and
bnge_rings_ok() now fails the reservation when fewer than two VNICs, or
too few RSS contexts for both, are granted.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index 21f55ea056f4f..4f4c0a2f40bd2 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c

[ ... ]

>  static u16 bnge_get_total_vnics(struct bnge_dev *bd)
>  {
> -	return 1;
> +	return BNGE_BASE_VNICS;
>  }

[ ... ]

> @@ -222,8 +226,12 @@ static void bnge_copy_reserved_rings(struct bnge_dev *bd,
>  
>  static bool bnge_rings_ok(struct bnge_hw_rings *hwr)
>  {
> -	return hwr->tx && hwr->rx && hwr->nq && hwr->grp && hwr->vnic &&
> -	       hwr->stat && hwr->cmpl;
> +	/* The default and the NTUPLE VNICs each need a full set of RSS
> +	 * contexts for the final number of ring groups.
> +	 */
> +	return hwr->tx && hwr->rx && hwr->nq && hwr->grp &&
> +	       hwr->vnic >= BNGE_BASE_VNICS && hwr->stat && hwr->cmpl &&
> +	       hwr->rss_ctx >= bnge_cal_nr_rss_ctxs(hwr->grp) * BNGE_BASE_VNICS;
>  }

[ ... ]

> @@ -327,6 +338,10 @@ int bnge_reserve_rings(struct bnge_dev *bd)
>  	bd->rx_nr_rings = rx_rings;
>  	bd->nq_nr_rings = hwr.nq;
>  
> +	/* One ring group per rx ring, so rss_ctx is checked against the final
> +	 * rx ring count.
> +	 */
> +	hwr.grp = rx_rings;
>  	if (!bnge_rings_ok(&hwr))
>  		return -ENOMEM;

[Severity: Medium]
Can a partial grant of RSS contexts or VNICs now stop the device from
probing?

bnge_get_total_vnics() always returns BNGE_BASE_VNICS, whatever the
NETIF_F_NTUPLE / BNGE_NET_EN_NTUPLE state. bnge_rings_ok() now requires
vnic >= 2 and rss_ctx >= 2 * bnge_cal_nr_rss_ctxs(grp). Before this
patch it only needed a non-zero vnic and did not check rss_ctx.

Earlier in bnge_reserve_rings(), rx_rings is trimmed by hwr.grp, by the
stat/nq limits and by bnge_adjust_rings():

	rx_rings = min_t(u16, rx_rings, hwr.grp);

However, rx_rings is never trimmed to what the granted resv_rsscos_ctxs
can cover. There is also no fallback that drops the NTUPLE VNIC.

The default ring count from _bnge_get_max_rings() also ignores
max_rsscos_ctxs and max_vnics:

	*max_rx = min_t(int, *max_rx, BNGE_MAX_RSS_TABLE_ENTRIES);

For example, with 100 default rx rings, bnge_cal_nr_rss_ctxs(100) is 2,
so 4 contexts are needed. If firmware grants 2 or 3, this worked before
the patch (one VNIC, rss_ctx not checked). Now the path is:

bnge_net_init_dflt_rings()
  bnge_reserve_rings()
    bnge_rings_ok() returns false
    return -ENOMEM

bnge_net_init_dflt_rings() then sets the tx/rx ring counts to 0 and
returns the error, so probe fails. With rx_rings trimmed to 64, only 2
contexts would have been needed.

A function that gets only one VNIC would also stop probing, even though
NTUPLE is optional and can be turned off.

The commit message says:

    If it grants fewer, bnge_reserve_rings() fails with -ENOMEM and the
    device does not probe, as it would for any other missing ring
    resource.

Is this accurate? The other resources are trimmed to a partial grant
and only fail when the grant is zero. A partial RSS context shortfall
fails outright.

For comparison, bnxt requests the NTUPLE VNIC only when RFS is enabled.
It also clears NTUPLE through bnxt_rfs_capable() when resources are
short. Would something similar work here? Another option would be to
trim rx_rings to what the granted RSS contexts can cover.

This also looks unchanged at the end of the series. The later
bnge_rss_ctx_capable() only covers additional user RSS contexts, and
bnge_rings_ok() and _bnge_get_max_rings() are not changed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
