Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C626F2BF;
	Tue, 23 Jun 2026 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217072; cv=none; b=fShk68R6+rlb6xRDbZTrbgAL8BKta7c7HcbU9SPSTP703PsQ8EqkAeVKlzdxNKqXKoWJ7HycfNfRCsVZxMzEYPx6ZEP1YNHLJuS9RaQ2Sb1HO+7X727gWhIYc0UYtiRhQ8IaATdLveRkjnqo+wRh2n7LBsOsb2fl21eRZOL/zJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217072; c=relaxed/simple;
	bh=L1fmSH/ngeQavYEYr07Dz490+UJrqa9tBu7ExUZOitg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgUFMjdGpOUX0YovKY1eKjXmsqpR85YRgZgWf2x0gllVDXndLNOvrqwT3WxkB73A7sxBx5xpt7zTh9nHr8Hzo/zo1h95ht0qXSzFAz+mmKipWvHzitU7JsB7PB9FuWkBTgo7/BmI9ZUMq/rqPVZFfYgpdq2tTtGmpsBLW6gxsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeTwnJr6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeTwnJr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782217071; x=1813753071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L1fmSH/ngeQavYEYr07Dz490+UJrqa9tBu7ExUZOitg=;
  b=GeTwnJr62DC98UCWnjq+4pk4o6Cg8Nw4BCfTtPMLIqa9TlW+X6wxPO1b
   ek+TD6TWYDRHvuYz0MGOkZi8NdcmAwL0oPrVWBaDB6lNu8uNAfRYAzSuk
   U81yXrk9wGgCzeUyiDwmnw+0U7AZG3ox4DUsvc+glteAv7hF8Zs7eCptq
   LRNS4bxHaGG9MNKUBqxY7ZTZWVsmaPyMZ2Jdu2VcmypnWi7udAaBDjrM8
   3pphkCONuytPoD1aesSgTL7RZp5vhiSS8vviBAjP53iJQggFTsVTd08kC
   95Uejor0thjqslpztacrlDNjNDybDP2yAxNGF/IyElidtiJtQORv6mnNE
   w==;
X-CSE-ConnectionGUID: 4WSLVIARQOaMt/D2JOhxIg==
X-CSE-MsgGUID: MYXCnIgGQTCHUY35DctRbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82999146"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82999146"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 05:17:50 -0700
X-CSE-ConnectionGUID: Izw3kUsBS7yuTBUSDff/mw==
X-CSE-MsgGUID: q4sWQ8K3QhOczEFYXY7V/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254486432"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 23 Jun 2026 05:17:47 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9CB5F95; Tue, 23 Jun 2026 14:17:46 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:17:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 0/3] thunderbold: A few cleanups
Message-ID: <20260623121746.GD3066@black.igk.intel.com>
References: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781776904.git.u.kleine-koenig@baylibre.com>

Hi,

On Thu, Jun 18, 2026 at 12:14:49PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> I'm currently working on a project that includes looking at all device
> ID structures from <linux/mod_devicetable.h>. While doing that for
> tb_service_id, I spotted these patch opportunities.
> 
> These are all non-critical and also my quest doesn't depend on this, so
> there is no urge to apply these patches. My suggestion is to apply them
> via the thunderbold tree during the next merge window with an ack from
> the network guys.
> 
> The first patch touches drivers/net and drivers/thunderbold. It could
> theretically be split, but then this results in at least 3 commits which
> seems excessive to handle three drivers, so I kept it as a single patch.
> 
> The third patch is a style change and so is subjective. Drop it, if you
> don't like it. Here splitting would be easy, but given that patch #1
> already touches the same files, letting these go in together without
> splitting seems to be sensible.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (The Capable Hub) (3):
>   thunderbold: Stop passing matched device ID to .probe()
>   thunderbold: Assert that a service driver has a probe callback
>   thunderbold: Drop comma after device id array terminator

Fixed the typo "thunderbold" -> "thunderbolt" and applied all to
thunderbolt.git/next. I also took the networking patch, let me know if
that's not okay (I'm the maintainer of that driver too and it looked fine).

Thanks!
