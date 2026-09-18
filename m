Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D451123A
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747959; cv=none; b=P/ugA7EkG0+j/BOpQouAWiilWsH8Zz5/W/B+Bd1utzAfAPcpq0s7EYuVC0IuXnlWdopHVhIh2sqNJsfebINptNGTAhXW1T2AkhSQcvBBrSxEnVUKoyg3nptlYxbdd6f3ayQ6W2t4Oo/2ei8XkQkVQYUwzgpdZyxsZ1lA9SLOmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747959; c=relaxed/simple;
	bh=xR8h6ikCp3H4MTSuA1has5H3G+7wX5232DmNH/D6kMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIT3vgSOgaG84pFaXfUcoSsOzdUgZ0jAqgfUsoRKVRo+wvl0Vr3FC475MyGxl49Oy/rQO7UJzJPb6VnEscNVQlGqrEC0pLEm/puYISTcmUmdpJfYc2b1b3lFIbjPQB9vjRXBJvKfkimX7aKnmfUP5MIAtw49/uLEseabaSGXFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJJkYbS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJJkYbS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979351F000FF;
	Fri, 18 Sep 2026 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747956;
	bh=eepU3vVdehlO0bgoMlYE2yqqpdODS7efGbts1jqmYTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IJJkYbS3ryJ+dnBzPT7RX3uPl5ZbXP0hRP+xgGpHQnlCuGbw2oSzo0u9yRiRST3eR
	 yGKsvGjHtyLJx4K9JcqnkMvBWNan0uE75XWIQAtny3K2jfeVAxdtn0/jQkbDPOTI0D
	 UD3GRx4ia/rxlDOIoLnyHCkwhV1KGit0HB2bQovGqbjrkU2BNt7yoZJpn+/jnmjl0r
	 oiDmeLtgNBZQLa/efNgISFZwNpP45vGZUxY63escLO5qSTKVt6cpvAiG8mLoR+7sSU
	 jjvz6WM1VbnxSga6sF7L6gAh22/hlWAaLJIqUlh6517vlo5YYWc9DoXY5QjPBGki+R
	 c/kZJEpqIo1Pg==
Date: Fri, 18 Sep 2026 17:12:32 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@meta.com
Subject: Re: [net PATCH v2 1/6] net: ethtool: keep rtnl_lock for the ioctl
 self test
Message-ID: <20260918161232.GQ51261@horms.kernel.org>
References: <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
 <178942019771.7700.338431553546884773.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178942019771.7700.338431553546884773.stgit@ahduyck-xeon-server.home.arpa>

On Mon, Sep 14, 2026 at 02:09:57PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> An offline self test that brings the interface down and back up with
> netif_close() / netif_open() requires rtnl_lock for both. Since the
> ethtool IOCTL path became rtnl-optional for ops-locked drivers, the
> ETHTOOL_TEST ioctl runs holding only the netdev instance lock, so on an
> ops-locked driver the self test now tears the device down without
> rtnl_lock.
> 
> With lockdep this reproduces deterministically on every offline self
> test on such a driver; note the sole lock held is the instance lock, not
> rtnl:
> 
>   WARNING: suspicious RCU usage
>   net/core/netpoll.c:207 suspicious rcu_dereference_protected() usage!
>   1 lock held by ethtool/107:
>    #0: (&dev->lock){+.+.}, at: dev_ethtool
>   Call Trace:
>    netpoll_poll_disable
>    __dev_close_many
>    netif_close_many
>    netif_close
>    fbnic_self_test
>    dev_ethtool_locked
>    dev_ethtool
>    dev_ioctl
>    sock_ioctl
>    __x64_sys_ioctl
> 
> Without lockdep the same condition trips ASSERT_RTNL() in
> __dev_close_many() / __dev_open(); that check only samples the global
> rtnl state, so it can be masked by a concurrent rtnl holder, but the
> device is still being reconfigured without the lock it requires.
> 
> The ethtool self_test is a legacy ioctl-only command, so an ETHTOOL_TEST
> case is only needed on the ioctl path. Add an opt-in bit for drivers whose
> self test needs rtnl_lock and set it on the ops-locked drivers whose
> offline self test tears the interface down and up:
> 
>   - fbnic (ops-locked via queue_mgmt_ops): fbnic_self_test() offline path
>     uses netif_close() / netif_open().
>   - bnxt (ops-locked via queue_mgmt_ops): bnxt_self_test() offline path
>     goes through bnxt_close_nic() / bnxt_half_open_nic() /
>     bnxt_half_close_nic() / bnxt_open_nic(), which close and reopen the
>     device.
> 
> Fixes: f994752b1127 ("net: ethtool: optionally skip rtnl_lock on IOCTL path")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>

