Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785899;
	b=uDmOWklY3Y9OvnrVG+L48tOt+4CBkE32CCntSWotvp5h1lVVAl37kZylT0SHcJUpPfIB
	 pAmaM92o54VoHv8AH5NGPSvmUU6IrnbTJ58aWMahwaFXri3px3+iumyKs7caDk8t1vzxh
	 o56v0u3M9lD0gWpaGZpktG6aqGWQQ/hKRybqdr7ZQrDLeAoHQzCvwskwTtH8PO3aOAvfx
	 Di0uNpBJn+8+gKYO9tHrfBVdsNy/uXO76OZpIIa16XErcHJNHtluq0Mq/K1KbFZfPPvrG
	 +USEjzvJ1CaG/9byKZL6PIVZ17oNq8HAdRNiX3Ec4q4Dt7cnjXhmYTjg5TWfCxwNzlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785899;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=kZmwgsq2euZuRwrrnE3ckSKAVMRx12ifpPWl5rPDrL8=;
	b=ys82Lyw+SlhbrYGTLQTOXWhEhehoE2zOhWv7VLBVa6f0CL6kcnMAyPeq5vrCy692aNAv
	 XscMM7eCFwc9PAX2Tl/eCT2h4wahJCU9X4fCyauuJAVNFe4VLIKWAsP1qHh+xkh5ptz5P
	 bbLYDxTHdzhKK/fGFS0jZVkNacT3DNEGc4F9IoTaOmgLaP/YBMPzbJbYvcGGb6IDPlU+z
	 uAr4QufsX6eXsADRu8j0LIoi7aL9McYdwN+AaOLEqAY2sH3mdcxUGfQgXlgQ1NNnDYau7
	 2IuXfxXgqCQ7ma5HCDFXiFKozruLiVB6SSV0oQ/PwIdSaliRc3qZV4xBNJVjD33posA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=dQ1PLDGj;
	arc=none smtp.remote-ip=212.227.17.24
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40183606A328;
	Wed,  4 Nov 2026 09:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40183606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=dQ1PLDGj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793785864; x=1794390664; i=jonas@jonasjelonek.de;
	bh=kZmwgsq2euZuRwrrnE3ckSKAVMRx12ifpPWl5rPDrL8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dQ1PLDGjiWJg/v7f/s19c7cuxjckamcIITrTAFCl8fQP23AkfwATANBC1S2en/ra
	 MwV9QmPEnVKtJjtoofLkpEzLurBujBw8l+l3KO3udVJZh2D8Jcg4oM04/9jlQiN/I
	 l+34ZU9Lb3kwG6DTNs4ZV3u/iiguOOsgiTaMmm5WLZGaZlE8TivtFcsMq3Zay9z3A
	 UsuYm6C8Q/4oxTG+T0c7jkKxpdWd74NGwyuLNP0NkKPKlSpts+2wYuTNpUxG1hdEv
	 zBQw9Na5wn0kBUcrqPyDsKR47KNRJxBVNK+ENL+Ma8o7uDvCjXHu+Mj9dK+As4woB
	 hmqhBlgnxtAQ8vFGmg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MowbA-1wjV0Y0mOk-00hTin; Wed, 04
 Nov 2026 10:51:04 +0100
Message-ID: <05061207-9c41-410e-9b60-c19428bf8585@jonasjelonek.de>
Date: Wed, 4 Nov 2026 10:51:00 +0100
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
Subject: Re: [PATCH net-next 4/4] net: pse-pd: realtek-pse-mcu: avoid global
 disable on teardown
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
 <20261103220312.860629-5-jonas@jonasjelonek.de>
 <5fba2b22-a7b6-4c9e-96e3-1ea41b984ba8@bootlin.com>
From: Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <5fba2b22-a7b6-4c9e-96e3-1ea41b984ba8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gsHUty2uZsYmoM27TOS1eZBV0eWfq5zWfptcqsY5SfmUozXAakO
 wcJqi38Oc143elPnF44gotc48K3Naxpy+v5WweVXKwYIaXLEUicvpy38DoR25wOEGO6fwLF
 9Ls7GZnSkPWs5gevvP1aYaAlvSZ6JGWwYlyxcGFRSZUjdHVAE1bfjg7m9zGGA7pJ+qERxYK
 WrEJMg7zULHv82/MuzzZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Ir0M1KS+Os=;apCugwWKtGkCnUGHIHPInhljfb7
 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
 Z/+nlCmdpsodjN1

Hi Kory,

On 04.11.26 10:45, Kory Maincent wrote:
>
>
> On 11/3/26 23:03, Jonas Jelonek wrote:
>> The driver installs a global-disable cleanup action when it enables a
>> previously disabled MCU. Consequently, driver teardown stops all ports
>> only when the MCU was disabled at probe, making the behavior depend on
>> the initial firmware state.
>>
>> Leave the MCU globally enabled on teardown so an independently powered
>> controller can continue autonomous delivery. This also allows persisten=
t
>> supply constraints to keep the rail powered without an explicit global
>> disable command stopping the ports.
>
> No SoB?
>
> Also this patch is not related to power management. Please send it stand=
alone.

I messed it up completely, my fault. Sorry for that.
I'll drop it from this series for v2 and send it standalone.

> IMHO this should de send as a fix because we don't want to have a remove=
 behavior change according to the Linux version.
> With all this change you can add my Reviewed-by.
>
>> ---
>> =C2=A0 drivers/net/pse-pd/realtek-pse-mcu-core.c | 13 -------------
>> =C2=A0 1 file changed, 13 deletions(-)
>>
>> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/ps=
e-pd/realtek-pse-mcu-core.c
>> index a90e19fb90e0..ab57c348436c 100644
>> --- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
>> +++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
>> @@ -894,13 +894,6 @@ static void rtpse_mcu_cleanup_vmain(void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(pse->vmain);
>> =C2=A0 }
>> =C2=A0 -static void rtpse_mcu_global_disable(void *data)
>> -{
>> -=C2=A0=C2=A0=C2=A0 struct rtpse_mcu_ctrl *pse =3D data;
>> -
>> -=C2=A0=C2=A0=C2=A0 rtpse_mcu_set_global_state(pse, false);
>> -}
>> -
>> =C2=A0 int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rtpse_mcu_match_data *match=
;
>> @@ -994,12 +987,6 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && ret !=
=3D -EOPNOTSUPP)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return dev_err_probe(pse->dev, ret,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "failed to enable PSE system\n");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D devm_add_action_or_reset(pse->dev,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtpse_mcu_global_disable, pse);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>

Best,
Jonas
