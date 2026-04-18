Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4ADF6C;
	Sat, 18 Apr 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529091; cv=none; b=a/kSrr/4Gmni9e6akadKx5wWMeIMgGdmL2E9MN/PJvj4SxqHCW8QyJ8fmQ+eXuSEij2w0j4sebQ1SR25bI5EADsmPyXjnePeA8tZdcvPlDIzuZgMQWrHzrbTbv1OheZarmHkFwlkf4S8I7NukgJMwno2JLM8PtBisv3piJATj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529091; c=relaxed/simple;
	bh=+zMQS05jS9/GoAeAkWjRNHE3F5pSo5nF20ddfGp846o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOeuFBFijyuHygis6FwoXseTSZKtu1NVcAwaoLRKlXolJb2Son9hEkp+RlWmYs6b6SPcKtvczWEbaKpsE++qfoQF8sxneXK7mmRiNzLbPteGb9dgOw/HrxtkLpJ2B6YjD7VaAZA+pEs+/4hrCOnrP3Zg/Ogz5Lz4Ff7WqgCmR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo2gi45H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo2gi45H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D371C19424;
	Sat, 18 Apr 2026 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776529090;
	bh=+zMQS05jS9/GoAeAkWjRNHE3F5pSo5nF20ddfGp846o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qo2gi45HLu5Ql+osxjaf9Z8bg3nBlIvm+z4z0W6vNPgbB1KSJnwpVEMt38CXxEGSY
	 4gu7wAdNbI5ZCGF8tFrQ7Lz91vRmCt7MHKK4n1lsS0B0AebE37QiQwH+B8lCP2WmI1
	 7aoX8ln5v0MLJWhRLjUYI6uDKVik6NhllzDqb/bFyb8H0B3FszB4HPN1qo+D5Xq4AL
	 M61QmG3JitEuhkq+ns1cdI53AKQkjJ4xp4MGl7Nsoyw3pNtO9UFTok0yciOsrcISbW
	 3+n0+JAFuoqEjVrqqE0X92ecd/ie5MQOj5uCuMR+7S17OjWgiqMdeIxRsZ8RylfQ92
	 6cMAm2UFr17tA==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	dan.carpenter@linaro.org,
	error27@gmail.com
Subject: Re: [PATCH net 1/3] octeontx2-af: npc: cn20k: Handle npc_mcam_idx_2_key_type() failures
Date: Sat, 18 Apr 2026 17:17:20 +0100
Message-ID: <20260418161719.365039-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416035352.333808-2-rkannoth@marvell.com>
References: <20260416035352.333808-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
octeontx2-af: npc: cn20k: Handle npc_mcam_idx_2_key_type() failures

This commit adds error checking to npc_mcam_idx_2_key_type() calls.
It returns early from several void functions to prevent programming
or interpreting MCAM state with an invalid key type.

Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7291fdb89b03f..2fcd0ee2b1e10 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -1052,10 +1054,12 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
>  	int kw = 0;
>  	u8 kw_type;
>  
> +	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
> +		return;
> +
>  	/* Disable before mcam entry update */
>  	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
>  

Does returning early from a void function here cause state desynchronization?

For example, in mailbox handlers like
rvu_mbox_handler_npc_cn20k_mcam_write_entry(), the caller assumes success
and returns 0, but the hardware programming would be silently aborted.

[ ... ]

> @@ -1132,8 +1136,13 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
>  
>  	dbank = npc_get_bank(mcam, dest);
>  	sbank = npc_get_bank(mcam, src);
> -	npc_mcam_idx_2_key_type(rvu, src, &src_kwtype);
> -	npc_mcam_idx_2_key_type(rvu, dest, &dest_kwtype);
> +
> +	if (npc_mcam_idx_2_key_type(rvu, src, &src_kwtype))
> +		return;
> +

If this copy is skipped, could callers like npc_cn20k_defrag() unconditionally
enable the target entry with stale hardware state?

[ ... ]

> @@ -1188,7 +1197,8 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
>  	int kw = 0, bank;
>  	u8 kw_type;
>  
> -	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
> +	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
> +		return;

Could this leave caller variables uninitialized?

If a function like npc_update_dmac_value() passes an uninitialized u8 intf
parameter on the stack, and this function returns early, the caller might
branch on garbage data when later calling is_npc_intf_tx(intf).

Would it make sense to refactor these functions to return an int so that
failures can be propagated and gracefully handled by the callers?
