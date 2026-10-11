Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBA33F394;
	Sun, 11 Oct 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715884; cv=none; b=B/mUdK5J3OTUdAktfa2pXw7Py33tVPYmtGIB6ZCLQm1bcD50YnBjsoyrH4o3AqvN+eBEm89WMWsdHItEWdPEAeFLD5ILHzMklLDuq0U8EwYdwfEoPGCRIok82CUPEIyzpGGRe3yl5sJ4Y8bN46wRhmsz2aLG7rlMR17iMG4JtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715884; c=relaxed/simple;
	bh=v9R1QU3vQ8hFDsk3UaN9JOs9YE8Drv5RIYW3CimTd2U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fHYfqq1pUAHAUG6R/D98OBSO1r0Hc/j6zs9+hA3DuMsC094L8mn4aAadX8R1hFqD5Thqo0fvvc52ZFz7YgjJ5dPZE2e/Q0YPPTApnAquTCXaOqtpz3lEP7b/sr5Z4sogDyTuNZ99x99xq4MPofkxo+aGDcFjmzFYuCRmfy4DumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7CPPink; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7CPPink"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202C81F0089C;
	Sun, 11 Oct 2026 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715882;
	bh=Ekrc6wpuRIcW4WSYEks5o9A/docONKtdMEfHe0WauDU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e7CPPinke/GG80+xpXv9HBtUcmZNU33vl9eJM0R6xCXAZBfFs78SIB44b9x1BxiEQ
	 026yy4Sd3ja/qYcx5JpiWULzP8kZ7LjbFSAztuoo487wRrbgxhtQu1Wpb2c8nc0zdl
	 AZ/aatdKqOCzazj+xn6HkLZd3n357ll3jPtU6xmHguD/m8efNkUMgBQIh7Rz3kW0ld
	 eRLq5Y0Qu7VJaQzV3Bfinp34jT5lxFLYTLhYhJyjKXAGvOgYc3JKcF79oscph9UtZx
	 iiB0dlyMzgdha8AKnYeWDZFLgMgGtUX/vbPGDD9k8viegplyf/Xy0Ta9+kMJ2SWRzV
	 NC1aK3YtDr7SQ==
Subject: Re: [PATCH v31 net-next 2/8] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:21 +0000
Message-ID: <179171588171.434549.5839384783484912228@kernel.org>
In-Reply-To: <20261010095939.2230-3-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-3-illusion.wang@nebula-matrix.com>
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

- [Low] The `get_host_pf_mask` kernel-doc in `nbl_def_hw.h` says
  nbl_res_init_pf_num() "always runs before this op's only consumer,…

--

net/nebula-matrix: add common resource implementation

This commit adds a chip-agnostic resource layer for the Nebula Matrix
driver. On the control PF it builds the PF topology, SR-IOV BDF, Ethernet
port and VSI identity tables once at probe time. It also adds new hw ops
(flush_write, get_real_bus, get_fw_eth_map, get_board_info) and the
VSI/PF/Eth ID conversion helpers.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index 58d1b669b8cbb..4b420db91963d 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

[ ... ]

> @@ -42,9 +55,22 @@ struct nbl_hw_ops {
>  	 * op only returns the raw register value.
>  	 */
>  	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);
> +	void (*get_real_bus)(struct nbl_hw_mgt *hw_mgt, u8 *bus);

[Severity: Low]
This isn't a bug, but the kernel-doc for get_host_pf_mask just above this
hunk now looks stale:

	 * The mask is validated in the resource layer:
	 * nbl_res_init_pf_num() rejects an all-zero mask and any
	 * non-contiguous layout with -EINVAL, and it always runs before
	 * this op's only consumer, nbl_chan_cfg_qinfo_map_table().  This
	 * op only returns the raw register value.

This patch adds nbl_res_init_pf_num() in nbl_resource_leonis.c, and that
function calls the op itself:

	hw_ops->get_host_pf_mask(res_mgt->hw_ops_tbl->priv, &pf_mask);

That means nbl_chan_cfg_qinfo_map_table() is no longer the only consumer.
The same is still true at the end of the series, where the op is called
from both nbl_resource_leonis.c and nbl_channel.c.

The ordering claim does hold by the end of the series. In "net/nebula-matrix:
add common/ctrl dev init/remove operation", nbl_dev_init() calls
nbl_dev_setup_chan_qinfo() only under common->has_ctrl, and it does so
after nbl_res_init_leonis().

Could the "only consumer" wording be changed to list both callers?

> 
>  	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
>  				  u8 bus, u8 devid, u8 function);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
