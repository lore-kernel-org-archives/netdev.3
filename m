Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C3330B2D;
	Fri, 29 May 2026 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015043; cv=none; b=HIQKUtmYRXJQoSmTyMU6KNvFKHG774Tmz54CxadIC8hAM2of12Y4vRqT4d6tfqAgtoJaYm9hiPr+CgzX+bP8OIXGosPOvfSm+jeSo3Sv3ouxB7HqHu6uDiF3owUvwlu7axuKaFkLPH3RULXWpInjZdVYP2Pd/0F8N9D/GHCDfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015043; c=relaxed/simple;
	bh=iYAEEPJT6zuUkztjNWNv5XNmyZJGq0aYOrm0JHLMA78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXO8bo25uIr5tfIkHWc9XopXM+eZ11ohpnTCF11dhY250cXf+0jQaGcYQ/BZHQV82wlcW9yinf4UVxDn2SvFIZep7xcQiXs8O7gGbrZIysU1fyv4n2d1nFz/r7VzwvQrNK67Q4mfyb8ObkxbjAxzDnXriAvggHNjsw38A13W5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofDeazrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofDeazrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3331F000E9;
	Fri, 29 May 2026 00:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015042;
	bh=b7yimqC8SUcB7N/PLtrmbiPlc4QWMZXw1yk3XWze+OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofDeazrfSUX+410NuFXpV/ahI9vrRJ1rCI9MLp21siJ/t64gEym0RI3N1Z5N99zu2
	 iqjq+xULDIr1JKoTHdJ3bsbRMCC/bUkVlxF8mlj2kSbN9gF9JycdpVSCa+tqJB32Y2
	 OrRHtgJI2wf1LTfLfO3iQ2xWIFh3BBBWCVX+ZQkTlYqfr7G8Sjn2tM30hAdEkcBe0l
	 FnDOF/JCCQSY9b8sOHeELYPU75CWvKImXFD68KDjbaw8N2gxoc30lfVXBznUN/owYR
	 KgKhth4OK0fW13bgFHgysvE81YcG3buB0leyhjVMtjciHrbK0jq6KqUfcYeWLPoZAJ
	 1UAcMaNa64b5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: bobbyeshleman@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hmohsin@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com
Subject: Re: [PATCH net v2] eth: fbnic: move aui and fec from fbnic_net to fbnic_dev
Date: Thu, 28 May 2026 17:37:14 -0700
Message-ID: <20260529003714.317617-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526-fbnic-aui-change-v2-1-7c74cd48074f@meta.com>
References: <20260526-fbnic-aui-change-v2-1-7c74cd48074f@meta.com>
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
eth: fbnic: move aui and fec from fbnic_net to fbnic_dev

This patch moves the aui and fec fields from struct fbnic_net to
struct fbnic_dev. It aims to prevent a time-of-check to time-of-use bug by
allowing the MDIO layer to read these fields directly from the device
structure instead of going through a potentially freed netdev.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
> index 709041f7fc43d..49895430c97d9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
[ ... ]
> @@ -15,18 +14,14 @@ static int
>  fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
>  {
>  	u8 aui = FBNIC_AUI_UNKNOWN;
> -	struct fbnic_net *fbn;
>  	int ret = 0;
>  
>  	/* We don't need a second PMD, just one can handle both lanes */
>  	if (addr)
>  		return 0;
>  
> -	if (fbd->netdev) {
> -		fbn = netdev_priv(fbd->netdev);
> -		if (fbn->aui < FBNIC_AUI_UNKNOWN)
> -			aui = fbn->aui;
> -	}
> +	if (fbd->aui < FBNIC_AUI_UNKNOWN)
> +		aui = fbd->aui;

[Severity: High]
This isn't a bug introduced by this patch, but does moving aui and fec to
struct fbnic_dev actually prevent a use-after-free here?

If fbnic_mdiobus_create() registers the MDIO bus using
devm_mdiobus_register(), devres-managed resources are cleaned up after the
driver's remove callback returns.

If fbnic_remove() frees the fbd structure, the bus remains fully active
between the time the remove function finishes and the devres cleanup
unregisters the MDIO bus.

Can a concurrent sysfs access invoke MDIO read callbacks which pass fbd
to this function, leading to a dereference of the freed fbd pointer when
reading fbd->aui?
-- 
pw-bot: cr
