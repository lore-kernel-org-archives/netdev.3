Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D033B6C1C;
	Mon, 16 Mar 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676404; cv=none; b=KOWjJ6eCj60g+2ViLlu1jvzOm5+EZ6IWTwIXJ+u26AbrbOziHFJH5xFaR27PGoEy29MRxJCxZ62yd83KqQ9dNEqYNUGNZufJ3PSrPXXReA4F+DQq5ue9+idjiX6YaPKS96nylMcDJPb/C7wkKq527Bw1uqNPt/LBMQUjwEAfwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676404; c=relaxed/simple;
	bh=RFCeHO245U+8njJknw5qYZfSbXGH8eJzzpTIJVHBseI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maUNPO7y6LfgJdJaetq9/ouR5JCKZKIp14ccjCOCIn6wmsz39zANf0IwFQaIx73X+MVEjnCnTjsVV+33nLty6IqNmlKNznot12ePW99adAd8myie4RZ2QXzlHQHNaTFKR2b+OQdpgzTZrGFvbABE/SfMci/bg0+Ch9SqPT3M86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sx7XCvac; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sx7XCvac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773676398; x=1805212398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RFCeHO245U+8njJknw5qYZfSbXGH8eJzzpTIJVHBseI=;
  b=Sx7XCvac3UZjxzH2LqrBaHBOk0/Gmy8vMSWFR/+ao8ukosSY/hvBt4KK
   c5YmwmVsN1IveMgWlGn51g07Ahl1huamrmd2cd8fWr4HEWJVrFTkjyKGE
   J2XTXmpiKo2xtORSY/ThqOfuURYzNJ/i6PcRG4eqt/YhT50F9qAi8dWsE
   cULviul/2yUwbA2a4nxpP7KjGMoHjsbQ+fbtZi/zVpJMLXS+HB/24BON/
   8loiAo0QJd49tLAtSzXZRDeaSP03osEBwsckDNnuH/u3+yOEUnzvh0Ha2
   G12RdMDIH2Y2FOcdRiO12zr/ola8mb3kJqV5viONwvu71NCnVYvCfWN1t
   g==;
X-CSE-ConnectionGUID: AGjEUvTxScS1GJWRN5ZkaA==
X-CSE-MsgGUID: nCT7RaovTASJ4VLkqczhsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74585872"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74585872"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:52:58 -0700
X-CSE-ConnectionGUID: 8B/+cPsTRY2JMvKtViM4rg==
X-CSE-MsgGUID: q5xLZ4WXTfyvzJA0ht/Tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217769834"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.124.223.96]) ([10.124.223.96])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:52:56 -0700
Message-ID: <8d1304ad-c123-43f3-b007-1b89d5490c5b@intel.com>
Date: Mon, 16 Mar 2026 08:52:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ntb_netdev: add SPDX-License-Identifier tag
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>, jdmason@kudzu.us
Cc: allenbh@gmail.com, davem@davemloft.net, kuba@kernel.org,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260315203345.13657-1-rayfraytech@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260315203345.13657-1-rayfraytech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 1:33 PM, Oskar Ray-Frayssinet wrote:
> Add missing SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license of this file.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index fbeae05817e9..3890074b26c9 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
>  /*
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
>   *   redistributing this file, you may do so under either license.

