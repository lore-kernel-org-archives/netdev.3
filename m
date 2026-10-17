Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC6352005
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792211711; cv=none; b=pHW+Xptd6bqV0oDomYV6Sd/WV4KN5uLx/FPfgygJ4wd8mtTJkI6DUeQ1vzOpbDqWTTiLBMjj76kR018hYRt7ukHoFF6fRroucB5D4r8pI8pRNf5/6kBXXB8LUvYKQiFEZMcH1Lo0IyXj9MGsjkUFT8WvONrMZrIvGLx8fCYjhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792211711; c=relaxed/simple;
	bh=7kk2U4a9Lo1xYcGtwJg0lyGzo5dv0nbWpZ3vvoWDVTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FGUoCPRZcd0S7Qw19Fedqynpq8ns+6nSwNXjgznzvIHtxfOaUzSLV2zDPZEKp+/xo2113egY0gBad9mJ4V0D/mGmOaf0TJr6mhuMJoybsjDFAyVyxT1MlnoMxEt4OFeGyF1IxWs9pFUIA4+GGBsJEZV06ktPpJmSqNddinMR42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4vVm79I; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4vVm79I"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac16335199so523953a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792211710; x=1792816510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ij/yw0EE7qvrJWtzl6WjRChvvvMCRKj13EcgUfUn1no=;
        b=J4vVm79IEdUl4CwBAXuLRkNGAagM1HJ5exu0RLrYub0/G7tsTiMeYQ1PKXKdMO8CBM
         K/k3jKvbHV/9IRwUftxPrsrH1V0JaTBz63AG0mNuKhArnffE82a1/g3F4TIYzmBmzF+b
         a7MplhpalQVIAiiSrzrEgIXKe8to43X+Ni2JCjktshSKpP+eIvIYwXktg7KvU2UiJRzS
         xbNWGTqWE+EjAYbiO3nz32tqDyC33SSjRyPM18lqDH1q+gjaiHTXvJxRP8WomJhG92RG
         pX1WyyF1rEXT9fXmXGofsBA9qCEE0AtQZAeJb0ku7U6ZGDHRAh3w7OH5RPKV8yP3no6D
         84dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792211710; x=1792816510;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ij/yw0EE7qvrJWtzl6WjRChvvvMCRKj13EcgUfUn1no=;
        b=ZTlU3l2YdjjlRdBqfMOsSsS6IrJkW0IdOof18Rwzw89xIqJR8LowFomWs3u9K6MckS
         N2MAbac10bOz1cpHrLC8L1rf4T8N88pOf5xPhiobVnLr0C9p3z2dibky9PyuaKMyeMJ5
         yFDRQ3PNnI+i7US8MEvu4Ew5vOA7vEFOaopIm9Ci2QLG1pkoT2jokQ9WB9fnkf+KgcU5
         uQnoaeGHRXYMAO2J30VGEnfabxD9/5fl/RmXlJ9VQAHyxW4FfNdkcvupGCmqgvG6rJZ8
         /AFhMqtjJck996wJ0ladF3SEjnRhqLzcOB+hGDGbXhy9kXyTmPKQWEcKWwqmRRKFEbZf
         jthw==
X-Forwarded-Encrypted: i=1; AKwUvBwZM11mFHiOUIv0/RwFYozcLzxVy497wl8W19fRkcjuywQqi9EooqVBfSrmleewBBiGLvJU/NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRZdAL6W39COjs4y0uRq47Ti8/Ezt4jRwp+LFkkS6icVmA+7L5
	m0PNbNk66onVEgp2t09NfJmp20slMfoIaXEcGYWhboCQWMx1fn6+waxN5p3QGPir1KI32oEdymA
	1EkbG1g==
X-Received: from pgnm1.prod.google.com ([2002:a63:7d41:0:b0:cc7:a825:732d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4d:b0:3ac:a7ee:6760
 with SMTP id 98e67ed59e1d1-3aceefc2b04mr1444742a91.23.1792211709522; Fri, 16
 Oct 2026 21:35:09 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:35:09 +0000
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-1-4157d798658f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
 <20261016-bug-net-netns-move-rcu-barrier-v1-1-4157d798658f@gmail.com>
Message-ID: <atL51vM2GDL-7YCn@google.com>
Subject: Re: [PATCH net-next 1/3] ipv4: draw rt_genid from a sequence shared
 by all netns
From: kuniyu@google.com
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 16 Oct 2026 14:09:53 +0800, Qiliang Yuan wrote:
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
> Take every rt_genid, including the initial one, from one global
> sequence, so that a cached route never matches the rt_genid of another
> netns.
> 
> A connected UDP socket in netns A caches a route through a nexthop
> object on a veth. The veth is moved to netns B and brought up with one
> RTM_NEWLINK, then the socket sends 200000 datagrams. B's rt_genid is
> bumped 0 to 20 times before the move, 63 trials:
> 
>                                 before     after
>   trials sending after move          2         0
>   datagrams sent after move       2353         0
> 
> Fixes: 4c7e8084fd46 ("ipv4: Plumb support for nexthop object in a fib_info")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
