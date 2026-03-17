Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C52C21C0;
	Tue, 17 Mar 2026 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718334; cv=none; b=Xtm9hIgJeyHBfA6FWXSozz2UTERyCBmUsg4pU2KhhwG9Pvx09z2xpKS8NFX4n/qAcVfPXoYbKJ1Zz0CrFzIrlZWodZjP2S0sXWBCYBfQqnLvd/uKbCPVxrThOSk00FO5eovG7sW++p7F13o9TlBDE7LWO5T8aHsVFyzhovQUlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718334; c=relaxed/simple;
	bh=jbHnc1XHzpFR67Gx+TBForXqU+GCHzWB+VbssfKa4/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHqwmKcOcXG9YBrAd+j74LNepLpCvqu3rWHvcWVnSdlXA7H4MpmIeo0kMMGLgeN4KWSbnK72QLjBPCfzFfsCK7s5QLyJSJi3vn7nndL66HxkX/tT+NFxoTQXZU7p3u/QzAaEV1d1HGaGQfmXHu/Lwe7Mw4GHobWCClDuOX3VUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJmOb7wW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJmOb7wW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6404BC19421;
	Tue, 17 Mar 2026 03:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773718334;
	bh=jbHnc1XHzpFR67Gx+TBForXqU+GCHzWB+VbssfKa4/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJmOb7wWu3D5dBt6l7CnO0N7G7zlHo5M5CDY1liqgOwv86WSL4pOkcuOmIGPL5Wxf
	 G7p8P9O1tVTT30FBJbfC3ib6Jn3AJ9D9goA/udoBRGxGiXhS92G5rVQQRxT88vy+t/
	 DIRagWPHhrGJwkLed2QrXL5ULEYMVoHbeZTB/vert5nHjczfFFADW0PFYZ7uuqauv3
	 2X9MlwrZ2lCsNDfCiLKp9C9YGT9ZTqBMWXlNvR3IVWLKTsgEfKXYfca5AWrdikTwT2
	 KXJZNWBZZMEr54Us/1Xh11F4Lr5jlxMIhHMb912+0IGFh1wo05XhyXn+mQ1SpaKW8G
	 YT2zRXJhjMr5g==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	saeedm@nvidia.com,
	sgoutham@marvell.com,
	edumazet@google.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	horms@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	shshitrit@nvidia.com
Subject: Re: [v4,net-next,3/5] octeontx2-af: npc: cn20k: add subbank search order control
Date: Mon, 16 Mar 2026 20:32:05 -0700
Message-ID: <20260317033205.646930-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312022754.2029595-4-rkannoth@marvell.com>
References: <20260312022754.2029595-4-rkannoth@marvell.com>
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
octeontx2-af: npc: cn20k: add subbank search order control

CN20K NPC MCAM is split into 32 subbanks that are searched in a
predefined order during allocation. Lower-numbered subbanks have
higher priority than higher-numbered ones. Add a runtime devlink
parameter "srch_order" (DEVLINK_PARAM_TYPE_U32_ARRAY) to control the
order in which subbanks are searched during MCAM allocation.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index e854b85ced9e..348a72c4ee43 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -3809,6 +3809,93 @@ static void npc_unlock_all_subbank(void)
>  		mutex_unlock(&npc_priv.sb[i].lock);
>  }
>
> +int npc_cn20k_search_order_set(struct rvu *rvu,
> +			       u32 arr[MAX_NUM_SUB_BANKS], int cnt)
> +{

[ ... ]

> +fail_used:
> +	npc_unlock_all_subbank();
> +	mutex_unlock(&mcam->lock);
> +
> +	return rc;
> +}
> +
> +const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
> +{
> +	*restricted_order = restrict_valid;
> +	*sz = npc_priv.num_subbanks;
> +	return subbank_srch_order;
> +}
           ^^^^^^^^^^^^^^^^^^^

Is there a type mismatch here? The function signature declares the return
type as 'const u32 *' but returns 'subbank_srch_order', which appears to be
declared as 'static int *' elsewhere in the code. While the values stored
(0-31 for subbank indices) fit within both int and u32, and sizeof(int) ==
sizeof(u32) on all kernel-supported architectures, this conversion between
signed and unsigned pointer types is technically incompatible.

The callers rvu_af_dl_npc_srch_order_get() and
rvu_af_dl_npc_srch_order_validate() treat the returned pointer as a u32
array:

drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c:rvu_af_dl_npc_srch_order_get()
{
    const u32 *order;
    ...
    order = npc_cn20k_search_order_get(&restricted_order, &sz);
    ...
    for (int i = 0; i < sz; i++)
        ctx->val.u32arr.val[i] = order[i];
}

Should subbank_srch_order be declared as 'static u32 *' instead of 'static
int *', or should the function return type be changed to 'const int *' to
match the actual type?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> index 004a556c7b90..b168ecfbc5c8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> @@ -343,5 +343,7 @@ int npc_cn20k_defrag(struct rvu *rvu);

[ ... ]
-- 
pw-bot: cr
