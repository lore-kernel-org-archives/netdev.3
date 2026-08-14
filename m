Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6018FDDE;
	Fri, 14 Aug 2026 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673054; cv=none; b=LDHOnUacqwa8wfHQkzpyC1RXglyNzIPHRVbJmpNe+oBMHrWA+m05DficOS3joYB6wmaxoeTy2Q/dFfSVM9glPzhT8V7yx9DO4DlZ8JSRV4uufkQGZqbPsZj47QUL6pClWFo4MqbVBx7ZIgNel9jlhlbTgjqTwZ+x8m/k4T6WqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673054; c=relaxed/simple;
	bh=hHpR18k9I+Ngs5LkxTU+erd1qOKO2BBGAXXDDlgkbLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0eGc9hKGKrIaa1wgy2AeBGFudZX38LJcaXZ4Wjf6n+RxViB+YpQVnJy2O2N3Drrs9HxZMNnyNZrVuH2DcZrARFaw4yqpRM87jtFtxsJZ4qmqZhcnLRQaRF2jVQht/JGPeNUkJYriCgi3JMZHUbyGU4sUjfBRZzDe/UTJmcOEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlNB+gkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlNB+gkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C611F000E9;
	Fri, 14 Aug 2026 02:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673052;
	bh=i0GveM913yNieNQlwzfbV2Ur/22VUi/L//5uORRBYR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlNB+gklfdvt+kF/Xfx+X74t8uOMr8fDwY7pvZaGNm6pU5QPbUEzi13v/QW7tK9vR
	 5YU4Et0xiFHSSV97rX59idXOo1iaS7DNL3NfmQXmlKS64C9oNtYAR4WBwN8wv3RdjM
	 yHBiuEjgIzzCRHrG2sRQ5lbvxvTVFrOAGnHafuIbGBnz2i3ml0QV+YumZ1UDwR1RvN
	 40cCQwMlq9mXLYF4XIoQfEhInd64TtpVqzdaT9zetQAo9Ae7RtDNFM3lydW7IdgssI
	 rZVxa/c47ZxuUf32px7CVLOKE/QJ7gPcr6vikL5h/d4wzez8JZgefCQn+LiNuyunL5
	 GaHeGrDM35smQ==
From: Jakub Kicinski <kuba@kernel.org>
To: christophe.roullier@foss.st.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH 1/1] net: stmmac: Fix manage error case during stmmac_dvr_probe
Date: Thu, 13 Aug 2026 19:02:36 -0700
Message-ID: <20260814020235.2839045-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810150749.458682-2-christophe.roullier@foss.st.com>
References: <20260810150749.458682-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Please see the AI-generated review of your patch below.

If what the AI suggests (flipping the order) is correct -
we definitely need a comment on this, 'cause it's counter-intuitive.
---
net: stmmac: Fix manage error case during stmmac_dvr_probe

The probe error path starting at the error_mdio_register label in
__stmmac_dvr_probe() did not undo the runtime PM setup done just before
stmmac_mdio_register(). This patch adds a put and a disable of runtime PM
to that label.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3c..37d06fc6dba47 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8080,6 +8080,8 @@ static int __stmmac_dvr_probe(struct device *device,
>  error_pcs_setup:
>  	stmmac_mdio_unregister(ndev);
>  error_mdio_register:
> +	pm_runtime_put_sync(device);
> +	pm_runtime_disable(device);

[Severity: High]
Should the order of these two calls be swapped, as in stmmac_dvr_remove()?

As written, pm_runtime_put_sync() runs while runtime PM is still enabled
and the status is RPM_ACTIVE (set earlier in __stmmac_dvr_probe() by
pm_runtime_get_noresume() / pm_runtime_set_active() / pm_runtime_enable()).
There is no ->runtime_idle callback and no autosuspend in this driver:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:
	SET_RUNTIME_PM_OPS(stmmac_runtime_suspend, stmmac_runtime_resume, NULL)

so dropping the usage count to zero synchronously runs
stmmac_runtime_suspend() -> stmmac_bus_clks_config(priv, false):

	} else {
		clk_disable_unprepare(plat_dat->stmmac_clk);
		clk_disable_unprepare(plat_dat->pclk);
		if (plat_dat->clks_config)
			plat_dat->clks_config(plat_dat->bsp_priv, enabled);
	}

But pm_runtime_set_active() is only bookkeeping - runtime PM never took a
clock reference of its own. stmmac_clk and pclk were prepared/enabled once
in stmmac_probe_config_dt(), and devm_stmmac_probe_config_dt() registered
the devres action that disables them again:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:devm_stmmac_remove_config_dt() {
	clk_disable_unprepare(plat->stmmac_clk);
	clk_disable_unprepare(plat->pclk);
	...
}

Can this lead to a double clk_disable_unprepare() when probe unwinds?  The
new put gates the clocks, then the error propagates out and the glue driver
error path plus devres unwinding disable the same clocks again, for example
in dwmac-imx:

	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
	if (ret)
		imx_dwmac_clks_config(dwmac, false);

which would hit the clk core warnings in clk_core_disable()
("%s already disabled") and clk_core_unprepare() ("%s already unprepared"),
with a panic on panic_on_warn systems.  25 glue drivers reference
stmmac_pltfr_pm_ops, so the same callback applies broadly.

Is this reachable in practice?  stmmac_mdio_register() returns -ENODEV on
the "No PHY found" path, and stmmac_pcs_setup(), stmmac_phylink_setup(),
stmmac_register_devlink() and register_netdev() all fall through to this
same label.

A related question: since the clocks are now gated for the rest of the
teardown, is it still safe for the plat_dat->exit() callback invoked by
stmmac_dvr_probe() on failure to touch MAC registers?

Would the following match the existing convention in stmmac_dvr_remove(),
which disables first and then uses a put that cannot invoke
->runtime_suspend, leaving the clocks on for the platform/devres teardown?

	pm_runtime_disable(device);
	pm_runtime_put_noidle(device);

>  	stmmac_napi_del(ndev);
>  error_hw_init:
>  	destroy_workqueue(priv->wq);
-- 
pw-bot: cr
