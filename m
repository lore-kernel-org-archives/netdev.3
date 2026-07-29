Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE723203B6;
	Wed, 29 Jul 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290958; cv=none; b=aB5MsVA/lqO8LaFKfCOYshBLft5Vwqer1485r/J9Bu1bAPIYUdiE2U8lXcNg0ec5bHdRQTcNzV2KoMFTLjljlY8hg28s5/htLKr+Bp3x6avI09GTIwg1FNJ6xxQD/V50w6AvU3a7pHj/BSvm6e7WErk4KfAmKSThTDYyYsQrYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290958; c=relaxed/simple;
	bh=7eswSE9MXB/DhO5eCcOv32h0QMwFX/MAvbivHt826kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqlkj6aJSb0gTSlfwNLnLmTNAbht/ItNcKGDriDb5WB+5Wq06wp7/B7sR5M1LUbzmbAzD8Fp2mm3znkNbcZbRjPi0V+vVqHG/SKf1XoTKiEoxNbW9r+SDMxl+/is35WJn+qDMOZX877UvrCP5182rR7yCwMXv5lkjLLm8X4I/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz58T//w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz58T//w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBA21F00A3A;
	Wed, 29 Jul 2026 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290955;
	bh=A5+i8IWHA3N/GIziVbV57tb9APAV6pu3sfvRxvE2tmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hz58T//wbHg1NPHGz9tsNUNSXPch53sCnu5Z3mKbgzICETQWfvGOa1k4uzlFqy/S4
	 zZg9evyuNx3Sa2bw+CS1gm6PLiOhGQ8pCp4Bek3uL/xOZXIR91nOc2CxzfXx8YNk00
	 62Sn9AbaT4ciav6wiGWJ1fy9sc0RUaBwPQowcsxKLzf+K2H28H1xlR3GupcoOjS7f3
	 LkrKY1GGgW7u0zh1ZXQPRt+AsgGk1T+wMBM/9rBMhNpX/GgjLIcG1d0CcI1hVA+bMN
	 Pnd/i03gQmfTNAQZKktzGeb61sqIloctfw8Fhbr40CXSwQGXTwMIPa5CPNiOt20IEv
	 yEQAUYv+CFPiw==
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
Subject: Re: [PATCH net-next 4/4] bnge: send hwrm for interface down/up transitions
Date: Tue, 28 Jul 2026 19:09:14 -0700
Message-ID: <20260729020914.3657232-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724142954.3101980-5-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-5-vikas.gupta@broadcom.com>
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
--- Patch [4]: [PATCH net-next 4/4] bnge: send hwrm for interface down/up transitions ---
commit d98cba7c642aee81ff9e1c8c6042d1e9dc822e87
Author: Vikas Gupta <vikas.gupta@broadcom.com>

bnge: send hwrm for interface down/up transitions

Firmware expects HWRM_FUNC_DRV_IF_CHANGE on interface down/up
transitions to coordinate resource management.
Add bnge_hwrm_if_change() to send this notification.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index e67536a8c4304..220bdcced0db9 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
[ ... ]
> @@ -2861,6 +2862,24 @@ static void bnge_tx_enable(struct bnge_net *bn)
>  		netif_carrier_on(bn->netdev);
>  }
>  
> +static int bnge_hwrm_if_change(struct bnge_dev *bd, bool up)
> +{
> +	struct hwrm_func_drv_if_change_input *req;
> +	int rc;
> +
> +	if (!(bd->fw_cap & BNGE_FW_CAP_IF_CHANGE))
> +		return 0;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_IF_CHANGE);
> +	if (rc)
> +		return rc;
> +
> +	if (up)
> +		req->flags = cpu_to_le32(FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP);
> +
> +	return bnge_hwrm_req_send(bd, req);

[Severity: Medium]
Is a retry mechanism needed here for transient firmware errors?

This function directly returns the result of the HWRM send instead of executing
a retry loop. If the firmware returns a transient error (like -EAGAIN), the
network interface might spuriously fail to open.

In teardown paths, could a single un-retried failure result in asymmetric
driver and firmware lifecycle states, where the driver tears down but the
firmware remains 'UP'?

> +}
> +
[ ... ]
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> index d177919c2e117..a1a939496ebd3 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> @@ -275,6 +275,8 @@ enum bnge_net_flag {
>  	BNGE_FLAG_PORT_STATS_EXT	= BIT(1),
>  };
>  
> +#define BNGE_FW_IF_RETRY	10

[Severity: Medium]
Should BNGE_FW_IF_RETRY be used in bnge_hwrm_if_change()?

This retry limit constant is defined here but doesn't appear to be used
anywhere in the implementation.

> +
>  enum bnge_sp_event {
>  	BNGE_LINK_CHNG_SP_EVENT,
>  	BNGE_LINK_SPEED_CHNG_SP_EVENT,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential data race
during multicast list traversal in bnge_init_chip().

In drivers/net/ethernet/broadcom/bnge/bnge_netdev.c, bnge_init_chip() calls
bnge_mc_list_updated() and passes the live multicast list without acquiring
netif_addr_lock_bh():

bnge_init_chip()
    ...
    bnge_mc_list_updated(bn, &mask, &bn->netdev->mc);

Inside bnge_mc_list_updated(), the list is traversed:

    netdev_hw_addr_list_for_each(ha, mc) {
    ...

If dev->mc is concurrently modified (for example, via dev_mc_add() from a
softirq context handling IPv6 MLD/ND), could the list pointers be corrupted
during traversal? Should netif_addr_lock_bh() be held here?
