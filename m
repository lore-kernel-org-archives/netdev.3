Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80A3AFD0D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236116; cv=none; b=E4eiJ4uPkbEDsgJbdbVevoMpmqS9REreNuSg8wMQTKOCCW2BXknEv2byhy2aYbggS1/IqIioK0dCfVGqvozVlXzRwyMH7NMTy0McHnkwyidO8IRWry+P6/rqFkOSQkn752W3b5+vj1Z0KtbW1YtAyOLcclm/BxpZ+NegTQ+1GDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236116; c=relaxed/simple;
	bh=/fpw5ne5H672tSCuEZ59qIIwaCEVgs75zERXMG0JCi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiQIH0C+aro0WNFYX1urr33H0oh2053pJO2Ua6iWel1iHmGLfgGBxDxEWnKdvfwhjfocEaQdxTxqdMUOblWWh1YorrvUhpAzUV3BJcav1TGg+8uM6Qew+9GbbVGHNIAjzR1bgoET8ct6Ec2MaI14W56sUz6q5DX6YaHi0yG4+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC8YgbD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC8YgbD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC00E1F000E9;
	Tue, 28 Jul 2026 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785236114;
	bh=PguSWyVqZRDGQy3BSxwBZ2iGGLwEFfLhZm0jfSJpPNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WC8YgbD86orGre8TwX3YKNWk7Oo7h7uPAOWj3jJD+xj/pDGvJKZzLWcvrUYrgVc4u
	 KNkFCVNudka0R/uu05a4/K+H+9vkWHUEVUBR81KnV0w6hl7Dy5x+djIvD1QN6j+PIv
	 l0idKSc/4L5frEzzYdtyVbjX2W4I7E8JFS+Jh5AM5uXUL8F/gHI8Kji8M5kGc5wxTT
	 lxpr83Qia7wtr1eIT0kYfo8Cn90XrvzqBm2GbeYhChpsRLatosHmnlZdvVk3/9eOqy
	 XMy3ycdvxWngk6lcwYCiMAJD9Q84rUGoyMoRPMZFHR+2AcLILgMU7Sp6eqkZvc1mqr
	 xBx7IruCWbi/Q==
Date: Tue, 28 Jul 2026 11:55:11 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Czapnik <lukasz.czapnik@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jakub Kaminski <jakub.kaminski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: Re: [PATCH iwl-net] ice: Fix "Unknown bps" during link events
Message-ID: <20260728105511.GT418547@horms.kernel.org>
References: <20260722122448.2286008-1-lukasz.czapnik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722122448.2286008-1-lukasz.czapnik@intel.com>

On Wed, Jul 22, 2026 at 02:24:48PM +0200, Lukasz Czapnik wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c

...

> @@ -1193,8 +1194,10 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>  	/* Check if the link state is up after updating link info, and treat
>  	 * this event as an UP event since the link is actually UP now.
>  	 */
> -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> +	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP) {
>  		link_up = true;
> +		link_speed = phy_info->link_info.link_speed;
> +	}
>  
>  	vsi = ice_get_main_vsi(pf);
>  	if (!vsi || !vsi->port_info)

I have a minor concern that the change above effects the following,
which is a little further down in the same function.

	/* if the old link up/down and speed is the same as the new */
	if (link_up == old_link && link_speed == old_link_speed)
		return 0;

Maybe it's obvious why that isn't the case.
But if so, perhaps could be mentioned in the patch description anyway?

> @@ -1224,7 +1227,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>  			ice_set_dflt_mib(pf);
>  	}
>  	ice_vsi_link_event(vsi, link_up);
> -	ice_print_link_msg(vsi, link_up);
> +	ice_print_link_msg(vsi, link_up, link_speed);
>  
>  	ice_vc_notify_link_state(pf);
>  

...
