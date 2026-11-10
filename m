Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320509;
	b=VSzqUrLNh6oSdf6ifwSIsqmZSPifyRm+flRbK8wTMo7OSgVV38Ffq1yqXMTgAdv1U59v
	 U84YbG9ZVJL9Bj2PGxNWsZ3jJ67ksJy3gOBxYBjpuBsmxkKuPSJPfafM+HVmR1uJ6qCdT
	 mOdXnRagZOe8x+Qp5bceoM7Pg/+5P+7Nuaal8+AH8dtrQ1Y9B9avwIuZ9I+Zq3SOFc3fr
	 d4JTO5Q2dSijzPyZ0JBUA0kTVxO+qsmiWp1m1sS+CsPQ0pcKUxeemSzP3u1l8t5WwsDdZ
	 w0f9WA6NczBI1Moyi19lJZTCNl5AhBR/fe5niZcj3+A1jGgmJfKir+riHCdjdww4Kog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320509;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=v3lhzBFBMq4LYga21qk5T8I5GmEaP6tqTiM53U9v4wI=;
	b=qBgBKKSp9TZMCvTFH3FOAVaIGWnroztVkjwJKntcHvtfA60wDuWVIzf5U5stE1rOMgAO
	 0rW97U6Ysax2Qbs/1b4MbdsU98Iqjpcs6i2N/Y8ICqqEqvr2miHFVlY8TmjfLjIOPmSYG
	 0RQyPQvK2ruE/kBlhPAAVVn8lXkONTls820BkqC8aeXFDAITqjLOAaKfwK0zXGQVeP4Hj
	 LczTZq10fp81d8q/RZtlM6AjQu4ix0gIX+khArJD6H5iTWufpRKWkHtYnsLr/3IZZW/zX
	 Or6K1/eZGCJoi6ivqkt8ohFC0GtbvRSmMwcRNc7FFcElipL4H/xWKQZp+JKwVsozrtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NqPlxJvq;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569460A2601
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A569460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NqPlxJvq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320508; x=1825856508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sEGSeEMxiUowRbiksA78d95S1GDUrZHi6yi/8NMwJGU=;
  b=NqPlxJvqX70dIz+vyhVvw1q1IGqqyh6MXbMW+IuuUUfZDZISXto5RVF5
   itLLsU0WfvRxJdHmz4tb/t3mLxg7ZVxcuvpDrvMdv3gvRHadlbqgs9vTR
   gzGp3IwjFjB05DzbF0opO0YIcyCOK6vwr3k8jQGY0akqbkYGEdzuBGzcp
   vPkYJlqE7wnX7mWZP0CCl8ci4MBlrpVnc6v9R1GcZJjayf15it0EO+esX
   dzbHpggE4+SunENjPFyrYIkZbzEhWyAh69KOHCeJq6A/iKuxhyM9iijmO
   GCusW6tJ6Lv8n6DODQ7TytB6xiBTb3+hLSE72AabGJXTr6cLrk/wJS+Ie
   A==;
X-CSE-ConnectionGUID: pF4ZbxMxSaGeyBIlBKpm3g==
X-CSE-MsgGUID: SkTvqrDAStKlTdHZDSU3Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2947970"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2947970"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:21:48 -0800
X-CSE-ConnectionGUID: ehHpVLaxQBuOZTIriTvhNw==
X-CSE-MsgGUID: kv9ThO4nRgyZEGFiECaJ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9898211"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 10 Nov 2026 06:21:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5020599; Tue, 10 Nov 2026 15:21:45 +0100 (CET)
Date: Tue, 10 Nov 2026 15:21:45 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: thunderbolt: Stop queueing Rx buffers if
 allocation fails
Message-ID: <20261110142145.GA259790@black.igk.intel.com>
References: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
 <179406690879.994134.8991092134542553771@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179406690879.994134.8991092134542553771@kernel.org>

Hi,

On Sat, Nov 07, 2026 at 03:55:08PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 3 · Medium: 0 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] tbnet_poll() (drivers/net/thunderbolt/main.c) can stop Rx
>   permanently when a refill fails.
> - [High] The new deficit-based cleaned_count in tbnet_poll() (lines
>   829-831) lets a NAPI poll that runs after teardown allocate and strand…
> - [High] tbnet_poll() no longer completes NAPI while allocations keep
>   failing and the ring is empty (the new `return budget` at line 936),…

I agree all of them. I will submit v2 with these fixed.

pw-bot: cr
