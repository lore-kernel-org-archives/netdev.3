Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C043846E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530164; cv=none; b=Wrtq8/eJMgtXo/1UirE2OklWxmHPeymfg/JZX0Fji6UuQq8FsiF4I1xw51xJDporHvfZGlAx2F9MtH9SZh6toO62vYz8i4d+htYOQNfzJUBOH4pTmjJm9axzLw+kepgSQNvBr6MvzJIMhu8q25BP1wWl3TYyuwO93dq2qVLug1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530164; c=relaxed/simple;
	bh=x4vTxmvtDDH9TLCmiWhOSBMECKyAK8jjYMKnfV8TWr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anQvtFs8SFJBEj2e0MS96B8m/j/QmkNwx/kz8dfHppO7/8Q+or3agEBAYO5HxN8zmqOo4dSrmUnqVf8aIXgqYW7zzfSry4DPqe1FaXzmdPWEfLKQOdnfirC8qhpRmo0P05fbhyAfoRKXwxo95pgW+OvRNnzKhjeLu5J+oftzZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch+RHaQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch+RHaQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02EC1F000E9;
	Wed,  8 Jul 2026 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783530160;
	bh=nzA7oP4dBhbWOn+fQw3xQ+2T7d/x7OIJEku8W4h5UBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ch+RHaQYkCe4qNb6Wq0QOHNmTaJ+Y9DWdDjNtKj/BFVWAZsjWecsq7YvQR79BFfS2
	 EPf0tY2UpdoQXigoM/6do3LyGtem6kRIgQgTqeNPMTHgzmytOrSOxcym/InUQObCM5
	 Fxx6k7ipOrcvyF+PkIGp71EXYt45N6hO1KQun60ltxC0i/rh9BIXtzb7NSQ2N/3Z5c
	 0h6dAO0RpQTxkRA0glBguO93QvbSU/OYQqZYE7zfOs/ZGCT+GG26PjaiSdlv4bC4Tz
	 Ls4vbM1dyEpE2oCun1us+U5EwFXknSEzTmTrGVJdEx//SlxgFe0+B4GA3zoahNBAXJ
	 av/b2ATrr/iFQ==
From: Simon Horman <horms@kernel.org>
To: jedrzej.jagielski@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1 6/6] ixgbe: take rtnl lock before ixgbe_reset() is called
Date: Wed,  8 Jul 2026 18:02:35 +0100
Message-ID: <20260708170235.1514479-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702091553.57112-7-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-7-jedrzej.jagielski@intel.com>
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
ixgbe: take rtnl lock before ixgbe_reset() is called

Previous commit introduced ixgbe_mac_addr_refresh which touches netdev
struct by updating mac addr. It should operate after taking rtnl lock.
One of the callers is ixgbe_reset(). Most of scenarios when ixgbe_reset()
is called met taking lock requirement, but there is a ixgbe_resume() path
which calls ixgbe_reset() -> ixgbe_mac_addr_refresh() without taking
the lock. So there is a risk of race.

Move rtnl_lock() before ixgbe_reset() is called.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index eb05c2f982e8e..aa5a61f95d883 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7535,11 +7535,11 @@ static int ixgbe_resume(struct device *dev_d)
>  
>  	device_wakeup_disable(dev_d);
>  
> +	rtnl_lock();
>  	ixgbe_reset(adapter);

[Severity: High]
This patch fixes the missing rtnl_lock() in ixgbe_resume(), but is this fix 
incomplete? 

It looks like there are still other paths that call ixgbe_reset() without 
acquiring rtnl_lock(), which would trigger the same race condition and 
ASSERT_RTNL() warning on the MAC address update. 

For example, the PCI error recovery handler calls it directly:

ixgbe_io_slot_reset() {
	...
	ixgbe_reset(adapter);
	...
}

And the service task can also call it without rtnl_lock():

ixgbe_handle_fw_event() {
	...
	ixgbe_down(adapter); /* calls ixgbe_reset() */
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but does ixgbe_reset() also modify 
the unicast address list without the required lock?

ixgbe_reset() directly calls __dev_uc_unsync(netdev, NULL) which iterates 
over and modifies the dev->uc address list. However, __dev_uc_unsync() is a 
lockless helper that expects the caller to hold netif_addr_lock_bh(netdev). 

Since the callers of ixgbe_reset() only hold rtnl_lock() (or no lock), 
could this cause list corruption or use-after-free if the device resets 
concurrently with unicast address modifications?

[Severity: High]
This is a pre-existing issue, but does ixgbe_reset() use an ad-hoc 
synchronization mechanism instead of standard primitives?

Inside ixgbe_reset():

	/* lock SFP init bit to prevent race conditions with the watchdog */
	while (test_and_set_bit(__IXGBE_IN_SFP_INIT, &adapter->state))
		usleep_range(1000, 2000);

Reimplementing a lock with test_and_set_bit() and usleep_range() lacks 
deadlock detection (lockdep visibility), priority inheritance, and fairness. 

Should this use a proper mutex or spinlock instead of spinning on a bit flag?

>  
>  	IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
>  
> -	rtnl_lock();
>  	err = ixgbe_init_interrupt_scheme(adapter);
