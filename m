Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFA3ACF10
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640654; cv=none; b=X6uMaMM+XX7YtbHajGq+28YKoRyIP+HL9eW3u88Ls0Ep/pgKmnY7M2w3f8MERyrlnZGp1DzOw4lNsm9gKJmOVaflvkTZrDGO0LlIbOCEpZ5HubiIX4Lar3eCVNnQ7osc5soHdtZsiSMgOhSodlI+U3uC7NnHdHy3p7IKJE0FHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640654; c=relaxed/simple;
	bh=XU82a9t97IWbOOY5ALVLWwYqlPf/8OCYJXJBUReFkg0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLyKfknbfiNjQn/ItOnpXI0qlsaXTvFTl+gFKyyBeH4cvocA8vGmfn92oCRK1v3YJi2t2nka9jCxG4FOrt7w252dbJEBw6GPHxyiC9LY3Z+U3660HEqpDYStTgZXwgjrL8QAFZwaxlEhwR0/sl8bwbB3JHuVt3kgZADX9IDtIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV4IIXvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV4IIXvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE71F00A3A;
	Sat,  5 Sep 2026 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640652;
	bh=C/gZvNkMPY4HCEtqEUvswBvPc4r4Yo6MKF/f1+T0sdo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LV4IIXvKSDW8LTSxBmjMNZ3G02hG7EjKOflI/yKGTl+GGqerWq2ALWxqk038pWRt5
	 vKDiRH4Lo8dz+zhLrLZO8cKg6sK9zW3U9IbwfObIJBCWg2e3W4Acfk5cMz+BB2DPdF
	 nFxMdHNcrblDGAp19cwvJ0gOXXhZa2UVtu7YeJ3ALrku2gzAFNX37uQNujqeSAIrrg
	 j2l9tjuilfrhkmzeOPWykRhoytUwNBFZ5nH83TQNbU5HiwtqLFpttCIRuv1KS9LrjU
	 LkEHDcuRw42UUnCvdWMNt/FnfeHGuWBWD7Q4quZbqw+a2n+rkk5kb8oeAqgP3LuB7o
	 FhFgwjmJBkbSg==
Subject:
 Re: [net PATCH 4/4] net: ethtool: keep rtnl_lock for the ioctl self test
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Sat, 05 Sep 2026 20:37:31 +0000
Message-ID: <178864065130.219967.16775047267287986005@kernel.org>
In-Reply-To:
 <178838833261.11136.11073590401658206367.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178838833261.11136.11073590401658206367.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix: the rtnl requirement for ETHTOOL_TEST is made a
  per-driver opt-in (ETHTOOL_OP_NEEDS_RTNL_TEST) and set only on fbnic,…

--

net: ethtool: keep rtnl_lock for the ioctl self test

The ETHTOOL_TEST ioctl on an ops-locked driver runs with only the netdev
instance lock, so fbnic's offline self test tears the device down through
netif_close() without rtnl_lock. The patch adds an opt-in bit,
ETHTOOL_OP_NEEDS_RTNL_TEST, handled in ethtool_ioctl_needs_rtnl(), and
sets it in fbnic_ethtool_ops.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 0e47088ec44b..423f179c9d47 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -2025,7 +2025,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
>  					  ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM |
>  					  ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
>  					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
> -					  ETHTOOL_OP_NEEDS_RTNL_GLINK,
> +					  ETHTOOL_OP_NEEDS_RTNL_GLINK |
> +					  ETHTOOL_OP_NEEDS_RTNL_TEST,
>  	.get_drvinfo			= fbnic_get_drvinfo,
>  	.get_regs_len			= fbnic_get_regs_len,
>  	.get_regs			= fbnic_get_regs,

[ ... ]

> diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> index 4e5356e26f40..ae32e7fdb563 100644
> --- a/net/ethtool/common.h
> +++ b/net/ethtool/common.h
> @@ -163,6 +163,8 @@ ethtool_ioctl_needs_rtnl(const struct net_device *dev, u32 ethcmd)
>  		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
>  	case ETHTOOL_GLINK:
>  		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GLINK;
> +	case ETHTOOL_TEST:
> +		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_TEST;
>  	}
>  	return false;
>  }

[Severity: High]
Making the rtnl requirement for ETHTOOL_TEST a per-driver opt-in leaves the
same condition reachable on bnxt, doesn't it?

bnxt is ops-locked, since bnxt_init_one() sets dev->queue_mgmt_ops
unconditionally:

	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
	if (BNXT_SUPPORTS_QUEUE_API(bp))
		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;

But bnxt_ethtool_ops does not carry the new bit:

	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
					  ETHTOOL_OP_NEEDS_RTNL_SCOALESCE |
					  ETHTOOL_OP_NEEDS_RTNL_RSS,

so with this patch applied, __dev_ethtool() still computes need_rtnl == false
for ETHTOOL_TEST on bnxt, and bnxt_self_test() runs under
netdev_lock_ops() only.

The offline branch of bnxt_self_test() then does:

		bnxt_close_nic(bp, true, false);
		...
		rc = bnxt_half_open_nic(bp);
		...
		bnxt_half_close_nic(bp);
		rc = bnxt_open_nic(bp, true, true);

and both bnxt_half_open_nic() and bnxt_open_nic() call netif_close() on
failure:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_half_open_nic() {
	...
half_open_err:
	bnxt_free_skbs(bp);
	bnxt_free_mem(bp, true);
	netif_close(bp->dev);
	return rc;
}

IFF_UP is still set at that point, since __bnxt_close_nic() never clears it,
so netif_close() goes into netif_close_many() -> __dev_close_many() with its
ASSERT_RTNL() and the rtnl-protected rcu_dereference_protected() in
netpoll_poll_disable(), which is the same call chain quoted in the commit
message, only on bnxt.

Would it make sense to either set ETHTOOL_OP_NEEDS_RTNL_TEST on bnxt as well,
or to keep rtnl_lock unconditionally for ETHTOOL_TEST on the ioctl path?
Given self_test is an ioctl-only and rarely used command, an unconditional
case here would also cover any future ops-locked driver that forgets the
opt-in.

I checked the other ops-locked drivers for the same exposure: mlx5's
mlx5e_self_test() only runs loopback under priv->state_lock and never calls
netif_close()/netif_open(), and gve, netdevsim, netkit, dummy, bnge and
mlxsw do not implement .self_test.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178838795612.11136.15512516427273655916.stgit%40ahduyck-xeon-server.home.arpa
