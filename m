Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEF30E84E;
	Wed, 29 Jul 2026 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290917; cv=none; b=DnI/3Wr8eD7lFVK/n8g1+3i+uzsqRUvY+p9KceLil+PPf7Nar9bRhTVdXpwgCIUFR9zC4e4a4h9q8n1+cBOLzvFd/l8cOrThtJoRmEIMk6VHD1xMHjO8W5XIQ5JORca6kqZeAy15OtEigLe9/V4SsAB0YtYhfw5NnN1JUU4NQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290917; c=relaxed/simple;
	bh=pXcQXwRNANlxZos/pqUpUZ64rJ4H/fmnYGi0VN5pTfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVzH5k6k66G7B1e75mJIr4fG7QYOyQULecMBNKX9AJzuKTtlysnx/Np1g0+4CBUF1TuVnFq3OQmS6BzXiW7IJBeQYS5AxwIDBF6TcI3Gsuu/HGt9JenZd3cSzp2FEKrotuVaEhYDEMGvQKW9r+iEPnepHSwmZYSBUyHA/FFrdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR4X4ikV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR4X4ikV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DEB1F000E9;
	Wed, 29 Jul 2026 02:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290916;
	bh=5wYPJQpiVVSHSNVQKJrms3Iwaln0D4ETC3pt6WeWZrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZR4X4ikVceBmmDLC6mE8F2p0l4YT/lP4ADPypIrfLfZKsj4dFVdrHjlCLRVSZ3a+r
	 SASoajDOZzv4MKJw2OfznSw/aTr6AM3NqFE7syD+QgtCUQfknLe/z9dEM+LCqfJuiZ
	 zZhpnn7UklNBv2uCGiQZ60hoJtVPKYHrFBVCMPiGMRO8tL6IlhPJLnvhGFaNj8EZFm
	 6xylOaSVjyqqKjdtXbfyjpQvI4zRc/SYmmmOk0yqjWRra1aCa0mHCxEi9ZnnyqemmM
	 SzwIqu1scWhN+7/+4KYh4XEl0mq0VB6rRxdl6myJp5zcfK6RIuCTYuJ5PSyOi8RP96
	 UV52IrJgndg7w==
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
Subject: Re: [PATCH net-next 2/4] bnge: refactor rx mode helpers to accept explicit address lists
Date: Tue, 28 Jul 2026 19:08:26 -0700
Message-ID: <20260729020826.3656355-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724142954.3101980-3-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-3-vikas.gupta@broadcom.com>
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
bnge: refactor rx mode helpers to accept explicit address lists

This patch renames bnge_cfg_def_vnic() to bnge_cfg_rx_mode(), threads
explicit netdev_hw_addr_list pointers through the mc/uc helpers, adds a
snapshot flag to skip netif_addr_lock_bh(), and treats -EAGAIN from
bnge_hwrm_set_vnic_filter() on the open path as a scheduled retry
instead of an open failure.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 6f7ef506d4e1..1e3cdaeaa03d 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2201,7 +2201,8 @@ static bool bnge_promisc_ok(struct bnge_net *bn)
>  	return true;
>  }
>  
> -static int bnge_cfg_def_vnic(struct bnge_net *bn)
> +static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
> +			    bool snapshot)
>  {

[ ... ]

> @@ -2226,22 +2225,28 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)

[ ... ]

>  	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
>  		rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
>  		if (rc) {
> -			netdev_err(dev, "HWRM vnic filter failure rc: %d\n", rc);
> +			if (rc == -EAGAIN)
> +				netdev_warn(dev, "FW busy while setting vnic filter, will retry\n");
> +			else
> +				netdev_err(dev, "HWRM vnic filter failure rc: %d\n",
> +					   rc);
>  			vnic->uc_filter_count = i;
>  			return rc;
>  		}
>  	}

[Low]
The commit message says the -EAGAIN retry handles the case coming from
bnge_hwrm_set_vnic_filter(), but bnge_cfg_rx_mode() can also return
-EAGAIN from the trailing bnge_hwrm_cfa_l2_set_rx_mask() calls (via
HWRM_ERR_CODE_BUSY translated in bnge_map_hwrm_error()).

In that second path the driver still logs:

    netdev_err(dev, "HWRM cfa l2 rx mask failure rc: %d\n", rc);

while the caller in bnge_init_chip() silently converts the same rc to 0
and schedules a retry.

Is the intent to retry only vnic-filter -EAGAINs, or any -EAGAIN out of
bnge_cfg_rx_mode()?  If the broader scope is intentional, would it be
worth aligning the log message (and the commit description) so the
netdev_err isn't emitted for a case the caller treats as a soft retry?

> @@ -2695,13 +2700,17 @@ static int bnge_init_chip(struct bnge_net *bn)
>  	} else if (bn->netdev->flags & IFF_MULTICAST) {
>  		u32 mask = 0;
>  
> -		bnge_mc_list_updated(bn, &mask);
> +		bnge_mc_list_updated(bn, &mask, &bn->netdev->mc);
>  		vnic->rx_mask |= mask;
>  	}
>  
> -	rc = bnge_cfg_def_vnic(bn);
> -	if (rc)
> +	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
> +	if (rc == -EAGAIN) {
> +		netif_rx_mode_schedule_retry(bn->netdev);
> +		rc = 0;
> +	} else if (rc) {
>  		goto err_out;
> +	}
>  	return 0;

[Medium]
When bnge_hwrm_set_vnic_filter() returns -EAGAIN, bnge_cfg_rx_mode()
returns immediately from inside the uc-filter loop:

    for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
        rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
        if (rc) {
            ...
            vnic->uc_filter_count = i;
            return rc;
        }
    }

so control never reaches the skip_uc: label and
bnge_hwrm_cfa_l2_set_rx_mask() is never called.  The vnic->rx_mask bits
assembled just above (IFF_BROADCAST / IFF_MULTICAST / IFF_PROMISC /
ALL_MCAST) are therefore not pushed to firmware.

bnge_init_chip() then converts the -EAGAIN to rc = 0 and calls
netif_rx_mode_schedule_retry(), so the open succeeds and the interface
comes up IFF_UP.

The retry timer eventually fires netif_rx_mode_run(), which dispatches
via ops->ndo_set_rx_mode_async / ops->ndo_set_rx_mode.  At this commit,
bnge_netdev_ops registers neither callback, so the retry is a no-op and
the device stays with no broadcast / multicast / promisc filters
programmed until something else re-triggers rx-mode configuration.

Should this patch either fail the open on -EAGAIN, or be ordered after
the ndo_set_rx_mode_async wiring so the scheduled retry actually
re-invokes bnge_cfg_rx_mode()?  The follow-up commit
"bnge: add ndo_set_rx_mode_async support" (fad0f7d4f3b6) does add
.ndo_set_rx_mode_async = bnge_set_rx_mode, which closes the gap only
after this patch lands.
-- 
pw-bot: cr
