Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502B3EC83E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317245; cv=none; b=RW9yUHzGZ67u0yYfhw3+DFQjbRChhhcG6yDFGvuB9NxBFd7XJ4eHMurq9s4P/4vtYsdCkDnTsVayxB67fnAwODIKBJwf0560GBZFs3d9p51QNaSy/HT2jSQOXXIVdhUTPTB5FXlz1Xd9rNhCsZEBF3fOrSua8qrDUmvtoOOqk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317245; c=relaxed/simple;
	bh=z77cgsMqkvy1+ZRDLEWm8tXK20jgLOGcazzQHSfgzKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5yxeJlVI+AUu3cQy3/KaLiBcdxMheJOi0PyltG89VvOrhesuec+7UpeZZVK0/YGdHRJq0rRjz7DzOvZDAXup/SC9Ue5H+47HyRtmp+jQ4UOiFGMFwObaErbXCxtOJ3mrK32WBgqeOMOEAop9J1Wh1fC5hJDM0fGTQy7JQa3uJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=K41n6DQd; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="K41n6DQd"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-828f4eeba13so603275a34.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791317242; x=1791922042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/LozmExABJUFU+9kHQRqzcFqSHSkbYSMgyyoNheRsM=;
        b=K41n6DQdqYD3USaAv36P4oZsXjOwcw/E6RVNR6Am+qD04jpfvtvIcrxqprhY4a8sHQ
         odXCvv/bcdXNJLkDSqdzlqGBBchIE1bczs0EJETVsWfJUG6w4HEzlTiVDq1PMeJQmzaR
         w7Fg8Qkvs3eS2/SSfU2cEArr73fOmNXoGlBZtN69XWLgGVEkyoXhZKwGaKOoF86JP8Q6
         dXJSufr3mqxlzQLu9ZifQxwmjZHnRJpqhDktg3VNgxO1ERKm1/phWxpbkFclcUqOL/+0
         Q1nWBgL5YCA09sAadJfi0yhcAKfv30qVJAcHveUudD8OpV6/XIseakIOzILAd3Md5Nuj
         kvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317242; x=1791922042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/LozmExABJUFU+9kHQRqzcFqSHSkbYSMgyyoNheRsM=;
        b=IU9551F6tBKJYpx/8Q9Ixv25kGnW14JsK5Y51Q0n9p7eoM0kqGJ4nr/XGCNXwGbx1/
         kOkEVNOFN+xdVjRaScTsgPIO2385NQBj3DuIhS4ynpVJzUblCNeMeA7gDyhssDRweqtQ
         uTPnlocc0dEZV+qFBIa3/p8B9AuY5JuUZyQ+HWdiG9KpNIQGPxiRUg/B0yjpMuB+zfix
         BVg19M9PvKwxwk3UbOQIcS74LIfqHMWUObMCxF8H7yZK5eFR9bsKlqGCwtHi44cqNYFX
         g6qzxnHai97QGL1qhvSJKW028PyQOoCpkaenTY5VQkfUKNkVQ1vmHfyY2MvAm2tmqm/P
         h5nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrGgeiUKALuxPOlif73lccbSRd6/EwhYcZnN2sPlnAN2jYTs3LHU8bNqofoy2gAgOssCQ2zsE=@vger.kernel.org
X-Gm-Message-State: AFuF++nLblSWaBwQ7vLos8wFdS3fxRz6CM/xybOo5oiWnbvAoa7M6iLA
	Xp+OiJVRDxsex+KAVJ/rlqOwB/sUd4B0VV6TumcWfEropTbr8C5LIqAPgpf+sN+5EOM=
X-Gm-Gg: AYBFou1JkWyLTb7PV9nAgmcn0exCsNaSeG6Ny2Q3MctcUqT6U8m6xVkCwkksqmwxMH9
	TILLc7qX6nGU3wKwyTWVfkK+xhLpxeQh5lyVxSQ8/xAyExnxJfC0kCf3J8fIXTxp4EwMRVQoVp1
	I5JcDgXaWTFGJzkguyJFnWnWWjM9v3lUgboR9wjRgLh+saTmR5CeF/JiYTYIGXhLd8pDBXvBilv
	HhRuq/RgomWqVXxzIhlwORP5bQB1zggcpRPIVGU2fcgtDo6XGclIeTCpgMkdBELevR0QTXpvVFA
	3dvy5QX7ArvJJh89wWOR9YZI5Yo8jSBBnnpqYLHirCItVLHSeAtWRMyuIsS70MAP0p0rEwR6TQU
	r9AosOi+3tgu+UxQFiYjjyXS75CQd2/WKWjd5q/QjjbQ7biN4vIPgMXejvo1X3wZpcrLeaF8wy8
	HmM+FC9y/iQHKDEjUCr7NE7zGNVSqjVp7cqj4GwCUno0DXtNs+2VUTRw==
X-Received: by 2002:a05:6820:1796:b0:6cd:3fcc:96d2 with SMTP id 006d021491bc7-6e7a85890f6mr268416eaf.80.1791317242352;
        Tue, 06 Oct 2026 13:07:22 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:15e1::22e:7a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e794ac5ab8sm388830eaf.14.2026.10.06.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:07:20 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:07:18 -0500
From: Chris Arges <carges@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/6] ip: Batch flushing uncached routes per
 batched device unregistration.
Message-ID: <asVU9o8eZkMz5zsN@20HS2G4>
References: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>

On 2026-10-01 20:47:12, Kuniyuki Iwashima wrote:
> Chris J Arges reported high RTNL contention during cleanup_net()
> caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
> over the global per-cpu uncached route lists for every netdev in
> dying netns [0].
> 
> This series resolves the issue by batching the uncached route
> cleanup after __rtnl_unlock() in netdev_run_todo()
> 
> [0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
> 
> 
> Changelog:
>   v3:
>     * Add patch 1 ~ 4
>     * Patch 6
>       * Unlink routes only when both devices are blackhole_netdev
>       * Clarify netdev_run_todo() does not run before
>         rt6_uncached_list is initialised
>       * Fix CONFIG_IPV6=n build
> 
>   v2: https://lore.kernel.org/netdev/20260929201546.1533268-1-kuniyu@google.com/
>     * Drop ->pre_exit_batch()
>     * Do batching after setting NETDEV_UNREGISTERED in netdev_run_todo()
> 
>   v1: https://lore.kernel.org/netdev/20260927202429.2452589-1-kuniyu@google.com/
> 
> 
> Kuniyuki Iwashima (6):
>   net: Order blackhole_netdev_init(), inet_init(), and inet6_init().
>   ipv4: Inline inet_blackhole_dev_init() to devinet_init().
>   net: Rename dev_isalive() to netif_is_alive().
>   xfrm: Check netif_is_alive() in xfrm_bundle_create() and
>     xfrm_create_dummy_bundle().
>   ipv4: Batch rt_flush_dev() in netdev_run_todo().
>   ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
> 
>  drivers/net/loopback.c    |  2 +-
>  include/linux/netdevice.h |  6 ++++++
>  include/net/ip6_route.h   |  7 +++++++
>  include/net/route.h       |  6 ++++++
>  net/core/dev.c            |  7 +++++++
>  net/core/dev.h            |  6 ------
>  net/core/net-sysfs.c      | 16 ++++++++--------
>  net/core/netdev_work.c    |  4 ++--
>  net/core/rtnetlink.c      |  2 +-
>  net/ipv4/devinet.c        | 17 +++++------------
>  net/ipv4/route.c          | 11 +++++++++--
>  net/ipv6/af_inet6.c       |  2 +-
>  net/ipv6/route.c          | 24 ++++++++++++++++--------
>  net/xfrm/xfrm_policy.c    |  4 ++--
>  14 files changed, 71 insertions(+), 43 deletions(-)
> 
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
>

I was able to run the v3 patchset locally and confirm it addresses
the original issue.

Tested-By: Chris J Arges <carges@cloudflare.com>

--chris
