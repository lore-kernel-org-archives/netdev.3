Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C834376A06
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035160; cv=none; b=FU2kupuKymknMt0JDZ3nBdDFwYI5Xnc2yTwmBQ+N7zN/wdSPGVK960EBJ/7CeCc2TybXreUXzsKReGrPIAMA3tXDVJuXiezEZZ+vGj86C+r9pFBuh+aylYFfoKrdliHepjOJcagRMEple8GjR8+fuOAIS4rKCOCQUBLwpuKOj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035160; c=relaxed/simple;
	bh=DXoaDw+nFHHzEco4U2utRXW7tSm9lEivdWkXOff4dYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWEUINwL87m2GQQS9HDNsAaL5AB7/76tmJCxEdI1IohWIC52zl90e+JSh6928ZO6CcpPyY7u0ACN0WtcpinKRa7s19JWXLtJQYr/p04cpXH51YFezN6cmC7nyO+xLSSyMtUwvs4R9a3nqvz7UIQhcBXD/icwsUIcrpj4UuKMCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fel3rIq7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fel3rIq7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422f148dfcso3450128b3a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781035159; x=1781639959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otQ2DouNzBecQjUZVVBOpIn2RERYEO1d5eIeJdvBllg=;
        b=Fel3rIq79QTJRVxWSP8ZUeM9lN3y4BXUg7kNH/vobDb1Gj9cFa7aNx+yC8UneYLqwg
         NZc8lBi4ZuWcydaDZsdHvv6Kh6EPe0uLsNtV2SR+pVLErQ4BwKluRzFGbqSunPV6bxiV
         GKVfhR2iP2VcJL4X/edPlK6STeoJ3GwFKC+L1gkm1dE833kjrmb5nlWKmwFgjdN6s78K
         akQgwxYI+864eXzUb1NGUn2XP+l0w8JeNoPF3876dxijs4lfm1F5tuOgpVY82d29lIsJ
         3gumIjVYCHCXh17loaFA5tquyPXK6sFqD+Q6JrNgwPMTigv4Hf+6zgu2q0sSiisGH9PK
         2xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781035159; x=1781639959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otQ2DouNzBecQjUZVVBOpIn2RERYEO1d5eIeJdvBllg=;
        b=hisYHcIfRRfbLoyot951JOSdQCdm7sOAf7Z4MhlHyY30yFGvZpeRiqt0pk81+qRipU
         Yp18QWTshoXpOmQr8zgyGlFad76r0HWALvzOTxIyEREPE6ZUACJz+ozAGfg380k/XQFz
         OW4Tg3LLratynl3by7VxUnXZPVYrYR3EURbKCmkEGzNHQSNWRF75BmKPTlys/HVSoTlT
         nkOs+5HkToD5xwq7GWjbTu+ZB0GhmcEXwu/463AsknK3HmZNa+PY4sbbip4qfDu1A5C3
         ziblfD9km4+F0AKQxUxMOTyzMj9k48jn6Qp2jVddti78+3oyepILBZmxDTiJwd6jur2z
         cSuA==
X-Forwarded-Encrypted: i=1; AFNElJ9d/Gy7BJOOdl4W5sUuE2n+5ayyizeihEyMnclDbOzhHq6/96xPP3b23pitJTy3mi+0INa92K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdMQ2gEnRsAPgGFkwsl6y8CXcONO7R8Is/J2QI36p8e6XT3Ly
	HfbYcqko1djXIolwftHhunGKLkJezzblhHhvmdtTmVI5LV7xsi3NYU0/
X-Gm-Gg: Acq92OE5CQMaiR3RIJIOlBOMlLO4ngok+VtWThcXJTdap2H3hvyB6ftMr/W+XnCQtMy
	ftwbWsZsQHH3NTj6jGHPsW6m63FwvocNuSRG1TJpD+6tPB1OsnJqbVj5IR5Egwt8d6l5AsH29S/
	3l4inFydJgBFpUWceV9AIP1CY0EuY1GvtspC1L83hqfJCmEGPZUggq2K2vCDi5382LI+EVghslY
	Vgn9wd90nqp0xQ+/gOuEmynLKfqhlr3FWMVLla88PQYrt4JRL+k+SSsFeGXZgumP9mHmyjgbaQb
	XEeN9ZYryt0r3hxKs2yfQPB/YpGGEvQ3RlYX99HJAZbXnT9j2354Ft416/u/Xsqm46FUijYoxgX
	ipEj1lNZHbT8LxofGfm900TMWNTzBP9FBbTi094iYVzmNOiFbPIQlQ+kNqa1GSWzoUGyP0sTkwL
	f2fBcm/OlCr3tF0qpNRi/UmPnhwPLbMtKqf3SF/lIeRs8yWU0n87dOndRSj9S5nzDMGg==
X-Received: by 2002:a05:6a00:4b4c:b0:842:7062:fb39 with SMTP id d2e1a72fcca58-842b0e1d338mr22386692b3a.4.1781035158574;
        Tue, 09 Jun 2026 12:59:18 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm22974276b3a.50.2026.06.09.12.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:59:18 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:59:16 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 3/4] netdev: avoid skipping objects on race with
 device disappearance
Message-ID: <aihwlI9A2TKktq9I@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-4-kuba@kernel.org>

On Tue, Jun 09, 2026 at 12:08:03PM -0700, Jakub Kicinski wrote:
> If the currently dumped device disappears while we were mid-dump
> we will get the next device without resetting the sub-object ID.
> This is quite unlikely, it was reported by an AI tool not a real
> user. Let's fix it for better dump consistency.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index d35af460e886..18046ad0f883 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -310,11 +310,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  			err = -ENODEV;
>  		}
>  	} else {
> +		unsigned long start_ifindex = ctx->ifindex;
> +
>  		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
> +			if (ctx->ifindex != start_ifindex)
> +				ctx->napi_id = 0;
>  			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
>  			if (err < 0)
>  				break;
> -			ctx->napi_id = 0;
>  		}
>  	}
>  
> @@ -634,13 +637,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  			err = -ENODEV;
>  		}
>  	} else {
> +		unsigned long start_ifindex = ctx->ifindex;
> +
>  		for_each_netdev_lock_ops_compat_scoped(net, netdev,
>  						       ctx->ifindex) {
> +			if (ctx->ifindex != start_ifindex) {
> +				ctx->rxq_idx = 0;
> +				ctx->txq_idx = 0;
> +			}
>  			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
>  			if (err < 0)
>  				break;
> -			ctx->rxq_idx = 0;
> -			ctx->txq_idx = 0;
>  		}
>  	}
>  
> @@ -786,8 +793,6 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
>  		ctx->txq_idx = ++i;
>  	}
>  
> -	ctx->rxq_idx = 0;
> -	ctx->txq_idx = 0;
>  	return 0;
>  }
>  
> @@ -902,6 +907,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
>  	const struct genl_info *info = genl_info_dump(cb);
>  	struct net *net = sock_net(skb->sk);
> +	unsigned long start_ifindex;
>  	struct net_device *netdev;
>  	unsigned int ifindex;
>  	unsigned int scope;
> @@ -934,7 +940,13 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  		return err;
>  	}
>  
> +	start_ifindex = ctx->ifindex;
> +
>  	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
> +		if (ctx->ifindex != start_ifindex) {
> +			ctx->rxq_idx = 0;
> +			ctx->txq_idx = 0;
> +		}
>  		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
>  						    info, ctx);
>  		if (err < 0)
> -- 
> 2.54.0
> 
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
