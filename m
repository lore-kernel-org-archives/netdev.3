Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B727442;
	Fri, 25 Sep 2026 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301433; cv=none; b=pb8YE61pnpMx5Y8drrmDSfKbqd2u2EVm6wMKi+NmWomxpcVgOFUk/QdQeE2y4qmcoKP6ZQv4i96+ozweq47hhTtHJ0xdL/OAZA/UIXULh0OVsBv4Hk5qzqvhSEBNk1j0RSYyYEaRLadM8E0cbT1aQAdEjoXLjMRW3z8Hkd7K+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301433; c=relaxed/simple;
	bh=whwymmTE1QHvS4lDIOHULv56N0DpM0XrrFVkEsGGPJ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7AFcvEzLQD7N0ndaImq42QLeV/4N9+dwhWc5cvkLxgvHzyXndqxRutSh30a8HYRqTtb9IhnOfL6yimOZwMvFUgB/E1Dk7yR0YDXxe3wQZkR7fUWrFDVuhF7Iu3+2/UWVzn038/Xu1u4WOkbhwkr4MW0dhaG5N1vKABDHvKtikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4N1vPX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4N1vPX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA64D1F00893;
	Fri, 25 Sep 2026 01:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301431;
	bh=m9cOpwpo3+aCCNN+COT8dk0LKzgMFZLdoE29kLvzKH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P4N1vPX0gB/OjnJA80GxoTCkZhwnND5SqLhuR+B68b432GrHNOb/JTXGXmZjt18Ld
	 7/yapZISp/GvEdJK5HtrJ63qEiyhLiNPKfiAzp6t6FaxD9FWjzP2hZXQIlbAohogRh
	 vKnbDy/Tk9jKJQEsy7QAPtFrjhegKTyrPqCVbUonZ7vxaR7zlgiN4V/T8lW9Aa4TS/
	 NKqopnotxykeyrOyIN/ov1+R0kCwCsy78b7Q06F3220xOOEShOf/KnWbaD/Xat8o2r
	 fmvbCcbLVokAOVgQ5m6fXLwDkiJjbD06uZ5AOF51JryyS2tZ+FpH17ix+42Lb2oPFY
	 FTuZQ90C3oA6g==
Subject: Re: [PATCH net v1] net/mctp: publish the mctp_dev only after it is
 initialised
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dengbinbin21@nudt.edu.cn
Date: Fri, 25 Sep 2026 01:57:10 +0000
Message-ID: <179030143029.2160803.7901930018249863589@kernel.org>
In-Reply-To: <20260922125443.133110-1-18983559317@163.com>
References: <20260922125443.133110-1-18983559317@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message presents an unverifiable/self-inconsistent
  KASAN report as the justification for the fix.

Pre-existing issues:
- [Medium] mctp_register_netdevice() (net/mctp/device.c:483-497) calls
  mctp_add_dev(), which kzalloc()s a struct mctp_dev with refcount 1 and…

--

net/mctp: publish the mctp_dev only after it is initialised

The patch moves the rcu_assign_pointer(dev->mctp_ptr, mdev) store in
mctp_add_dev() to after mdev->dev is set, so RCU readers that pick the
device up via __mctp_dev_get() can no longer observe mdev->dev == NULL.
The reordering itself looks correct.

A couple of questions below, one about the evidence in the commit message
and one about a pre-existing rollback gap in the same allocation path.

> net/mctp: publish the mctp_dev only after it is initialised
>
> mctp_add_dev() links the new mctp_dev into dev->mctp_ptr before mdev->dev
> is assigned, so a reader that picks the device up in that window
> dereferences a net_device pointer that is still NULL:
>
> KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
> Call Trace:
>  <TASK>
>  ? __pfx_mctp_sendmsg (./include/linux/sockptr.h:49)
>  ? __pfx_mctp_dst_output (net/mctp/route.c:41)
>  ? selinux_socket_sendmsg (security/selinux/hooks.c:5278)
>  ____sys_sendmsg (net/socket.c:775 ...)
>  ...
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  </TASK>

[Severity: Medium]
Can this trace actually correspond to the race being described?

There is no faulting instruction line in the report (no "Read of size N at
addr ..." and no RIP:/top frame), and the only MCTP entries are unreliable
"?" frames that resolve to kcfi padding symbols:

     ? __pfx_mctp_sendmsg (./include/linux/sockptr.h:49)
     ? __pfx_mctp_dst_output (net/mctp/route.c:41)

A __pfx_foo symbol is the 16-byte padding placed before foo, so it can
never be a live call site. The remaining "?" entries are stale scheduler
and perf frames (update_cfs_rq_load_avg, sched_tick,
clockevents_program_event, perf_event_task_tick), leaving only
____sys_sendmsg/___sys_sendmsg/__sys_sendmsg/do_syscall_64 as reliable
frames.

For the window described, the dereference of the half-initialised mdev
happens here:

net/mctp/route.c:mctp_dst_output() {
    ...
	skb->dev = dst->dev->dev;
    ...
}

Would a genuine splat not list mctp_dst_output() and the following xmit
frame as reliable frames?

The window itself does look real: register_netdevice() calls
list_netdevice(dev) before call_netdevice_notifiers(NETDEV_REGISTER, dev),
so while mctp_register()->mctp_add_dev() runs from the notifier, the
net_device is already reachable through dev_get_by_index_rcu(), and a
concurrent sendmsg with MCTP_ADDR_EXT can reach
mctp_dst_from_extaddr()->__mctp_dev_get().

Could the changelog describe that reachability path instead, and add the
provenance (Reported-by:/Closes:/reproducer, or a statement that this was
found by code inspection)? As it stands the claimed crash cannot be
validated by reviewers or stable maintainers.

> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 822120e860c82..b76715ea50e14 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -344,13 +344,18 @@ static struct mctp_dev *mctp_add_dev(struct net_device *dev)
>  
>  	mdev->net = mctp_default_net(dev_net(dev));
>  
> -	/* associate to net_device */
>  	refcount_set(&mdev->refs, 1);
> -	rcu_assign_pointer(dev->mctp_ptr, mdev);
> -
>  	dev_hold(dev);
>  	mdev->dev = dev;
>  
> +	/*
> +	 * Associate to net_device.  Publish only once the object is fully
> +	 * initialised: __mctp_dev_get() runs under rcu_read_lock() only and
> +	 * hands this object to readers as soon as mctp_ptr is assigned, so
> +	 * they must never observe mdev->dev == NULL.
> +	 */
> +	rcu_assign_pointer(dev->mctp_ptr, mdev);
> +
>  	return mdev;
>  }
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the
allocation done here: does the mctp_dev allocated by mctp_add_dev(), plus
the dev_hold(dev) reference taken next to it, leak when
register_netdevice() fails?

net/mctp/device.c:mctp_register_netdevice() {
	mdev = mctp_add_dev(dev);
	if (IS_ERR(mdev))
		return PTR_ERR(mdev);

	mdev->ops = ops;
	mdev->binding = binding;

	return register_netdevice(dev);
}

register_netdevice() has several exits that return an error without ever
delivering NETDEV_UNREGISTER - dev_get_valid_name() failure,
netdev_name_node_head_alloc() -ENOMEM, ndo_init() failure, the buggy-VLAN
-EINVAL, netdev_do_alloc_pcpu_stats() failure, dev_index_reserve()
failure, NETDEV_POST_INIT notifier failure and netdev_register_kobject()
failure (which only emits NETDEV_PRE_UNINIT):

net/core/dev.c:register_netdevice() {
    ...
err_uninit_notify:
	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
err_ifindex_release:
	dev_index_release(net, dev->ifindex);
    ...
err_free_name:
	netdev_name_node_free(dev->name_node);
	goto out;
}

The only place that drops the mctp_dev is mctp_unregister(), and it only
runs from the NETDEV_UNREGISTER notifier:

net/mctp/device.c:mctp_unregister() {
	RCU_INIT_POINTER(mdev->dev->mctp_ptr, NULL);
    ...
	mctp_dev_put(mdev);
}

All four in-tree MCTP drivers then free the netdev directly, for example:

drivers/net/mctp/mctp-serial.c:mctp_serial_open() {
	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_SERIAL);
	if (rc)
		goto free_netdev;
}

with reg_state still NETREG_UNINITIALIZED, so free_netdev() frees the
netdev immediately while the mctp_dev is left allocated with a stale
mdev->dev and an unbalanced netdev reference (which also shows up as a
ref_tracker "leaked reference" report with
CONFIG_NET_DEV_REFCNT_TRACKER=y). Would an explicit rollback on the
register_netdevice() error return - RCU_INIT_POINTER(dev->mctp_ptr, NULL)
followed by mctp_dev_put(mdev) - be appropriate, perhaps as a separate
patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922125443.133110-1-18983559317%40163.com
