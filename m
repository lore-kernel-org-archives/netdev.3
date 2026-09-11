Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E283F12C6;
	Fri, 11 Sep 2026 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098110; cv=none; b=re1F4Ugqz4sJgy9dmiPwqZvr5Y61GrT3w6mLpPh3EZBrfl6tTJzDQL7GEsg9WwhYuPjoYvTlZ7y2zbzFSvLEyFf3gr3ayVTwtOjgcseblG1jVUt30v/2melieLy6uz/m64z6ldyisvxPH1CKfkOwo/T8omiTyfXNe2vYZZmd5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098110; c=relaxed/simple;
	bh=Oe8fHkW6OPrhbQS5gJzKiCnM9OSHPgaEqxCjS2JjU7Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqDgLcN/WO+JUxEUtGMN/IyJcjoossjC889rDOUgVeuFy+8eGTBdIjfHluxEV6mN4iTNewM+gS9Sdq0RkMd4PU0MoJJGpetlQ8j3y2CGjL65hRBrAEagNkfDabaxrIrp3N6tyTmjliNFnhvmThwIq7zgCuiMmiUTJ0fKZqvwxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNnULQeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNnULQeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE891F00893;
	Fri, 11 Sep 2026 03:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098108;
	bh=sjlqjA6Do7Zq1jcMaJuNbVP0rDAzdQRzujjfA0sHIco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cNnULQeBNi0jaN9kj/qheVtUDcx0U8szVo8EWtGjH2dwImfGwJ2nZJsxf9gWjQ57X
	 zlwPiPoNHZxUJQWtGayH5s4Qy1oZGtjbTV6cvMOv1Wda4r++CJbY2xqK4P54vmbRT6
	 +7FjXs9PjgYV7FkowUQSwO6n7BIeaF6FBXXGE6YG3HZb9dmiyqDjnEWTgv3ibG/pdw
	 s04WEP/Fqqen+G+FFFuMZPdOJJI4QKDRPD883mBm3HDC7v394RjES4GPeFeYj74Nv+
	 1snpKe0vNxWmOBvF/xSfMYMf6Q8elfez+Tv8S8Ou6EC5QCkbOQJ8h85NolG7fmewCk
	 uxYBPSKj+VLlw==
Subject: Re: [PATCH v27 net-next 04/10] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:47 +0000
Message-ID: <178909810744.219967.987338204344069004@kernel.org>
In-Reply-To: <20260907123848.30256-5-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-5-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] DISCARDED (baseline decision false): claim that the commit
  message's statement 'The dispatch layer serializes all resource ops…
- [Low] Kernel-doc/declaration mismatch for the new hw op: in
  drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h the…

--

net/nebula-matrix: add common resource implementation

This adds the chip-independent resource layer for the nbl driver, which
owns the PF/eth/vsi identity tables and the lookup helpers between
vsi_id, func_id, eth_id and pf_id.  It also adds two new hardware ops,
get_fw_eth_map() and get_board_info(), plus get_real_bus(), used during
control-PF initialization.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index be63e53d41c61..e05248c66afbb 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

[ ... ]

> @@ -35,11 +36,26 @@ struct nbl_hw_ops {
>  	 *   All-zero mask (0x00) means all 8 PFs enabled, which is
>  	 *   unsupported by the driver and rejected with -EINVAL.
>  	 *
> +	 * Firmware contract: number of unmasked PFs MUST equal
> +	 * get_board_info()->eth_num.
>  	 */
>  	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);
> +	void (*get_real_bus)(struct nbl_hw_mgt *hw_mgt, u8 *bus);
>  
>  	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
>  				  u8 bus, u8 devid, u8 function);
> +	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
> +	/**
> +	 * get_board_info - Fetch board info from firmware
> +	 * @hw_mgt: hardware management context
> +	 * @board_info: output pointer for board info structure
> +	 *
> +	 * Firmware contract: board_info.eth_num MUST equal the number of
> +	 * unmasked PFs from get_host_pf_mask(). See get_host_pf_mask for
> +	 * details.
> +	 */
> +	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
> +			       struct nbl_board_port_info *board);

[Severity: Low]
This isn't a bug, but the kernel-doc block for get_board_info in
nbl_def_hw.h documents @board_info while the callback is declared with the
parameter named board:

	 * @board_info: output pointer for board info structure
	...
	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
			       struct nbl_board_port_info *board);

Would make W=1 warn here with "Excess function parameter 'board_info'
description" and "Function parameter or struct member 'board' not
described"?

The implementation in nbl_hw_leonis.c uses the documented name:

	static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
					  struct nbl_board_port_info *board_info)

so renaming the declared parameter to board_info would keep the three
consistent.  The mismatch is still present at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
