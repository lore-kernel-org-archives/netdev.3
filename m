Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792469656;
	b=In4NpRuEgFNzn8SVE+EZfB73KzUH+ziy6+m3ZoyNImF/DhBBgBLqEm9YqxIhMygY2ZT8
	 D8Q7eLobF8vtew9FxSuewld+ie/S2alZeE5qYynhsFAVK7uOqaXNy1+IzY9oyK3+TMui0
	 k0kO3bLMSm5zA81k0KgIUbZ1OkvdQox8vPkrwTlt05Huck+/0LXcTe4oz/+gnL83f0jdT
	 0dwYc+ityqF8sC4c8XmAIVX6ECkUysgcmzOpRvT/0DaIibm4ku+UKJy/HQSPV9BZHb1JM
	 I1pYGfoeUyDn1skP9jfFDUpbHW4/ELq3A7lY09XY59WjD5YXbwiTXEc8jO8w3X6NSvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792469656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DxN0sudUJewCfLMVKKP0r2+HbKPiDu9x82FTF+O+lI0=;
	b=Mt6LRpTuSJKi3rPs3X8PaHJbCC/a+POCrCkoYvjH/FccWDR7FkCTbZvc7F3zP/KM0NNp
	 Mhm+atQJaXXBFq5G8N45WRbZOcLbOVyl5kJS414AAIvKsvCOBxeJJxlZgzAketP1yi6Wh
	 0J0MenP3J7IjEj/6vFUhGNkPmCYrYVSYMSuPgPftrzvznG/5R890iFVxEr6LrKrYaKdL6
	 6lQhuDjn2zNLWTfVmksMbzPluS05ddkUvaFWDryRIhN/9G6YVoza0IX6H01b+Pi9qJd6Z
	 9cVl7mFtQus7mR/Wf4Po+fdLlqoIAm4oi3YgpTdrf7BKyZu/NGCyeCHmKjY7jMnxPHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LzsmHutE;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0707606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0707606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LzsmHutE
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so1774814a91.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792469655; x=1793074455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxN0sudUJewCfLMVKKP0r2+HbKPiDu9x82FTF+O+lI0=;
        b=LzsmHutEAkSwECaGW7SRlHcfzN1LHNEMg656QTfmCQBqL7UEBi33rfcbEskFy9Vf9s
         aYzUQz1s+u6xwaHKJIOgvJV+/TU8TQN3Ec7IRKqccgQqKQKiWyfo1iKQ9aFez6FLgZQe
         De0fmxQuZsv0ZqLwNBKPUfhdTbRVQdYrqMEj4BEjVPjftrU7Jl97RIWyS/Qk6qogxzSW
         ub4cG4zwOSI4OlPNHSKSLiOPK2dPfY1QS+i7NyYWGIyz57OWVVfnMLvqY47UKXMQN6xI
         CFd9uSxaAwQWHfjhnNO96tmg9OR0hZxDjb9CZ6xta48phnYcjxa9sYLNlO7AB8AzlSdl
         Pn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792469655; x=1793074455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DxN0sudUJewCfLMVKKP0r2+HbKPiDu9x82FTF+O+lI0=;
        b=aVprt4v6hTpd3QfGyL0NIytmGx5Vou4L+6D5h7sK6XkxTMCwFUgotkexjlFfUztG2y
         gwvrXR9M76nKp3JRghOFNfX5D43jAs8nAYy5YkRzoYie0YUqfRckn6eUvvO12AXTPbqo
         SNArJ+fX4DJIUng43xvCXAPzeHtXLzEimt2IWC6U1JE4vze30wcM/71KRH2t5qdOVaMI
         Q0xmM9lrQZC/COFZZ04B2GI23hpzeUFucrnWj0UUry4AdP67XQcvSYiDD41nIaEFmijo
         aMz2/59qVNryXAbfrAkjORrnImgoJxeIa0xlPfeZEEqYvb2iuKds5cBpOdIC/A6hxBv4
         wU9Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6mNwkSbWa5pD7jeGXXAzPIGR7cFuJOUeQjJZ9Tc5zNlrwxwtBJgk6O/so+XmWxaIsb3mMPX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOeUoS2Xm1zoaus5lFOyzlWioANxb2/gAmv8pg9A7GpElmCdHl
	/nS4qSARAvI59OMz0ZwWQJoYn1Re1KAc466gCxLtdTw4QosSv3wQPMbQUdRF3D6aM0wM8QTtrqH
	6w7Fs2A==
X-Received: from pjee12.prod.google.com ([2002:a17:90b:578c:b0:3ad:4377:79ba])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7ca:b0:3ab:f38:2b3c
 with SMTP id 98e67ed59e1d1-3acef13eb0cmr8177489a91.28.1792469654868; Mon, 19
 Oct 2026 21:14:14 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:14:14 +0000
In-Reply-To: <20261019-bug-net-netns-move-rcu-barrier-v2-1-b6eb7780c492@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
 <20261019-bug-net-netns-move-rcu-barrier-v2-1-b6eb7780c492@gmail.com>
Message-ID: <atbqjdy_KVld_WAC@google.com>
Subject: Re: [PATCH net-next v2 1/3] ipv4: draw rt_genid from a sequence
 shared by all netns
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 19 Oct 2026 11:31:15 +0800, Qiliang Yuan wrote:
> An IPv4 route records the rt_genid of the netns it was created in, and
> rt_is_expired() compares it with the rt_genid of the netns its device
> belongs to when the route is checked. Every netns starts its rt_genid
> at 0 and increments it on each cache flush, so different netns often
> hold the same value.
> 
> When a device moves to another netns, routes cached through it remain
> usable until dst_dev_put() points them to blackhole_netdev. For a route
> using a nexthop object this happens in nexthop_free_rcu(), which
> free_fib_info_rcu() queues from inside an RCU callback, so the
> rcu_barrier() in __dev_change_net_namespace() does not wait for it. If
> the rt_genid of the new netns matches the cached one in that window,
> ipv4_dst_check() accepts the route and a socket in the old netns keeps
> sending through a device that now belongs to another netns.
> 
> Take every rt_genid bump from one sequence shared by all netns, which
> never hands out 0, the value every netns starts with. A netns bumps its
> rt_genid on NETDEV_UP before its devices can carry traffic, so a cached
> route never matches the rt_genid of the netns its device moves to.
> Concurrent bumps of one netns can leave the older of two values, so
> rt_genid is no longer monotonic per netns. It is only compared for
> equality, so this costs at most an extra route lookup.
> 
> A connected UDP socket in netns A caches a route through a nexthop
> object on a veth. The veth is moved to netns B and brought up with one
> RTM_NEWLINK, then the socket sends 200000 datagrams. B's rt_genid is
> bumped 0 to 20 times before the move, 63 trials:
> 
>                                 before     after
>   trials sending after move          2         0
>   datagrams sent after move       2616         0
> 
> Fixes: 4c7e8084fd46 ("ipv4: Plumb support for nexthop object in a fib_info")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
