Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632F38837B;
	Thu, 16 Apr 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327771; cv=none; b=qGFxW9wWTDOZTRow+/IKtu3IdnIu7oT8FTT3n/x9cAgWqhgOruhlq0G7zxuz/YNh6MvhGzmvhPJGwxE7sngcz5gN8YV+8vCdUUiqgfL6Qc/F2ZJJAiwHDJyTnsVxSPcYIKGl02QhFDiHTy+EpWlQugStIDVeQzJWo3ApoDEiDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327771; c=relaxed/simple;
	bh=FF2Hu3tsfPgmUysXQRYTdoXImMRnS5VAm2iqlazCptQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owR2fIU4VJoQ3fXfHZyQIFx3oq7t0WCPX41hJ5xpJMM+mfcCfnl0QAmc0AqJ2jsUYu116fAnFSFrtehDv1KldJzkrSxLe9fV74SC7OvzOtIaoObUHWcAHZms9RLL44LhPHU0iPYvdyQYwhTaopXEK1Tm9wqQT38iOi1WJzP+Paw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diMBgL3b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diMBgL3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327770; x=1807863770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FF2Hu3tsfPgmUysXQRYTdoXImMRnS5VAm2iqlazCptQ=;
  b=diMBgL3bWRkwsODDyO8Zj1X4e2DLc74KZaVlMkFdbXolu9oc3nWFaSos
   bkDV7ba1A9UE13iln3+Hs8G6h6SrISd0d4iZnPfJCnkcZ6o/OY1Plz5D7
   9CxXxdIQphwk+/UBeixu10pxctTQiOEeoE5ZItERv3hyJTYG9yPMyoeFg
   1cErcZK5YLaz+71yD16n601xbOe2u37mVUqgL/8Nugm5+5Ork+9MfRbM7
   hnqcWFyZN4bIu8uawOQLkq+CHgeoMBskoIIBPY2tAMP/UOD0TfDzsFQWK
   rXPSltPxCGdp7DjvcEhfUInXLMaG++DEagOKKVvhYDrVOCd7OwMfR405Y
   A==;
X-CSE-ConnectionGUID: CFbYWrC1SrqBV5dIJ5d8Lw==
X-CSE-MsgGUID: BGluRLClRwq5R2Uprtg8YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="87622374"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="87622374"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:22:49 -0700
X-CSE-ConnectionGUID: ahImSsagQhGSPzyuUq/DjQ==
X-CSE-MsgGUID: 0Khl595iR0GlOcxcYe+M1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230598180"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:22:49 -0700
Received: from [10.107.24.239] (soc-5CG20645H5.clients.intel.com [10.107.24.239])
	by linux.intel.com (Postfix) with ESMTP id 29CC120B5713;
	Thu, 16 Apr 2026 01:22:44 -0700 (PDT)
Message-ID: <bacbe354-c202-4690-8e06-91f0244567ed@linux.intel.com>
Date: Thu, 16 Apr 2026 16:22:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2 1/1] net: stmmac: Update default_an_inband before
 passing value to phylink_config
To: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 ovidiu.panait.rb@renesas.com, vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yoong.siang.song@intel.com, hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260413020339.68426-1-khai.wen.tan@linux.intel.com>
 <72d1b0b7-c8df-463e-a2d9-bf5ff04ba33c@redhat.com>
Content-Language: en-US
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
In-Reply-To: <72d1b0b7-c8df-463e-a2d9-bf5ff04ba33c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/2026 4:12 PM, Paolo Abeni wrote:

> On 4/13/26 4:03 AM, KhaiWenTan wrote:
>> get_interfaces() will update both the plat->phy_interfaces and
>> mdio_bus_data->default_an_inband based on reading a SERDES register. As
>> get_interfaces() will be called after default_an_inband had already been
>> read, dwmac-intel regressed as a result with incorrect default_an_inband
>> value in phylink_config.
>>
>> Therefore, we moved the priv->plat->get_interfaces() to be executed first
>> before assigning mdio_bus_data->default_an_inband to
>> config->default_an_inband to ensure default_an_inband is in correct value.
>>
>> Fixes: d3836052fe09 ("net: stmmac: intel: convert speed_mode_2500() to get_interfaces()")
>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> Since Jakub sent the net-next PR and forwarded the trees, this patch
> does not apply anymore. Please rebase and repost. You can retain
> Russell's reviewed-by tag.
>
> Thanks,
>
> Paolo

Thank you Paolo, will be rebasing the patch and update a v3.

