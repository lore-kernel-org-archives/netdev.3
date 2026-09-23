Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BFB2F0C62;
	Wed, 23 Sep 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155826; cv=none; b=l+eutqVfQSqX4AH+Ls73Iv9wxX20+DUZLdztlxhXfmnpUu3vUQh4BsOdDx6zFKiyswHcLchy69fdxr7V7ThdldKJZ+QsaijuXq76Ef3x/t9y49nJgEVHWxNmy/bGOEiQilB4pLzi3ZSVDf8+Ez4U/wkQy/lka66PZi5OrIHyjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155826; c=relaxed/simple;
	bh=LO6Qi7dMoppLkP2fh8f91hO/tTo7FR05Vgw2/yiijxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHYbDw+ZUwemHplcMaQXkQJ64LC7YE5wA1yB/9qOAMW5c6LizR8pTRBlYsgOmA8VlHRCTKcL6bx4FPrkjQgF/tbopVBOoSRaS0RtNFhF3avfoj0Q9EY/UrYPhnWy8x2DxI2SynZCUl/m02J2NXDE6eXrrlOg3HrlmYX/VEQRTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe7wLBNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe7wLBNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D101F000FF;
	Wed, 23 Sep 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155825;
	bh=w4RZpTpwH+86+MlalggS3frcHNH26NoLVkMIGSVHUAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xe7wLBNlLFPx0gk74fc2Y7stp2cmjm6TdZQNSFVe+hNlXcqL1TargvtfuzSqEj/ET
	 AW852IBnOlnJuMiAsxxwRJca6S/T9xPkn9DvFVz3ZM4KN4wLlqtshQ5EM7rH5CxYgE
	 Z6F6p/9xtik7YIWDnjEE5M+KtfvOwp0CGtlsJzg/AMaBsB8Ig5mOy+2z6r9SKBWiIK
	 Nin9mIdax8QqRb7X3tAtRSf6wTgFGDgRZyvhIgYevc2G7ITO01NCXUUHrsqjm9U+z8
	 0/lTYwkM1whz12G7d8YlwunPnDQuy3K8s4ZQkDwkddI6VSw4gZed9gbxNYAaR4m5BW
	 tuCq5g7AAFJzA==
Date: Wed, 23 Sep 2026 10:29:50 +0100
From: Simon Horman <horms@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	aleksander.lobakin@intel.com, wojciech.drewek@intel.com,
	marcin.szycik@linux.intel.com, linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] pfcp: fix socket lifetime on netdevice
 registration failure
Message-ID: <20260923092638.GS13925@horms.kernel.org>
References: <20260918123158.5631-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918123158.5631-1-xuanqiang.luo@linux.dev>

On Fri, Sep 18, 2026 at 08:31:58PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> pfcp_newlink() creates the UDP socket before register_netdevice().
> If registration fails after pfcp_dev_init() succeeds, the core calls
> pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
> The newlink error path then releases it again, causing a NULL pointer
> dereference. This was observed with failslab fault injection:
> 
>   FAULT_INJECTION: forcing a failure.
>   kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
>   BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
>   Read of size 8 at addr 0000000000000120 by task ip/1037
>   Call trace:
>    show_stack+0x18/0x24 (C)
>    dump_stack_lvl+0x78/0x90
>    print_report+0x468/0x5cc
>    kasan_report+0xa4/0xf0
>    __asan_load8+0x7c/0xd0
>    udp_tunnel_sock_release+0x1c/0x50
>    pfcp_newlink+0x128/0x184
>    rtnl_newlink+0x848/0xe44
>    rtnetlink_rcv_msg+0x468/0x514
>    netlink_rcv_skb+0xc0/0x1f0
>    rtnetlink_rcv+0x18/0x24
>    netlink_unicast+0x4b8/0x558
>    netlink_sendmsg+0x2b8/0x584
>    ...
> 
> Create the socket in pfcp_dev_init() after initializing the GRO cells,
> and let pfcp_dev_uninit() release it on registration failure or removal.
> 
> Move the RCU wait into pfcp_dev_uninit(), using synchronize_net() after
> socket release to drain receive callbacks before destroying the GRO cells.
> 
> Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> A NULL check would fix the crash. Moving socket creation into ndo_init
> also removes the duplicate cleanup and ensures the receive state is
> initialized before enabling the socket's receive callback.

Assuming the NULL check is significantly simpler than this patch,
and that it resolves the bug, think that we should consider:

1. A patch that minimal NULL check for net
2. Follow-up with the approach taken by this patch in net-next

I say this because this seems to be lower risk than skipping to applying
2 to net.

Also, please consider CCing stable on bug fixes.

Link: https://docs.kernel.org/process/maintainer-netdev.html#stable-tree
