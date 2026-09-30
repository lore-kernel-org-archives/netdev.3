Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9792370AFC
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735640; cv=none; b=pixqbXiSArdhcZ6QgsJsZyBu0u1wSokyzXel628HjzcU5D2Y6u8EcsAvXzE08OkeCQSOqczpuhpe0ICyGDcjC8PwGFM8mWpPqSPGIeTB9WGvzWegMuUTMHR8pUt/p+0s3pftlWrqc4wOQDjFwtToDl9jSXv0jMtvKMqMzWmZ2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735640; c=relaxed/simple;
	bh=NHTef/IaCOVMoJ5oO2lol0WxJCz6IyfIJhQo6Bu98xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVJ2UaTLhvmLbgFPHOhtM76KmssZNCd2Ltb6nMuBgdInwAc30HVdgBHB+C8Y7edl0hwoLca5aqHt44rOmNVOMShaOQnLl1ehC2tpeCGKPJZ41ZeNRc+Jbkmt7k0I+J/NKUP0soMUS7N44xwEh1jB7/N7rV907C22yLvrnaEiTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UrelUeGb; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UrelUeGb"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7fcb425fc2bso3040394a34.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790735631; x=1791340431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WimeQAmU72TV3I87w1mthEkhUyR0hLF8H4rHCIJsrKo=;
        b=UrelUeGbogPMxZgLuNVIy1Qyra2DiWWG0S1YAALwZA+X+M+veXDrJ13Ld3iFP91BfY
         ncooSU6NyYkBQp1qA4ZS1UNbB/uoGERLOwJDdLV0PuR1QWYgRpC5NIVqk1R00gGpTlve
         CF5a0OLkGNiHzLuqWRxqzGcoVsa/eVlOmHLXwxwlHluA4PTa4YylwFJ7pQSDh1fhIRUC
         ZcliyM96oQKrCMx+edrpT8xhasE1yG6OuzHU5PWii0LZBvxdZJNlaVXbRBQrEYtznEek
         4OtGfDpECqhgeERJSrjlRIjf0Kf8Rqa5hUkijaUpWiSYcCwmtFr8kR0RWTGTZLjurNy0
         GxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790735631; x=1791340431;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WimeQAmU72TV3I87w1mthEkhUyR0hLF8H4rHCIJsrKo=;
        b=kBClxvljG4dQNGpW+/qf+OZJElor/uALHx20oghXlNt2kQ7WEHcIw731kLiPHc6ENr
         g6j8EA5/u41qI2LNyKHEn2cCA/iQE4OazS6w2Hq0y3RRVQv4rGAzEpE+TFxPR2mMipFY
         0fNitWy0koUhJWkOzf1Oc71m+tPpdfCsJ/WbwhCYgIHQ4uduBVRsWGPas/ftdJ280Ual
         knP7kB9HpWdiDpt2VpHq8QDxnAcbA5bmUDKdmUMvdXvm4IhmL7UbXJG1rUTk0FBsAvqD
         4r2quYLX1FxiHR7O7/tF/z8H4AKNWmDx5Y7MSnJl5ZWYKgeLMrhO9Q2YsgdbRnv+b8uM
         bhcg==
X-Forwarded-Encrypted: i=1; AKwUvBx9pMFFlHxvR0nsRrCK/KuTY0pJOd2DKMcuarXS207ujGfJsHkVDGVvKMCROuBZjhlf5Bg+6SY=@vger.kernel.org
X-Gm-Message-State: AFuF++lhP5NLoUaA+dyufE3ullWPytGtdPk6xpQXsoi1wpN6mX+XyBic
	aqAGZve7ibb8IjCMAJjIht2e9X9nPLRjBh5FIFygbG2h0FTioghm7xCZMxQZaDBaGww=
X-Gm-Gg: AYBFou0rCwEKjckENhUAL4gBgnzwrhS8hMZOqpFnHa1Z94rfJExjaQcWiZ7JWQ6Wxl6
	v6tOiR81i5V7bObBed1MTVcZBWws/CpVtnqRz/cbMl61bQgJTgKpBCxbPEd4wStRq6X4yYsa+h9
	GiiA98wWxBPjhtXFkb4BINYgqV6o1ZYKeNsr2LMJ9l5ugsuF4/OJ14Ghy+d0IHMEs1XLE5JyYF0
	MHn1kFQdtLbDNaXUVBrMCJhrLex4DoEAG2e/b8UoCA/V3vVphhuKKlAohhmslA+nbBSCvRgMw7Y
	IJh0qYbyiTU7CWjKR+l1qzfwkYaNVBRGy+jb8SYhqKsu2o/UBoBr4tsSc5ubG9ROnaaM8/+EAxT
	JZ/mjIE4lFJ6CW142pioqmq2AsTRuH40t8cQuHrOYSSl7YRak6/9xElZg9NS0h+0vQTE9c/WrCV
	stmpTXVjsFQn2kMQ0iWGHNFcR0h0TcqUNaZXUH5Lz0qMLYO8k04eQZ
X-Received: by 2002:a05:6830:6a8d:b0:81a:cc8a:ff8a with SMTP id 46e09a7af769-8204a75d1e7mr152408a34.21.1790735631284;
        Tue, 29 Sep 2026 19:33:51 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:3064::4d2:8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81fafce0ad8sm1630636a34.22.2026.09.29.19.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 19:33:49 -0700 (PDT)
Date: Tue, 29 Sep 2026 21:33:46 -0500
From: Chris Arges <carges@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/2] ip: Batch flushing uncached routes per
 batched device unregistration.
Message-ID: <arx1CqxoGGRdxv5-@20HS2G4>
References: <20260929201546.1533268-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929201546.1533268-1-kuniyu@google.com>

On 2026-09-29 20:15:06, Kuniyuki Iwashima wrote:
> Chris J Arges reported high RTNL contention during cleanup_net()
> caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
> over the global per-cpu uncached route lists for every netdev in
> dying netns [0].
> 
> This series resolves the issue by batching the uncached route
> cleanup after __rtnl_unlock() in netdev_run_todo().
> 
> [0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
> 
> 
> Changelog:
>   v2:
>     * Drop ->pre_exit_batch()
>     * Do batching after setting NETDEV_UNREGISTERED in netdev_run_todo()
> 
>   v1: https://lore.kernel.org/netdev/20260927202429.2452589-1-kuniyu@google.com/
> 
> 
> Kuniyuki Iwashima (2):
>   ipv4: Batch rt_flush_dev() in netdev_run_todo().
>   ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
> 
>  include/net/ip6_route.h |  7 +++++++
>  include/net/route.h     |  6 ++++++
>  net/core/dev.c          |  5 +++++
>  net/ipv4/route.c        | 11 +++++++++--
>  net/ipv6/route.c        | 18 ++++++++++++++----
>  5 files changed, 41 insertions(+), 6 deletions(-)
> 
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
I was able to test and confirm that this patchset reduces RTNL lock contention
with my test case. Please add:
Tested-by: Chris J Arges <carges@cloudflare.com>

Also for "ipv4: Batch rt_flush_dev() in netdev_run_todo()" please include:
Reported-by: Chris J Arges <carges@cloudflare.com>.

Thanks,
--chris
