Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796697;
	b=Xqc2d1uGzvrRfZ3LUn5lwaAdrrKWdBtbkcYM+dDXyXz8CjMlUfiB1q5ieu6T9CQLLi7P
	 QVjn4MMrwD2bNmp6JmcEmpb/5k3Qzpjl6fGnpf35klYcJrcEAiFIiWYZgdycGBO8fOg4E
	 RxEgoJEqmuj5NEJ4rTruE+MnYetLJuTnHra9WQGwbNMv6QyFM6w6zWL19G19/xhQsCR6b
	 f7yH7maMxeb27kKb+EuNl2pNfne99q6lsF8R/9LavAfSGnFfPED3OjDP0isHlNWTUdzwS
	 eRN1pkLB/nz5zBKSQtYquEw+77AaeWsUAqAQv43VcZjonIpNCMQ0Lq94wKTQ9Jp2Acg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796697;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=GTgLqekxREDnux3hnYrxYqItzfHMhOlshtaUeR7+j5Y=;
	b=yopM4f2FNSn+c7hFwPIH/pDCtqJyc7Ns9sPTSpkrvQ+QCg1Zz7OXEeQ676kqL+LStVHe
	 vYgjcxJOfoO+aENhocDXR31hRKg+l3Mg8NoN6hZ3LX6t9wWVTtSO7eTyQwUcizv//fogm
	 qj863n0gcH6hWbjoMn9TC/qC5ErSjoOOImAOF7IpYUPY3SaxqaYNB1cb5xXuhU+Xlr8+3
	 pbs/CosZwD39FzIKmv/coDkB2itQhHFnOeLRU4uyxkId47DgYlpWI4lUe00bYOKwMHRYi
	 tHuoyxgawoWilHrIPIWUcCJ64gIPC+EpXSUJfGAPHA682ylKn2G79+FlKxJrbwdeNUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=1SzuAvfl;
	arc=none smtp.remote-ip=217.72.192.73
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8933606A328;
	Wed,  4 Nov 2026 12:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8933606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=1SzuAvfl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793796687; x=1794401487; i=jonas@jonasjelonek.de;
	bh=GTgLqekxREDnux3hnYrxYqItzfHMhOlshtaUeR7+j5Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=1SzuAvfl0xA8weUUl70fmcYiTjnU/ehtK41ZbzgsPfDnutvmTFPdgEvl6XSnwTv2
	 K22ffL+k8ziUe2t1+FfaBDA8dhCUkzoLTy6c/SJJGzWGUO720cmqFPwKl5llKAmgt
	 9KcUAGk6vrmoXy0pKYOFYIn2u2nd+EzR6i0D4a8Dm6EUB0DxJe3b/O7VkG0SU3F7G
	 gy5tgwOVEsRoPKjW3jGn+VlECLjz4ailLfvM/4aDbesAyfjWvd8W7LJUjfulXI1dd
	 58M7OOBjE/ewM4EYfDN4jbHdspmnBy/kXF7Eb90MpabFJUXvp1/wtWsPyuixSlX4O
	 0+xxq/4bAA72sg3tKQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MhCq4-1wtONZ2THG-00mxZq; Wed, 04
 Nov 2026 13:51:27 +0100
Message-ID: <d1196efc-ef27-4b69-81a6-f1fd99ccb85b@jonasjelonek.de>
Date: Wed, 4 Nov 2026 13:51:24 +0100
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
 <e0910567-999c-4c96-9b20-2e34434bec3d@jonasjelonek.de>
 <357f6311-7f00-42c3-8eec-e0fd0c35749e@bootlin.com>
From: Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <357f6311-7f00-42c3-8eec-e0fd0c35749e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W/jSt+EVkXI+DSADrCyMZJ32Rl3/tDP8Pp94pKOhcLWv6ULeWgC
 CP4ozdJKUtn/PEqmGlXedWG96I9n7o6RrzmLeejdiL48SAD02xEbiuNalooRnbG++x62nOC
 wv8fenebItzY4p5MYQR/zI/8DZl68LHev57mpzC4P9XHvghltbwpymciztTjO03KpUVZjXf
 tVRR2ah+vjrLJaFgckbpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oECLamO+RUs=;Drag0WLXKGMnf3KIkkcOiIijqOA
 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
 6kW3RXz7



On 04.11.26 13:36, Kory Maincent wrote:
>
>
> On 11/4/26 13:20, Jonas Jelonek wrote:
>> Hi Kory,
>>
>> On 04.11.26 12:32, Kory Maincent wrote:
>>>
>>>
>>> On 11/3/26 23:03, Jonas Jelonek wrote:
>>>> Use the optional VMAIN regulator power budget to configure the MCU's
>>>> aggregate PoE power limit during probe. Quantize the available budget=
 to
>>>> the protocol's 100 mW units and reserve exactly that amount through t=
he
>>>> regulator core.
>>>>
>>>> The regulator budget represents the usable PoE allowance. Program zer=
o
>>>> reserved power so the previous firmware guard band does not further r=
educe
>>>> that allowance.
>>>>
>>>> Require a finite budget of at least one protocol unit when vmain-supp=
ly is
>>>> provided. Program the budget before selecting dynamic power managemen=
t and
>>>> ungating the ports, so enforcement starts with the regulator-derived =
limit.
>>>>
>>>> Enable VMAIN before hardware initialization and register one managed =
cleanup
>>>> action to free any reserved budget and release the enable reference o=
n probe
>>>> failure and driver removal. Record each successful reservation immedi=
ately
>>>> so subsequent initialization failures are covered by this action.
>>>>
>>>> Read the current budget index before programming the MCU. Retain the
>>>> programmed MCU limit on probe failure and driver removal, as reducing=
 that
>>>> limit to zero would interrupt ongoing power delivery.
>>>>
>>>> Boards without vmain-supply retain their existing firmware-managed
>>>> budget.
>>>>
>>>> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
>>>> ---
>>>
>>> ...
>>>
>>>> =C2=A0=C2=A0 +static void rtpse_mcu_cleanup_vmain(void *data)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct rtpse_mcu_ctrl *pse =3D data;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (pse->requested_budget_mW)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_free_power_budg=
et(pse->vmain, pse->requested_budget_mW);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(pse->vmain);
>>>> +}
>>>
>>> Following patch 4 logic, you might not want to disable the PSE control=
ler power supply,
>>
>> I added it because of the requirement that regulator_enable() calls mus=
t be
>> balanced with regulator_disable() calls. Accepting that this may power =
off the
>> rail in theory, something outside of the driver would need to keep the =
supply
>> enabled. Concretely, I'm thinking of "regulator-always-on". And all boa=
rds
>> I've seen so far which can use this driver do not provide a provide to =
really
>> power off the PoE rail. Sure this is no finite guarantee.
>>
>> What is the correct way? I see either droping the enable call too, just=
 relying on
>> that it is correctly handled outside of this driver, or I keep enable +=
 disable and
>> the continued delivery is ensured with "regulator-always-on".
>
> Indeed if you use "regulator-always-on" it does not turn off the power s=
upply when we call regulator_disable().
> https://elixir.bootlin.com/linux/v7.3/source/drivers/regulator/core.c#L3=
269
>
> Does the PSE controller needs this supply to start, or is it only requir=
ed to power the PSE PIs?
>
> If it is the first you will need to enable it in the driver.
> If it's the latter, you could describe it as the PI's regulator parent s=
upply. An enable of any PI will enable this vmain regulator.
>

The purpose of this supply right now is to have the budget defined correct=
ly
and let the driver apply it. The rail input and managing the budget global=
ly
across all downstream managers and PIs is done in the firmware. The physic=
al
rail on the board itself doesn't need explicit enabling, mostly because it=
 really is
always-on. Potentially it might be used for more later, including referenc=
ing it
in vpwr-supply of PIs.

So having regulator_enable() here in the first place is probably not usefu=
l.

>>> this will lead to a power off of all your PIs.
>>
>> Is this enforced by PSE-PD or just based on the rail really being turne=
d off?
>
> If you call regulator_disable() on the main PSE power supply it will tur=
n off the power rail which will turn off you PIs.
>

Best,
Jonas
