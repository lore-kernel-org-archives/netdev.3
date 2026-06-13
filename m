Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFF125A0;
	Sat, 13 Jun 2026 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382477; cv=none; b=uQ++2mljBKBE0xdGifjXLiLaQ1dg/8TcbBRzFAbIinzgQ+SX7Hf7Pg8PFHpptu6tWzaX/PJF3Po2AC35DisnYjpBMJ9QWYGq6wCEet4sO9VCT1nZIK+0FB8A2RA+jOrafxkTCncuvXAHE9jh4JqAyW2bc8sNg+ognumYKG4OGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382477; c=relaxed/simple;
	bh=4ovALgOKX20p7BRaHz8M+StSi4whya61Xc6wqoKJ2BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHx5NZzJQsUc5WfsA6U1uWF67MYA/QYHA48v4WgvVKzzaPWTso3ahmzvNcfIFQEeh2NCmse/E8Li9/hyKYvMRnoyAgTzDTbVNz7Au1aCMgvfXtQlQnctPoPNc7gl/a094BimnWeVZWC44SROLtVk3bgjlywd9aKQMmzbFB/131Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgpB7cCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgpB7cCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BE71F000E9;
	Sat, 13 Jun 2026 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781382475;
	bh=QMmcuE8DSjrHYXf/QWms+/WUULv13ijGbv3LUEQ15xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KgpB7cChLyT+d4tgCLbidRVA08Bl5Xk8A6GLm6ZX3WBxB84nWepw1vCNruS88uc2i
	 5JTozl6uSmI+wawmrlUPl3Q7atMO3ByVqIyugMdMhixTTwj89Oc7eyK/Y3Mn+b1+Gz
	 c/zg7u8KYBkCdmTp8A3gVzbLylXWReQeq1YsuhBNnt1JrJ8lnjRksue+yAq4zTmCwU
	 gG96+1C3qh+cV+ZO9O1S/Qd+OW1TKtb/DxWIAg4/v7OC0BQbe+25uhsY4pS0WF2khP
	 3fWnOH+VsU/IkteKUnMmnM1MRVJt1mf3SjyRm0e06sJkQueLmTjJ7Z/n4lBpr+2yy8
	 iU2CjH56ZmNyw==
Date: Sat, 13 Jun 2026 13:27:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Oros, Petr" <poros@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
 <Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
Message-ID: <20260613132753.2b3d1f07@kernel.org>
In-Reply-To: <IA1PR11MB6219B836E61D44198B0FB5AF921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
	<20260607183045.1213735-4-grzegorz.nitka@intel.com>
	<5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
	<IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
	<20260611104109.34063873@kernel.org>
	<IA1PR11MB6219B836E61D44198B0FB5AF921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 18:36:14 +0000 Nitka, Grzegorz wrote:
> For v14 patchset, I got only comments from Arek and Paolo.
> In my opinion, after rethinking, Arek's concerns are not valid (explained in
> the responses). Maybe I could squash some changes, but the final code would
> remain the same as for v14.
> 
> Paolo raised 'Fixes' tags which I added and critical divide-by-zero panic
> Regarding 'Fixes' tag, It might be my fault or misunderstanding.
> I can remove them if we want and re-send the series.
> Regarding div-by-zero - see my comments about AI concern list below.
> 
> Also, what was raised by AI, I unintentionally changed WARN_ON to WARN_ON_ONCE
> in patch 2. I'd restore it to WARN_ON.

Alright, let me apply this.

But please investigate the situation with the notifications.
Maybe there are two create notifications because we add more info
to the second one? If not we should drop the duplicates.. YNL can
monitor the notifications during tests if you need a repro.

You can follow up with the fixes during the merge window.
