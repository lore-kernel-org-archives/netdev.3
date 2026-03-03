Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FE375ADC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524965; cv=none; b=QSvIvQCivIDrg4btBqNWEc7BjjHYvC/1Zyp1JHcZXk6bD1Yt15j+q4kWAIoN4efYDJzdJur8vrqXamp78cgaolgpu+QcVRa9b4rlyqDxY88TSYVh3hgF0w5xsl8o7+dOb13I86YbLy7DtAw3HgvAA96qdf75hCDMcMKWVOxkchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524965; c=relaxed/simple;
	bh=jhRlGfBhb489U8ltCUEQB1pbYFEqF9EJuEmdtzSaZLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Q7z6wAtjCbbDkvI3WqjTbjhQZ54WxUmnqb6XhTafqOgCVcs10J8WAFLVcsr+Q95tDRm+JbaMYoOi9lBqzY7yJvf8CXoZWdLsXr5txSp7Xo30l3E/TBAgHj+MM46JoclFKMLDuRXUSDZQ+7YK4+4qUm/ul4CnXzhb8b6APZfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0fg4x5d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0fg4x5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772524964; x=1804060964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhRlGfBhb489U8ltCUEQB1pbYFEqF9EJuEmdtzSaZLc=;
  b=j0fg4x5dIw/mpKESjuq5u4qCSuZ3oqnCDzk2c9sQp30aQQZheL8K6I8k
   zRln229xYzZrlL8iNzGdQKHHYpwbcNx63qE4+RS6oAIbGwL8Md4tHDLuu
   gD/xaVkp0DQT1DhH6FBoRQ7zdJiJwT7kNe4nVino3KRjRpuw9+QGS7uV5
   D0L+02lRfBm4QEj6uV9lrFHYZ83ChMOEqE6mZCedkj5fM5RE+3LhWik/Q
   sYZHOIP0CwzQwNSYgDUlkNUdMxPzUhuqEVstiMXyXTuz/93v0EAQU8Rpc
   VaE40Ubpmt1WFDAfYTKXcsOh2EKkISE8M+VZRakjpfBkICQP5afex/oKz
   Q==;
X-CSE-ConnectionGUID: FVpY8wEpTfGbRfwjl5yb7A==
X-CSE-MsgGUID: N9Ddo6mRRiyBkra/xsYhpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90948395"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="90948395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:02:43 -0800
X-CSE-ConnectionGUID: fLrkU2CHRky8S1ml9zMRag==
X-CSE-MsgGUID: 1ZrI5mT2SqChC88s7QAIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="218030943"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:02:41 -0800
Date: Tue, 3 Mar 2026 10:02:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 3/4] i40e: Add missing header
Message-ID: <aaaVnmx_QHcpiVbG@ashevche-desk.local>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
 <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 03:41:01PM -0800, Tony Nguyen wrote:

> When cleaning up another header I have met this build error:
> 
> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
>   105 |         val1 = (u32)(upper_32_bits(pa));                                \
> 
> This is due to missing header, add it to fix the possible issue.

There was a v2 with the other (missing here) tag is added (it was given against
v1 conditionally) and Subject amendeded.

-- 
With Best Regards,
Andy Shevchenko


