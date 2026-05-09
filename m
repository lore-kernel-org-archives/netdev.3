Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466D8C1F;
	Sat,  9 May 2026 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293165; cv=none; b=FwR+XbJCmG9JUurifomIs13pVHXMh1sqyFbF8KZfjFIBPm5Oki9C+gzRGU0fhyACZChKbRb3w65CLEeJkWu1W+ZRkitoPt/QabqywtHT3Z+qXumoVGAdg5TO7k+RoUMxJXzcO1FURsMfEvUN7lQwOgb0SB7YuSDmYNTZH5j0vIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293165; c=relaxed/simple;
	bh=peQPwtsbF0J5WcKTmoVjs+sG+xMxuFfAxqz2R6XPIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Of8nTD6XkrziQud9yTGKK8ZZWNRIfoloqAVp2oKtp7kM/RNKOSmf7J8sqI7LI2PKbwJNR0LW7V9RxF/+mXwu60oNZTKRVUS7+UKjVzTLjhmxS7WRyxfjs6uM2tJE/Q+btzP+s4Lgws/ggfYsBEAsijKBqJGmLZkmq0s//mb8AQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea2r84bm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea2r84bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB11C2BCC7;
	Sat,  9 May 2026 02:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778293165;
	bh=peQPwtsbF0J5WcKTmoVjs+sG+xMxuFfAxqz2R6XPIq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ea2r84bmqJ7zyzWOPmYNlh4/w6Zsre0az7vgiRIXOvgCcM4hjOtNBwiS1XmkQ96VA
	 7UrmN9C/BUvlEm4kgFDwVRt1R+Jf5EVEMS9TNV6XlRa8oIGP6TvcZxU+C+ji1IqJBg
	 8Xw7My2QGHxJuAqLPGGXX3iEF4Ub/OKoS2KUvNijrqmrNsVjpNBFVyBgulp7RMjZT1
	 6qnr9aA+3BcwC43mtUDj930SWN0V7d54uG3aSQfaLebgWDGmasN6rfn9hX8/f7zF6N
	 p9OhphqjsBfeKrGuM0rtLsURreKC82Qtg/HGogkNePltKS8kbqbm8m0NC21uQ/czFo
	 CM0l4WNEFKPVg==
Date: Fri, 8 May 2026 19:19:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: alexjlzheng@gmail.com
Cc: albinwyang@tencent.com, alexjlzheng@tencent.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hannes@stressinduktion.org,
 horms@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
 shenyangyang4@huawei.com
Subject: Re: [PATCH net v2 1/3] macsec: introduce dedicated workqueue for SA
 crypto cleanup
Message-ID: <20260508191923.3978b8fa@kernel.org>
In-Reply-To: <20260509020054.1792674-1-alexjlzheng@tencent.com>
References: <20260508154243.3ce21bee@kernel.org>
	<20260509020054.1792674-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 10:00:54 +0800 alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> On Fri, 8 May 2026 15:42:43 -0700, Jakub Kicinski wrote:
> > > +wq:
> > > +	destroy_workqueue(macsec_wq);
> > > +	return err;  
> >
> > nit: err_destroy_wq: would be a better label name
> >
> > rcu_barrier() is needed before this  
> 
> Thanks for the review.
> 
> Regarding the label name: "wq:" follows the existing naming convention
> in macsec_init(), where the other error labels are also named after the
> resource they clean up ("rtnl:", "notifier:") rather than using the
> "err_xxx:" style. I kept it consistent with that local convention, but
> happy to switch to "err_destroy_wq:" if you prefer uniformity with the
> broader codebase.

I can see that, but we have to start somewhere.

> Regarding rcu_barrier(): in the error path of macsec_init(), the
> workqueue has just been created and no MACsec interface has been
> registered yet.  queue_rcu_work(macsec_wq, ...) is only reachable
> from macsec_rxsa_put() and macsec_txsa_put(), which require an SA
> object to exist. No SA can be created before macsec_init() succeeds,
> so macsec_wq is guaranteed to be empty at this point and
> rcu_barrier() is not needed here.
> 
> The rcu_barrier() in macsec_exit() is necessary for a different
> reason: at that point live interfaces may have been destroyed and
> their SAs may be in-flight through the rcu_work mechanism, so we
> must wait for all rcu_work_rcufn callbacks to finish enqueuing their
> work items before destroy_workqueue() drains them.
> 
> Does that reasoning make sense, or am I missing a path where work
> could be queued onto macsec_wq during the init error unwind?

TBH I didn't check the code, you may be right that until the genl
family is registered there's no way to an SA to exist (even tho
macsec devices may have already gotten created).

Either way, I'd just add that barrier. We're basically leaving
a trap for whoever tries to add another piece of code to this function.
The error unwind path and the remove path should generally be kept
the same.
