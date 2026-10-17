Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19A4F5E0
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792212027; cv=none; b=DRqI/3tDpqOfGt8kWVoDLlJiXXlySvkapGUXJLCleu9+F3q8Lw5E1jGOHzEQSIbgs1DgZ34t6KA7WWRi2POdAdqd5HAGW+Rm6G2TkZNa7InmlyAn7KMqO52DP/7N3AD421IJO7icvwpMrx83ns9R2PhcUmd8+iHrpYFcyhargNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792212027; c=relaxed/simple;
	bh=dt6zKtsA2pImG2OzEQtTlAjxne9U81g0RsmV5/u1dCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N67//eqdE7+Ie13vUsqzlHD9rsA7mZcZZE1iEfT1f74MZAR4CBWQPwK4zhEoYeBmqEh96vDLU05GRq8sdkfsmm65VjAQMKnp4pmWJ/pM6iesPVpwourtvZSxhmdoeH9664IVxRjj7lAQ5poIJ5/WnegqrwkS4GVfDhD5fK1hCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDj4IRrt; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDj4IRrt"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab9850456aso927202a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 21:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792212025; x=1792816825; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujlqLNxMSLXVmuXc6H/r32h76Zwbh9xlAVzdBgdTBM0=;
        b=eDj4IRrtxGnjtispzq2jp6bOhHIFeYrM5m2bonVqEAuljckbf0RCCOQKIajBL3ly6C
         4+nfAeMYFvJalnruRewij7oHgyfYeAYdqeAohaqDb0sK1iqRNVh0/TxNBIaUfRyX0xaq
         aR3BOl4FYsxFPeeA2oCREtB54y6Vi5NVPpCaNG6FB428IPJp6iN4MKH/jYf3cmf475/5
         iB8BumDuiwxFS0T1nJJTq0sx1a+vXJkc5ohENXyC8nfQEZIgIG7NeG+qkTb2ytW+KRDL
         tXXrjBLcOa1Af1NRSBR7yZ+2R3G0DYT6kgRSg3zR7AyrjqiiOFqdu7GzEN1U8+S23VEZ
         BSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792212025; x=1792816825;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujlqLNxMSLXVmuXc6H/r32h76Zwbh9xlAVzdBgdTBM0=;
        b=ybVOeuzLdiKsEq9c4hcTpafnzU+5MT/5P4LEWmwz5QhpDoBrh7xOw7toPV6WqBcoG3
         vi0fv2f3CvCaTReMrkoflemfbGDT3pF2mfFsgQRiztE3GnLjS5cKDIhAq6z5Axf3YZhd
         h/sS9ZyQGoHk2a1Msg5dVpzGKBFXMOU+sZ+oRd03rZ314TPm4HluKw+my+WGVB31Fhnc
         kIz3MJKaVfnI90bjfF0umamH82cQyHHP/vyUJ6sgBCtTV20NLa0cLYwluAqBYKI7ZhTo
         oOED7+KuqdcxIrt0aE/dJvGLXmYTZB453vgkRDr2eFyroVlr3QHXWvc/P6oY/E95exBL
         u7dA==
X-Forwarded-Encrypted: i=1; AKwUvBxtJ9IX+erPicbkoPH69Qgl6mB9y11Y2CwXcsEQpsVbklzpFY/Aebpc+OS5QygGzZecA5vdsX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtoL4Vi2f+Jlef01H8ESqVOmnRPt3N3gNm03+KEjs7yAPSEYX5
	Gp/SbEZFauMzdrUY1ppsk3yGs3OGX/xujOjFpnznxQGlkmVyIwYktEuHj9DDgcAELHOgH6xW0yz
	RUdaSAQ==
X-Received: from pgnm1.prod.google.com ([2002:a63:7d41:0:b0:cc7:a825:732d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582d:b0:3a8:5d1f:59ad
 with SMTP id 98e67ed59e1d1-3acef14c8femr1576985a91.43.1792212025461; Fri, 16
 Oct 2026 21:40:25 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:40:25 +0000
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
 <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
Message-ID: <atL8JlUJlc3EBcbF@google.com>
Subject: Re: [PATCH net-next 2/3] ipv6: take fib6_sernum from a sequence
 shared by all netns
From: kuniyu@google.com
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 16 Oct 2026 14:09:54 +0800, Qiliang Yuan wrote:
> A per-cpu IPv6 route of a nexthop object records fib6_sernum of the
> netns it was created in, and rt6_is_valid() compares it with fib6_sernum
> of the netns its device belongs to when the route is checked. Every netns
> starts its fib6_sernum at 1 and increments it on each tree change, so
> different netns often hold the same value.
> 
> When a device moves to another netns, such a route remains usable until
> nexthop_free_rcu() releases it, and fib6_info_destroy_rcu() queues that
> callback from inside an RCU callback, after the device has moved. If the
> fib6_sernum of the new netns matches the cached one in that window,
> ip6_dst_check() accepts the route and a socket in the old netns keeps
> sending through a device that now belongs to another netns.
> 
> Take every fib6_sernum, including the initial one, from one global
> sequence, so that a cached route never matches the fib6_sernum of
> another netns.
> 
> A connected UDP socket in netns A caches a route through an IPv6 nexthop
> object on a veth. The veth is moved to netns B and brought up with one
> RTM_NEWLINK, then the socket sends 200000 datagrams. A route is added
> to and removed from B 0 to 20 times before the move, 63 trials:
> 
>                                 before     after
>   trials sending after move          3         0
>   datagrams sent after move       8187         0
> 
> Fixes: 8f34e53b60b3 ("ipv6: Use global sernum for dst validation with nexthop objects")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
