Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793624301;
	b=ncHfAszdoymQuKuzshpm1j9leApb2NIlJajEELj0fLvWw1MYH/N2UOVonNMvCzlhViQi
	 OUOI/0KuHGDnnbsToXz6E1upTbY4EYjY2VSuF2SxosqA9urivbj2NDb8Np0UpfJicikdx
	 +IzlAAQiQ6xUxTAJkNMJDKvyB/1VBtmHovHIP5NEWZgypvR9R9A4HWckKZXB1gOHxGvuK
	 cXbesmNEke1b/daevjd1rZnN3aeuIf2PURLYl0SE1tlHpleE2rBurNhnA8rfSE1bEx/X3
	 xPp/AUmqE+jBdAXKBql9s6qxWFTGaZQP6WDDPrj57Fd6j7bIJZSBPn+cg3wiNvPaWvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OQFH2hgC0TDM1sRzbEadUUZlJqc+Evd7f3Bf5CeXHcs=;
	b=PSoROSkIggiQWE6yFUc9ITIEg+FjGDBvup+B4Fm4KsXs/u2JbgowA815Zc655ybz16C2
	 KInXXnDMZPLc4aKESwGqUvqIwf80RGofPdR7WJJ0tKulQtKQlUp98AOy/BkPUB3jxjyWS
	 FOPWBqabJzodY6U1+1uBJ7FvXYRVPYF3Ts0JOn7f5DHSWhetAWIfRdFXCpFOSZnATJqNX
	 rAJ0dSamHEb7t+aaeTCqOgRV4ScvsnWv1FeN6HlcA4R4kJdFF2aXLo4XD4RAaH+p/kG4F
	 H+J7/YivyhK6849Q33T+HWFUReN2Hu7F6dEnLWUTpDd9xVYTRS9HHkgUwYQPuQ2HGZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o2KeHr3j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15C606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA15C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o2KeHr3j
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ac525c1f05so26523317b3.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:58:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793624300; cv=none;
        d=google.com; s=arc-20260327;
        b=IGuYnRQsWSY9tGbdrWuLgMdJUSJDjkC8R8wqLMkYoSa7mk2IEQBQVhX2qgKnlcw9v9
         N9FcKe9VMjqNoWSw31DVplSgUzZO3Lp7ehLihNbbhBn845GYVfCbKjp4sVoAtlcS8gNo
         bWObcWmh5J/yOckBDwj9lGqEXKDNZ5++H+yzggK5X6mSTF2A80IftesARWjPsJR7lQKY
         hBsKLYUI5yX2rxoW3G3/Hln0u+cMukck6hiPrsLALF30QHu3rBtmQKvYrIB0vibMM1/+
         G/kb5h3OTmQigi9or1PHGtgbYSZjlxmgILuJq9TfrNEK1Q5rpHvoFrIL81rgufaLkaSc
         yvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQFH2hgC0TDM1sRzbEadUUZlJqc+Evd7f3Bf5CeXHcs=;
        fh=3u67pbdETZDELoeFL6FBKbDJQC3SFY2XwPi7hNC5Udo=;
        b=qft0j/24F77gGnzNgWEIokcJDl6b5M2in8x89ZTap3K4t3l+y9/YSy4c7gmZwgCH+m
         ac36gbwID/BFCmECusr0QjSX8S9mq+UmUY0p75ELVINDhKjiRh42BlHAVO+GKm2qlPTk
         JYvQm4Ez55XJnxT3PXJaQHeiLzgOgfyq1ZG8A9vc8DAzAKEfduEWCcmm/c6umAUYjF1h
         B19iCxrgq7JLhdR236BHDp3ArmLFSTRF3MZZQDC1xwQh6wZ6RnsNPKfKST24bkZDe/R3
         +1Mrr5VFEOPmvV+4jfuRLaZwJuHQ1QDXGOo6gpwoblNdpUpBDzPn5Y5j8bqBLeCZ+2y8
         2BTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624300; x=1794229100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQFH2hgC0TDM1sRzbEadUUZlJqc+Evd7f3Bf5CeXHcs=;
        b=o2KeHr3jd0uAlP7tCtKprsPT/V+CF7Q9nrspZyMA6zzb2IvLX0F6xhYt+Vtk68udMs
         LstIjCs8KvoACCWucSHTQ+9O1tOYxuk4lYea8pIHIyNAtuDpNxVxHxMpYExg/w9Zpr0G
         ko5W2rA7PBGHM2OdtoOgAdNRqWTBT8M9l8MngYuY86XQT1YPI31BDkFLys9SSO6b1yl2
         kcwFfw9E3ChjCPPoFv75xF9HFJM5KFd/rquEPMmSHZJAlILMv8zDnmYJX6qNRcUIuR3n
         VtMwM9ZS9BPrYJzwIMc3/jfLvdBnKOSohD4I4Pjz1yOX7WdRiRhpEhwUm7++ZPrvJf3X
         iL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624300; x=1794229100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQFH2hgC0TDM1sRzbEadUUZlJqc+Evd7f3Bf5CeXHcs=;
        b=lBJnMvcb/UnyepuJaOjv1MHHj/g2Ex7neVNxV/gH5rRb0sB3E1Oho6o8WajDxem2eR
         YAU30bYI91EmafcPiuqMiiujOLDyUtx6JSpPMzK7E5vkQVwcU0FaWouAi3aZMTYTY+o+
         gZn0vp9rbHQg6HjdCcrKv1Zw289/GKXnBcBmwUlbL5ykhHIW8kFxtpscmHp5v4ylwY/E
         nAhG2zzzvHyA4GCN8T+JfsYM0yvgsmGMSejJWJKhGhz47Xg/HO1nufl3jrpEO3o1emc3
         Tzwl4zy2pz5OkPQgdHnHbjI1yvoT66rh/l8rvD4l/kSUuOMgqPqRFQPINJqtHVj4V8w1
         8RRQ==
X-Gm-Message-State: APuU4Z8D8lUCoAlH0vxT0F2N/ocspMd17JVDJwTP9umj/VcErFFPuYuC
	6XqAfiyRQOFTQSI++tyaFHLuUA3E8fvvujrigTR5phfmdH5Q/OAEmntFKsHoPVS+imiKrS783ut
	FnSffRYC8Mgo8AG6bnxpfYy1VWIA8Yxw=
X-Gm-Gg: AYBFou0/+CynYo8twddr0ycS04yC4AxbLYXfW1+IC+G1pbA3chrcE0h+c5OZnPoqcNL
	vCZL9Vi1V5B70bpaXbX107+2OOTjL2FSUTwoLA3GAAkFTDwdJjGbL3UnGQ61TDob5mBDFjftt0G
	qCisLvN+yl6v8lVvwb7EA5D+OIOXVGQg4MIatBim+kgVAkHGe4ivibX41lzmPXLl7u2ph4VuI4A
	wGkpsGhkV0UHVLvcomLm7Qlrc7id/O6HV9GiT3/rYfNTnHirD2tryqdatckSlP+3MwzvK1qNB4T
	lKjL2xXc5ZbIZdVJFj8gaBak0sJFw4741I17E9G5vS7K7qjbY2ccWfnXFmorACfnoaJGUSvqRMb
	HPIWwJFXH1jQA/YZWS+8fbj1GGCRUEHNAs7aimD5C8cUFwMJW72tEvePtw0yNppr2cosLpgihK5
	QTqyg0Tjzm09qN9LdJ1aD38To8MH0=
X-Received: by 2002:a05:690c:a046:b0:8b0:eab2:f502 with SMTP id
 00721157ae682-8b2b67992e6mr60153087b3.61.1793624299790; Mon, 02 Nov 2026
 04:58:19 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101145841.687905-2-thnkslprpt@gmail.com> <eb689b84-eab8-4289-a48d-64f13853028e@lunn.ch>
In-Reply-To: <eb689b84-eab8-4289-a48d-64f13853028e@lunn.ch>
From: Avi <thnkslprpt@gmail.com>
Date: Mon, 2 Nov 2026 14:57:42 +0200
X-Gm-Features: AclHuK8H_X0i0D1i4ZuBHXpKubFRHuWttNt6nX4o4KI_nkbsioLW4F8WI5Emr7s
Message-ID: <CA+jvY9EydBEkSjveXc1O4o=VjaqSzWFoNCknHr7HgQrH_=EJ+A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: parse the eighth nested VLAN tag
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK no worries Andrew.

The motivation was just a correctness fix to align the parser with the
intention of the original commit, which set VLAN_MAX_DEPTH to 8.

I'll re-submit to net-next when the window reopens.

cheers,
avi

On Sun, Nov 1, 2026 at 9:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Nov 01, 2026 at 04:58:42PM +0200, Avi Weiss wrote:
> > __vlan_get_protocol_offset() starts with VLAN_MAX_DEPTH (8) but
> > pre-decrements parse_depth before checking it. This rejects the eighth
> > VLAN header and returns protocol 0 instead of the encapsulated EtherTyp=
e.
> >
> > When skb->mac_len is ETH_HLEN, the first iteration rereads the outer
> > EtherType, so eight VLAN tags require nine iterations. Check the counte=
r
> > before decrementing it and allow one extra iteration in this case.
> >
> > Fixes: 469aceddfa3e ("vlan: consolidate VLAN parsing code and limit max=
 parsing depth")
>
> Do you have a use case for 8 nested VLANs?
>
> Have you seen people reporting issues? Does this bother anybody?
>
> If not, i suggest you drop the Fixes: tag and post to net-next.
>
>    Andrew
