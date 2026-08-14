Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C003CBE79;
	Fri, 14 Aug 2026 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736721; cv=none; b=qfUs0ewhduNWniy3PEGB923Ez5DWRO1+BOg4L+S4dzhIEdKOfOGAxxHZJ/aZDjGt/S3/oPrin3EN9k0MJAUtoALsec3vb7838bMdxfmq92cPxQo4qnCbJRx3feBkTBLPggnCFDRjol06ZIzxhDoq1iEhuTbzT2kbmm6IJU4UgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736721; c=relaxed/simple;
	bh=Um924p4SN4TNjdu/6vLQuTgs3rQdyzW6dMu7n/xUFE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNe7+isinmSLZ1CA5xPn3/lOf1LKchxpY2PwgyLOH5fDxyN6swwqlZJWq/bPTrZNqkZznTdZOLywNW8PAfErDCizEjelCvUqKAGCm2P77tpDrw/J88Wt182pvGQ3U0rtLW+GZtM84tZidKHgFYMbO/B5TNaQnpmN/8eQkgD9jcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIZyZpFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIZyZpFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D711F000E9;
	Fri, 14 Aug 2026 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736720;
	bh=PegFeUG5l+yQlkSyzsnT2lnIIaiPORGQayirTpvI0LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIZyZpFV8vvq3fEd+BJ/e5SjNKapKJ5dRz3G4zqv9rLCFUMZYr0Dgi2J54MzZkzBZ
	 gkPmM72AnSPh5nKY60DMGyHDelQpXq4lL1ByqXpDeUrzhYgG+Jl5onFx9EyRG4tyvv
	 ut+rU5HCS3h+u2J/YYXRSL0zwjUnnFytSnrPfTkyLB6z3DtePXlfnDxlfmrODe6UI1
	 Wxgh9Js9zFhp6NaC8W15Bz9jaIuca60QOczM/t9zyxnKYWoNCdlFdKRKcisNkNHd8F
	 koG1asN3owr9axa4Ym3YaQQpRov6N4yKoc+FXF/MWEB5Z+QfL9n/MoVEAxNQaZABLS
	 OjUfKiPcCD2hQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v24 net-next 08/11] net/nebula-matrix: dispatch: add control-level routing core infrastructure
Date: Fri, 14 Aug 2026 12:45:18 -0700
Message-ID: <20260814194518.3200065-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807044422.2356-9-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: dispatch: add control-level routing core infrastructure

This adds the nbl dispatch layer: a dispatch mgt struct, an ops table
allocated with devm_kzalloc(), a ctrl_lvl bitmask, and local wrappers for
the resource layer init_module/deinit_module calls.  nbl_disp_init() is
wired into nbl_core_init() and nbl_disp_remove() into nbl_core_remove().

A few questions about the changelog and the new code below.

> Add base dispatch layer infrastructure for control-level routing:
> 1. Dispatch management & ops table structures allocation
> 2. X-macro op table template for uniform dispatch entry registration
> 3. Control PF / regular PF routing logic via ctrl_lvl bitmask
> 4. Local chip init/deinit dispatch wrappers (no channel dependency)
>
> Document constraint: init_module/deinit_module only valid
> on Control PF, caller must guard with has_ctrl to avoid NULL deref.

[Severity: Medium]
Do bullets 2 and 3 and the "Document constraint" paragraph match what the
patch contains?

For bullet 2, there is no X-macro anywhere in the patch.  The only related
artifact is the identity macro added to nbl_include.h:

    /* Used for macros to pass checkpatch */
    #define NBL_NAME(x)                                     x

and the two ops that do get registered are registered by plain pointer
assignment in nbl_disp_setup_ctrl_lvl():

    disp_ops->init_module = nbl_disp_init_module;
    disp_ops->deinit_module = nbl_disp_deinit_module;

A grep for NBL_NAME( under drivers/net/ethernet/nebula-matrix/ returns a
single hit, the definition itself, both at this commit and at the end of
the series, so no X-macro registration table is introduced later either.

For bullet 3, only the control PF direction is installed here:

    if (common->has_ctrl)
            nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);

NBL_DISP_CTRL_LVL_NET matches only its own enum declaration at this
commit, and the non-ctrl route appears later in "net/nebula-matrix:
dispatch: add channel RPC framework & shared hw ops mutex".  Could the
bullet be deferred to that patch?

For the "Document constraint" paragraph, no comment describing the
has_ctrl requirement appears in nbl_dispatch.c, nbl_dispatch.h or
nbl_def_dispatch.h.  Would it make sense to put that constraint next to
the init_module/deinit_module declarations in struct nbl_dispatch_ops so a
future caller can see it?

> This patch only provides core routing skeleton, no channel message
> handling or resource locking logic.

[Severity: Low]
This statement seems to conflict with the nbl_channel.c and
nbl_def_channel.h hunks below: the patch adds a new on-wire response code
enum (NBL_CHAN_RESP_OK/ERR/UNIMPLEMENTED), four mailbox payload layouts,
and four BUILD_BUG_ON() assertions inside nbl_chan_init_common().  Could
the changelog mention that this patch establishes a peer/firmware facing
wire contract?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> index 3eb795199217..9e0f9b6c4c3a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -1030,6 +1030,10 @@ int nbl_chan_init_common(struct nbl_adapter *adap)
>  	struct nbl_channel_mgt *chan_mgt;
>  	int ret;
>  
> +	BUILD_BUG_ON(sizeof(struct nbl_chan_param_cfg_msix_map) != 8);
> +	BUILD_BUG_ON(sizeof(struct nbl_chan_param_set_mailbox_irq) != 4);
> +	BUILD_BUG_ON(sizeof(struct nbl_chan_param_get_vsi_id) != 4);
> +	BUILD_BUG_ON(sizeof(struct nbl_chan_param_get_eth_id) != 8);

[Severity: Low]
The four sizes are numerically correct (2+2+2+2, 2+1+1, 2+2 and
2+1+1+1+3), so there is no functional problem here.

These are dispatch layer message structs though, and the assertions are
placed in the channel layer's runtime init function.  Would static_assert()
next to each struct definition in nbl_def_channel.h keep the wire format
check with the format it describes?

>  	chan_mgt = nbl_chan_setup_chan_mgt(adap);
>  	if (IS_ERR(chan_mgt)) {
>  		ret = PTR_ERR(chan_mgt);

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> new file mode 100644
> index 000000000000..9358651cbf7e
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -0,0 +1,112 @@

[ ... ]

> +static void nbl_disp_deinit_module(struct nbl_dispatch_mgt *disp_mgt)
> +{
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +
> +	if (res_ops->deinit_module)
> +		res_ops->deinit_module(p);
> +}
> +
> +static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
> +{
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +
> +	if (res_ops->init_module)
> +		return res_ops->init_module(p);
> +	return -EOPNOTSUPP;
> +}

[Severity: Low]
Can these NULL tests ever be false, and can -EOPNOTSUPP ever be returned?

nbl_res_setup_ops() already refuses to publish an incomplete table:

    if (!res_ops.get_vsi_id || !res_ops.get_eth_id  ||
        !res_ops.cfg_msix_map || !res_ops.destroy_msix_map ||
        !res_ops.set_mailbox_irq || !res_ops.init_module ||
        !res_ops.deinit_module)
            return ERR_PTR(-EINVAL);

and nbl_core_init() -> nbl_res_init_leonis() propagates that failure, so
nbl_disp_init() only runs with both pointers set.

That makes the guards and the -EOPNOTSUPP path unreachable while
advertising a return value a caller may try to handle.  This is still the
case at the end of the series.  Would it be cleaner to keep the validation
in one layer only?

> +
> +static void nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
> +{
> +	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
> +
> +	set_bit(lvl, disp_mgt->ctrl_lvl);
> +
> +	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
> +		disp_ops->init_module = nbl_disp_init_module;
> +		disp_ops->deinit_module = nbl_disp_deinit_module;
> +	}
> +}

[ ... ]

> +static struct nbl_dispatch_ops_tbl *
> +nbl_disp_setup_ops(struct device *dev, struct nbl_dispatch_mgt *disp_mgt)
> +{
> +	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
> +	struct nbl_dispatch_ops *disp_ops;
> +
> +	disp_ops_tbl = devm_kzalloc(dev, sizeof(*disp_ops_tbl), GFP_KERNEL);
> +	if (!disp_ops_tbl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	disp_ops = devm_kzalloc(dev, sizeof(*disp_ops), GFP_KERNEL);
> +	if (!disp_ops)
> +		return ERR_PTR(-ENOMEM);
> +
> +	disp_ops_tbl->ops = disp_ops;
> +	disp_ops_tbl->priv = disp_mgt;

[Severity: Low]
This publishes a zeroed struct nbl_dispatch_ops through
adapter->intf.dispatch_ops_tbl, and at this commit only init_module and
deinit_module are ever filled, and only when common->has_ctrl is set.  The
other five declared ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq,
get_vsi_id, get_eth_id) stay NULL for every PF.

Unlike the sibling constructors nbl_res_setup_ops() and nbl_hw_setup_ops(),
which return ERR_PTR(-EINVAL) when any op is NULL, the dispatch layer never
validates the table it hands out.

To be clear about reachability: I could not find a consumer that would hit
a NULL op.  By the end of the series nbl_disp_setup_ctrl_lvl() fills the
remaining five ops in both the MGT branch and the new else branch, and the
only call sites of init_module/deinit_module, nbl_dev_setup_ctrl_dev() and
nbl_dev_remove_ctrl_dev(), are reached only under if (common->has_ctrl) in
nbl_dev_init()/nbl_dev_remove().

Would adding the same completeness check the resource and hw layers use,
and documenting the has_ctrl-only validity of init_module/deinit_module in
the header, be worth doing here?

> +
> +	return disp_ops_tbl;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index b5a7b069d834..23bdd453ee73 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -13,6 +13,12 @@ struct nbl_adapter;
>  
>  typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
>  
> +enum {
> +	NBL_CHAN_RESP_OK = 0,
> +	NBL_CHAN_RESP_ERR = 1,
> +	NBL_CHAN_RESP_UNIMPLEMENTED = 2,
> +};
> +

[Severity: Low]
These response codes and the four nbl_chan_param_* layouts below have no
producer or consumer at this commit; they gain users in the following patch
"net/nebula-matrix: dispatch: add channel RPC framework & shared hw ops
mutex", which is fine for a staged series.  The point is only that the
changelog says this patch has no channel message handling while it defines
the channel response ABI.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> new file mode 100644
> index 000000000000..b26425e0112b
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> @@ -0,0 +1,42 @@

[ ... ]

> +enum {
> +	NBL_DISP_CTRL_LVL_NEVER = 0,
> +	NBL_DISP_CTRL_LVL_MGT,
> +	NBL_DISP_CTRL_LVL_NET,
> +	NBL_DISP_CTRL_LVL_MAX,
> +};

[Severity: Medium]
NBL_DISP_CTRL_LVL_NET is declared here but never set or tested at this
commit, which is the enumerator the changelog's "Control PF / regular PF
routing logic via ctrl_lvl bitmask" would rely on.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index 3f35982cb02a..5f33a5de908d 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -15,6 +15,8 @@
>  
>  #define NBL_MAX_FUNC					520
>  #define NBL_MAX_ETHERNET				4
> +/* Used for macros to pass checkpatch */
> +#define NBL_NAME(x)					x

[Severity: Low]
This identity macro has no users.  A grep for NBL_NAME( under
drivers/net/ethernet/nebula-matrix/ returns only this definition, both at
this commit and at the end of the series, and the X-macro table given as
its justification is never added.

Also, what exactly does checkpatch object to?  The comment says the macro
exists so later constructs pass checkpatch rather than to address the
underlying complaint.  Could this define be dropped?
