Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319E15C14F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396881; cv=none; b=UDf/Nzp2+Ut1KzpbCh8OoOSvGvoZ7KEkji9J4xZiFhxwi6xdKpiP+O/Ext4p4rJc5Jee23i9KOu3blYZZdmoNwwharjaIJkliWEkenjx8K+GDhlj76nwMzvKnoEAINdqlMWSRhBJS3Y9dgUhTfYdpznBi9dzBs48q5IbyQJFgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396881; c=relaxed/simple;
	bh=DX6x0YzSmCKVjStrrKsEGZKXavg2WcAocz8T+yAqzqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn0zajy4fTu+AXuVOZDpwXuD1Oa93XNNJE/rPXXHjFbFnqqBuuzLK6vvTOTB2wYYzWpuBnaWIhAi51dUzlV2UqOWtTLeH+mKhIp+MtGV9+sd5yoUYyezp7qZ375GFWZR5Qi/mqr4P7ljc38U0G5dwj3B5Ujmyg7RgDsbKfT6QhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGEUPR4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGEUPR4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114621F000E9;
	Thu,  3 Sep 2026 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788396880;
	bh=kByBFXzLTqvbt91jCCe/tGyVt4UQsMeyzGZ9cStlk70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZGEUPR4fxxXRNXBjJhKVzfLqLfvYFFSPq7jbSuhHeduHGQlQObc/nfsNklbHbtOYn
	 G+AFIY8yj0MUDyGxbhctfC48cvjlpriCLOJgWGO+jkbsbWHk7C0ffzDQwDfB+R3mkT
	 Z4rnsc2cdHEeKxrc+uc6IKjDlF6d7Wq3JW3fagTU5actzeIKq62E+K4lmDJLDzf6m/
	 XGkKZui1fx3JaVxqcDR/NHWz5ljDJ2rO6Ahusej96Gjo80RiBi2V9jnul+Ye3ox9cb
	 s+YIGszC8XR098EOfxeECiVTmhBNxx9RVocm58jw9NGetcDnktJk3zH2tG8JFrDtQH
	 zlS649/xZ6J1Q==
Date: Wed, 2 Sep 2026 17:54:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com
Subject: Re: [PATCH net-next] net: sysfs: use ops lock for speed and duplex
Message-ID: <20260902175439.02f76447@kernel.org>
In-Reply-To: <20260831080623.1064001-1-wang.zhan@smartx.com>
References: <20260831080623.1064001-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 16:06:23 +0800 Wang Zhan wrote:
> Reading /sys/class/net/<dev>/{speed,duplex} takes rtnl_lock() before
> calling __ethtool_get_link_ksettings(). For ops-locked devices whose
> callbacks do not require RTNL, this unnecessarily serializes sysfs
> readers with rtnetlink users. On CPU-throttled hosts, a periodic reader
> such as node-exporter can keep RTNL held for hundreds of milliseconds
> while an mlx5 callback runs.
> 
> Ops-locked devices can run ethtool operations under the netdev instance
> lock. The ethtool netlink and ioctl paths use
> ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS to identify callbacks that still need
> RTNL, but the sysfs path currently does not. Apply the same rule to sysfs
> reads: call netif_get_link_ksettings() under netdev_lock_ops() when the
> callback does not require RTNL, and keep sysfs_rtnl_lock() for legacy
> devices and callbacks that opt in to RTNL.
> 
> Preserve the existing speed and duplex sysfs ABI, including -EINVAL for
> devices that are down or callbacks that fail.
> 
> Assisted-by: LLM

The diff is too ugly to look at. Learn how to break up your changes to
make them reviewable.
-- 
pw-bot: cr
pv-bot: slop
