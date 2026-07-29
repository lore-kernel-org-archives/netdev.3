Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78E33123D;
	Wed, 29 Jul 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290958; cv=none; b=U43gnFeO4hNUbSuxfEMxVXdAShgUDYc8U0LVp4jUZjFUyv00fBShtp95t32zzrs5SAP65HCJCAJ0KopOhODFX10jBhdoRqDJouori7+dKnwYV03OacX3TVxUfOqKkMv3S4geiSbP1tOw3/HMsuWc4HKy/x4I1KG6JS2qFPXXoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290958; c=relaxed/simple;
	bh=lB7neo5RxkBOFzhstEaCtDv3W/7yQEMIT/To6tcyHIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6/atWZegJOwZbO3C37Ta4mWNsCAXPre/3117UZZ/4NWrAxM6r904FdBcxDGQv7jh12W5f4A+2auOCLLLMz3jtYJ5KWksY0xjFS61jE+HBS9kNK+2kco9UkHDS48LOr/2gqH28ZGFgZpvLo8iS1b5sMgKwya0W/3uwsBnGJ03lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqj6S1Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqj6S1Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637591F000E9;
	Wed, 29 Jul 2026 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290953;
	bh=f+G7iSf6YfRwZUzOh+H/HqMrcYACqwsUrANhxXySrLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqj6S1DhopDZCwQbPd6I04jE9/qoOn+IDqknEnwRC2aMdG1RMoxcQZRJUb9ruT/Ch
	 zxXM7+fJqPAAjG6s8cAZgoH90Pa2NHJY1OE29JJbXt73wZvUnL/Sz8JiDaIPVlWEU4
	 vuX9nNBhWPwTvsAzU7ahecJua+EVyWqr/hLI+C2lV51984r3WcBvgaclIbOrptgOHd
	 zmQDoQIBq1yt+Ky6jfGQG7R1hE8Gr9FQeX3FdW/79AkNiaRiDDd4cAPw2pgXw2Hfhj
	 yl3gS252cL52A7mFncQkghijVz5LiOObPzWfU2bCZ704T0F2jKgUAdTL1BccL8B5Rv
	 jiEwjvd9e3qow==
From: Jakub Kicinski <kuba@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 3/4] bnge: add ndo_set_rx_mode_async support
Date: Tue, 28 Jul 2026 19:09:12 -0700
Message-ID: <20260729020912.3657198-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724142954.3101980-4-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-4-vikas.gupta@broadcom.com>
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
--- Patch [3]: [PATCH net-next 3/4] bnge: add ndo_set_rx_mode_async support ---
commit 1fc0ed8b56a0fd5a87f788e357261a7f2693625b
Author: Vikas Gupta <vikas.gupta@broadcom.com>

bnge: add ndo_set_rx_mode_async support

This commit registers bnge_set_rx_mode() as ndo_set_rx_mode_async to
handle filter updates asynchronously. It computes UC list updates directly
from the snapshot, allowing sleepable HWRM commands without holding the
address lock.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 1e3cdaeaa03dc..e67536a8c4304 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2272,6 +2269,48 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
>  	return rc;
>  }
>  
> +static int bnge_set_rx_mode(struct net_device *dev,
> +			    struct netdev_hw_addr_list *uc,
> +			    struct netdev_hw_addr_list *mc)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_vnic_info *vnic;

[ ... ]

> +	if (dev->flags & IFF_ALLMULTI) {
> +		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
> +		vnic->mc_list_count = 0;
> +	} else if (dev->flags & IFF_MULTICAST) {
> +		mc_update = bnge_mc_list_updated(bn, &mask, mc);
> +	}
> +
> +	if (mask != vnic->rx_mask || uc_update || mc_update) {
> +		vnic->rx_mask = mask;
> +		return bnge_cfg_rx_mode(bn, uc, uc_update, true);
> +	}

[Severity: High]
If bnge_cfg_rx_mode() returns -EAGAIN, the network core schedules a retry 
timer. However, because vnic->rx_mask is eagerly updated here (and 
vnic->mc_list is mutated in-place inside bnge_mc_list_updated()), won't the 
subsequent retry falsely detect no state changes and return 0 without 
programming the hardware?

Could this leave the hardware filter state permanently desynchronized from 
the network stack?

> +
> +	return 0;
> +}

[ ... ]

> @@ -2704,7 +2743,7 @@ static int bnge_init_chip(struct bnge_net *bn)
>  		vnic->rx_mask |= mask;
>  	}
>  
> -	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
> +	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, true, false);
>  	if (rc == -EAGAIN) {
>  		netif_rx_mode_schedule_retry(bn->netdev);
>  		rc = 0;

[Severity: High]
This is a pre-existing issue, but does iterating the live netdev multicast
list earlier in bnge_init_chip() require holding netif_addr_lock_bh()?

Just above this call in bnge_init_chip(), the code evaluates:
bnge_mc_list_updated(bn, &mask, &bn->netdev->mc)

Since this happens without netif_addr_lock_bh() held, could it race with 
concurrent multicast updates (such as dev_mc_add() from IGMP/MLD timers), 
potentially leading to a use-after-free or infinite loop during list 
traversal?
