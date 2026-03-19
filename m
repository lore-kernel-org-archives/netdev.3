Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DF2727EB;
	Thu, 19 Mar 2026 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882938; cv=none; b=JJgeL/9UAMjbkby4nWlNQMdmSNOz9iX+iYJp/KjddKgAJl5HIp7iNflTXV2bN87d6wxCVmPSUJb935ZAPjq9ONbtMdI1JrAxKNiygQTpn0DAgn0HcgEhxdSR+t1V79kDMmIG2ws/xb9vflfL/YM18d7HTGGwOodmoHY0WIJw+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882938; c=relaxed/simple;
	bh=lmHaLuIxd6l9RPT8kI3SSDuXCZKVfv5+v2tusvUmMh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkyS+qPyu7i/IMUUi85fKY7L/WE5C1HbBp2XhhXrT6nix0siJ/NMRB81+WwUosQ4dgO4L7b+SbomJJkhUxib5g2MhmTg06b/3YiZCRb86AVM2N7+zOqClIPXhkkYR/pYokQrLD9m3db6WQtMjwC9Evl6jjSAPfbKRPz9A76VVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRucJ76L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRucJ76L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A5C19421;
	Thu, 19 Mar 2026 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882937;
	bh=lmHaLuIxd6l9RPT8kI3SSDuXCZKVfv5+v2tusvUmMh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PRucJ76LFRPS+y2MR+BM/GgQtLQSjgew3jjrR/TTxEX3WFwroVoLUI58PH/EAbemk
	 9pGFBfKHxSnYKPpYPkvB5TijZ1yZ/YxQOfh0qFmlt/17UOElM3jwFDABzyLsL5oBTh
	 jURcf+qYLQz05ygpwsE4nIQV8M5e+T6WFvlXc6MtiMArqIih/DHJSfwjo+k8yKria7
	 00lzvgnpXc9TTsEz77QaEJOXcFFaf13OAJ8+l9+OxgBt36pC+dLp1IeGIEhvON/uVy
	 D5ZVNYfLiX5PbL0JCghiFtWp4flryx8a3wPqPff9b5+HO7btEAZalSLsoaIwYJDxvJ
	 4eO0fXGEhVglw==
Date: Wed, 18 Mar 2026 18:15:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency
 in __ipv6_dev_mc_inc()
Message-ID: <20260318181536.47ed9fd1@kernel.org>
In-Reply-To: <20260317111208.62667-1-jiayuan.chen@linux.dev>
References: <20260317111208.62667-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 19:12:07 +0800 Jiayuan Chen wrote:
> syzbot reported a possible circular locking dependency:
> 
>   fs_reclaim --> sk_lock-AF_INET6 --> &idev->mc_lock
> 
>   CPU0                              CPU1
>   ----                              ----
>   lock(&idev->mc_lock)
>                                     lock(sk_lock-AF_INET6)
>                                     lock(&idev->mc_lock)  // blocked
>   kzalloc(GFP_KERNEL)
>     fs_reclaim
>       ...nbd I/O...
>         sk_lock-AF_INET6            // blocked -> DEADLOCK
> 
> __ipv6_dev_mc_inc() does GFP_KERNEL allocation inside mc_lock via
> mca_alloc(). This can enter memory reclaim, which through nbd block
> I/O may need sk_lock-AF_INET6. But sk_lock -> mc_lock already exists
> via setsockopt -> __ipv6_sock_mc_join, so we have a deadlock.
> 
> Before commit 63ed8de4be81 ("mld: add mc_lock for protecting
> per-interface mld data"), only RTNL was held during the allocation.
> The lock ordering was always RTNL -> sk_lock (the nbd path doesn't
> involve RTNL), so there was no circular dependency.
> 
> Split mca_alloc() into mca_alloc() + mca_init(): mca_alloc() does the
> GFP_KERNEL allocation before mc_lock, mca_init() initializes under
> mc_lock. If the address already exists, the pre-allocated memory is
> simply freed. Also move inet6_ifmcaddr_notify() outside mc_lock since
> it also does GFP_KERNEL allocation.

Moving the allocation seems fine, but also having to move the
notification, potentially letting the notification go out of order
makes me wonder if we aren't better off adding helpers for taking this
lock which also call memalloc_noio_{save,restore} ?
