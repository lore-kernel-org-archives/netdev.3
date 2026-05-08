Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E34313534
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278527; cv=none; b=XI4DMOH5X29en5JVeCvZpzYXO2LWc7KZyOzMj6RpaZDv1YYeEBTXGr4oh80+aZMO8T1/gkywrydwM4KmQahCcsXnu9moFJRreG/YBl91vtL0DY4+QHYWPt5nKjj3p6Izw3Yp1D0/IFrd6n2tvB4b2dY3CJxYKq2NvCoKOuEecCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278527; c=relaxed/simple;
	bh=XnWDCjAfiInsPzvjgVP8ogFNBW3b+qDY5JB//KinUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7hERdnzzMSsW3e51YkuzyJHvpopCGImBytDt6cNVOOZCbPT0QUULys/q84ruV8LTgR24Yg8oXgQYbmGPKhhdIG/k1NalVytZvxjOgWPj70jKY88eNhlCQuU2P4H8tuJmKxaSFAgBBaO23M81Wfbmd8iwf4fa7vWy6sF2/Lkex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPo7RvLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPo7RvLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121CEC2BCB0;
	Fri,  8 May 2026 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278524;
	bh=XnWDCjAfiInsPzvjgVP8ogFNBW3b+qDY5JB//KinUU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPo7RvLt5x0o6lxuVNpqtUKIkzF8biG44K+pBP0rzRqzwCQRrZJpnbLSKF8ekOGgP
	 1NIt7PLieJBK7uOc0kbA9LwxqwxuoBb2/Tjm8/oztil9Ft5+AFAsTjcKPI8P0sUt6o
	 0X+VIRLtiwsbebp+Y4C8CQ5RgOdN+b7vlv+k2T0HPe3zltaic+ODtLZJKt9z/BuWPq
	 AEtbujhTbb3o4HLkxgcdk5yJ4qG4vpd6PO+VthicMqx67s4g4i5ozZsbBl62FOf+cB
	 lKviLu7FfR7EOAFcQf3y/Wwj3KqbC0ttYQ4Tq1FMk67V06a3C1c0Gk8x8QcKW6rO66
	 WmIPYqK7lG8jw==
Date: Fri, 8 May 2026 15:15:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/3] net: constify sk_skb_reason_drop() sock
 parameter
Message-ID: <20260508151523.609cadaa@kernel.org>
In-Reply-To: <20260507084305.2506115-2-edumazet@google.com>
References: <20260507084305.2506115-1-edumazet@google.com>
	<20260507084305.2506115-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 08:43:03 +0000 Eric Dumazet wrote:
>  	TP_PROTO(struct sk_buff *skb, void *location,
> -		 enum skb_drop_reason reason, struct sock *rx_sk),
> +		 enum skb_drop_reason reason, const struct sock *rx_sk),

build says drop_monitor registers for this tracepoint from within 
the kernel, and needs adjusting.
