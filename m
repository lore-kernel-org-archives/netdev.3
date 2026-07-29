Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535233BBC5;
	Wed, 29 Jul 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290954; cv=none; b=J+EYJqIFIGJvQNr5DbPPpuJtrbjnNd2AnVWxvuB/7VgasD1a9dwB8KI+Ztqnrjrmi55RiK35casf/vHeZptEJZyC7PawYpoKlef1Cu9mHDAtC7erIpiWfC+cwYxuc0D48beUGIoRHaRMVe1rrKNtDbnt3eT4dQ1NAZaLBgQDWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290954; c=relaxed/simple;
	bh=TViW4i1059NbO8ic+hGNj1vguTGRas3fvmEtConn5Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRXOZph5LfPaiBkdAgrBXJKEkZIC0TaeoNAWXtlbntia/m6MCGxMOf0Om6aTlx/TJtZMWpv/6Bh0rdbLDqkPpfWK8aKOkiRYWYKBiN6JZeUePLHjdaEQIVmFwwjb8Q6N3kbOVeUHOmZESa+mPnlXijbH09YV3/3G+lNzQ8rIbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqqDioe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqqDioe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EEE1F00A3A;
	Wed, 29 Jul 2026 02:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290952;
	bh=OOmU1QGzB2ufpHut7Us3n0z+1f9VoAWQEgbxI9wn3M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eqqDioe4nrENHNUdQO015+tqGpP/7uhAJJpewFiF7msuRpbocM60E+k9v+2ePNixO
	 3XeQjIMEMqRviGvwr/o5la2T+cVH06W3l+mIj5HjkF60bphf/2eyYeVDO1uNekTUnF
	 0WifSgTwadyV2Qcr0R2GsY+6Ztls9ipQ/PZcuanwJMZ8dwU7GjMyveaRkxJye2pQ5S
	 +LZqls9GUlHDKiRHEkD74NaAfUKzmF2SJLYjz7rveh1XN0k8/S4WTOnNtGB5Hip1v9
	 nlEE2FodQhxeM72hP+NfOl9PS22hQTZ68EPtIWL/WdXpU3npnSEeLzspiht5AaaZ7l
	 tRyXzfeKu3eLA==
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
Date: Tue, 28 Jul 2026 19:09:11 -0700
Message-ID: <20260729020911.3657160-1-kuba@kernel.org>
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
--- Patch [2]: [PATCH net-next 2/4] bnge: refactor rx mode helpers to accept explicit address lists ---
commit 89173081c7d6c9342e8bf0ec4661f5150e6862c9
Author: Vikas Gupta <vikas.gupta@broadcom.com>
bnge: refactor rx mode helpers to accept explicit address lists

This patch refactors bnge_cfg_def_vnic() to bnge_cfg_rx_mode() and updates
the MC/UC list update functions to take explicit address lists. It adds a
snapshot parameter to optionally skip acquiring netif_addr_lock_bh(), and
schedules a retry if bnge_hwrm_set_vnic_filter() returns -EAGAIN.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 6f7ef506d4e18..1e3cdaeaa03dc 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -2144,16 +2144,16 @@ static int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
>  	return rc;
>  }
>  
> -static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask)
> +static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask,
> +				 const struct netdev_hw_addr_list *mc)
>  {
>  	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
> -	struct net_device *dev = bn->netdev;
>  	struct netdev_hw_addr *ha;
>  	int mc_count = 0, off = 0;
>  	bool update = false;
>  	u8 *haddr;
>  
> -	netdev_for_each_mc_addr(ha, dev) {
> +	netdev_hw_addr_list_for_each(ha, mc) {
>  		if (mc_count >= BNGE_MAX_MC_ADDRS) {

[ ... ]

> @@ -2201,7 +2201,8 @@ static bool bnge_promisc_ok(struct bnge_net *bn)
>  	return true;
>  }
>  
> -static int bnge_cfg_def_vnic(struct bnge_net *bn)
> +static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
> +			    bool snapshot)
>  {
>  	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
>  	struct net_device *dev = bn->netdev;
> @@ -2210,9 +2211,7 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
>  	int i, off = 0, rc;
>  	bool uc_update;
>  
> -	netif_addr_lock_bh(dev);
> -	uc_update = bnge_uc_list_updated(bn);
> -	netif_addr_unlock_bh(dev);
> +	uc_update = bnge_uc_list_updated(bn, uc);

[Severity: High]
Does this code introduce a data race or list corruption?

The function bnge_cfg_rx_mode() is called with the live unicast list, but the
lock is only acquired later in the function. Since this patch removed
netif_addr_lock_bh() around the call to bnge_uc_list_updated(), the list
traversal inside bnge_uc_list_updated() is completely unprotected.

If there are concurrent modifications to the unicast list (e.g., via
dev_uc_add()) while the interface is being initialized, won't this race
cause a crash on poisoned list pointers?

>  
>  	if (!uc_update)
>  		goto skip_uc;

[ ... ]

> @@ -2695,13 +2700,17 @@ static int bnge_init_chip(struct bnge_net *bn)
>  	} else if (bn->netdev->flags & IFF_MULTICAST) {
>  		u32 mask = 0;
>  
> -		bnge_mc_list_updated(bn, &mask);
> +		bnge_mc_list_updated(bn, &mask, &bn->netdev->mc);

[Severity: High]
This isn't a bug introduced by this patch, but does this traverse the live
multicast list without holding netif_addr_lock_bh()?

Concurrent network stack operations (like IGMP/MLD processing triggering
dev_mc_add()) can modify this list while the device is opening, potentially
leading to a race and crash.

>  		vnic->rx_mask |= mask;
>  	}
>  
> -	rc = bnge_cfg_def_vnic(bn);
> -	if (rc)
> +	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
> +	if (rc == -EAGAIN) {
> +		netif_rx_mode_schedule_retry(bn->netdev);

[Severity: High]
If bnge_cfg_rx_mode() returns -EAGAIN, this handles the error by scheduling
a retry mechanism via netif_rx_mode_schedule_retry().

However, since this driver does not implement .ndo_set_rx_mode or
.ndo_set_rx_mode_async in bnge_netdev_ops, will the scheduled retry worker
(netif_rx_mode_run()) silently return without doing anything?

If so, won't this leave the device permanently without proper receive filters,
leading to dropped traffic?

> +		rc = 0;
> +	} else if (rc) {
>  		goto err_out;
> +	}
>  	return 0;
>  
>  err_out:
