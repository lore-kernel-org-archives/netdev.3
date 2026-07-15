Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD72EEE9E
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129083; cv=none; b=TURRrbCXED/JGrwZKLilTbGx+lbZJ+bdT6pMBYRGWt3IFpnCj28uJNxB6A3i3jS5GPDFL38GCwh2/Y7ljEU2Yc/oaJXuZjF3xuqHgefEg9yjYLHgpnEHtgqE0QQACQBdzjtxY/i73EgpCO4n29C2ZJMzEx2zpSnLsIn1NcF8Y1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129083; c=relaxed/simple;
	bh=sEk93MFRkXZnBHH3w3/gyg+6jiWJcM1uXHZES+5BO7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuYaSq+RDXnbtwybz5wOwkyKEmu/f0vFPmn7Xwy5pZth/wuV/AWYUi62mGiKfscSLqLOeSAFUNhu/1myxGB9BFHnld3JcgJ11bAjrn+8j2rj/71hAKHOyjq3znIJoPBt89DgBP3eA+QIjWlabpr57LnQfLPEynoTyfVD9HFLXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgi+7r8Y; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgi+7r8Y"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a31b9a492aso3597341eaf.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784129080; x=1784733880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbizxbGSlmpaW+4UvpWda4ms/XR6DbFdjKqJi1v9eXA=;
        b=Qgi+7r8YcwoQGhZWiQBKdR7DuCiZEKEb9W531ojupm2J4jm+VAEuLoFcp1n2GaoFZA
         id42J6wDTVzBrXXRL6fWD9pnP7S3mf/27mix2nuIf9nHFL2FwzcDnACGWhjvKy3klmtC
         hmpbfk9KAl2msMhKw3hxJlUdm2ge+YdOX+tI7u10wA/lMhB/YQRGXlzEdEYWkSPErqMd
         NCKyjOfe0pnQfsaULrB6JDcsfMM0HozaHt8VHXDzIrmsLGXrKb0roEOxfWg0vDBJmLP5
         NdXe8FRhdIbFslQybyVP91X0Ooo/wWHNto4glzREg3pKM1YZyYutiC3be7TY6/csI32n
         ++IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129080; x=1784733880;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbizxbGSlmpaW+4UvpWda4ms/XR6DbFdjKqJi1v9eXA=;
        b=Btsh7k0mvBlx5/8+dXlP6qMKBHz30+oRlLahdWlF2jCFfJellm2Au2uq/tzBeQth4o
         DmnKDD8e0wsewfvrejOyXRdqqhQdCIBKJGMq2+3hJb0aF7PkKbXMnZOs671anKKfNi7Z
         K1l4XO9JA9ZZXBWzNVgYWjoCasdrLje4ceYlDpj1RjdMwUBo6sU4Es2BKpY2mCos+y3Q
         YEo5suaryXfqP+eNhDbT7USCWNO+3YvSXvRPSTGALZdluPQ1v/NzM+dQu0FJAkkONhST
         RTa5yeifAMIqfG23EqzAXxFz4uyAqbNay8/Q47v+v95z5+14RCnl0C70jeqMIUTQYmw4
         gmwA==
X-Gm-Message-State: AOJu0YyEHWLzLieVaVJLeFzKB+81epdwoweusH5euxwhFKwWc0IYbpDn
	oa3U8o8REwdyVHCd5/3oThcaGylyHKordiqSQQIxhs2F1eJ8irpYAexb
X-Gm-Gg: AfdE7ckXiQFoa7WDKJ3K3QBCoRAUj0eTgQVIfze4t0IwYvpiIfPmw0rFRufSys+9Xyb
	8PbRX4K3Pu2u5VaJEEyG6G5PjZfHb+gQOZYf21qQswuiciM7YMYs6kbCYBSWZ/5JhwtCEnDSJVb
	OQnFrARnNBh4OrRrJcknoI6WahHDNjYX7J8VC4XeHfOXiKRi8oeNzETkIqrfY3RV/EUHOcG7g1Y
	op+eoDFpvIZsIpQiXYRpWa7HIP6CkrUYPqEmaTeTHCSTR0CIdCcET38a3aoFgjJ408Di062qnT5
	P26vY5Kuv/QAsacfTDaYgijIg7ZTV6/+rln3eGAwd/ChU53n5meMjINfco9Q7wWdiSst+wvXyyD
	0qsr1dPyPoidvsZdju+B1PnH+LK85zjmn5+U7Yx7hpgP2WmRGJUr49pUrRieXNBbryVreWF5neq
	rXdtISGdYMjlglxtUQ3BbKFyhRPK5q+PsY5s7aByNmz8p8ZQsaJgnH35E0o6oy8cO5jngIMvJBi
	+A9OWQ=
X-Received: by 2002:a05:6820:1a0c:b0:6a3:81df:4770 with SMTP id 006d021491bc7-6a3cbb8415bmr3581307eaf.33.1784129080378;
        Wed, 15 Jul 2026 08:24:40 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:9c92:7274:e627:290e? ([2601:282:1e02:1040:9c92:7274:e627:290e])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-6a36a66b668sm15721591eaf.8.2026.07.15.08.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 08:24:40 -0700 (PDT)
Message-ID: <d9961c0a-dfe6-4d77-8547-fed90f7fb705@gmail.com>
Date: Wed, 15 Jul 2026 09:24:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mpls: fix NULL deref in mpls_valid_fib_dump_req() on
 CONFIG_INET=n
Content-Language: en-US
To: Xiang Mei <xmei5@asu.edu>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bestswngs@gmail.com
References: <20260712220903.3131568-1-xmei5@asu.edu>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260712220903.3131568-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/26 4:09 PM, Xiang Mei wrote:
> On CONFIG_INET=n, mpls_valid_fib_dump_req()'s local strict-check loop
> enters the RTA_OIF arm on the index alone and calls nla_get_u32(tb[i]).
> Since nlmsg_parse_deprecated_strict() leaves tb[i] NULL for any omitted
> attribute, a dump without RTA_OIF dereferences NULL and oopses.
> 
> Skip unset attributes before dispatching on the index, mirroring
> ip_valid_fib_dump_req().
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:mpls_valid_fib_dump_req (net/mpls/af_mpls.c:2189)
>   Call Trace:
>    mpls_dump_routes (net/mpls/af_mpls.c:2236)
>    netlink_dump (net/netlink/af_netlink.c:2331)
>    __netlink_dump_start (net/netlink/af_netlink.c:2446)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7041)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2556)
>    netlink_unicast (net/netlink/af_netlink.c:1345)
>    netlink_sendmsg (net/netlink/af_netlink.c:1900)
>    __sock_sendmsg (net/socket.c:790)
>    ____sys_sendmsg (net/socket.c:2684)
>    ___sys_sendmsg (net/socket.c:2738)
>    __sys_sendmsg (net/socket.c:2770)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception
> 
> Fixes: 196cfebf8972 ("net/mpls: Handle kernel side filtering of route dumps")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/mpls/af_mpls.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index ca504d9626cf..1ad07df89d5b 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2185,13 +2185,16 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
>  	for (i = 0; i <= RTA_MAX; ++i) {
>  		int ifindex;
>  
> +		if (!tb[i])
> +			continue;
> +
>  		if (i == RTA_OIF) {
>  			ifindex = nla_get_u32(tb[i]);
>  			filter->dev = dev_get_by_index_rcu(net, ifindex);
>  			if (!filter->dev)
>  				return -ENODEV;
>  			filter->filter_set = 1;
> -		} else if (tb[i]) {
> +		} else {
>  			NL_SET_ERR_MSG_MOD(extack, "Unsupported attribute in dump request");
>  			return -EINVAL;
>  		}

Reviewed-by: David Ahern <dsahern@kernel.org>

