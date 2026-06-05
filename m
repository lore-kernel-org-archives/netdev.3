Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FB30D401;
	Fri,  5 Jun 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701978; cv=none; b=sIa9UXDVC9/QR2Wsg7FUmIGUKcISTXG1HfqwaIYgGtd3CnFrAVkJg8cSBw5GMs+QMx2DGpSMeNjpeYguh506ipB3V/8k36w4XAlEKH/83Glzfn+7llNR1nGnvDjhrPNvBJbS+SOXBFPoMFFKmqJ5SbT7lPNDj5ToWHFwhs0z964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701978; c=relaxed/simple;
	bh=KnZFrCUbyhR+riefVqmFHD4g1Bj567ZClbQUDv/JWMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVy+gsvurY6mmgSZrwbcCOFV2Htrnkfq3tChlVRIj5veTVjJAN8dkz7ww8y01ALIFHg1T+xFV0eUypedLU0xjHOSqZ0Mzqu28ZMJFEq97UhzhakwVeb9N7t95gji1MGH0a5FhEIDzT4xTLWkni0urr8bShlkZ9yQSdabpTFVPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7403+Oo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7403+Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FBD1F00893;
	Fri,  5 Jun 2026 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701976;
	bh=IG96N48IaU0YB7Fwkuesk+PO+SJtj7KaqjiAzFCI5Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E7403+OodPvRrNF8Mu0tD+WtYtsyw6n74A4QVl6z/iRe4WKlz9LJkPJfmpHf8WcEk
	 1RoDOPsMm31w8ml9+DhR3SJuo4i5omE65p5UL1zp/fKi3IRzx7dAgtqZ5rB2T8JHCX
	 Dz9pAASe2FCFJq9BUaXNeKC2l5HTg31yR9IBmDe20nYxJ4F0p0oVMy8Xo4U2YnDTVd
	 aPuAr9BrPNqhLX/3NoBy45reAkNQtPNpTS8l5iFhQ1GBAUwCeD17ddf7dnSCNsbjhD
	 d1AN7RDTojfSWFZDgAjDYl2DNqgpHj0oojBw5JQooiRDROVnTS9avrCEA2JPartTrY
	 rZpFXnToUrJMg==
Date: Fri, 5 Jun 2026 16:26:15 -0700
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
Message-ID: <20260605162615.0987ff2a@kernel.org>
In-Reply-To: <IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
	<20260603183036.7c4762d2@kernel.org>
	<IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260604155422.167314ff@kernel.org>
	<IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 16:10:19 +0000 Nitka, Grzegorz wrote:
> Hi Kuba. Just submitted v13.
> 
> It includes the following fixes for pre-existing issues:
>   - dpll core fixes. Each AI review concern (3) is addressed in separate
>     commit. If you think it's better to squash them, let me know (however
>     it addresses issues from two different 'old' commits).
>     Also, the hint form AI  to use different dpll xa_array (parent not pin) to
>     address one of the issues, it simply does not work (WARNING flood observed,
>     more details in patch 3/11)
>   - ice driver fix for potential hung on flush_workqueue in error path for FW node pins
> 
> As you noted, two other pre-existing issues are covered by ICE_FLAG_DPLL.
> I left the code as it is for those concerns.
> There is one more pre-existing one, related to ice_ptp_link_change. As the fix seems to be
> rather simple one, I believe I need more time for more comprehensive testing.
> So my preference is to go with standard fix-path on 'net'.

SG, thanks!

BTW either you or Arkadiusz should chime in on the NCO thread, please:
https://lore.kernel.org/all/20260531194423.383366-2-ivecera@redhat.com/
Shouldn't take much time to express an opinion, I hope.
