Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94F3E3155;
	Fri,  5 Jun 2026 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627119; cv=none; b=lGh0lnAr6LE4X3HIoPgAT5TRy8JiZ9UV2x5gjuOqh/wnGygsXsUIz5QWJmV4vX5fBw6AcjJ5IJ1t5IuS36M6YCg6g4XuV4VoCFoGAoFyE3hmw66/cmkHUnjuLLAau7+PgI7xGslM5zPpSCfE5OcBU6lZ3BML7GbK+Aeelx+WHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627119; c=relaxed/simple;
	bh=OGMmf6bsHMua57xPnzXPnpMsolC/thXXZ39muzt6fF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMV/tBvgiNm7DykYpTNZrhTNpHPPHrfjJpi36pX7aScM2gw7W6IVzK5I8e9Y6sNhz0OxdiDrnU9esLFzxYw0iuEjP9NQBu/09N2wEpA3szoEDyGYyXJ4o6Gq4tGGnaKgZ29BYpcEFFIRghhDEfUvRDPAINbiHSR+0u47XhpZIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7lX8lJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7lX8lJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05FE1F00898;
	Fri,  5 Jun 2026 02:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627113;
	bh=GvlsWfjga9Qduzi7rdkPjWoHL+cOvUF188mJhsiihbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7lX8lJirIERMIJIyMDyRTInVbZU2IOMaBc2G3pfZTsiYtkHQ7hQVqCrMrA1XjIbu
	 NBAMI8MkQS7RAL4kEwHU7VMO3u+3u1P6OI/BmVGu9ZFiSIGhO5fdo5f5qNxiq0U1K0
	 qgrUhiQHgEArk4KoVmuj/lND+aEwqRz5f2l29FI899d5HuPx/URr5OWTDy2sNcf6D1
	 wIRds8lIMjnzGWs3wQ0V7CjJS15Gyx7pZum8SBf+XXnikk1SrejMcT4pwkCP0ueTH5
	 zWnw3SJs9Z2THPTIeRnW6RgkPHW3WhRKBZ29nG5wwYm/MzU1cA1El+rNFGq5g77rgN
	 CELVS1dZlUxrA==
From: Jakub Kicinski <kuba@kernel.org>
To: sukhdeeps@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v4 6/12] net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address
Date: Thu,  4 Jun 2026 19:38:31 -0700
Message-ID: <20260605023831.3629095-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602135452.516-7-sukhdeeps@marvell.com>
References: <20260602135452.516-7-sukhdeeps@marvell.com>
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
net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address

This patch updates hw_atl2 init to use firmware-reported ART and L2
filter base indices for AQC113, adds hw_atl2_hw_mac_addr_set() that
programs the MAC into the firmware-assigned L2 filter slot, and wires
.hw_get_regs into hw_atl2_ops.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 0ce9caae8799..27a62fffbc29 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c

[ ... ]

> @@ -484,6 +508,7 @@ static int hw_atl2_act_rslvr_table_set(struct aq_hw_s *self, u8 location,
>  static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  {
>  	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
> +	struct hw_atl2_priv *priv = self->priv;
>  	int i;
>  
>  	/* Rx TC/RSS number config */
> @@ -499,7 +524,9 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  
>  	/* Multicast filters */
>  	for (i = HW_ATL2_MAC_MAX; i--;) {
> -		hw_atl_rpfl2_uc_flr_en_set(self, (i == 0U) ? 1U : 0U, i);
> +		hw_atl_rpfl2_uc_flr_en_set(self,
> +					   (i == priv->l2_filters_base_index) ?
> +					   1U : 0U, i);
>  		hw_atl_rpfl2unicast_flr_act_set(self, 1U, i);
>  	}

[High]

Can the multicast list handler now collide with the UC MAC slot?

After this patch, the host MAC is programmed at slot
priv->l2_filters_base_index (firmware-supplied, clamped by the new check
in hw_atl2_utils_get_filter_caps() to the range [0, HW_ATL2_MAC_MAX-1]
i.e. [0, 37]).  However, hw_atl2_hw_multicast_list_set() still iterates
multicast entries into slots HW_ATL2_MAC_MIN + i (i.e. starting at slot
1):

  for (cfg->mc_list_count = 0U;
       cfg->mc_list_count < count;
       ++cfg->mc_list_count) {
      u32 i = cfg->mc_list_count;
      ...
      hw_atl_rpfl2_uc_flr_en_set(self, 0U, HW_ATL2_MAC_MIN + i);
      hw_atl_rpfl2unicast_dest_addresslsw_set(self, l,
                                              HW_ATL2_MAC_MIN + i);
      hw_atl_rpfl2unicast_dest_addressmsw_set(self, h,
                                              HW_ATL2_MAC_MIN + i);
      hw_atl2_rpfl2_uc_flr_tag_set(self, 1, HW_ATL2_MAC_MIN + i);
      hw_atl_rpfl2_uc_flr_en_set(self, (cfg->is_mc_list_enabled),
                                 HW_ATL2_MAC_MIN + i);
  }

If the firmware reports any value N in [1, 37] for
l2_filters_base_index (which is the case the patch is intended to
support, since for N=0 the change vs. the old hardcoded HW_ATL2_MAC_UC=0
is a no-op) and the multicast list contains at least N entries, the
iteration with i = N - 1 writes to slot HW_ATL2_MAC_MIN + (N - 1) = N,
which is the UC MAC filter slot.

Wouldn't routine ndo_set_rx_mode invocations (for example IGMP/MLD
group joins or link state changes) then silently overwrite the host
MAC's UC filter with a multicast address, causing the NIC to stop
accepting unicast frames for the host?

Should hw_atl2_hw_multicast_list_set() also be updated to skip or
offset around priv->l2_filters_base_index, in the same way
hw_atl2_hw_init_rx_path() and hw_atl2_hw_mac_addr_set() were?
