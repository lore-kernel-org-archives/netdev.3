Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9F3E0C57
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957427; cv=pass; b=YhdW5QEAkUFwDP7f6IVDF/glRh8TQGbZhTSnZF8cJbrgNFuTg20aDKtGRiGSkZ4eMTRf/Q06nCQKtkdt2b+OZzRlCv9E1JZIAsgUASyOCVDLQqf7C36qhbrXJqdvxkpkMx7Or6HtBy0duJfzmBqMwHy1la7KxOWzh8EgrEtedkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957427; c=relaxed/simple;
	bh=vAGc6aYy53n8Ge9kSp0L4eR4cVBIMAXOr4qdllGJ4L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Okr8YxESGKPCT4uQEtXGOahWXg6OXA0c/Ve+YsL9brtVH3S6zBwyubWN+WsBq7TRvEickQoHXeMWjmy3h14XOcs2MYnFVJpEyRKgVfjjc7zvdZpSuOp1U/hIsmC89kHgTTu2pP810gJ7gfWn/0tl5bPKgTjjrM7c4drcvjEdUlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqiCxx3D; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqiCxx3D"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so16800211fa.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 12:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957422; cv=none;
        d=google.com; s=arc-20260327;
        b=dCoSzQKGRkr/k2+FKesuVOIAElu2acXL9anq7L4Ul9eQAcRSlDhoT0vPtYo1X+WTl0
         sjemamcKfEhoVwfft1LQEaiLyiUFNDqO52vg7VmW2tEQKCntXfgPIXR9AVR6JQRXegJs
         ZbvwKMXEf0AKNr0KCcFQhSP7ZN56tfCzC/m4v4tmYI4/XN2gSJSbY5xUiwkfcKz8lqhk
         CC/E9IJWF8jMhxmKYJz7TCkYFo9h8aIZqyqgkef1ytpFW7Tyr0ajxMegVVFPreS2LP/2
         1059AG7su9x5lvWRBlEVPX9nuuLg6G/IWXnQ0MqGEHs/e52UmZ4hgZI/ZGfpndWg7MUL
         FZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        fh=ZjdpCDaoQ5u27Uu2U0G7+AnxvS2ECqyC4NZIBtzV1cs=;
        b=kV/3I+rVI+8wpxyaYeJSCx9jO1Xw/bo6/wNDg9v2maDBTuyg+zKmC588Zkz+yBwr7k
         jpXuZ90s3FA3EalXfNnx+r3gP0fg/yDrwzC5xipYWPVrXadLOETFWo8aIy5DtmdinGUo
         yV9A3HVFcl4NaJKKQvfxY0AZQUhHd4hBw+kO3OyEz8Hiz6ZQphnVcWIOzVzV8HMn7cJ7
         HdQKBRX/hhXiAG/bKPF8s4ZUMCPF/OLwF0MHoWr0kM6EsdM1nM+8jqofdXFyKQU/sCQI
         7Gzs10eY0WTVR7NQ1d8ytVJVAaROKrFfvUhzg9cEUNnffTSHjDgRFjNkUhfySPFrXZ5x
         XVOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957422; x=1786562222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        b=DqiCxx3DiTaycwe7AdZtoPwcpH2Pjb6vGcDysi2Z5gmyJ0HAE4MzwObahewCbTGuYB
         pxFM08wLxt4+RQvjmLRVSnFuMNXwUlQos4d9dajUup9wcZ83pLGq6aJrlO7Ew2ZwCptd
         QcyWR+s3xKKV+FpJoH7z5ZEb4tjMjX8VP1Cccanh98THWVPxgoj+rDH8Mtr40AGSmtg7
         TM29Kxv+VWkfaR7MBWzZDS+NQIwwrfMGLvoYf8IVUPQlUeP5EjzQUtr7lCuL9oNmQfS0
         AgC/fwweAN0pbPzO0VtDZN8K8zDHkWMNxf9RqR0Cu5HAZXApTA4kIJWT7NTHXXRxs5N8
         sDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957422; x=1786562222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        b=nmKKb6cbVP8QH+uoWfjcZ+XpxhH6I8uqHtJmEGFihrSWGzLYKjrCK9GvbV096Trh/U
         CoSjOjKg37RdzV9krLIZEmBD/byxmDKOCxAAdqRsJV7UcSQqScbLiM811Y8EcCnhjiul
         0tt754eaHQQDYClMm+RxrSlco56nwyJHGPRKp2X3swqxrgYC8SBEEz2Vj2k7M98ocYJC
         0ZKFkm6pVxsN0kDo3/hwxCTjqaAebgfYRLFHaPh9f31utsJJ9qV7kCsZWKKR6MM6gsJ7
         TzI2seFxi3uaTMriKbGOFgtCiyLX1SSZWczJrO2ETkdLuFyx6cqiR7cdLsNGWDkOTUFP
         tu/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoghPBvXqAMDxr8GdToJrpL6LwFSkGSSyXFxeNz9H4IUE1b05sZ98wJDdvYc2kCl1Uy0ELz8Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJpefBlnRUq4QA3V4hUtF4NMD4PsjxTvmHY/LpHHu+6wpPk7I
	msaKCXRcf9+HoeYrb/BbOetKl5mS7Ggwg4WzJIGRjOineCrHSBdq6D37o+GtkVQVwMsN3u0pFLb
	0oFHfTsWSiRpelL83gnyDKQJ7yLzxnVG9PyU1vtsI
X-Gm-Gg: AR+sD136Hxk8CUZx+LAwQK+emUXuOjhh8PGa9G3TFIKqMbFGU4t4rju7oo0Arl7Hxnn
	y1C/BBUpElZO/DWA9wkYMv8feAtf3+o9hTuKvWsuOV/AS/tTpAJWXfOOOvceSebz8Ezi3gmcI8T
	F+qvtTpZitkdqhA+PUwiewpwyzBe/GOK66HpwFtoAkBSAlzhNHCCfjqc8Oxx50Ho9jky5pBhO2i
	hhAHJTWv8kv8llbCBnUOOENuYFj/4G9/850BwygKiTcYR0FdQNq6PlozUA/FM59qvJpXDjooG4T
	ensp1wsS82TfvShnH74hXJpt1T3WTWArQ61czNm2zS4FUu61sSfmJVRk1RROLDgCoOYJZFtiH9H
	QaS5z1BXOBoSPxlKSUnDaizl+629WSmNrQy7LF/dD5e1M9JB4LzB7sDMI31/lXRoHZKvjW7S4wi
	yR2EYjjkwNeghRfxLg6XL9tbVOPX8=
X-Received: by 2002:a05:651c:221e:b0:39f:bc94:eba6 with SMTP id
 38308e7fff4ca-39fbc94ec7cmr11124031fa.14.1785957421590; Wed, 05 Aug 2026
 12:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804214406.750710-1-tkjos@google.com> <20260805011006.stable-0007@kernel.org>
In-Reply-To: <20260805011006.stable-0007@kernel.org>
From: Todd Kjos <tkjos@google.com>
Date: Wed, 5 Aug 2026 12:16:48 -0700
X-Gm-Features: AUfX_mw1nkkw5kkLj8bI2FW2wAiOLfVkEzSktWrAkzdsdv_wgjivU38R77dZlH8
Message-ID: <CAHRSSEz69qwV6KzFuhU_cMq3QDBAotSvGrkW-rpHWWubpqqY2A@mail.gmail.com>
Subject: Re: [PATCH 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, kernel-team@android.com, 
	Lee Jones <lee@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com, 
	Xiangyu Chen <xiangyu.chen@windriver.com>, He Zhe <zhe.he@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:13=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Tue, Aug 04, 2026 at 09:44:05PM +0000, Todd Kjos wrote:
> > @@ -192,7 +200,7 @@ static void sco_conn_del(struct hci_conn *hcon, int=
 err)
> >
> >       /* Kill socket */
> >       sco_conn_lock(conn);
> > -     sk =3D conn->sk;
> > +     sk =3D sco_sock_hold(conn);
> >       sco_conn_unlock(conn);
> >
> >       if (sk) {
>
> I think that this hunk leaks a struct sock reference on 5.10.

Yes, you are right.

>
> Unlike upstream and the 5.15/6.1 backports, where the sock_hold(sk) sits
> just before sco_conn_unlock() and the upstream hunk deletes it, 5.10 keep=
s
> its sock_hold(sk) inside the condition:
>
>         sco_conn_lock(conn);
>         sk =3D conn->sk;
>         sco_conn_unlock(conn);
>
>         if (sk) {
>                 sock_hold(sk);

This reference is not needed in the new version, since in we take the
reference above.

>                 bh_lock_sock(sk);
>                 sco_sock_clear_timer(sk);
>                 sco_chan_del(sk, err);
>                 bh_unlock_sock(sk);
>                 sock_put(sk);
>         }
>
> So after this patch the function takes two references (one in
> sco_sock_hold(), one from the surviving sock_hold(sk)) and drops only one=
.
> That is a permanent struct sock leak on every SCO teardown, reachable by
> any user with repeated connect/disconnect.
>
> While respinning, please also drop the Change-Id: trailers from both
> patches.

Will do. Sorry about that.

>
> --
> Thanks,
> Sasha
