Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5318346AFD
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632085; cv=none; b=RyWYP4GxnL8g7JWRqBpJmgnbCHGjg+uHpQKO/JyUKtLKPu/IAWTZL1iR503W7bKbU/r4d6ErTUTm1Nvk1ZIFD1y8dfG7ZHDhfvRmHPzo9r1CR5+MZFLXvaNmDtCWnZmIP/gKUIa2CsmUiYJbHDuB6wn1XSyrinPG/Lqs3zEd1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632085; c=relaxed/simple;
	bh=Mfv68jd+gmiyI0TKaPVK8vaRGnAK3mWkCFCtDyzVatA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUVz8ySNl+TANOvmyWqLIKGK8OYYv+bo9BFk1r4c1WyfrXmSqTKIzvocsThajXOkYq4ezUPG/StHEagkLcHmd8DZFZ5J/gECk7eNSenx91xF+U6aUmFdASyg6ULDrV+u1eCdi8TG6GtQW1hzhAfka7K46nEvvOO0bdIKvLRzzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0HxuFee; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0HxuFee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784632082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpoELLvJpSDPCX+1SgJO/5ACPGm/5GRo2k2MXA7KiY4=;
	b=X0HxuFeer6P90/XZtMr348FSmm/RntqJ1qJgZXuChZ0bCQyOjeLG7EKv2TfZ1VT3pthBUX
	4BoB/S24V6mB6rYdILcTdyhcgmBPcyJb5jQazL1RYZUJhRnjPIEnORmlR2/kZENVaO2Los
	GNEQWBsSL97cN3jTjcrNpzrMXbFbFzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-NQBYXxeJPeWzBVAfEtzXqw-1; Tue,
 21 Jul 2026 07:05:49 -0400
X-MC-Unique: NQBYXxeJPeWzBVAfEtzXqw-1
X-Mimecast-MFC-AGG-ID: NQBYXxeJPeWzBVAfEtzXqw_1784631948
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5A03180AAB7;
	Tue, 21 Jul 2026 11:05:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.106])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C8C53004193;
	Tue, 21 Jul 2026 11:05:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: shaojijie@huawei.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shenjian15@huawei.com,
	liuyonglong@huawei.com,
	chenhao418@huawei.com,
	yangshuaisong@h-partners.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net] net: hns3: fix speed configuration residue after driver reload
Date: Tue, 21 Jul 2026 13:05:29 +0200
Message-ID: <20260721110529.201977-1-pabeni@redhat.com>
In-Reply-To: <20260708140532.1691493-1-shaojijie@huawei.com>
References: <20260708140532.1691493-1-shaojijie@huawei.com>
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
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: hns3: fix speed configuration residue after driver reload

This change drops the req_speed overwrite in hclge_init_ae_dev() so
req_speed keeps the firmware default set during hclge_configure()
after a driver reload, and only req_autoneg continues to be
synchronized from mac.autoneg on non-copper media.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index fc8587c80813..164c3ecf195c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -9498,12 +9498,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>  	if (ret)
>  		goto err_ptp_uninit;
>  
> -	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER) {
> +	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
>  		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
> -		if (hdev->hw.mac.autoneg == AUTONEG_DISABLE &&
> -		    hdev->hw.mac.speed != SPEED_UNKNOWN)
> -			hdev->hw.mac.req_speed = hdev->hw.mac.speed;
> -	}

[High]
Could removing this block reintroduce the scenario that d9d349c4e8a0
("net: hns3: differentiate autoneg default values between copper and
fiber") was written to handle?

The Fixes-tagged commit added this req_speed overwrite specifically for
optical ports where firmware presets autoneg=DISABLE at a specific
forced speed (a case its commit message describes as common in data
centers where the remote switch runs in forced mode).

There appear to be two distinct notions of "firmware default" involved:

  - cfg.default_speed read from flash static parameters via
    hclge_get_cfg() and stored into req_speed by hclge_configure()

  - the live firmware/SFP state read via hclge_get_sfp_info() into
    mac.autoneg and mac.speed

On a fiber port where the flash default_speed is 100G but firmware has
preset the port to forced 25G to match a fixed-speed remote, after this
change:

    hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;  /* = DISABLE */
    /* req_speed still holds flash default 100G */

hclge_set_autoneg_speed_dup() would then see !req_autoneg and call:

    hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed=100G, ...);

forcing 100G against a 25G-only peer.

Is that scenario still handled, or is it expected not to occur in
practice?

[Medium]
The commit message reasons about mac.speed carrying over user ethtool
changes across a driver reload:

  "In hclge_init_ae_dev(), hclge_update_port_info() reads mac.speed
   from hardware, which reflects the last user configuration (e.g.
   ethtool changes), not the firmware default."

Does the same reasoning apply to mac.autoneg?

hclge_get_sfp_info() sets mac->autoneg from the live firmware state, so
a prior "ethtool -s ethX autoneg off speed 40000" on a 100G optical
port would leave firmware reporting autoneg=DISABLE after reload.

After this change, req_speed correctly reverts to the flash default
100G, but this line still runs:

    hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;

so req_autoneg stays at AUTONEG_DISABLE rather than reverting to the
AUTONEG_ENABLE default that hclge_configure() would set for fiber.

Why is speed residue fixed while autoneg residue is preserved?

>  
>  	ret = hclge_set_autoneg_speed_dup(hdev);
>  	if (ret) {
-- 
This is an AI-generated review.

