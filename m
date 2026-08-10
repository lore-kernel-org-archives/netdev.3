Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D73839B7;
	Mon, 10 Aug 2026 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348419; cv=none; b=Ar1IbEGrM4veV1rMl9kLWgLsQL2gXJxEGigl0Ew+ErGq6yMDNuUVQ+iwWdFCRfMfUdhskHnkNFGu8PIn9uDAGYrq8Hbvk978+kxElIAVT3weG+8HZx/Qs/N9SHhvpcxPHvdemcIB6jspRK2+vBgCe/9U/BABxQ56znh9f/Rjy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348419; c=relaxed/simple;
	bh=nMZrEt1Xx2wttWxdikFSYeWvFbbsZATKRUOwyBwFIcw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GWcHUUTCKmrNjlVKJL882eIsHlyGvXTf4vRl/1Gj9CAxrv0tlg7wAS6gHmPifok7X22AhXY+93zPDP1eaRO6ecMW8aVUcwZNqanyC7YizMmUN595vkRi/6zxAhnMEO5lCDxCRnupmDWYxuiXRx9G6AABPhAaPcnfXHRdrD7t8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aX61iko2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVIvd2NZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aX61iko2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVIvd2NZ"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9FB71400079;
	Mon, 10 Aug 2026 03:53:35 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 10 Aug 2026 03:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786348415;
	 x=1786434815; bh=runD0U6EWuHy0e8dF08rJ7oF2cXWENn2Kbh9AqCq5wQ=; b=
	aX61iko21XS2w+ehKVVG5600g4ulzyQwiFLE5k0LLiUGlUX1u4UOqcrkRBv7DI9d
	2ledx8RN0pFMhahErPM9IBabBK45TGzk0JBEpJCOAI47Blg+S4Pod3TM4XCjrL3N
	dSzK9A+pF/Q5aYg75pvmR+g7mTiZNNmvcYNBIO7/22dpL4OQf2YaodENUUQC4Un3
	DY7gq8Zj13zfNx9USrKY8vbdz/zUd3Lm/9cv3ly1kxqN1g0iRHgUJ9fPEnEvBwKv
	OakNcTgbR8HBkqgYjbBQ1kjQ3CvNxlepjxl7rhfyQ4EmD6J3qNxt0O28QXjL9H4r
	J24elYfCgMd24tOTFUU15g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786348415; x=
	1786434815; bh=runD0U6EWuHy0e8dF08rJ7oF2cXWENn2Kbh9AqCq5wQ=; b=Z
	VIvd2NZnccN1aq8Gg0awnAgQFEldXpmwUXTryoptmnk55oYwfbIRoxkIJ+uHmvp5
	4icIH12WWerTfWBDaC/cMtR16Iaulqy/CBmNeg0j2a7lcDjGGfSUxiVgMvpiy8cW
	atwUyBsCYFq514tvPth+81WIP6Pc/EWnbKn97qAhwHxnlCvSo8/vz+lEwRRv+2K1
	GQi7H7ovjkB2wDRdVWtmjoqvggpcJBzUCjDSOahXlMURj9olsbwFisw2x7ESNPve
	JX6ixYcyH2lA9Jj1xyTqx0piohUqxkrZbyHMcIgFP1IPL0wn9T5oN/LoSVbpxuR2
	nD+H2sMbgccu2hZpjBuvQ==
X-ME-Sender: <xms:eIN5anSCCh5v7FYK8y2dpH458eukVQtWKBUBG9YI1irFkO6Y_upyJw>
    <xme:eIN5ajmXLPLVYywd3sGTWKrnyAzrhS-rtRtBUxL--LrLIobSMmf39qDI7ecwzak7V
    nmqrLuOftqQaSP2rWzZvlbD4qnmrMNQ_tjdWQPVnhLsxFgSWyYNdnlX>
X-ME-Proxy-Cause: dmFkZTG3KJHUy5DZByjZ18dD0N4Bjz8bSsstts7L8TWP0BmgEF+vmOwPbQ3C3vJIpS2wNT
    WxdrMKu++JrIpcluQK1nHCn3vp5K5hYnF9VQ2/As3M8fkqKY8j+Ilt81by6hexQ6yZFslq
    1xvHFZG+4gp9qtk+ETFsw+e5qRhKDUEICQdL9IwU14W/5Tl3Ck66224px795utxM2cb9WT
    y9gMrgpQukFkbk+tiacfvFAanTx0PjhKIi4Pp0Axa1j2xYMCB4rbAhd0FAikWA8MbDuxq8
    l/RFpzNObSXnOllZAJHH9GzWSbs/LdHBoCiKXHdHhzVoKZOKdZhVu6vKPcguttrQmEcxX5
    zMW9r1LWyeZe+o3w0TzU6S+xU9RfeCsMTd1bsA7kyPffdkAf9UO42/G8qYhBMIct+VRbKN
    3gvsL2W0SlYvQAPvUCMD4dNN6t5QplzdP1ajXJDZl5xSXg9Xx/fYWFACQ4LP7YdI0yQSWK
    RObZ7aJorUJ7czBRnTH9hpMr57XlYV8o6gXWD7ROLCpEcgZyPc1XeMfu7KIvCbBxoFY2BM
    u0TDUzOehxNByoAZwaYZ1AbdLOOAvDlcTGAaaIaI4RfyBGOXA8JqK7KrOYlFkZTeOP5N2Z
    P3sCPFYDf+Qc3EITFAE9qgvl5q7+FKp1Nidcql5bs7vqFhh8FxZ2xxdCoBiA
X-ME-Proxy: <xmx:e4N5aqB8kUMFImQJHNcdcYFQ_DG3i3G12dLYI4u3Nmbz5f-3GfHAHg>
    <xmx:e4N5aoPDL7yUCT111I8YHaN3rjVr3vtbsy0By6db-am3vbpta2IXPA>
    <xmx:e4N5amM-OaidR6gI8U5CPhuuy22c2zMMBobBv0OOYZmSFVyFeJemWw>
    <xmx:e4N5aqLJMJzPP2elJ4xPhVXfYOwuEdOrFiiLectB0vU57SMhLe0baQ>
    <xmx:f4N5at4ElwPqWsfHhzCoBBCYccNHfvIBK5vz_dDcHkxFHnaGjMP4048p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B99CF32A006A; Mon, 10 Aug 2026 03:53:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9hGE10fN-aw
Date: Mon, 10 Aug 2026 09:53:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzk@kernel.org>,
 =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9e8fb566-e372-4519-ac0b-b8ca6de275e3@app.fastmail.com>
In-Reply-To: <20260810-arrogant-anteater-of-economy-ef2078@quoll>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add link-gpios
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026, at 09:43, Krzysztof Kozlowski wrote:
> On Thu, Aug 06, 2026 at 05:00:01PM +0200, Arthur Cr=C3=A9pin Leblond w=
rote:
>> =20
>> +  link-gpios:
>> +    description:
>> +      An optional GPIO line that can be wired to the LINKLED pin of =
the w5500
>> +      as an interrupt to detect link status changes.
>
> The message is confusing. If you describe it from the host (system poi=
nt
> of view), then interrupts are not GPIOs but "interrupts".
>
> But maybe this is OUT GPIO from the system to the device?

From the device point of view, it's an LED output, but from the
system side we should describe it as an IRQ_TYPE_EDGE_BOTH
"interrupts" property rather than a gpio line.

     Arnd
