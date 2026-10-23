Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745274;
	b=YyN3uj0wgnijDhFUhZgrKX0ASY8Qyy47Wo48Lwh4JJ6IO8X4q4nJt5GO/+ybYM7fxwy5
	 Q2o+5r6dREnTWp6MGgFTiOIdzoLCPGKSTurE6JR0zKHuLaaZp2HgNCWdpsY452P1FQ34v
	 Dv7bawK4tIi/BMWIticZc6ooWPFUMfVkIjBO9l/vEAKwmQtgLpA11bhvhMrk8jwHoHQB7
	 ALHaiqYd9eVVwLvrVvPtIk11r3GenUlqrJqiwG5edZbowXoloJyFd5OEcvLuhfsy+LFJi
	 CpOm1gIAcyohbBqbOd15/8HQPt1l8nbE1LtADlAQMuilu2tpBisg9OGaY0P8bNICfqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=mcXosW2OV7Dzgaxf9eJAPNhpQPkL1o5sHEtJNdoFfAE=;
	b=2/i9E8Kc13z2RMcGIyVmCNwUCchn2nNFDyA+4sdbXnP3c02xmkpORPXKhg8ZIPQNvjm3
	 T6W7hzgMj+aT+CMkM7/j2jjQXHw8VmBjq4CBEiouK5MDY+wuWtD7tHhV/qvyzxwRTDJHm
	 xmDuI3NgtfaboClMf9Y5Am7HWelMaKp9lTw0+x89W/RjOifHjV/1BD4HYW4xEvj56NMxj
	 oo4AezzYMsLizZr9E3s0G0BHoTi+wUZpY0ZiBLXlboLMHhC8CRCFrCAEDug6l28kKK0DH
	 BwxKGMC3vtdacKRyFYJLnWZQZIAuCwxJBFtXtdC4Qne0kZrn1spYMpE7Ooh8C+o3yGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=waldekranz.com;
	spf=pass smtp.mailfrom=waldekranz.com;
	dkim=pass header.d=waldekranz-com.20251104.gappssmtp.com header.i=@waldekranz-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VRGTnBSi;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A45606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A45606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=waldekranz-com.20251104.gappssmtp.com header.i=@waldekranz-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VRGTnBSi
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so665536a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20251104.gappssmtp.com; s=20251104; t=1792745272; x=1793350072; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcXosW2OV7Dzgaxf9eJAPNhpQPkL1o5sHEtJNdoFfAE=;
        b=VRGTnBSiwDJKAy16ONtQ4HusEuGeVtV/5IMrKHq0pwuvXbDxGSdfUxDNRe3ab5hQ+4
         JC0WkH4BNwJTtfFnWz+L4Gol60o8Iprh50mHZ2tmLV55r7i+IeySPmTT+Y9dgwczcYHQ
         AZYZLUhREM3nGXuM6gqrnpjmObByH7eRUyXTi6fXahCJDzVSn6OMFWApcQbvBdsSOv0G
         nSZU6KHOTCRY/F82PPIh+c8wzrq3/vDdgp8GsRt2ztDIJZeWZMiG+X1vUiFTJJE6mv7X
         qKw9bsbbOgyA95WINOs4kM6mC42Pd/T/Zp6B+x9xauQIuUd3LWXVq7baQ0FYV5LKbFVW
         TIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792745272; x=1793350072;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcXosW2OV7Dzgaxf9eJAPNhpQPkL1o5sHEtJNdoFfAE=;
        b=VLHSRGYAoJiC94GlRLwhedkZ3iXKP0lGWgqNQKhoF+vZ64DxIW0IuvxSVW+DeA/AAd
         MU3baDD3vr/CZlmzGQ8eHso98kj/GrDt7nfRh094aLdy1cwFliRXvgxSKTqKGVHPovMA
         h5Ij6cZ0uvsIzaVedpjK2PD3g+uH6OzV0RdSZF3KMEl8nat91Cdki3ha0CFabJFCyvv8
         /II36J3+8UWf24WvSPUXAbXOsI/s8ssoGC8rNEQUaulVCJ/q9YZMWEaEa+0pUyZ0BjhX
         ZtKBQbrr19YjUINgIwiph42NMJghh9D0ymQlA6XxedrxVZP6q/9WJ28NnSE9wGGwWeIi
         J/EA==
X-Forwarded-Encrypted: i=1; AKwUvBzoc8Zy+IAT084F7Sx/N451UKH0N1WLs6nS7l078yliYFov7c9HfgHKqxRGFA3ZdYISnhaeOAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKRp2aAOd6lkSQnkhSohPXsJe9R9S1r9F+NFY9U5N9IJ/2bcXm
	XFvtiOpDm3ZcSpGjuj0Exf6jNvBdikuQh0gh7IoGHo6gPhWf5o4ow6DitqODj72cmoM=
X-Gm-Gg: AYBFou1muMbzHAUJb/OlQmOFeS+e2q5VN3mSIq/vNKDWKqrGAOuOJCoVUSLGuoUD90Y
	0M28B/yPt6VcsYNFdRWQxST1GCBmmg0iBU/1pkPpyVxcJ0RDhsyElOjCYzMTBcoYCqww42rBTEL
	4oIt4VeXzi/mjPYtXYBLkvod6L7i9oHP/UvD3rKmjnOMR+fUelsZ5pTwROTR0dPP+mH2k2F1GGW
	SJSgqJBR7HVhQ2FExnP0w4ORLjm53TW/XUJIiv85gb85TpySMPogNKi/VcsXew5mWLUU9DUP+yE
	Di4TIQ/eGo2dQBW/NaXLvO9OIU0g4/JzfjH2RlzSU2p7ONpRvIVnz4i7Dvy6Pvm1/ElC0yK0alS
	BtHfqxZM6wWXsnKOVK2AnGufGyAkvODH4C8vWjcS8M3FYixFMcXtA2sqStF8SnfN23Z/05C3D89
	rbQmxGLSZ6atB4QWdTRI0GtKPoCh3ly0Wr27hAC7m3JqAjQhb2bUQcjBoHlKqXanrH4QVKtikJ8
	BjxLL98dnmuRZ14U/VroxElMkDjT6ee4IH1u+VDMXV7wlv6HG8P2SyLCcUomTBre9r7EXYCkKPe
	rqOoJeqSzfKm5EEq+hAAfQXy00+dz2j5hJ/6OhVUC0WazJmwyUDsTsAUjlmjXoY/t3MuUfQ5U9O
	n9y8p7jaNd/0xUMw=
X-Received: by 2002:a05:6402:5004:b0:6aa:9284:9a99 with SMTP id 4fb4d7f45d1cf-6b432b14825mr2549227a12.6.1792745271895;
        Fri, 23 Oct 2026 01:47:51 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432cc9775sm840508a12.28.2026.10.23.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:47:51 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Cheng Yongkang <teel4res@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: do not bypass port state for MST
 without VLAN filtering
In-Reply-To: <179268538303.70821.3493915601694605045@gmail.com>
References: <179268538303.70821.3493915601694605045@gmail.com>
Date: Fri, 23 Oct 2026 10:47:50 +0200
Message-ID: <877bj8iz0p.fsf@waldekranz.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain


Hi Cheng,

On tor, okt 22, 2026 at 08:26, Cheng Yongkang <teel4res@gmail.com> wrote:
> br_mst_is_enabled() is true when the bridge MST option is set and the
> port has a VLAN group, and nbp_vlan_init() installs a VLAN group on
> every port even when VLAN filtering is disabled.  While it is true,
> ingress treats the port as forwarding and egress skips the
> BR_STATE_FORWARDING check, so that the per-VLAN MST state is enforced
> instead.  That state is only checked when VLAN filtering is enabled,
> though: br_allowed_ingress() returns early otherwise, and
> br_allowed_egress() only checks frames that were VLAN-filtered on
> ingress.
>
> With MST enabled and VLAN filtering disabled, no port state is enforced
> at all, and a port in BR_STATE_BLOCKING or BR_STATE_DISABLED still
> forwards traffic, defeating STP and MRP loop protection.  MST can be
> enabled in this configuration, since br_mst_set_enabled() only requires
> that no port has a VLAN, for example with default_pvid 0.  In that setup
> a BLOCKING port kept forwarding broadcast frames while MST was enabled,
> and stopped when MST was disabled.
>
> Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
> state bypass") stopped this bypass during port deletion by also
> requiring the port VLAN group; the bypass itself remained.
>
> Also require VLAN filtering in br_mst_is_enabled(), so the normal port
> state checks apply until VLAN filtering is enabled.
>
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
>  net/bridge/br_private.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index ff746f036f54..85065304597e 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
>  	/* check the port's vlan group to avoid racing with port deletion */
>  	return static_branch_unlikely(&br_mst_used) &&
>  	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
> +	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
>  	       rcu_access_pointer(p->vlgrp);
>  }
>  
>
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
> -- 
> 2.34.1

I suppose the other way to fix this issue would be to require VLAN
filtering being enabled in order to enable MST filtering.

From a user perspective, that seems natural since you need to associate
packets with VLANs (i.e., have VLAN filtering enabled) in order to make
any use of MST filtering.

From the bridge's perspective it might be less desirable since it would
mean that the two options would become entangled - the bridge would have
to refuse VLAN filtering disablement while MST is enabled.
