Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CF3AFAEF;
	Wed, 15 Jul 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141170; cv=none; b=YFtTrOuv/Bo36dSR3+oE/qMJYgnovCtk2A7ytI4U4buFh681/o/rPd2TaDv+/7BTCFCF99UP9v4Rj1pj0BGuurOVEJe/xEUH2CQ0Ly9C1J0BycR99Bv9Ko7tsYiPSWzwZcAXqu0m6pttnkNW5sP9Pd4NpBvxUIzklbyRse196Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141170; c=relaxed/simple;
	bh=+xQYhW0d5aqLDpyhJgjez4KHXq15UVl6IQNbhLqEIHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVyF0HSnonBv6Aj9b1D1XuTRzXUYyJsf2WwPXa7PSeieaN1ad/EFq6Q1w3/2zvq6xaq56EcbJOWM0LDWMVlfVPF2wmEX/0LeuvTEe9KmG+7nXRspvNzCZT1VZgWGzYDoB1dLNJWRLpbIQVv+IT1B8eZq9PZk0uq9IYssdwHYhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CuSTQZ7I; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CuSTQZ7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784141152; x=1784745952; i=markus.elfring@web.de;
	bh=KEGz09AAEeiELUL58/7yKHo5RD5MkXxIXiRTk7XNRKM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CuSTQZ7IpnoXAO5qiGHWXbu1Uh6P28JVWWvfUpJCJZA4ba/lDXfLcVeuiCTk0G4u
	 y+FeHUeIdJX6OPP0IHAE7VJ8wsKcJqZD+rZV22PEHIwK1OXgzfF6w3PI+rZsX2iWt
	 akaAX/C4095v1TVi8M+SL9Sq3/uTfTmXbVS56YhDfavtzFn2v1Hhe2hkvYcsu7pQG
	 OhKAjTIGWmQxR9tyROyy1FiGzMtu6e4YQexroM9/QN15cEor1Y+L1Ojwo9hmjf8QJ
	 uOymR1KudG/3MOldFUdXlaRkjvt8aBc/u6B3z6JtWuvhUXUlPTHdOQ43IQZ2e/qqJ
	 ZkPkzkPx77B8ITutRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1xRgxN0nFx-00cM26; Wed, 15
 Jul 2026 20:45:52 +0200
Message-ID: <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
Date: Wed, 15 Jul 2026 20:45:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de> <aleFN4Z2XT3NP3od@monoceros>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aleFN4Z2XT3NP3od@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hoJP3cDmsdv7wcHe8/U9gLjpykWYvLA22oy+DwTkdzAg8Jp/OGP
 gn892G8Dl6+YjUsH4nThSAO8pCLD23SVUPan5w6kTtxEGDRS/eUJfRbVH7UwsLz5LJXQxb2
 scTPVwFD9ecE6CBBon6QIYcvAfL7FhksZQb/p3Ke4Ln8ESoNIZ0vBellmTGTiCUV+CUI8y6
 mbFlSoMImnUKNWVd4MqKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IqPXYEbNPq4=;tqORDZaBNz764dJT8rWu1Fw7Kpx
 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



Am 15.07.26 um 15:12 schrieb Uwe Kleine-K=C3=B6nig:
> On Mon, Jul 13, 2026 at 10:22:06AM +0200, Markus Elfring wrote:
>>>> The address of a data structure member was determined before
>>>> a corresponding null pointer check in the implementation of
>>>> the function =E2=80=9Crnpgbe_rm_adapter=E2=80=9D.
>>>>
>>>> Thus avoid the risk for undefined behaviour by omitting the variable =
=E2=80=9Chw=E2=80=9D.
>>>> Pass the required address directly to a function call.
>>>>
>>>> This issue was detected by using the Coccinelle software.
>>>>
>>>> Fixes: 2ee95ec17e97c58b65e978a08b75fa8cb6424e4e ("net: rnpgbe: Add re=
gister_netdev")
>>>
>>> There is no NULL dereference here.  It's just pointer math.
>>> No need for a Fixes tag.
>>
>> How does your view fit to information in an article like =E2=80=9CFun w=
ith
>> NULL pointers, part 1=E2=80=9D(by Jonathan Corbet from 2009-07-20)?
>> https://lwn.net/Articles/342330/
>=20
> It does fit, because the problematic code discussed in Jonathan Corbet's
> article is of the type:
>=20
> 	int i =3D ptr->i;
>=20
> 	if (!ptr)
> 		do_something();
>=20
> while here we have:
>=20
> 	int *i =3D &ptr->i;
>=20
> 	if (!ptr)
> 		do_something();
>=20
> which at least in my test[1] is relevantly different.

Jonathan Corbet provided the following information.

=E2=80=9C=E2=80=A6
But Herbert's patch added a line which dereferences the pointer prior to t=
he check. That, of course, is a bug.
=E2=80=A6=E2=80=9D


>                                                       Note, I didn't
> study the C standard

I hope that clarification approaches can evolve further according to this =
information source.


>                      if the compiler is free to optimize out
> do_something() also in the 2nd case, but at least today gcc doesn't.

Can development interests grow also according to another clarification app=
roach?

Does &((struct name *)NULL -> b) cause undefined behaviour in C11?
https://stackoverflow.com/questions/26906621/does-struct-name-null-b-cause=
-undefined-behaviour-in-c11



Would you prefer to omit a =E2=80=9Csanity check=E2=80=9D in the discussed=
 function implementation?

Regards,
Markus
