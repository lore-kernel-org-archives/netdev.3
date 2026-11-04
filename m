Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805594;
	b=304T7njugBX2z2HjdUPIYN5wRCHI40pxt6QT72guKDIsxF16EukVdvdOxrQSstaOlYjf
	 7MkW7GBNxXRcbhE/8IYZLYIGFY34nQeLFIJ7I+YznWRVknr+PwUYZWepSfyckJj1mTVF9
	 xXLDB6zgHJKNvmTKHJCWkBb/sag4awF4G8SEGt1bias8O/dekowmMRvZVlphSaMNeOkz6
	 B1AR8xfYnBsEk2MGAJWfwejKtMUWG+B/IvL7NzHXaXumdyHPc7K6ROJLP6gpzivTYf+Yn
	 QsV8nSeHgLL4qHUC+ZJkQS9ckQgCmYQ+WEx2DYWxCdWVZVC3TDuDbZN+pXygB1H7T1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805594;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=K3fgBMw2HNXRAIiBZEeJ/lREOui7IgwXu/7UvY+DQ6Y=;
	b=jYOfzp+7/uLWqAk4gawwcGXlE5gBt+drzsvOGmkaG3oS1ngqpeAPJDguoX60YvoAlDpp
	 jfrKPrVFX20mVIB21TWCx0SxZapHaQUqx76RqHVh+ghnm54phdsIN4P2u8JGzB8dGPEHa
	 iIcuZ4bNcJQm6gAdzNVv5DBhOSGt/kcni6jdfq7ldUxbDo6XLSvU5L/6huSjUeGHL8vSv
	 OmzfImt0Ac8zt4nbnb9rNIwNXkRuec3nwK+srLdMj1qfrO9SE1LFgeeK/SqjtC49F00dl
	 WqxLfH+EnlXmMZb2rHDVGAU4f2vzW48yVd0YGwUzJTPgptCqDHieQJa/MmFS3lEJTvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=y7OMmUSV;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67122606A7C0
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67122606A7C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=y7OMmUSV
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 03423C8F474;
	Wed,  4 Nov 2026 15:20:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0053B60770;
	Wed,  4 Nov 2026 15:19:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C737D103291D1;
	Wed,  4 Nov 2026 16:19:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805590; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K3fgBMw2HNXRAIiBZEeJ/lREOui7IgwXu/7UvY+DQ6Y=;
	b=y7OMmUSVEPClGb+kdN269F+rf+gyC039YWg2CSocLXrwcoliz0PUgvqvha7E5QoWdN0Rr5
	IKK2r2urXpkuazVC+zJjx9gmXCxVbQllawAwyutqFNLkdwUKtEGWRZ8SBu31xlibM5RLnP
	OdVH+/XBw8Iy5rZmfk3NbcjuYm0tg2nNhYJ3N+Vp21SmP+5eAaHcdN9EUBITr5p5niGq9T
	hIfEQtbF4Yh4teLqr1vsQRdO+Dzo2wnWVNU+sdOJ93yD32idb1v0Z8IN9H0eQVgdGCo/yy
	Gn6e8BYnHyngvxK0vWt239Q9/AZItTv6scVX9NYAw/DeI/skuXapPFnzWUDI6g==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 05/14] net: pse-pd: do not reach a freed PHY
 from the notification worker
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>, 
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103220217.1131971-6-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-6-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557477.1333589.18180962041053495718.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

> The notification worker holds a reference on the pse_control, but not
> on the PHY that psec->attached_phydev points to. If the PHY is removed
> while the worker runs, the pse_control survives and the worker reads the
> freed PHY. The same happens without a race when two PHYs share one PI:
> attached_phydev keeps pointing at the first PHY after it is removed.
> 
> pse_control_put() unlinks and frees a pse_control under pse_list_mutex,
> and phy_device_remove() calls it before the PHY is freed. So instead of
> taking a reference, let the worker look the pse_control up and use
> attached_phydev under pse_list_mutex. This nests pse_list_mutex inside
> rtnl; nothing under pse_list_mutex takes rtnl.
> 
> For a PI shared by two PHYs there is no single netdev to report to, so
> clear attached_phydev when a second PHY takes the pse_control, and warn.
> Events for that PI are then no longer reported, even after one PHY goes
> away. Failing the second PHY instead would fail its whole MDIO bus.
> 
> Triggered in QEMU (arm64, KASAN) with a test-only PSE controller:
> removing a PHY while the worker waits for rtnl, and removing one of
> two PHYs on a shared PI, both give
> 
>   BUG: KASAN: slab-use-after-free in pse_send_ntf_worker+0x2b0/0x2bc
> 
> With this patch both are gone.
> 
> Fixes: fc0e6db30941 ("net: pse-pd: Add support for reporting events")
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
>
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index eab7e25f2039b..af9eb29792706 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -238,24 +238,22 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
>   * @pcdev: a pointer to the PSE
>   * @id: index of the PSE control
>   *
> - * Return: pse_control pointer or NULL. The device returned has had a
> - *	   reference added and the pointer is safe until the user calls
> - *	   pse_control_put() to indicate they have finished with it.
> + * Must be called with pse_list_mutex held. No reference is taken: the
> + * pointer is only valid until pse_list_mutex is released.
> + *
> + * Return: pse_control pointer or NULL.
>   */
>  static struct pse_control *
>  pse_control_find_by_id(struct pse_controller_dev *pcdev, int id)
>  {
>  	struct pse_control *psec;
>  
> -	mutex_lock(&pse_list_mutex);
> +	lockdep_assert_held(&pse_list_mutex);
> +
>  	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> -		if (psec->id == id) {
> -			kref_get(&psec->refcnt);
> -			mutex_unlock(&pse_list_mutex);
> +		if (psec->id == id)
>  			return psec;
> -		}
>  	}
> -	mutex_unlock(&pse_list_mutex);
>  	return NULL;
>  }
>  
> @@ -268,6 +266,7 @@ pse_control_find_by_id(struct pse_controller_dev *pcdev, int id)
>  static struct net_device *pse_control_get_netdev(struct pse_control *psec)
>  {
>  	ASSERT_RTNL();
> +	lockdep_assert_held(&pse_list_mutex);
>  
>  	if (!psec || !psec->attached_phydev)
>  		return NULL;
> @@ -1015,13 +1014,23 @@ static void pse_send_ntf_worker(struct work_struct *work)
>  		struct net_device *netdev;
>  		struct pse_control *psec;
>  
> -		psec = pse_control_find_by_id(pcdev, ntf.id);
> +		/* If attached_phydev is set, it names the only PHY that
> +		 * holds this pse_control: a second PHY on the same PI
> +		 * clears it in pse_control_get_internal(). That PHY's
> +		 * pse_control_put() unlinks and frees the pse_control under
> +		 * pse_list_mutex before the PHY itself can be freed. Holding
> +		 * the mutex across the lookup and the attached_phydev
> +		 * dereference therefore keeps the PHY alive, which a
> +		 * reference on the pse_control alone would not.
> +		 */

Can you summarize this comment. It's hard to read.
Also we have the commit message that explain the why.

>  		rtnl_lock();
> +		mutex_lock(&pse_list_mutex);
> +		psec = pse_control_find_by_id(pcdev, ntf.id);
>  		netdev = pse_control_get_netdev(psec);
>  		if (netdev)
>  			ethnl_pse_send_ntf(netdev, ntf.notifs);
> +		mutex_unlock(&pse_list_mutex);
>  		rtnl_unlock();
> -		pse_control_put(psec);
>  	}
>  }
>  
> @@ -1412,6 +1421,19 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
>  
>  	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
>  		if (psec->id == index) {
> +			/* attached_phydev can only name one PHY. If a second
> +			 * one shares the PI, either may be removed first and
> +			 * leave it pointing at a freed phy_device, so stop
> +			 * reporting events for this PI instead.
> +			 */

Same here. The warn message explain already the issue.

With these changes you can add my Reviewed-by.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

