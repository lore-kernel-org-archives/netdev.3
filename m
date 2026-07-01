Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF416481679
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908855; cv=none; b=e0uZWmg2paUqaThWJeRkFuSMB8Qno8Bg+lmAIIyavaMHprQP7piibVTrfMMbvOcPaP7gUc5Hj1LukBmudWgyoli/cRbaKjiAOXUXZJkhDogZGqKWIPq+VF1Rb3N1SRZ16v9tiIkDEVVLGPBiWAK6YBF/rDzPanDLHlVdMfrYZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908855; c=relaxed/simple;
	bh=7cLVAYMUd5AnQOsYPgCAB602Jl0VgHgpVGTyL4/nLJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trUSmwP7qg/m94L4QxCEhoOD29gbIdvmxsq5ndm1NIUgTF8uIRC06iQlPqGKYzeeehKmXgId9uclTWU1Q6D/OnVwRURgiKFjUJ0h9Utg6D5I5eUv2RmE4y8x9g9+E2JyBftWSWCveudW9/7yVFzLcnitEAnYuv3+CVxpjijCq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9AB5B4C2C37D66;
	Wed, 01 Jul 2026 14:27:01 +0200 (CEST)
Message-ID: <fb13640b-0171-457a-84c5-f6dbdd6d7471@molgen.mpg.de>
Date: Wed, 1 Jul 2026 14:27:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: E610: force phy link
 to get down when interface is down
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260701113519.49859-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260701113519.49859-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jedrzej,


Thank you for your patch.

Am 01.07.26 um 13:35 schrieb Jedrzej Jagielski:
> For the E610 family, similarly to the E8xx adapters, the default behavior
> is for the PHY link to remain up even when the corresponding OS interface
> is down.
> 
> Add function setting down the PHY config IXGBE_ACI_PHY_ENA_LINK bit
> what leads to disabling PHY link.

It’d extend it a little:

… by factoring the code out into ixgbe_handle_link_down(), and call it 
in ixgbe_close().

> Align functionality with the implementation of the ice driver.

Please add a paragraph detailing regression potential. Are there users 
that might depend on the current default, as uncommon it might be?

> Let user to configure link-down-on-close enablement through ethtool.

Please provide examples, and how to test your change. Doing this you can 
also paste the new log messages.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 35 ++++++++++++++++++-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  1 +
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 15 ++++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 27 +++++++++++---
>   5 files changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 30f62174acf2..7bbb82dd962c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -685,6 +685,7 @@ struct ixgbe_adapter {
>   #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
>   #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
>   #define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
> +#define IXGBE_FLAG2_LINK_DOWN_ON_CLOSE		BIT(25)
>   
>   	/* Tx fast path data */
>   	int num_tx_queues;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index da445fb673fc..46d8a3ea86b8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -1923,6 +1923,33 @@ void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw)
>   	hw->fc.current_mode = hw->fc.requested_mode;
>   }
>   
> +/**
> + * ixgbe_disable_phy_link - force phy link to get down
> + * @hw: pointer to hardware structure
> + *
> + * Send 0x0601 with the IXGBE_ACI_PHY_ENA_LINK bit set down.
> + *
> + * Return: the exit code of the operation.

At least for me it’s not that helpful. Shouldn’t the return values be 
listed? What is success? What is failure?

> + */
> +int ixgbe_disable_phy_link(struct ixgbe_hw *hw)
> +{
> +	struct ixgbe_aci_cmd_get_phy_caps_data pcaps = {};
> +	struct ixgbe_aci_cmd_set_phy_cfg_data pcfg = {};
> +	int err;
> +
> +	err = ixgbe_aci_get_phy_caps(hw, false, IXGBE_ACI_REPORT_ACTIVE_CFG,
> +				     &pcaps);
> +	if (err)
> +		return err;
> +
> +	ixgbe_copy_phy_caps_to_cfg(&pcaps, &pcfg);
> +
> +	pcfg.caps &= ~IXGBE_ACI_PHY_ENA_LINK;
> +	pcfg.caps |= IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT;
> +
> +	return ixgbe_aci_set_phy_cfg(hw, &pcfg);
> +}
> +
>   /**
>    * ixgbe_disable_rx_e610 - Disable RX unit
>    * @hw: pointer to hardware structure
> @@ -2207,6 +2234,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
>   	u8 rmode = IXGBE_ACI_REPORT_TOPO_CAP_MEDIA;
>   	u64 sup_phy_type_low, sup_phy_type_high;
>   	u64 phy_type_low = 0, phy_type_high = 0;
> +	bool force_on_required;
>   	int err;
>   
>   	err = ixgbe_aci_get_link_info(hw, false, NULL);
> @@ -2272,6 +2300,11 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
>   		phy_type_high |= IXGBE_PHY_TYPE_HIGH_10G_USXGMII;
>   	}
>   
> +	/* If IXGBE_ACI_PHY_ENA_LINK has been explicitly disabled that means
> +	 * we need to force interface enablement after reaching that point

It’d be great, if you rephrased “that point”.

> +	 */
> +	force_on_required = !(pcfg.caps & IXGBE_ACI_PHY_ENA_LINK);
> +
>   	/* Mask the set values to avoid requesting unsupported link types. */
>   	phy_type_low &= sup_phy_type_low;
>   	pcfg.phy_type_low = cpu_to_le64(phy_type_low);
> @@ -2280,7 +2313,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
>   
>   	if (pcfg.phy_type_high != pcaps.phy_type_high ||
>   	    pcfg.phy_type_low != pcaps.phy_type_low ||
> -	    pcfg.caps != pcaps.caps) {
> +	    pcfg.caps != pcaps.caps || force_on_required) {
>   		pcfg.caps |= IXGBE_ACI_PHY_ENA_LINK;
>   		pcfg.caps |= IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT;
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> index 2cb76a3d30ae..59044d67ebeb 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> @@ -50,6 +50,7 @@ int ixgbe_cfg_phy_fc(struct ixgbe_hw *hw,
>   		     enum ixgbe_fc_mode req_mode);
>   int ixgbe_setup_fc_e610(struct ixgbe_hw *hw);
>   void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw);
> +int ixgbe_disable_phy_link(struct ixgbe_hw *hw);
>   void ixgbe_disable_rx_e610(struct ixgbe_hw *hw);
>   int ixgbe_init_phy_ops_e610(struct ixgbe_hw *hw);
>   int ixgbe_identify_phy_e610(struct ixgbe_hw *hw);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 4dfae53b4ea1..0fcb9d738984 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -139,6 +139,8 @@ static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
>   	"vf-ipsec",
>   #define IXGBE_PRIV_FLAGS_AUTO_DISABLE_VF	BIT(2)
>   	"mdd-disable-vf",
> +#define IXGBE_PRIV_LINK_DOWN_ON_CLOSE	BIT(3)
> +	"link-down-on-close",
>   };
>   
>   #define IXGBE_PRIV_FLAGS_STR_LEN ARRAY_SIZE(ixgbe_priv_flags_strings)
> @@ -3842,6 +3844,9 @@ static u32 ixgbe_get_priv_flags(struct net_device *netdev)
>   	if (adapter->flags2 & IXGBE_FLAG2_AUTO_DISABLE_VF)
>   		priv_flags |= IXGBE_PRIV_FLAGS_AUTO_DISABLE_VF;
>   
> +	if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE)
> +		priv_flags |= IXGBE_PRIV_LINK_DOWN_ON_CLOSE;
> +
>   	return priv_flags;
>   }
>   
> @@ -3879,6 +3884,16 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
>   		}
>   	}
>   
> +	flags2 &= ~IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
> +	if (priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE) {
> +		if (adapter->hw.mac.type == ixgbe_mac_e610) {
> +			flags2 |= IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
> +		} else {
> +			e_info(probe, "Cannot set private flags: Unsupported hardware\n");

Please print hw.mac.type, and mention, that it’s only supported on E610.

> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>   	if (flags2 != adapter->flags2) {
>   		adapter->flags2 = flags2;
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 62c2d83e1577..58ee4a186039 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7544,6 +7544,17 @@ static void ixgbe_close_suspend(struct ixgbe_adapter *adapter)
>   	ixgbe_free_all_rx_resources(adapter);
>   }
>   
> +static void ixgbe_handle_link_down(struct ixgbe_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +
> +	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
> +		ixgbe_ptp_start_cyclecounter(adapter);
> +
> +	e_info(drv, "NIC Link is Down\n");
> +	netif_carrier_off(netdev);
> +}
> +
>   /**
>    * ixgbe_close - Disables a network interface
>    * @netdev: network interface device structure
> @@ -7566,6 +7577,16 @@ int ixgbe_close(struct net_device *netdev)
>   
>   	ixgbe_fdir_filter_exit(adapter);
>   
> +	if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE) {
> +		int err;
> +
> +		err = ixgbe_disable_phy_link(&adapter->hw);
> +		if (err)
> +			e_warn(drv, "Cannot set PHY link down\n");

Log the error?

> +
> +		ixgbe_handle_link_down(adapter);
> +	}
> +
>   	ixgbe_release_hw_control(adapter);
>   
>   	return 0;
> @@ -8244,11 +8265,7 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
>   	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
>   		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
>   
> -	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
> -		ixgbe_ptp_start_cyclecounter(adapter);
> -
> -	e_info(drv, "NIC Link is Down\n");
> -	netif_carrier_off(netdev);
> +	ixgbe_handle_link_down(adapter);
>   }
>   
>   static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)


Kind regards,

Paul
