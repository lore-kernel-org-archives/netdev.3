Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CB3DBD43
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019167; cv=none; b=Fs3sm4HOFuSiAhVlw5u7oOyfvpg+jq4Fr0ZKGe/9Y2Hpvr5456IVWsiwAWd6q1SgUd7ljZWabJpvaalPMvLGpvdjLRYj30PRjm6Dw93jGZ1m7C0IuPOhAJzDD1RK0+agRcxXxaRQipiHgGu7XGl7NVqNizp6VMJ2TVPecmh/Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019167; c=relaxed/simple;
	bh=Zv5DFhapJz8Taxh8olUlK2mi02VNMV8KBv8WGvglWiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjtYPB2xvSrWLb/FIeunj34Qt/fB9/lMeeh63VrC+RhPbwfNsCWyTQlLwKg29d2zuJ0cRtjQpN9I5egBe0XL5zSE4d5Zzvf6rYvF+BpEKQxS/l8e04Va7O+4/EOfzSqnGSsIlVbUMROK2hLfhl8JMLJf2Ml0nGfJkn68fHNlTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDoToYAk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDoToYAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786019165; x=1817555165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zv5DFhapJz8Taxh8olUlK2mi02VNMV8KBv8WGvglWiY=;
  b=EDoToYAkOPqJHcR0f4n/oZFxg1OUpZUKLJooirz78MDlV+jvzn6QPf5C
   yLt1jJ6g3rKtcqfX7L+mTPMi8REyu9X1apTmmF2ZoadUV9PAxZG5GIswa
   hURooSBPXe4ykkYhwAujn2vbEGse4xk+GRENlmzgX6y6AZsqxxpof/AAC
   8MFZYo8rEjpZG/VqfcElUbwx5uYZbf8dN/x/3CEmnSi2NP9obmng1LJ6R
   W2k/D8lXOGRixHY+lKHeee0+1DYTdFP6cn44hUhE7LYyauvuS2NX+H6kh
   lEsk7wZHa2x7tIaMlBBCXWWmVCKKf9PheZH9O2vTKwesK/KGfbc70GeN7
   g==;
X-CSE-ConnectionGUID: uoqA7/dETHu9vHmdkyi9Mw==
X-CSE-MsgGUID: XS/hAPSvQYKw5xH9DZ5W1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="104012468"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="104012468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 05:26:04 -0700
X-CSE-ConnectionGUID: lWkq9/2dS9Ck+NueEFhJ3w==
X-CSE-MsgGUID: 1u/nZzh1Ra2rZsZ+kxtCgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="258218161"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239]) ([10.217.160.239])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 05:26:02 -0700
Message-ID: <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
Date: Thu, 6 Aug 2026 14:26:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/08/2026 23:06, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> field in a single operation.
> 
> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> __le32 to ensure the fields are written correctly also on big endian
> platforms.
> 
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> ---
> 
> Changes
>   v1 -> v2
>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index c724d429a7aa..91ca75e45463 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
>  				    struct idpf_tx_splitq_params *params,
>  				    u16 td_cmd, u16 size)
>  {
> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));

While it technically works, I find it unreadable. Looking at this line
without reading commit msg, it looks like a bug where a 4-byte value is
written to u8 field. The intent to zero an adjacent, unrelated field is
not clear. Consider assigning these 4 fields manually, or adding a
comment/function doc.

Thanks,
Marcin

>  	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
>  	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
>  }

