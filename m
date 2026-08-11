Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0623393C;
	Tue, 11 Aug 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453093; cv=none; b=WBPnQd3s+Ayijzetv18pBDPBDHcusPa20Lcc54uXQcnG/bPiWY9Z/lUUAALN0jmIlqza3vnhSytz28pSgnTqxIQy5gaAvU+djLXidmiREzNPstNLeJeZ3QROJmuLWQVTw5fYfewTd4eAFt38i2cMDer4b7i5ZIW3SQ3mpXB9wZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453093; c=relaxed/simple;
	bh=t6l5A0FN/QMvzyNimLRKHdOJatFO4aETeoH9DF0U2LE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qogSgZtr7r5Q4Gw1zQ55zeXI/SmpyuIYjU2m/wCWRqetqZC1xAJUpROUNXQcPwKDPCkc3SzhBJ/NPVg+BGA2y/xFppKvQLZKld1Wdg7tTrIkAXvqHo4kkf/Crs8Nk5l5QGoTwzZnnv092Q4XsSvjkJ/UW3qLkbL2qdxYrML+VpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BaRDF5zF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtgOTme5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BaRDF5zF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtgOTme5"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F1C3EC00BB;
	Tue, 11 Aug 2026 08:58:09 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 11 Aug 2026 08:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786453088;
	 x=1786539488; bh=iXsICp0SWc+SRdGk8ebwnVAJaKYg5Pj5HgWOakctfy8=; b=
	BaRDF5zFfuUNk5x/lmWU4Oq16a+DIeRt4CWsHy2oqnu/OacVes7bs4Io8s5x3vad
	7uYvCdu+t85v94qRFAA6ywtLUIF+d4MgXVWIcVT4BWbb8Pjum/dj/8wMXefsPQbb
	SBSwRdiKOvaDwL7nXed6qyOaAS5EK56Q0klkL9HI8IRAA8tHnxCSoOGMrjXl1j8K
	wVou8LqbcK27Z9Tk7clfi/0PX7it1LMW0HLUz/ePnn1lxmn9oZvO64ny39duXvgY
	5TylklCIVdyV5z2dwBGbUCbXPA4na07m5law91d9p5x7CJPQgAUn1hz5K+K3oVjK
	HcbXB0iELZC444UHLRM1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786453088; x=
	1786539488; bh=iXsICp0SWc+SRdGk8ebwnVAJaKYg5Pj5HgWOakctfy8=; b=U
	tgOTme5c7J6umxaCaR+ZUBfdE42W+QXUoYQuaFTFKQTMMYRTO6xXfklsJooABWPF
	zfmsM022kuyODOE/g1DhXOyHY1feOvVOt1fM6gNFX1FvOnPaHvi/mn9xnbKvuYKc
	RrO0X5XgKZpuEZH36b2errJepWQ67gV7TArDQODqNLQplf/1Sgca552QmReenKid
	RG3pa/eiSQVhphoT1T/357+CVw7JqLbkII9mNrhJn1wkmlb8hw8+13CYaiXfLZeQ
	j1mOmy6hE7JKZ5wbLzrUvKzGpP24kJJBjKXo+e1uVZRMwf8f5TfBGtFwOwFhFC+P
	UyDq77Z1PJQKmLQYs4Y8Q==
X-ME-Sender: <xms:WRx7anSmYc1p-a-zVvikoy2N-1nz58t7hDlfuRGJFEKFsFuqoU7JqQ>
    <xme:WRx7ajnrnhQy_rAq0_0XkNxUFgZaxVbUtN6-le94Ozjmm6ZHnGEuFqyE0Gpa5aPwL
    zdsOF9RY7A8O-nIM2eumGCoDWcHAA8ZXccagF7orMIV3fm7cSbdJq8>
X-ME-Proxy-Cause: dmFkZTEgwoLrKc+iCznplqVnE39SS99aEYrs3bPuibc0jIqJ39pJ8LFA0KNYQZbcyE2U0a
    e1hVvc+2IC/Dg3levJSa7wSjF65Fj25olgJ0yc6pcqCJ3O8aT7YGtB3cJfLMa0wuJSg944
    d9Rlvst2DYgPj7xKbgJ2Il/paO/1F/7+7hWfg1OW7NKc0iGVssxbYx7Wp0R40aBXWn+cMb
    raHPO5Md0vO6vKuLTgKvvFJHGi8Ok5BU75f5W6b6r5Jpcq8CnwIbGY3EWQv0DBDidlLXRy
    PqQ6ZyqrgoofnyHKFpJ/fCQwgozidi0XnfZZbu7gFB99EzLyLSdak3K7tQgcRuSv8mJZJj
    IWr5EvciYWRGxDq3fXpCHBiNen7hKAi3dWrkE+tvy2V5dKhTL9EkvZi2aeYpK0nN8SlpEK
    XKo8CWL7MqD6/XIErDILKUocSEpNBp7xdi5ffFXLqvJx7L4dBvBIjeJPdcnNr2QVoa6IUK
    P+IOjuWZ3h9SLdSuwmvn+ncgntbqI3d8w+vO3Pa0fi1aCzibn31x3pvAvn2k0wRj9KTSbO
    EHjUHKUk8ArLHzrbu9FB1kY5MEcGZLkXjkPAFiQzIM5v7E93b4hIfHZ0JoMzyk4SAoR+Mf
    7vPReWCnCGZJjk6rs6RMkuKQtVortOvdDlJ91Qi08A8bIwbog+r00pQVdOqQ
X-ME-Proxy: <xmx:XBx7amPiRX7kL2Rih1KpjNEtNDxxKeDWxpRj8v2WNhfQKAHokkbNFA>
    <xmx:XBx7aqKd6krdWuCAcxMVOaJqAaG96FLEX5OVxhl_gP17zV8ugp-usw>
    <xmx:XBx7agoyR5zqGBVKnZEduOmjsJQPOxMQQVCigX8Syy6eym4MHdvMOQ>
    <xmx:XBx7amOJm-yLc5DaZggr5niBInlpLKGFFhCn4tsmg_FT3lWF3uPZmQ>
    <xmx:YBx7agU3IM0hSoXEGYr3WLXId8OaNwBArjwDY3V-6jPn3poJiS3CAM8S>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C594532A006F; Tue, 11 Aug 2026 08:58:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AE4jp8cz6WHc
Date: Tue, 11 Aug 2026 14:57:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Message-Id: <5812d452-5dbe-436b-ae6e-af062a873f7a@app.fastmail.com>
In-Reply-To: <20260811-wiznet-link-gpio-v4-1-4d5f7da885a8@marmottus.net>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
 <20260811-wiznet-link-gpio-v4-1-4d5f7da885a8@marmottus.net>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: wiznet,w5100: convert to DT
 schema
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, at 14:34, Arthur Cr=C3=A9pin Leblond wrote:
> +        ethernet@0 {
> +            compatible =3D "wiznet,w5500";
> +            reg =3D <0>;
> +            pinctrl-names =3D "default";
> +            pinctrl-0 =3D <&eth1_pins>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;

I think this needs to be IRQ_TYPE_EDGE_BOTH instead of IRQ_TYPE_EDGE_FAL=
LING
to make sense.

      Arnd
