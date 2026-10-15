Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3F38C421;
	Thu, 15 Oct 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051408; cv=none; b=FfOGtw0kjez0C8Zsx4GzO3wxWOHirHUsm6fugU020THEAfz6PU6xSZ2LC0PjbBIl2PuLLx5wxGHq4iTmA5WqgpsKqBWFMBeViS35j+kRArjCl3w1pw6SGEiIKzFd/0weq0hKfPhlYNC90qizLOWhnG/ln9s8pNqQPlOri7720Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051408; c=relaxed/simple;
	bh=sEhQ8KBsekhw0zbOdanprd8DiArMJXCtOwTggfftcmc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvQ9SSWZcdqNyjGQXnxm2EZWRt2OywJ8nhW7XBKZs9pkkVTzGDqq0ThDG224nXMziAtSYVXEARGuY4W65co5xs9rg9IwmcYLdIo5xdOAevTZvwraKyo1brPjazomLC7erEednj55toYyMarZy1961mOCED8WpGo2yEVleWQvBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R5htUudS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R5htUudS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051414; x=1823587414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sEhQ8KBsekhw0zbOdanprd8DiArMJXCtOwTggfftcmc=;
  b=R5htUudSdesS96s2AxQ4AnUWo4B7FmAz2ISvJHathJRoPWoWK6F6ElwF
   pNjbXAg+4fLt69ztuh2ZvVkNP7quJtyoTrq1dduRZq8Cv2GE39cZYG9/Q
   3gz7z6QofV2ZmgOVg03LG0vmrGoG1ZbJVk3+luk/eB4mwsn5aZumG5XbF
   s58oIexxunWdaBVjCoeIxsmTMA7Ek0fQrDCbY2kOTXCQPIweotk8tFk/I
   O2DfEhcQkTRIiLhX7oHshogAERgB/MYz6oe6gI6TqYK66fC4MWTMTYENv
   /1secWf1Fz58WD3gHztYpCl3+13gPjJj6EQdHBAGcPn2edyqdq4uCYiz+
   g==;
X-CSE-ConnectionGUID: Vay8vR0DQOiEN4pPhKguDg==
X-CSE-MsgGUID: wtEBimCOSSy+7cz24yqZ2g==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="65077714"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 01:03:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 15 Oct 2026 01:03:25 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:03:22 -0700
Date: Thu, 15 Oct 2026 10:03:21 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Jakub Kicinski <kuba@kernel.org>, Sagi Maimon <maimon.sagi@gmail.com>, Joe
 Damato <joe@dama.to>, <netdev@vger.kernel.org>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<daniel@iogearbox.net>, <jacob.e.keller@intel.com>, <suraj.gupta2@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
Message-ID: <20261015080321.zefrpa6ylcbsk3uq@DEN-DL-M70577>
References: <20261004083759.1016519-1-maimon.sagi@gmail.com>
 <asQ1pF9AAqOiEo3r@devvm20253.cco0.facebook.com>
 <CAMuE1bGXcNwKKX1firkq6eEzymkrDOp8PnnowMzz97SibtpoSQ@mail.gmail.com>
 <20261006180210.03a15e52@kernel.org>
 <20261011084652.c5y3zj7wzmj53ur4@DEN-DL-M70577>
 <d832de5c-a01a-471d-b935-5ea00d1c5794@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d832de5c-a01a-471d-b935-5ea00d1c5794@redhat.com>

> On 10/11/26 10:46, Daniel Machon wrote:
> > > On Tue, 6 Oct 2026 06:44:55 +0300 Sagi Maimon wrote:
> > > > Agreed on the helper.  As on v2, I kept the fix minimal for net, and
> > > > will send the helper to net-next once this has reached it, with both
> > > > axienet_dma_bd_release() and axienet_dma_err_handler() using it.
> > > 
> > > Let's do this now, trying to keep fixes small is a bit of
> > > an anti-pattern
> > 
> > Out of curiosity, why is that an anti-pattern?
> > 
> > I'd think that small fixes are, in general, easier to backport to stable. Is this
> > more of procedural question - if the whole fix gets into net, it will get merged
> > into net-next by the end of the week anyway?
> I'm answering here because I can only guess how scarefully long is
> Jakub's email backlog, and possibly this could get lost.

I appreciate that.

> 
> I think the key here is the context. This revision is incorrect because
> in order to be minimal intentionally adds a significant chunk of duplicate
> code, but such duplication must be avoided, the 'keep is small' is not a
> good argument to allow that.
> 
> I guess a one-line alternative implementing a different solution
> (if existing) could have been ok.
> 
> /P
> 

Thanks for the clarification.

/Daniel
