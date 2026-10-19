Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452026;
	b=F3Wqxh0okbiOXpxoqryJPj9n4xvKwEGtd1rAPB2U9m6VW4uVem+rwwxhJudlP5DVvM0P
	 a7YpTJ1LawN7Rndia27KrwKQhHAoJ3gigPSHlvoJkUzISLwnbJ/buqzgpL991oI0DWbVb
	 sNtT0b2CyVngpE0nZaf+tdx2gBA52GSSKNJ30Qka0aVjMewJBYCxhKur+avAcZPI+QFma
	 Pnp5tnP/FzDsVK5R7628FWrMcc5sQ38wIRB5bAKbafBV8Ot7P6uf4V//UQxykBBxPF26j
	 KaKqwkl+ZN59mDzDKmBnUgTVPjCx3a9xngskfKJFrzG+/QaSAk8hG0BFYb6zG5s4x5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452026;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cWkh3vcKbn9kL4r/H5CdFN/78AVMZJQH0p0NN/6/v10=;
	b=XN+68CzgMh1Nk8G5tak5vLqp3blRAjmNW325XOl+D7fF5GqSo+sHdKZpdOQBrVHwtHZf
	 eTYvyc8G2p+bMOBkmLmETkJvHUNfomIkV9JPR4D5iXehl9ZDZJXEz8ZzhhPkDibUGAdhN
	 5Hq09ABul+uE+37Yk2P472ByxjFtiXa9KG+Ont2cgJfKxWJecZO2YGlyU3Kd9vxsqGEPu
	 z4i0jRyeyalcCRgGlft4s+7xfhTO3kLHaHwLid0zsvWkUNOZPXJkMob8NGHiNgu+oRM3h
	 duzj7gIqX2yWjo74SKCdvNnGZf4F4tLkhGckzV4BU41WMLjPeCSvy8iskQRTL2U30cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osq+oCCn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11502606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osq+oCCn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159351F000C6;
	Mon, 19 Oct 2026 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452025;
	bh=cWkh3vcKbn9kL4r/H5CdFN/78AVMZJQH0p0NN/6/v10=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=osq+oCCnIOEBHkC/oreQHaxHQKCSH/Iu55uXuChy/Fy3JkKcvsHdf4LoQQ+h8mktc
	 /vEF+SfCwKTl2pDslF94hTrme9cawM+U6mPemBGJqHf+YjukiO0POLolRIqmhws+Hi
	 MVvnpP5OOl4OoHL62y97JxWbXdyoHqSCeJx3B0kqZlZ2D+sXAaH0W6vR76SYB/xm40
	 XtBod/S0MXoKoFV0NS7+UwSkS19bp0t/EbCCq81naQnmiV4Y5CYPaW55Qd08BSj/9L
	 g9NPVwjd+kLMghSF9xJ2kVsgubQ0z1qfGlhLuDlKiFAGlkNNuUsldP6IostqcB+T2N
	 0n1WO2OBCz6tA==
Subject: Re: [PATCH net v2 2/2] ionic: free port_info when probe fails after
 the port is set up
From: netdev-bot+sashiko@kernel.org
To: eric.joyner@amd.com
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nikhil.rao@amd.com, vadim.fedorenko@linux.dev, edumazet@kernel.org
Date: Mon, 19 Oct 2026 23:20:24 +0000
Message-ID: <179245202451.3135.14858672804771242161@kernel.org>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-2-57232013fd79@amd.com>
References: <20261015-ionic-port-info-lifetime-v2-2-57232013fd79@amd.com>
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

- [Medium] The new ionic_port_reset() call in ionic_probe()'s err_out_pci
  frees the port_info buffer with dma_free_coherent() even when the…

--

ionic: free port_info when probe fails after the port is set up

This patch adds an ionic_port_reset() call at the err_out_pci label in
ionic_probe(). The goal is to free the port_info DMA buffer that
ionic_setup_one()->ionic_port_init() allocated when probe fails later.
It follows the cleanup order already used in ionic_remove().

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 05f19489ec5c8..68b3bceedd999 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -397,6 +397,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  err_out_free_irqs:
>  	ionic_bus_free_irq_vectors(ionic);
>  err_out_pci:
> +	ionic_port_reset(ionic);

[Severity: Medium]
Is it safe to free port_info here if the PORT_RESET command never
completes?

ionic_port_reset() sends the command, but the wait result does not
decide whether the free happens:

drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_reset() {
    ...
	if (ionic_is_fw_running(idev)) {
		mutex_lock(&ionic->dev_cmd_lock);
		ionic_dev_cmd_port_reset(idev);
		err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
		mutex_unlock(&ionic->dev_cmd_lock);
	}

	dma_free_coherent(ionic->dev, idev->port_info_sz,
			  idev->port_info, idev->port_info_pa);
    ...
}

__ionic_dev_cmd_wait() can return -ETIMEDOUT while the firmware still
reports that it is running:

	if (!done && !time_before(jiffies, max_wait)) {
		ionic_dev_cmd_clean(ionic);
		dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
			 ionic_opcode_to_str(opcode), opcode, max_seconds);
		return -ETIMEDOUT;
	}

ionic_dev_cmd_port_init() passed port_info_pa to the firmware through
port_init.info_pa. The comment in ionic_get_link_ksettings() says the NIC
updates this buffer by DMA on its own.

Bus mastering, enabled by pci_set_master() in ionic_setup_one(), stays on
until pci_disable_device() in ionic_clear_pci(). That runs only after
ionic_dev_teardown().

Take a probe failure like an adminq timeout in ionic_lif_init(). The
firmware could be running but not answering dev-cmds. If it keeps writing
port status into port_info during that window, can it DMA into pages that
have already been freed and possibly reused?

Before this patch, the buffer was leaked on this path instead of freed.

The commit message says:

    the firmware gets a PORT_RESET before the buffer is freed, the same
    order as in ionic_remove().

However, the command is only sent here, and its completion is never
checked. ionic_remove() uses the same pattern, so this patch carries that
convention over to the probe failure path.

Should the free be skipped when the PORT_RESET wait fails? Alternatively,
could it be deferred until bus mastering has been disabled?

>  	ionic_dev_teardown(ionic);
>  	ionic_clear_pci(ionic);
>  	ionic_debugfs_del_dev(ionic);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-ionic-port-info-lifetime-v2-0-57232013fd79%40amd.com
