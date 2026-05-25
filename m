Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B939733E;
	Mon, 25 May 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741677; cv=none; b=TF/lpV6S8U7lKczDpQxYgl62p9/ITOHGMMzKooCX07B4dXO91BM6VUkK+bElGwf75nFRMDxIRN4sB75NeYe6ZtpL6EfzsotM7PLUma8pzkJeLq7HsiXlP9LQC9X1pqMMMHhDRDpxl3kDlSvAA8mAkz/Ibw3HrTJ94ejHDdmwna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741677; c=relaxed/simple;
	bh=TUH+0GxD0OHHbvdq0McgIUXc9iNiF92C5mJ1b9fFPzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah0gfsTU0zaqgf7TrFobonxMcXfxZaHT+/QIkJ8rTQNafiliPZtyr9ctf7JcrsIxp6hed66FUrqYhMFq2wBee0rRVYFmMgveCmYq18rAvbeyntKqJvR5kHSBAp2r9mOluOqwFGY2HAYrpbfaQXPGZRYpwZoKrToE2rjdLOzkK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuLvWqk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuLvWqk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD31F00A3C;
	Mon, 25 May 2026 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741675;
	bh=NOJPgcxnrBYyK1zcL1bbmgF54U1ASRtU4QXZ0gZ887k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LuLvWqk81tDh+oHsJD+2NxQWcG/Yb5rmP/FoRJQbPFy5rgf2dnvCLpw1chmzDWF/1
	 EyirMPfDtKYcvfu1CRur9a78dy1jRcmm2YJ9oGO3V3smPrrnujfDZj5jY7TPGkT7LS
	 oO0pPxXWJjSJs5IYjoTOtrE0qYoeosYZCB/ft63GBaghvR+WsMo//0gztw6+z691kE
	 ArIaG+802Sx8j8fLrwwE0Uwg6Nd/Y5k8IGJU4ykmggAxNuNEU2JVZ8gjC0bO8eKiBn
	 fmZN5GZD2pp793jTBj19o+jd71PToK70ylhfS+PCNkmk3X2QAVcmqdpun+pZeinXhQ
	 YgGmlRvtjT7qQ==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.dege@renesas.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	yoshihiro.shimoda.uh@renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/14] net: renesas: rswitch: add locking for agent clock control
Date: Mon, 25 May 2026 13:41:14 -0700
Message-ID: <20260525204114.2471390-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522-rswitch_add_vlans-v5-8-53589d944a9f@renesas.com>
References: <20260522-rswitch_add_vlans-v5-8-53589d944a9f@renesas.com>
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
net: renesas: rswitch: add locking for agent clock control

This commit introduces an agent_lock to serialize access to the shared RCEC
and RCDC agent clock registers. This aims to prevent potential race
conditions between ETHA and GWCA ports when enabling or disabling clocks.

> diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
> --- a/drivers/net/ethernet/renesas/rswitch.h
> +++ b/drivers/net/ethernet/renesas/rswitch.h
[ ... ]
> @@ -1207,6 +1208,8 @@ struct rswitch_private {
>  	struct list_head port_list;
>  
>  	spinlock_t lock;	/* lock interrupt registers' control */
> +	spinlock_t agent_lock;	/* rswitch agent clock control */
> +

[Severity: High]
Is this lock initialized anywhere before it is used? 

It looks like agent_lock is added to the structure, but spin_lock_init() is
missing from the driver probe path. Depending on kzalloc for
zero-initialization is not valid for spinlocks and can cause issues on
architectures or kernel configurations that require explicit initialization.

> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -173,8 +173,12 @@ int rswitch_gwca_change_mode(struct rswitch_private *priv,
>  {
>  	int ret;
>  
> -	if (!rswitch_agent_clock_is_enabled(priv->addr, priv->gwca.index))
> +	if (!rswitch_agent_clock_is_enabled(priv->addr, priv->gwca.index)) {
> +		spin_lock(&priv->agent_lock);
>  		rswitch_agent_clock_ctrl(priv->addr, priv->gwca.index, 1);
> +		spin_lock(&priv->agent_lock);
> +	}

[Severity: High]
Does this code cause an immediate deadlock? 

Because spin_lock() is called twice consecutively without a spin_unlock(), it
appears the CPU will spin indefinitely waiting for the lock it already holds.
