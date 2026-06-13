Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512530DED5;
	Sat, 13 Jun 2026 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388385; cv=none; b=jXBtWT3U5GUN+LxXAfeL4AGVEfigCWbFYr4ntbQUI5MmWh8mZNu0h35KqUIT/jX3IDr+Lz+Xi9TVLzePVJulY997Dk3WE+ghBvA6BdtW0c7F/9/YfYKmG7skK0S5U7wEvVSUBxcEMdExn+001Q/yqLJomjfroDOWmos0WEv5KFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388385; c=relaxed/simple;
	bh=PCNDdsSVQHbMLDu3lz7T7P8HQFgotV8ZQEH5MmQ7yJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgzSqThf2sFeDqFhhK0Th0OPpCPOKVBSGAOSCo0aMsDWd7H3K2mJBrdrj17p9BOvXVqPmM95Yy8QBPrPF9xlAQarvEYLJD9nutYtuRkROto5ESBUeLoHA/dDAlH3iN6rCyH5ZvI8e93J7X3GssoHEVbYL+gBa4t7s1i3gBXIo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCEwJT03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCEwJT03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D7D1F000E9;
	Sat, 13 Jun 2026 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388384;
	bh=vJCP4ee1nVCNSlrAHSKDwDvkWwGFkqbesfqZaxh9rjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCEwJT03Ek/OJbxvH836CqPod0VedGy9/Cj97nbJRJwZ3Deo99huB7tQm774Up3c4
	 6+MHTBhGXinkdRNIfUWsBuco4E6j1Icryb6BFUiFvefr9MSSvswZNEd9g4K5bLSUj9
	 tGP05TQh74xKh1rduK9bNrpupfbrC9KG5O8PFkfadircKOvcUxlXfVCZlxcoRwNBN3
	 n4xs91fTDTnmVfafQQTQF7mBvd/wczZPxRuekYWeGpdNQSXmaB9zSCTzZ5ZIaTzdbn
	 +O4fJCc3CcoZuY6Rvaru+6kxIsMnavZNs5GeWTdnqCvBEY28ZHF5++9jzFBM1mwAe1
	 O61fO894TWdvg==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] r8169: create a virtual interrupt for linkchg
Date: Sat, 13 Jun 2026 15:06:22 -0700
Message-ID: <20260613220622.220157-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611094345.880-3-javen_xu@realsil.com.cn>
References: <20260611094345.880-3-javen_xu@realsil.com.cn>
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
r8169: create a virtual interrupt for linkchg

This commit creates a virtual interrupt domain in r8169_mdio_register() so
the MAC link change interrupt can be dispatched into phylib via
generic_handle_domain_irq() instead of calling phy_mac_interrupt() on
tp->phydev directly.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index c60710f9bd21..560f987437b6 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5458,6 +5488,21 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  		new_bus->write_c45 = r8169_mdio_write_reg_c45;
>  	}
>
> +	tp->phy_irq_domain = irq_domain_add_linear(NULL, 1,
> +						   &rtl_phy_irq_domain_ops, tp);
> +	if (!tp->phy_irq_domain)
> +		return -ENOMEM;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, rtl_phy_irq_cleanup, tp);
> +	if (ret)
> +		return ret;
> +
> +	virq = irq_create_mapping(tp->phy_irq_domain, 0);
> +	if (!virq)
> +		ret = -EINVAL;
> +
> +	new_bus->irq[0] = virq;
> +
>  	ret = devm_mdiobus_register(&pdev->dev, new_bus);
>  	if (ret)
>  		return ret;

[High]
Should the failure of irq_create_mapping() actually abort registration
here?

	virq = irq_create_mapping(tp->phy_irq_domain, 0);
	if (!virq)
		ret = -EINVAL;

	new_bus->irq[0] = virq;

	ret = devm_mdiobus_register(&pdev->dev, new_bus);
	if (ret)
		return ret;

When irq_create_mapping() returns 0, ret is set to -EINVAL but the
function continues on. The next assignment to ret from
devm_mdiobus_register() overwrites that -EINVAL, so the mapping failure
is silently dropped.

A couple of follow-on consequences seem possible:

The mdiobus is registered with new_bus->irq[0] == 0. phy_interrupt_is_valid()
only special-cases PHY_POLL (-1) and PHY_MAC_INTERRUPT (-2), so 0 looks
like a normal IRQ number and phylib will try to request_threaded_irq(0,
...) when the PHY starts.

In rtl8169_interrupt(), generic_handle_domain_irq(tp->phy_irq_domain, 0)
will be called against a domain with no hwirq 0 mapping, so LinkChg
events would not reach the PHY state machine.

Would something like this be more appropriate?

	virq = irq_create_mapping(tp->phy_irq_domain, 0);
	if (!virq)
		return -EINVAL;

	new_bus->irq[0] = virq;
