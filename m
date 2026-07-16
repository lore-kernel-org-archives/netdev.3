Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0283391507;
	Thu, 16 Jul 2026 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216883; cv=none; b=OjMLAvOp1ctiD9BH/CxNVAIGltVu4vb1ZsF7LMcC67/0SLmwciHYlZxCBM6R7FkcS6PJpjL6/yK4aiR2HI0c1QzLhovwaq9OAg2x98TxIyoOjHUPZyRf+3+ikgFe5teB0MEPivbKMDDdnip1//2umEVHypsqBcg0R29lHrxKhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216883; c=relaxed/simple;
	bh=WN+6q7KPEjcGTBu1+gNi6rjeoSh+sd11NnmV+eEGc0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDaQWvzFTocbSrAiekTkSbERBhheeK/DZ8ewUvj/fS8bN1OewmISUI/Xq2P3Kr4KO9u+bq8VNSKdOMp/tCiF+aK+RRSiwZvN68jyLyqTLsIHHhu/k6bZArWqdjTQ6QPVb1yEnvwiRb3xv6jHsk2BCEcyfCt0bpcRqJEPr0ozmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=nKr3wis9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mFTX8TBR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="nKr3wis9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFTX8TBR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2309A7A0109;
	Thu, 16 Jul 2026 11:47:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 11:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784216876;
	 x=1784303276; bh=HB/FKaTyvhlqB8GK9CB4ztDBDQW8yOpGTYGDpjvNGX4=; b=
	nKr3wis9Bro742kYLtkQw/HOaGmFbeJreYwJzHq4iwssSZGiiRwqQSSW0bwD9VuQ
	jRYGP6pGVldzgMsOdL6oR6LG6jOfo48jfw2z84AygeeR3f4OnVa64kIHjHi2Gpxb
	Gjn2RuORLYLP7n4AhgEf6NfU/hMm3Sl7xYZgPY7iQMz87dh8x2ltJIV59mSpHGU6
	a4iB/q7hMxNtMcicpS/oIHq34yGJwtm+qStR0xG3suVLDLXFnVtHEzkLw0ATJuyv
	kgpXyDnTA1uDxfAXyAX+bCrNY2JV0+FzVBrg1Ntbnx3wCCL7m7KfOfnKPDfu+iGx
	1a2b77au2RrXmphrrG45OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784216876; x=
	1784303276; bh=HB/FKaTyvhlqB8GK9CB4ztDBDQW8yOpGTYGDpjvNGX4=; b=m
	FTX8TBRdSWlL86oyq+g7Y9+Hwri7yW8EPlB3BuRjjsGSQvKNdBjz0vuvXTHtsrWY
	fqj8cqdbbgImqgqE+PYoHWiG3+n5jC+EGBMt6WmOJ5jVowjs5yvTGxR71/4Yikn+
	mhui2CXtb5MneWunRN8WenkhEzsb5Hd9GoKY42/yONbw/3rq1/Ost/uxNZ+j7wpN
	La5zDTcBlEUST7ceVEPqDHH+F4eBq6+Bz5JST6jZxLEqDeBeoi/wrepZdF1JtpMv
	bQkR3Fuwb73lxgHFjcsin4igqAJz+GJ0cEu7YNdrxizObxOtFjBjr2n5wZfU/yNb
	3/JD4OZ7XIhAJXpdsZRzg==
X-ME-Sender: <xms:LP1Yav73PBSQ-OTFSlO6OobooyPXSbavf6YxkJnjPXIwCx__ig6jHQ>
    <xme:LP1Yavzm57wNVkSn7HSge5rcYTOHo-Eq1So1mUmjjjjfq1NFwxqbqrFmvnNB4v5aF
    Ea95yESZI7GAQiyfzMyenDuLTEKe1OydUezS565CO3xy_88z8JcqRM>
X-ME-Received: <xmr:LP1YagoN-hGmmCcE-yja0y3aNMHxZK_ZxzpKFKkVh_9QygZztgSsiUYjrv5pIda0M75XRRTmlwn2Ui7WsMq1bnL5v5KEcl4>
X-ME-Proxy-Cause: dmFkZTFU1EBs1rA1q6DrfLuabqPQngX9j5QFJ2wsEVNs0NdlFEP7iFAvVJs68Xex7Gffdd
    sEJcOMhQnmjybeAcAon5v+WH7Y+UkWS0ZgCgh6HtTbOB8odfvTo35keA9/UnPzGvyJQNAa
    JxNW+GJoDtziMX8mihvaj3Xd5LbfFxQo7GtsuOhFlzOX7+rCV5Vd/bYDeiROAxhqHxmGdw
    Fagx1/0lHgw+pL4uXi+EjWCkt2owKsR31HyQqDkY855mqnUEQ8moS4952fH6evRzp/R13u
    P+Lp2CScuEd72ZI9EbA9Ly+vfbfsxS5FHAFVKpfMKp1HJ0hc7lKN1/hGT9QfkO0XLH4fKx
    5yRI6pi27S6MBRB+4qyW59DNZf2Ro8DPYvmyCC2ozza1DBIUSd6FL5jqUEjD7TSt/m+VZH
    vs+3D4lK1c3+Dmfjr295UfWu5Npwp0JmuIsTKrs58lg2+0Ny1k4vXqk5phQomuEPoAVroE
    smVhWe7IJ1tHjDrEbvf7BdyxSm38EESb9M/4hsp4FZ78OwV/8/3Nmrd9P65tDeLNWyAGi+
    zyhuTQdE0GNj0njUqa2QV0/lPYc5CPc3A5h+/2XvGAwYFhVAt/O39VCGNwO45J1aDE0mPm
    3AcYxbw0PP3sUgS5SR1nT9SqnBL+CaP9mE2Y9kGwnetozqPpmfezefiK5frg
X-ME-Proxy: <xmx:LP1Yah3HZdD3daYG-BzuHlybve6E4Rjf-2RkJpqIIxXlAAsAvolubQ>
    <xmx:LP1YapBTLh2UJ52xo8-uYfb01M4FDhB10j6mGvWhBuaZo86bW7_wIg>
    <xmx:LP1YaiP6OdN-SJQdafFWQ81_eUEG7wHrX3_ZK0hivviauKBOgk27Pw>
    <xmx:LP1YatS8MKbdguP0n-qW_Id3dhhrVFckju5m-z656VYonRPxV8U0KA>
    <xmx:LP1YaqmXMzBIKOsPfH_YvwULbdaajSJKIkQpQKwtvlC2Vu2iD_2_HA5d>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 11:47:55 -0400 (EDT)
Date: Thu, 16 Jul 2026 17:47:53 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] ptp: Add driver for R-Car Gen4
Message-ID: <20260716154753.GC1593320@ragnatech.se>
References: <20260702125525.2230427-1-niklas.soderlund+renesas@ragnatech.se>
 <20260702125525.2230427-3-niklas.soderlund+renesas@ragnatech.se>
 <alSO_-xODO9gWXKn@monoceros>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alSO_-xODO9gWXKn@monoceros>

Hi Uwe,

Thanks for your comment.

On 2026-07-13 09:09:35 +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jul 02, 2026 at 02:55:24PM +0200, Niklas Söderlund wrote:
> > +#include <linux/mod_devicetable.h>
> 
> Please don't add new users for this header file. Only use those
> <linux/device-id/*.h> that you actually need (if any).

Indeed, thanks!

> 
> Thanks
> Uwe



-- 
Kind Regards,
Niklas Söderlund
