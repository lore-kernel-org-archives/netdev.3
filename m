Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA847D930;
	Sat, 28 Feb 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293201; cv=none; b=mKWmhlFMwfdTNpUF7j2egX+0vN44j/3jcfhLI0TJE3zgIv+KbLzE9aWenXzN+UXAVmVeKE3KTJ8sZ6LdrwNGUqCHTOja3wFELcd0bt5Qbdn29Vczl7qGOK9z6CzXqWJdhtdlgfRjwdIo/QB8hWnDBecsvlvd8OncWutHIYb5OpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293201; c=relaxed/simple;
	bh=csspmxNZhkmoxudo99/uuLUpzgU2EvZBCLsd02ysASo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWEu9wOhfa6AHHsFqcqBZ+zUbdOAD/+Jz8VJCRHqOB8d1WqU3lVJ70wVPY0RvO10nW0RXOI3I2XjNQdYnGL7J6gq2i1Hgme+Zd9naXTlwcv/yd3MlQqdp0XaZ7Hm1GVCOkZ8j+B2y7wnaRmJY4VIZPOidDMJktBVwaP7D2D0mO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNYHjIKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNYHjIKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BABC116D0;
	Sat, 28 Feb 2026 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772293200;
	bh=csspmxNZhkmoxudo99/uuLUpzgU2EvZBCLsd02ysASo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bNYHjIKnQVKheot51RWEEIRyoVUMnWQYQlpKCE6gAsRM01Pstvjusl0xC+xvp7ODy
	 kwevxeUxUNcflIP+1uE5cuHB3Zdp9WtOHboQTdaKYhg91asxKtDjOH1jqTSaDUKFoK
	 cBl46+f1iaMRLRx6j/517Voj2XIOA5wSMXpwszMUvqBdbhrb9ekKX3VulIpwB/A2Y0
	 i3rRKysOKutHwOJgmsHjJMxKMCLcFM9p/OjPVUoInHzQcVqzHNvXWlQkY6eGkyuGu4
	 yZZfaZdquE1/eoM2+U+xuOkCc8/k4Sf6zMC29glFtmFMIOaJSpoaZEx+GyV3NhEnSy
	 bFT+nPO0fuovw==
Date: Sat, 28 Feb 2026 07:39:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com, David Ahern
 <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: nexthop: fix panic when IPv4 route
 references IPv6 nexthop
Message-ID: <20260228073959.0ef1b33f@kernel.org>
In-Reply-To: <20260228031400.163009-1-jiayuan.chen@linux.dev>
References: <20260228031400.163009-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 11:13:59 +0800 Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> fib_check_nexthop() does not validate that the nexthop family matches
> the route family. This allows an IPv4 route to reference an IPv6
> nexthop object. When the IPv4 route is looked up, __mkroute_output()
> accesses nhc->nhc_pcpu_rth_output which is never allocated for IPv6
> nexthops (fib6_nh_init does not call fib_nh_common_init), causing a
> NULL pointer dereference.
> 
> Note that this is not about IPv4 routes with IPv6 gateways (RFC 5549),
> which uses an AF_INET nexthop with nhc_gw_family=AF_INET6 and properly
> allocates nhc_pcpu_rth_output via fib_nh_common_init(). The bug here
> is an AF_INET6 nexthop object being directly referenced by an IPv4
> route, which is an invalid combination.
> 
> Add the missing family check in fib_check_nexthop(), mirroring what
> fib6_check_nexthop() already does for the reverse direction (rejecting
> IPv6 routes that reference IPv4 nexthop objects).

AFAICT this breaks a bunch of tests, quickest to repro with is
gre_multipath_nh.sh but you should probably run fib_nexthops.sh
on your fix as well.

> Reproducer:
> 
>   unshare -rn
>   ip link set lo up
>   ip nexthop add id 100 via fe80::1 dev lo
>   ip route add 172.20.20.0/24 nhid 100
>   ping -c1 172.20.20.1
-- 
pw-bot: cr
