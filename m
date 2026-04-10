Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F820B22;
	Fri, 10 Apr 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789842; cv=none; b=ScdDEMufcj+nSD/tYVJRjpZMJnCZz2UEa3RHwb2YlUM179RAOz++FKSZd+CDbNMFqZEevBifn1uAaXf5ajTFgkQ3zv0xOVxDqZecybFUzba7Q8yGhQvS6E73zdpnwUFs2cSE7iI6sOVYxebeJb5+Qt9vuoG2RjnAXUpPwdYT62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789842; c=relaxed/simple;
	bh=L6wszwS8qFkzeqIRGzk3Bj9pcAOHKFzChEeUvPEdrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnwPpP25wzHN4bKH+n0f+/1QbfTxT71mMlkXHNetlV5sz9gBdlooOYo3YG9cVfIVx95ODtt4YxrH/cR0jTQFG7mj6L0a0cVFb2p/6tj6yRDnUVzxwIH9q0/gLj3tHyPubPk+Fm+S2hTrTwLqX65GGeNfutQJKyf68dmPQQ13td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unC8irle; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unC8irle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743D1C4CEF7;
	Fri, 10 Apr 2026 02:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789842;
	bh=L6wszwS8qFkzeqIRGzk3Bj9pcAOHKFzChEeUvPEdrVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unC8irle7Z3WU/wQW+tQG3kvvhONwihsBJSpZ61ZtOgJMg9y5hpsgn9k+vJYEcT+c
	 HYnfv4g5AcYBdjEkZdN/iLtFLVzOfn3zTaOYEjxRj1RKujkw18nUmpDqnYRS+C4msc
	 cuh9JKjZta34u229RaBwakIw166xI1ktxuAkvyLaSNYGIfYh9yFd4oe5pKhUm5eyqI
	 Byl9p1++5upj/hfB36VMkud/RZJ0jr9TG70WXdJi6q9pIyE/4v0SKCnmWr8e08WRjv
	 LWTkLaANz/OuTlTanVHD2TpMaUj3nL5RqWBeGHwF4cv6faXsaVtlN155Li1VR129D2
	 2CbU6tOPE5cuA==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] net: airoha: Set PPE cpu port for GDM2 if loopback is enabled
Date: Thu,  9 Apr 2026 19:57:20 -0700
Message-ID: <20260410025720.1809934-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-2-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-2-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "For your consideration."
---
net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct

This commit moves the airoha_qdma pointer from the airoha_gdm_port struct
to the airoha_gdm_dev struct. This ensures the QDMA block used depends on
the specific net_device WAN/LAN configuration.

[ ... ]

> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -1497,9 +1498,10 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
>  	}
>  }
>  
> -static void airoha_update_hw_stats(struct airoha_gdm_port *port)
> +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_eth *eth = port->qdma->eth;
> +	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_eth *eth = dev->eth;
>  	u32 val, i = 0;
>  
>  	spin_lock(&port->stats.lock);

This isn't a bug introduced by this patch, but does this spin_lock()
carry a deadlock risk?

Because ndo_get_stats64() can be called from atomic context (e.g., from a
softirq), if a process context caller holds port->stats.lock and is
interrupted by a softirq on the same CPU that also triggers dev_get_stats(),
the softirq could spin forever waiting for the lock.

Should this be upgraded to spin_lock_bh() to ensure local softirqs are
disabled during the critical section?

[ ... ]

> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -534,12 +534,12 @@ struct airoha_qdma {
>  
>  struct airoha_gdm_dev {
>  	struct airoha_gdm_port *port;
> +	struct airoha_qdma *qdma;
>  	struct net_device *dev;
>  	struct airoha_eth *eth;
>  };
>  
>  struct airoha_gdm_port {
> -	struct airoha_qdma *qdma;
>  	struct airoha_gdm_dev *dev;
>  	int id;

This isn't a bug introduced by this patch, but since the qdma pointer
is being moved to better align with the hardware structure, should 
qos_sq_bmap, cpu_tx_packets, and fwd_tx_packets be moved to 
struct airoha_qdma as well?

Because QDMA1 is shared by all WAN ports (GDM 2, 3, 4) and qos_sq_bmap
is currently tracked per-port instead of per-QDMA, each WAN port 
independently allocates QDMA1 channels starting from index 0. Does this 
cause different ports to overwrite each other's hardware QoS configurations 
in the shared QDMA1 block?

Furthermore, cpu_tx_packets and fwd_tx_packets cache per-channel ETS
hardware counters but are single u64 scalar variables in the port structure.
When querying stats for multiple channels, do these scalar caches get
overwritten with values from completely different channels, resulting in
incorrect delta calculations?
