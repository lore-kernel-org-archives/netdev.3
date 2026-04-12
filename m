Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFD2B9BA;
	Sun, 12 Apr 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005455; cv=none; b=uZ+IRjX7m0aG136cHMR9zP+2faDweVyBPrrz6NDEmSYgxoq/avDUzkJP3j6FvMW93YDjImPrQUyj2mUGROk+vHSVY5IQTxftaZhLmHKaeX0ivS41kyyIZj9Qsg8JtXyG7Vt2L6eRM06f17iuLRPQ4gnq9M9CdRym+PT0+NHsARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005455; c=relaxed/simple;
	bh=S32mcILpghlDeygeLc6FWvgkzRilryCAAV2qjAvE7zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otJ0ztobb8UQF2HenUgmBpvo4ILO0HPIYhdXmoM1pDvcLqH4yeB0Bewmv+MOprrhXFYL+jTT7KlFZP9bpA6sddoMw4kbfPLgZk+8B/oFgvTVtNJ1V5UUfBTO9CHiCsKw2tg3MYWjuH2AqPeW2A4QvOKfj5+EIq8tr15N7Nu38S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn/duyMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn/duyMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897EC19424;
	Sun, 12 Apr 2026 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005455;
	bh=S32mcILpghlDeygeLc6FWvgkzRilryCAAV2qjAvE7zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qn/duyMbgo37GSHoV3G2LBAX/Q7Mg5TMfft/GqI9baJml7Kwngrxp/fKSpMtigjBU
	 0RdXxHMONadZFd5hcDODRKBnRb1Z+LBlTCl+qA7Ki0xOOh/+9n6HMAeF/opCr577sK
	 4+tTD7qROvuftcL1WMYzeOyQusfrjlpRmShhqMJMAEDWHabDrxj8NPTm44YAeI78DN
	 WzDqZMWe4AtHofPAUKpyMjL4D5bIy4r+CuUtM7lBGNj79HsgP8DdQ5ve0NpmxRB+hc
	 HIOEq/86m3ca2jWogZRdXjP6MgBducQ3TztjaXEN7BgRM/zXG8q7AattQu4ttOZGxu
	 SPLb53CxJwrZA==
Date: Sun, 12 Apr 2026 07:50:53 -0700
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
Subject: Re: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Message-ID: <20260412075053.23660721@kernel.org>
In-Reply-To: <IA1PR11MB62195E2AF6FE5B102B2EECD392272@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260410133812.4cf9b090@kernel.org>
	<IA1PR11MB62195E2AF6FE5B102B2EECD392272@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 13:50:23 +0000 Nitka, Grzegorz wrote:
> > > Proposed solution just seems to be clean and fully reflects current
> > > connection topology.  
> > 
> > Do you have the link to the old proposal that was adding stuff to
> > rtnetlink? I remember some discussion long-ish ago, maybe I was wrong.
>
> This is the patch from the discussion I put the link in the cover letter:
> https://lore.kernel.org/netdev/20250828164345.116097-1-arkadiusz.kubalewski@intel.com/

Let's go back to something like that. But leave the OC info out of 
the XO, just ext-ref, dpll, xo? We can add the xo types later if really
needed. Sorry for the flip flop.
