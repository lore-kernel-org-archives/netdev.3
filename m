Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CF41686B;
	Tue,  4 Aug 2026 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869089; cv=none; b=Ir6pg3xNGrpIHOT/SWPQbgTYj57sT3yWumLjJnM623KpdSOBKYD0c8bsjlsVgcqOP0K6CwZSE4LNry7u91HXfuyK5q7Ps0PnVrAaOabNjmYNLXpXWLqUV1Tl3Ru0YwBq3hdhMckLBkgUPgbqTppWOFP5VrNnVDDoN1ds5C6jxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869089; c=relaxed/simple;
	bh=CiHyGw5nuroIb56valNV/0/CpH/ApDNi5aql+zgAtao=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cm5RIDjvbQeD0DRni8iLyl0Zo77jWLtTxMnBUZrqgDREvvhMHMTCpXgRW6ep70VxPRyKGk3VHJiT6PgjtlPAqTPcppFL7FAwwQAuJPFJIpJg7hA6uyC2oJwY8gSHXxh4oHG9n/Hj4D0D4BSKL2JDF+pbezXL4GWl5FiKqMkZJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CU9Ap36P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=if6SD2hQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CU9Ap36P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="if6SD2hQ"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 40FE3EC00D2;
	Tue,  4 Aug 2026 14:44:45 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 04 Aug 2026 14:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785869084;
	 x=1785955484; bh=CiHyGw5nuroIb56valNV/0/CpH/ApDNi5aql+zgAtao=; b=
	CU9Ap36PMQw7CxobXoModlxGiHRsH6szsDDWJtWxLyF6IUZAb4aUVbR+bP8IEqqf
	RKWP5fTKkijVYly8N077eRimtu6h2gno09Z+HQ52h/RzFRyceMN/uI04kMjnLAvM
	MZCXf2kkAB8oOBu3dXoS0zQAyxsGvUPPq9Kgtja+ADaTFtVaTmgRnJIwJX1qsoEk
	DFi62BXyt0nEbrW/Tb9I1iatBbLYAWt4fWc1sjjaxHQLEv1PvDcWHkpDmQIOWOlE
	5OKFSwWyBH37zCAZx+BpbUwkEUI1Nzl3InaaTRH8ys1BQcrbE+R7S/Sn+bF/XmS4
	EaZqo/fMPS8bzclQCH5fNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785869084; x=
	1785955484; bh=CiHyGw5nuroIb56valNV/0/CpH/ApDNi5aql+zgAtao=; b=i
	f6SD2hQjw9wNA22baQWS4XNZoM/nx4Xs2tQBZd/OugF546knQF6WzTR78JHeuIsS
	y0K0sIqBOaRfyrLzsgAosyRasf1XdOumAlRefU3aqNwUM2WZ9/Yb3PBUHLpWwwBW
	mHYatuXpOBOsvPinxLIBis7VsVRRNXgNhbSVcCexzqnxO+0Ww2wo55LQxxt7WeZi
	8onMUZWopbUDGWgriyjdJpkpd/e6tgjPIeM77FbkRUE1iCJlw11dk0U+C6QNPMk4
	4INZ7TwHU/8czK8Knp/QItTFqdZsdN77oYn+oHqGSna0t2PFTK9R7CTQAlJjaXOp
	GHpABg/klu7pQwYMipntg==
X-ME-Sender: <xms:FjNyaqOqizyPyN9mFlOCPKwT50sh6KlRa2bkmwmm3SE67t5l-Icd9w>
    <xme:FjNyajztmMY3RVDNr9LpV5ROaQa_RhpK2vqCtbvkVJzJuF0jOPT-ljfDBwEXRZjG2
    Iuytlu6zWF8eeim9HMrlxYvoB4ZT5FfklErcx5eJgJXfOq3HUYIt9o>
X-ME-Proxy-Cause: dmFkZTGQKlZ9Xbi8fAn1P8ReUFpaOMRJIWofvKva/Ri1P63V/SDP9r2GsvIIJZPMXxu/LP
    WOlKT5d16J+Po+W9v5OR3HZNSAs5njYjEytyeH53PEuYqsH/KXjIwply9izR2TEMFtx2+B
    PmuQ1rvGxKwec9Ry98WBxV7MIKHPlY8yuFTrSZB96gB6zZL1oxf6uqzEa5uYWwRdzAONyZ
    r+KbmF7UoAfjLjwG0gw3+R1Z9fcoEr28TfQ8wpHs4O5KhzswTpYH4vWqJ0IeBdRjPzlXN+
    Te8ELQpdH7NEIwSVtXnLTCwDdnYDpCpRTq49FOEQQZQDzkmBNCfZ6Tjwe8spRn1TlJmMLo
    d3//fatMdeRkv+XSszorud1t2I0jImLhyzYglwjg6Nd8aTSQDRvGBdF2F/FG8l3+Q/XUQm
    7aPVsgMG+RlpdQLsk7Gk1gnwyQZ1bjGJqNfQneCvG5djulraNMfTKGUgYLI7HWTt4N2VoX
    cXAM7qmba6mv/6wrJSUw6iHoRZTbpNbLStSrao+XEr5ScBOj7+C0p0wTafpgSHXDWepFZQ
    VPJTBIVgZXcndBGt3TMMSThLJltW8EOB3/sZdp5ISTzIDS0GlP2fhWKfhnpyy+Bf2FoD6R
    hLxQw+tbhODe5lpLVIkUjbsJ0EU+h152V9G0Mj6KBD39rdvTzKR7fO02l9UA
X-ME-Proxy: <xmx:GDNyaqIlQ8Ksjg75YKg411rajMPl91VryjjgVkFi-0m6Idq7K0Z1jw>
    <xmx:GDNyaogQKYrd6hcDdQwSEuJKnNavIsIKxR_7b_cgKA9fde6flo2dYQ>
    <xmx:GDNyam9bpmLxKDzLTy8fNwurFLOBiHyeqj2s2v3Y9SaKW7eY02qmLg>
    <xmx:GDNyatNHvGiOmNKTd09OSogex45R1Q0qClwASI5G85Q-SQ2vH8-uSA>
    <xmx:HDNyaqhP09HqQyqryQGriWUsalWxp2cJnVUcyY6SZXCl21ZAZQyKIWxa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2582B32A0062; Tue,  4 Aug 2026 14:44:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW9x60_DFePc
Date: Tue, 04 Aug 2026 20:44:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <8295f924-1b74-4a10-b9e2-47f70df02938@app.fastmail.com>
In-Reply-To: <20260804-wiznet-link-gpio-v2-1-3b1d0c870f35@marmottus.net>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
 <20260804-wiznet-link-gpio-v2-1-3b1d0c870f35@marmottus.net>
Subject: Re: [PATCH v2 1/2] w5100: restore GPIO-based link detection
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026, at 19:40, Arthur Cr=C3=A9pin Leblond wrote:
> Commit dacf281771a9 ("w5100: remove unused gpio link detection")
> dropped the link_gpio/link_irq handling on the grounds that no
> devicetree user passed a "link" GPIO at the time.
>
> This isn't a plain revert of that removal. The link GPIO is now
> bound from the device tree link-gpios property using the resource
> managed GPIO descriptors.
>
> The link IRQ is also requested with devm_request_threaded_irq()
> instead of request_any_context_irq(), so it is released automatically
> on driver removal or probe failure.
>
> Signed-off-by: Arthur Cr=C3=A9pin Leblond <arthur@marmottus.net>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
