Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA56313547;
	Mon, 26 Jan 2026 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422079; cv=none; b=MeabeXBGPVTVSLm0RlvL4zZnrHUHj9QKC9Pw7uP6sEt3NRcKcB7e6ytoB5y8fbPQ3CGHMW0BYtU9q8QXQkAvkMaNpwfRkVsH++NZaXI6+REPu5vsJg3dhfrwIqSsNRBtKBDygp3SFc5h0GLeRltucvb0lEtuhmkoFEdnOOf0Ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422079; c=relaxed/simple;
	bh=i53QC34mmVK2ZaeyBA2qjvIBa8TfbY7lumbUxES+2GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8hGkcED5Na61z7MVtD4X6jIL4r1RN12RE4opK1FvVwSgU1JFJFLTwx4EtFDxiKlRqkJfCR40k8xqojn1LEA7sWr3idQC5pA5naYqLwzuKD/qitUxKWnKutvXa6jktLvvv8gcG7EHx2pVfpWvBIXyKuFw366zV9oTSeWFVixnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrkgaYtH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrkgaYtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769422078; x=1800958078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i53QC34mmVK2ZaeyBA2qjvIBa8TfbY7lumbUxES+2GY=;
  b=PrkgaYtH6PQGDzpIO2enA6MjrU6fOl2ZY36ttdjopARAxOJuR31mR19N
   tBSm0R4TrXMnxPzkJ9NT14FtZnvutoiwQEfAE9Wcbhb3O2LoQF3F4vK3e
   nGsOKFONUj7iAu2ft3+x88vCHEsL3Drq8cCxORiqpeBLDwddjQzP162BN
   1micg6C/BDxBNLdn9qOugeGQ9spqpHMT8P2zyOo26gs+MOMRMwnQzhhxr
   J9DSTqc+l6LMvvkwSDCqCQulY5xRlHsJlcIkLBCAfLVsSuH0Ac2D/m7az
   6xqCHpyD7jOVFVV373krp+rbaFeVlQQ/OxbPCiJAeP8TCdhi/a+VG94er
   w==;
X-CSE-ConnectionGUID: TZu679eeQ7+XGXWI3eMppw==
X-CSE-MsgGUID: GvXtyQoKSGKTTnfPD/65IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70755953"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="70755953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:07:57 -0800
X-CSE-ConnectionGUID: 0APbs0HMRe24HbNouuz9Lw==
X-CSE-MsgGUID: Yk+1LMP8Ruagh5YFaJaDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207529230"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:07:53 -0800
Date: Mon, 26 Jan 2026 12:07:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Petko Manolov <petkan@nucleusys.com>,
	Oliver Neukum <oneukum@suse.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Foster Snowhill <forst@pen.gy>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: switch to two-argument strscpy
Message-ID: <aXc89lDpfHQFVX-7@smile.fi.intel.com>
References: <20260126035052.31216-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126035052.31216-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 25, 2026 at 07:50:15PM -0800, Ethan Nelson-Moore wrote:
> All instances of strscpy in the USB network drivers use the size of the
> destination. If given only two arguments, strscpy will automatically
> use the size of the destination. Make the code more concise by
> switching to the two-argument form of strscpy.
> 
> Also add a blank line after a variable declaration in catc.c to adhere
> to kernel code style, since the surrounding code is being touched.

It should go after your patch that drops some of the strscpy():s.
Hence make a v3 as a series of two patches.

Code wise this LGTM, thanks for doing this.

-- 
With Best Regards,
Andy Shevchenko


