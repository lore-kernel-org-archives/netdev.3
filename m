Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552E26ED3E;
	Mon, 21 Sep 2026 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957887; cv=none; b=Zdj20dnLlfJNz6bS/CYGbjcmQaZoo0ZOktxliF2vWupw2pEaHSZSuEjP6Vs3S9J4hg6xN/5b3IggkI892bj6L7hRk3K0kZg9SCPFXn7CMxWnDvF0OuYPRxABAKfMHySH+HUMBpssKuHniwxmUoZlwbNM1pE2bEfXNH2uzXAX9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957887; c=relaxed/simple;
	bh=51Havl/1lx9zjGMqJFs5HDOQporm497Kobf8wp16rRI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WB8kSUD+qoKoLdHp4UBPQ6VcZlRkN3kKvgnQBKSp4I/UALz5zK1ylp4euaPOjOXwVJQUPCMzGBZ2Pf8nTG0t6RW0Y+KAkz+SkB2sF08cJCPqEuLogOeR/uzK8Vil4lcuhNN/JZSHziM6cZAZ82xZPRo1gazwkDzTiGdtU8ReMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPfoS1RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPfoS1RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCC11F000FF;
	Mon, 21 Sep 2026 02:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789957885;
	bh=WeO44XQC8oAMreeb/1Lw/6wTrRUe9Z4cPgrcCLTW7hA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KPfoS1RI1whnBJkMi34DGEZOA2NEOauuDY+EOGe0yr33eaK6yLvK/6ZMNi8A13sjC
	 qx8aklXa5Cu397/VToyixDYHhq+ZXNsoDeR6ieroipEzG/PVceRnAPAj7EUiWtsHac
	 u60pSBW9NXK1dANW+NtAQpkza9UD0tp33rTUu/TqC9AJC5HDg/RP+jU6rAhH5gZhT0
	 8TtNz+dT9hXJqXCX3WxDi8AtjAW9XLD1MaALJCJMiHdvSDaRuIX6t6exJL48LhD/uS
	 7fZlb0KYEut41dQXB095czosw3IWQOi7rSjkfmnnqx/oVoPsReX8b32wlx18HQXvyc
	 Zy31oW2uqPJIQ==
Subject: Re: [PATCH net-next] octeontx2-af: nix: Log TX scheduler queue
 validation failures
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com
Date: Mon, 21 Sep 2026 02:31:24 +0000
Message-ID: <178995788476.2160803.6094995582609949480@kernel.org>
In-Reply-To: <20260917021327.1124199-1-rkannoth@marvell.com>
References: <20260917021327.1124199-1-rkannoth@marvell.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Unrate-limited dev_err() on a PF/VF mailbox-driven validation
  failure path in is_valid_txschq()…
- [Medium] The diagnostics added by this patch do not achieve the stated
  purpose.

--

octeontx2-af: nix: Log TX scheduler queue validation failures

This adds dev_err() calls to two of the rejection paths in
is_valid_txschq() so that scheduler queue mapping failures show up in the
kernel log.  The braces around the existing return statements are adjusted
accordingly.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index d80d2c00bd843..593c5ff70e9fb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -325,14 +325,22 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
>  		if ((nix_get_tx_link(rvu, map_func) !=
>  		     nix_get_tx_link(rvu, pcifunc)) &&
>  		     (rvu_get_pf(rvu->pdev, map_func) !=
> -				rvu_get_pf(rvu->pdev, pcifunc)))
> +				rvu_get_pf(rvu->pdev, pcifunc))) {
> +			dev_err(rvu->dev,
> +				"Invalid tx link: pcifunc %x map pcifunc %x\n",
> +				pcifunc, map_func);
>  			return false;
> -		else
> +		} else {
>  			return true;
> +		}
>  	}
>  
> -	if (map_func != pcifunc)
> +	if (map_func != pcifunc) {
> +		dev_err(rvu->dev,
> +			"pcifunc %x map pcifunc %x not equal\n", pcifunc,
> +			map_func);
>  		return false;
> +	}
>  
>  	return true;
>  }

[Severity: Medium]
Are these two new prints reachable directly from PF/VF mailbox messages,
and if so should they be rate limited?

The schq value that decides the outcome comes straight out of the mailbox
request in is_txschq_hierarchy_valid():

	schq = TXSCHQ_IDX(reg, TXSCHQ_IDX_SHIFT);
	/* Check if this schq belongs to this PF/VF or not */
	if (!is_valid_txschq(rvu, blkaddr, lvl, pcifunc, schq))
		return false;

and rvu_mbox_handler_nix_txschq_cfg() only rejects the request with
NIX_AF_INVAL_TXSCHQ_CFG:

	if (!is_txschq_hierarchy_valid(rvu, pcifunc, blkaddr,
				       txsch->lvl, reg, regval))
		return NIX_AF_INVAL_TXSCHQ_CFG;

nix_txschq_cfg_read() and the SMQ check in rvu_nix_blk_aq_enq_inst() are two
more requester-controlled paths into the same helper.  Since the request is
just rejected, a PF/VF (including a guest-owned VF whose messages are
forwarded to the AF) can resend a request naming an in-range schq owned by
another function in a loop, and each attempt emits a line on the host
console.  Would dev_err_ratelimited(), dev_dbg(), or a counter be a better
fit here?

As a smaller point, the message also prints the owning pcifunc of another
function's scheduler queue into the shared host log.

[Severity: Medium]
Do these messages give enough information to diagnose the failure the
commit message describes?

is_valid_txschq() has four ways to return false, and two of them are still
silent:

	nix_hw = get_nix_hw(rvu->hw, blkaddr);
	if (!nix_hw)
		return false;

	txsch = &nix_hw->txsch[lvl];
	/* Check out of bounds */
	if (schq >= txsch->schq.max)
		return false;

An out of range scheduler queue looks like the most likely symptom of a
misconfigured TX scheduler allocation, but that path produces no output at
all while the caller still returns NIX_AF_INVAL_TXSCHQ_CFG or
NIX_AF_ERR_AQ_ENQUEUE.  Should those returns be instrumented too, given the
commit message says the intent is that "misconfigured TX scheduler
allocations are easier to diagnose"?

Also, both new messages print only pcifunc and map_func, with no lvl or
schq.  is_txschq_hierarchy_valid() calls the helper for both the queue and
its parent across several levels, for example:

	if (regbase == NIX_AF_MDQX_PARENT(0) &&
	    !is_valid_txschq(rvu, blkaddr, NIX_TXSCH_LVL_TL4, pcifunc, parent))
		return false;

so a line like "pcifunc 4 map pcifunc 0 not equal" does not say which level
or which queue was rejected.  Could lvl and schq be added to both messages?

One more wording question: the first message is labelled "Invalid tx link",
but the branch is only taken when the TX link differs and the parent PF
differs.  Would something naming the ownership mismatch be less misleading
for an operator looking at link configuration?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917021327.1124199-1-rkannoth%40marvell.com
