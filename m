Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCB501F45;
	Fri, 25 Sep 2026 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379929; cv=none; b=VXhyGhArYb98DU07FYQCqpgDIC5vGYhAykkaicJfQkrNjYaL7bttvCKH3LukIV3VlvhJlXoJBGT9RdNquPo0bz4IYZbE00MXJQizJQRHtbzIejgQJb6cJG88J1shQGb+ecjpWT3ou85k039foumyJZ5A20Vl6Kt2xrQ4pCNA9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379929; c=relaxed/simple;
	bh=rFON0srpWh8DbJ9gQZvj/AH5LWMJNfmnscE3UbpJLWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqbrA5iFLT1WZgQg+fmt1Yp165773ZgMPzmr8x3VMaE6Qli88CvmUuFXul4OvlxyUe1ozqlyoemLFHpk3b7xrzhozTUFE34K3bdnXRZS59y6N9oYwM5DEODE8ekoyALz4GxUnPPSvi7yAALtxBt0Ebck0P/Py8vaoIEUxnrNoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai2s4VRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai2s4VRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC6B1F000FF;
	Fri, 25 Sep 2026 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379925;
	bh=rFON0srpWh8DbJ9gQZvj/AH5LWMJNfmnscE3UbpJLWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ai2s4VRwpPAc6VZxob/tDwjqjHFgM2GOTUY0teTMipJO6QIw0qz09t6m+3kDvHK6t
	 vR0TL4U7WyytQO3ZEybFsBbAjKCCD/HiqzLDRwgUQKwUWE8OSrxGty+pE5RKcITpT9
	 LLlW6csH/ha3el6rQjGOoDzrd0oNn/r1qJfVXzpSb3zVSLmfpGRmZdLIQrEDRL0Wr1
	 36ZH2oBE98Glj2f81loXx6SDZDIhTWVXMYdxqdp9DLMRKLLiM+2TrtKyzheL1w95H+
	 BBjqen09iSEUSUnZbzp0SwA4pQadzgZgcZJ/z4UQV+hIeop7ne++3nMqaMpfoxNfva
	 Rxn+ktb/gpu8g==
Date: Fri, 25 Sep 2026 16:45:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund+renesas@ragnatech.se>
Cc: paul@pbarker.dev, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Richard Cochran <richardcochran@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Sergey Shtylyov
 <sergei.shtylyov@gmail.com>, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] ravb: Add gPTP support for Gen4
Message-ID: <20260925164524.3f3a5cd6@kernel.org>
In-Reply-To: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 19:50:27 +0200 Niklas S=C3=B6derlund wrote:
> This series is the second part cleaning up how PTP timer support is
> implemented on R-Car Gen4. Currently there is partial support for it in
> some of the Ethernet devices that can use it, but not all.

Please respond to the AI feedback, even if it's just a short message
replying to the thread as a whole saying that all of it is invalid.
