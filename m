Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670801;
	b=4TLSsVHjfdSPmNyAFNKZ84j+bS5gFnRNfMradKWtjglWPv72O1a3WXDGKKxOZhgnDmb1
	 Ti3ofRcexqpYDjfNkGtnpbTEi4EjV2xeqyrih8ufFO1qlxvw/SzAbwjBC3sKjd9s5SsIi
	 O7UFcqT+yApCxQGaLPZ7ItFeMWwVZ6LVNHPWJ+41ERTGNOgBgx5tsy211VtfeaKDzc+Qt
	 LaZ77CejiOV33NrjLq8YRowKiFerIF1T7lGpHmzvtLTdJFOV03UXRLDTpSJuOdyuWXrwa
	 W6qHBZ10ddrT4UpUKHPFwH96a2F0xR+tFSIJYFIWWGZpfOc07F0Est6/bLBCfXFwJlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=gQPf1gojSipDfNLOKsfEvoilcb1WU2m4yt6GDonHOXw=;
	b=nhn5DxLQzn+gYzKk8IorTzh1OMtT6FSzbD808hIi5qskipEdEv6OhmXQS9M153yPfWM6
	 5903PnA9qcU8I+9AlDOawLjrE1Kfv7Ezxf8EZlUumosE7snvqREnyp10qDS3y87/sSqu7
	 ApGQ151QMuAHlQ/Vd0g7e1jPaKcid4Z5MHGy5f1adPiRNi6HJCHMvV0HDaR68D/Asm+mG
	 94vSO2nVAjvafDtnjj6NWJOlPEcEmXYsoobI4w/MFeL3ZlETukPYT0rJ124pRoQitP+Ph
	 CXkXODrtEnFljHvNtA0FIPgzMb7eOh9Xfezw2W19owiDZU3e+yWHp/JQdHGkXGfuHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZCQJ8kLB;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E7606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A17E7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZCQJ8kLB
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-534e6545939so13057041cf.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670799; x=1793275599; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gQPf1gojSipDfNLOKsfEvoilcb1WU2m4yt6GDonHOXw=;
        b=ZCQJ8kLBJ/MoSPXRe8glkbJdNFWhnxWRRkDnFOjub/FZcJMQmkE1MFqc1aZEPDE9hJ
         oVBCyqu74h/KrpBIeywlmu/wEiQhWF4qvn9c9Djt3knhAb0a5BC5jDJJWPZsT0m3CMNX
         W+fUs17d6PXFlZ8g83RRkClLll40EeJvANyUBZrOnHBGzSQt2AxLqprx864kwUB0b/6c
         wNUp3W4oGTuXf+bRYw9kyYaa5Ai6GL1o934vdKOutIOOkIkhnEAiyeg6m5iKNq7qRA9m
         b/ZRJ9/mFtAd3fQu8PLXqvPeReGjgbUb5RW0t3AwDmqeTbMwl78bbHeRH0akkZjZFT+g
         Wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670799; x=1793275599;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQPf1gojSipDfNLOKsfEvoilcb1WU2m4yt6GDonHOXw=;
        b=RGAmeBoEXlzYVrPM7sRuUXw3x86D8n3DAMfotRiEDaGyDXnHLcBFsQTHfDQTxvXgfW
         lPDh95ouBLO3lU3u6QBZOJ9QKcB0FfP7Jubeg8ah3q0g1ojMi8/1neQTqdO94BK9idSm
         iZVIXWAIhnmv7yw/F9WuoATrxfOvaOVAWwgviL+qXbrF+A7IFIZieYhcNWC5f8vpJnjh
         INhgxvtg4RCFSXDk4huoGYl/DWYiS0oF0Aj12Tf1mxcglWLBkA+Fx1ryaKuOoaLSnROi
         GO/hnubY42btwJF4X70c0laGyF55v92oN7SEuYt2sIpRSE37b/KiQulTenuHR1eMsZVw
         1WHw==
X-Gm-Message-State: AFq9FYIBYKrRQQNUPvY7t6shSFFB7wxFU2P4RrFOUxFhnCT+x4yPtJiH
	GWjs61vn2eGhhLDuSrSf+8XoPtX/LKgXjvuprFRZD6ix30C2u2sMJfmV
X-Gm-Gg: AYBFou36lBbuLGzOEASJr//Qwkz7z68qLG4HdRe+MS+jlG/kirHSOpfIKOVnhCEAr37
	I2MiSQsMjLGA/hD/4C4Gbhc2Ws4TTuPiXLJvKp2L6rDIZ+VvszeIGeBvXuvM/g59IDF14wsTBK3
	5TT8Kg70qams/OLKG/B4rk+YB8x8cuWBmP/figzWw4XBpnfOppIhlhp2rNXca46ZKzo6WOE3zyZ
	A2oGA7pOWZ2x1IzVqYnMF9Af3//DaS9BSF+CxS9P3vi/ADCVd/ry4yAMU8NjQtOiGSQbuKyld2C
	/jhBamm8Qjc2LpkRK9bdk4rKNXTzbawycwTClFLeWNa9D+EeTsTc8+/kHVJYvJ35+7SJaS6l01b
	aklUHivz6UCvdJU9L0KUt2/QayDq22PT3bEXqP+zt9t7CNTPYAGLO84SUBAlAXPM0RdhZcYxx7v
	rfjliDD3LuRHl1fIu0KyBFEEaeZGfqRcaGjQDzLoTRp/vY7LVQwxBs6Mofb7AZKt2Le20x9tsG7
	Bf1x3pQR3/2NrSdBZ6HDBkInq49V4nukKWUhUyqS1PzdjftAxalABrBR45eZQ==
X-Received: by 2002:a05:622a:15c4:b0:532:d773:99a3 with SMTP id d75a77b69052e-5369b4f30abmr78052581cf.6.1792670799372;
        Thu, 22 Oct 2026 05:06:39 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab76a3a2sm24907881cf.22.2026.10.22.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:06:38 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 08:06:37 -0400
Message-Id: <DMBCRFEQZ7D8.1SQ5SSTSTGZFR@gmail.com>
Subject: Re: [PATCH net 0/2] psp: drop packets with extension headers in
 transport mode
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Bert Freed" <toddfreed@meta.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
Cc: <netdev@vger.kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "Shuah Khan" <shuah@kernel.org>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
 "Cosmin Ratiu" <cratiu@nvidia.com>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261021210200.788191-1-toddfreed@meta.com>
 <DMAUWQVPIVKP.1QAK1YSA76EHJ@gmail.com>
 <CADh2yMypAdV07rRufDqj1aOdEzAqEaH2bDkJ2jYV_z1_9iXRkg@mail.gmail.com>
In-Reply-To: <CADh2yMypAdV07rRufDqj1aOdEzAqEaH2bDkJ2jYV_z1_9iXRkg@mail.gmail.com>

On Wed Oct 21, 2026 at 7:16 PM EDT, Todd Bert Freed wrote:
> On Wed, Oct 21, 2026 at 3:07=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.=
com> wrote:
>> >
>> > The first patch drops the packets, the second patch adds selftests for
>> > that case.
>> >
>>
>> Why not just fix psp_dev_encapsulate() to put the psp headers in the
>> right position? With the self test we are going to make PSP + ipv6 ext
>> header =3D=3D drop part of the uapi?
>
> If the original ipv6 packet has extension headers, then the nexthdr on th=
e
> fixed ipv6 header identifies the first extension header, and the L4 proto=
 is
> in the nexthdr on the last one in the chain.
>
> psp_dev_encapsulate() places the udp+psp headers after all the extension
> headers in this case.
>
> The issue is that it rewrites the fixed ipv6 header nexthdr to be UDP,
>
>   ipv6_hdr(skb)->nexthdr =3D IPPROTO_UDP;
>
> It would need to walk the chain, and set the nexthdr on the final extensi=
on
> header to UDP, instead, if the correct policy were for udp+psp to come
> after the extension headers in all cases.
>
> I'm not sure that's the correct policy though ; for some headers (e.g. th=
e
> fragment header) it might make sense to leave them on the inner packet.
> Note that the psp spec does not describe this. Perhaps the user should
> express the desired policy?
>
> Explicitly dropping ipv6 packets with fragments is consistent with the
> current behavior (it already doesn't work).
>
> -Todd

I think walking the extension headers and inserting before the transport
header is better than dropping. I agree with Bjorn that rejecting
fragment header makes sense because the receiver can't decrypt the
fragmented PSP payload.
