Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB22E7BB6;
	Sat,  1 Aug 2026 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545209; cv=none; b=PEuX2YvipmjbtL3GwvxedThia4fMRTqd6dtrI0DIqJ4u8JFNWfQOMANRoc7TtBWj6Ve4eOkKec9QeIHbI3rnkWnHq0ZXLAvSYDbXF7OVH3pKI6tSN1burnhzURkQBHllX7qpd8bzNphFdRYRobVtUmS+6VkTpkm/Oon3z2zRRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545209; c=relaxed/simple;
	bh=BPOHkzlwqYP0V46KYYpPlfPkZqdg+6bTum3stuUrupo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh4OVcSHHHSzEwnrIENzib0fRiei+UHFvYbHJ4ve+7/tARdvflgccI19BcSunEKDpFg0pxdwBvgAG/oBlClmy/FpzLyqA5Lg7uJH5u+v9cNmuOxKTbL31shfd3hGiJdrAqdFaMqjJ6vSzW+Wzoo4e6+OskI1+LZlcosGheeelKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaqMvJZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaqMvJZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6B81F00AC4;
	Sat,  1 Aug 2026 00:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545204;
	bh=X/eDWyJKiOu4q6x0YrmdApxY/xHZZExgnVqNx96mIQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RaqMvJZpwTeeJbw9Lcac8Guf0D8WFLw/RVLVUham4whBJqKIsmJHzyjOptb6kZe3W
	 nfNLZ6hyQ7XiqpBjZmZ1o++3xm9l9ePyZTyZN4fjjsS6k6E+Jl62ztSzTt9OqCJj4I
	 lzwis5DwCaJpPvZE9qC99Avk3rGu8R4Cg/HOdir4EdKON3MZPcghq7IjGmo94uQKGY
	 B6nLtKb/e/18JXoYxPwmtzCLZMgczjydAOSwtA39UmE5FebNgq3ER8TsPyvLJ92/XF
	 AQQjNoLQF6izkqwO26ANSMO+3dDnssMOYhvQQhn08uvBT0uH8DQDtcRxF8yDKoJM1m
	 3etytuuXjpzjw==
Date: Fri, 31 Jul 2026 17:46:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nathan Gao <zcgao@amazon.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] tcp: do not change rcv_ssthresh in
 tcp_measure_rcv_mss()
Message-ID: <20260731174644.02410e2d@kernel.org>
In-Reply-To: <20260725030806.28135-1-zcgao@amazon.com>
References: <20260725030806.28135-1-zcgao@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 20:08:06 -0700 Nathan Gao wrote:
> Commit f5da7c45188e ("tcp: adjust rcvq_space after updating scaling
> ratio") replaced the direct window_clamp update in tcp_measure_rcv_mss()
> with a call to tcp_set_window_clamp(), a helper that implements the
> TCP_WINDOW_CLAMP setsockopt. As a side effect, the helper also shrinks
> rcv_ssthresh via __tcp_adjust_rcv_ssthresh().
> 
> As a result, each scaling_ratio decrease detected by
> tcp_measure_rcv_mss() also cuts rcv_ssthresh. Elsewhere in TCP,
> rcv_ssthresh is usually cut under memory pressure and grows via
> tcp_grow_window().
> 
> Flows whose segment sizes vary keep scaling_ratio oscillating, which
> leads to an unstable rcv_ssthresh: a dip of rcv_ssthresh only recovers
> via tcp_grow_window(), keeping the advertised window at a relatively
> low level even after the ratio itself has recovered, and can even stall
> the sender.
> 
> Observed on a customer's proxy gateway after upgrading from kernel 6.1
> to 6.12: in the worst case, rcv_ssthresh was cut in half by a
> scaling_ratio dip. P99 latency jumped from <10ms on 6.1 to ~100ms on
> 6.12, and almost returned to the 6.1 level with this patch applied.
> 
> Restore the plain WRITE_ONCE() update of window_clamp, as introduced
> in commit a2cbb1603943 ("tcp: Update window clamping condition"), and
> keep the rcvq_space.space adjustment. Now rcv_ssthresh is decoupled from
> scaling_ratio changes in tcp_measure_rcv_mss().
> 
> Fixes: f5da7c45188e ("tcp: adjust rcvq_space after updating scaling ratio")
> Signed-off-by: Nathan Gao <zcgao@amazon.com>

Not sure, I mean regression is a regression, but also the previous
behavior seems to have just been lucky rather than correct in principle?

Looks like Eric and Neal are AFK, Kuniyuki, Paolo, any opinion on this
patch?

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index daff93d513428..5b6378b94701e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -252,7 +252,7 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
>  				struct tcp_sock *tp = tcp_sk(sk);
>  
>  				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
> -				tcp_set_window_clamp(sk, val);
> +				WRITE_ONCE(tp->window_clamp, val);
>  
>  				if (tp->window_clamp < tp->rcvq_space.space)
>  					tp->rcvq_space.space = tp->window_clamp;
> 
> base-commit: 78f75d632f74b8de0f081a128588f7c37d0d1164

