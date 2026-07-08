Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CF37F8CC;
	Wed,  8 Jul 2026 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529057; cv=none; b=pD9kNqTxqsJNrA4l2SY5M6P5BL2egknrWzONIAPWSxwBkdh7rvSxw3Ojww3bAOmJzLqBcHrrooczIK8cNDzW+Cfp7ZSyN9v7xcxlPPiadATGe5oa2rQEOewO/4LDgkvRAvg9fcJ/SnRKdp95IFPJ6s0qGApZ4YwsQNFj6xLEoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529057; c=relaxed/simple;
	bh=VcUVjiOVc8mwr/NtJmaRl2FUsP/yL1eklMGuJODXgHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+uICe4WyGKPpZtmwd6i4bt5/3heD9uU7SrafKnc/EXY9tBB97iQLb/kXYKVLs/5WqNrKPFtmZa9Rskuc6dmPDt2ikg8A4K1F5nZb/S6QFZgwT+LE/fo7pwAqqF+QjhDqicAxvz6zIHTN7H7XsTaBruA0C5YLiH+NJHGFuCHQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9yOzdzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9yOzdzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2CE1F000E9;
	Wed,  8 Jul 2026 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529051;
	bh=J1xcrdQPqVs3L3vusvyuph47aQZgLV0cNEClaNvp8Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9yOzdztxUr397XdBMFyNRhzPZSFCwtB+/dj4wMCUvMs26oRJH92UIPUHlwbNW/xg
	 QfGdwOBS8cQCuzPoFSvEoGAdk7uNwTzb0xK6f2lVUrDY6H73vfbZ9cKaxVbh3d0z6U
	 4zS38+r/xeHyumaN45q3dUffsFErxZG6GrCx8UX/byDT5rgfZE47sWapxxdvRLkqQy
	 TGWEIY2Vy30U+T7GXah+OHHxRm7aMMS8iOkmKfx8/9K0XmfuD9L7UjCxIai9O23Eoq
	 4abdr/ACo89mmBkeqeTm/k40aOzFpAF1DkKqadOUxqOUDLmgh0/Kn+b0jHPrpHRp82
	 c9JDzn25ZK8Rg==
From: Simon Horman <horms@kernel.org>
To: t.martitz@fritz.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] macvlan: allow source mode devices along with passthru
Date: Wed,  8 Jul 2026 17:43:50 +0100
Message-ID: <20260708164350.1513604-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065642.1783764-2-t.martitz@fritz.com>
References: <20260702065642.1783764-2-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
macvlan: allow source mode devices along with passthru

This allows for configurations where there are a few
known senders in the system (e.g. multiple SoCs on the same
board) along with unlimited external senders.

> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index c40fa331836bb..d28f9d905a84d 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c

[ ... ]

> @@ -1523,10 +1514,30 @@ int macvlan_common_newlink(struct net_device *dev,
>  	if (data && data[IFLA_MACVLAN_FLAGS])
>  		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>  
> +	/* Only 1 macvlan device can be created in passthru mode. There may be
> +	 * additional source mode devices but nothing else at the moment.
> +	 *
> +	 * First check if adding a source mode device to an existing passthru vlan.
> +	 */
> +	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
> +		/* The macvlan port must be not created this time,
> +		 * still goto destroy_macvlan_port for readability.
> +		 */
> +		err = -EINVAL;
> +		goto destroy_macvlan_port;
> +	}

[Severity: High]
While macvlan_common_newlink() prevents creating non-SOURCE devices on a
passthru port, macvlan_changelink() does not seem to have a similar check.

Can a user bypass this restriction by creating a SOURCE device and then using
changelink to modify its mode to VEPA, bypassing MAC isolation?

[Severity: High]
With source devices and passthru devices now coexisting on the same port,
functions like macvlan_open(), macvlan_stop(), and macvlan_sync_address()
check the port-wide macvlan_passthru(vlan->port) flag instead of the device
mode.

If a user brings down a SOURCE device on a passthru port, will macvlan_stop()
incorrectly take the passthru teardown path? This appears to skip dev_uc_del()
and call dev_set_promiscuity(..., -1) for a device that never incremented it.

> +
> +	/* Now check if adding a passthru device to an existing set of source mode
> +	 * devices.
> +	 */
>  	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
> -		if (port->count) {
> -			err = -EINVAL;
> -			goto destroy_macvlan_port;
> +		struct macvlan_dev *p;
> +
> +		list_for_each_entry(p, &port->vlans, list) {
> +			if (p->mode != MACVLAN_MODE_SOURCE) {
> +				err = -EINVAL;
> +				goto destroy_macvlan_port;
> +			}
>  		}
>  		macvlan_set_passthru(port);

[Severity: High]
If a PASSTHRU device is deleted while SOURCE devices still exist on the port,
macvlan_uninit() decrements port->count but does not clear MACVLAN_F_PASSTHRU.

Does this leave the port in a permanently broken state where new PASSTHRU
devices cannot be created, and remaining SOURCE devices continue to be
mistakenly treated as passthru?

>  		eth_hw_addr_inherit(dev, lowerdev);
