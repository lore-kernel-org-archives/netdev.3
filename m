Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4C478E57;
	Thu,  6 Aug 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039016; cv=none; b=BWebRvoXun/H00aWZdfv5WfsazkD9wf/iCuPWvR6H2cU8ZXQACTEuvEf5Lhw3ZrQstchXoM9YCMTyrcRR4cYESL+i3W8InugHGed7Fm44nqXIFqonFUgES5Du3JQPJVTR+j8XvMSynpMH0TqDLahKlalpvF1dRL2BjE3XDAJfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039016; c=relaxed/simple;
	bh=3RYQswQOUCpHxdifoM5pD2Uy/DDMtixSFygsWBINfwU=;
	h=From:To:Cc:MIME-Version:Content-Type:Subject:In-Reply-To:
	 References:Date:Message-ID; b=ZmxDO2Xx/xqfES40qmlpxllzYl1/zhRFN6velW1y+DTXtv9AySWKyYV+nx+ZDuiAHG/kLb42YQJZ9yMUyrmFwdJzbce0iKj1vjX3boJnpMnLzh26wJRQSYN90wc0uOGUkTgMCEQqqoj6QcYEa6Y9s8xxcTi/EIPDb7RMZbt+GFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDY4k7Cj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDY4k7Cj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786039014; x=1817575014;
  h=from:to:cc:mime-version:subject:in-reply-to:references:
   date:message-id;
  bh=3RYQswQOUCpHxdifoM5pD2Uy/DDMtixSFygsWBINfwU=;
  b=oDY4k7Cj6AOexLz4SnlC7wRmzLKqiaLhFX4IkfsFTu50bx2aDJbcaD7f
   Ux5xgELB+qY4SLQcmmbiu5FOrgJeURM5plQgJs4wmws64U/pthdKGE4QJ
   U9ihH5NWVAw5d0thjUi7ssl8hxJHluyPq6aDIrHd7yU4m8/2CXn7tlYzx
   Am1pCDI+CJJlMeEefbK/4aTZwA5w8TBG8pymQ+WOKrZYoq/JRPHQoDbZP
   CxafVTtHPDLIVZQVKx+FmNDP9enQF1CR/kFgGfDwiyY2xeWXiCZqfQrqC
   Jv5luq2yb4WNPYwXd/hQ+eqmCO04QIG897B5KQLaK0NQyAaJ+gZf1Lk0Y
   g==;
X-CSE-ConnectionGUID: mdtXtHdqQIKwb53X7JOwpw==
X-CSE-MsgGUID: 0hNMY11SRTapLWUkiMZm5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="109437618"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="109437618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:56:53 -0700
X-CSE-ConnectionGUID: mVgShsRsSvSs83sqrakKdQ==
X-CSE-MsgGUID: YY53XFK6T+mQV6Wsj0e1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="259558973"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:56:53 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Jack Wang <163wangjack@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Jack Wang <163wangjack@gmail.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] net/sched: cbs: perform rate conversions in signed
 64-bit arithmetic
In-Reply-To: <20260806155253.50252-1-163wangjack@gmail.com>
References: <20260806155253.50252-1-163wangjack@gmail.com>
Date: Thu, 06 Aug 2026 10:56:52 -0700
Message-ID: <87cxvv2kuz.fsf@intel.com>

Jack Wang <163wangjack@gmail.com> writes:

> cbs_set_port_rate() and cbs_change() multiply link rates and slope values
> by BYTES_PER_KBIT, an unsigned long constant.  On 32-bit architectures,
> the multiplications therefore take place in 32-bit unsigned arithmetic
> before the results are assigned to s64 fields.
>
> For port rates above approximately 34.36 Gbit/s this wraps port_rate.
> The same conversion turns a negative sendslope into a large positive
> value, reversing the CBS credit adjustment.  This affects software CBS;
> port_rate is also refreshed on NETDEV_UP and NETDEV_CHANGE notifications.
>
> Cast the first operand of each multiplication to s64 so all intermediate
> operations use signed 64-bit arithmetic and preserve the value's sign on
> every architecture.
>
> Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
> Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_port_rate()")
>
> Signed-off-by: Jack Wang <163wangjack@gmail.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
