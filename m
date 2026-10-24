Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792871449;
	b=3B40UREFSAAfpOUFIwLamIi+N/rUcUsa2tfYrz1dLGBlc1z43kIrEGa8JPSosiNWUwm+
	 VhChuTnR+f9LUFjJe15Xci9Cx+4RUg8oN1aZ+1IMqsmRO/yMSnKu6gYmvkwkaZtoD+xkd
	 hg+OKBEpuMchHjpZIkjQtVqzAMqb3N0ESEC4mi8uY3GImT85cTE5Q6STKX7PrenAlpTbz
	 +EZhBpmaBGRUUPpgrv8R99TvxDC6t7ZN7grbrolE3xWO+Blonxitmvr7wGVxi5jDbpRrw
	 EvOSCEshya/oDip9rJz1om2dNE36kFqrsVFmsIRseBO9pn914LO3XXptkVI6qln/tug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792871449;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:Disposition-Notification-To:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=SCNrj+kcqPB30TfxopRSWTtc1BFF554gxizM38t+6+w=;
	b=n9kBNbUaIZzaFEr7nDzobUkpcJ2vDwUahQvhg5o29ytYJigPRI1ILBb8pjW5VKWUnSoD
	 rXdpSTWzwuTMY8K4U1MD+Xv+RdBWAtr1M4Xj0OHeIsGj0FWeeBCvKz/6P0nwh4BaHlRYl
	 z4bdlzjLbtz8vHXSzoSdTEbeWGIGOMXXrK7fhOHT1qQA5vGxNE8ojXR0SZjsDWGfCxt2o
	 HW31HgYebCMl9ToJxJSajKeoDRqSn8Qt5uNnMHtrC3xt5esAFJVxbKelRhexDRIiUFe7O
	 J3REdaCkp5ysuyntJHgathHtWwtk5CY1RGZGWsWk6xVkFbwcmUM3UcKfN0VvrFjtw2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=matthias.tafelmeier@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=I5CpWvte;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A09606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 19:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A09606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=matthias.tafelmeier@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=I5CpWvte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1792871446; x=1793476246;
	i=matthias.tafelmeier@gmx.net;
	bh=SCNrj+kcqPB30TfxopRSWTtc1BFF554gxizM38t+6+w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I5CpWvteuD6dv8D8G22TYg0d6wkPHPoZagJ85hH9PnrfxnDnIk9QjblqPESctjr0
	 FgFZKI3VL8hNhHXhj2ofLYxY9coRDL7dWY0h5CH6rUC/lZsi1kN3Hsf14JY8h4s0h
	 AIHZm+xQJz638gxIzn5ujxnuDyp3KUDRSuZd01BnNQCEX+BvwrTmbjb3SkBwptYJ6
	 jU8Dv2a7GHegd/UBYDfYMUVfnM03IBSdsm2NDqMqWM8vpcqcC4forQA9GpRggS0k5
	 JnIIk801hcVOefuHA69uPTbewD6jI/gMiy2T8O3LDs8RI4SGLdIcH9Nbxu2psFZoG
	 vIW9BUraDgh4J3RhlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1x3Auc2QzY-00RQRn; Sat, 24
 Oct 2026 21:50:46 +0200
Message-ID: <44d79af1-be9e-476b-8982-e7009bf5a088@gmx.net>
Date: Sat, 24 Oct 2026 21:50:46 +0200
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
Subject: Re: [PATCH net] net: reject dev_weight products that overflow int
To: Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20261023114228.289161-1-jiayuan.chen@linux.dev>
 <20261023123102.3c30d01e@kernel.org>
 <607851eb-e42b-46bc-928f-91db542fa9c0@gmx.net>
 <20261023130812.1ba2462a@kernel.org>
 <CAL+tcoBiuu3f+XDkg1a+oZPgPfBYHbJEKYd4MKFv20Ma668ANA@mail.gmail.com>
Content-Language: en-US
From: Matthias Tafelmeier <matthias.tafelmeier@gmx.net>
Autocrypt: addr=matthias.tafelmeier@gmx.net; keydata=
 xsBNBFJ0FzIBCADZ/hkwcprVGydMOqeqM+2k6v5e5kb4YDMKU7nMbCVmH4sn01T7Yh9kDwG5
 LOMLD06BB2txjLBvTY+c0mpK+hE4pWr+i3qhU5CbVvx7jppJqCD6ZT/TA3I7NxsdixRvLIF4
 UXgKQOMKPIx+aw/sp86NqzCLAMse7F0vXUjAP5YANtJid2rfr/B37BGKhqDGhi4Appz4UZOz
 pRov/v8JD4XScuvJnl09/oi5cDj3Mn2uqOc/G6hAt7HXsbHh4dKxd3AftqPPzEkJAmm+9Z4A
 SG9hy8IXms8Czimr+BGL0CnfsJlX6DCUm6mVDqT1GJyzmP4zkWcPi+2fOI4KtpV+C7+bABEB
 AAHNOk1hdHRoaWFzIFRhZmVsbWVpZXIgKHByaXZhdCkgPG1hdHRoaWFzLnRhZmVsbWVpZXJA
 Z214Lm5ldD7CwJgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE3KAB
 pALWdMCm+KI24BZPW4rfNDsFAmfFwnAFCRkUEj4ACgkQ4BZPW4rfNDuYyQf+MXXaG4Xx/9up
 NKSFy7Sq7dMVkM90KVVtfh9KOJUBm+8SUL782mxE8FgkpvGjDIbiUaSjyvj3oF1SNDKuGg1f
 58oOEQrA/Zv7CEvB4kzPUg/AL0Ao7PobKiZ7hJ/aFYQaB50IIBr+af+WfCjblW+5y6irihTc
 xPuKkHvV+S+saAQ3mcdQQVWgFsLnMTz/AQFL7DMsmJB9XFTIx+G4Q+xXCfNM2uyDUcSf2t4l
 MT6V301O/lhKk9MMyB/CxBD/HvdoiOfWHEGF6c7LilxbHcevge+Il4R52rWcVEZwmeH70vGu
 yRMbBzSg16E3oXMK4Srz5SJUU3Nx7ougjwuv0irWNc7ATQRSdBcyAQgA8gKv7nI3K5Vyay/n
 GmZEqfMqhOMnvG3QQ+Ku7z3ksRQ83bm0nKLw9mYtyI0mcShDbfWOMCWhC/HWlvdyvfnPMZc9
 M8nl8QQJkPExYyNW8IxvhcrRiOoIX2L+4qJznOqPBE0A8QZM79mBL57bWVQlKa4pHqblZBwq
 AEf62pLeuh2CO6ecg3hSI0zFur9VUYgJY+N2ChOSpYTevxC2EouDguPMgsQfcdsbf2X69PAQ
 po/irnFKEVmNFStkLZqcE/6BDH8VsF9/e5+kIv0sXl2TLBk/c0dXJpr8PxProJOPtHKd3g1n
 L+p2oYyMyMS5/RGSBcXtRqvgZea45+shx/9foQARAQABwsB8BBgBCAAmAhsMFiEE3KABpALW
 dMCm+KI24BZPW4rfNDsFAmfFwxYFCRkUEuQACgkQ4BZPW4rfNDu2nwf/Z0JumzgpUE2EHA7F
 j9KzO8TZeMRzXDvigduOi39bT1+kBcRNigMrLOk8dGCgYeT44vTkJCVji23I4YuFH442fvAa
 m3f/9L0ob9As/lGc/VIrEWlplFgDQVKgStLjoKBCD6/VVmy0o1nlZUhH9fXo4V2EoYtuDORV
 uxTTKyFdl9U335HrYboFdYwbOhkE9rM/IPWQP7f3jwdhRfvSL9KCzxiH3VmTCKojmYECQo2X
 O5XeWTvzc2E5ML9qsvXO22cXdmga3krfNrtZTbV6ZYYqYr9fgWo5BWiCp31bGjyIn3q/YzhQ
 gBadsya6LEPJZGkruPVwL5N9H6x28dzgUXNk6w==
In-Reply-To: <CAL+tcoBiuu3f+XDkg1a+oZPgPfBYHbJEKYd4MKFv20Ma668ANA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E3BPgimiWDxLZ4a3mb/lWIRBqSRaq4pb0REF/9sw+59pdkhIMfV
 cJ3csIUoAkcFvWoSyGxNIdx6wEfFqa5StGJF+MwqSQMQ01dmhwHTrEnzkJjQZTSzC6eXnZ9
 6SnyXHk7hCLlt2Fa+0qs/otJbP3yAcUhGr5wLaP9lDy14yz0n24GhXx921FfiUDMhva6xgV
 B8BetJdOTzaPasl2eNgLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/nJKR+wGnBY=;o3q83nduaLcnea6QWbho+LPl0Ze
 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
 =

On 10/24/26 10:59, Jason Xing wrote:
> On Sat, Oct 24, 2026 at 4:08=E2=80=AFAM Jakub Kicinski<kuba@kernel.org> =
wrote:
>> On Fri, 23 Oct 2026 21:32:40 +0200 Matthias Tafelmeier wrote:
>>> On 10/23/26 21:31, Jakub Kicinski wrote:
>>>> On Fri, 23 Oct 2026 19:42:25 +0800 Jiayuan Chen wrote:
>>>>> proc_do_dev_weight() sets the backlog NAPI weight and the qdisc quot=
a
>>>>> to dev_weight * dev_weight_rx_bias and dev_weight * dev_weight_tx_bi=
as.
>>>>> The three sysctls only have a lower bound of 1, so the products can
>>>>> overflow int and end up <=3D 0, e.g. dev_weight=3D65536 and
>>>>> dev_weight_rx_bias=3D65536 give a backlog weight of 0.
>>>> Not sure anyone uses these, maybe we could cap them?
>>>> 1k for dev weight 8 for bias?
>>> Capping does not make sense to me.
>> Please don't email people off list.
>>
>> What are the values you know of being used in production?
> I'm not Matthias. Revisiting my past experience doing AI tuning stuff
> in the testbed/real workload, I once saw performance improvements when
> I played with this weight and the driver weight. But I didn't manage
> to see the deeper underlying reason for that scenario, which means I
> was unable to replicate the methodology to another scenario. Maybe
> it's a good candidate for blind AI tuning...
>
> With that, I think capping at 1000 is fine by me.
>
> Thanks,
> Jason

Sorry about the off-list mail =E2=80=94 was not on purpose.


To answer honestly: I don't have the numbers anymore. The setup that
motivated my patches is years gone; I can't name current users of large
values, myself included.

But my argument doesn't rest on them: a change to the sysctl surface
should name its harm in both directions, the same as a new knob should
name its need. The wrap rejection does =E2=80=94 an overflowed product is =
not a
configuration.

An envelope cap doesn't: above the useful band,
netdev_budget, netdev_budget_usecs and the queue already bound
everything, while the cap would reject configs that worked yesterday.
No evidence, no change =E2=80=94 the burden sits with the change.

Disclosure: I'm building an autonomous system/instrument that tends live
infrastructure =E2=80=94 it observes state and steers through exactly thes=
e
config surfaces =E2=80=94 so I have an interest in the space staying as wi=
de
as the arithmetic allows.

My stance for AI era is we should have even more and more surface in=20
general.

We should take in Jiayuan's patch for now.

If caps are ever still wanted: I'd suggest a separate
thread not to mingle the matters too much -=C2=A0maybe ten arithmetic boun=
ds=20
(dev_weight <=3D 65535, biases <=3D 32767), not
envelope values.

Cheers
Matthias

