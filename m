Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345985;
	b=eiU3g+mUnhHG50a3aLnaYE9w4EfuEo25noAZ/NTy4a/IftMlByZXgk0AIA8nRjuxwFEp
	 7eH7JUjrZhf+Ll3oxm3bs1Ewy7qxdM1XluWZEoCaDfE7fAgCxWvbwyjsbh97OwiwvgnI7
	 45xAXAaPRRhdo43PXMIZDDhDcvP5PgOAm/kgQDFEzuRNo/GLiHtcylgMp6fc+Wfbz9KcQ
	 tEgJdXW5ENcO4rlAP22H7qgLI5XoyjOhKAqHnbwx1KWg/Yjw9X4lUbeA8XxVaLp+1l4lI
	 lAjcU5hZ1BZsygRkdFIzDRK5hS+7E7bAaEtuME9e1IlcDKY99bXvRv7I92nV1fMUSRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WSLefdhIoTKuSBUWT7xkDzFrjEc0mfIIXjLONc470lA=;
	b=eKH4r5Z+ow6N1t+y7ppTacoGamCXu8f1PqTZa52VUJGqqpzOSmeW0jXBmnF8LXU5zUOg
	 +hO6a9YZ3/hHQiVWSwXO3oBYVZRMxBFJ8G2GmKb6Rtr4hy+5dUtcer/N2yBBAOtiaR407
	 WSCj4IXn6hGLDVc7WnbZHo7Y2zvW4txRGMbIGSVXa1wHHCQ4aSiWYx/YpelFdMC/5/QCF
	 uy0jytxXMIwh2+4GhZB9F27P7onhiPj7AcUtO+A9BNRmgmYvu1fm6s88sBJnKhUmdtFGk
	 SW2TqitLD/RREad9jtYZK6IGaJgqWy4xFhD8F2HGibk769N+Ay+0J8fpzATYzaYkmpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKfOWZRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535F606A32A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKfOWZRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE1F1F0089F;
	Tue, 10 Nov 2026 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345984;
	bh=WSLefdhIoTKuSBUWT7xkDzFrjEc0mfIIXjLONc470lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKfOWZRVqTZ2Nl9aS5BDlu9vdsYUrlpLFIagpAAbtzhOx8MacbTE8oLnnuB9HHWE8
	 ++z41NQH7cfxsIx7DYcnCzDqTCxMkQs5rjr1egIFfcs9oqebgEF2KbXiL4djBUVzkt
	 8yZghaXg81vBumPImXmvPbuxfPhFonlJvbGDIvz5p4Ty1pRgF6dxnqBJYYULF8Vxve
	 eF54pu2OXKzCDDNyQif2cq8A+hB1TjOO05iV/+7xDFBR5FwtOLDCLy+u1NrSKVlDXf
	 RyF+ro9I1XaJ2o7UFPeUJVUjtkc1+n9BlDd3sWeoBnxtyQ1Sn0qy7EDd11dB04zXWR
	 duY5FPi3oDr3g==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	nikhil.rao@amd.com,
	edumazet@kernel.org
Subject: Re: [PATCH net-next v3 4/5] ionic: report the operational FEC mode from ethtool --show-fec
Date: Tue, 10 Nov 2026 13:26:23 -0800
Message-ID: <20261110212623.2294818-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-ionic-get-fec-stats-v3-4-b261fd53d0a7@amd.com>
References: <20261104-ionic-get-fec-stats-v3-4-b261fd53d0a7@amd.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ionic: report the operational FEC mode from ethtool --show-fec

This commit changes ionic_get_fecparam() to fill active_fec from the
firmware-reported status.fec_type instead of the host-requested
config.fec_type. The commit message notes that firmware older than the
status.fec_type field will report FEC as off.

> Poisoning the byte before PORT_INIT, the way the driver marks unwritten
> extra_stats counters with IONIC_STAT_INVALID, does not work here:
> firmware builds the whole port status block and writes it over the DMA
> region, so the marker is gone whether or not that firmware knows the
> field.  Accept the wrong answer on firmware that old.
>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>

[Severity: Low]
This isn't a bug, but should this have a Fixes: tag? Reporting
config.fec_type as active_fec goes back to commit e95f922f4c2f ("ionic:
implement ethtool set-fec").

The sibling patch in this series, "ionic: report the configured FEC mode
in ethtool_fecparam.fec", changes the same function and carries
Fixes: e95f922f4c2f.

If the tag was left off on purpose, for example to keep the old firmware
behavior change out of stable backports, could the commit message say so?

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index bf7c70438a8c3..2e067481bb153 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -442,8 +442,10 @@ static int ionic_get_fecparam(struct net_device *netdev,
>  	lif = netdev_priv(netdev);
>  	port_info = lif->ionic->idev.port_info;
>  
> -	fec->active_fec = ionic_fec_type_to_ethtool(port_info->config.fec_type);
> -	fec->fec = ionic_fec_type_to_ethtool(port_info->config.fec_type);
> +	fec->active_fec =
> +		ionic_fec_type_to_ethtool(READ_ONCE(port_info->status.fec_type));

[Severity: Medium]
Does this break forced-FEC links on firmware older than commit
c4e7a75a096c ("ionic: updates to ionic FW api description")?

On that firmware, status.fec_type is still a reserved byte that reads as
0. That value is IONIC_PORT_FEC_TYPE_NONE, so ionic_fec_type_to_ethtool()
returns ETHTOOL_FEC_OFF for every link.

ionic_set_fecparam() only accepts FEC changes while autoneg is disabled:

	if (lif->ionic->idev.port_info->config.an_enable) {
		netdev_err(netdev, "FEC request not allowed while autoneg is enabled\n");
		return -EINVAL;
	}

So when config.an_enable is clear, config.fec_type is the mode the port
is running. Before this patch, links forced to RS or BaseR were reported
correctly. With this change, they show "Active FEC encoding: Off" on old
firmware.

The driver has no minimum firmware version check (ionic_identify() only
logs fw_version), so that firmware is still accepted. The rest of the
series doesn't touch ionic_get_fecparam(), so this is still the behavior
after the last patch.

The commit message says "Accept the wrong answer on firmware that old",
but it doesn't mention that forced-FEC links, which used to report
correctly, now report the wrong mode too.

Could active_fec fall back to config.fec_type when !config.an_enable, and
use status.fec_type only on autoneg links? New firmware would give the
same answer, and on old firmware the wrong answer would be limited to
autoneg links.

> +	fec->fec =
> +		ionic_fec_type_to_ethtool(READ_ONCE(port_info->config.fec_type));
>  
>  	return 0;
>  }
