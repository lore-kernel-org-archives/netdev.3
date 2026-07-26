Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE4311969
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785060848; cv=none; b=MxrxZISablDRdIwCdTHUAgkcy9pmv66SQRXB7wkO6TWqhXYba3bKpptI2V40Ty5+CCgSrktw7p2PUYWZE3a3gujq3bLhVdnURErbmLjzkK8x1NXe/pT8swXeysj70fDCz2QPWBMH4l7LXMsm+j9mwpxnLbUEMEof7aLXvjBXNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785060848; c=relaxed/simple;
	bh=h1P5btjzqqAMj2JC/X8BiIMgvZUoT0u7grKnwIzMGNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEs7uLznaXDr5UDysSEx1bjT+46CQmaVf+blklFlGVOZsAGft6671RwRUqhghuSER9/PFCzx0AB/ZOp5jOB2TwlMggv+ubhmgv5azFNelgjPL44xoFTU9UltLFX5pY+dPrVELGmV9hML1IRxUgRy/I7N9L3WH8qwqk/nu1wdm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DsAYRiII; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DsAYRiII"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so11256615e9.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785060845; x=1785665645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDxc0+6iV2GZQ0LIsObeEGPpkXqQEjGEB1+96GPkh0w=;
        b=DsAYRiII0z46xLMODLhdXX6FTdSWsC2IH1WKUXn1ajSMLETkWe8NRDXRbEGImqZMTK
         a8KMcZLcU/g2QQabFfa+Gs31/4xiqiSDSTS9i/xn4qoy4m6otZroS+yB/1e1xpStFkQU
         3HGHb2mHOaueTALdzayGcNN83/N6MlIOaHcfr/132hd3IPlmbdEKTPBeEr8+YK+Z6jCi
         IuZ4cynlBtGMEmS9fT77yCsM1XSJHYq3zzTbT8tdCzl18QD1/nuLf1XM/hqlyyxWoHwy
         b94nfFq4Ce5lW2MYAOmeGK9o4mJGB7TC0BduductCmisk65yKWg9o5M25JHLjQ/5/65F
         E3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785060845; x=1785665645;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDxc0+6iV2GZQ0LIsObeEGPpkXqQEjGEB1+96GPkh0w=;
        b=JWEe4I0lpXH3ZZVxr8kajQ5jYxNlAWpRKjLYI8b4cfc4QSEzqtZQoXXKcXC7S7Qw0B
         6WgJDmd5vDXQaG+fmZ46nzPAjDcxICGTWVe5fEAYv5NTSZ3qhv9B3QXkyIMWILC+TqPy
         si0bj2+xyTsKpoaLeKhStlID3LQeivK9BoTD+/sGwhes7e1tJBD4+txpA5xY207BXXXl
         YvgTbq2w6/rcUxcJHGGIGS2JDLy9VMF6ppO/JZOnndPu+t4j6NIhLudjHjerCydpKIVc
         w+qgN5poU+B+1Nt9MX7aXOiqYp1f02sK/+5P6ECird5PyUZrXGjJtBzPNFF+b6rHv2O/
         tMmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoE5Fxk1ydhy2kogFZihyOezPN9C89uovh1fCZ9G0ts6lWWMx1OZX9Q4Bwo4fFL7SsGi/nDh1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHf+oxu8qm0Fv71e7jwEsGZj31ZyOCCz/xi4uSyGAv/xbEPJ4
	cy3oXRMkwM0//2eyqo4b2SnXOc7QiaQ/9IKrnL40uY1nX50E94ji+q+LdIkGoRr/XO4=
X-Gm-Gg: AR+sD10KKnzPcr/dlqeK/ZVPnJYRCzOHENuDaJMZdNLUD9HYL3UKmzF1WSVnZkXKjvJ
	5URNl4fSQVd7jcYw3jsa54HS/fUUO5QhxCAq97cCRpQK7LbyJ5RYNUvypx3mLJjZ3Mg9FElyykl
	u3DzXkVTgW1w+vDDDi6Cj5g7KH6rz/40e5vpVnm+ES/YrF5ko3iIHFJxP70diJi5v4e8yS48q8O
	Gl+QmgZx1QZljGX3N/qMADEkUlsonr303m+cUCR3+7PUllte/mrHfDEkqzqYbko3OZTnjBGwCTM
	gdPXwF6nqMyMIGNCvUG1E++rA0U9JZU1YdZ4Ioj1DaaoVuYk6dvAgMHbAgMqmWDT0rlxQllTxhA
	4jXagdsrpV5taS5IRov46Z5UmeHwIshQt0tcInx1qGIjTz/zo4wBuyI+fPD+o5MS1VowP8nIBvM
	hzg/UJLKnY
X-Received: by 2002:a05:600c:3e10:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-496b57160e7mr53193435e9.19.1785060845317;
        Sun, 26 Jul 2026 03:14:05 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm162079695e9.1.2026.07.26.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:14:04 -0700 (PDT)
Date: Sun, 26 Jul 2026 13:13:53 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ren Wei <enjou1224z@gmail.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, linus.luessing@c0d3.blue,
	vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH net 1/1] net: bridge: stop fast-leave after deleting a
 port group
Message-ID: <amXd4UTdaREoxTpG@penguin>
References: <cover.1784707712.git.zhilinz@nebusec.ai>
 <1cf0898872ef7c72d5f4c0304414a192c6dac591.1784707712.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf0898872ef7c72d5f4c0304414a192c6dac591.1784707712.git.zhilinz@nebusec.ai>

On Fri, Jul 24, 2026 at 12:52:48AM +0800, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> br_multicast_leave_group() iterates mp->ports with pp = &p->next in
> its fast-leave path. After br_multicast_del_pg() removes p,
> continuing the loop advances pp through the deleted entry.
> 
> If multicast-to-unicast was enabled, the bridge can hold multiple port
> groups for the same port and group with different source MAC
> addresses. Once multicast-to-unicast is disabled,
> br_port_group_equal() matches those entries by port only. A fast leave
> can then delete one entry and continue from its stale next pointer,
> leaving mp->ports pointing at a deleted port group.
> 
> Fast leave only needs to remove one matching port group. Break after
> br_multicast_del_pg() so the loop stops before dereferencing the
> removed entry.
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/bridge/br_multicast.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 6b3ac473fd22..00aa9b2879d6 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -3687,6 +3687,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
>  
>  			p->flags |= MDB_PG_FLAGS_FAST_LEAVE;
>  			br_multicast_del_pg(mp, p, pp);
> +			break;
>  		}
>  		goto out;
>  	}
> -- 
> 2.43.0
> 

Yeah, all other places which use br_port_group_equal do exactly that
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

