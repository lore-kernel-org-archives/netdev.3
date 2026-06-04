Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7F285C84;
	Thu,  4 Jun 2026 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613666; cv=none; b=Y1JN00X3KliNXZb+z40EvEphj3gJZbeUbTf9iBP0uKiCPkzad19Mw6zikK+1gpzBD41TERTf/XuggCUdIJ0ycKLZV6hMAKRysaXdXysSeKSq2NiIaH5Y+1X89ebnJF70oyvwyuN7AdAK5tsknEm8EokFsnuSqozV+ikpX6qVDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613666; c=relaxed/simple;
	bh=oXjJ7XjYMvV4qrB0SMbNbwChK2HbZT6xNUdwAiiSbzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4LwB0OSa7pedqKhog6Uy8NVL0iqG+iGKqHhMaqY94JQVG0pkjG3/qAokeOU7n8dkZ2zTPSrpVQq2eCftuZMABybznur2pDcBeAiFHlqu53o5u/FM60ldz7/y2t1tcoDmEnOzV73TCNogTeVfiadb78bD5YeTwf1ptYK339dMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWqVhDtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWqVhDtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76051F00893;
	Thu,  4 Jun 2026 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780613664;
	bh=3lMPwTETgOHXdjVrbiyEjoY0H3xuhL5jFk2nN61vumk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mWqVhDtl9S6NhuYYXnbfYOKqCQPIW+Ht1cApg/HEDqr1C792kFVYvQx9S0hUdEyRx
	 4DlsmC/nV1JjporWCyz4mimRtjEgUv4woONpG1J5QuYaJXXFMPqxZJNl9XXn9M8oTR
	 YmdudMQhInteUeITIoxa6pfFhK7D/vzKPaY1hyWVM4KW3i9aH7NoUkps3rGZ1OjXUo
	 YoiRNk0LxO4kYy63w183d3gvSayScBFJiWD9i2UsI+pzas/CUgy2hX1LE32dXqZjDL
	 tjZi7sInI33fhlM3jeukZY3un7hHLzOefigz4G8URTjoGQrtgFhfBDVKrEQNDFVaA0
	 AGIsuZuYEVK7Q==
Date: Thu, 4 Jun 2026 15:54:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Oros, Petr" <poros@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
 <Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and
 full TX reference clock control for E825
Message-ID: <20260604155422.167314ff@kernel.org>
In-Reply-To: <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
	<20260603183036.7c4762d2@kernel.org>
	<IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 20:05:54 +0000 Nitka, Grzegorz wrote:
> > On Fri, 29 May 2026 16:26:20 +0200 Grzegorz Nitka wrote:  
> > > NOTE: This series is intentionally submitted on net-next (not
> > > intel-wired-lan) as early feedback of DPLL subsystem changes is
> > > welcomed. In the past possible approaches were discussed in [1].  
> > 
> > I dug into 3 of the issues reported by Claude here and I think all
> > are really preexisting. But I don't see why we wouldn't fix those
> > first, and have a clean AI scan. Please send the fixes ASAP if you
> > have them, if they are trivial they may make it for tomorrow's PR.  
> 
> Thanks for your feedback.
> I'm not sure if I can identify exact 3 issues you mentioned above.
> I see couple pre-existing issues reported in
> https://sashiko.dev/#/patchset/20260529142628.1678955-1-grzegorz.nitka%40intel.com
>   - 3 issues reported in [PATCH v12 net-next 3/8] dpll: extend pin notifier with notification source ID
>   - 2 issues reported in [PATCH v12 net-next 5/8] ice: introduce TXC DPLL device and TX ref clock pin framework for E825
>     The first one is false positive in my opinion.
> 
> Did you mean those from patch 3/8?
> It should be rather simple ones. Shall I submit it as a part of this series?
> Or a new patch/patchset? (against next or net?)

Ugh, I think I missed that the caller looks at the ICE_FLAG_DPLL flag.
So most of the deinit bugs are not actually bugs.

You can add the fixes to this series.
