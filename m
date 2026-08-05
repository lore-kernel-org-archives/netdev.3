Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40C246784;
	Wed,  5 Aug 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918364; cv=none; b=OB6ZdvDBRzybeWkRlC4l1F/R1UCtJd6P1E/8EYWirjT3Gkj/DBsxukgWOc/pXc+ofAT9EanLx5V3/w9ueU8nIrsny06+XO06kumqX+ZdUKTkiKal/GE3c8BNXHeeN9Bh4B3Q/Jl2tgDnc6jiLMScb6caSEUZbVG1lzze3fmevro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918364; c=relaxed/simple;
	bh=jdNVwwJQY+ckL6kJ8Tj7UyLROjjvMVrs/XkN06eWAYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPV68LieJ3vPScEM5K7pieiEPVUkmB+F3gLebxn7jW15mo6LYSUWGl0CwVm9kJjtSRvkg7JgvHpud504RKJWNjJwrSjCMIs1HAotRLVMkItih2qU9XsuHIeJ6j8hxBbkLW2wxQUWRw+Ony8ovtzBSZbhh3+6j3a+lCfFaI+0myY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=m8EyoIp0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="m8EyoIp0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BF703EBCA;
	Wed,  5 Aug 2026 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785918359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbHmjTmZQfaX9I+BqpADjh7NOh5VxYpTnMMdG04HFtY=;
	b=m8EyoIp07y7wKl7DCfWzOzX7NoV52LsHfIOJNILlbVSDqfX9xNy1UXEAENyc4qzMmsgoGj
	hADxdZrZ7MWlFZ0injQ0rIUrXeznn857CPxQGff3zfzFQ30rztdvZuREWzcMYkLqR4uBS3
	pW6nGEGOz9PB74eSRGpp0SaxCrc7oO50F5YeWpO/+gotQn/z5Tj/Ip2Q8QgugkWZUyuDuD
	wiOlNTz5S+hZRsTildGlK0+JvaFP8AgsW7ZglQmerSQfY+ZSlyoTE0kmNQ9F4ztXAgFVH2
	NwWqbweZAjCSVbzywRqr/pn6SIvVf0DWA6XSdhBsxUQE/xoSYDovuu9VDYXJJw==
Date: Wed, 5 Aug 2026 10:25:52 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Message-ID: <anLzkNOBMvn7_0d3@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
 <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGedFxA1DxmVgniXAyrblc2qturyZNzK18xk1YpaSqkwFNCmV3VuwI5rbYnTtaISHoMx9SXNLrcXCFpo4M91UAW8j+taKmaDYl3Ko0aZavlF3INaaA6/j3TXTFEtvHaxha8dVHelnHZHpMQfmKMnqCJRIvzMSE0UA3ONKX2i/Og10ACDNJYKfGRHMzudPLeJBMjNfTLD2wZXjYYTP1fm88njpkuZ0sFhobtXvzgoT8ZcePZtEUMBR0pGdpfOWV0ktbwupD47ljaGluECwD7HE4zrkCrWT8nG+FQh2vXk91Ns0419wj7EFlOI20XN2YCrI8eQuIAXgybFlbXc+EajZDYX7Sovw08pNCDGiHexhAoanzlczxjpjU8gxqIbZej4Lff70zgUdF1mG59wZTEv99bRkEKZ0QdxsV4vwUT9JdBiv4TVbMeS/SjfM7R4g2fQEhVEUWdmPU4d08/n8l0k0IUz2gFfX2urLjTflAAfTNYCli+5HwRKyEh1l/S9m/vdU9rSuNucyauI8+3xVBqNjz2BE06Op1TrbeHTBv6db7hyah+rrACJW89IB4gVETcxEFInd9/WrvTRJLLDpgQPma2MiBwSdcnKCjbRTgvLiwJX22Cl85hem5RqCsqPi0MRAaJ2C3ZQQZj/Fwf+d3sggxqb42lKqhVBArQw8FPVUSyVQ

On Tue, Aug 04, 2026 at 07:54:29PM +0200, Andrew Lunn wrote:
>On Tue, Aug 04, 2026 at 04:38:35PM +0200, Arthur Crépin Leblond wrote:
>> Commit dacf281771a9 ("w5100: remove unused gpio link detection")
>> dropped the link_gpio/link_irq handling on the grounds that no
>> devicetree user passed a "link" GPIO at the time.
>>
>> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
>
>Hi Arthur
>
>Do you understand the architecture of this device? What exactly is on
>the other end of this GPIO?
>
>https://wiznet.io/products/ethernet-chips/w5100
>
>suggests it has an integrated PHY. So why is a GPIO needed to report
>link?
>
>Thanks
>	Andrew

Hi Andrew,

the W5100/W5500 exposes directly a LINKLED pin for the carrier status.
On my board (RPi), that pin is wired to a GPIO to detect changes on the host
directly via an interrupt.

Arthur
