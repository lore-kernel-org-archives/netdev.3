Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D836348883;
	Tue, 28 Apr 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359416; cv=none; b=WOZKdEUbSKdjbR2hPY6i53WGSElc/9R+ysdZmDXMr1r2X4YUSsGDGa2xz2H2/ns1j1SSeNUC0FDS7nqgMMcBe1Gxq3wXRjwIYDx6HDz6dGccPkXoLHibJBc5shKo+zXL6W2hDd0/AT2FtdP4UNHYqKFUHkTtSzCR4aUekJ+52SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359416; c=relaxed/simple;
	bh=CS4pBdzNh3NZsCPmjXr1Y9IgwAuRv4L39KxS3qol8L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM3SY92BochZkEr0TCy/6GP6S7lWyO/sQ4bmOVwmesezkUGFSxM2NA7nHwTBXWQDus5sIVAKL2XLelx0ANHtElE1Ky7DJd7MbFmyh8klgK9FHhwJ+OO/3VyQCOnm3XJxuKqncZ8WknzrWgiAYc7kNbLOR7lVAkVgjmZP+MrWZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af76e.dynamic.kabel-deutschland.de [95.90.247.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA5054C288718F;
	Tue, 28 Apr 2026 08:56:02 +0200 (CEST)
Message-ID: <a9cfe2dc-f4dc-48fb-a374-0d2902baa0c5@molgen.mpg.de>
Date: Tue, 28 Apr 2026 08:56:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/3] igc: remove unused
 autoneg_failed field
To: khai.wen.tan@linux.intel.com
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: Removed stray *Looi*]

Dear Khai Wen Tan,


Thank you for your patch.


Am 28.04.26 um 08:00 schrieb KhaiWenTan:

(Should spaces be added in your name?)

> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> autoneg_failed in struct igc_mac_info is never set in the igc driver.
> Remove the field and the dead code checking it in
> igc_config_fc_after_link_up().

Could you please elaborate. Why is removal the correct fix, and it’s not 
an incomplete feature? Does auto-negotiation always succeed?

> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>

Please order it to not use the comma: Hong Aun Looi

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
>   drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
>   2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
> index be8a49a86d09..86ab8f566f44 100644
> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
> @@ -92,7 +92,6 @@ struct igc_mac_info {
>   	bool asf_firmware_present;
>   	bool arc_subsystem_valid;
> 
> -	bool autoneg_failed;
>   	bool get_link_status;
>   };
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
> index 7ac6637f8db7..142beb9ae557 100644
> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
> @@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
>    * Checks the status of auto-negotiation after link up to ensure that the
>    * speed and duplex were not forced.  If the link needed to be forced, then
>    * flow control needs to be forced also.  If auto-negotiation is enabled
> - * and did not fail, then we configure flow control based on our link
> - * partner.
> + * then we configure flow control based on our link partner.
>    */
>   s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>   {
>   	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
> -	struct igc_mac_info *mac = &hw->mac;
>   	u16 speed, duplex;
>   	s32 ret_val = 0;
> 
> -	/* Check for the case where we have fiber media and auto-neg failed
> -	 * so we had to force link.  In this case, we need to force the
> -	 * configuration of the MAC to match the "fc" parameter.
> -	 */
> -	if (mac->autoneg_failed)
> -		ret_val = igc_force_mac_fc(hw);
> -
> -	if (ret_val) {
> -		hw_dbg("Error forcing flow control settings\n");
> -		goto out;
> -	}
> -
>   	/* In auto-neg, we need to check and see if Auto-Neg has completed,
>   	 * and if so, how the PHY and link partner has flow control
>   	 * configured.


Kind regards,

Paul
