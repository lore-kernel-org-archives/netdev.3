Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E24AD4B9;
	Thu, 17 Sep 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684511; cv=none; b=Kvlrs0DayV1ZQ4fh8S68DkYgmTDxyyGlsKD3CKWTC+rX5Vg/LPAodjs911A65ujkjynyCXunfnle7z56Rv5dkQZb0El4Y1NAg8+9srBAFc2QIdpGV41XuFtDKHh+EQnAmPX8AfqpCHmkgrSDmiERud3uySazx64IkJFnMMaWaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684511; c=relaxed/simple;
	bh=hR5hj8DimGux2UkyfJU5xup7cKsjTAaM3m2a3h2Sg9w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ch60HkLaaX+4i9RqJp7ntCdbiduKbTii5n+DlD9zIBS34+aWG496/eKmq8mJnEjyi4tAInUXRkDyPgT5tTyNqKy7R55/JjscJppx4nQA+q3fTJb9BFhiky5lc045CR6hZN5SK8JziHI7YAHRA/dq34TpXt/wUTs7Lav2+ZUlHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGlppGJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGlppGJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E9A1F00893;
	Thu, 17 Sep 2026 22:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684509;
	bh=D+Dh7AyQ97qaZaPUqCJ2Ld1gyA02Gt7EcV2bV1X5oXM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FGlppGJo3gKgG/2hwluZjnMFJYxmMbW0PEK3wRMU/AFik3s8VvskPrseApnBIh3Uo
	 N0wsthl2UGdtUtyWMgz0+B8Oq+ibtnY/xxncr9jwt+ZhGjS/CAQo0L1lrP9pGljZ30
	 jzO887y3OWXWU08NUHLHCG7vZTBcmseVQSs0odAwEEqV7VFbRaA7DccSnSFaxLkFu3
	 ymeQVwuJvXiNXpkVO7BYj3n/8mhKvvdnu9u790f3maI9WxM95jpNk7gpOXjSj8VekD
	 tr+bEP85hQdBKUt0pkLj0I610dVmK0UdcOe08J/7G5ZzYi25TOsOsVQN+dR09ipLS/
	 STbPC8xjnXucA==
Subject: Re: [PATCH v28 net-next 07/10] net/nebula-matrix: dispatch: add
 control-level routing core infrastructure
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:08 +0000
Message-ID: <178968450819.22033.4902172279323184978@kernel.org>
In-Reply-To: <20260914123429.56596-8-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-8-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] New channel response enum (NBL_CHAN_RESP_OK/ERR/UNIMPLEMENTED,
  extended with PERM_DENY later in the series) uses positive wire…
- [Low] The comment in the (empty) nbl_disp_remove() bases dispatch
  teardown safety on facts that do not exist at this commit: it says…

--

net/nebula-matrix: dispatch: add control-level routing core infrastructure

This adds the dispatch layer skeleton: allocation of the dispatch
management structure and ops table, init_module/deinit_module wrappers
around the resource ops, and a ctrl_lvl bitmask that enables the MGT
level on the Control PF only.  It also adds forward declarations of
channel wire structures and a channel response enum for a later RPC
framework.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index 61dd97c779ef6..58a9fa97fbf39 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -7,12 +7,19 @@
>  #define _NBL_DEF_CHANNEL_H_
>  
>  #include <linux/types.h>
> +#include <linux/build_bug.h>
>  
>  struct nbl_channel_mgt;
>  struct nbl_adapter;
>  
>  typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
>  
> +enum {
> +	NBL_CHAN_RESP_OK = 0,
> +	NBL_CHAN_RESP_ERR = 1,
> +	NBL_CHAN_RESP_UNIMPLEMENTED = 2,
> +};
> +

[Severity: Medium]
Can these positive response codes ever be observed by a sender?  The ACK
receive path in nbl_chan_recv_ack_msg() rewrites any positive remote
status:

drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c:
	raw_err = (s32)le32_to_cpu(*(__le32 *)&payload[NBL_CHAN_ACK_RET_POS]);
	if (raw_err > 0 || raw_err < -MAX_ERRNO)
		raw_err = -EREMOTEIO;

	WRITE_ONCE(wait_head->ack_err, raw_err);

nbl_chan_send_msg() returns exactly that clamped value, so a caller can
only ever see 0 or a negative errno, never NBL_CHAN_RESP_ERR (1) or
NBL_CHAN_RESP_UNIMPLEMENTED (2).

The follow-up patch in the series ("net/nebula-matrix: dispatch:
implement channel RPC framework and serialize hardware ops") both puts
these codes on the wire via nbl_disp_chan_*_resp() ->
nbl_chan_fill_ack_info(..., err, ...) and then switches on them after
send_msg(), for example in nbl_disp_chan_get_eth_id_req():

	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
	if (ret < 0)
		return ret;
	switch (ret) {
	case NBL_CHAN_RESP_OK:
		break;
	case NBL_CHAN_RESP_UNIMPLEMENTED:
		return -EOPNOTSUPP;
	case NBL_CHAN_RESP_ERR:
		return -EREMOTEIO;
	case NBL_CHAN_RESP_PERM_DENY:
		return -EPERM;

Are all the non-OK arms dead code, given "if (ret < 0) return ret;"
fires first for the clamped -EREMOTEIO?  A peer answering "unimplemented"
or "permission denied" would then be reported to the requester as
-EREMOTEIO instead of -EOPNOTSUPP / -EPERM.

Would it make sense to either encode these response codes as
non-positive values (or in a dedicated payload field), or to let the
clamp in nbl_chan_recv_ack_msg() pass the defined response codes
through?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> new file mode 100644
> index 0000000000000..b7f404b319fac
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -0,0 +1,124 @@

[ ... ]

> +void nbl_disp_remove(struct nbl_adapter *adapter)
> +{
> +	/*
> +	 * All dispatch objects are allocated via devm.
> +	 * Dispatch message handlers are not explicitly unregistered here.
> +	 * Safety relies on dev layer shutting down mailbox channel queue
> +	 * before nbl_res_remove_leonis(), so responders cannot run after
> +	 * resource layer is torn down. Channel layer nbl_chan_remove_common()
> +	 * finalizes cleanup at device teardown.
> +	 */
> +}

[Severity: Low]
This isn't a bug, but does this comment describe code that exists at this
commit?

There is no dev layer yet (no nbl_core/nbl_dev.o in the Makefile and no
nbl_dev_init()/nbl_dev_remove() call in nbl_main.c), so nothing shuts
down the mailbox channel queue before nbl_res_remove_leonis().

This patch also registers no channel handlers at all (no
chan_ops->register_msg() call in nbl_dispatch.c), so there are no
responders that the "not explicitly unregistered here" sentence could
refer to.

Both premises do hold at the end of the series, where nbl_core_remove()
calls nbl_dev_remove() first and nbl_dev_remove_common_dev() tears down
the mailbox queue before the resource layer, and nbl_disp_setup_msg()
registers the responders.  Would it be clearer to move this comment to
the patch that actually registers the handlers?

Related to the same staging question: nbl_disp_refresh_ctrl_ops()
installs init_module/deinit_module

> +	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
> +		disp_ops->init_module = nbl_disp_init_module;
> +		disp_ops->deinit_module = nbl_disp_deinit_module;
> +	}

but is there any caller of these ops at this commit?  The first callers,
nbl_dev_setup_ctrl_dev() and nbl_dev_remove_ctrl_dev(), arrive with the
later dev-layer patch, so the "dispatch management flow" the commit
message mentions appears inert here.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 1aafed2d46d71..5d5c0bbf418c8 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -59,6 +66,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
>  
>  void nbl_core_remove(struct nbl_adapter *adapter)
>  {
> +	nbl_disp_remove(adapter);
>  	nbl_res_remove_leonis(adapter);
>  	nbl_chan_remove_common(adapter);
>  	nbl_hw_remove_leonis(adapter);

Here the channel layer is removed after the resource layer, which is the
opposite order from the one the nbl_disp_remove() comment relies on.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
