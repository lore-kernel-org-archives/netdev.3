Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779F2D9787
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658500; cv=none; b=a888L7e86tOHauzyJGcUZ/8yblqykB9tk8GhUlc8P/Eiu74IQjuE9lgvhPU7pX8mENJe2VQDl+uBSVR9jNAYIFC+TQblIQPYmH/Yoc58ao85VAcaCgISCoTgfWu2wA+ytuP6uT5dquAptCPD0otCOTpKnx9y01ixFuXc/t2iD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658500; c=relaxed/simple;
	bh=himC2/STvkUhiPPHFDAGIowQR8mb9pEGk2Ouz2yyZeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjOxSTSF4emadYcVZzOusgM5oG2YwBUw+rcYIz5Mmt3mJSinF2NgmR6ikj7l/lAqvL19/lspkhEWkVUi8LhSnBDtw0jfYA5JQpzvXAr7kHm2AqDpstKVx0c3z+GtL2uSSeDJrL2nxSLlvKwOMWU1LVgngRoY7QUHgJAgMcuLLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B82594C2C37F04;
	Wed, 08 Apr 2026 16:27:51 +0200 (CEST)
Message-ID: <d87f554d-ef86-44c7-9585-0a3806cc5752@molgen.mpg.de>
Date: Wed, 8 Apr 2026 16:27:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: call netif_keep_dst()
 once when entering switchdev mode
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
References: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr, dear Marcin,


Thank you for the patch.

Am 08.04.26 um 16:14 schrieb Aleksandr Loktionov:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> netif_keep_dst() only needs to be called once for the uplink VSI, not
> once for each port representor.  Move it from ice_eswitch_setup_repr()
> to ice_eswitch_enable_switchdev().

It’d be great, if you could share the commands, how to verify your change.

> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>   - Verified Fixes: tag via bisect - defd52455aee introduced the redundant
>     per-repr call to netif_keep_dst(uplink_vsi->netdev) by changing the
>     target netdev to the uplink VSI inside the per-representor setup
>     function. Before that commit, each call was on a distinct repr->netdev
>     so no Fixes: predating it applies.
> 
>   drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f096..c30e27b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -117,8 +117,6 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
>   	if (!repr->dst)
>   		return -ENOMEM;
>   
> -	netif_keep_dst(uplink_vsi->netdev);
> -
>   	dst = repr->dst;
>   	dst->u.port_info.port_id = vsi->vsi_num;
>   	dst->u.port_info.lower_dev = uplink_vsi->netdev;
> @@ -312,6 +310,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
>   	if (ice_eswitch_br_offloads_init(pf))
>   		goto err_br_offloads;
>   
> +	netif_keep_dst(uplink_vsi->netdev);
> +
>   	pf->eswitch.is_running = true;
>   
>   	return 0;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
