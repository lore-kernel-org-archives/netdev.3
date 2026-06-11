Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637802D94BA;
	Thu, 11 Jun 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199673; cv=none; b=jnERQn9Egrft7DsLCZ3t3kZJqDUQBaggk0Q6zisnu2dcd4uedCxoj8et7SuaNztfpBuq8iTbrSLycvsLFoGHKFz+En5ToiiDGTUBxSn8Ip2XvbCv/y7AePShCmIaIg3QwI6sBEGOPpJiuleBtGE28cwZEF8+qOAYCm5PJnElENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199673; c=relaxed/simple;
	bh=EjwItpzvPJkGo0jkccdylAMrRo5z7vcmV579UMGldCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMszgXRVMk9VyNFPgaNuiLXzWFu2Wfgu1G9R6pX7OOG9VudG7uxk4cdGdZE0wDvTshJIF/eJyeTo+Qoiyx/cGaQmcOuiXwQb/qPJhLOxUeed1kLdOvTKGX1uBp70R6KsWvm04CUs/VbiS9CyXnX5chSvGDmVUNifDYhORCHqW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/nTNmGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/nTNmGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E61F00893;
	Thu, 11 Jun 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199672;
	bh=EjwItpzvPJkGo0jkccdylAMrRo5z7vcmV579UMGldCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J/nTNmGccMsABDlTrZ04xGfARU0xvILX58TUYB3dA9f2a6q5eibxWpSAERdfHx8jq
	 Fgf/eRyx3tSflBAn28Cw48+TP/7OJcfQSk07nT0+Kydb5/ifQcQZxF3mptkTTyNSFm
	 xu8oxnfc2QH8tVzeuqVc0ch/J9BWJIqy1U5JzOtvejme9C+2UpSrI1/56Vh2sOy0jI
	 oSnlih63GXEq9rRhTOyhnfHx08ucALLREzUo3QawqUUvQfztEgYrEetk3vbMjLttkV
	 C66RInxKH2chgq77VWYyLHm4OoSw5V2cLpxRJnl9u/ikhYZUUAJsbQ5JBnzsq+/aDd
	 RxDtHBhFtH6ag==
Date: Thu, 11 Jun 2026 10:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
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
Message-ID: <20260611104109.34063873@kernel.org>
In-Reply-To: <20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
	<20260607183045.1213735-4-grzegorz.nitka@intel.com>
	<5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
	<IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 16:41:07 +0200 Paolo Abeni wrote:
> Fixes tag could be stripped when applying the patches as needed, and I
> think that could be preferable to a repost just for such thing, given
> the current PW load...

To be clear tho, this series has already been marked as changes
requested. Presumably based on the other comments?
