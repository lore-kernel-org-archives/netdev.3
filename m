Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221207;
	b=z05KSNbMmbE2pxW83IbcBZjVVpDhroOXAk1PSTTyBhkSHEmkjczEuXx1oLNxG2XsKwaR
	 hWGYAMgdfSH2tEmNlEcwo4phJOqF+Lwlg5iat21ycrVawpoVOiTzoj8Xz9ZAqve+YpywC
	 R0S5zu2achbv3KruGnO+68FuDWMeRxX4FxnFxl5GXyetlpOQuZOeFfPtzMlLx7Ilk7KCb
	 AJ44d9W1PK5NygrxyjfAA5zewDM11QrFV8if+kpZXu/mdgSAVKPAGSPq0s78eo8sbGdz8
	 6GlsjX1bIPZwmb825zifTnr5tZhu44f2KtxzHoNHeNxDqD2Y0SWBdE508vydEwbbffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221207;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EGLRBtrqwLmpuLL/DC/Zcp+EGbQUnDJwdb8d7ZNXyZw=;
	b=lP9afI2B9UOe3FV8KnhMrzqO9dI8fDcp0JzNcml6xALAN3Kijg+3sm9lXRPQ1VMH5/mF
	 ze2ez3TBSK9oHWWvYzn35MLId7pOM86XHKkMvy46HcW/25MUnV1yPIBb/5BTufXJP6+iV
	 vrNKomeolnvlXk+1spxvQFrOxr5XOK1cSxoObf3HeBH/EP0TTVoZ1SvtGOgqFMGhxxAcQ
	 L6pInn5jXRYXbF40JMEZ1j+D7LWMQ5/qxVGiIRkoEZxKtx7ktiD2iRUCMpV4A1vrARo1t
	 +Fd+mEcZe+1z+fmHzqZX/+APVEemaNV1gjgF8ZJR8fjVA/eXyXOJ0Ynz3jlvDKEPXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dro8/MQC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88486606A325;
	Mon,  9 Nov 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dro8/MQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E421F0089F;
	Mon,  9 Nov 2026 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221207;
	bh=EGLRBtrqwLmpuLL/DC/Zcp+EGbQUnDJwdb8d7ZNXyZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dro8/MQCh7R7TbkAjW26BFB+ihtZj8Wbf7vP0yl/I+MaAhv/gOlpgbg3xqAvSJE0N
	 TG0VHmR1JnLdYZWiTHIHdEkTKsnmJHiX6Yqg4KSUsNOt9MUW8sTW1XvYqXEPZSSsNA
	 i/hgHWE5q3LZT3rcu1W3XHY5Ys5DoI+wOB93omFwluipdFFKoK8jUd61lz4I/ndNgo
	 ieyq30nEKtMONxHi0pWIt03PAuKwhmwhAhSNlb3LyQMx4W7o3Aajq77qWQM+kVbzGz
	 AhKNYYZhR0mpIwbyP1C0B8NVaEVlNXDm/OjXU8PdA5anFaVzN7p1W30A/TEuRu4Tvl
	 HhiEw8uw4mNqQ==
Subject:
 Re: [PATCH net-next] net: dsa: motorcomm: Free the MIB block on port teardown
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 10:46:46 +0000
Message-ID: <179422120601.994134.564932634198490394@kernel.org>
In-Reply-To: <20261108101648.1308271-1-mmyangfl@gmail.com>
References: <20261108101648.1308271-1-mmyangfl@gmail.com>
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

- [Medium] The patch adds a memory leak on the yt921x_dsa_port_setup()
  error path (drivers/net/dsa/motorcomm/chip.c).
- [Low] A comment in yt921x_phylink_mac_link_down()
  (drivers/net/dsa/motorcomm/chip.c) is now false.

--

net: dsa: motorcomm: Free the MIB block on port teardown

The patch moves the per-port MIB block from devm_kzalloc() to
kvzalloc_obj() and frees it in yt921x_dsa_port_teardown(). The next
.setup() then gets zeroed counters after the hardware reset. The
disable/enable pairing of the MIB poll work in port_setup is dropped.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..fd737c3e2e184 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -1994,11 +1994,11 @@ static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct yt921x_mib *pm = pp->mib;
>  
> -	/* get_stats64() might not be synchronized with port_teardown(), hold
> -	 * the MIB block till the device teardown
> -	 */
> -	if (pm)
> +	if (pm) {
>  		disable_delayed_work_sync(&pm->work);
> +		pp->mib = NULL;
> +		kvfree(pm);
> +	}
>  }

[Severity: Low]

This isn't a bug, but the MIB block is now freed here on every tree
teardown, so the comment in yt921x_phylink_mac_link_down() looks stale:

drivers/net/dsa/motorcomm/chip.c:yt921x_phylink_mac_link_down() {
    ...
	/* No need to sync; port control block is hold until device remove */
	pm = priv->ports[port].mib;
	if (pm)
		cancel_delayed_work(&pm->work);
    ...
}

The code still looks safe, but for a different reason. DSA stops and
destroys phylink before .port_teardown():

  user ports:     dsa_user_destroy()->dsa_port_phylink_destroy()
  CPU/DSA ports:  dsa_port_disable_rt()->phylink_stop(), then
                  dsa_shared_port_link_unregister_of()

All of these run before dsa_port_devlink_teardown().

Could this comment be updated to give that reason instead of the old
devm lifetime?

[ ... ]

> @@ -2006,12 +2006,11 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
>  	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
>  	struct yt921x_port *pp = &priv->ports[port];
>  	const struct yt921x_info *info = priv->info;
> -	struct device *dev = yt921x_priv_to_device(priv);
>  	struct yt921x_mib *pm = pp->mib;
>  	int res;
>  
>  	if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
> -		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
> +		pm = kvzalloc_obj(*pm);
>  		if (!pm)
>  			return -ENOMEM;
>  		pp->mib = pm;

[ ... ]

> @@ -2031,9 +2026,6 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
>  	if (res)
>  		return res;

[Severity: Medium]

Now that the MIB block is no longer devm-managed, does this error path
leak it?

pm is allocated with kvzalloc_obj() and stored in pp->mib before
yt921x_port_setup() runs. yt921x_port_setup() can fail, for example
when a register write fails in yt921x_userport_standalone() or in the
YT921X_PORTn_PRIO_ORD or YT921X_PORTn_ISOLATION writes. In that case
this function returns without freeing pm.

The DSA core doesn't call .port_teardown() after a failed .port_setup():

net/dsa/devlink.c:dsa_port_devlink_setup() {
    ...
		err = ds->ops->port_setup(ds, dp->index);
		if (err)
			return err;
    ...
}

dp->setup stays false, so dsa_tree_teardown_ports()->dsa_port_teardown()
skips this port:

net/dsa/dsa.c:dsa_port_teardown() {
    ...
	if (!dp->setup)
		return;
    ...
}

yt921x_mdio_remove() frees the ACL blocks but not priv->ports[].mib.

With a single switch, dsa_register_switch() fails and so does probe.
The devm-allocated priv, which holds the only pointer to the block, is
then freed.

For user ports, dsa_port_setup_as_unused() retries and reuses the
leftover pm. If that retry also fails, the block leaks the same way.

The commit message says .port_teardown() "pairs with every successful
.port_setup()", which doesn't cover the failed-setup case.

Could this path kvfree(pm) and clear pp->mib when this call did the
allocation? Another option is to allocate only after yt921x_port_setup()
succeeds.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108101648.1308271-1-mmyangfl%40gmail.com
