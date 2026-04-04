Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01B256D
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261169; cv=none; b=G2L5pAyKnmHXkVOBrYO34PcnrPNS8yQn++x9zHuq1zgJ+W2uP5I1MqNTQ6unrnfx8OdNuxT5ym14xjPW7dbxzZYYqizyP+vMQVcK24BfXaL3BKeMOwbC0AqhrWtcHCrisbMk6yKlMj7ykMyeka4HaOI7rjLHZonbQBPk3QQyOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261169; c=relaxed/simple;
	bh=9yRl/QjP7hWqp9A6Nnf2BmoDZGn/crZ/n+N9hj+ArWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fter3mwoBx9L5LRICc4zpzUeCbkYGEnRimIAT9khO3MBux/snnUw5YqJY6O4TDGAuNIGN+r219e/xXHDGOIulQ3rLwb0rdGpuxa73sDnXrUWYytT9VNOuf4BayC9hqN1wnD63N7p4JqzndDMqv8gXLj2w2449oyyK0Zv4N5mB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP/bEWxH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP/bEWxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94DDC4CEF7;
	Sat,  4 Apr 2026 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261169;
	bh=9yRl/QjP7hWqp9A6Nnf2BmoDZGn/crZ/n+N9hj+ArWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SP/bEWxHciIEpRRsVGYJlwEioTAhyJRvslJlonCrFQKYvJ02CLGoD82TT1GSPVQbv
	 XnhPcbFbP6Em7X7tJoCSV9YpAg9mPcBaYMYzHYLHRKHjgRSWovDmuiCAuuuNcA8CAt
	 NNC+0yaPz8BRCpoV/ppNHOLWT+pmHvnl9wLYWSKrSWO776xoifTjiwA+veSYwSzg+I
	 rRrBbp/IU+FfC3Fnf4uzAmIFV3jz37ojumLNuGkB15soXdvHhOq49aEmJIk8JhEut4
	 EMoiJVKOgrsvipfrTRMZ8OwQfBx13q8aAlju06mEbgHff1vwVKb/g7OqCYHQRe29uC
	 BguLndYS92Wtw==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 05/14] fbnic: convert to ndo_set_rx_mode_async
Date: Fri,  3 Apr 2026 17:06:08 -0700
Message-ID: <20260404000608.2414015-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-6-sdf@fomichev.me>
References: <20260402225535.4124525-6-sdf@fomichev.me>
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
fbnic: convert to ndo_set_rx_mode_async

Convert fbnic from ndo_set_rx_mode to ndo_set_rx_mode_async, updating
the driver to take explicit uc/mc lists and using __hw_addr_sync_dev()
on the snapshots instead of __dev_uc_sync() on the netdev directly.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index b4b396ca9bce3..c406a3b56b37f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
[ ... ]
> @@ -213,10 +215,10 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
>  	}
>  
>  	/* Synchronize unicast and multicast address lists */
> -	err = __dev_uc_sync(netdev, fbnic_uc_sync, fbnic_uc_unsync);
> +	err = __hw_addr_sync_dev(uc, netdev, fbnic_uc_sync, fbnic_uc_unsync);
>  	if (err == -ENOSPC)
>  		uc_promisc = true;
> -	err = __dev_mc_sync(netdev, fbnic_mc_sync, fbnic_mc_unsync);
> +	err = __hw_addr_sync_dev(mc, netdev, fbnic_mc_sync, fbnic_mc_unsync);

Since __fbnic_set_rx_mode() performs read-modify-write operations on the
internal fbd->mac_addr array and updates the device TCAM, is there a need
for internal synchronization?

It appears that concurrent out-of-band callers like fbnic_bmc_rpc_check()
(from an unlocked workqueue), RTNL paths like fbnic_set_mac(), and the async
RX mode workqueue can race on the internal fbd->mac_addr array and interleave
writes to the hardware, potentially breaking the RX filtering rules.

>  	if (err == -ENOSPC)
>  		mc_promisc = true;
[ ... ]
> @@ -257,7 +262,8 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
>  
>  	eth_hw_addr_set(netdev, addr->sa_data);
>  
> -	fbnic_set_rx_mode(netdev);
> +	if (netif_running(netdev))
> +		__fbnic_set_rx_mode(fbn->fbd, &netdev->uc, &netdev->mc);

Is it safe to pass the live &netdev->uc and &netdev->mc address lists to
__hw_addr_sync_dev() without holding netif_addr_lock_bh() or rtnl_lock()?

This bypasses the core network stack's lock, which could lead to list
corruption and use-after-free if the network stack concurrently modifies
the address lists (e.g., via dev_mc_add()).

Additionally, doesn't manually mutating sync_cnt on the live lists bypass
the core's snapshot reconciliation state machine?

>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index e3aebbe3656d5..6b139cf542567 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
[ ... ]
> @@ -180,7 +180,7 @@ static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
>  	}
>  
>  	fbnic_rpc_reset_valid_entries(fbd);
> -	__fbnic_set_rx_mode(fbd);
> +	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);

Similarly here, fbnic_fw_config_after_crash() appears to be executed from the
unlocked fbnic_service_task workqueue. Could this cause lockless data races on
the live network stack lists?

>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index 42a186db43ea9..fe95b6f696463 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
[ ... ]
> @@ -244,7 +244,7 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
>  
>  	if (fbd->fw_cap.need_bmc_tcam_reinit) {
>  		fbnic_bmc_rpc_init(fbd);
> -		__fbnic_set_rx_mode(fbd);
> +		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);

And here as well, passing live address lists without synchronization.
