Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03A3CF039;
	Tue, 21 Apr 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777401; cv=none; b=oJ3f/snkJqILbOD5Re4tFjdwZbeCHHCeQsCcHdhKCKE5bVfw0OJC8VrsB5L6OaKZB+4oI3yr6zg5lCHGItD0vdA3PzICArUbEIVSiDFrjam9Pl9luFtktj9bE0JRMMcUUqcHvwct6/04hODHoCuHXAyw3sN/sSbV/+JjxDMm9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777401; c=relaxed/simple;
	bh=HwZFUmSVwGlLN/E9ULZD0pnxiOMW2oqddgLQtuZKeQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3yQNdAx0YfR+XR7aRkzTM1XJBzP7KWYmjmWmlS8TRUHHWOXU8O2xaRC56FwfDXWTMWh8cHp3wxhe6aKPzlOcbS7j4r6dOrkSlavr+uI6YpXkPBcnO8e+XBitr6yAMcM85wnY9jtw6KAMXQFnum7ToJpEb41RYtKjvb/3yIJMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNCp0lr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNCp0lr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE94C2BCB0;
	Tue, 21 Apr 2026 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776777400;
	bh=HwZFUmSVwGlLN/E9ULZD0pnxiOMW2oqddgLQtuZKeQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNCp0lr91nApxOF2gfI3R+FfmNbi8y+Q0eQkrSt6MoVDRPbjEGP92FZt3aNmyZc6W
	 50feVbtm24FtoCkxMT/kzVvIP9ZEIM9SGg0txf6ykb8dJZjCXnaHl57e4PhENQjCID
	 UYkEJi1DfiVZO16tM1LoDp5vov04iDC1cJlnAW/z+V77bapy/iET00qGGnbNf46F6o
	 PIqAecnIyaBJlBhMzub9thg9RBZzhQfDrBKGjA8u0FG2JCfRhEdkzmMsUcwsilT/v+
	 JxYNVOqy1P0sO7KS5iiJbWTY1fzfaj45UhuL+Rk7XQWgmdaL41qGUVVwuqoiTfPNvB
	 aocK4BR4+7lBA==
Date: Tue, 21 Apr 2026 14:16:33 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dave Taht <dave.taht@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v8 6/6] net/sched: netem: check for negative latency
 and jitter
Message-ID: <20260421131633.GC651125@horms.kernel.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
 <20260418032027.900913-7-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418032027.900913-7-stephen@networkplumber.org>

On Fri, Apr 17, 2026 at 08:19:44PM -0700, Stephen Hemminger wrote:
> Reject requests with negative latency or jitter.
> A negative value added to current timestamp (u64) wraps
> to an enormous time_to_send, disabling dequeue.
> The original UAPI used u32 for these values; the conversion to 64-bit
> time values via TCA_NETEM_LATENCY64 and TCA_NETEM_JITTER64
> allowed signed values to reach the kernel without validation.
> 
> Jitter is already silently clamped by an abs() in netem_change();
> that abs() can be removed in a follow-up once this rejection is in
> place.
> 
> Fixes: 99803171ef04 ("netem: add uapi to express delay and jitter in nanoseconds")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>

