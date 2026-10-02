Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E31ADC97
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903015; cv=none; b=ZMkI03MGmPdjvFytinYhJpdKzvX4xcxFx1zrDrHYL7YuXQ+VJyUF8ZrvaolaFY3z3Mn7aTC0q1zcXPM7xIG8oCFixlF/p8cUtS+oBl0p90lbLebhakZjSbMlUJdwMuwhnPdj5YMe9xNx5draSHfXUQ4PKFT9dja7UsppTM6Q+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903015; c=relaxed/simple;
	bh=Iqq0tKidyUkGhhJSnWgZ63+wnDZZICq58JRViehFr1A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecip0kMu2kYBlWMFcIejel/Rp/joPcPSsS8zBvtW4mWsmPEG7SX8X/ross2uigVATVkXQYtaLvjxvieqqEHctpQUr4TesNRC8BefXChPig5PX8Q2Qb3SlEbd7ClEaSR2G02GEc1af7U4m+h4872QuU9V+sOT0aGChHU/uqk5QDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNyEy9kW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNyEy9kW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D41F000FF;
	Fri,  2 Oct 2026 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790903013;
	bh=GK+6c8EdGIwDSL0JtDEGBhF++I5Jr9kpdR2MKMvbDa4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PNyEy9kWqm8QTGm5QjAJuByWKNOFuRKSLsHCf2onj1mQrx+sZfFuU0ZzP3hHy6kdK
	 rc2m9mEE0HI6WQ3kQMSPtsruS9+qWDBHLt1eMgjSP5i4/9DWRHfs3n8aRP1ZhPCrgK
	 5iG7gWRTsr+hjFrjVOdXuu+2MksuVDI0h6iVFr2TKE0lgZMIevQzOD4qA2fRmjpcn5
	 6rICH9nhGf4ylCsr2MUyp4NqVvdfudVXHtIZ3etUBPrcHnU7ufnzWO7SSRhHrZu42t
	 7E8g91E2RgxdodfeaVYLhz8qiq43ar7yIORUBNFZOXjhXFaOkVDejoodZDolmtafaD
	 qXcSTry4uekAQ==
Subject: Re: [PATCH net v2] net: gro_cells: prevent enabling threaded NAPI on
 gro_cells
From: netdev-bot+sashiko@kernel.org
To: namangulati@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 kuniyu@google.com, syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Date: Fri, 02 Oct 2026 01:03:32 +0000
Message-ID: <179090301201.434549.1629224862256105592@kernel.org>
In-Reply-To: <20260929010058.4063305-1-namangulati@google.com>
References: <20260929010058.4063305-1-namangulati@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The rewritten modify_napi_threaded() (net/core/net-sysfs.c) uses
  NAPI_STATE_NO_BUSY_POLL to mean "this NAPI cannot be threaded".
- [Medium] The commit message says the patch makes the write fail with
  -EOPNOTSUPP "when trying to enable threaded NAPI via sysfs" on netdevs…

--

net: gro_cells: prevent enabling threaded NAPI on gro_cells

This patch changes modify_napi_threaded() in net/core/net-sysfs.c.
A write to /sys/class/net/<dev>/threaded now reaches netif_set_threaded()
only if at least one NAPI on the device lacks NAPI_STATE_NO_BUSY_POLL.
The goal is to stop threaded NAPI from being enabled on per-CPU gro_cells
NAPIs, where the local_lock does not provide cross-CPU exclusion.

Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@google.com

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df75785..286c7b4139df1 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -743,17 +743,17 @@ static ssize_t threaded_show(struct device *dev,
>  
>  static int modify_napi_threaded(struct net_device *dev, unsigned long val)
>  {
> -	int ret;
> -
> -	if (list_empty(&dev->napi_list))
> -		return -EOPNOTSUPP;
> +	struct napi_struct *napi;
>  
>  	if (val != 0 && val != 1)
>  		return -EOPNOTSUPP;
>  
> -	ret = netif_set_threaded(dev, val);
> +	list_for_each_entry(napi, &dev->napi_list, dev_list) {
> +		if (!test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> +			return netif_set_threaded(dev, val);
> +	}
>  
> -	return ret;
> +	return -EOPNOTSUPP;
>  }

[Severity: High]
Does this break the threaded control on WireGuard devices?

WireGuard sets NAPI_STATE_NO_BUSY_POLL on every per-peer NAPI. It also
runs those NAPIs threaded by default:

drivers/net/wireguard/peer.c:wg_peer_create() {
    ...
	set_bit(NAPI_STATE_NO_BUSY_POLL, &peer->napi.state);
	netif_napi_add(wg->dev, &peer->napi, wg_packet_rx_poll);
	napi_enable(&peer->napi);
    ...
}

drivers/net/wireguard/device.c:wg_newlink() {
    ...
	netif_threaded_enable(dev);
	ret = register_netdevice(dev);
    ...
}

Once a peer has been added, the new loop never finds a NAPI without
NO_BUSY_POLL. Writing either 0 or 1 to /sys/class/net/wg0/threaded then
returns -EOPNOTSUPP:

threaded_store()->netdev_lock_store()->modify_napi_threaded()

Before this patch, a non-empty napi_list reached netif_set_threaded().
A call to netif_set_threaded(dev, 0) succeeded and stopped the kthreads.

Netlink does not offer another way to change this. napi_hash_add() skips
NO_BUSY_POLL NAPIs, so WireGuard NAPIs never get a NAPI ID. netdev-genl
exposes threaded only per NAPI, through napi-set.

As a result, threaded_show() still reports 1 on WireGuard, but users can
no longer turn threaded mode off. The ABI document for this file says:

    User could set this value to enable/disable threaded mode for all
    napi belonging to this device

The gro_cells problem comes from per-CPU cells protected by a local_lock,
not from NO_BUSY_POLL itself. Would a dedicated marker for NAPIs that
cannot be threaded work better here, similar to the NAPI_STATE_NO_THREADED
approach in v1? The patch carries Fixes: tags, so this change would also
reach stable kernels.

[Severity: Medium]
Should the NO_BUSY_POLL check apply only when val is 1?

The commit message says:

    Check NAPI_STATE_NO_BUSY_POLL in modify_napi_threaded(), and fail early
    with -EOPNOTSUPP when trying to enable threaded NAPI via sysfs on
    netdevs where all NAPIs have NAPI_STATE_NO_BUSY_POLL set.

The loop also runs when val == 0, though. gro_cells_init() sets the flag
on every cell NAPI:

net/core/gro_cells.c:gro_cells_init() {
    ...
		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
    ...
}

On gre, vxlan, geneve and other devices backed only by gro_cells, writing
0 to threaded used to reach netif_set_threaded(dev, 0) and succeed as a
no-op. It now returns -EOPNOTSUPP.

The commit message avoids napi_id_valid() because it "can potentially
break userspace". Could this change also break scripts that write 0 to
threaded on every interface? If the change is intended, could the commit
message mention it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929010058.4063305-1-namangulati%40google.com
