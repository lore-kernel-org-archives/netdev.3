Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3623B059A;
	Thu, 17 Sep 2026 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646605; cv=none; b=f350TSn7xt2mLq1lsOtY7V0o5whrmSiNU6VzZgHOH/TnjR4GIX/pTiyDl1oQkRGnsIFaqeTvFAEwUeLSp0uSuQVXRswSlys3TJUDhwEJduZP9Z+IqW3dqDvTWULCX+Z0FCk/2RYskEVko9FCjX707npk7y5gStU5Z1oh66yRbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646605; c=relaxed/simple;
	bh=BsD/oXPvJ9qiCd47GmEAFtdS4HDZS1QcBU785pbxG6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCn54QjWjbtnsZQEYYpEgrL7xI1+d00/IXI3IHCoy1kLHItcQ3ECIA79TW9oqU9J7ijzbjj/J0H/36u3DA6IDpXuKGJ2wmOo9Nfk5igyDgNogOf0MgMsNNCk2QypZRG2M0QjAa5JzngWDSceBcHHm6PRbDaCX9C8Xa+8Y4zFOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=jSGEPlfN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="jSGEPlfN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A081A1F6AA;
	Thu, 17 Sep 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789646581; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=0UviFIQs9+PaJGUtdP+dHhsObrBaIMQoQVmAHi4xLjQ=;
	b=jSGEPlfNhF0tQ0MbNQuEXI6eIjC9ujUAKLh3/C5hu00E4n9kVAQWdeqi6dtoGB4M7fw0Ju
	FOkFyz6A/TDiXEiiRwMKC+J3WnO0Rr+lL3+HU2pM1OxR3UGk2vnIhSoceILr3uAMklGxEB
	vqnwYNRpw3rrm0VtQpUoDr5tBvye/Iemh4oce82PCbrsfvudBSAndhmKCX42kXRKpRp6xM
	lDKJEvMeHpOFty0SR2sHpMLUIttpDCwyE0lhyiSvZJRhBAM5xfXMyK7p89usL3G+Mjk+Nn
	3iFo9e4JHZ4By3AYT+b3rYIYIYCJjmv2Yogd0DdTQ4ZiFDmTs9HCbNoAfS6Iug==
Date: Thu, 17 Sep 2026 14:02:58 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260917120258.GA466094@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
 <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>
 <20260917-sexy-quixotic-ermine-138eab@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260917-sexy-quixotic-ermine-138eab@quoll>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTGIJwiaWl1piAoCNeWJuVGMQtjUlwewHYjAE3CJ3m35a5w4FYzN5Isi4LGGsmhP8DegaTz9xzdw75z/Ukwh7+9rPTNmpSfif79tCji2Er7lgktID0C3vpp4uK2Tv/dbqyM5zx6cXgfL9hCNvrSrNGjolYLkaPDmEqLHcZTiMg7rd+0mUP4LQjf3B0Z5Vmnfohwmay93//xqBIb4wVumw6OByH0g6eoXmDkvctVmxD1J3XGHzhqNE8sdskJnplOSgrTkwPiv3IRpTt9HVF04zaj1ofU0u5Vc4g9WvYG/+Xby6FQdwUdTrBJkb6E30l2AH0TUrCCJ41J4eX7Yaj5gajcWPv3q/ZPIcVlrtY1y4GGbiktv1TugsJ0dvV/hjGiaNvkCh+n1oTzEwosJWq5tpBAsWxcbUXYUPfw5CgHEIjiuiF9tzFnWWWlDwlcrHDogZTaDpiVADiPxqjRLoJiXvhRJHW1arM2J6U8945ACk32A9GHa1q02X4mDXX/KPTh6ggnpaPenFEF0LY60adMkCNHM8QrIHFlFapu9f9AXn8XqmQhmGQa+FF1shCprsLAQt8Go5I07ZsIQYP+ylgZoEQV+4RAt8KbDEn//+k/6bc8JiEu3V1zgnjYvDOR6c5bonYP4u83EkXO9SPyn9LvZCG3bNR7GPyM9lvxf64Qk9aEesQ
X-GND-State: clean

On Thu, Sep 17, 2026 at 12:04:12PM +0200, Krzysztof Kozlowski wrote:
>>  properties:
>>    compatible:
>>      enum:
>> @@ -24,8 +20,11 @@ properties:
>>        - wiznet,w5500
>>
>>    interrupts:
>> -    maxItems: 1
>
>Broadest constraints always stay here.
>
>I already asked for proper syntax here:
>https://lore.kernel.org/all/688f57cd-a098-4904-b8cd-965470a89386@kernel.org/
>
>https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L127
>
>Best regards,
>Krzysztof
>

Oh, my bad again... I'll fix it.

Thanks again for your review.

Arthur
