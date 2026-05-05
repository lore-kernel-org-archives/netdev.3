Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392D3C4547;
	Tue,  5 May 2026 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963409; cv=none; b=KBq+a3VRuGe3Ttxn/kOje3PokziajRjfwykwxhLfzZZvYd+iIzRyx7b9T684o08l1ObYELllraVF289n6bCKPEia3LrCr3ba0iUHoWifcm6brN1ytGg/qVOnxUWuSLHclMDddMAI/mv5/Mnet0OFetTTagsEmW5350lVCO+RooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963409; c=relaxed/simple;
	bh=b/K78SLDsaYn8UcX8zw2dpPLo0sAfurOR0cSeqL6BuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7Q2jYAB8/tZLavLTEZ+OJAwifXvmldo3vf7XQd9bRBhmw9DJKMQ79mT4OgUaMKxwRtkA0b1frhyODeMJkU06TaxRlxJHjFDNNQ7MByYV9qHFcHcJGUVGQI7Jk2MINe4Pk2kKqN7HuGra44uFdZktI5CkprTZOknDsvmhdNhLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkPo3bU/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkPo3bU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777963408; x=1809499408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/K78SLDsaYn8UcX8zw2dpPLo0sAfurOR0cSeqL6BuM=;
  b=DkPo3bU/gsZJUq5sgb0HgPWrGg0cAiG23aYLHe1O492lKNqeQ3mAyFNr
   23XwI8gtmj+FXdyioc8Tj284Q3lBv8HI7lDn+m0BX2R8bofDXrtG1lw3a
   mwa8KenasPZJlAflK+igsQSh49Zjus9+efSJmGzS3xc1l2NLksiKX2ElK
   OkbLt6uZnkDnTqHBEKfYdb8fdPUhK7JEUIglvxZi0LJ6WjyC2ofCqNLq7
   o08KfJh/t7cdF4A2g8h8LfsRokAtxCsTmeHFgq2A05ztJAKTPvZKX29Xo
   80l1wyjcRk++QJjjwffGpPmGWcmKn37NNYqNhN6J9mimpXAiXgCUkOe6E
   w==;
X-CSE-ConnectionGUID: a8l8ZeDwRDyFd/J0eOuvjg==
X-CSE-MsgGUID: DuKTLgDRQTmk72uZlpZqlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="66354988"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="66354988"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:43:27 -0700
X-CSE-ConnectionGUID: 61tlT+o/QcOXcOweNtWJPg==
X-CSE-MsgGUID: wiD/NJYQQfmvuL1e1Wx/sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="237506227"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:43:25 -0700
Date: Tue, 5 May 2026 09:43:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next] net: usb: mcs7830: fix typo in module
 description and clarify it
Message-ID: <afmRigJK0yPrJZYy@ashevche-desk.local>
References: <20260505013504.45975-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505013504.45975-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 06:34:59PM -0700, Ethan Nelson-Moore wrote:
> The mcs7830 driver's MODULE_DESCRIPTION has an errant parenthesis

MODULE_DESCRIPTION()

> and does not indicate that the device is an Ethernet adapter. Remove
> the parenthesis and improve the description.

...

> -MODULE_DESCRIPTION("USB to network adapter MCS7830)");
> +MODULE_DESCRIPTION("MCS7830 USB to Ethernet adapter driver");

It's better to align this with the top comment

 * MOSCHIP MCS7830 based (7730/7830/7832) USB 2.0 Ethernet Devices

Another option is to align to Kconfig help

	tristate "MosChip MCS7830 based Ethernet adapters"

(ideally all three should be the same).

-- 
With Best Regards,
Andy Shevchenko


