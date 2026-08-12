Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789031ED80
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515146; cv=none; b=mG2//lAcZ7H83JhCW4+ZZ1OzJqG4T24Gjgnf5wQQ7LxxhIGjlgQN2n/fs+pOc8qy7P1bgE+5aRc5adPxERUnrFbd+h6VCA8o2o9i50H4qeExPy3NCXK7bYmoq6vaWdxTTVe3bvOjBcwXnhjVZoQXr/PRlTcTVoSZPr+dAj53qeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515146; c=relaxed/simple;
	bh=oGn0d7AO1BGA1h21iEfgQ8Rv8RBlv1+CtF4b0V5ud/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dt82esOShanwMIm2JkCWGYFfXJmrVI0gIlzXcNKtJ0rxadQ3ELChXCFYnKyPgVnmPfBiW9DO0NteMY0+/N51MF1/S0yav+H2XZz7EFbonQdsmH1qZ0WLfU+/3RMLDsAcr+gbfq40kngOkDQTWCtzLsSALu8Qpt/0aWVPaRz9wAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.150] (ip5f5af690.dynamic.kabel-deutschland.de [95.90.246.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 389814C2C90B43;
	Wed, 12 Aug 2026 08:11:53 +0200 (CEST)
Message-ID: <4173a6dd-8c82-4b2f-8532-84db150e3965@molgen.mpg.de>
Date: Wed, 12 Aug 2026 08:11:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Maciek Machnikowski <maciej.machnikowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com
References: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Tony, dear Maciek,


Thank you for your patch.

Am 12.08.26 um 01:10 schrieb Tony Nguyen:
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
> 
> The PHY on E825-C requires recalibration after large jumps of the
> system time. Add missing PHY recalibration also on E825-C.

Why does it need it? Does the datasheet say so? Hardware errata?

How can the issue be reproduced?

> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 84b99cfc5675..bf625b9f4991 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1956,8 +1956,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>   	/* Reenable periodic outputs */
>   	ice_ptp_enable_all_perout(pf);
>   
> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> -	if (hw->mac_type == ICE_MAC_GENERIC)
> +	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
> +	if (hw->mac_type == ICE_MAC_GENERIC ||
> +	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>   		ice_ptp_restart_all_phy(pf);
>   exit:
>   	if (err) {

The diff looks fine:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
