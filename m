Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAC31716A
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203801; cv=none; b=B9ZllN6AB576j6xEVtLxMK9pGCzfTI/8KwidkJa/XiwZ1wg49uyvMNgLjdaXNKNdldWH1DMQYv56O6DL8b9cFLzgz3gBibuvG4CYSx/8ZVZqYV0PFpGtfWezhtt9i6HHCSv6Aufnxk64lHnnK2O697uWEz9AHOLtGfWTyne45/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203801; c=relaxed/simple;
	bh=immbULMt48HNApDrJlj1EqpNtsWBa39juRn1bXQ6KUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMYilFXnqX5v8X413db9TlfldoY8HlSoX/rRkDqGMsWclDC77uUd4D1z1Pjh6P+CV02Ldc9tIai7HQycA/oAtfZ1+IzWwbRBTFs4rnHhyZDwQeX1GOq/prBadY7dtbaJxYNi3Wc54qZdEmIVPUaVRpoEIg10Rm7hmEJZHsI6u1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p57bd9728.dip0.t-ipconnect.de [87.189.151.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 169814C2C37D58;
	Fri, 03 Apr 2026 10:09:36 +0200 (CEST)
Message-ID: <3013fbbd-74ef-4636-9a18-5c35c4e8dd04@molgen.mpg.de>
Date: Fri, 3 Apr 2026 10:09:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] iavf: fix kernel-doc comment
 style in ethtool ops
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
References: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Leszek, dear Aleksandr,


Thank you for the patch.

Am 03.04.26 um 07:43 schrieb Aleksandr Loktionov:
> From: Leszek Pepiak <leszek.pepiak@intel.com>
> 
> iavf_get_channels() and iavf_set_channels() use the legacy `**/`
> comment terminator and embed the return description in the body text.
> Convert to proper kernel-doc style: single `*/` terminator and an
> explicit `Return:` section.
> 
> Signed-off-by: Leszek Pepiak <leszek.pepiak@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 8188dd4..425acbb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -1846,13 +1846,13 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>   	return ret;
>   }
>   /**
> - * iavf_get_channels: get the number of channels supported by the device
> + * iavf_get_channels - get the number of channels supported by the device
>    * @netdev: network interface device structure
>    * @ch: channel information structure
>    *
>    * For the purposes of our device, we only use combined channels, i.e. a tx/rx
>    * queue pair. Report one extra channel to match our "other" MSI-X vector.
> - **/
> + */
>   static void iavf_get_channels(struct net_device *netdev,
>   			      struct ethtool_channels *ch)
>   {
> @@ -1873,14 +1873,15 @@ static void iavf_get_channels(struct net_device *netdev,
>   }
>   
>   /**
> - * iavf_set_channels: set the new channel count
> + * iavf_set_channels - set the new channel count
>    * @netdev: network interface device structure
>    * @ch: channel information structure
>    *
>    * Negotiate a new number of channels with the PF then do a reset.  During
> - * reset we'll realloc queues and fix the RSS table.  Returns 0 on success,
> - * negative on failure.
> - **/
> + * reset we'll realloc queues and fix the RSS table.
> + *
> + * Return: 0 on success, negative on failure.
> + */
>   static int iavf_set_channels(struct net_device *netdev,
>   			     struct ethtool_channels *ch)
>   {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
