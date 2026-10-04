Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08FB40961B;
	Sun,  4 Oct 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105156; cv=none; b=NMC37I4XXxK9SFklrpk0EdXBxxpgLvilGV6nGd3CJxoDy6Irg5devnEuZgjFeN0H9xXcfGmf1Yl+Kv7YOLSPEKZmc3J3I2beNKEqjYQVteuKqCJbe+NPApdkH2ScziPgAmTRwOwQp4qfnUlz29LEj+HdgXsiSgqBbQDBteT0b0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105156; c=relaxed/simple;
	bh=uI/QEbRcgN/rcqHFvGymydsmmO4HtFHp/gVvw25L5bw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X14wdwPyZUFn1mXCbf7iYjZmc7gyiKymGoBiZgMpOcuuDOBqHZWQd/dvo8AzgvWSvCvPSqyLX7wTkCV6HDTeBxikyBV7Q7OfhG7xClev2P9HsjoZwXSoU12XknCyH+DjTXNnKmwv13cY5x+1rjkHb6AG9doXkVf1075RH1ZXXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzIDgMXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzIDgMXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6773B1F00893;
	Sun,  4 Oct 2026 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105154;
	bh=+zDl+LAvuFrTzsXxauaAyeqR078BiwrOA/uX6qhKVDU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FzIDgMXYDk7Mj41u6DVsP1aQINahZ790rxgG8MDrjxvkfk86LlV/mtED5TmgKamHW
	 XByf+ErjFmmf0SSYM47ay1DELGqe5SyBV6wbov128RmT8LOykHA73U8iCOQPvV7m/Y
	 rdoOhJZIvp4tSVrIieQYtO8Ah/6DoCDt3tQj1K78e+zlDlGxAYowr2RHtyYSmACBe3
	 iSGhzVEkEkoohxllNRpDtDdYKx6bpcBD4vkouRmUPis9kyDkFCmWDmNcxEr5WEdS9V
	 YFBPFI1+tgetp2PZK6RrJnkPMvHGpI0cVU/CnYs/XM3nxSEjzMknUyzfJzcGT6btkg
	 yhrA5iOeumyjg==
Subject:
 Re: [PATCH v9 2/6] net: wwan: t9xx: Add control plane transaction layer
From: netdev-bot+sashiko@kernel.org
To: jackbb_wu@compal.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wen-zhi.huang@mediatek.com, shi-wei.yeh@mediatek.com,
 Minano.tseng@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robert_yu@compal.com, Jeff_Chang@compal.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-doc@vger.kernel.org
Date: Sun, 04 Oct 2026 09:12:32 +0000
Message-ID: <179110515297.434549.13978731531634280399@kernel.org>
In-Reply-To: <20260930-t9xx_driver_v1-v9-2-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-2-3248b9256956@compal.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit, mtk_ctrl_init() and mtk_ctrl_exit() in
  drivers/net/wwan/t9xx/mtk_ctrl_plane.c have no callers.
- [Low] struct mtk_ctrl_blk (mtk_ctrl_plane.h) has a 'struct
  mtk_ctrl_trans *trans' member, and struct mtk_ctrl_trans…
- [Low] mtk_ctrl_init() allocates ctrl_blk with devm_kzalloc(mdev->dev,
  ...).

--

net: wwan: t9xx: Add control plane transaction layer

This commit adds the core control plane structures (struct mtk_ctrl_blk
and struct mtk_ctrl_trans) and the mtk_ctrl_init()/mtk_ctrl_exit() entry
points for the T9XX WWAN driver. The DMA engine and TX/RX service
implementations are left to later patches.

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> new file mode 100644
> index 0000000000000..fa2ab8c3e7577
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> @@ -0,0 +1,44 @@

[ ... ]

> +int mtk_ctrl_init(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk;
> +
> +	ctrl_blk = devm_kzalloc(mdev->dev, sizeof(*ctrl_blk), GFP_KERNEL);
> +	if (!ctrl_blk)
> +		return -ENOMEM;
> +
> +	ctrl_blk->mdev = mdev;
> +	mdev->ctrl_blk = ctrl_blk;
> +
> +	return 0;
> +}

[Severity: Low]

This isn't a bug, but at this point in the series nothing calls
mtk_ctrl_init() or mtk_ctrl_exit(). That means:

- mdev->ctrl_blk in struct mtk_md_dev is never filled in.
- Nothing creates a struct mtk_ctrl_trans.
- Nothing in pcie/mtk_pci.c uses the newly added include:

    #include "mtk_trans_ctrl.h"

The subject says "Add control plane transaction layer", but this patch
only adds structures and helpers that nothing can reach yet.

The next commit, "net: wwan: t9xx: Add control DMA interface", adds the
callers:

    mtk_pci_probe()->mtk_pci_dev_init()->mtk_trans_ctrl_init()->mtk_ctrl_init()
    mtk_pci_remove()->mtk_pci_dev_exit()->mtk_trans_ctrl_exit()->mtk_ctrl_exit()

Could these helpers and the include move into the patch that adds their
callers? Otherwise, could the subject say that this patch only adds the
scaffolding?

> +
> +/**
> + * mtk_ctrl_exit() - Clean up the control plane block.
> + * @mdev: Pointer to the MTK modem device.
> + *
> + * Clears the control plane block pointer. The allocation
> + * itself is managed by devres and freed on driver detach.
> + */
> +void mtk_ctrl_exit(struct mtk_md_dev *mdev)
> +{
> +	mdev->ctrl_blk = NULL;
> +}

[Severity: Low]

This isn't a bug, but mtk_ctrl_init() allocates ctrl_blk with
devm_kzalloc(), and mtk_ctrl_exit() only clears mdev->ctrl_blk. Suppose
init and exit ran more than once while the device stayed bound. Each
mtk_ctrl_init() call would add another devres allocation and overwrite
mdev->ctrl_blk without freeing the old block.

That can't happen at the end of the series. The only path to
mtk_ctrl_init() is mtk_pci_probe()->mtk_pci_dev_init()->
mtk_trans_ctrl_init(). mtk_ctrl_exit() is reached only from
mtk_pci_remove() or the probe error path. Devres then frees the block at
unbind, as the kerneldoc says.

By the end of the series, mtk_ctrl_exit() also calls
mtk_fsm_notifier_unregister() and mtk_port_mngr_exit(). So the teardown
hook does end up in place.

Would it help to add a comment saying mtk_ctrl_init() may only run once
per bind? That would keep a future reset path from calling it again.

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.h b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
> new file mode 100644
> index 0000000000000..c141876ef95d3
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
> @@ -0,0 +1,22 @@

[ ... ]

> +struct mtk_ctrl_blk {
> +	struct mtk_md_dev *mdev;
> +	struct mtk_ctrl_trans *trans;
> +};

[Severity: Low]

This isn't a bug, but nothing assigns ctrl_blk->trans in this patch.
The back-pointers in the new struct mtk_ctrl_trans in
pcie/mtk_trans_ctrl.h are never set either:

    struct mtk_ctrl_trans {
    	struct mtk_ctrl_blk *ctrl_blk;
    	struct mtk_md_dev *mdev;
    };

mtk_ctrl_plane.h is a generic header, but it names the pcie-only struct
mtk_ctrl_trans. It does not include or forward-declare the header that
defines it. The code still builds, because C allows a member that points
to an undeclared struct tag.

The next commit, "net: wwan: t9xx: Add control DMA interface", replaces
this member with void *ctrl_hw_priv. Later in the series,
mtk_trans_ctrl_init() sets trans->mdev and mtk_pcie_hif_init() sets
trans->ctrl_blk.

Could the ctrl_hw_priv member be added here directly? That would avoid
adding a trans member that is removed one patch later.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-t9xx_driver_v1-v9-0-3248b9256956%40compal.com
