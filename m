Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794875;
	b=nhIVKnMt7AKZighPIMWPhFRFFERI9zVXca5mgX2CDq9dr20SUwhyboWrFnjUhtqXV0XY
	 hdEOQQnqvYZrcHZAlGgomEHGyE7LBV8AijVXgrQAhx/CPvft2DYWHojCTcAq9YeIfstKg
	 XqtTr27mT/MAn8VMrHnt6Vv0bbwMQSZRR7tjeENRbJ8z+azGik44hVQOba6Z8Q/JV3RL/
	 oMF+qQYWQ0qFuymEWTTBlO7780rkoS+N816jEHGuE1xZ6lEBiwaEq4wMhWuZBZVFdWaNq
	 PuPO7Q9ZLTpHWXDZs+TLnpjfC2CqKtZTKlt/MR/OtyUDSiamAm02a3vBXxf+6orD7nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794875;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=t+5ALu3SxfMtXK8dSlzHR0u+CXuqexSNQoee4rWPijk=;
	b=M7feXJPB17VH5FVnKMSNiyWDXuIvuEIRQishlcvJcv71x9q2YMPcS28rLA8ZaRp3rX2b
	 hD+mT91wejMu0umjrfKhEki7Mr/FZFQNIZM1ajyPTiGG5TktdL0ZhLenMlnFDTy1K+ed0
	 BJRlsbfqsw2N45SVv9TOMOhLKyuyFjmw1oIdRhmKPDN5ROvqS9Q/YWDrsXO+UQ1F6+sMB
	 hDWE8A1QeKQwf3bvu4Gc2N71nChxAVwlaEdK2kAyDswr2zekqkvCwUSDKKTXrNMut2oHR
	 phxqBJYbcqdg/WGDtHylpycj73RsBQS93FaugLlWHUOpN7MvzeTBjpetdqAKgQsvhAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=UqjNNXFw;
	arc=none smtp.remote-ip=212.227.17.10
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897D606A31B;
	Wed,  4 Nov 2026 12:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0897D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=UqjNNXFw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793794847; x=1794399647; i=jonas@jonasjelonek.de;
	bh=t+5ALu3SxfMtXK8dSlzHR0u+CXuqexSNQoee4rWPijk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UqjNNXFwzhi1NPn1Fwd2B4IVWpVNYJSpBYOx77A2Ql1bbReQrUF2X8PKkMefrvEN
	 /aJa4tPC+vuN36zahQ2qmyQHWxJaFzSl2M4H9K1aZVrTM/TRPyzwWHl4Ij6fPIjK8
	 J3tqx7nze7IC6D3NEK7PL96BhVjMZmvDdIJb3Xe7Y1EVmVSYhpDy8KnJ63iagjPWp
	 3e7o4Sxq6vHFsdpSb9LEbzTDGxpiEIPC91036nXxRiBiSDzofcl6IXNti6L277xtx
	 hMkkw5+qD5FnwXYFepUQgtLw0/LysuZehGNSzgK7PrpH98KUFM6qcUREgd7OKnSP3
	 V0wQGbviopf7b3k7bA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1Mt6x5-1wVWS614W1-00xFCD; Wed, 04
 Nov 2026 13:20:47 +0100
Message-ID: <e0910567-999c-4c96-9b20-2e34434bec3d@jonasjelonek.de>
Date: Wed, 4 Nov 2026 13:20:44 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: pse-pd: realtek-pse-mcu: configure
 global power budget
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Sander Vanheule <sander@svanheule.net>,
 Russell Senior <russell@personaltelco.net>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
 <20261103220312.860629-4-jonas@jonasjelonek.de>
 <5e00fd7f-40f9-4041-8dfa-fff222b57b92@bootlin.com>
From: Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <5e00fd7f-40f9-4041-8dfa-fff222b57b92@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tiscwDo2yseEFnKtASqrbIyNK1OpkL4ansvF+UBM4xHN4bilJwM
 NHk8e9lfRHksja80Ge4C76ehzpYDyS7mlmlD3H9nbn3HdoyOAEGcvIY5CBy8488v2lcdSV0
 dZXonfksnUdkCq6gWp2KUjuuRv8oywnVnwb4RhTJmjo6Uv/e11XIKyeCagI0v6yCqRS4mlx
 bmFfNirTyYVdzQKnjN1Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lSEaDRhdmOQ=;K0JpkGdxbNNpRP3rFMeVU0vr+fc
 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
 HghGbzaE

Hi Kory,

On 04.11.26 12:32, Kory Maincent wrote:
>
>
> On 11/3/26 23:03, Jonas Jelonek wrote:
>> Use the optional VMAIN regulator power budget to configure the MCU's
>> aggregate PoE power limit during probe. Quantize the available budget t=
o
>> the protocol's 100 mW units and reserve exactly that amount through the
>> regulator core.
>>
>> The regulator budget represents the usable PoE allowance. Program zero
>> reserved power so the previous firmware guard band does not further red=
uce
>> that allowance.
>>
>> Require a finite budget of at least one protocol unit when vmain-supply=
 is
>> provided. Program the budget before selecting dynamic power management =
and
>> ungating the ports, so enforcement starts with the regulator-derived li=
mit.
>>
>> Enable VMAIN before hardware initialization and register one managed cl=
eanup
>> action to free any reserved budget and release the enable reference on =
probe
>> failure and driver removal. Record each successful reservation immediat=
ely
>> so subsequent initialization failures are covered by this action.
>>
>> Read the current budget index before programming the MCU. Retain the
>> programmed MCU limit on probe failure and driver removal, as reducing t=
hat
>> limit to zero would interrupt ongoing power delivery.
>>
>> Boards without vmain-supply retain their existing firmware-managed
>> budget.
>>
>> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
>> ---
>
> ...
>
>> =C2=A0 +static void rtpse_mcu_cleanup_vmain(void *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct rtpse_mcu_ctrl *pse =3D data;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (pse->requested_budget_mW)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_free_power_budget=
(pse->vmain, pse->requested_budget_mW);
>> +=C2=A0=C2=A0=C2=A0 regulator_disable(pse->vmain);
>> +}
>
> Following patch 4 logic, you might not want to disable the PSE controlle=
r power supply,=C2=A0

I added it because of the requirement that regulator_enable() calls must b=
e
balanced with regulator_disable() calls. Accepting that this may power off=
 the
rail in theory, something outside of the driver would need to keep the sup=
ply
enabled. Concretely, I'm thinking of "regulator-always-on". And all boards
I've seen so far which can use this driver do not provide a provide to rea=
lly
power off the PoE rail. Sure this is no finite guarantee.

What is the correct way? I see either droping the enable call too, just re=
lying on
that it is correctly handled outside of this driver, or I keep enable + di=
sable and
the continued delivery is ensured with "regulator-always-on".

> this will lead to a power off of all your PIs.

Is this enforced by PSE-PD or just based on the rail really being turned o=
ff?

> I think you should still free the power budget, to not allocate it twice=
 if the module is loaded again.
>
> Else is ok to me.
>

Best,
Jonas
