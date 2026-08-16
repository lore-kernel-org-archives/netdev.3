Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB711C5499
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865594; cv=none; b=tOM72abqyD5zrEIOTM2VW3UHCMNRLhS/hTX0+0CYbomgApBkdg7Sf5+eJA5He3VfqJBSaBZ/OrmnHKHMvKUFTos/NuXTeamvJlWbtXbmIchURdVTpzmJX3m1atI+yws6U+WOoFLG1CEp9u3bql/1Nni7U4yEyKSS6WcJaXkZ7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865594; c=relaxed/simple;
	bh=y6QcRCCfW4d495k95HuIQw2UVSsdUa46AUu5XwAig4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmSQYFpG4t6Guug68KFVLRbuBe1gVZzhImljfKNjCuqbv9/xi5ctpMl1CriZLJy7plno4METJvjcKJrqrCh0+hMOEOYNx5GzQiS0Gtu4tsPtdGM93p6VKsJ9QJA+0OtgJ1xjRMarSwAwHNE3qkeEVTPl4+B06p4Q7YznEWfeZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TFuw2vXn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TFuw2vXn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49800c6a846so27497445e9.3
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786865591; x=1787470391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4Dxzk9SYkYwJWvs5z6wDXm/t0KB0vBdS9GjuR4ntoo=;
        b=TFuw2vXnxoOW3L4BrSg8lW59lHoNHG7x/vt3XCJpW+VlNy/kKOT/GErNa57tEr30HI
         cr0u5NBjN+0iVoegqWZSM9uO0Db5uoiaBgbtHWh6im09gZ2XFgiTFJdjSKRGg5hKZ031
         0FZzUU/nIHCxAqYL49JobuXbBtiyMUDmc71aDt+BAGgupSeaUYxaXfl4ow5C9Zf59WU8
         9fN7xI+RUQ3mO25xq/Id5/l8Yi4rzg8oIlwJeAVGibJIK09RMLguUw0zsDa0rzrQQAPs
         WhuEosuLmEi9JUgDp7zNv24MjQNEiuuYNHkle9qypNr81sjriXgNr530gbPPf77pSFg4
         1vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865591; x=1787470391;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4Dxzk9SYkYwJWvs5z6wDXm/t0KB0vBdS9GjuR4ntoo=;
        b=FbdgFmNeao2CTvvrXlwfeBkYwYdzGRVSO4ZsmDCA3GgxenJwXi7yI6M0xTezi7G+3M
         u2TO0MdOescMbSLA4Yat37wqbxFITUeiZHTJed/feUPDhJyFDUri9EAYef81libo1xaq
         nIhLzkWshFFnjswJfoxQIkTPMpPET3cZJukySmIh3lVHDzys4Fjh3YyPBOhrVOhHq+8Y
         YjV81A26iBofBdOGZrqGJuMDhmU7xKQ6muhJn0NEI983q9r1HGTGMOtupPDGHrtOs5wb
         SQ+5tydlbezWYcF+dTOOkyplWXIPw3j6T/AgpAK2m4HqNbgVFEtZEHWRcMlRjfdA+6EY
         VwLw==
X-Forwarded-Encrypted: i=1; AHgh+RqTAEk8viVybwl1rg0+IjhPmdLu4U7daejC520EWUHf6PQQPr2QS7dm1H6nG693J/peB3MljjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnc0yKnM/iBoSQvTaRM/UhOUiIJss63w9CxoKRV/t65EW9K8CP
	/+sNN7+TYLa4Gdlr89rIG/WKRZUkI2AVFMAqmzinLncRL0TxiWBNwrMeRbl0SJd9pEo=
X-Gm-Gg: AR+sD116Wah5lCizMHFHOWjSRqTB5GAly2qZkhnqSeatu9CA/ItYU586k9+9v+iZj7O
	siM+YIyEiU06mdfs3hlNx9us2F9GfwEE68/IMzc1Dg/zTevdG8tTzuUChsyZ1icHxcWyTPrQRiN
	o5JpjuN8CsLif7WXwbhUIdgVFnKgJ0UwMkJqjP2y9/xcHVsdEGEfCcwNlniMTXLWcG4YRyG7pNc
	bGQ/e+yrX5knwlH3srh/OBZanXXka0PKaFYxMNFwnsNvzT4HhjmSsXFIick3+DcHju8FqBPwU5h
	zH64fw9pFjkUSjJfOxu03Plgs2PF9EuRjc57p3Hi8SBBBpSIvL/cUcXD4nej4gFsjSpP5SX1gMz
	hb5oaM/ncWTd6ErGkKxSxasJgDmjzZISdsXHuT9vPA57a5oiwZbOHHMQig/g794TkctLxrKuvD8
	lO1wf2rjpLKJbtklChUod/MDsYlt4uszz5mg9MNNGiktdXoHiy2mIwPc59J8lafu4om7ulmgIQC
	O4Yj/sv2vUGzKz/9Z/KAcs7L854Bzw=
X-Received: by 2002:a05:600c:528d:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-499900c9e99mr124668415e9.9.1786865591344;
        Sun, 16 Aug 2026 00:33:11 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm53667815e9.13.2026.08.16.00.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 00:33:10 -0700 (PDT)
Message-ID: <0d917407-feaf-41c6-af7f-080aced09bf3@blackwall.org>
Date: Sun, 16 Aug 2026 10:33:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Reject descending VLAN tunnel ranges
Content-Language: en-US, bg
To: Ruoyu Wang <ruoyuw560@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814134053.1387275-1-ruoyuw560@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260814134053.1387275-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2026 16:40, Ruoyu Wang wrote:
> A pair of descending VLAN and tunnel IDs can pass the tunnel range span
> check. The VLAN subtraction produces a negative int, which is converted
> to unsigned when compared with the u32 tunnel ID subtraction. It can
> therefore equal the wrapped tunnel ID delta.
> 
> The range loop then performs no iterations. Since the batched
> notification handling added a post-loop error check, this leaves err
> uninitialized and makes the request's return value unpredictable.
> 
> Reject descending VLAN ranges before comparing the spans. Valid
> ascending and single-entry ranges remain unchanged, while malformed
> descending ranges consistently return -EINVAL.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 94339443686b ("net: bridge: notify on vlan tunnel changes done via the old api")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   net/bridge/br_netlink_tunnel.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 71a12da30004c..05f560eeb789c 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -301,7 +301,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>   
>   		if (!(tinfo_last->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN))
>   			return -EINVAL;
> -		if ((tinfo_curr->vid - tinfo_last->vid) !=
> +		if (tinfo_curr->vid < tinfo_last->vid ||
> +		    (tinfo_curr->vid - tinfo_last->vid) !=
>   		    (tinfo_curr->tunid - tinfo_last->tunid))
>   			return -EINVAL;
>   		t = tinfo_last->tunid;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
