Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10534477E4
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543256; cv=none; b=mk/ezJ+4I5UuxG51wuPsDqOysW+2zJw0bbFE3j5euKCFCNWOWRg4dMLnzg8so5EcCECR9BXxnDn4FU3udODaFM2LXW7ICbgDa7i8sWEKh25plJ2nGON9C7G+2wSLguB2f8bbgRL6fvdwcMCpozp7yU9Y93o2kmnVyZXdGS+dpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543256; c=relaxed/simple;
	bh=eD+nxRY1CwIOH39+maW8jESaVEmI0XcBor2jO0WtG+M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iK/5VbltUfKUksPrwXssbguir7IeiLU9/hwj1d8Es/A9YnR3ux3TslLSBLYkJ9yL1axp4ESS5/CL+jdwV+NFXc+WIIc/I5BzlPh8I9v8BB6hWnAEECgv9GhioR4TcL+rhMRs2DB0p32cu7LYGOOmZfoVcsPyTcRKNmnhHzIj4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=X7Y3BoXa; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="X7Y3BoXa"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so799169a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1789543238; x=1790148038; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nWJSFNcW4hlXNASCl6/vvabpgGkrwyVE57+WcgHtvAI=;
        b=X7Y3BoXaV0Q+1CBFOsjowevCBIMGXJq9bDE8uh8A8owKTnYEeulyBGszKqed1qlHS9
         MK59LwpuDAZxX7LS6Y1xVPf/2Wo1Zzt6y4XexPmIg076y8oyJQdJtFebp/POIItd0E9r
         2jsf64QegznmGXD7n+/aPakQnOvmyodB5w0B9zPAkPEnG8ebFSPK7/xfDNJwtWZmsF/h
         dysSSP0JDgxgx3h5ZFq/rTyAXwQ0RnRpClisnm10NRHQ+RGVWTgvVeSHPEf7RrlCKbKM
         lBS0OCL/jvX5oercNe9x6uIzoYMvY4aDnnrDb79HeHbxw9Rk4t3kyv7jEZpC0LyUqGQS
         xI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543238; x=1790148038;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWJSFNcW4hlXNASCl6/vvabpgGkrwyVE57+WcgHtvAI=;
        b=wQn5yqWupHMK1HVcIJPEL5QZ9wSaRJa3QUfaqoC+oCJ3fnLtVOuHGiiP2NsFIK7Y4h
         2lAcKrlP8bmTOraGfmB/HlJaxKF2ZtV0pmCZe6CUmc8hBvAiCufc/AhkoyLInLHzG1zn
         +0g8K9anfLpxA94QY789KltfyXvMYwWmsTWtVX5msLY4XHm2aNrIm6xfESNy2dHYz7yi
         3Z8LYWEEs6fBf1piCqrvfd7oBaZ2n/7Il0V+decMXba96UdzxnD+uOG7RR+SE+8PoJrv
         hlhRBeCXml+yJx0xrqWgoktdNihnlveeEF+28M6ZXKG2T8QvtkySOd6hH47XsqWnoGMh
         6ZIg==
X-Forwarded-Encrypted: i=1; AKwUvBygI8rSaJTFtGPvvUaynNgRTQEoWjN+Wl7+yhEDQFbYN9zuUp0/mEkBbUh+K17oVaxp0lWULMw=@vger.kernel.org
X-Gm-Message-State: AFuF++kD3+fNHAYUVucnWF2wnANALVhZSdlUACe82rEYlJU5dNcx23E0
	BLRPMZWIdZ9Eepv2VsfYu95Oj8tQn/Oyv0NFDdl1rcNafPU/E7nWONV7RLHtw8Hf3ok=
X-Gm-Gg: AYBFou1Bn2xTf7+riiBRML5lyhmVW2FV+JMLMk2faCzPBdo4BPnGHYsSvxlGAujRsRZ
	tQYRqCiehLwVPSPke7/lbSxDoNcCzeYT4myX8ptbeVRkSEJSIbrlPxu6i8OAd3aDBJ7zzY5PM2R
	1f+afxfYhOA9ITRajcZ0imfA5kicyu0RV40t9LTUKMH9+N3dBGXxBrhfl1R8nt4IWOkn8vM7PoU
	z2kSXfDgwUrZyqaoV1k4Wb2vNUvhdJC1Pg7nSTtUrh7Noot6NV0jk+ehCezc/6cyZyLwVuYVkZ/
	8Jht46Y9+4i2BXpR/4b5+Euskf3tKuEZr+a49iOP3LoCsw4wDYIFWlnOGRJJemt+QoXAajYUUUG
	I8WlQA1HlBSQ/U8C2W/CgEbb2w2rdx6JTsNu9EsADGKpQKCMIbzamy1yb5Di6q77XoBo1Ttgsce
	JgH6Shsl2hoqcrOL7jGRh9+RX7wKSxe/0BRfr4yKCQJ78MhfUiZb+Tx0u9aNKJoRbLh6Ebzomc2
	D2PCIFdwMUM89LTfr2H1rFMZfRBKGGamA4U5sO7rcxSCLtyBKWQ7smfKcKFFwKYlqie
X-Received: by 2002:a05:6402:428b:b0:6aa:e95:9bee with SMTP id 4fb4d7f45d1cf-6aa2245919bmr897766a12.31.1789543238126;
        Wed, 16 Sep 2026 00:20:38 -0700 (PDT)
Received: from smtpclient.apple (83.10.8.214.ipv4.supernova.orange.pl. [83.10.8.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2406d6sm932760a12.12.2026.09.16.00.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 00:20:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH net] openvswitch: reject a negative transport length in
 the IPv6 L4 checksum update
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <CANn89iJbs9n=kmt1putx=izvr3w17U4g6RDoDzdh4NWz+7uRaw@mail.gmail.com>
Date: Wed, 16 Sep 2026 09:20:24 +0200
Cc: Ilya Maximets <i.maximets@ovn.org>,
 netdev@vger.kernel.org,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6067C60-18DB-4E6C-AA80-B6F68006234E@doyensec.com>
References: <114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyensec.com>
 <de0fd2e5-8509-406c-9f92-cb644c42229d@ovn.org>
 <CANn89iJbs9n=kmt1putx=izvr3w17U4g6RDoDzdh4NWz+7uRaw@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

On Sep 15, 2026, at 23:40, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Tue, Sep 15, 2026 at 2:13=E2=80=AFPM Ilya Maximets =
<i.maximets@ovn.org> wrote:
>>=20
>>=20
>> Hi, Norbert.
>>=20
>> This looks like something that needs to be fixed in the =
ipv6_find_hdr().
>> IMO, this function should not return an offset that doesn't exist in =
the
>> packet, i.e. we should not be able to find what's not in there.
>>=20
>> CC: David and Ido.
>>=20
>> In general, we should be able to trust the skb_transport_offset(),
>> otherwise there could be other issues all over the place, not only in
>> openvswitch.
>=20
> Totally agree.
> We keep receiving defensive code instead of finding and fixing the
> root causes :/
>=20
> Fix ipv6_find_hdr() in net/ipv6/exthdrs_core.c
>=20
> if (skb->len - start < hdrlen)
>    return -EBADMSG;

Thanks Ilya & Eric, and sorry for the defensive fix. I suspected
ipv6_find_hdr() was the real problem, but I could only reproduce it=20
through openvswitch here, so fixing the caller I had evidence for=20
seemed like the smaller change. I'll send a v2 for ipv6_find_hdr()=20
later.

N.=
