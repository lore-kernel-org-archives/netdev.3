Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F702931FF
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586666; cv=none; b=dY9bNpcNk+eMyeDK7abzZ0hxOc8u5Jn9BvG/XetA+tgS4si8LMUpIFijID8xeHl/NnA9dVTRD2jVtQIARe/F02+Nf91oDIO83SJ0G0E7+yif3TqRZjDJXt3PdLC9eaSbFMUq6j9hkC7CmQDWNcPmwwmwI7EALWCALciR+ZeLoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586666; c=relaxed/simple;
	bh=s28eRr5Bnu9NhryPgtyknhZXfMrEKdB3Y/tOZc8OolI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccexht9wV1DU2y2dNwdt84pFTOCu3ZU16LY+cBFFAlbvErQ1pacsLaj14szyZmghDSr66m/1iy1Eq1c6/vWnenZkYd0QazMu1iB4lpeOLtAYJRtQril210t8G7E64EFC/Z9sJ3M+yoc/zRiXc0REgZP0rizxQOisAuvrDRyDyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5zJ6lOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5zJ6lOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA81F000E9;
	Mon, 24 Aug 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586664;
	bh=qGnYzb6sb2CaYap45m87vBaR83LJiJZymed/HuvCnUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K5zJ6lOWqJaiA4tHxVuhif8Mm3bjKQTt1ciDXs5YMdZjTdSI6wZ31p8MeOhn3VXtq
	 ZzMfNkXtKEp33p4VVjw4fseQGwOnRr6N3i21KsAm6490Y/F2IlXdVtyt0butglDCVI
	 Ai2yUFTH2CP+dMQg7x97akzd1bDmJBhgrue3bQyOUNzTPNFUTbB9pQg27mRp24e7Zy
	 vX83Jt42erme+CQX05t6g8wnxu2QB/255FyNnNpt/vCNoiPpzKvyk01RayqM88VFUo
	 1HvUfkuDeVj2aOpf37Uvgb4NBjOuLjm90qYkAjRYr7EHraleZPlJK/Qfl7mBeu76Jd
	 uR8c/L2Rpvcgg==
Date: Mon, 24 Aug 2026 16:51:01 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Message-ID: <20260824155101.GW265046@horms.kernel.org>
References: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
 <20260824110838.GP265046@horms.kernel.org>
 <IA3PR11MB89864B9D29B763A29C25B823E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89864B9D29B763A29C25B823E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>

On Mon, Aug 24, 2026 at 01:18:10PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>

...

> Good day, Simon
> 
> The clamp math is off, for the record: pkt_buf is ICE_PARSER_MAX_PKT_LEN + ICE_PARSER_PKT_REV = 536 bytes, so sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE is 504, not 488.
> 
> That said, the actual point stands: ice_parser_rt_pktbuf_set() stores the unclamped caller pkt_len into rt->pkt_len, and both raw RSS and raw FDIR VF paths can pass up to VIRTCHNL_MAX_SIZE_RAW_PACKET (1024) > ICE_PARSER_MAX_PKT_LEN (504). After this fix HO can't exceed 504 either, so HO >= pkt_len stops being a reliable exit for those inputs. Doesn't look like a guaranteed infinite loop to me - the graph's is_last_round action still ends parsing independent of HO - but there's no reason to leave a dangling bound in a bounds-fix patch. I'll send v2 that also stores the clamped length in rt->pkt_len, same Fixes: tag.

Thanks, much appreciated.

> 
> The DDP-table-index and FDIR IRQ-context points from Sashiko are unrelated to this patch - different code, different trust boundary (signed firmware package vs. VF input). 
> I think it should not block this fix.

Yes, agreed.
