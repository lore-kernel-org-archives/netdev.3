Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1935E1D7
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948507; cv=none; b=tG7HcrYKlJq7H0OgwZI/UWtiTe7yYpbS1xoZeSqTeSdu2q0pl2hgXRoUlpAIC1lCZ48cnDHJ78YYz0kfKxVUPspen6r1pSBBVW0TZAUo1NAxlPoqzdeDh6SzgU2ffEI0hbzSVJFx8QIO5Mu345SuxWGiBLT51lXAM10JwRxlSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948507; c=relaxed/simple;
	bh=oqYUQJaboN2B+M2hHb1WLYzzf/roWuKN3WyTx66Li1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F78ZtC8Q/VsT4IHhWxtfVb2KYKpiWnrwNgsmpspfIMXZ5lL9y2/wFQNnkArjmEnCCQzSpUwiX0T1mQOv4ePWOPLgkeb2GZxWn5sDmxP6GAD6HnheBp+T+rMwbYGIJI+haKvvb56La4MLNxHFaSzBqHDjvsPurqCB6PYFVuoyb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wf4Lu-0003gJ-Fo; Wed, 01 Jul 2026 23:28:22 +0000
Message-ID: <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
Date: Wed, 1 Jul 2026 16:28:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool : PRBS feature
To: Andrew Lunn <andrew@lunn.ch>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Cc: "Das, Shubham" <shubham.das@intel.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "D H, Siddaraju" <siddaraju.dh@intel.com>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
 "niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
 "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/26 3:02 PM, Andrew Lunn wrote:

> On Wed, Jul 01, 2026 at 09:38:08PM +0000, Srinivasan, Vijay wrote:
>> Hi Andrew,
>> I think there is a disconnect here.
> Which proves my point. The specification is not sufficient if you have
> to keep correcting me.
>
> The kAPI should be understandable by somebody who has a general
> networking background. Please write a specification with that
> assumption in mind. Don't assume the reader is a test engineer who has
> used PRBS for half his life. Assume it is a brand new test engineer
> who is hearing PRBS for the first time. That is what most engineers on
> the netdev list are. Me included.

I think part of the disconnect is that PRBS testing is a signal 
integrity test, not a network test. In this case the phy happens to be 
Ethernet but it could just as easily be PCIE or USB. That is why it was 
heavily suggested to me at netdev 0x19 that this should be done on the 
generic phy layer, not netdev.

Lee

