Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03B28853A;
	Wed,  4 Feb 2026 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176063; cv=none; b=PJ4SbvYCpCtlVQEdpaQ/jED4rvFlCN+V3gG7xawbnUYvlKiJmlON/uG7JrLz9wfnkf62ZCi1JWnZBD27gAJB82sWMC+8zxQFj1qwFVYElR8ShWMR8q5Kec9Memgpb+nqEGQgN/xRwpYXf43XSa74LEwHwGrbkSNGrm8CRJYA8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176063; c=relaxed/simple;
	bh=7LYvxop/UzbaNuWZbUeogMT49FY0BTln2u5Is5UWtG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKmUp871EVhiOQMuKe7Jzpns7nUtK++zS1leItBiS0Q5rLMp8wdlPQhvfTyc3MRCHKl/gD3TvAS05ir7E98EiQoW1EVn/ogI5wnzXix170NH0s+RKLoP0hEIMXsgSgacyi9n+e0vM0h0nIZc2X3RSQq6VvEkxt5CdvNYg1v5rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qicqvksi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qicqvksi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1813C4CEF7;
	Wed,  4 Feb 2026 03:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770176063;
	bh=7LYvxop/UzbaNuWZbUeogMT49FY0BTln2u5Is5UWtG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QicqvksiKfuumlQN2RbOXdDFALRemeRdpMmD8tlyPW6BnfrutQPnd1StNtVd66p7F
	 5yG3QN+gxd1kODozSEsOn/piXmVGYGQW48ZeZI3TGSCULVOM43SAQM/lBDliAIwMJq
	 vp3zexHHWJIcHKaDbZ4tLIj3VCeLlBbuJCCB1lRdhQBUw+dSWtLpYy8y4WLaNSNnsk
	 aQaIjGwTAyznLS5LE3+WA9I+v52QvvWYl7yJmI93xojqZr2/uJr3fdNIrKSwxxoE/v
	 1BuFGBnq7n2GuG5Q3nkHZfrYD3Ck7JUcsiXGFTLU4jDJ+ACIl6l2V6kjH/FvbyCPY+
	 0JVTy7lU5mgMg==
From: Jakub Kicinski <kuba@kernel.org>
To: jacky_chou@aspeedtech.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	andrew@lunn.ch
Subject: Re: [net-next,v3,08/15] net: ftgmac100: Move NCSI probe code into a helper
Date: Tue,  3 Feb 2026 19:34:21 -0800
Message-ID: <20260204033421.1665426-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202-ftgmac-cleanup-v3-8-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-8-6a6a8d45280a@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: ftgmac100: Move NCSI probe code into a helper

This commit refactors ftgmac100_probe() by extracting NCSI-specific probe
code into a new helper function ftgmac100_probe_ncsi(). The commit message
states "No functional change intended."

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index e511d6d5f7c2..9d8256d4d368 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1839,6 +1839,39 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
> 	return ret;
>  }
>
> +static int ftgmac100_probe_ncsi(struct net_device *netdev,
> +				struct ftgmac100 *priv,
> +				struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct phy_device *phydev;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_NET_NCSI)) {
> +		dev_err(&pdev->dev, "NCSI stack not enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_info(&pdev->dev, "Using NCSI interface\n");
> +	priv->use_ncsi = true;
> +	priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
> +	if (!priv->ndev)
> +		return -EINVAL;
> +
> +	phydev = fixed_phy_register(&ncsi_phy_status, np);
> +	if (IS_ERR(phydev)) {
> +		dev_err(&pdev->dev, "failed to register fixed PHY device\n");
> +		return PTR_ERR(phydev);

If fixed_phy_register() fails here, doesn't priv->ndev leak? The NCSI device
was registered via ncsi_register_dev() above, but this error path returns
without calling ncsi_unregister_dev().

> +	}
> +	err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> +				 PHY_INTERFACE_MODE_RMII);
> +	if (err) {
> +		dev_err(&pdev->dev, "Connecting PHY failed\n");
> +		fixed_phy_unregister(phydev);
> +	}
> +	return err;

Similarly, if phy_connect_direct() fails, fixed_phy_unregister() is called
but ncsi_unregister_dev(priv->ndev) is not.

[ ... ]

> @@ -1928,32 +1960,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  	}
>
>  	if (np && of_get_property(np, "use-ncsi", NULL)) {
> -		if (!IS_ENABLED(CONFIG_NET_NCSI)) {
> -			dev_err(&pdev->dev, "NCSI stack not enabled\n");
> -			err = -EINVAL;
> -			goto err_phy_connect;

[ ... ]

> -		phydev = fixed_phy_register(&ncsi_phy_status, np);
> -		if (IS_ERR(phydev)) {
> -			dev_err(&pdev->dev, "failed to register fixed PHY device\n");
> -			err = PTR_ERR(phydev);
> -			goto err_phy_connect;

The old code jumped to err_phy_connect on failure, which falls through to
err_ncsi_dev where ncsi_unregister_dev(priv->ndev) is called.

> +		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
> +		if (err)
> +			goto err_setup_mdio;

The new code jumps to err_setup_mdio, which skips the err_ncsi_dev label
entirely. Combined with the helper not cleaning up priv->ndev on its error
paths, this appears to be a behavioral change from the original code.
-- 
pw-bot: cr
