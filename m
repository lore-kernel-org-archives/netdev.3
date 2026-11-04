Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831114;
	b=gWeIirhSuHuwaZ0xtjAWG3Zw6VfF+VnCCABpTQUyGlOcoKu61Khx51JDmNrkPuwVPE3U
	 jTqJvEKu/OC+U+WDUSvYBXWSR29PVkkF9slipAU+sdV7Gl84Lsr/UMbHnvv380Cj8GENq
	 eNg0BuG9e3k1QAbzm1bOtMcE/1f03692pUC16DlpMLYH1u1gDi8eTs+yD+jCzTNPExjgM
	 Al+/5lpTik+DAIiD0nKhTRFnJbCAKIKpZaINhFXmrM7rQZ4DQLXkBzf1z2knng+d/isFZ
	 Twp5D9tISust5uUi+g5zouriKwlRA+pLVawR7uY2HJ6LpN+KCBBBER9+DY7qflea0kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831114;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=EuVZ/U8iXB5qoqQB2mOa7sPSxLd+TMbAJUrNPXzT9Uo=;
	b=EK/4E0OQweOqbe1M+c5emP6gTQAW6OlRszzeWZA9ie4ib9EhhgMUu989U8sJxPyFmqAN
	 QiofA4ZR4ODsxyltfklbeJ4dK05im0j+Ty5c1oa6c2cHlf01M5KdnCRhpitZgD2oPFzht
	 XyzleknuYDaCNX4VdEjC8ibQlmkTwaVRivmy+JK0LkiazZBoxTwq5+sGXsmCvyf6bGUTF
	 E5z7dulsmIBeDKJBMcSZ+9sMKAL0lkFoMvvPbhoD7zbS+2WlHuswqTUI7//ENTc6IezQ/
	 LqXHKTZRIHYG7DmLtr5Tse/mt0IeUW+t+ruLTZoy7n0inZQ3xFKwCo6UUwpH8ayGrMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20650606B2EF
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20650606B2EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso640602137.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831113; x=1794435913;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EuVZ/U8iXB5qoqQB2mOa7sPSxLd+TMbAJUrNPXzT9Uo=;
        b=ILytURCbbZxkWlAvm+J1j5FmMfoUWkrlmYHSbLeDZ95hpoeTqfHqBLtoUI1CFJ1NJU
         qvm4GrSM/C7zA4VqWRC1U8+Mg3sECplySLa4uPhCGEAi95x/j/yF0IQSsfj2WmH5oDOf
         3sZN9ooDC/rFoktTqaumk+cAmncvoyagCc5fGExwxh1q8yS0NAb+pcs6p0Zwk2CLLyPt
         M9zLZP8FZcwrJGbDHKMW6AIZZdtqfzDZ1mu6JO9bj6kzby0hjFQi2o1gMKJ9PJNS/6Ei
         rF3SpPuVWNBDnFiN7ZcJxIbqWzHU8bC5YJjcLwBrvPk1QYbM2bQWl9SUS6/mN2+sSKi0
         V8Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxf3GXV8IHC5Xl7u1pVkF04VdLVgCcAuawart1hGXM9hLEzd/c+oWsc1pWCf/liZmyakS332YM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nfH6EDNTr1aiV6vPiqVXSpujCaM0RTt+qNP0fqIk40xnO8uwp
	pQwa+qKjXe3FpsTJMex11axt550W+bu1iOlCB0gSFWgr3Wpe5f/OvJZiItzPGVSu
X-Gm-Gg: AYBFou0rynsIPBzs5Jv3FY74Q3/m5YNnTKiWLcqCb+j/Hf7+neDrINANkhrJ7/HFtE1
	6g6XoYlSbM5MhY4rN5XRtpsHxeCIvQOeDXC8TXOD02YQNgoYZhdusbK04wYqiAjYmGZAG4gLoyA
	IkJOCXMcwuakp/vEiNtkZfFQ4hpCrqNGF9xfX/03daAwiBERkcDqN+D9OlXMMMQOjbzh57FCQSu
	VDMw+4gxI3ibLyA5ORy/XLo357ccC4rRZVovqUL4MeoF5h/aIKY2BoS9WkPm+GpCxpmhDNbU1Nw
	yf6jWPtqX0O201qb0/ZtpZ92lVRVmfahH5WctQDJ1Cr/7hIHg6kSVbGYigAWrRu3kwwrtrHnkiY
	Wy5RCDlaAYnwwJES599kgC89Yb9XND7Enj/IMP2zsw7WHql1FXxm3PasFxanvZ0NpV8+8c240gb
	Ks6v70t6Cdtm/tRo2M2tmpgyx4BY7nDPiQ+i6CIuYxvsEstkZbAcogsjQIs2Dn8wepGhK1OxbLO
	CQ6aLR3MtgBWzBYazHxzvHaugzzpGGSLczSXPz7ibm5iGxmayPgeuH309sRreIyiJmrdm7J0+X7
	s7zHdYg7SvsN3PAhy4+8k321sp5QsXz/D5ZP0yBM063t+x5Lndcr+iNXVYsC6kzc5HYgq8cr5lp
	vlqs55gP9X+KF9//eFAjxGwbmcYx21y2bNf8m4dAo/Ca3
X-Received: by 2002:a05:6102:1623:b0:7a7:b6a:b022 with SMTP id ada2fe7eead31-7d072ca6f38mr7784926137.22.1793831112995;
        Wed, 04 Nov 2026 14:25:12 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afbfe6sm3028747241.3.2026.11.04.14.25.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:25:12 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so892818e0c.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:25:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzkB2gQmVlI1ciJcCvan7cpo0zkooj4yoE6r+CTgGaRIdjktvQj7ISRfwDZbZAAs+/usia+9MY=@vger.kernel.org
X-Received: by 2002:a05:7300:e9d3:20b0:369:fe81:a575 with SMTP id
 5a478bee46e88-36a4243ab94mr30254394eec.35.1793830801788; Wed, 04 Nov 2026
 14:20:01 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-2-a15965a49574@telaak.dev> <ba345fce-e88a-4aac-b9a4-59c500f80247@lunn.ch>
In-Reply-To: <ba345fce-e88a-4aac-b9a4-59c500f80247@lunn.ch>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 17:19:50 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ73NCpxXWWD+HTVXctWCbOutbW+FHT83fGB+ar=Hu+vsQ@mail.gmail.com>
X-Gm-Features: AclHuK9bkkUrD9f9kOIMS4d2kgzS-vT8Hn9jZFXbBFoDFm8RqLepOJdYmZqvzqI
Message-ID: <CAPY4CJ73NCpxXWWD+HTVXctWCbOutbW+FHT83fGB+ar=Hu+vsQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: Add Siflower SF19A2890 glue
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Chuanhong Guo <gch981213@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> What does SF19A2890_GMAC_RX_DELAY_EN do? By default rx is 0, so the
> delay is not enabled. Is that any different to actually enabling it
> with SF19A2890_GMAC_RX_DELAY set to 0?

RX_DELAY_EN switches the RX delay line in; with it clear the line is
bypassed. I checked on the board: with it clear, the link passes
traffic at every RX_DELAY value, including 40 and 80 steps, which fail
with it set; with it set, RX_DELAY applies as measured in the sweep.

With RX_DELAY at 0, enabled and bypassed both pass traffic, so any
difference between them is too small to show at 1000 Mb/s. v2 will
explain this in a comment.
