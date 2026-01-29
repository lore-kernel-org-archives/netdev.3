Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1F2DB78F;
	Thu, 29 Jan 2026 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663593; cv=none; b=ipLsl+82UEvGJGbkBkDdS01ETTFRRzmJr9kxpG+J3I96Up3+inYHEPL1CSdO1cWnnDZodq8doztHTWz1I2F2I0QTCcr+OuG+42dskkGBeFiKG3VLGzqROSjmKEcneZBzd1s5Jz20INX18RIjDSeL3cEmdqUSMoRSWHWFkfmj9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663593; c=relaxed/simple;
	bh=6StV8OaED8DOktFkrjo+Yo2WkSMhVo+GDhmefkuZJx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkpmehM9a1rWIHaBXSpyueUb+2S+pkVNP70XzmPUwsuoUd3fN0fWpDCoIK+JhoDIb2yCVf9xbzq9f5+fGHuyDidVak0VHbNm4rbLvlPGNNbyTYouZX9rTFM8qKB92rVIuwHWfShzbNcpQtwyg0z9TywS+QMgFAJWT7bDwnsWmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAcJIRKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAcJIRKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9CCC116D0;
	Thu, 29 Jan 2026 05:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663592;
	bh=6StV8OaED8DOktFkrjo+Yo2WkSMhVo+GDhmefkuZJx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAcJIRKRFqCs2Dk5ONKX3Szon9Mq1azY8G7jsNZGVL2pELYI3/Dqn8WAkxiDXjQaX
	 twMZm9xyCfyBN0emSV7+94YhtpMaDFL1jWCvz6ZNi9QAf/o9ZQberEXXvHvvDZVsyt
	 3b/oMwAbkYnh0S21FUn0azf099zT/2L5E79torIyaRA0AUUWgHY//s5GRnghciZ2XU
	 gF0hGVRFRqN7p7a5ahMK+I4aFgSmn0fq+oxQgcyQuy1WyZOBMG18YyfGAT5gLWmCxF
	 RlTHLRbeU76vwgHSRLonxO/UrrZ2xT+tBb9avufMD5gbtqrJrgrTnUSOLTcQbnHL8/
	 Z+stdIgc0Qbxg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sumang@marvell.com,
	linux-kernel@vger.kernel.org,
	sbhatta@marvell.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	sgoutham@marvell.com
Subject: Re: [net-next,v6,11/13] octeontx2-pf: cn20k: Add TC rules support
Date: Wed, 28 Jan 2026 21:13:11 -0800
Message-ID: <20260129051311.376689-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128071235.3577206-12-rkannoth@marvell.com>
References: <20260128071235.3577206-12-rkannoth@marvell.com>
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
octeontx2-pf: cn20k: Add TC rules support

This patch adds dynamic MCAM entry allocation for TC rules on CN20K
silicon. The AF driver allocates entries on the fly when the user
installs a rule.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 26a08d2cfbb1..866d9451f5d6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -1292,7 +1277,23 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	if (old_node)
>  		otx2_tc_del_flow(nic, tc_flow_cmd);
>
> +	if (is_cn20k(nic->pdev)) {
> +		rc = cn20k_tc_alloc_entry(nic, tc_flow_cmd, new_node, &dummy);
> +		if (rc) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "MCAM rule allocation failed");
> +			kfree_rcu(new_node, rcu);
> +			return rc;
> +		}
> +	}
> +
> +	entry = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
> +	if (entry < 0) {
> +		NL_SET_ERR_MSG_MOD(extack, "Adding rule failed");
> +		rc = entry;
> +		goto free_leaf;
> +	}
> +
>  	mutex_lock(&nic->mbox.lock);
>  	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
>  	if (!req) {
>  		mutex_unlock(&nic->mbox.lock);
>  		rc = -ENOMEM;
>  		goto free_leaf;
                ^^^^^^^^^^^^^^

For CN20K, cn20k_tc_alloc_entry() allocates an MCAM entry from the AF
driver and stores it in new_node->entry. If otx2_mbox_alloc_msg_npc_install_flow()
or otx2_sync_mbox_msg() later fails, the code jumps to free_leaf.

Looking at the free_leaf cleanup path below, it calls
otx2_tc_del_from_flow_list() and kfree_rcu() but does not call
cn20k_tc_free_mcam_entry() to release the AF-allocated entry.

Can this leak the MCAM entry on CN20K when these error paths are taken?

The cn20k_tc_update_mcam_table_add_req() function does call
cn20k_tc_free_mcam_entry() when it fails internally (due to X2/X4 mix),
which suggests MCAM entry cleanup is expected on error.

[ ... ]

> @@ -1328,0 +1328,24 @@ free_leaf:
> +free_leaf:
> +	otx2_tc_del_from_flow_list(flow_cfg, new_node);
> +	if (new_node->is_act_police) {

[ ... ]

> +	kfree_rcu(new_node, rcu);
                 ^^^^^^^^

The node is freed here without first calling cn20k_tc_free_mcam_entry()
to return the MCAM entry to the AF driver.

This was previously noted during review:
https://lore.kernel.org/netdev/20260118004028.1044419-1-kuba@kernel.org/
