Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549086;
	b=JEfkyZhIUPL5iI3geoSntsSs+QLcfjqZK5Nkri9cCsuMh4bnxDT7a8nSqwIkwf/zcY85
	 GhpE4k5FkTGV9PvJIeMgPG3MQJEwnd/l1fMao8yK0tk9BP5mxrX4E4/K9d1PXrsbbnx/u
	 nkOWQuU1iZoSf7VoA5vLKM+8sRYpnjfPPtvn2o1x6KtQz4rze+FnksX2Ini0RM8VcwFXq
	 cjoaD/jb67vjH0M25IafwVs+OmfaqQGzL8MHSYxjNiGD/PROCRQ34U0dHG/5EPM4/K9/3
	 e7WO3yBr+M4vFCDYO+KdtS3iACXkJYVYz2nVp4nvSzxqBpQ1okU+zk2VEZiBLDVs/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549086;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GjFNdrxT3EZFR3J6YnNd1f/Z2k934t/npf1oL+Xxd74=;
	b=zrEyjcnnCUaTMcA5j90BWFDZIICpypKKjdDlWsdHjFev8fruTPfsqnS1oz6IiLDxnI+E
	 cQP0SX0KZpEAEKvvaafkWsMUWHbZWO88PU0Snb7oyXPQtOSN/TLDm2pdM5hLk8WwnuOeH
	 puY4ZNl2qg0+QZCYJYlqZ4NqwGlLAHkbX83LGZHcaw9dCa4407x8PSDpduf3bkWziUCyT
	 LQvWunbxJokmDZMIsiYqRbZVy+q8lWN8Cgf4k8injhHXgJzeVu+7wp1r5+coa8Oyu8IaV
	 I/22q3YdiV1prWcYyi874aCrxJ5/JVWGUcZWQSLcG9FsnShPV3hdYe2/5ZJwfDJW7EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkNi0WJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF1606A8A6;
	Fri, 13 Nov 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkNi0WJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117941F000C8;
	Fri, 13 Nov 2026 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549086;
	bh=GjFNdrxT3EZFR3J6YnNd1f/Z2k934t/npf1oL+Xxd74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lkNi0WJeOwuHsOONt4kswun2pDApIBs0KFMSAwcGgXveBRLLWwsWzxZiBA+wmzVRm
	 aDXJz5A/WG+ht+rX6gAiKuUcIys5pvIHz/8YRLkgVnR+d3vXeNdO9ly1lcAzmvoUgL
	 750MWv3GfoMcL1A8aFvgbMO35MyG+jKdssBcJW0K2XqbPyWTYPVtro3PedEkB7txfa
	 S+csPzK/tfaFktsR9fkycsF0Zo3imP1STx+9L4YL1z22Jib8n8p1qrSdWZ3MRr2KBU
	 qjsVvgzJnMahByMt1sTaQD+OGz89baO2mADlxNS28Fg8/Mx5bQzrvn+ATWEROOYk/V
	 QT4rDzwwq0AbQ==
Subject: Re: [PATCH net v5 1/4] net: phy: move irq_suspended and irq_rerun out
 of the bitfield
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com,
 wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 05:51:24 +0000
Message-ID: <179454908461.2199510.508928890759611464@kernel.org>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-1-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-1-bbfdb5afb7d3@iav.lv>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds the comment "/* Written without phydev->lock, so
  not bitfields */" above irq_suspended and irq_rerun in struct…

--

net: phy: move irq_suspended and irq_rerun out of the bitfield

This commit turns irq_suspended and irq_rerun in struct phy_device from
1-bit bitfields into bools. phy_interrupt() sets irq_rerun without
phydev->lock, and that write could lose an update to link and
autoneg_complete, which share the same word. After this change the two
flags are separate memory locations.

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 21afc2082b174..bbe28ff97e51c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -726,8 +726,9 @@ struct phy_device {
>  
>  	/* Interrupts are enabled */
>  	unsigned interrupts:1;
> -	unsigned irq_suspended:1;
> -	unsigned irq_rerun:1;
> +	/* Written without phydev->lock, so not bitfields */

[Severity: Low]
This isn't a bug, but the new comment states a rule that the
neighbouring fields don't follow. Several of them are written without
phydev->lock. They are still 1-bit bitfields in the same run as link
and autoneg_complete, and the state machine writes those two under the
lock.

interrupts, the field just above, is written in phy_config_interrupt():

drivers/net/phy/phy.c:phy_config_interrupt() {
    ...
	phydev->interrupts = interrupts ? 1 : 0;
    ...
}

This is reached from phy_request_interrupt()/phy_free_interrupt(). Some
PHY drivers also set it in their suspend/resume paths (dp83867, micrel,
marvell-88q2xxx).

phy_suspend() writes wol_enabled and suspended:

drivers/net/phy/phy_device.c:phy_suspend() {
    ...
	phydev->wol_enabled = phy_may_wakeup(phydev) ||
    ...
		phydev->suspended = true;
    ...
}

mdio_bus_phy_suspend() and mdio_bus_phy_resume() write
suspended_by_mdio_bus:

	phydev->suspended_by_mdio_bus = 1;

The commit message itself names these unlocked writers of the same word.

Later in the series, "net: phy: postpone PHY interrupts during sleep
with MAC-managed PM" adds another bitfield to this word, wol_phy:1.
phy_suspend() writes it without phydev->lock, and phy_irq_wake_source()
reads it.

Could the comment say that these two fields are split out because
phy_interrupt() writes them from the IRQ thread? As written, a reader
could assume the remaining bitfields are all lock-protected.

If any of those unlocked writers can run at the same time as each
other, or as the locked link/autoneg_complete writers, the lost-update
problem this commit describes would still apply to them. I haven't
shown that concurrency here.

> +	bool irq_suspended;
> +	bool irq_rerun;
>  
>  	unsigned default_timestamp:1;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3%40iav.lv
