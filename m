Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877893DD86A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267923; cv=none; b=Q6jhDHEM5mgxIWjJq4IbNOdad7yf4IpdcPDi/1m4+BV2bCF7nLaEYBktgh7hDjWsdfOrNhi8GHW/EjDAPEV3t2fAxNhLk1cleHwF6JdEkTu7qWFLrzXExQOf8qzehk/39zllRWpKLSUwicDggmrMQPQ+pjkz0HAL6XrDkAIvB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267923; c=relaxed/simple;
	bh=2VO3DTVvup53a8b6mtz14IR8zvNIYXKF8tMu17niY2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STy7jyi1GqHXiYxlu4SQ1TnppMY3IQQV3LFTem4/IJE5kpJBLa0pMw6yO8gpb4hMW1RVhd4kUkY9lg4l8ZAb5snbGSTHZOeBQWJDfSMxep59Vb9lx9eoxwF5VMolkadOQf9tC1pdszwlwyaIGsmxf7UFTl11fPPCwvXmkXEHQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNxswPx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNxswPx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D471F000E9;
	Fri, 12 Jun 2026 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267922;
	bh=/iniJO3J7ejHxZqxaL7RUEVPeDd2EIiz11xjqJTsMD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNxswPx3Cuh+1yCG+L0pOhCY9Cp5DENeb8BZJTTq71KIOZLJQkCPLeEMiSjncGoVQ
	 JXv86DWfTGzgQrEQYMeJECCYHVmM5gvMWbrRw5EkozCu/hQyzfWBBBOPmd14Ocmk0/
	 ZuzyYa7xyQQAZrN7pFqLww0RHz4paPNRjpXuf1t6MecExJ3l/yKfDHqw+JN3+ZIGlT
	 WVIbIR2ZSyaCFp+1+qrkl9gHhnx67cTbnDzkx3EHXEQPrUoOplCB1ZEpdOBFh1CdZL
	 0vFTMji6x33pX7dwIYJh9pKztLzfFOkXTB9+FVarnMgB+V8Li/JUXxAshVGNKlYnni
	 ujNZDs2SeSVcg==
From: Simon Horman <horms@kernel.org>
To: fmancera@suse.de
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net
Subject: Re: [PATCH 2/3 net-next v6] ipv4: handle devconf post-set actions on netlink updates
Date: Fri, 12 Jun 2026 13:38:20 +0100
Message-ID: <20260612123820.673243-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609204520.4670-2-fmancera@suse.de>
References: <20260609204520.4670-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ipv4: handle devconf post-set actions on netlink updates

This commit ensures that IPv4 device configuration parameters updated
via netlink trigger the same post-modification actions as sysctl updates.
It addresses the inconsistency by calling devinet_conf_post_set() inside
inet_set_link_af() and deferring cache flushing.

> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 8300516fb38f4..a35b72662e431 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
[ ... ]
> +	case IPV4_DEVCONF_FORWARDING:
> +		if (new == 1) {
> +			/* it is safe to use container_of() because forwarding case
> +			 * is only used by the netlink path
> +			 */
> +			struct in_device *idev = container_of(cnf, struct in_device, cnf);
> +
> +			netif_disable_lro(idev->dev);

[Severity: High]
Does calling netif_disable_lro() directly here without acquiring the
netdev_lock_ops mutex cause lockdep assertion failures?

Since inet_set_link_af() runs only under rtnl_lock() and does not acquire
the device ops lock, this direct invocation appears to bypass the locking
requirements for netif_disable_lro(), which modifies dev->wanted_features
and invokes netdev_update_features(dev).

On drivers that opt-in to netdev_lock_ops, does this create a concurrent
data race on the device features mask? Should this use dev_disable_lro()
instead, which correctly acquires and releases netdev_lock_ops(dev) around
the netif_disable_lro() call?

> +		}
> +
> +		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +					    NETCONFA_FORWARDING,
> +					    ifindex, cnf);
> +		return true;
