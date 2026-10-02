Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839935AC3B;
	Fri,  2 Oct 2026 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912119; cv=none; b=PAFOHOgGSdb5YxPrjKktnJn1qjsRJFAkP4Vh3Sd5KlHNzNrudbdw7NlRUQW2RfBOUJiXWbwiS2H3GdfbBxoM+vaNgfE8aheKP5ey0aG4WYyj8rCT0Q/U7+tywYSRsxHi+pDoEYInwBUkElTTa8I2+ObS/UCW3UMEVnoCMkL4aEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912119; c=relaxed/simple;
	bh=SeA0NVKssGs2rbR258GJXcqcgAhc/eBx0hXbnO63Gf4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjdhsARkSmsGaKBrsfE143ynicifL8jp3oeZjBjC76dMHClHZr1purbmlf6kZPNJBvz+1xPAzQJ3T+DC4wbmKvqShsge8+12hCYV2RGqWMQBC2M6fQ/9/R9LVZOmpPKQWkTGHw3AlwqzrdfxP7JENj9ZHXlwcQ32BtJy+wb+lEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV/Rj6yK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV/Rj6yK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E71F00893;
	Fri,  2 Oct 2026 03:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912118;
	bh=vtJ/T5+F0nCL38szeXRQlo63YEYDP8cNWqdWnph4ryI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FV/Rj6yKoGJCyHHr1mldSGFx+sba1jnDacXnP5hm/hMoTqh3uqO2I8ZRFZQ913BD4
	 jsMSDu11lxWDyvzZCo3W7Xucq0at/hHFKotqNF52A6D6T2RfiqWnf1pnT00l+ipKE5
	 5jEAv/3cL9OxbeY+dehpHqYqYVkM128d+ukitlQFyxN/0yc+UwnkTQ5pkpUPgOAdgl
	 PfZc3CheFd4MJ0IKF4mZQfoOpPUDckt7BUjgrwHkQe5Dob4rP59nXNrnOFDK3oahs4
	 jnlpTTYjSkceiMmfDhvH1G6CrdTsyOrPAG3wB5RuaYIfYTs0zinBQmwzyUpQICSvSg
	 QRD4L6JWWPfqQ==
Subject: Re: [PATCH v30 net-next 5/8] net/nebula-matrix: dispatch: add
 control-level routing core infrastructure
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:17 +0000
Message-ID: <179091211721.434549.6592428387777339791@kernel.org>
In-Reply-To: <20260928123237.88994-6-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-6-illusion.wang@nebula-matrix.com>
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

- [Low] The commit message of "net/nebula-matrix: dispatch: add control-
  level routing core infrastructure" says the patch will "Add wire ABI…
- [Low] At this commit, the kernel-doc Warning paragraph for struct
  nbl_dispatch_ops (nbl_def_dispatch.h lines 25-31) describes five…
- [Low] The kernel-doc for struct nbl_dispatch_ops (nbl_def_dispatch.h)
  calls @init_module "dispatch layer initialization" and @deinit_module…

--

net/nebula-matrix: dispatch: add control-level routing core infrastructure

This commit adds the nbl dispatch layer. It allocates a devm-managed
nbl_dispatch_mgt, an ops table and a ctrl_lvl bitmap. When has_ctrl is
set, it enables the MGT level and installs init_module/deinit_module
wrappers that forward to the resource ops.

> MGT level is only enabled for Control PF. Add kerneldoc for caller
> permission constraints. Add wire ABI structures with static_assert for
> upcoming mailbox RPC.

[Severity: Low]
Is the last sentence accurate for this patch? The diff touches the
Makefile, nbl_core.h, nbl_dispatch.c, nbl_dispatch.h, nbl_def_dispatch.h
and nbl_main.c. None of these files gets a mailbox wire-format struct or
a static_assert.

At this commit, the driver has one static_assert, for struct
nbl_board_port_info in nbl_def_channel.h. It was already there, and this
patch does not change it.

The RPC payload structs and their size checks (nbl_chan_param_cfg_msix_map,
nbl_chan_param_set_mailbox_irq, nbl_chan_param_get_vsi_id,
nbl_chan_param_get_eth_id) first appear in the next patch,
"net/nebula-matrix: dispatch: implement channel RPC framework and
serialize hardware ops".

Could this sentence be dropped here, or moved to that patch's commit
message?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> new file mode 100644
> index 000000000000..b3398591035b
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> @@ -0,0 +1,45 @@

[ ... ]

> +/**
> + * struct nbl_dispatch_ops - dispatch control plane operation callbacks
> + * @init_module: dispatch layer initialization, control-PF exclusive,
> + *               caller must check has_ctrl guard
> + * @deinit_module: dispatch layer cleanup, control-PF exclusive,
> + *                 caller must check has_ctrl guard

[Severity: Low]
Do "dispatch layer initialization" and "dispatch layer cleanup" describe
these callbacks correctly? All dispatch-layer setup happens in
nbl_disp_init(), and nbl_disp_remove() is empty. The installed callbacks
only forward to the resource ops:

nbl_disp_init_module()
    res_ops->init_module(p)          /* nbl_res_chip_init_module() */
        hw_ops->init_module(p, eth_speed, eth_num)

nbl_disp_deinit_module()
    res_ops->deinit_module(p)        /* nbl_res_chip_deinit_module() */
        hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv)

On leonis, these calls program the chip-wide datapath and set or clear
driver_status. Clearing driver_status starts asynchronous firmware
cleanup. nbl_dev.c notes that mailbox DMA must be drained before
deinit_module is called.

Would it be clearer to call these chip/firmware init and deinit, and to
mention the ordering requirement? That way later callers won't treat
deinit_module as software-only cleanup. The same wording is still there
at the end of the series.

> + *
> + * Warning: init_module/deinit_module are control-PF exclusive. The five
> + * resource ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq,
> + * get_vsi_id, get_eth_id) are PF-only and resolve to either a local
> + * resource call (control PF) or a mailbox RPC (non-control PF with
> + * has_net). A function with neither has_ctrl nor has_net leaves these
> + * pointers NULL; callers must not invoke them on such functions. VFs are
> + * rejected by the responders with -EPERM.
> + */
> +struct nbl_dispatch_ops {
> +	int (*init_module)(struct nbl_dispatch_mgt *disp_mgt);
> +	void (*deinit_module)(struct nbl_dispatch_mgt *disp_mgt);
> +};

[Severity: Low]
Is this paragraph describing code that isn't in this patch yet? Here,
struct nbl_dispatch_ops has only init_module and deinit_module, and the
enum has only NBL_DISP_CTRL_LVL_MGT. nbl_disp_init() never checks
has_net, and nbl_disp_refresh_ctrl_ops() installs only the MGT pointers:

	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
		disp_ops->init_module = nbl_disp_init_module;
		disp_ops->deinit_module = nbl_disp_deinit_module;
	}

The five ops, NBL_DISP_CTRL_LVL_NET, the has_net routing and the -EPERM
responders all come in the next patch, "net/nebula-matrix: dispatch:
implement channel RPC framework and serialize hardware ops". By the end
of the series, the doc matches the code.

Could this paragraph be added in that patch instead, so the documentation
in each commit matches its code?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
