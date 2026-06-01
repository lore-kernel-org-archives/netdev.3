Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CF3955E2;
	Mon,  1 Jun 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307127; cv=none; b=u9bbeC7sTKIaMxA8AqTQMhNvK8A43Kij1dBnNR5r6tN7pc4dhEKVrlz1tn/0ZhRD9e/CYYh4AmGzhu3A3WVQbFbfH96WWsMuXcDydk8jJ6KeE+1x0/tVoLWtm2TDZWY2V+YohGq1mvaH9asE05hYtxG/Cp+fLmYAVuknPX1ntyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307127; c=relaxed/simple;
	bh=rXhfy0OJXSHb6/IJZYenwk8mraVQ6R3qSlOb1bb7sck=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O2EoM6l4GQ/UvS46hSib0TTtIGPYVQCs2TJ9SE0w/3dFZImkcBYPRLGt+tqpBdPVKvVpe/9S8l0gMmwHLMpoh4fre5inHcI7Zx24pR61FyZXY6Od1/XkRp7fQDBHZYM/6I7/RyjG5FSOnss8jos7nUclTruFb0RcQDuhZWaBltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=w6hWpZGn; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="w6hWpZGn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D053A4C09;
	Mon,  1 Jun 2026 11:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780307120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c2lq12F95AF0fONDKT9cGLInrpieeMANpi5wpSqUpUU=;
	b=w6hWpZGn0UR6aM5a2JDPluPYsH724FkbNFbawhFfJhmmkiRVcbwW3cI0oHH37mva6nEjLN
	0b8UTnribARyA8LFQDN+2yADlEUz8UygW0SiX9+KkHH5vKgpy7zjHc02/8nTOyduMESBUA
	o0R9TZvtK3WWkJRa0blYe0f9dsDyI1Pd4UNgYSVHqrt52t0u9h8cyjtKiuayTyy2qeCh7E
	TFltM0aw/UR7wC9yxHs19QDTIZ5OXbulqfTQYEM6+5p6QRyf+F4mfKgYsgLCBjWZa4fI0W
	8iBhIKudBxgKsEvA6tcytITuDLkKjrFBMBSURMtyR5/4pxtxlv0KAtC5v5zDLg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 11:45:19 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] net: dsa: ks8995: Delete surplus driver
In-Reply-To: <20260526-ks8995-to-ksz8-v3-5-c530f651989f@kernel.org>
References: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
 <20260526-ks8995-to-ksz8-v3-5-c530f651989f@kernel.org>
Message-ID: <8c81f622caa31c526fd8b00585b1cc96@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus

On 26.5.2026 17:59, Linus Walleij wrote:
> The Microchip ksz driver now handles all switches that the
> old driver was handling, but better.
> 
> Delete the old driver.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

> [...]

Now that the old driver is gone and the three micrel,* compatibles are
matched by the new ksz_spi driver, should micrel,ks8995.yaml be folded
into microchip,ksz.yaml? Not a blocker either way.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
