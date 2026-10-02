Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7A3AA4F9;
	Fri,  2 Oct 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921046; cv=none; b=h9G5nQ2n1FKizCNC0ReOd6smeQSizH3Z5NsvHkfVCTxr2YhhK+9/Up83Z1qFiteMCcWvdIrmLE5iXjn3ixyr+a8uotJ5KL/7nMqq4A2AcmFH0lUnSTXvi/JHvYyzI/rvP4J62dK2Ir017YcUqk2jQOm1L/seyNzgeE1JXX+Dsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921046; c=relaxed/simple;
	bh=P2YaFlVSeH7dakudj/I+c5FgvdXTyfP7I0tX8V+8nbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKlMnICT+dyJSDtgg18p0+7Os5cEElRFMhKFud4nCrqXqr6h4YM+E58fXF/17aK3mcsRHbBTVgQQNrmBV59QB63hd/XBg/uwtlWHVxsV/5U1LL8nwEggT905C7FKQQjD0bt8nRdrUbBUzv591zlDRsWU4vkshVAopdjfEUsxCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaHfrfeU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaHfrfeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790921045; x=1822457045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P2YaFlVSeH7dakudj/I+c5FgvdXTyfP7I0tX8V+8nbI=;
  b=HaHfrfeUvFJyeYesocSoimt9Lx+zMBdB3/GJBN/ArrAIYLAc44BrnuvF
   hHi8I1FV+vhu/jveHBeOctLoVNgdIJRJK4c0GxKpsQ7cTDxAGq8DA7ZsA
   XRNMh/PRfUUIzM+U3hfaC6ffAv/mEDgGt20c9OFQeWN74FVnpN0u2QOBF
   R9hzm75EqWIkn1/WlXyl/RgxOy6AbiYH4C2jMv2W6MbAa2hKi9Vs8j5EG
   g2naf38nkY0PnP4rmWQN6gKJW0n/95oSrtJQN73kYPjZAIl2SsCwgmsyt
   5gFfsU678Nw8Pvzcsq9qV/XsT9XOFhfgixkKZmI4hS9S0haDCMhf2o1yU
   Q==;
X-CSE-ConnectionGUID: LIQ5sLjeSdacnRES2IBCXA==
X-CSE-MsgGUID: +464eqb9S6O9ecmXd++QVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91706922"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="91706922"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:04:04 -0700
X-CSE-ConnectionGUID: kLLusgD8RIeBUT87MbHsYw==
X-CSE-MsgGUID: JRn+AZwzRlS/lcktmvMdqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279436940"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:04:01 -0700
Date: Fri, 2 Oct 2026 09:03:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev-bot+sashiko@kernel.org
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, guwen@linux.alibaba.com,
	lulie@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v1 1/1] eea: Drop temporary buffer by using %pEp
 directly
Message-ID: <ar9JTAoL7JcHF_NW@ashevche-desk.local>
References: <20260929082722.3368741-1-andriy.shevchenko@linux.intel.com>
 <179089728102.434549.12368098081790653201@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179089728102.434549.12368098081790653201@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 11:28:01PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

...

> [Severity: Medium]
> Will this print only the first byte of rep->reply_str?
> 
> %pE does not look for a NUL terminator. It takes the buffer length from
> the field width, and when no width is given it uses 1 byte:

Yes, completely forgot how it works.

pw-bot: cr

-- 
With Best Regards,
Andy Shevchenko


