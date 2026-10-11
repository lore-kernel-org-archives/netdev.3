Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF6318EEE;
	Sun, 11 Oct 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708418; cv=none; b=hZLh/eQI6Ut3nKlW5LSM+uLbcYWats10emeTVCNdj5szSTc+CSN0TU3msK7asT8iZMYtNU8NF4NsuRiHVZkoOGEf51SSqPYmrt/vjaIWdHYcRwHKGupABVbB0Yd1vUmURXTcRpymMxmw13/4UlZZoOkwJgFT8zfd9jmvsEKr+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708418; c=relaxed/simple;
	bh=NFL1d+tnoc5IT5vRjBdw3J8nS66QldRxBGepGvo6Sqg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di+rEdPplLbvu4KtAouOowd41M3/FlPvWsnYVnjXn4rWLw4gVJ9y4dm/158opoKDsfzLSwGUnzKwO5kIbp+PJuYi66hu70Md6F1eLCES1ZDiNjJ9IT05Sz7SMj8thCJ/yJgrpDB9gj71PQSG3DMWK7A9xU8nkg3bUoWKGsVT7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Til4vhvx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Til4vhvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791708417; x=1823244417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFL1d+tnoc5IT5vRjBdw3J8nS66QldRxBGepGvo6Sqg=;
  b=Til4vhvxbX5AOfYNnN+rv0XktYaZ9/WMbctMWQskc2qjlH7BCydkxRq1
   EHsrbvToYLqs9vcx1P1qF5XgDu/orbymbwY1uOuQfwSGtP6BpbpSK1PMz
   4UJOUhX6/HB2ZDxriMDyw+rJ1C8ycJbBGZwNdYShG0SxI1OuYZGk6/wm8
   QEM5o+Q7r8hnvU7vl9sVv2ZuqnUcGqVpwkQ8OLbFS6mfv1atR+kFagPq1
   SWhlyzVyh3HQYKqK+4PaE2tIjHkHBQfDO7INJXbAK9dgxX4O9wdAA/0a6
   9N5wawVUHgfPAMOH/ndjqDtrq5QVnqEA02X9tsom8RgQn+DenPpTT8oBw
   w==;
X-CSE-ConnectionGUID: OFjkfmCJSja6H3ITLei1Jg==
X-CSE-MsgGUID: 4h5fsx6DSzucmxVQ2Pdjkg==
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="231957431"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 01:46:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Sun, 11 Oct 2026 01:46:55 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 11 Oct 2026 01:46:53 -0700
Date: Sun, 11 Oct 2026 10:46:52 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Sagi Maimon <maimon.sagi@gmail.com>, Joe Damato <joe@dama.to>,
	<netdev@vger.kernel.org>, <radhey.shyam.pandey@amd.com>,
	<michal.simek@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <daniel@iogearbox.net>,
	<jacob.e.keller@intel.com>, <suraj.gupta2@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
Message-ID: <20261011084652.c5y3zj7wzmj53ur4@DEN-DL-M70577>
References: <20261004083759.1016519-1-maimon.sagi@gmail.com>
 <asQ1pF9AAqOiEo3r@devvm20253.cco0.facebook.com>
 <CAMuE1bGXcNwKKX1firkq6eEzymkrDOp8PnnowMzz97SibtpoSQ@mail.gmail.com>
 <20261006180210.03a15e52@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006180210.03a15e52@kernel.org>

> On Tue, 6 Oct 2026 06:44:55 +0300 Sagi Maimon wrote:
> > Agreed on the helper.  As on v2, I kept the fix minimal for net, and
> > will send the helper to net-next once this has reached it, with both
> > axienet_dma_bd_release() and axienet_dma_err_handler() using it.
> 
> Let's do this now, trying to keep fixes small is a bit of 
> an anti-pattern

Out of curiosity, why is that an anti-pattern?

I'd think that small fixes are, in general, easier to backport to stable. Is this
more of procedural question - if the whole fix gets into net, it will get merged
into net-next by the end of the week anyway?

/Daniel

