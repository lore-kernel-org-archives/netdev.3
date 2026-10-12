Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0E41D204;
	Mon, 12 Oct 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831688; cv=none; b=Hqnohop/mzShwHrZTR5Kokk2OLKG9Mq7ydmk4xwCW/yuLxHPNuMFcjCRGoI+LclBojAsuDyb3LJPLY5A36pzW0R15KSpmIJBorA/xzBneiccl3XiY62d7QvoIe4EoRrI4R+4xK7FxFuxWBKd9A7+xwJ7a7qqPcaUAmUz8hbDVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831688; c=relaxed/simple;
	bh=Xw0bqyRW3ITXCi2hZd3bEZrfhGIbqBTBV2UFIBh226o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gU1rOc92Sm6yzt1zPaJHWs9TUxzUKnfUZPN8DqWkM7bn9AGq1lF8YzsNxeGzcscn8WbsUPmzt94WUKAzKvERviaabowBX31x8qWTAIEgicy2AasL5GZUuyoSGy5gMCgEZJnJKjcqY6oAgkH/KKseAji3SKMDz23GkYo9KKoNYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RplrdsM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RplrdsM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C2A1F0089B;
	Mon, 12 Oct 2026 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831686;
	bh=UIqOJLYRdV+MzZLicS2TDxnQpeZCtKLQ/MbxYjbovPs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RplrdsM/XL3+pKgGomBxpyHHtQHdDi2HSTfFFaUwOJ88H2YpW/nnYCrbI9nFwoymT
	 NG4UuOWMgv6G7QMGmvkQW35ynpuy/fMxpWRaX3/csTv8La3T7Dw6oDbz0xxHuQAhXR
	 sRmT771ipZm7pJdz0zA1vxGQn03FIwzmNs39ZwOIVLMHkzAZPTjI/EHjvAD4U42H1j
	 XH3W/yQyrXELrn7l93jyGp9L1gTfl3/45Pgg7LQqJPOqAbjCX3Quz3rrRVGtrxmlkW
	 Kulwfu4QceH+j66gMx8PAoLxl9gSb/Umb+kxofRg2WBdyGN2yl9yhUU4WK6tGrAISQ
	 3Wp/jr0qz+wCg==
Subject: Re: [PATCH net-next v11 1/6] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 19:01:25 +0000
Message-ID: <179183168522.434549.14619345397319265452@kernel.org>
In-Reply-To: <20261008175225.3375274-2-coiaprant@gmail.com>
References: <20261008175225.3375274-2-coiaprant@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] xpcs_get_state_c37_sgmii() now does a non-atomic read -> act
  sequence.
- [Low] Concern: in xpcs_get_state_c37_sgmii() the ANCMPLT latch is
  cleared (pcs-xpcs.c:1112) before BMCR_ANRESTART is issued (pcs-…

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

This patch sets BMCR_ANRESTART alongside BMCR_ANENABLE when configuring
C37 SGMII AN. It also clears DW_VR_MII_AN_INTR_STS before AN starts. In
xpcs_get_state_c37_sgmii(), when AN completion is seen with the link down,
it clears the ANCMPLT latch and restarts AN, so that parts such as RK3568
can recover the link.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index b415b93d77c15..6466e0ff2a98b 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c

[ ... ]

> @@ -1093,9 +1107,18 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
>  		return 0;
>  	}
>  
> -	/* Clear AN complete status or interrupt */
> -	if (state->an_complete)
> -		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	if (state->an_complete) {
> +		/* Clear AN complete status or interrupt */
> +		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Initiate the next round of AN */
> +		ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +				  BMCR_ANRESTART);
> +		if (ret < 0)
> +			return ret;

[Severity: Medium]
Can two callers of .pcs_get_state() race here and restart a negotiation
that has just finished with the link up?

The read of DW_VR_MII_AN_INTR_STS at the top of the function and the
clear and restart here are not atomic. phylink calls .pcs_get_state()
from contexts that do not share a lock:

  phylink_resolve()                   holds pl->state_mutex, not RTNL
  phylink_ethtool_ksettings_get()     holds RTNL only (MLO_AN_INBAND,
                                      no phydev)
  phylink_mii_ioctl()->phylink_mii_read()   holds RTNL only

struct dw_xpcs has no lock of its own, and the MDIO bus lock only covers
each single access.

A possible interleaving:

CPU1 (ethtool get)                  CPU0 (phylink_resolve)
xpcs_read(INTR_STS)
  link=0, ANCMPLT=1
                                    xpcs_read(INTR_STS)
                                      link=0, ANCMPLT=1
                                    xpcs_write(INTR_STS, 0)
                                    xpcs_modify(BMCR, ANRESTART)
                                    ... AN completes, link up ...
xpcs_write(INTR_STS, 0)
xpcs_modify(BMCR, ANRESTART)

CPU1 acts on its stale sample. It clears the newly latched ANCMPLT and
restarts AN on a link that has just come up.

Before this patch, a concurrent caller could only clear the latch. The
extra restart is new. Unprivileged users can issue ethtool get link
settings.

The commit message's reason for clearing the latch before the restart
assumes that get_state calls are serialized. Does phylink actually
guarantee that for these callers?

[Severity: Low]
What retries the restart if the xpcs_write() of DW_VR_MII_AN_INTR_STS
succeeds and then this xpcs_modify() of MII_BMCR fails?

The latched ANCMPLT that triggers this path has already been cleared. No
restart is pending, and xpcs_get_state() only logs the error:

phylink_resolve()
  xpcs_get_state()
    xpcs_get_state_c37_sgmii()
      xpcs_write(DW_VR_MII_AN_INTR_STS, 0)    succeeds
      xpcs_modify(MII_BMCR, BMCR_ANRESTART)   fails
    dev_err(..., "xpcs_get_state_c37_sgmii", ...)

On parts that do not restart AN by themselves, the link would then stay
down until the interface is reconfigured.

The commit message covers this case:

  "If an MDIO access fails at this point, it indicates an unrecoverable
  hardware condition until reset."

On RK3568, the MMIO-based MDIO back end added later in the series seems
to fail only through pm_runtime_resume_and_get(). That failure is not
transient. On other XPCS platforms the databook says AN restarts on its
own. So the documented behaviour may be fine as it is.

> +	}
>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008175225.3375274-1-coiaprant%40gmail.com
