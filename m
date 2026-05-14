Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862631F1537;
	Thu, 14 May 2026 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719356; cv=none; b=NIHzrB1xjr7ii6/SWdI0SS5Hnae8RVgST6Brwe/nm5mfIG8jPmB7scTqWClYeFvjx66e1/ZjafZ6/pfQJjGBPbLZ+Wrp5+zexPgS2cTWNBlE6ABsAh0jM4YQyJYDRRcYmg8EQjONoL/famRELlNGId5e9WNIBO1qaIDsQmomATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719356; c=relaxed/simple;
	bh=uNWCEocpWm5ShoTec7DuWx3jxalhxH6RZc2Y9mQS9tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGqMvZWz6daep2eWn3omAObEli5BEvVTY2k6AvoOXiRFLjeXn6kudbNCEEIjURLX0qgHN3bKIFieES580J1f7f95ymIPJ2fdHjenxttENtFycVHDSe1ZUCYaNss/q6g5SO7JKAN2rxrnYWq4Ol1p6dgyRNDSddxCOb5JIGgBtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/bZKimS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/bZKimS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4B4C19425;
	Thu, 14 May 2026 00:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719356;
	bh=uNWCEocpWm5ShoTec7DuWx3jxalhxH6RZc2Y9mQS9tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/bZKimSnvDsvmcgy4TuxT3L0/+cW84yzZcU0mVn5YoBedsyuwuBwaQF/+69Ne9h0
	 Vr1keM/y2IzTe1/5UFIDR8hKuyJVec9cWLNNiZo0ebQoPHCVH9xWqwYwNu/h46Of0Y
	 MVLv0/4HgPea9hfwA1foY9eUDaIGwqKqg0fcx1Dz/CITfU9eSPDoUdUDMpPXVOYmwU
	 idaSRYpjxQVmsL/uKGYDYwKrufRf9j3UKXO23ghNAgK8gaS9meKDsWVENorGUl3qav
	 XxJ0hcRC5+ukmG+5FeMGYDsbg45zzCz83KcdBn0LJ8BeIaNWYKdgVgrauwCQt5rpjT
	 K+LXjoXhVVzcg==
Date: Wed, 13 May 2026 17:42:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: introduce TCQ_F_IN_HW to track
 successful qdisc offload
Message-ID: <20260513174234.3e78e67b@kernel.org>
In-Reply-To: <20260509122238.2792915-1-mmyangfl@gmail.com>
References: <20260509122238.2792915-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 20:22:33 +0800 David Yang wrote:
> qdisc_offload_dump_helper(), introduced for RED in commit 602f3baf2218
> ("net_sch: red: Add offload ability to RED qdisc"), re-evaluates offload
> liveness on every dump because a parent qdisc change can alter the
> offload state without any qdisc-specific callback being invoked.  In
> this path -EOPNOTSUPP means "I do not offload this qdisc currently",
> not "I do not support statistics at all".
> 
> Only mlxsw and nfp handle this correctly by maintaining internal qdisc
> tracking (they need it for RED offload).  Every other qdisc type that
> supports offload (ETS, PRIO, TBF, FIFO, MQ) calls TC_*_DESTROY
> unconditionally in its destroy path regardless of whether a previous
> TC_*_REPLACE succeeded.  Moreover, without a flag recording whether
> REPLACE was accepted, a simple driver that queries hardware directly
> rather than maintaining a software shadow has no way to answer STATS
> correctly: it must either always return -EOPNOTSUPP (hiding real
> offloads from stats) or always return 0 (false positive, claiming a
> qdisc is offloaded when it never was).
> 
> Gating TC_*_STATS or TC_*_DESTROY on prior TC_*_REPLACE / TC_*_GRAFT
> success is not an option: sch_gred relies on receiving STATS even after
> offload ends in order to adjust backlog counters, and silently skipping
> DESTROY for a qdisc that was previously offloaded would leak hardware
> state.
> 
> Introduce TCQ_F_IN_HW to indicate that a qdisc has been successfully
> loaded to hardware via TC_*_REPLACE.  The flag is set by the new
> qdisc_offload_change_helper() on success and consumed by the new
> qdisc_offload_destroy_helper() which skips the driver call entirely
> when it is clear.  This is orthogonal to TCQ_F_OFFLOADED, which remains
> the liveness indicator re-evaluated on every dump.
> 
> With this a simple driver can be stateless: on STATS it queries
> hardware by handle and returns -EOPNOTSUPP when the entry is absent (the
> core will clear TCQ_F_OFFLOADED but TCQ_F_IN_HW remains, so a subsequent
> destroy still cleans up); on DESTROY it need not defend against "was
> this ever offloaded?" because the core already verified TCQ_F_IN_HW.
> The driver no longer needs to maintain its own registry of offloaded
> qdisc handles.

I read this 3 times and I'm still not 100% sure what the main problem
you're trying to fix is. You don't know if the DELETE is for the
offloaded qdisc? Can't you just store the handle of what's offloaded
in the driver?

The qdisc offload is a bit of a mess without a dedicated maintainer.
Sweeping changes like this are a bit burdensome for the core
maintainers..
-- 
pw-bot: cr
