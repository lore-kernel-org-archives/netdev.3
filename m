Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325B3B14AD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675300; cv=none; b=SvG+H9QIJ07YFyGHMP0gErvhVWeuQr4l48O0m2MA1euc7r98tuv9xeISxsXf89vBL+nI5bADx5CoOeuo4XPSLWRZiPsC62+vm+dSTMDyU/pwUD+78VHmqIymcxxRLXVAQZg5cxnWbbVhK3EEVN7tME8UbWOMy688o9FV38pcWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675300; c=relaxed/simple;
	bh=RfY0zLeIQSf+Vj8ReDyh1qWtK1KF9ACGk3v8FmmpV68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzWJEL2Ienzo3hFGw2DLUGnjBM97ldHxGNHkryR6y9UeqfNgELsxpH1dSLQpSRhqbAvtbwEPKf4r5VRybNmcG9qlIpvkZ6Io4eKpLGRUBRtyAZQxLhytP2D+ZUAbFAFO3if/xryseUgXw57d8yez6Jo+3Ikkla6I9ySVvSE4U6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQbpfzT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQbpfzT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D91F000FF;
	Thu, 17 Sep 2026 20:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675298;
	bh=aI2gW6L+L5+0dR2N1/hP1balwFJ30oFK9pSV4B8DN0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gQbpfzT9vZ+ZdE4IHAucxQ5Y/tOkSMa7o6gBnl/8EYozcjzfRzliMAoelr4/hLlKc
	 Cs3GilF1voLIysSqZFduPpITStSxdZUR5Rxp6O7EZcg3Vj1mJKPx74PiXH4GMd56Rc
	 eA/yGJvW9/uWR/E2V10HSu8CG9zSEgBBmNt+58kwsV93bQTtB7QjQcTrYaru1YS5jC
	 s+Nzu7YiC0Ge09aIYf2o8cvb0oA66bAKzgveGv8iLvLJCc8k5q8cSvNw1W6a5QMaRR
	 ntrqetjyq73uQdfm2mAO4X7SNU7FqKJqNYnnjN48LPaP8RMx+Ia9Nl9DzdEywtTcoe
	 CBWhNko7SaPag==
Date: Thu, 17 Sep 2026 13:01:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Sheena Mohan <sheenamo@google.com>, Willem de Bruijn
 <willemb@google.com>, Adrian Pielech <adrian.pielech@intel.com>, Przemyslaw
 Kitszel <przemyslaw.kitszel@intel.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, bjorn@kernel.org, maciej.fijalkowski@intel.com
Subject: Re: [RFC net-next 0/6] selftests: net: add performance metric
 reporting
Message-ID: <20260917130137.2fa3b9d9@kernel.org>
In-Reply-To: <20260916190409.1222272-1-sdf@fomichev.me>
References: <20260916190409.1222272-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Adding Sheena, Willem, Przemek, and Adrian, who I have in my notes 
as folks responsible for the Google and Intel NIPA runners.
(Please LMK if I should update my notes!)

On Wed, 16 Sep 2026 12:04:03 -0700 Stanislav Fomichev wrote:
> Sharing as an RFC to get the feedback on the overall approach. Current
> model is where the ktap side drives system monitoring and nipa only
> collects/interprets/draws. Another way we can do it is to move system
> monitoring stuff to nipa.
> 
> ktap-side monitoring pros/cons:
> - pro: same format for system vs test metrics (same parser, same
>   aggregator, etc)
> - pro: test controls when the system collection starts
> - pro: test controls what the system collects (say, on multi-nic
>   machines, we collect only the things that matter)
> - pro: local runs produce the same output (and we can add some tools to
>   produce the aggregates for local analysis)

I'm CCing folks from other runners, because I wonder how much it would
help them. I don't think lifting the code form NIPA would be a major
effort, with LLMs. But it is work..

> - con: bespoke metrics aggregation format defined/exported by the test (but
>   I think we still need it for non-system metrics regardless?)
> - con: extra code/complexity on ksft side (although it's only SystemMonitor,
>   the rest of this patch series still relevant)

That's a big one for me, hand up who is able to read all netdev@
traffic as is, this will be more emails and review :(

> nipa-side monitoring pros/cons:
> - pro: more code stays on nipa side

yes, which aligns with where runners are and we can fix things much
more quickly

> - pro: tests don't care about system side of things, it's always
>   collected on nipa side
> - pro: each nipa runner can define its own policy/thresholds (although,
>   why would we want it only for the system side and not the test side?)

pro: the system metrics require no semantic annotations for the UI,
since NIPA produces them it knows them

> - con: separate collection & parsing (system vs test)
> - con: local runs need nipa if we want to observe the metrics

On the code organization - should we not keep the perf tests
separate? 
 - the perf tests will probably need to run ~30 sec each
   and it's very easy to multiply the variants. I'm worried 
   we may need to sooner or later split them out and only run
   a portion of the tests for each branch if they take long?
 - makes no sense to run perf tests for debug kernels.
 - extra infra and history is required to make sense of results,
   no point running them during 95% of development..


That's my $.50, I don't love the ksft.py changes, but I'm open
to trying if others think this is the right move. So please share 
your opinions? :S
