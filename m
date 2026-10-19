Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15964A2A75;
	Mon, 19 Oct 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399875; cv=none; b=ljCHSKajDLcp23WzMXDbYYHP1++s0mvz3Dymf0NyJJcrxiNkox7uiaqV7ptE6KSFFZsOpIGgUNZ9Dsefwv/WZDJfT8m5JWQ9sHUeKktA7PslSQ+omTS1zMpf3h/80eGvp2ryhuewb5flFpCqKxw2TPOdpJSCCq4Q7znxYGtroQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399875; c=relaxed/simple;
	bh=Asb+h8bKamHyyIqCPskXAxBTaMoNR5mlUu/M1GxSLuk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cy2U+tNz1R2RigbVG2ZFfOFFpWyV4vyPse2O9ehXbMSQ7Epzz6KP0BTD4y3L8eW16FRiEPsJhdmkvcS7sMUrzxagwv1iNT+YUDrD9MtgEOkSds3AHVtrFH4+cH4QpQngt5UZGw+P7uLhlD3iIKorAeANMJrr1QLAMRpQ1wNSI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgQejHtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgQejHtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784461F000C6;
	Mon, 19 Oct 2026 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399873;
	bh=7C+XIg1Nh5v55mp+ZHlfr+JOF1pd97so8IrLiGCUNRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FgQejHtIzIf2ZlclI6AwlVOe1pAkOs4hR7I9nqDJQquYsx28ZMXGszVeGsOlrrCbj
	 sY8YfDhDNyaCSG9FVXLyLpAj/NBZ29JLzBBp5T7G8+/W2XBDNlQicgkpM83OKH4t6h
	 Ol7Ac3QxiIMiIioSZ56iolPCWBHmk0WSxKvA1iAtjqWmSnY1I3s7VXT5Regy27cG1R
	 1dmFOP+9UdaXq6cgVkAtu97Mdw4h6vPKmvUwZ2WS5txtIeQARi7mqrFTJNxC9yG+71
	 UTX0R3vPOANyh9l3Duk5om4QBsI/ZTsMrBrAMf4qXY2iPh7LdT4WhMnjbaYaMcSRVB
	 GllVK6PnWQgag==
Subject: Re: [PATCH net 04/10] net: pse-pd: do not reach a freed PHY from the
 notification worker
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 piotr.kubik@adtran.com, saikrishnag@marvell.com, horms@kernel.org,
 kyle.swenson@est.tech, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:51:12 +0000
Message-ID: <179239987207.3135.17141454695480717442@kernel.org>
In-Reply-To: <20261018082314.48950-5-github@szelinsky.de>
References: <20261018082314.48950-5-github@szelinsky.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comment this patch adds to pse_send_ntf_worker()
  (drivers/net/pse-pd/pse_core.c, lines 1022-1028) says: "A pse_control…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  phy_device_remove() (drivers/net/phy/phy_device.c:1155) calls…

--

net: pse-pd: do not reach a freed PHY from the notification worker

The notification worker used to take a reference on the pse_control. It
now looks up the pse_control under pse_list_mutex and uses
attached_phydev under that mutex, so a removed PHY cannot be reached. If
a second PHY takes a pse_control for a shared PI, attached_phydev is
cleared and a warning is printed.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 65a41c517b359..336f00d82b5f8 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -1020,13 +1019,21 @@ static void pse_send_ntf_worker(struct work_struct *work)
>  		struct net_device *netdev;
>  		struct pse_control *psec;
>  
> -		psec = pse_control_find_by_id(pcdev, ntf.id);
> +		/* A pse_control is only on the list while the PHY it was
> +		 * handed to holds it: the PHY's pse_control_put() unlinks
> +		 * and frees it under pse_list_mutex before the PHY itself
> +		 * can be freed. Holding the mutex across the lookup and the
> +		 * attached_phydev dereference therefore keeps the PHY alive,
> +		 * which a reference on the pse_control alone would not.
> +		 */

[Severity: Low]
This comment says a pse_control is only on the list while the PHY it was
handed to holds it, and that the PHY's pse_control_put() unlinks and frees
it. Does that hold when two PHYs share a PI?

In that case pse_control_get_internal() returns the existing psec after
kref_get(). The unlink and free only happen on the last put:

drivers/net/pse-pd/pse_core.c:__pse_control_release() {
    ...
	list_del(&psec->list);
	kfree(psec);
}

So the first PHY's phy_device_remove()->pse_control_put() only drops the
refcount. The psec stays on pcdev->pse_control_head after that PHY can be
freed.

The worker is still safe today, but only because
pse_control_get_internal() clears psec->attached_phydev when a different
PHY takes the psec. The comment gives list membership as the reason and
does not mention that dependency.

Could the comment say that it relies on attached_phydev being cleared in
the shared-PI case? Later patches in the series leave this comment
unchanged.

[ ... ]

> @@ -1417,6 +1424,19 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
>  
>  	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
>  		if (psec->id == index) {
> +			/* attached_phydev can only name one PHY. If a second
> +			 * one shares the PI, either may be removed first and
> +			 * leave it pointing at a freed phy_device, so stop
> +			 * reporting events for this PI instead.
> +			 */
> +			if (psec->attached_phydev &&
> +			    psec->attached_phydev != phydev) {
> +				dev_warn(pcdev->dev,
> +					 "PI %u shared by several PHYs, not reporting its events\n",
> +					 index);
> +				psec->attached_phydev = NULL;
> +			}
> +
>  			kref_get(&psec->refcnt);
>  			return psec;
>  		}

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. This
patch relies on the pse_control_put() in phy_device_remove(). Does that
call leave phydev->psec dangling?

drivers/net/phy/phy_device.c:phy_device_remove() {
	unregister_mii_timestamper(phydev->mii_ts);
	pse_control_put(phydev->psec);

	device_del(&phydev->mdio.dev);
    ...
}

With the usual one PHY per PI, this put drops the last reference and
__pse_control_release() does list_del() and kfree(psec). phydev->psec is
never set to NULL.

The phy_device can outlive phy_device_remove(), because
phy_attach_direct() holds get_device() on it. The MAC<->PHY device_link
is DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS, so the MAC is not unbound.
phy_remove() also does not detach the netdev. After the MDIO bus is
unregistered or unbound under an attached MAC, netdev->phydev still
points at a phy_device whose psec has been freed.

ETHTOOL_MSG_PSE_GET does not need admin permissions, and it reaches:

pse_prepare_data()
  pse_get_pse_attributes()
    pse_ethtool_get_status(phydev->psec, ...)

net/ethtool/pse-pd.c:pse_get_pse_attributes() {
    ...
	if (!phydev->psec) {
		NL_SET_ERR_MSG(extack, "No PSE is attached");
		return -EOPNOTSUPP;
	}
    ...
	return pse_ethtool_get_status(phydev->psec, extack, &data->status);
}

Can this dereference the freed pse_control? The PSE SET handlers in
net/ethtool/pse-pd.c appear to follow the same pattern.

There may also be a race during removal. pse_control_put() in
phy_device_remove() runs without rtnl, but the ethtool handlers read
phydev->psec under rtnl. Could a concurrent PSE_GET or PSE_SET use the
psec while it is being freed?

Would clearing phydev->psec after the put, synchronized with the
rtnl-protected readers, address both cases? The pse_control_put() call in
phy_device_remove() dates back to commit 5e82147de1cbd7 in 2022. No later
patch in this series touches phy_device_remove() or the ethtool PSE
handlers.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018082314.48950-1-github%40szelinsky.de
