Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285643E08D
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755059; cv=none; b=L5kWxPQOGe9rjkGztZPPD8QlMuB+VRWJujHxmi149Rv3WNC/vopAj4jSPKwxMAU1SIW/GJGCazUXGC3Hx0CUKkdhMD5hZ96Czm0bGBbysRDY0Nhgmr3VF/SblqQwsBGiK335csHeoHL5NvVZCONYSEdXahGZvoAjdqUNoeYVZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755059; c=relaxed/simple;
	bh=TC0OkRhjUUdFeNQ+mtm8uAHBZtV7OvjOvchH+vTv8fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csenEVo+yhKx9WLO5D7wbNgmKY79R5t49nYRMnxJ53p7oPmQ9fZPLYOIcK22SJsmcjTIYRuEWlW6NXDltkVkXC4osV3ZzafhX+1b4xomuILk66k5AkV+oazC23Pcei0mg669HTUOGCGHEaPaX3ZibAlrP9bhDX19wyxYz8Scd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DF/ofe9g; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DF/ofe9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787755057; x=1819291057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TC0OkRhjUUdFeNQ+mtm8uAHBZtV7OvjOvchH+vTv8fM=;
  b=DF/ofe9geAYf4/UtVJ35jFuR7UfvE+JFdp4Ju3PPqtVPfJRlt6zYye3x
   rcmeFN1oCUmhhNhQeRfKFlUaZXN/YYO85eWzeDqx5ChQVM5SHwHvJiKHT
   D3BnRmH/dTaNYkTtxfKI8LFYf1poUhdKQbT7D/blm0hoD6RsrIQarx1SK
   ekiY4cpfcyIc+HNscwe0IQ0G7WcwsBMMr0FSThsKntHqSqLCThpQ7JC6r
   wLYQNtvdorIzxwJEM7qWBsGM6A1kMBkWZU2D7sUNteterOZuDSJgKs6gu
   D7QZTf5HWG+FCNWFoh7VPe6RpPGvHbdDLuWFKBxO/C7kC9dB5ToQi0ZQp
   Q==;
X-CSE-ConnectionGUID: pNVGq2YLReujhxFsyq546Q==
X-CSE-MsgGUID: k3hsKHyESsiKEcl9sazDsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99398626"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="99398626"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:37:37 -0700
X-CSE-ConnectionGUID: w4u+Dbg+Si+4jd/oNNqvmg==
X-CSE-MsgGUID: PR2O1Gc8TeC4k/eU3TvEJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="291117041"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:37:36 -0700
Received: from [10.102.88.131] (soc-5CG4396XFD.clients.intel.com [10.102.88.131])
	by linux.intel.com (Postfix) with ESMTP id 6F5D020BF394;
	Wed, 26 Aug 2026 07:37:35 -0700 (PDT)
Message-ID: <b164ae67-2874-43ed-aa32-66ca42ae90cc@linux.intel.com>
Date: Wed, 26 Aug 2026 16:37:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v4] ixgbevf: fix link speed reporting for Hyper-V
 E610 VFs
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20260824110834.2364407-1-tomasz.lichwala@linux.intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260824110834.2364407-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This email covers the Sashiko review for this patch.

On 24.08.2026 13:08, Tomasz Lichwala wrote:
> When an E610 VF is running under Hyper-V, the VFLINKS register does not
> carry valid link speed. The existing code reads speed from VFLINKS, which
> does not reflect the actual negotiated speed. This results in ethtool
> reporting a stale or incorrect link speed.
> 
> The Hyper-V synthetic NIC exposes the actual link status through
> emulated PCI config space at offset 0x209 in VFLINKS register format.
> Read and decode link status from there when checking link on E610 VFs.
> 
> To avoid generating unnecessary VMBus transactions on every watchdog
> cycle, read the PCI config register on demand when ethtool or sysfs
> queries link speed, rather than polling it periodically. The cached
> value is used by the watchdog and link state notifications as before.
> 
> Guard the PCI config space read with IS_ENABLED(CONFIG_PCI_MMCONFIG),
> since accessing offsets above 256 requires MMCONFIG support.
> 
> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> ---
> v4:
>  - Read link speed on demand from ethtool/sysfs query instead of polling
>    every watchdog cycle to avoid unnecessary VMBus transactions (ethtool.c)
>  - Restore get_link_status caching for E610 VFs in check_link
>  - Add IS_ENABLED(CONFIG_PCI_MMCONFIG) guard for PCI config reads above
>    offset 256
>  - Add CC netdev@vger.kernel.org
> v3:
>  - Remove #if IS_ENABLED(CONFIG_PCI_MMCONFIG) preprocessor guard
>  - Replace goto decode label with if/else control flow
>  - Move get_link_status check into else branch (non-E610 path only)
>  - Expand commit message with problem description
> v2:
>  - Simplify error path: return 0 with link_up=false instead of
>    propagating PCI read error code
>  - Fix alignment in macro definitions
>  - Update comment describing Hyper-V PCI config offsets
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c | 12 ++++
>  drivers/net/ethernet/intel/ixgbevf/vf.c      | 68 +++++++++++++++++---
>  2 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> index 537a60d5276f..2463fccffd4d 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> @@ -83,6 +83,18 @@ static int ixgbevf_get_link_ksettings(struct net_device *netdev,
>  				      struct ethtool_link_ksettings *cmd)
>  {
>  	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
> +	struct ixgbe_hw *hw = &adapter->hw;
> +
> +	/* E610 Hyper-V VFs: read current link speed from PCI config space
> +	 * on every link speed query.
> +	 */
> +	if (hw->mac.type == ixgbe_mac_e610_vf) {

The mac type check matches both Hyper-V and bare-metal E610 VFs. On bare-metal, forcing get_link_status=true and calling ixgbevf_check_mac_link_vf() would indeed corrupt the link state — the CTS mailbox read fails (no pending CTS), causing a false link-down report.

Fixed in v5 by checking the subsystem device ID (IXGBE_SUBDEV_ID_E610_VF_HV) instead of the mac type.  This is the same identifier used in the PCI ID table to select Hyper-V mac_ops during probe, so the on-demand read now only triggers for Hyper-V VFs where hw->mac.ops.check_link points to ixgbevf_hv_check_mac_link_vf().

> +		spin_lock_bh(&adapter->mbx_lock);
> +		hw->mac.get_link_status = true;
> +		hw->mac.ops.check_link(hw, &adapter->link_speed,
> +				       &adapter->link_up, false);

This is not a race introduced by this patch. The watchdog's pattern of caching adapter->link_speed into a local variable before taking mbx_lock is pre-existing for all Hyper-V VF types. The ethtool response is always correct because it reads adapter->link_speed immediately after check_link returns within the same function call. The mbx_lock serializes concurrent check_link calls - ethtool and watchdog cannot execute check_link simultaneously.

> +		spin_unlock_bh(&adapter->mbx_lock);
> +	}
>  
>  	ethtool_link_ksettings_zero_link_mode(cmd, supported);
>  	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index f6df86d124b9..a84b62641e9b 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -1,14 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 1999 - 2024 Intel Corporation. */
>  
> +#include <linux/unaligned.h>
> +
>  #include "vf.h"
>  #include "ixgbevf.h"
>  
> -/* On Hyper-V, to reset, we need to read from this offset
> - * from the PCI config space. This is the mechanism used on
> - * Hyper-V to support PF/VF communication.
> +/* On Hyper-V the PF/VF communication is through emulated PCI config
> + * space. The reset and link status are exposed at the offsets below.
>   */
> -#define IXGBE_HV_RESET_OFFSET           0x201
> +#define IXGBE_HV_RESET_OFFSET		0x201
> +#define IXGBE_HV_LINK_STATUS_OFFSET	0x209
> +#define IXGBE_HV_LINK_STATUS_SIZE	4
>  
>  static inline s32 ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw, u32 *msg,
>  					     u32 *retmsg, u16 size)
> @@ -901,6 +904,40 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>  	return ret_val;
>  }
>  
> +/**
> + * ixgbevf_hv_read_links_e610 - read link status from PCI config space
> + * @hw: pointer to hardware structure
> + * @links_reg: pointer to store read value
> + *
> + * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
> + * Instead, link status is exposed through emulated PCI config space at offset
> + * 0x209 in VFLINKS register format.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
> +{
> +	struct ixgbevf_adapter *adapter = hw->back;
> +	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
> +
> +	if (!IS_ENABLED(CONFIG_PCI_MMCONFIG)) {


The IS_ENABLED(CONFIG_PCI_MMCONFIG) guard is intentionally kept for consistency with  xgbevf_hv_reset_hw_vf(), which uses the same pattern to access emulated PCI config space at offset  x201. Both functions read from extended config space offsets (>256) that require MMCONFIG on x86. In practice, Hyper-V E610 VFs are only deployed on x86 hosts where CONFIG_PCI_MMCONFIG is always enabled. If ARM64 Hyper-V support becomes relevant, both functions would need to be updated together.

> +		dev_err_once(&adapter->pdev->dev,
> +			     "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
> +		int ret = pci_read_config_byte(adapter->pdev,
> +					       IXGBE_HV_LINK_STATUS_OFFSET + i,
> +					       &data[i]);
> +		if (ret)
> +			return pcibios_err_to_errno(ret);
> +	}
> +
> +	*links_reg = get_unaligned_le32(data);
> +	return 0;
> +}
> +
>  /**
>   * ixgbevf_hv_check_mac_link_vf - check link
>   * @hw: pointer to private hardware struct
> @@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>   * @autoneg_wait_to_complete: unused
>   *
>   * Hyper-V variant; there is no mailbox communication.
> + * For E610 VFs, link status is read from emulated PCI config space.
>   */
>  static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  					ixgbe_link_speed *speed,
> @@ -926,8 +964,16 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  	if (!mac->get_link_status)
>  		goto out;
>  
> -	/* if link status is down no point in checking to see if pf is up */
> -	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
> +	if (mac->type == ixgbe_mac_e610_vf) {
> +		if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
> +			*link_up = false;
> +			*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +			return 0;
> +		}
> +	} else {
> +		links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
> +	}
> +
>  	if (!(links_reg & IXGBE_LINKS_UP))
>  		goto out;
>  
> @@ -941,8 +987,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  			udelay(100);
>  			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
>  
> -			if (!(links_reg & IXGBE_LINKS_UP))
> -				goto out;
> +			if (!(links_reg & IXGBE_LINKS_UP)) {
> +				*link_up = false;
> +				*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +				return 0;
> +			}
>  		}
>  	}
>  
> @@ -956,6 +1005,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  	case IXGBE_LINKS_SPEED_100_82599:
>  		*speed = IXGBE_LINK_SPEED_100_FULL;
>  		break;
> +	default:
> +		*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +		break;
>  	}
>  
>  	/* if we passed all the tests above then the link is up and we no

