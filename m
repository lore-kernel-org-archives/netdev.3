Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CD385509
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951369; cv=pass; b=cgzqofjzaSUXOdGYEVOLK6Ac0OJ5kf+cY/M2D6Wrp2sjr+yelc3Cxm8b2oIhe/pQSdvIpQiOGhRDRezl8XF2rj2MvTzesjsUxf7d2kxqLU/x0zOT4lJ+nk/3V2KAHcLaaXtgHg37bsEJ7rp2duSy7yq/0qv1wp66ad53MZb4Uzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951369; c=relaxed/simple;
	bh=Fngor6BsQe0NiKYevp1IuYbQHIiJAepZr1Z4GNaqSzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rm/hypVMxBhud6IVNoWN3shDcDbg+KLCiwlAp1yj1jDcH/WYA5taqR5jDWxYAvF0NTYghfsKpzuztMJ1CTbuCuOy0scZdROjHfWhCaXoRX8Ucqci4i0nOVBxOmflbN0ib/L7qxbOayBj/eUimiUVPeLXCM27cvWp8DHJKcRPToo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a90v5t/C; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a90v5t/C"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ccdf36f63dso7845ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785951367; cv=none;
        d=google.com; s=arc-20260327;
        b=O7om1T+2+Ngba4iepcivJoQKM9jP6w6dnmBq2I1sOoKff8Ul+0pXSzMYj3L5RowMlS
         Pb17utgNkMWlGoznLx1icGNqxl3p9n3z//hS9nChUdS5O1MpPsd4sygaRZByrBpMr+Gl
         vgR/BhzB3gflZMdjHyWow7L4Wz2DcUSXwqdF+tO2pHF/JnjF9DQOfJD0v8kkb3rT7SYe
         MhLJVpjjuGby7c5/omwTuZ2Npb095C8w7h0JF56IJOzsGmeH0vFJuFpcHTnTo+llUqZm
         0pa7gs2c7+gxhQUJD1kw+BMQSpBp1eF0k9LIBt2t5G4VfIre/yl+6+qbTp5wJbLccRRw
         Qzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fngor6BsQe0NiKYevp1IuYbQHIiJAepZr1Z4GNaqSzY=;
        fh=EQ9Vs9Plx9OzxRas3tre2vn1Q7rxr6qcwFkie7I17QY=;
        b=KjYsUEI1vNxcSL3BWlMOXiZF3JJ4M9DFWEROmjPollb73btDVzulDA4+6RGQ82gs0k
         E2TgCgk7U7pNVNFJLsfsMkgKgwBsWzv/h4NFx+T+ALlW442GViLNCGhsdLNC/zt9DeIb
         pTHGCZ91MfVu+W9j+uYg6lvJS98c7978OKp8oNLU21sqo8ueHZsOIVKpI5xDEqfmh85r
         jRt3Wwb5RqCzqrg9uvnm3/JWK3ypUd/oZKN7DFXF49f5YK4yPNp/iR2G1PWQzeWqzYjB
         wWROi19Kkj/0Zl63Cdj5QUVfeBwEv/G+D1q5hw9HLC2WZVB7SgYw0toio7obkxYNzIlW
         o+Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785951367; x=1786556167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fngor6BsQe0NiKYevp1IuYbQHIiJAepZr1Z4GNaqSzY=;
        b=a90v5t/CUbofxsaersMhuFJ7GzuVOkI84S2kVpyN6PuTmLEnIV8usfMWksdA8X/tUD
         6gLd/veV+1MqGoRZG+UJ8g0vyAjeRr8IC1te/wSPetV+7NdxfQL8nIa9yUQubH+wewXb
         +vZ4XXS27AcKB+ZXzNjxeZ5AV6rRby7VhZZYl72NuktOtGbOjR0N88fPwqT7TNpaiDwS
         Q7L1IU6XrQVkftKZ/zdQaQH3rGpVEkapTWGwMDowWR2ANcVb3lkkKVIakUjNgesvAvcT
         d8s5p1fTAdGQwiHPayvPn1g0nVNVCfM0SxfEaMAHWkkIxY3k/4/ofMZh1bYZa5E9dtP7
         XZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951367; x=1786556167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fngor6BsQe0NiKYevp1IuYbQHIiJAepZr1Z4GNaqSzY=;
        b=YU1AkmqXz5GjUdl9Ovw+/QynwsrsH2MmXdzUFXIpRqDeNeWUjXMOn63zaG6jfjzoTK
         aUdbWePXSSK9qyWV24LexskNqVN1NIKVBeQIONI3rAzby4XZhMqV0hnS48o9JTgPFAuM
         EDtTs8YgSYiA+mI4Tr9iCCjTNrvVffdfpGdDMhx/Ek7sv9nZa91Ih/aUEhQ9B0AezmHR
         x2ZkwNfXFQPXqsAle7REyAnMGx+7o+Wda/VkRTHr8x0ztL6pjk3UnOtPzRieKYLbz80d
         /hJ9Y6mC82JRA16CNr5wiCM4ut+dBqe8BXwzq1KkxKxWkpDVQ86LVgywMMY/o3ri0JPs
         mHMw==
X-Gm-Message-State: AOJu0Yx62rl+W2tVXaLHaIuJRsJ/PKBKI82qd7SuXc8FQotOwsqU5H8S
	AkThvDcUtscxF5u7HPaPahnGuQOcREIsbvRkmHFvAl4YR24wxlxWNBRNuuSzHyTIpXkSScovMTu
	B4w17KYaJ+wAAroX0dm0kCpR4PkhKG0k/LI1hhMvg
X-Gm-Gg: AR+sD11aViw5rzyoCY91Trk1I5fNl0VvNQuLV4iB7HMURqARyVYysp18xJCFyt/KhSi
	OdzSFFWj6QJ4D6cOX9nGZpK7IOhpu6WlcWV2P6odSb2VvqY4XDjLJkmGSXKrw0du9MYcI64/A5M
	8It2Q9Gra68/VPhg2PUn3gxjk8uvO9IIWR3zjV+7lP2uDXHolMHRvW/M86u4PLRct4oxqRKQ8pS
	NFMkfc7EyJiR4R2yGaSJUp//ZN7+aKKs8QlqwBBjPHxyBrBlNS8mHW1HmyXuHzT/aZ3iFSoYpFb
	T1pEKNzRRQDG47a5JUBJIbnNVswnhEK7lM4FBSKgQ2d7XG89iM+H70wlovAwWFK45lUszb92B3c
	=
X-Received: by 2002:a17:903:298b:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2d0f2da3bbcmr486415ad.7.1785951366548; Wed, 05 Aug 2026
 10:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801131220.1367229-1-almasrymina@google.com>
 <20260801131220.1367229-2-almasrymina@google.com> <CABdmKX3Qyeho7Ru8HOzWyCrKXp=kf2H1pOUTXVR3tRWpYhKpTw@mail.gmail.com>
In-Reply-To: <CABdmKX3Qyeho7Ru8HOzWyCrKXp=kf2H1pOUTXVR3tRWpYhKpTw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Aug 2026 10:35:53 -0700
X-Gm-Features: AUfX_myIiu3RXZne4yTwiucvdtGUQZsIdfBTkTamUKmtVvsV7Of0e13iL3V01xg
Message-ID: <CAHS8izP_mxA=QxP-17cg09uF1Gc1if=jog1pM_imMKQ7Obj3qg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: drv-net: ncdevmem: gracefully
 retry bind()
To: "T.J. Mercier" <tjmercier@google.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:21=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
> > In testing environments, binding to the port can transiently fail
> > following a driver reset caused by the preceding queue configuration.
> > The failing bind() is typically caused by DHCP/IPv6 DAD needing some
> > time to resolve and assign the IP address back to the interface after
> > the reset.
>
> With EADDRNOTAVAIL? Maybe loop only for that errno?
>

I did not check the actual error code returned. I could.

But is it worth maintaining an exact list of error codes to retry on
for this test code? It will be annoying for the next guy to discover
another error code that legitimately requires waiting, and then we'd
have to maintain a list of error codes to retry on. It would be worth
going through the trouble for actual kernel code, but it feels like
more trouble than it's worth for a test?

--=20
Thanks,
Mina
