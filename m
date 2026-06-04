Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A33DB338
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573305; cv=none; b=coa8fehDUU6pezTNe9MH49EBeTeXdUBtdLdUz5RJjXOlesXUyPqFs0MVG98RUTgDD7jN2Vu0bkJxhpOIrPSZphBYMMfr5CPt4t5uZm/7kKNpKv8swaf2pFuefiUzD9knM4oSwzs6xpmHaDuo81g/rUtK8Jsk/oI2lXjh3j0A9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573305; c=relaxed/simple;
	bh=1qNBJcwKVG1CZQr09l+kfyApZAvxzNoOCTixBTyISX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr9qtl6/xwIc66zSON/SdlHttde+PI0Qlmb792s1wAXvdKZjezPpVxsfeQ8fNgM7YpKzzJKwSiQwbwCJKcETlkoSXz3dK63OeCrFXhQguKKJ+qU9TZN4eEFb5nmuNFQMYaGs7PwbKXzHWzaOXi9B1YJOnUf1um+08dUfoP9xaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYxCYPBN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYxCYPBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780573302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XG+q9cMUfB3ktBQ3CWeEecmcKk4bo49IUo2CKRhJpUk=;
	b=iYxCYPBNrX53b0snlcrO8eKvitVqrK4jQDjouP1cJ0PPSXpL8QlD23GqFQz3zXmAX6JeaB
	hXAqFyHyxSiPcMD5uLYV+e9knsFN7YUDRt3z2p09z92tEEVNPekv9PMkXYaXmsjE4LmhND
	79BueTYgt+s/QBWv+wBVngtmjuX6J1o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-x50i2IA6OX6IYnjCvGcKfw-1; Thu,
 04 Jun 2026 07:41:36 -0400
X-MC-Unique: x50i2IA6OX6IYnjCvGcKfw-1
X-Mimecast-MFC-AGG-ID: x50i2IA6OX6IYnjCvGcKfw_1780573294
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD8B6180048E;
	Thu,  4 Jun 2026 11:41:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAFFF30001A1;
	Thu,  4 Jun 2026 11:41:25 +0000 (UTC)
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
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss cable PHY tunables
Date: Thu,  4 Jun 2026 13:41:19 +0200
Message-ID: <20260604114119.170747-1-pabeni@redhat.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: ethtool: add KSZ87xx low-loss cable PHY tunables

Introduce vendor-specific PHY tunable identifiers to control the
KSZ87xx low-loss cable erratum handling through the ethtool PHY
tunable interface.

> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 1cdfb8341df24..a2091d4e00f3f 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -291,6 +291,9 @@ enum phy_tunable_id {
>  	ETHTOOL_PHY_DOWNSHIFT,
>  	ETHTOOL_PHY_FAST_LINK_DOWN,
>  	ETHTOOL_PHY_EDPD,
> +	ETHTOOL_PHY_SHORT_CABLE_PRESET,
> +	ETHTOOL_PHY_LPF_BW,
> +	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,

[Severity: High]
Are these vendor-specific hardware erratum tunables appropriate for the 
generic global ethtool UAPI? 

These tunables use generic names for device-specific KSZ87xx workarounds. 
Since UAPI is permanent, adding hardware-tied erratum parameters without a 
vendor prefix or standard abstraction could lead to namespace pollution. Would 
devlink param or device tree properties be a better fit for this?

[ ... ]

> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index bd97f9b9bf182..fc25424228246 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -3114,6 +3114,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
>  	switch (tuna->id) {
>  	case ETHTOOL_PHY_DOWNSHIFT:
>  	case ETHTOOL_PHY_FAST_LINK_DOWN:
> +	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
> +	case ETHTOOL_PHY_LPF_BW:
> +	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
>  		if (tuna->len != sizeof(u8) ||
>  		    tuna->type_id != ETHTOOL_TUNABLE_U8)
>  			return -EINVAL;

[Severity: High]
Is it intentional to enforce an 8-bit type constraint for bandwidth and DSP
equalizer tunables?

This heavily couples the global API to the 8-bit register layout of the
KSZ87xx hardware without defining generic units like Hz for bandwidth. 

Also, in the same file:

> net/ethtool/ioctl.c:set_phy_tunable() {
> ...
> 	phy_drv_tunable = phydev && phydev->drv && phydev->drv->get_tunable;
> 	if (!phy_drv_tunable && !dev->ethtool_ops->set_phy_tunable)
> 		return -EOPNOTSUPP;
> ...
> 	if (phy_drv_tunable) {
> 		mutex_lock(&phydev->lock);
> 		ret = phydev->drv->set_tunable(phydev, &tuna, data);
> 		mutex_unlock(&phydev->lock);
> 	}
> ...
> }

[Severity: High]
This is a pre-existing issue, but does this code unconditionally dereference
set_tunable if get_tunable is present?

In set_phy_tunable(), phy_drv_tunable is determined by checking
phydev->drv->get_tunable instead of set_tunable. If a driver implements
get_tunable but leaves set_tunable as NULL, the capability check passes, which
would result in a NULL pointer dereference when set_tunable is called.
-- 
This is an AI-generated review.

