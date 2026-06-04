Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49F425CE6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573529; cv=none; b=jtZbn4qQC3JvBXclWxaBGTDdFOgBIlGeEZQbepxVGrU3X/3HphjoD2/7m8G/2iv+zNF0TLHUQ02WH2nBtlH6mOd9u9jD3f6un5RRzNwcaoq3ghCeB4q+E0s5pKEDJnAT8rCgp3vvHFMfGiWAHbiacBjFyOEoiu9qHAGyFi9sFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573529; c=relaxed/simple;
	bh=0Y+TeetPK1sXCb/1u7pnHcRDWAB6amzW7kUDqeN3Whs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeO7AVGCtHH/wxx6mDyHjK19fChmryCcBsRfqBPb8/es60IHL5ph0NKKQimkHSlzDS/OP9rnn6v2s6SFnQ/bfuC30suijWGoRLPq/xo4nu+ldV8mZDykcJi+y8zCckE+jScyGYicOIE7LjFEa9mPhLHt9qXWN3KvK7TAIT9VpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBdLi4IP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBdLi4IP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780573526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGeL7NiuE1trFM+DToRpd6ciMCeQVr8e9ns4mRVJyio=;
	b=BBdLi4IPCYd3i3k7F/GhQVI1LE0QoS4iwaYgXrHf6m3PjX+9rKBsxLkzb6/SRqEtdRVv+w
	pAnH3b+dgdslNUbDXgO9PT/F1Xu+41eSij/a/1PC9t6WqMdEfffAxqK3VauNBGovPp/RCd
	zFVmCLu/o6iew0YN7jnt3HabXdoyyx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-9I4vO23_OJOGvjjFqNya4g-1; Thu,
 04 Jun 2026 07:45:22 -0400
X-MC-Unique: 9I4vO23_OJOGvjjFqNya4g-1
X-Mimecast-MFC-AGG-ID: 9I4vO23_OJOGvjjFqNya4g_1780573520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E716180034E;
	Thu,  4 Jun 2026 11:45:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 375F41955BC0;
	Thu,  4 Jun 2026 11:45:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lawson.fidelio@gmail.com
Cc: woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marex@denx.de,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Tristram.Ha@microchip.com,
	Woojung.Huh@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nb@tipi-net.de,
	fidelio.lawson@exotec.com,
	marex@nabladev.com
Subject: Re: [PATCH net-next v9 3/3] net: phy: micrel: expose KSZ87xx low-loss cable tunables
Date: Thu,  4 Jun 2026 13:41:33 +0200
Message-ID: <20260604114133.170770-1-pabeni@redhat.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-3-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-3-fdbbb15592cb@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: phy: micrel: expose KSZ87xx low-loss cable tunables

This commit adds support for the KSZ87xx low-loss cable PHY tunables in the
Micrel PHY driver. It implements the get_tunable and set_tunable callbacks
to control receiver behavior. These callbacks are forwarded via standard
phy_read() and phy_write() operations.

> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index e211a523c2584..bb8f3054e2574 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c

[ ... ]

> @@ -6961,6 +7013,8 @@ static struct phy_driver ksphy_driver[] = {
>  	/* PHY_BASIC_FEATURES */
>  	.config_init	= kszphy_config_init,
>  	.match_phy_device = ksz8795_match_phy_device,
> +	.get_tunable	= ksz8795_get_tunable,
> +	.set_tunable	= ksz8795_set_tunable,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the addition
of these callbacks, I noticed a pre-existing issue in the ethtool core.

In net/ethtool/ioctl.c:set_phy_tunable(), the capability check wrongly examines
phydev->drv->get_tunable instead of set_tunable:

	phy_drv_tunable = phydev && phydev->drv && phydev->drv->get_tunable;
	if (!phy_drv_tunable && !dev->ethtool_ops->set_phy_tunable)
		return -EOPNOTSUPP;
...
	if (phy_drv_tunable) {
		mutex_lock(&phydev->lock);
		ret = phydev->drv->set_tunable(phydev, &tuna, data);

Since the capability check looks at get_tunable but unconditionally calls
set_tunable, could this lead to a NULL pointer dereference if a PHY driver
were to implement only read-only tunables by providing just get_tunable?

>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
>  }, {
-- 
This is an AI-generated review.

