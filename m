Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443B348C77;
	Fri,  2 Oct 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914248; cv=none; b=IBo+3t/BUydxAmecmzdD6kIb5GwRtCZWG2wY5UVCeh88b26CBk8rkyUwyN/K0VgtMvJk7v6yKibV8wCDvbxWb36vv7cFUAwN/kHa0RezJR2F1W95OICZpEIP1XN8njmcryLo3SvrTbYGIPnSaNn56xZU0GVi8cYOmk1lXSDckvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914248; c=relaxed/simple;
	bh=Z68kw3B//GZ0Z5MiZwwLl3pL5mKjupQkiGeOeAPeaMg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDtgf5a9yjb0c/m3kfKGduCYQDhcGjvZqqQoboBYByFn9HS+FBRaD9fG1F1tZsdwHE5hfC+f1B74K1GX05TG+z7kfWCZ0S58KnlHIMfWdeVl9vwr0RVn0DYXeYLhbPQ352CTgNu/9Z7Di9D384TgsmHvL6NytVULfPPDS7UXY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpG6wJ7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpG6wJ7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B66B1F00893;
	Fri,  2 Oct 2026 04:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790914247;
	bh=UPQNdbltyWislDfxyV/39mDFxqpnG8TnmbEQcw8RkGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RpG6wJ7dJmLiHXJSMnHp4aPmjCmPR7LpSyZpd6SzqyVEu6Znz+jMX/SZaFlb8q4Tt
	 lWPdybZTAXm4Nnxdz7ZY8niEJxptHY1umo40kgKlCk3NqpdbAfXGgt8MpZvk5m7UDm
	 Ckq9Q7ZdVjBFlgTykvTdX/BAnvUza+YLFVkm6LJsVEO7vQQ0Glzzi+2skogR6fO+bO
	 +XHoxJsfURirDFU2Gl9+3q1fvYqmfTf7YtonqtJw6Ux8Wso46PFOZ8VcBfbqltzUXw
	 xa+zdFdcdIG0Iv6TggSteFA52X4158i8zouQhqavK1OlNWGP+QGuRyvA7NzBHx85nl
	 Swh38c7Shs2LQ==
Subject: Re: [PATCH net-next v4 3/3] net: dsa: qca8k: support QCA8337 internal
 PHY CPU links
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, hzyitc@outlook.com, ansuelsmth@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 04:10:45 +0000
Message-ID: <179091424589.434549.6889429704601031156@kernel.org>
In-Reply-To: <20260928220811.1880-4-yongzhao.derek@gmail.com>
References: <20260928220811.1880-4-yongzhao.derek@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new MDIO-filter clause in qca8k_setup_mdio_bus()
  (drivers/net/dsa/qca/qca8k-8xxx.c:1017-1018) puts any CPU port on 1..5…
- [Low] qca8k_phylink_mac_link_up()
  (drivers/net/dsa/qca/qca8k-8xxx.c:1485-1489) sets…
- [Low] The patch removes the dev_dbg("port 0 is not the CPU port.
- [Low] Concern: with an internal CPU port written as phy-mode =
  "internal" and user ports reached through the external MDC pass-…

Pre-existing issues:
- [Medium] On QCA8337, a DT that declares CPU ports on an internal port
  (1..5) and on port 6 makes qca8k_find_cpu_port() pick port 6.

--

net: dsa: qca8k: support QCA8337 internal PHY CPU links

On QCA8337, this patch lets qca8k_find_cpu_port() fall back to internal
PHY ports 1-5 when neither port 0 nor port 6 is a CPU port. It adds CPU
ports 1-5 to the internal/external MDIO classification in
qca8k_setup_mdio_bus(). It also rewords the error that qca8k_setup()
prints when no CPU port is found.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index dfe18b6e936bf..c30913a3c2784 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1014,7 +1014,8 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
>  			return ret;
>  		}
>  
> -		if (!dsa_is_user_port(priv->ds, reg))
> +		if (!dsa_is_user_port(priv->ds, reg) &&
> +		    !(reg > 0 && reg < 6 && dsa_is_cpu_port(priv->ds, reg)))
>  			continue;

[Severity: Medium]
This clause lets any CPU port on 1..5 into the MDIO classification. It
does so on every switch model, and also when port 0 or 6 is a CPU port.

The QCA8337-only check exists only in qca8k_find_cpu_port(), after the
early returns for ports 0 and 6. So the two functions can disagree about
which ports count as internal CPU links.

Before this patch, a secondary CPU port on 1..5 is not a user port, so it
hit the continue. Now it gets classified. For example, it sets
internal_mdio_mask if it has no phy-handle (or uses a fixed-link), or if
it has phy-mode = "internal".

The user ports may use the external MDIO pass-through (phy-handle and no
phy-mode, as in the binding's external MDIO example). In that case they
also set external_mdio_mask, and then:

	if (!!external_mdio_mask && !!internal_mdio_mask) {
		dev_err(priv->dev, "either internal or external mdio bus configuration is supported.\n");
		return -EINVAL;
	}

Could qca8k_setup() now fail with -EINVAL on a DT that probed before
this patch?

The commit message says QCA8327 internal CPU links are "not enabled" and
that the change is made "without altering the handling of MAC-only or
external user ports". Should this clause be limited to QCA8337, and to
the port that qca8k_find_cpu_port() actually selected?

[Severity: Low]
Related to this, the commit message describes an internal CPU PHY
"configured with an explicit phy-handle and phy-mode = "internal"".

On boards whose user ports use the external MDC pass-through, such a CPU
port goes into internal_mdio_mask while the user ports go into
external_mdio_mask. Setup then fails with the existing mixed-configuration
error.

The binding says this mixed configuration is not supported by the
hardware. A CPU port described the same way as the user ports
(phy-handle, no phy-mode) is classified as external and works.

This isn't a bug, but could the commit message say that on external MDIO
boards the CPU port should be described the same way as the user ports,
rather than with phy-mode = "internal"?

>  
>  		of_get_phy_mode(port, &mode);
> @@ -1090,16 +1091,23 @@ qca8k_setup_mac_pwr_sel(struct qca8k_priv *priv)
>  static int qca8k_find_cpu_port(struct dsa_switch *ds)
>  {
>  	struct qca8k_priv *priv = ds->priv;
> +	int port;
>  
> -	/* Find the connected cpu port. Valid port are 0 or 6 */
>  	if (dsa_is_cpu_port(ds, 0))
>  		return 0;
>  
> -	dev_dbg(priv->dev, "port 0 is not the CPU port. Checking port 6");
> -
>  	if (dsa_is_cpu_port(ds, 6))
>  		return 6;

[Severity: Medium]
This isn't a bug introduced by this patch, but consider a QCA8337 DT that
declares CPU ports on both an internal port (1..5) and port 6. Here
qca8k_find_cpu_port() returns 6.

However, dsa_tree_setup_cpu_ports() in net/dsa/dsa.c sets dp->cpu_dp for
every user port to the lowest-index CPU port, because qca8k does not
provide .preferred_default_local_cpu_port.

qca8k_setup() programs GLOBAL_FW_CTRL1 flooding and the LOOKUP_MEMBER
masks from cpu_port = 6. qca8k_update_port_member() in qca8k-common.c
later uses:

	u32 port_mask = BIT(dp->cpu_dp->index);

That is the internal port. Setup cleared its own LOOKUP_MEMBER and
nothing sets it again. Can hardware forwarding and DSA disagree about
which CPU port is in use here?

The baseline code also returned 6 for this DT. The new fallback loop only
runs when neither 0 nor 6 is a CPU port, so this patch does not change
that behaviour.

>  
> +	/* Internal PHY CPU port selection is currently enabled for QCA8337. */
> +	if (priv->switch_id != QCA8K_ID_QCA8337)
> +		return -EINVAL;
> +
> +	/* An internal PHY can provide a PHY-to-PHY CPU link. */
> +	for (port = 1; port < 6; port++)
> +		if (dsa_is_cpu_port(ds, port))
> +			return port;

[Severity: Low]
With this fallback, the CPU port on QCA8337 can be an autonegotiated
internal PHY port. qca8k_phylink_mac_link_up() turns flow control on for
every CPU port, whatever pause state phylink resolved:

	if (rx_pause || dsa_port_is_cpu(dp))
		reg |= QCA8K_PORT_STATUS_RXFLOW;

	if (tx_pause || dsa_port_is_cpu(dp))
		reg |= QCA8K_PORT_STATUS_TXFLOW;

Before this patch, the CPU port could only be port 0 or 6 on a fixed
link. On a PHY-to-PHY CPU link, tx_pause and rx_pause hold the negotiated
result. Will PORT_STATUS enable PAUSE even when negotiation settled on no
pause?

The commit message says the existing phylink callbacks "already handle"
these internal interfaces. Should the dsa_port_is_cpu() override apply
only to ports 0 and 6?

> +
>  	return -EINVAL;
>  }
>  
> @@ -1851,7 +1859,7 @@ qca8k_setup(struct dsa_switch *ds)
>  
>  	cpu_port = qca8k_find_cpu_port(ds);
>  	if (cpu_port < 0) {
> -		dev_err(priv->dev, "No cpu port configured in both cpu port0 and port6");
> +		dev_err(priv->dev, "No CPU port configured");

[Severity: Low]
This isn't a bug, but the commit message does not mention removing the
dev_dbg() in qca8k_find_cpu_port() or rewording this error.

The new text is also misleading for the rejection path this patch adds.
On QCA8327, or any model other than QCA8337, with a CPU port on 1..5, the
switch_id check in qca8k_find_cpu_port() returns -EINVAL. This message
then says "No CPU port configured" even though one is configured.

Could the message list the valid ports, or say that internal CPU ports
are only accepted on QCA8337?

>  		return cpu_port;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928220811.1880-1-yongzhao.derek%40gmail.com
