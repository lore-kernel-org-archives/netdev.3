Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A74E0B86
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849438; cv=none; b=DvA5bQy7vklaczKs2M+7yMLnZUwv4QuIDEi28A93DP2V9TM32Sv2u0lht/nefenWDDhCFvPBITOQynk/fwzPPyhWI/Yw5ILQK6qK+g6dHxu2W4p4J8cu9MlDOxxbw7OLnJalrEUJuP2lypE9gZ03cE9wJPSDAgeo2eYGednqfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849438; c=relaxed/simple;
	bh=KKONlWY/83+wTCksz++GLv0bMBuWDcN16F+JIoZNTTU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ur4qyDLmXqesvKYYYdXxgQUalpIglvsz85eNM1V5Ref4s2vT1Rgt9dgYvdXnMt0JsuM9kO5pBZTKEJoIGH9c0O7nj2Ad5HtHlocIsxqSw70E/LuwrRwbSAOJbTja+mKuVMMsibKb/19U3Kaux5zfpZ9KL5N1bkaoohh6/DwZB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eofFC4Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eofFC4Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9161F000FF;
	Thu,  1 Oct 2026 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849427;
	bh=vlZGPYj1d1ZFsTdMsJcZLBSvncgKD90m2oBH2nB0+Kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eofFC4RdFUidCEZGVIf4FkUIkwKJfrBs7SsMqyEqvHmXSsI+4sGjNkdf1aQrNQ34f
	 YIk2KlDxb53p4K3NXANA7p+BNmbChmpDRGejcZhaotluDtOO2+d7eKyuqfatu2GGYL
	 JN+ZT1j7Q+oH2ed9/8b0c3LmmalQ2T82CcfktgiUTXSS1kWmdwxLcReG6fJvHD2aVP
	 3dGxHe2S5QU5t/ntvDM5vBwqAl97NLQ59DGLJ2pYgwr8I93Xaiw258hHqT3bYOTSxy
	 nCUbDXut6caHtFrEnP7WrqYoWZqJ4UyPitp79iZWZiLi+2Ngal/gQF6jNQfNtlLlw9
	 Cg3gnCi3KsE0w==
Subject: Re: [PATCH net-next 1/9] batman-adv: bla: avoid double free after
 failed backbone_hash alloc
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:26 +0000
Message-ID: <179084942612.434549.483028329310521943@kernel.org>
In-Reply-To: <20260930094558.3723766-2-sw@simonwunderlich.de>
References: <20260930094558.3723766-2-sw@simonwunderlich.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a double free that cannot happen.

--

batman-adv: bla: avoid double free after failed backbone_hash alloc

This commit sets bat_priv->bla.claim_hash to NULL after
batadv_hash_destroy() in the batadv_bla_init() error path taken when the
backbone_hash allocation fails. The commit message says that the
destructor later frees claim_hash a second time via batadv_mesh_free()
-> batadv_bla_free().

> When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
> the (previously) allocated claim_hash. The initialization function will
> then return an error and the net_device initialization will stop. The
> destructor will be called instead and (indirectly via batadv_mesh_free() ->
> batadv_bla_free()) will try to free the bat_priv->bla.claim_hash again.

[Severity: Medium]

Can this sequence actually happen? batadv_bla_init() has only one
caller, batadv_mesh_init(), and when it fails that function jumps past
batadv_bla_free():

net/batman-adv/main.c:batadv_mesh_init() {
    ...
	ret = batadv_bla_init(bat_priv);
	if (ret < 0) {
		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
		goto err_bla;
	}
    ...
err_dat:
	batadv_bla_free(bat_priv);
err_bla:
	batadv_v_mesh_free(bat_priv);
    ...
}

batadv_mesh_init() is only reached from batadv_meshif_init_late(), the
.ndo_init callback, which returns the error. In register_netdevice(), an
ndo_init failure skips the priv_destructor call:

net/core/dev.c:register_netdevice() {
    ...
	if (dev->netdev_ops->ndo_init) {
		ret = dev->netdev_ops->ndo_init(dev);
		if (ret) {
			if (ret > 0)
				ret = -EIO;
			goto err_free_name;
		}
	}
    ...
err_uninit:
	if (dev->netdev_ops->ndo_uninit)
		dev->netdev_ops->ndo_uninit(dev);
	if (dev->priv_destructor)
		dev->priv_destructor(dev);
err_free_name:
	netdev_name_node_free(dev->name_node);
	goto out;
}

After that, free_netdev() sees reg_state == NETREG_UNINITIALIZED and
only calls kvfree(dev). So batadv_meshif_free() -> batadv_mesh_free() ->
batadv_bla_free() does not seem to run on this path, and nothing reads
or frees the stale claim_hash pointer again.

Also, if the destructor did run here, wouldn't batadv_bla_free() call
disable_delayed_work_sync(&bat_priv->bla.work) on work that was never
set up? INIT_DELAYED_WORK() only runs after both hashes are allocated.
The patch doesn't handle that case, so the description and the fix don't
seem to match.

This makes the change look like harmless hardening rather than a
double-free fix. Could the commit message describe it that way, or show
the path where the second batadv_hash_destroy() actually happens? As
written, stable or CVE tooling may treat it as a memory-safety fix.

> diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
> index ad6ab4a50658f..a96f269da8d37 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -1625,6 +1625,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
>  	bat_priv->bla.backbone_hash = batadv_hash_new(32);
>  	if (!bat_priv->bla.backbone_hash) {
>  		batadv_hash_destroy(bat_priv->bla.claim_hash);
> +		bat_priv->bla.claim_hash = NULL;
>  		return -ENOMEM;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
