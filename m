Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394539;
	b=rUTvx4Txj/qJoGr8aZvitdFZ+UJAjI6pMhT2y9R0ufgLI5c5OlNT6xH0v0EeeNYrB3Au
	 zcZg6qq83jdsfnYcVTU0rqNJ93WlYSQe2d58Q7WlhcSc77CUZoMAjZSGJvKhGDf4qSflb
	 d3S4zqw3WcXNOqVUXBAOQLyj3iTaiLRuQvTqZRu6tJi0E/dkmyDR6LM1eUzArxkSerWki
	 Zo7eYCzVGQPliwOkBSZ3m9R/i+f6Lf0LRTFGmgcmuIPrc6Zs+U2uwRetFCviUIJx/BVu5
	 v++f9VeuGNQsKF1nfJRBVd+WDLr7mE3QN9bfte72SK8Jd944QMcXMeZM4ZaJFG8x3wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W3z0mwrPXjDyh25V3etJIycxf0MnLGdgmbdL34z00rw=;
	b=mfMzMdOzVXoInyzepAJvJdYAKFfvblZaIthwdc5GP6Yrtl/zVZws1EZfG63wwgGVaVIh
	 VDobGVl/n0fcAMnEjHUoCKLhdrH923Mg0F7NG3zoiV2xzVUJ5tRSIsYj02iFo3zJvV2ax
	 ONKPdNdtLLanzo/gdOkrlDH/z6tvLnr8kXrOcdR1PHWvRJHV+L957dPLy1cxGPndCwxdA
	 SOchbcoCNTvlD3QSQJ43T97fHkosDaZRqXkvWerpIuQk/HLmCc3kw0iMc0Sn8ltJ5eOYl
	 9P23ZnNrSQP4m9Go6UZ0gvleNTUsSCWeYGmPL/14OFvf1Uh1pPAaeKMSMa4xkByCzQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARvR3frD;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02324606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02324606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARvR3frD
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso1807230eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394538; x=1793999338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W3z0mwrPXjDyh25V3etJIycxf0MnLGdgmbdL34z00rw=;
        b=ARvR3frDK0R4K6cAO5B8wDyq8X94HuE0ijyDCTBl+0vnuWsxrMgeBfjZQOH40GCd8P
         XMUGNH72QVl7VzRm4d159ZK+9Y4zWky99vTix6/8d8gu8teZfmnsSQxNuJkasul9FFc+
         87xn17BTS/WYte7O2aDqISPtt/VkX4ZepKF7zMjdNiVBOcLHv32Wffe5fIn/YryiT1wa
         cwuZTSb/hXPkVwYrhnk/yGH6lfWYNhPuEctGC5URmPD2OYbutPoq5mBGf6pprPxjad62
         sSDXOL61k+dqkucwR+KabTTLA3yntiWvUbny8JNclQRV3y+DT3aAhPgRybpp5ZIysD/o
         dcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394538; x=1793999338;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3z0mwrPXjDyh25V3etJIycxf0MnLGdgmbdL34z00rw=;
        b=fcL5+gwAt933bW7Sj2ozhlg9MTBqlhyGeCNlG4rVA8cKr4+Kjx2Nv7eQCvwFqx9XKC
         F3HOTzZ8XoVQjYoO4PzzyaThHbCxMw8hBAEsUPXO1SqTPiPE7c71JJGNcoIrKcmG38SC
         /fyCsj7yzsQwxEGmSQBpTtsGs2nj7dKDmgx+IcbmTdE6TdF5Z4zqO8zjU9awVEvxY63T
         Mg5HOhcrLPQLhbshJkDU5ghOu0rULdFvABfyY2f3vjf+nNWA1Ykxof0npfDHP+CAcSD1
         NEVxMwGxNkhrQrrK78Dn7PfGSvfODkg9Fn8TijKZR+BAw8bvB2fUYH4RqHQ/xgu0+H+2
         znYg==
X-Forwarded-Encrypted: i=1; AKwUvBzfvOnqpiXhC7PUkhrXQL1+JGemR9RLmRPm0xLWHkZfUIjI3k6HM3qUkQnVlO7XiZJLsNZSCt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqlP5+rXcoKjrp7ry9VklmmKN235KQlFnYD9v/D4LnRpvp0Woz
	QlDayv7UiTPbQ8toZmWEFy+93sW11kKnfGSr01rljXfBM4icg2yFf6lozM5i8QiOO4A=
X-Gm-Gg: AYBFou2Dl0vcGsNmMw/N+q+uSabP21vZqXGFdW/Z8+hVqNCS5PR8DvcQCwH6VKcRjf+
	m2reqyvOFCdp/s+Z1BsFfnmJGgqpU/1kOQCL9ZVJDfNOwLGXbLuuK3LTGMdaWD5pyckJY/JtFPY
	jUUDtwyhu4rRJWGvKi8yI/ROumt9RjtwcpWLlgnLQsr7kCeIwL7zh/jqOgpV5MqUzOVaYVxPjt3
	bobqcjym4b5KZMwzn9iqD/8y70WvrOlqKpI3OcfOL2jRsfKK7pLZD5109fTnk/6J7zHmBSLGaCJ
	8Yb+H/sVBqNgQ/fI4KPKEAZYYFmdHoQlcRmG24jnicQsLaR/RpFzQ2d3zIZOLdosWOciHHERNHw
	WD2YTmGm2V9D0l2V3N8xyxpFYRoVSwjwDQrR75Qrlo3AjO0ZjZS8WU8cbktQg3HIe7SpZpSmq1M
	IjZU4lQvwjdbP+FDO3U265zDLaBRzKKtV0K4PYjkceQzfXvnc7MppNyI3oHeY9QsQ6YMahsCU5Y
	3H2W7G7AeLcZnwMCNWLNKR3PacCyzBqbvFV60wguewHTCYiof7aulZPFXUrXAQ5Cyacd0lNVG+i
	c+wYhqvtbCw2b4woFVBTqbTIE0IalztWn8SsPe+OuBL8+ALtr7oPY7SO0l7j
X-Received: by 2002:a05:701b:42d1:10b0:188:9ae5:162e with SMTP id a92af1059eb24-1ac5cdf9ae0mr5066603c88.40.1793394538003;
        Fri, 30 Oct 2026 14:08:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm9657089c88.0.2026.10.30.14.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:08:57 -0700 (PDT)
Date: Sat, 31 Oct 2026 05:08:50 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
User-Agent: K-9 Mail for Android
In-Reply-To: <c5fc86f9-3c43-4aee-8d88-92e8f88c6d5d@bootlin.com>
References: <20261029094916.3127193-2-coiaprant@gmail.com> <c5fc86f9-3c43-4aee-8d88-92e8f88c6d5d@bootlin.com>
Message-ID: <1B8D463D-1295-4BF0-972D-859C342E49F5@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 31, 2026 4:44:22 AM GMT+08:00, Maxime Chevallier <maxime=2Echeva=
llier@bootlin=2Ecom> wrote:
>Hi Coia,
>
>On 10/29/26 10:49, Coia Prant wrote:
>> The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII, but the RK3568
>> GMAC only implements SGMII, so only SGMII is advertised in
>> supported_interfaces=2E
>>=20
>> The generic xpcs core fills the mask from the compat table, which
>> includes 1000BASE-X, QSGMII and the higher-speed modes=2E Clearing it a=
nd
>> setting only SGMII keeps phylink from validating interfaces that are
>> not usable here=2E
>>=20
>> 1000BASE-X and QSGMII can be enabled later when a board actually wires
>> them up=2E
>
>So the PCS supports them, but not the MAC ? The correct fix for that is
>likely in the MAC then=2E
>
>There's nothing board-specific when it comes to supporting 1000BaseX if y=
ou
>already support SGMII, 2500BaseX may work (it's 1000BaseX but 2=2E5x fast=
er)=2E
>
>Ii may just be that these modes aren't implemented in the MAC, so we shou=
ld
>keep them enabled at the PCS level=2E
>
>Maxime
>

Hi Maxime,

You're right that for modes the PCS does implement, the limit belongs
on the MAC side=2E The complication is that the compat table describes
the whole Synopsys IP set, while a given XPCS instance only implements
a subset of it=2E That is a historical design issue in pcs-xpcs: the
table mixes C73, C37, 2500BASE-X and 10GBASE-X entries, but different
integrations implement different subsets=2E

On RK3568 the XPCS instance is wired up for the C37 SGMII path only=2E
1000BASE-X is part of the same C37 core, but I don't have a PHY to test
it against=2E QSGMII is not implemented in this core=2E 2500BASE-X and
10GBASE-X are separate modes the shared table carries, and neither is
implemented on this SoC=2E C73 is not wired up either=2E

Trimming the mask is not limiting the PCS, it is cutting the shared
table down to what this instance actually implements=2E A
platform-specific glue is the right place to do that=2E

For 2500BASE-X there is also a physical conflict: it runs at 3=2E125
Gbps on the SerDes while SGMII runs at 1=2E25 Gbps, so the same lane
cannot do both=2E

So the mask does two things: it trims the entries this instance does
not implement, and it leaves out 1000BASE-X because it is untested
today=2E If you'd prefer I keep 1000BASE-X in the mask and only trim the
unimplemented entries, I can do that=2E

The xpcs_find_compat() part is the more general fix: it makes the mask
authoritative so the core does not configure an interface the glue has
marked unsupported=2E

I agree the stmmac OR-merge is the architectural issue, but I'd rather
not mix that into this fix=2E The compat table mixing is a separate
discussion too, but I'm happy to follow up on it if you think it is
worth pursuing=2E

This reply is to the v1 thread; v2 with the folded xpcs_find_compat()
change is already on the list, please have a look there=2E

Coia
