Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA43C0624;
	Wed, 10 Jun 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087897; cv=none; b=NBEtnc1ujTUddjL6oDYKzuKOT1o7Om51Tydw8r0oilgl1OtUx7hZaGp2qXXyjv3r5ii6L4NUslk9HYYeX5ON9+mOP6V+Ppp9SKWQdoO2qED+ytgeBHYa98oeaEu2dh/SeOKPOxvEUiQkr/xNnDBlAdZtKZQ4CaI6HzKN2LBi6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087897; c=relaxed/simple;
	bh=o4YtGMTfnxaq6zA3t5OayZWeNPx/RSslucKg07HktBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swWDgtvZ0krS0mTafq6ry152G3lcbOeyQeiS4I91RWcJjxZIMEHDS2ZrUuGnQu7gVVTS1K31dpGxRR7e44xfSRGobkkgvFbojYo7aQkSU1vXf0MC7RGLYB+t0nRrC0Tke9MVanELnH5yzvsBiR4ixy0ZVnccmsBOiImuouynHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=uHew9rKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMjitKjg; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="uHew9rKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMjitKjg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AAFB51D00109;
	Wed, 10 Jun 2026 06:38:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 06:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781087894;
	 x=1781174294; bh=UxByxHojcW0/JpsnKuo8fRJ0BcEM0zLPVToHM/MysCo=; b=
	uHew9rKWzoszihGiTWg3/lWpwKHuox+Vdd3U9NI06jlwnsJjdXp30yN+IqTfg9Ob
	nY1SRJJnNVN2auHvFHyMzNIE0RfsMtkvU9Bp+fZz30oxSfZL8tz5jcqPWZ4Eq57S
	JFYwNilOik3PmEjuonLT0bbmJh/FyoiyCer3QmqwY3dl1h1hcO7IEAv/sT2DfKJL
	nNP0+p9UU41TkbXKw6ZtnL6BuHxcfYNd9eGgU8Y12aFOXhcIms7bbj4IDsPVlsyk
	wRxw2fw5gVw3KP5lfNwGFhXptuPznsZHvWnLqlKzDEMWrHMLvp31zNO0rrkMI1hh
	1pI9+V56vTSS9IxuxpP5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781087894; x=
	1781174294; bh=UxByxHojcW0/JpsnKuo8fRJ0BcEM0zLPVToHM/MysCo=; b=R
	MjitKjgirUdQQ+M3jM2jwOutDCe+xpKKOzYc/YlInxDh4/m/EwteYdTfYbNv0jw2
	/dHy/eJ3P2JeQ7vDyL4DATH5QnLKk4lmy4HV+5NkV7r6ssLY02NTFHgmffY/uVan
	2JRV6k4H6MNe9xEfF7i0WfNMb872xVEgTQMkOaAt2fXf7XJzQnxDKuZzbfNB0Tw/
	caU9sdJvFtsIF7ar66QA5LlKjQ5O1XNBC6E6XiA2L+aLg5SKk1Xf2AZLvGH0DHDD
	zJm6vy1sXCYuHnRYgnIKPGMsbyrUrd5mo5hY0Ap38FobV4oNspyc7R4BQ0Ay4zfd
	gT/JAD1Pl5QICZqr96NVA==
X-ME-Sender: <xms:lj4panS_-gZTbrvkuwjW2sumMnP2QTW7oeoohx31TJFHnzFKH3nAYA>
    <xme:lj4pahhY3vTbyjoT8cgYWzP6HkZHF6Dwe7ocRgHLZN_zqxslHaLERV30qwJkTHG_Z
    HgTs140EOE_06v17PoMYBGcH65XS7N0lbpRzVApyr1AmIv8-xh8plc>
X-ME-Received: <xmr:lj4pargxkFYDrDBuQJKQMHpFVA9VPUFj-hZ-77Z_hqaFIDtFMxMJqfBcGPzBDD7348xH-LWsrrIRv8dkPCWrGg2IntyHezNLVGSG>
X-ME-Proxy-Cause: dmFkZTGzmK9+1npgBE4CNVzIG4Tn/S4vHqOE7oZQiD+7505Ck2MZDti7w3iSKVAti0VrEC
    /bxbffDkYP4BLzXd/j8IIbJnxpzP/Zw9CSUQ1IPvdyZPMQ8oSM1h888VyoFOiSB9O84G9R
    zZXZH1NixE29/8MA4hXbQnoWSrMZr+hq6n1O7zFVi6nmgBCAIc+z3dhBWH9CQpFAHqPxVB
    HvecRZ4wCKW4q2rzJlHzZQyl5rxAOBCisl1OcH6DNH3r85vZh8jJgsmJSfFt3vjQPgNcWN
    W3K7knDB1HDvhsgw100s2QwIEEO6LGqZ/l6nHTOkhKmIck/ypDGIP+eBaHy9OxqvMRFCRj
    FKw1TaPm45X7e5RYx+G+sV5dtMnXNkGx86t0+3zdd7GGQ77asejzaLvUqpacJoCNZWWL3N
    BXqSv1RPdooQCnc7DGqwWdzV2l/fQh4SKQFc0AItLfpDLHlhCvXV3tNdHI63Ky0NjzresO
    OprDDZyMH97IGnW9+6HKNcssvL/unL22++1e2dh1HFhFlGww6s2pEf3lYvLbLpbcU7wUO3
    vq5KwlcuzweOLNvBAzYlMFV50fdBGrPUQByLzIhl78FHYhKsfhDolBKeH4ki/xpmHn9A1A
    I0BhrUjSecd39Rh1xLrjgVS+lwjpsD3ZPJBQ/5kzAUk0ZKKxUEtcOkdeFTdw
X-ME-Proxy: <xmx:lj4papYSyy944gJPIBpN5PzVNedy_7K3cjzGqQ2HJMxtNNZfkZXQWw>
    <xmx:lj4pakVtKJ5UHOOvqWDcqRjxV5ZoOLEKrtCp_EmHdl5hxOZxXCaEAA>
    <xmx:lj4pagg79T7-0T06dvmUhu_TIqVnpJhWo3AlQ9jIWtHoHycgvlQWyQ>
    <xmx:lj4pavlbeZJLVRL8OjYPDv_egCFWheT7QAUVmhVztrKgEg55p4fPHQ>
    <xmx:lj4pajUj6TKEel0m-XsZN_TOVOkKXIZWTt_f9NkLcAq_OEEaWCg2M2mH>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 06:38:13 -0400 (EDT)
Date: Wed, 10 Jun 2026 12:38:12 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next 0/9] ravb: Add gPTP support for Gen4
Message-ID: <20260610103812.GE2465390@ragnatech.se>
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <d525a1f4-9e87-40cc-9878-2044e5d6dea6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d525a1f4-9e87-40cc-9878-2044e5d6dea6@kernel.org>

Hi Krzysztof,

On 2026-06-10 12:27:55 +0200, Krzysztof Kozlowski wrote:
> On 10/06/2026 12:24, Niklas Söderlund wrote:
> > Hello,
> > 
> > This series is the second part cleaning up how PTP timer support is
> > implemented on R-Car Gen4. Currently there is partial support for it in 
> > some of the Ethernet devices that can use it, but not all.
> > 
> 
> Second series doing the same...
> 
> Please use standard email subjects, so with the PATCH keyword in the
> title. `git format-patch -vX` helps here to create proper versioned
> patches. Another useful tool is b4. Skipping the PATCH keyword makes
> filtering of emails more difficult thus making the review process less
> convenient.

I'm sorry about that, but as this (and the previous) series targets 
netdev where as I understand it the convection is to use net-next, or 
net, to indicate which tree it targets. When not posting to netdev I 
indeed use -vX.

I'm not sure how to resolve these two. Would [PATCH,net-next,vX 0/9] 
make life easier for you?

> 
> Best regards,
> Krzysztof

-- 
Kind Regards,
Niklas Söderlund
