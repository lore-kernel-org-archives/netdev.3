Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC53430B8C;
	Sat, 28 Feb 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311474; cv=none; b=Cs83dydjAc6Cglv9MzvOdVw1J1ZnwD5lKKOK21Nr/16Pbo37//MZ+GgKBPwflTfmBKeBmGdjKm4RVjN1+6b9JzMTpcT79DfOn/TBR4unhFKskyws/yXPzSghVPYPGAv4AV9ots6Dwl+K18ZqIJ4leKDgovXXoKwa6iZ2iEc9UJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311474; c=relaxed/simple;
	bh=fouJcXrcIqnS4OK5wrynhLTd93+//OFNPP5WduPOU9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtVAvD5n36b7bRR4MEQET5ykbeOFYxPGng3Y2WoSrQhzWmBajmFHV4WequSI+hUl6ZS+DTFv3V3HZ/L2T+mHfKhNeA32Q38P/jZmrXnX7M8tWs0wFUnN608xGwCKjguI7HqQ/nDf1oI4T3UyL9sf4c0E32hOxSGW4PC1o2Lh50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Isai794V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Isai794V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SrzHTbYPCKrR1q3pp5B8ty/C+EIi95VJx+2ipEIuh1Q=; b=Isai794V+IltfaW+HZj+S+m8Sh
	UXkVo7GQuH6Uey8Rp4NvWi2kESCjHagAscaKN9heSSxhs9jMmj4tj+phtOKwg7s0zocpCl2GuByXf
	rksZ62YmhlCvy/lMVXZ+EQUlt23mrryaOrTKkREkZ3rvj9rPN/7hZ5OIH23ZMsqG4o3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwRAb-009Dpe-Eb; Sat, 28 Feb 2026 21:44:13 +0100
Date: Sat, 28 Feb 2026 21:44:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 06/11] net/nebula-matrix: add common resource
 implementation
Message-ID: <10134f9b-e389-45c8-ac57-10e8a465453c@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-7-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-7-illusion.wang@nebula-matrix.com>

> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -6,7 +6,32 @@
>  
>  #include "nbl_resource_leonis.h"
>  
> +static u16 nbl_res_get_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			      u16 type)
> +{
> +	return nbl_res_func_id_to_vsi_id(res_mgt, func_id, type);
> +}

> +int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			      int *pfid, int *vfid)
> +{
> +	return func_id_to_pfvfid(res_mgt, func_id, pfid, vfid);
> +}
> +
> +u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
> +			     int vfid, u16 type)
> +{
> +	return pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
> +}
> +
> +int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			   u8 *bus, u8 *dev, u8 *function)
> +{
> +	return func_id_to_bdf(res_mgt, func_id, bus, dev, function);
> +}
> +
> +int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
> +{
> +	return vsi_id_to_pf_id(res_mgt, vsi_id);
> +}
> +
> +u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			      u16 type)
> +{
> +	return func_id_to_vsi_id(res_mgt, func_id, type);
> +}


None of these functions actually do anything. Why do they exist?

	Andrew
