Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0943BED2D;
	Thu, 16 Jul 2026 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190091; cv=none; b=MuyUH2qkEZFqlA73YEGOAYz1cdK8kbd/NFIa8Fjjrc9CZeF5ynYBLPMWohF1omagKNyDOGFO7cuP+X7NxMYe04k6IJ/qevw3mTRUov+KS3XyFWdHq2v0jSQPyeObECi3hgwIYO+JtUas+tXHhz8pcHHw6aIJP9D/IXqB9+O3GBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190091; c=relaxed/simple;
	bh=CHTclf9JowuT9d6FYNBV/Q5Paz+RyCSjuM6w57vCqjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GblIjby3HXVXCeviomLdd3eZJ/UuYzpMGDSDG3pkOeAj+8tOcd0TwSr5vYag2mRSEZnXX+zd89WjgyDsLd6tSiAgIB2YI0bwmxCPb5wLK06MvfemdQa8Kf0Eh0pOkAf2Dr2IJ1Wn8AC2hqFNtX0SVU0cvyBPc99JvG19j1LArJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SDRbpH7c; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SDRbpH7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784190053; x=1784794853; i=markus.elfring@web.de;
	bh=hffN6M1K3qALQBuFPMQS+Lb8FU/3/ajJ1t4JrMDVYkg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SDRbpH7czClfpjV1xBRaKIT6HN2+dp+tuYFIKuvzo7mOGXkiau+l/slyp1vxHp8T
	 UCGVujGDv4uDtjs7jwKm0vhuqsVj8n3ntlc2nCrPQtH5SiphgV/r6gGPQp07wT52I
	 1cMx7r85kjBz5BL7rdANuV35vAwIXSviUlyi4HVfUJNX8OEMrcGK52I3W3NZtnX8U
	 eHLjie7qBeUmpZJcBxm5/bViAnewUA7MfDQ7T57elxxhx5vld5R/0ILlpFqCQPqmM
	 UmF9EcAzvgEdLQwXqTKxp+IHZaYQ7Sc76ThNYaN7SPaB3l+ee6rOTsKJ88Sw057+V
	 FyVanOBXIg2dY/sfRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pYS-1wfJnP39XK-00EVb5; Thu, 16
 Jul 2026 10:20:53 +0200
Message-ID: <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de>
Date: Thu, 16 Jul 2026 10:20:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aliA1EIIrX82jGR-@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aliA1EIIrX82jGR-@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/5EIPkzE58Jck8nLXptLBnwJ5ogBTF/PsWKJEQ4NrsGPM90+5HF
 MlCE4c9AjZfZr+GL8OIFfW+YLCwFMVeALDVI+jFQt+jO03OvnZOtDV9SwTMNA3Cm+sqsWd+
 /gRjSLZxvZZge9RPhS5oGzYiXBwDR/KSwQN/UvNOv7APN31bgD6F+UmWtYPN+QsScM0lNx+
 cxx+iuSG4LRRHKEtxwipg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LkP9ZRJ4QtE=;pdTcBz/CdlFoP/z7HRdbBP91f+3
 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

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
ith NULL pointers, part 1=E2=80=9D
>> (by Jonathan Corbet from 2009-07-20)?>> https://lwn.net/Articles/342330=
/
>>
>=20
> Of course you can't have NULL pointer dereferences but this is not a
> dereference, it's just pointer math.
Does your understanding of programming language details differ from the vi=
ew
by Jonathan Corbet?

Regards,
Markus
