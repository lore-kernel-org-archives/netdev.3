Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF93AA50B;
	Fri, 17 Jul 2026 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268646; cv=none; b=Kz6+7fMiImcQkkafNFDD0JLF6TEF9mC3t/vwM7cuwPSa5adiwCkiPMDeQrQRkzBoXIGYNijsXBbzIVHBs3eeSxz6oS6wBmdW7DwZXGJRWvaFvBHwcfr5xzK+xaWjjSRMmTwA+h1iZrdD2MIa8eXiGwK3W724u+qP+8S34fLIt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268646; c=relaxed/simple;
	bh=/MK94NiSyRWRZ6tZjJOcLu1mRa9DIYVSppn7PBCjIxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ5CUBn+pXNho8jWKlfH/DZRe14e8DdvJsRz3CWPneZceDuMD8qXYqAx2nGS7c7U2KL6535pglzixviBIYWsSR+bI9YxQhBfqQFovkPb/5MN3u/dvanDqeYbUQfVPocdThwqo0mK/EGy/x7bYvb5ZcfY4MtDETzd78uyKFKtiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=A3P0ydsg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="A3P0ydsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784268618; x=1784873418; i=markus.elfring@web.de;
	bh=/MK94NiSyRWRZ6tZjJOcLu1mRa9DIYVSppn7PBCjIxg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A3P0ydsgZSxcWW8Hz6pw+tjyfKb9EiuvHQ5oysgXiBlHHGttEL/8k+v0TgEJWkdK
	 r43GEoUNDvyqP/T4EQVw/eyhfo7AkzCFzbja/r5qxckYZzA/5IdRL+9rXzN8LfjvW
	 tnpbkO1MNF+nGN27sgGlqeJ6PhOX0VohltMgqopZOSGwFUTx1xEHPxQ8l6Kh+F2av
	 tfwuRxwO5rm0lcDiqtrTdEM9zf4+7/z7NWc2G92MNlwCtVw8p+dz132zPBTX2S8+J
	 4tFavanFsy0c4w6Ih5P6G8D5jOMZQG7skpkDxBwYTFli776yULCM6sLX8Oe4p/oRR
	 55y/ulI5CzYD+uP8AQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLijy-1wSwMk0pEG-00TJQE; Fri, 17
 Jul 2026 08:10:18 +0200
Message-ID: <97451fd1-3d52-4e07-a1ed-634eaef53481@web.de>
Date: Fri, 17 Jul 2026 08:10:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 net-next] net: rnpgbe: Delete a null pointer check in
 rnpgbe_rm_adapter()
To: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>
References: <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de> <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
 <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
 <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>
 <aljdzTZ_f5v6ckVg@stanley.mountain>
 <d70814de-30b3-4315-9455-db58477ab085@lunn.ch>
 <a4fe0527-6302-45dc-b4be-40282c2673b6@web.de>
 <2d60fe2b-06cf-4c35-98a0-fc0f8034180b@lunn.ch>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2d60fe2b-06cf-4c35-98a0-fc0f8034180b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AVpFvtERI7ddU5FAryeHdW9WIw/09hde3x+Qb5+SFd63ordD5fc
 UcrKlVME1T+CTjD0YgU+SeN4Un0FWrzS3sZCa6tyElmCbMMWaibW1ZDbyTEZ6gb9OjKcOip
 VFIvOPxSocbBNo1LSafywbc1pN+Z4pwsysmD4B3CXLrLYJupmH4julWFs+70hTT22lIQZun
 Ne7fvpTj6NduxZR1/aAMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HmCXA9zjtgw=;CZvNxDlEYbSMdkdDWC1JF5FAzwl
 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
 dmpeIW0wg=

>> The check for the pointer =E2=80=9Cmucse=E2=80=9D was finally identifie=
d as undesirable.
> I'm not sure finally is appropriate. It was one of the first questions
> i asked. Also, i expect anybody looking at a Coccinelle report to take
> the time to understand the code and decide what the correct fix is. We
> have too many developers doing the minimum to make the tool happy,
> without actually thinking.
>=20
> Please also include the reasoning behind this. The commit message is
> all about "Why?" Why is it undesirable?
Why could a redundant sanity check be tolerated for a while?

Regards,
Markus
