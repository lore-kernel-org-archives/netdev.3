Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5A64AA4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785803949; cv=none; b=XbSmeVJ2tWOZ+RbPVidcbsgNh7BYYPUS92wKcVhuTx9RX3+RMh2VXKZk2pmLQlwykZunUPepYVQ13ilyQ7IPmDQA26XOMp14SOixyVMftWyw1SFfgDmY8FjiJS6lKHtM0NXGBw2e2kHw0hSEtg5vLQgMXR9HT/m+2KD4unXCb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785803949; c=relaxed/simple;
	bh=xovwhVmpkEveCwLYJ/n21+8QALU3iHII6CXOWaplhmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2/LpbfMAotvC3qnU8gEaQVVTYcAQS4tEefrWhvKxxA+o7NragtTEsnHeuoJqfUE6KeB7D8OmbJ4AyuozkhvJpMQooo4EoqPV9fAseOnpgBpF+gvMihpDNrCIOcgg1aBJBtoqHuRPFsAuUzpFEDYW4i5hVKk+pFXz5QlerrvkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=J32eZNA4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="J32eZNA4"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e6391b114so283035985a.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785803946; x=1786408746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/EY4yD4sBtY1O5tlqAbq8+rthspnFgEnz8UM04jNemg=;
        b=J32eZNA4euhrlMo+dsE04T6ll0cMri0e4dGUHIDyJnuPBZ9ZzZUzRPC7EuIPxpOw3q
         usHrd5J5MNWUolUuKLJWRvH7UIQQ1uFGS55OccgpPvdywOWM2CprV1qzUHI8NeKGqCG7
         pw7s6GyinFk5nxoHw5wKx5/b6v5Rou+k34ykA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785803946; x=1786408746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/EY4yD4sBtY1O5tlqAbq8+rthspnFgEnz8UM04jNemg=;
        b=N2N8BWzqT9eHsXv5hFIaBqY83HPlKR62i48TS5LdV0TUMUx5isHFu0IAbwpuWtSbCB
         IYV3hhKy5RiYjOhcGpUr0KrhOX1d1TJ5+f3UBucIEkLCFwn61X4ZfjJgy5bVq+QhFOsp
         SzdwsdOdkU/TJOBivTQSMSZebRqtBwNr7vTCbKsqScI5J6cYByXDZZjocBseWAF9OuhO
         fXL64i4R1Phc7/5EpcDAfvxhoEnmDxDqwJnSQEUVosFWi/07+CrmZVgusV4+3grsI3uS
         Kiq1HhRe14LzVlTz/XdNPc07Ocl1BciMRrQGJbHqtNiShxOIYnoMDOF8UaTr8o6T1hdW
         O6+w==
X-Forwarded-Encrypted: i=1; AHgh+RpALMwKVFXx6CmbygsgikYTsLYo/qkhB2KIitM0i5Ho9qDwz+D3zbDqFgO75aYQO5Jzw6pxuZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTbu3VH9gAcSJSJSGcTBSsKEFaASbLtPOpvREwhcDXx6S9VoZ
	iTyWm9AhbsAUj6IKZKv6xLzDpGz7U1kLZzRZ71r1JUaqQYwQHr4GXIb6IXvYBgYaX8c=
X-Gm-Gg: AR+sD10vnyj7tUM/23Xtis1TR8cwEWtXg0FBHW46bx/WgS2v/FzADxoSQAoGfeGqorD
	ZonhmiRpGnblzZrGf6Z7kROkbScinDKKnc5MCVpXwk71GdIOWJFdxKOVuNVRm62+vlk2f9OpWAB
	x/qyfesTCnlJ/Tj3pc9a+xCv/e7zMC9E/9XxrfCkxJ5GwkwSHN62NaT0oc8FBDyUPg3z2/i41nC
	RwoIwEQ98dGoXqgly50+S0VfKia70hO8RYy+x3xZJMJItfp6aKuuTAzn/Tb9i9djIC9xvDWQqF6
	yL7f5F6yr3f8arVQ2DMNZZ9k96sioZdXLZQlYflYjHu6k8P2OjodunCmGXkfY/zzf4w8w/U/BKN
	kq9r+x1DX7Sna7TrVd5IdSLCc1weFqmz/ywr8ndK1RFZvpNuuXAzLrhU9O8e0zasrvBAcHBl7bq
	sFGdMtEqJuZwcd8wZmvcZsJmNONt2/ozHr2G42ti0ussXZId2D+RX6Vm0Jk7U/yucqwdrJVd9mG
	XM2ODnqAqPfnAZOqk4+20WRdW2KC3eppVXC4TGfqNk=
X-Received: by 2002:a05:620a:2b46:b0:934:b6ba:15d5 with SMTP id af79cd13be357-934b6ba17c1mr1106476785a.39.1785803946195;
        Mon, 03 Aug 2026 17:39:06 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc25f08sm783567985a.9.2026.08.03.17.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 17:39:05 -0700 (PDT)
Date: Mon, 3 Aug 2026 17:39:02 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
Message-ID: <anE0pkuSdq6ilu7V@com-75606>
References: <20260804002155.2233594-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804002155.2233594-1-kuniyu@google.com>

On Tue, Aug 04, 2026 at 12:21:54AM +0000, Kuniyuki Iwashima wrote:
> Kyle Zeng reported that GC could free a dead SCC partially.
> 
> The scenario is as follows:
> 
>    1) Create two SCCs:
> 
>        X -.   A <-> B
>        ^--'
> 
>    2) Run the following concurrently:
> 
>       2-1) send() sk-B to sk-B from sk-X
>       2-2) close() both A and B
> 
> At 2-1), there is a small window where unix_add_edges()
> publishes a new edge (B <-> B) to GC but its skb is not queued
> by skb_queue_tail().
> 
> If 2-2) completes before skb_queue_tail() and GC is triggered,
> it judges A <-> B as dead, but B is not freed because GC cannot
> collect the not-yet-queued skb holding the B <-> B edge.
> 
>        X -.   A <-> B -. This edge is visible
>        ^--'         ^..'  but skb is not
> 
> This itself is not a problem since the next GC run will judge
> B as dead as well and free it finally.
> 
>        X -.   A <.> B -.
>        ^--'         ^--'
> 
> However, X's SCC forces the next GC to call unix_walk_scc_fast(),
> and it iterates over A through B's scc_entry.
> 
> Let's unlink scc_entry before freeing the vertex in unix_del_edge().
> 
> Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/unix/garbage.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e2526..9fcaaf55cba5 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -186,6 +186,7 @@ static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
>  	if (!vertex->out_degree) {
>  		edge->predecessor->vertex = NULL;
>  		list_move_tail(&vertex->entry, &fpl->vertices);
> +		list_del(&vertex->scc_entry);
>  	}
>  }
>  
> -- 
> 2.55.0.571.g244d577d93-goog
> 

Reviewed-by: Kyle Zeng <kylebot@openai.com>
