Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6538330C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521580; cv=none; b=bztLsP/JoRyjZ6rirddg7C+aHsAdOx0GHXJsKAeIOW5gvzrut6crNpRCSdoXSBwTFS22n1OkZZ7EMVIufndMoqet8RgHs4QHAMoY0IvjqMzyDLj7E0bRNfiPrr+pFsAf9CG78N741XOFovhmPo570ZafpNeow85vbB/jw+aD/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521580; c=relaxed/simple;
	bh=CQRX8Ac2y8Hf3F784OgoZ89ytoXXMwg6mqUgEkMmZy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7I39Z/oSGPwalohmJLRf3Fe1pqwOFpRVX1dG2jSi0nJU1zNPL6pMdvBRcorIzkObUd8cy/2L6KB1kEMFnzmTHAudM7PEWjSfcX5bWC9zgI6FvTiO4QRMNcZB4Z1fWlGMGX8UPbrG4OgZ67/yG8gFDs+vp3gPN1yjn57eEKZmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo7mKqXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo7mKqXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61AB1F000FF;
	Wed, 16 Sep 2026 01:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521579;
	bh=dALJhOu9TKNIjd3cBTS4Puy1H5P2lb/xXn9oX3MrooU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jo7mKqXdkESvsL9MnGwvoZXLwspLoy+fvWhLbQASDC1wE7r9MBHc0mS+o+Aoc29+1
	 OoQe9bWdX+H5avNnE51AhkeQ93R8XgPEGcyuy1arC63QRSbTrJKaSPYM8fjwuq/kEL
	 qz0VNIVqmeJp9Ha/bLuKF9/UoKFdEw8pTbgKdnLZiW7pta4q/nH+AOKpYymVtwTOUH
	 fU3e58ZMR36HCuievuQTuiHIriWzp4KhmXoiQ+OP3cOfsKvCn1X1Oj8UDPqrgTKtu+
	 PXloM4u0OCYGHc0xC4MewjAgaYz+aopJLh+GyRKOq5aUWqvzgwxHqhVjxRWHzOnZSH
	 fNLEOTlr4LksA==
From: Jakub Kicinski <kuba@kernel.org>
To: hkallweit1@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Subject: Re: [PATCH RESUBMIT net-next] net: phy: factor out legacy PHY fixup support and make it always built-in
Date: Tue, 15 Sep 2026 18:19:37 -0700
Message-ID: <20260916011937.1640802-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9bf96f6b-2d08-402a-af5b-cc6b33fc6d26@gmail.com>
References: <9bf96f6b-2d08-402a-af5b-cc6b33fc6d26@gmail.com>
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
net: phy: factor out legacy PHY fixup support and make it always built-in

This moves the legacy PHY fixup code out of the modular part of phylib
into a new always-built-in file, drivers/net/phy/phy_fixup.c, marks the
registration helpers __init and changes them to return void.  struct
phy_fixup and phy_fixup_list become private to the new file and the
fixup mutex is dropped.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 41d1b20cde2c0..5b13a74e2fa92 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -427,85 +416,6 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
>  			 mdio_bus_phy_resume);
>  
> -/**
> - * phy_register_fixup - creates a new phy_fixup and adds it to the list
> - * @bus_id: A string which matches phydev->mdio.dev.bus_id (or NULL)
> - * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
> - * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
> - *	comparison (or 0 to disable id-based matching)
> - * @run: The actual code to be run when a matching PHY is found
> - */

[ ... ]

> diff --git a/drivers/net/phy/phy_fixup.c b/drivers/net/phy/phy_fixup.c
> new file mode 100644
> index 0000000000000..f49fc4cefe817
> --- /dev/null
> +++ b/drivers/net/phy/phy_fixup.c
> @@ -0,0 +1,99 @@

[ ... ]

> +/**
> + * phy_register_fixup - creates a new phy_fixup and adds it to the list
> + * @bus_id: A string which matches phydev->mdio.dev.bus_id (or PHY_ANY_ID)
> + * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
> + *	It can also be PHY_ANY_UID
> + * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
> + *	comparison
> + * @run: The actual code to be run when a matching PHY is found
> + */

[Severity: Low]
Was the wording change in this kernel-doc block intentional?  The version
removed from phy_device.c said "(or NULL)" for @bus_id and "(or 0 to
disable id-based matching)" for @phy_uid_mask, which matches what the code
does.  The new text mentions PHY_ANY_ID and PHY_ANY_UID instead.

Grepping the tree at this commit, PHY_ANY_ID and PHY_ANY_UID have no
definition anywhere; the only hits are these two new comment lines in
phy_fixup.c plus one sentence in Documentation/networking/phy.rst.

The matching code moved by this patch, phy_needs_fixup() in phy_fixup.c,
has no wildcard handling:

	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
		return true;

	if (fixup->phy_uid_mask &&
	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
		return true;

and phy_register_fixup() only special-cases a NULL bus_id:

	if (bus_id)
		strscpy(fixup->bus_id, bus_id);
	fixup->phy_uid = phy_uid;
	fixup->phy_uid_mask = phy_uid_mask;

So platform code written against this comment would either fail to build
on the undefined identifier, or register a fixup that never matches.
Would it be better to keep the "(or NULL)" and "(or 0 to disable id-based
matching)" wording?

> +static void __init phy_register_fixup(const char *bus_id, u32 phy_uid,
> +				      u32 phy_uid_mask,
> +				      int (*run)(struct phy_device *))

[ ... ]

> +/* Registers a fixup to be run on any PHY with the UID in phy_uid */
> +void __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
> +				       int (*run)(struct phy_device *))
> +{
> +	phy_register_fixup(NULL, phy_uid, phy_uid_mask, run);
> +}
> +
> +/* Registers a fixup to be run on the PHY with id string bus_id */
> +void __init phy_register_fixup_for_id(const char *bus_id,
> +				      int (*run)(struct phy_device *))
> +{
> +	phy_register_fixup(bus_id, 0, 0, run);
> +}

[ ... ]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3d8afe6b7f1c5..257634a543a14 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2440,10 +2440,10 @@ int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
>  void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
>  		       bool *tx_pause, bool *rx_pause);
>  
> -int phy_register_fixup_for_id(const char *bus_id,
> -			      int (*run)(struct phy_device *));
> -int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
> -			       int (*run)(struct phy_device *));
> +void __init phy_register_fixup_for_id(const char *bus_id,
> +				      int (*run)(struct phy_device *));
> +void __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
> +				       int (*run)(struct phy_device *));

[Severity: Low]
Should Documentation/networking/phy.rst be updated in the same patch?  The
"Board Fixups" section still documents the old prototypes:

 int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
		int (*run)(struct phy_device *));
 int phy_register_fixup_for_id(const char *phy_id,
		int (*run)(struct phy_device *));

Two things there are now stale.  The return type is void, so code that
assigns or tests the return value as the document suggests no longer
compiles.

The document also just says platform code registers fixups, with no
mention that registration is now init-only: the helpers are __init and are
no longer exported, and phy_register_fixup() adds to phy_fixup_list, which
is declared

	static struct list_head phy_fixup_list __ro_after_init =
		LIST_HEAD_INIT(phy_fixup_list);

so a caller outside init context gets a section mismatch from modpost and,
if it ever runs after init, writes to read-only memory.  Modules can no
longer call these at all.

Same section of phy.rst also describes PHY_ANY_ID and PHY_ANY_UID as
wildcards, which ties in with the kernel-doc comment above.
-- 
pw-bot: cr
