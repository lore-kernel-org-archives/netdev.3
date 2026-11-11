Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394134;
	b=IOza756T0KAkGnbNAXe/9CcTKoznRit4UXepPIzjWIbqBFbE5MWez6NrKK51Ykn5uObx
	 eIAXSceKxyY/R3dJYx6Fa0dE7ue9VT7usgz2yVnqyF3w3Lv2hepwGLTI4oSuZb6wm49QI
	 QEPIeG5yjbdaKXNvdM7HJCy5qqGXugGLy8iZVClFiT09r/nVnL220VT7bTUTj4CTK+DsB
	 hmfq8980w4Zs6AhTidcKcPQ1tfV0pugC4eQ7DOb1wP15lg8ExVI4/qj2gVk4SS1pZ3isD
	 Qw8n+Wv76FIfJlAv9IkOL8LdLQbXMQfdpvaxQbJoioZK1A+RkJYYYmzqZK2Vh1aPccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394134;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bjk0I1t6cM3RcsXcL4oqc5nrXlKGlYx5oH1oEjFVOqE=;
	b=aMP3KkTTVQxFzE54ROu4AVKXwSJRgHkceT4PMwlJkcth+SsmYmevX8UJbLknwOsYGcOr
	 hdnXmPONGlapDNRG3Ask22j8e0b3qiZ4EqBV0ZwU0YNpMnezfjMXbGQAILYzMyE/Mhkrf
	 75Rmi2TX0BNSVsn1u3YymZUplXXVVDYSdyssAAExteU190oGHC7xNfPWopmFHVxFc+s3a
	 Bsv/7xZv6AusN5NkLzaDUqEyBMvvPSfSvfdknslaen7Ap7npPEcgl+i5so4QSW+k1hjWs
	 8JKkCwi33f+CpXqCvNx/1315umKfhuxMuorS7NqTpoe7ZKmRPPJ0nNspjDToTiGp9lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6RKHFxL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA92606A8AD
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6RKHFxL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF09A1F00A06;
	Wed, 11 Nov 2026 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394134;
	bh=bjk0I1t6cM3RcsXcL4oqc5nrXlKGlYx5oH1oEjFVOqE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c6RKHFxLcPjgu1Uw0XYlEPgkop6HYHjDckgpUhM1B4pX8bPOk+cMrhKlXeYjqNVeF
	 OQAuDLh9qniaPX/GFlLXCWum1aUSoQ2/G4PYH0NdYRzIg6ae9otv5SsWoyyYw5b1v6
	 6hS8i12D+3xqdZUrkRvjETB+JlaTnWdeifMyX3BPFCuECYKVokjR+VaVyV8Av47oK8
	 U3xfbJ1IgXZOdg/Vghe1ZgGaOG18WAQ06iW6uNYKcy0dNSlPmvCDBvLOkmfF86rCLg
	 AUSA07/RVzbOSN7DnAS48tu3DVReY6kKrrgnuzSCjWdRvnW8v8CUW7aEtit3o3fNQv
	 vRoOG1a51hn7A==
Subject: Re: [PATCH net-next v2 5/5] hv_netvsc: let the core take XDP off a
 netvsc device that is going away
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Date: Wed, 11 Nov 2026 10:48:53 +0000
Message-ID: <179439413336.2199510.16556459400141468213@kernel.org>
In-Reply-To: <20261109194843.1353592-6-kuba@kernel.org>
References: <20261109194843.1353592-6-kuba@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/hyperv/netvsc_bpf.c, netvsc_bpf() now reports
  success for an XDP removal when nvdev is gone and vf_netdev is NULL.

--

hv_netvsc: let the core take XDP off a netvsc device that is going away

When nvdev is gone, netvsc_bpf() now lets an XDP removal succeed if
there is also no VF. If netvsc_suspend() parked a program reference for
netvsc_resume(), that reference is dropped. This avoids the WARN_ON() in
dev_xdp_uninstall() and stops the dispatcher from keeping the program on
unbind or hot-remove.

> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index 143fc0c128411..14bb520b44ed5 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -206,7 +206,21 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  	int ret;
>  
>  	if (!nvdev || nvdev->destroy) {
> -		return -ENODEV;
> +		struct netvsc_device_info *saved;
> +
> +		if (bpf->command != XDP_SETUP_PROG || bpf->prog || vf_netdev)
> +			return -ENODEV;
> +
> +		/* The channels and the VF are gone, and so is the program,
> +		 * except for the reference netvsc_suspend() keeps for
> +		 * netvsc_resume().
> +		 */

[Severity: Medium]
Is "and so is the program" true on the unbind path in the failed-suspend
and failed-reconfiguration cases that v2 targets?

netvsc_remove() unlinks the VF before it unregisters the netdev:

drivers/net/hyperv/netvsc_drv.c:netvsc_remove() {
    ...
	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
	if (vf_netdev)
		netvsc_unregister_vf(vf_netdev);
    ...
	unregister_netdevice(net);
    ...
}

So when dev_xdp_uninstall() calls netvsc_bpf(), vf_netdev is always NULL
and the new vf_netdev check never fires.

netvsc_unregister_vf() only takes the program back from the VF while it
is still on netvsc's channels:

drivers/net/hyperv/netvsc_drv.c:netvsc_unregister_vf() {
    ...
	nvdev = rtnl_dereference(net_device_ctx->nvdev);
	if (nvdev && netvsc_xdp_get(nvdev) && !dev_xdp_prog_count(vf_netdev)) {
		netdev_lock_ops(vf_netdev);
		ret = netvsc_vf_setxdp(vf_netdev, NULL);
    ...
	netdev_upper_dev_unlink(vf_netdev, ndev);
	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
    ...
}

That condition is false in at least two cases.

First, netvsc_detach() clears the channels and can then fail. This can
happen when it is called from netvsc_suspend(), netvsc_set_channels(),
netvsc_change_mtu() or netvsc_set_ringparam():

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
    ...
}

After that, nvdev is still there and the channels are empty. The VF
still runs the program that netvsc_vf_setxdp() installed.

Second, both netvsc_attach() calls in a reconfiguration can fail. Then
nvdev is NULL and the VF stays joined with the program still on it.

In either case, netvsc_unregister_vf() skips
netvsc_vf_setxdp(vf_netdev, NULL) but still clears vf_netdev. This new
branch then returns 0, and the core drops its reference, the dispatcher
entry and the xdp_state record.

Doesn't the former VF then keep running netvsc's program under the
reference netvsc_vf_setxdp() took?

netif_xdp_propagate() doesn't record propagated programs, so
dev_xdp_prog_count() on the VF is 0. That means neither device reports
the program, and "ip link set dev <vf> xdp off" never reaches the VF
driver.

The earlier patch in this series, "hv_netvsc: treat the VF's XDP program
the way bonding treats a slave's", also removed the NULL push at VF
registration. So a later netvsc instance with no program won't clear the
leftover either.

That looks like the same result that patch set out to prevent: a VF
running netvsc's program with no upper that owns it.

Would it work to put the program back on the channels (and free
saved_netvsc_dev_info) when netvsc_detach() or netvsc_suspend() fails?
Another option would be for netvsc_unregister_vf() to check netvsc's
recorded native program instead of the channel state.

> +		saved = ndevctx->saved_netvsc_dev_info;
> +		if (saved && saved->bprog) {
> +			bpf_prog_put(saved->bprog);
> +			saved->bprog = NULL;
> +		}
> +		return 0;
>  	}
>  
>  	switch (bpf->command) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109194843.1353592-1-kuba%40kernel.org
