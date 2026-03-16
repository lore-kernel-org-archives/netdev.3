Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF07191F94
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681708; cv=none; b=Rm3JTHUUenN1gLL/yzmApAp5duYX8SAcDGAhrvVagd4Ar83rw40LXPMkYDcKVoFHzTq54qMO/9oaBk8Ea67Z/Dy25krPGRR5msFNpai1Sqc/kiBSFH4YLEPKlMWH8v5NGLoIC+WNA+0Wt3zDTuRXQgg0j9PEz/zYa9LLRdEKEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681708; c=relaxed/simple;
	bh=XFTDd7Tadlm0/od3TW1ezaMppdHeqpU3S8hzc5cs31E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Hv8Eg3wIFtKjtv1d1ZmLgapheKRQ9MjT3luCKvpUr9DtAw5ZqhnSUN1av34MbUVaXiPcBMFJPNDUPHRIlgHdfdc0E0kOiyp3SVRrf8d6Ao0az6R0bJ0PFMbjPjt18siDgXFDqpHfcM2V+bjikXVATBImXanW71NtM7bbcyRqtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LXvHwC5B; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LXvHwC5B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 42DF01A2E71;
	Mon, 16 Mar 2026 17:21:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 095B65FC4A;
	Mon, 16 Mar 2026 17:21:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AAD510372204;
	Mon, 16 Mar 2026 18:21:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773681703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5hJQPcQB/mfn4z9kBexUJFaQDGdy8HXhWPjLr20ro9s=;
	b=LXvHwC5Bv+dbRiyfi15dVgmJUz8kDDC8Thu7YT4mTKLEbQKg9kDD7SIg2o24Nn3hD9LZ2Q
	k4ZuWypoYPtb00sl5wGKGTxPJjDTjSnydQJdzzdw6gwXkg01jj0xgnWQ+AQjXC7cvGAmwk
	pkXWq/wEyhtZFeZFXcuMXE6x0rxUJmizD8gTF2YmGoUDab9d5Lqa+U77P4+lH4yExZdyPX
	yB6k/AhheVUfkWviIwPwQoHUS6k6oikyWFzRGFD8S8RjFLg1kP9lQNCxb4Hxy/ZObbFTL+
	8jp5K26+DTV3tAjV3yT4H9OsSou9BsfquwLceXPCQJ8AN0uK8q2ns6UqWqxJ0w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 18:21:38 +0100
Message-Id: <DH4DORKIV5RB.3P7Z2RTRNCXH7@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 2/3] net: macb: add safeguards for jumbo
 frame larger than 10240
Cc: "Simon Horman" <horms@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Charles Perry" <charles.perry@microchip.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <20260313140610.3681752-3-charles.perry@microchip.com>
In-Reply-To: <20260313140610.3681752-3-charles.perry@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Charles,

On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
> The RX buffers for GEM can have a maximum size of 16320 bytes
> (0xff in the RXBS field of the DMACFG register means 255*64 =3D
> 16320 bytes).
>
> The GEM IP has configurable maximum jumbo frame length that can go up to
> 16383. The actual value for this limit can be found in the
>        "jumbo_max_length" field (bits 0..13) of the DCFG2 register.
> Currently, the macb driver doesn't use the DCFG2 register when
> determining the max MTU, instead an hardcoded value (jumbo_max_len in
> struct macb_config) is used for each platform. Right now the maximum
> value for jumbo_max_len is 10240 (0x2800).

If DCFG2 contains the value then we can runtime detect it. With that, we
could make the macb_config->jumbo_max_len attribute optional. Then
start dropping it from platforms where we know we can trust the DCFG2
value.

An alternative would be to validate macb_config->jumbo_max_len against
the DCFG2 value, but that is less useful.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

