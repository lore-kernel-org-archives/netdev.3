Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1593B27FF
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955944; cv=none; b=mi3mPaLM0nTSemyqZBOJ3hvwGE110GSmAoj7WMsUAsvNzN/PRtgQoE0rD4jzYfoLlgL6di8SFHa0b1+/28N0sDmi5bzubJJdlpgiq/nUy2bsZR7NXDtMOK0kkckj7a7suhe9CeOCkJm6Tmow2iNjjNXwo9l41wDhd72pv/KzJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955944; c=relaxed/simple;
	bh=c1HpKxmZh/vDAAxMnUvYiCbMKTHqUgCr6R7N3XfmFAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiCNpI9zoQLTHtpqhpIOio9Afnpv/dUHzP6LHrG97W9xb5F/SjhlXdxJ7kEAS1Bg7DRnUYZg1tFpdmbIuLY0G6VMmbExXj4NrfwUu0xkW0LmXboimDLgXtfbjUEZyzVxgvDBazVSKww4UUDo2s1+tRsakia73K1C7FHbUBYb1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6q5fPql; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6q5fPql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955943; x=1809491943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c1HpKxmZh/vDAAxMnUvYiCbMKTHqUgCr6R7N3XfmFAQ=;
  b=T6q5fPqlcaCOX4BPX0ZCuxtRVbOCU0s2QkW4uw6+YsmfOqfN1HsvKlw7
   gS5+PxSSRZHaLVFb43/qMDXKtQtv62IxccF2zs9KsFoautnHrfW++nfzD
   heR7FMTiCQk430RJHserRMjrpAgjMN4MGvJkQ5mjrYA8eXYCCTd6r6Gcz
   h2ySABupro9h9Hy9NWzQbJMxPbtdIHoLhIQ9CdpCbuZclfpR9MOIwkJoP
   Se1KPwKjTe/4bJ8HmuQ8T3Vyc7j0B3xXUY5rbIMPOmm5VFt5tVYT/02+5
   nq9Hz4iBXyT8yQlCo0cO9ckULuMpFfBwYiz6zWcnbVTAkMdGpD9ko03XZ
   g==;
X-CSE-ConnectionGUID: wDr+3NYKST64OSNUnAhnOQ==
X-CSE-MsgGUID: JTKiwD7nRYejjypaSrFVVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89124588"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89124588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:39:03 -0700
X-CSE-ConnectionGUID: Zp/RDczkSni7GBS1NKqqlw==
X-CSE-MsgGUID: gUFZaRRZTXaFArHJjVG8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="259369989"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:39:00 -0700
Date: Tue, 5 May 2026 06:35:04 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jramaseu@redhat.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use
 NETIF_F_HW_CSUM instead of IP/IPV6
Message-ID: <aflzeKTaOUBy2Xsn@mev-dev.igk.intel.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
 <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
 <44623db1-8b86-4e8e-82a3-46d65b055ebc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44623db1-8b86-4e8e-82a3-46d65b055ebc@intel.com>

On Mon, May 04, 2026 at 04:53:12PM -0700, Jacob Keller wrote:
> On 4/28/2026 12:06 AM, Michal Swiatkowski wrote:
> > The hardware is capable of calculating checksum for IPV6 packets with
> > extension header. To not drop such packets switch from IP/IPV6 checksum
> > to HW_CSUM.
> > 
> > HW_CSUM is also used in previous generation (i40e).
> > 
> > Previously HW_CSUM was used to indicate that hardware supports general
> > checksum. Drop it assuming that if the hardware supports it, it is used.
> > 
> > Disabling offload for E830 in case of TSO isn't needed anymore as the
> > check for TSO is done in Tx path just before preparation of the special
> > GCS descriptor.
> > 
> > The commit from Fixes didn't introduce a bug, it just shown that the
> > driver is doing sth wrong with the checksum features.
> > 
> > Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> Am I correct in thinking that this supersedes (really, properly fixes)
> the patch "ice: enable NETIF_F_HW_CSUM for GSO packets" at
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260310150557.1138437-1-jramaseu@redhat.com/
> ?
> 
> Thanks,
> Jake

Yes, exactly. I think I linked it in cover letter, but maybe I should do
it also here.

Thanks
