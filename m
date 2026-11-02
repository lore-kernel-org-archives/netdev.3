Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589412;
	b=17dhaTiBrjzL1xCI7LlTifvqfnPKHT/nMnoJpFc22rFK5kDqEFk1UDfe7AjFERq2aWp9
	 JexsQV3n18A7yKjnTCDdJq675cN1Bu95Hjk0KhmiwepAd/TuGo39CSMOsONR53KUmlSiF
	 JV3v6tr1feqCWD7iIumPzD2b5rcBPXp+3Pw/IVJIIyct/tGOWiUyaOC7ycVx/WWrzZeKp
	 CHtWitHy4eTSrXPFNqbEyS9EvYtRRgct4wrhlceTO5sCTE660U1LD3WSmos4X4+lURZsd
	 YTNP9DhI/o0db9uBPcprYJJsWCSjhb+Q5OoiVb7taNr42/tXSUfxuWcI5zBUppwvjSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589412;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sJw++RZDG5Vo6fmGQWiIhdzPjPtQUuqigtExKkQsQTg=;
	b=tz/sIwKm2LVZaLXQ/NnCcwUfNBSfyDfRpREaBX2ItAhafH+uUuRJYRzwJVhc8fEmAJXq
	 p5UIvZIb+qvkWEsGqKY22E8tOvdHVON1gkhfVLVQphblwO5eMBf8bZvCwrw7r+SFH4sSb
	 SlDmMh1A3Wz/sESpahFrABbFMvbzgVYUie2fv0AHQokR+D/0BnDn4ACUWxgujSxUW00ma
	 PdtFAVG8N1tII//5XNufzI8q7GSOPLx4q6S6gFSahVX6W+ipu1yiJtKE9fMK7Sg/lmpw9
	 jg6jXfeaHqPk8da2UsU0Zx/vBHolCzrNjBf+ZBaPlM9tjwNaW6ffynP2BhkIAB7SCxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jtv/+c+R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B05606A324;
	Mon,  2 Nov 2026 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtv/+c+R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E081F000C1;
	Mon,  2 Nov 2026 03:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793589412;
	bh=sJw++RZDG5Vo6fmGQWiIhdzPjPtQUuqigtExKkQsQTg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jtv/+c+RFAu3LrhQcovopmFfBljHcvIFsG+hIpTi+A+gMHE/AC/pPExnzKN5fjnDN
	 p5kZGs30lBMpun61wEvnp2s4li16mkc7f9to16yX3w7b94zytsU0duS9leQmtmLnPp
	 QaEt9hHL3tK+ACLt8ad2uCx/Aaq8lrELHN+fn+hYWBDH07F5rjVCuPDMforrX8z7RS
	 VWhX6trkVIf+oEG03qabfgRTn4ISAbhrl1/z7Ya7EOazoswBqnbV+Qc+yneZiRDVKJ
	 3asg3aRsNy6nCKkDkUqCgQ/5O0jGQhlbb2Ps49AwHZEMC1SM98Hm0f3ulWXXU07SAQ
	 SUxqoCGM+d8KA==
Subject: Re: [PATCH net] netdevsim: delete ports added after a failed reload
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 03:16:51 +0000
Message-ID: <179358941115.3131.11140874817222792270@kernel.org>
In-Reply-To: <179324296598.34505.11070163314749859668@gmail.com>
References: <179324296598.34505.11070163314749859668@gmail.com>
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

- [Medium] The fix is incomplete, and the claim it rests on is wrong.

--

netdevsim: delete ports added after a failed reload

This patch makes nsim_dev_reload_destroy() call nsim_dev_port_del_all() on
the early-return path that is taken after a failed devlink reload. Before
this, ports added through new_port after the failed reload were never
deleted, which led to WARNs in devlink_free() and a use-after-free on the
leftover netdev.

Closes: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a

> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index feb88ccbbcedb..a8717908cfb83 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1697,8 +1697,13 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
>  {
>  	struct devlink *devlink = priv_to_devlink(nsim_dev);
>  
> -	if (devlink_is_reload_failed(devlink))
> +	if (devlink_is_reload_failed(devlink)) {
> +		/* The failed reload already tore everything down, but ports
> +		 * can still be added through new_port after that.
> +		 */
> +		nsim_dev_port_del_all(nsim_dev);
>  		return;
> +	}

[Severity: Medium]
Is deleting the ports enough on this path? The commit message says:

  "The ports are the only thing that can be created after the failed
  reload, so delete them on the early-return path too."

After a failed reload, user space can apparently still set sriov_numvfs,
switch the eswitch to switchdev mode, and create devlink rate nodes. None
of these paths check devlink_is_reload_failed():

  nsim_bus_dev_numvfs_store()
    nsim_drv_configure_vfs()
      nsim_bus_dev_set_vfs(nsim_bus_dev, num_vfs);
      nsim_esw_switchdev_enable()

  nsim_devlink_eswitch_mode_set()
    nsim_esw_switchdev_enable()
      __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF, i, NULL);
      nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;

  devlink_nl_rate_new_doit()
    nsim_rate_node_new()
      if (!nsim_esw_mode_is_switchdev(nsim_dev)) {
          ...
          return -EOPNOTSUPP;
      }

Before deleting ports, the normal path further down in
nsim_dev_reload_destroy() resets the VFs and tears down the eswitch state:

	if (nsim_dev_get_vfs(nsim_dev)) {
		nsim_bus_dev_set_vfs(nsim_dev->nsim_bus_dev, 0);
		if (nsim_esw_mode_is_switchdev(nsim_dev))
			nsim_esw_legacy_enable(nsim_dev, NULL);
	}

nsim_esw_legacy_enable() is the only caller of devl_rate_nodes_destroy() in
netdevsim. The new early-return branch never reaches it.

Take this sequence: fail_reload=1, reload fails, set sriov_numvfs, switch to
switchdev, run "devlink port function rate add <dev>/node1", then
del_device. The early branch removes the ports but leaves the rate node on
devlink->rate_list. Would devlink_free() then hit this check:

net/devlink/core.c:devlink_free() {
    ...
	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
    ...
}

and leak the devlink_rate and the nsim_rate_node?

The commit message also says a successful reload after the failed one is
fixed. In that case the early branch deletes the VF ports but leaves
num_vfs set and esw_mode as switchdev. Any remaining rate node would trip
WARN_ON(devlink_rates_check(...)) in devlink_reload_reinit_sanity_check().

After that, nsim_dev_reload_create() re-adds only the PF ports. The device
then ends up in switchdev mode with VFs configured but no VF representor
ports. A normal reload never leaves the device in that state.

Should the failed branch do the same VF reset and nsim_esw_legacy_enable()
teardown as the normal path before calling nsim_dev_port_del_all()? If not,
the "only thing that can be created" sentence in the commit message should
probably be corrected.

>  	debugfs_remove(nsim_dev->take_snapshot);
>  
>  	if (nsim_dev_get_vfs(nsim_dev)) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179324296598.34505.11070163314749859668%40gmail.com
