Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394132;
	b=YCfBzNH/bWo4tADRaRkTyPcO5kPAHqY2eAMH3NTFj/772Eb9aA7bEpehyqP7Fy8yE4aP
	 S+ufCjEanbVTMaLhyHlg4i75Yt588GkF+yQqPG1uD3VI8g0CO3t96UVpFv+Ux/+UuPlcE
	 8EudXw8L/rwbGypt4kVL3E6wPQB9i1je1Xd5ULnPLmWwp/9taLMyjwZPKYqM5uJ1XjuXd
	 UdPyRS9RO9NuYi9SUrtg8+wEzm5AvVE0Vh5WW0OcPPKKkYT8gtEWuT66M7oeruEZ+n6Mi
	 piOE7b0JTjXQ473td1o3u9vNl0I1OFJuJcK9JCvZp7x9lBU2p2eZlwvgcXLzHVvW8tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394132;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=komAFAIdBmdBRfvRqwXzuSbDanSuKoLF+FU2ZZa+OKo=;
	b=nsZTVMp59MThCUpiywau0mwJd9mpAJ3gkm1uOlPRqLGHi6C9IC1B3UfcDZH9AksS7dFb
	 gUNAXYjIIczXfXkFWU3VmJfRHS4hRC+oO6X2bszwiDzhvXdk7ISwkZVo0TXEOOwisJLus
	 S0KgIeG5rb8M69+JIhSdSffdGZKOFG9kN3LhHs9rkK6LU6Ze87OqDHxDM7EOn4mjk+8Gf
	 0hrmn9Yw9N0L7OR9FVkSygnZZKBTr0jsW0zFT36+pBQ0fZOzIQWH0sb/kWkXEwc2hef8c
	 g/qGAL/4LwYEGpFVY0BAzL7difoomFiIIiXsDouaNbB0+ljy8F2MhXtIsWDqEzIFM3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjA9gH7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C001606A88D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjA9gH7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C4E1F00A05;
	Wed, 11 Nov 2026 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394132;
	bh=komAFAIdBmdBRfvRqwXzuSbDanSuKoLF+FU2ZZa+OKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KjA9gH7ivmENN57QxZNRwAyn8ME/a9icyfdTXH49HYF2erP6QbgRwvIbiRlopTeHX
	 PhDb4q6LVlyG3lFjTjpUkQzX6BkmwXq0jKGlcR/tqBO6t3ymlN8dtK1lCYx4FjAnll
	 ECDxm4LKIka7pfw8ueXOoXC6B/c5VCL+xvW/RK4lVl9El82NFhr09SV28Bb1Nc09rq
	 A5Ai9Nhu83L4+irM43Tw/Cad2vfkrLcVqSe4GXRHWDViDLbmJx8WXA0kTg27fEDJpi
	 Uyo+RrAtm+42WQAec7g9VtGyPQXahcPAg5JVkNUPa01gux/H3OR8Zih715brXcdpqs
	 9xMcaKcVp/yxg==
Subject: Re: [PATCH net-next v2 3/5] hv_netvsc: treat the VF's XDP program the
 way bonding treats a slave's
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Date: Wed, 11 Nov 2026 10:48:50 +0000
Message-ID: <179439413096.2199510.13357896520403888843@kernel.org>
In-Reply-To: <20261109194843.1353592-4-kuba@kernel.org>
References: <20261109194843.1353592-4-kuba@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netvsc_unregister_vf()
  (drivers/net/hyperv/netvsc_drv.c:2487-2494) takes netvsc's program…
- [Low] The commit message says that installing netvsc's program before
  joining means 'nothing reaches netvsc through the VF without having…

--

hv_netvsc: treat the VF's XDP program the way bonding treats a slave's

This patch makes netvsc refuse to take over a VF that has its own XDP
program, or that can't or won't run netvsc's program. It installs
netvsc's program on the VF before joining it. It also takes netvsc's
program back from the VF in netvsc_unregister_vf().

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 1d43c73fd73f1..61109ff9927fb 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c

[ ... ]

> @@ -2349,10 +2356,31 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
>  		return NOTIFY_DONE;
>  	}
>  
> +	/* Install netvsc's program before joining, so that a VF which
> +	 * refuses it never gets used. Syncing the features first turns
> +	 * off LRO, which the VF may not run XDP with.
> +	 */
> +	if (prog) {
> +		vf_netdev->wanted_features = ndev->features;
> +		netdev_update_features(vf_netdev);
> +
> +		ret = netvsc_vf_setxdp(vf_netdev, prog);
> +		if (ret) {
> +			netdev_warn(ndev, "not using VF %s, it refused netvsc's XDP program: %d\n",
> +				    vf_netdev->name, ret);
> +			return NOTIFY_DONE;
> +		}
> +	}
> +
>  	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
>  
> -	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
> +	if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {

[Severity: Low]

The commit message says that installing the program before joining means
"nothing reaches netvsc through the VF without having been through the
program". Does this ordering fully guarantee that?

netvsc_vf_setxdp() is followed directly by netvsc_vf_join(), which calls
netdev_rx_handler_register(). That function publishes the handler without
any synchronization:

net/core/dev.c:netdev_rx_handler_register() {
    ...
	rcu_assign_pointer(dev->rx_handler_data, rx_handler_data);
	rcu_assign_pointer(dev->rx_handler, rx_handler);
    ...
}

Some VF drivers also publish the new program without waiting for NAPI.
mana is one example:

drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_chn_setxdp() {
    ...
	rcu_assign_pointer(apc->rxqs[i]->bpf_prog, prog);
    ...
}

Suppose a VF NAPI poll on another CPU has already read a NULL
rxq->bpf_prog. It could build an skb, hold it in GRO, and deliver it after
rx_handler becomes visible. netvsc_vf_handle_frame() would then pass that
frame to netvsc without it having run the XDP program.

The teardown side does wait, because netdev_rx_handler_unregister() calls
synchronize_net(). The setup side mostly matters for the netvsc_probe()
path (VF_REG_IN_PROBE), where the VF may already be up and polling. The
window is about one NAPI poll, and the ordering is still better than it
was before the patch.

Would a synchronize_net() between netvsc_vf_setxdp() and netvsc_vf_join()
make the claim hold? If not, should the commit message be softened?

[ ... ]

> @@ -2453,6 +2480,20 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
>  
>  	reinit_completion(&net_device_ctx->vf_add);
>  	netdev_rx_handler_unregister(vf_netdev);
> +
> +	/* Take our program back now that frames from the VF no longer
> +	 * reach netvsc, but leave a program of the VF's own be.
> +	 */
> +	nvdev = rtnl_dereference(net_device_ctx->nvdev);
> +	if (nvdev && netvsc_xdp_get(nvdev) && !dev_xdp_prog_count(vf_netdev)) {

[Severity: Medium]

This take-back depends on netvsc's channel program, not on whether a
program was actually pushed to the VF. Can the VF be left running
netvsc's program when the two get out of sync?

There seem to be two reachable states where the condition is false while
the VF stays joined and still runs the program from netvsc_vf_setxdp().

In the first state, nvdev exists but its channels are empty.
netvsc_detach() clears the channel program before steps that can still
fail:

drivers/net/hyperv/netvsc_drv.c:netvsc_detach() {
    ...
	netvsc_xdp_set(ndev, NULL, NULL, nvdev);

	/* If device was up (receiving) then shutdown */
	if (netif_running(ndev)) {
		netvsc_tx_disable(nvdev, ndev);

		ret = rndis_filter_close(nvdev);
		if (ret) {
			...
			return ret;
		}

		ret = netvsc_wait_until_empty(nvdev);
		if (ret) {
			...
			return ret;
		}
	}
    ...
}

If this fails, netvsc_change_mtu() goes to rollback_vf and
netvsc_set_channels() goes to out, and neither one re-attaches. nvdev is
still there, but netvsc_xdp_get(nvdev) returns NULL and the VF was never
touched.

In the second state, nvdev is NULL. If netvsc_attach() fails, either on
an rndis_filter_device_add() error or through the err1/err2 paths,
ndev_ctx->nvdev stays NULL. That happens when both attach attempts fail
in change_mtu or set_channels. It also happens when the single attempt
fails in netvsc_resume(), which drops the saved bprog as well.

In either state, any later path into netvsc_unregister_vf() skips the
take-back: a VF hot-remove, a netns move, netvsc_remove(), unbind, or
rmmod. The VF is then unlinked still running netvsc's program, and its
driver keeps the reference. Isn't that the same orphaned program and
mana leak that the commit message says this patch fixes?

When nvdev is NULL, netvsc_bpf() also returns -ENODEV for a removal while
the VF is joined. So the program can't be cleared through netvsc either.

The patch also removes this push after join in netvsc_register_vf():

	prog = netvsc_xdp_get(netvsc_dev);
	netvsc_vf_setxdp(vf_netdev, prog);

That unconditional push used to clear such a leftover when the VF
registered again with a netvsc that has no program. Now the stale program
survives re-registration. dev_xdp_prog_count() can't see it, because it
was propagated rather than installed on the VF through dev_xdp_install().

The commit message compares this to bonding keying its release on
bond->xdp_prog. The two behave differently: bond->xdp_prog lasts as long
as the bond has a program attached. netvsc's channel pointer is torn down
on every detach/attach and on a failed reconfiguration.

The later patches in the series ("move a new VF to netvsc's netns from a
work item" and "let the core take XDP off a netvsc device that is going
away") leave this condition unchanged.

Could the release be keyed on what was actually pushed? One way is a
pointer or flag in net_device_ctx that is set when
netvsc_vf_setxdp(vf, prog) succeeds. Another is to have the detach and
attach failure paths also pull the program off the VF.

> +		netdev_lock_ops(vf_netdev);
> +		ret = netvsc_vf_setxdp(vf_netdev, NULL);
> +		netdev_unlock_ops(vf_netdev);
> +		if (ret)
> +			netdev_warn(ndev, "failed to remove XDP program from VF %s: %d\n",
> +				    vf_netdev->name, ret);
> +	}
> +
>  	netdev_upper_dev_unlink(vf_netdev, ndev);
>  	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
>  	dev_put(vf_netdev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109194843.1353592-1-kuba%40kernel.org
