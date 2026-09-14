Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20ED38DC6B;
	Mon, 14 Sep 2026 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412584; cv=none; b=VkXI/PgGT4UlfdsoubSS8y/HUF+CHNxPubFNzfLtbWxc+aldjC+eFzaP0U6vbCVbOLRUIC5eL+GB0JdUj0JuGIQ/DnVfyu7xdAMp5k9bceSXy4aNqwrSpGgu1sZXJRpbJF5hLzEf5RoCBy2UILp3UCejN5o18hs6xkpxp11O/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412584; c=relaxed/simple;
	bh=cKvZAxvHC6FIhO4+9Aod3FGIQm2LD23nRIJ2Drau/Ls=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CcfbD8MST4nnOOX6Evxqcepo1ItOaHdQVbH7Z74v18d1j+FnVZWbdpo/DseHoLunMr1rt5EqpmhwHOU5KLTuocXDyqZOu+id6UvLnHtA/BIElNVjEstoOXjVXtxt1PqpbaHzbg0gwOz3No/WGBAEskMahJZFrEhXtreNbhR52Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKp1hdhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKp1hdhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366ED1F000FF;
	Mon, 14 Sep 2026 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789412579;
	bh=YfHmhyOIHhUpmUhjLuRNQqTVcQKi4a198mseVnLlZ74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GKp1hdhrC3X4+OjgfwqOcw7B6qZEJjCYzrCX/DGpdGfd2YVbUzd1vfiOcr66ozJYK
	 4HZtudA0JKeR4cKG1R+JnE1qpbXsQSnuXl3Mc5YG9X2gfaY36Kj2sShkg/q9s960R2
	 BZkmZsq9ox3FDtEnz6n7PJJQkBaNYbWnwq+CMpW7pFnpGKtcasDJbc1DWKII47oUjX
	 N+L9Nb3eCdWV56WFZoyd09bbGCD9RKikJHzY7ZTfjxUBBChYe9XKIsdX3zb/Gl+FGZ
	 tfxUeU9ZXVC17owZGda/iYhhXuLU2ZuJJs7bmZvlTOKMzvtRXTXAmTmiGDYpogH3ez
	 H7YYHkRlkjjsA==
Subject: Re: [PATCH net] net: bcmgenet: restore the hardware filters on open
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: netdev@vger.kernel.org, opendmb@gmail.com, florian.fainelli@broadcom.com,
 justin.chen@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 19:02:58 +0000
Message-ID: <178941257876.22033.16482190060523760551@kernel.org>
In-Reply-To: <20260913190052.939955-1-nb@tipi-net.de>
References: <20260913190052.939955-1-nb@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The commit message of "net: bcmgenet: restore the hardware
  filters on open" describes only the loss of user-configured rxnfc…

--

net: bcmgenet: restore the hardware filters on open

The patch splits bcmgenet_hfb_init() into a list-initialisation part that
now runs once from bcmgenet_probe(), and a new bcmgenet_hfb_restore() that
clears the hardware filter block and re-programs the configured rxnfc
rules.  bcmgenet_open() and bcmgenet_resume() both call the restore helper.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index a2305e6428d1f..b916080f4ff17 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -4075,6 +4084,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  
>  	/* Mii wait queue */
>  	init_waitqueue_head(&priv->wq);
> +	bcmgenet_hfb_init(priv);
>  	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);

[Severity: Medium]
Does this hunk also fix a NULL pointer dereference that the changelog does
not mention?

Before this change, priv->rxnfc_list was only initialised from
bcmgenet_open(), and alloc_etherdev_mqs() hands back zeroed private data,
so between register_netdev() and the first ifup the list head is
{NULL, NULL}.

The ethtool rxnfc getters have no netif_running() gate; bcmgenet_begin()
only enables the clock:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_begin() {
	struct bcmgenet_priv *priv = netdev_priv(dev);

	/* Turn on the clock */
	return clk_prepare_enable(priv->clk);
}

so ETHTOOL_GRXCLSRLCNT reaches bcmgenet_get_rxnfc() ->
bcmgenet_get_num_flows():

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_get_num_flows() {
	struct list_head *pos;
	int res = 0;

	list_for_each(pos, &priv->rxnfc_list)
		res++;
	...
}

with pos = head->next == NULL, the list_is_head() test does not match the
head, and pos->next is then dereferenced.

ETHTOOL_GRXCLSRLCNT, ETHTOOL_GRXCLSRULE and ETHTOOL_GRXCLSRLALL are
exempted from the ns_capable(CAP_NET_ADMIN) check in dev_ethtool():

net/ethtool/ioctl.c:dev_ethtool() {
	case ETHTOOL_GRXCLSRLCNT:
	case ETHTOOL_GRXCLSRULE:
	case ETHTOOL_GRXCLSRLALL:
		break;
	default:
		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
			return -EPERM;
	...
}

so an unprivileged local user running "ethtool -n eth0" on a bcmgenet
interface that was never brought up could hit this.

The changelog only describes the lost rules:

	Every rule the user configured is silently lost

	Initialise the lists once at probe and restore the rules on open, as
	bcmgenet_resume() already does.

Could the changelog also mention this crash, since it affects how the
patch is triaged for stable?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913190052.939955-1-nb%40tipi-net.de
