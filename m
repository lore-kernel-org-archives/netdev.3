Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020E38A715;
	Fri, 10 Apr 2026 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853498; cv=none; b=rnObwaST5t91f4x4sO5c5DmlMbJ+gapSzGx6Jsz67Dpfyc9w4ggWw/Bcipr6ST+VEcHBeBoggSS/jiq8XkEeyJD5sm0G6nlGo5YxWzDOzM9+GksLR4cyuXsT1RCGAeUQZKCwt9lzEuXbLR1QC0LSU8/9xSxSCFe1lQq7avFt+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853498; c=relaxed/simple;
	bh=B6+j5N5qAy6nbb1b9iueruT9QbUx2CuqHxkBpEuTEmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APvluf4JMlCPHxgBednpLzHUF8Ya0rcvWxF87W7+6cXk/Z5uhmKmSH57irEOTRtg3ZfPKqAagtjM/D2vlIAKHgLfIhhoI/wjoy8+Qr9Gf8XE9iW85iUsJh0ykoiImptB4NmQ3OUhfuA1aTQfv643PAZlP+A/SYLN8zYtoiYMFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmBU1qDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmBU1qDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62914C19421;
	Fri, 10 Apr 2026 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775853497;
	bh=B6+j5N5qAy6nbb1b9iueruT9QbUx2CuqHxkBpEuTEmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmBU1qDNA8QqEGMGjmAJtjkRxxIl4Pt50tPXswPzd/pORv/6YRvby1WKbSvnlulgv
	 FVy1CaNm+G124JwlGB5e1etPOAG3+cwzCUZOvf9vNnHLp5NlZOPQGO/ygUxUOSCPAY
	 bjcfCTBT4vi9Iab8Rp8PAkXCAWhfnia6mZ+2+rk/NasCH7zL5ERjxWZIe+W8x/oVpK
	 VtPrL+I9S4YkpkhbbJ+WsY8NNx/h95KZSWpmUdKnJr9mQvz7Vu3uU96z7TthrBlDm+
	 fbb51lN3B9gFHcV7ufIyzM3175tO+dPy9Bzff5p8FiYYWNdnfpq4adqUaJ3r3ong8i
	 jXWkNvc1XftxA==
Date: Fri, 10 Apr 2026 13:38:12 -0700
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
Message-ID: <20260410133812.4cf9b090@kernel.org>
In-Reply-To: <IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 14:23:58 +0000 Nitka, Grzegorz wrote:
> Here is the high-level connection diagram for E825 device. I hope you find it helpful:
> [..]

It does thanks a lot.

> Before this series, we tried different approaches.
> One of them was to create MUX pin associated with netdev interface.
> EXT_REF and SYNCE pins were registered with this MUX pin.
> However I recall there were at least two issues with this solution:
> - when using DPLL subsystem not all the connections/relations were visible
>   from DPLL pin-get perspective. RT netlink was required
> - due to mixing pins from different modules (like fwnode based pin from zl driver
>   and the pins from ice), we were not able to safely clean the references between
>   pins and dpll (basicaly .. we observed crashes)
> 
> Proposed solution just seems to be clean and fully reflects current
> connection topology.

Do you have the link to the old proposal that was adding stuff to
rtnetlink? I remember some discussion long-ish ago, maybe I was wrong.

> What's actually your biggest concern?
> The fact we introduce a new DPLL type? Or multiply DPLL instances? Or both?
> Do you prefer to see "one big" DPLL with 16 pins in our case (8 ports x 2 tx-clk pins)?
> Each pin with the name like, for example, PF0-SyncE/PF0-eRef etc.?

My concern is that I think this is a pretty run of the mill SyncE
design. If we need to pretend we have two DPLLs here if we really
only have one and a mux - then our APIs are mis-designed :(
