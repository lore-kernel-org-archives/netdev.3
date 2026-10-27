Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094915;
	b=c9v0KUa52RrZmxERioxZKo4HEdJm1wexopHSqM17LJCV8MORqc798WqgTeHPP8LKMfWO
	 HeKY5dBX5XzHL5t+CMm4E+G0Vj392vdZF8JZa2WuqzqtlbE8ZCDLfdDu+SuNw21o+NElR
	 n8+cyrZEWRNg8Wu7ShCUTznYT6myOLuH9haoCqBg5ZEYhr3XS50WVj+LyMttvfNP+y8Xl
	 RVE4S30KomjLYvGMHYitlDfVWGCdVpIjwKC1xd+OOAyyJ2GdtX2HPmHpUCNjbbtT8dcA6
	 CLjQrQ8yuYrTeq/raltFrXm3YWIhx5TCC1AYRen9en2KFB7K/nW7+tPYJqDrNIwkPhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094915;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7XFJ7wvqPCgNFFCKH1RgMpmXMwr2z/TBkHELQDADOQg=;
	b=mEOu2m7n3aArdMF14kyDaxvS7vCbOGC+QbZrmCsCeowdKifbT6/pG0PynvMlHlWD/3jL
	 R7dx2QW5Pxrh6SJAr10rmtNpb436cJnJMZvfhaCdQyViSyWjO3L4FUREuyV3iN/Ym6tk4
	 7yvoEV+UAkgYM8aRFe46Y81AGtU2ysihvpDiFzyTEW0xl/q3HY3ml/tD4n32t0VO+weBr
	 +j7NqsRzBZNMN/l6eNBR8Fu2aly9Wj1la7HGuGDOIkhiw/+IeJ24U7211+QnkLllVLQub
	 EDMmkbfhEB5HtXaUKPnJLLDNiK0tcRrOMmBMtLpgR3QelU/0ki+aa1UWcrmZ4XKTZoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3B606A31B;
	Tue, 27 Oct 2026 09:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B3B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonas =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, Shubhang
 Kaushik <shubhang@os.amperecomputing.com>, "Christoph Lameter (Ampere)"
 <cl@gentwo.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Subject: Re: [PATCH v2] net/sched: sch_cake: skip redundant cake_mq rate
 updates
In-Reply-To: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org>
References: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org>
Date: Tue, 27 Oct 2026 10:55:03 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8733trpix4.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Shubhang Kaushik (Ampere)" <sh@gentwo.org> writes:

> cake_mq periodically counts active child qdiscs in cake_dequeue() and
> derives an effective per-child shaper rate. cake_dequeue() currently
> reconfigures every tin after each scan, even when that effective rate
> is unchanged.
>
> The dequeue-time call chain is:
>
>   cake_dequeue()
>     -> cake_configure_rates(..., true)
>       -> cake_config_*()
>         -> cake_set_rate()
>
> With rate_adjust=3Dtrue, cake_set_rate() only refreshes rate-derived
> state. Tin 0 records the unscaled rate argument in every supported
> CAKE tin mode, so its installed rate identifies whether this call chain
> would change any state.
>
> Skip the reconfiguration when the effective rate is already installed,
> while continuing to update the activity-sampling timestamp and
> active-queue statistic.
>
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-=
instances of cake_mq")
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
> Tested on an 80-core SMP, non-SMT Ampere Altra system (aarch64)
> The test used a 32-TX-queue veth pair, with cake_mq
> bandwidth 2gbit on the transmit side and the peer in a network
> namespace. The workload was:
>
>   iperf3 -c 198.18.0.2 -P 32 -t 30
>
> Validation against mainline commit a32e63a613aa80, the patched kernel
> reduced cake_configure_rates() calls by 99.99% (2,477,627 to 206) and
> aggregate helper time by 99.986% (3.477 s to 0.498 ms), while retaining
> approximately 1.91 Gbit/s aggregate throughput (baseline:
> 1.91-1.92 Gbit/s). A separate per-child trace observed no
> same-effective-rate calls on the patched kernel (@unchanged: 0).
> Changing cake_mq bandwidth from 2Gbit to 1Gbit and back invoked
> cake_configure_rates() 64 times, matching all 32 child CAKE qdiscs
> updated for each of the two control-plane changes.
>
> Changes in v2:
>   - Drop READ_ONCE() as suggested by Jonas K=C3=B6ppeler.
>
> Link to v1: https://lore.kernel.org/r/20261025-net_sched_sch_cake-v1-1-51=
65c924a590@gentwo.org

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
