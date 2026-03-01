Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE03430BA4;
	Sun,  1 Mar 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388318; cv=none; b=QtwkAkZ9ncDYa9J3r62jtdnUN9kTL/vtanw3z6I7AGINL3vCsqSnRiNmhR/tIBXpIEMx2wvcYnWPx/rMsuLaxU2X/ISc1419E7FgnsyLKuiRiI7AI0/T5XAdmScQbt0lZc/UqNDGGQ7/WIiDpy9Sde6NezgMU/JMY0itsRBT+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388318; c=relaxed/simple;
	bh=FuONouOQ7xTSmkKxI5aDnRBG+pYeJzqUlo7ibxt3hlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZHUBcP/QktbkYD/NKTKy1zH51OQCkuGQUVUNSMHWd5RNJchzhqDIZWIZj3ioP7S3zFsHYyD+ym0fpHm8To9qh+dgLOM3c/i+6X0ojikvu4IWYjvyyJtUDoOcffGwYMw5mkD8QGO567KsZWZo1MG1LtWph4Z1ateBCV8Axr/nEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH0zSv0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH0zSv0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBDEC116C6;
	Sun,  1 Mar 2026 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772388318;
	bh=FuONouOQ7xTSmkKxI5aDnRBG+pYeJzqUlo7ibxt3hlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MH0zSv0nWQl5BDwU6v6TmZd0y8PY6P08M92W+b7ENA/KdbzabKczr+3cN9It87bQh
	 0eK96nkSke1uhUw0nyiehY6sZc1C9UacZ+wn5dZ2mVBxTONFzmtSHP1ttxeaGkYI1T
	 xCJrTLERoF6TmDPXBNdG4YfrLfwejh9h/2T6RWCXervqsbrkneq9AyCoQOnfo+8ROT
	 gwyEprrVO1TvjsUJA1WTFtyuE0fS85BXiyeKoXsh5/BPzNtdkyx8bugWHQc3v0Nvf8
	 ra+Gu65WroQHUEdphqrE5a3Qg7qpdVRKwEOpMQsRQKoaXoq612cK0L9QS16sO69sJt
	 3zASVwlXJDbyg==
Message-ID: <b2c3b7c5-df56-4f5f-a51e-fc76257dddad@kernel.org>
Date: Sun, 1 Mar 2026 11:05:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: nexthop: fix panic when IPv4 route references
 IPv6 nexthop
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260228031400.163009-1-jiayuan.chen@linux.dev>
 <20260228073959.0ef1b33f@kernel.org>
 <3a00c5bf-6740-47c3-b885-c1e0cfe62289@kernel.org>
 <CANn89iJjjNW4U6ZxVcuRxWaKPbo1wfEyBD4Etkf+f6CWyhAHFg@mail.gmail.com>
 <d3722ec10046a2fde021a2b8a51a83431c8bcbac@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <d3722ec10046a2fde021a2b8a51a83431c8bcbac@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/26 6:57 PM, Jiayuan Chen wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index c0350d97307e..4e7c44101709 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3643,6 +3643,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>                                 goto out;
>                         }
>                 }
> +               fib6_nh->nh_common.nhc_pcpu_rth_output =
> +                       alloc_percpu_gfp(struct rtable __rcu *, gfp_flags);
> +               if (!fib6_nh->nh_common.nhc_pcpu_rth_output) {
> +                       err = -ENOMEM;
> +                       goto out;
> +               }
>                 goto pcpu_alloc;
>         }
> 
>

Already done by  fib6_nh_init -> fib_nh_common_init():

        nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
                                                    gfp_flags);
        if (!nhc->nhc_pcpu_rth_output)
                return -ENOMEM;



