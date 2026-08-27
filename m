Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152C38B12A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828196; cv=pass; b=dubr3DdUT+KR9TL1q4lD6ZphrWZWuhU22Yk7p8lLXV1h7t6kZGMrm86LNPR4dLuae2ewjiJk4HkjJXMtaG3MgxyKAH8htVXxuTDHFQTxKkJjF4utDxbrJ1xqxAPY0B05P90kG7vrwjZZO6XRq9YdOSy/xOZZdPdZYp6DSbLYddU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828196; c=relaxed/simple;
	bh=dXDPfK0dhT02d1TeV6qse5w+WInzpV0flL6ANp2uo78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtjUc4dOdrSWrWh/AzaZwMQkDh4fzgLszhFpe/cs2yQpzMvUCZrDhmXvxcvXztHMme7obV122oepTD6tbDyJwGPjGSMcoxnAvvDrAnjSyd0BJFOCsNeTjZMlpsdB42Ui+UUuLs4IZ6z75M3Y8qhqRLW9rKJN4/YPehMn9b5WwOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OL7GCYIz; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OL7GCYIz"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836cb2fa1bcso33055967b3.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787828194; cv=none;
        d=google.com; s=arc-20260327;
        b=QtsJ6TbV28BJsTS/Y/EkOZo/Y9HAUJOot4LGew9dWa/K8Noq55idbQptPLs5lmuhnK
         +570gmN7H8U7ZufvT0zPsbQDemyi9bF4P/yJnV/mJfSf58EBHkBuaIcUt4s031pNGJuV
         mDbvxqXaIAwxW6QaRUvShxsdUmruf1bqCFUWNNiZOvnC1iFFTDwdAwdAI8xkfhQ6N6jd
         tx6Rd01JzupC9UeBVf8DOw2pS4HttqRCKvpIRymmttbGl8IS77m26C1wuTd6I407F6AN
         xHvpLWhg2WyfKKnlmm38GO3//j6faQ7kKwLPtNJyTb+aIVIvUyKjI0/Oa40m8nLNHDNO
         u+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GDuiIzVATVb1cumV32b7bxAagNo8z0DEhbz/qi0Mnf0=;
        fh=yYMvh/gr46yg61dPHAxL7ZQehre0EqQ1+L4hLaFzVzo=;
        b=Uxhk635I1FW4Z4sonyT5m/8SqMCPe/mpDMWNOXbRP5FOuNfG4jo9E5iWKgTU1ogixS
         phtAATuhFQkeUR2CSpmO3M0BHvM9kH6l/dT6IA29JsGDu8n3wua4opBcSLpX57Sv5RuJ
         QM5O+OlaZ0VHqjw69//P4S8q9tGa5z4+uRT8/GMQZ7d2G3aN2UPyHBGxWtj4Io3DtmGf
         OlHucBaEOKXsf9ukikKzeROg1eSqfDePkrHmnYvdhXdvSShVlATpnxyY3tLp2DS0XUQx
         rpIO4uFChqVDEAlEtgBMDnEkfkS9IYot/Vd8Xg7cW4GhdSknkYTezX/Vfj1C0N4BcFHq
         +cCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787828194; x=1788432994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GDuiIzVATVb1cumV32b7bxAagNo8z0DEhbz/qi0Mnf0=;
        b=OL7GCYIz8PcQV6y+N0u1R1H87N5gf1RgTOo3EHVq+WnlfMvrX3BuKQXQtxvXTlAy0v
         Z5uvzBMJ/+4Gxirq27qQIYxLcNDYkc1mVvUlMi71CRtAc1MOd3FqluojcMYNwUbYJNdX
         ia4ck9/4hWOus7dmqVVgC4JEdksxh9ikoDJjmPTkqW4L4K4JXkeHx+drF/82O9wJDH4M
         tmtSbCppzixoCaKu+jXab3Ier080GIwPNZJPNOtqdC/UPOqb2L8CafKgnXzXDfC1Vn83
         ADy1gY4+jfhAanup6g2fG8XU/Gfs50R759JTUtlDN7kyS2N2ubTkDwRaR8A4yDajNvzC
         eZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828194; x=1788432994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDuiIzVATVb1cumV32b7bxAagNo8z0DEhbz/qi0Mnf0=;
        b=WF/0c98i9ZxOco4dygTtu1J/uxhOti1ilPgazin3gftjynOdVmijOAFYV3tduX/LcD
         I1swkgZ8fnVlzemdNXqJO7TzgeY3k0fKNDwrRrswikPHDIGMze0nXqYh1mcslx3NT9z8
         ztezhC2eGZo6qm9dqvstFiDjjlCpBxI1phWgT/tWDVeMycUUBOswZr4jzC3iBxQCduWV
         Uwl49v01kOQ7o3zi8zfHgsCjQTuEOZWdU5K40/AIlXoXIIKc1lX12k3m5uTUcThSNnuY
         2s3cmev1vlhGvTu8MObYQWKSKaOZtht9/NBxZv2mW6HT7yp9a3IOpYKZVnln7O7UYvTs
         6Ogw==
X-Forwarded-Encrypted: i=1; AHgh+RpvOFg1HYmqPYsKYnySa62FeHfYhctVJd0VBAN3xINl2nqgp43xxbBleJ6F8BJCGNEgKyS28eg=@vger.kernel.org
X-Gm-Message-State: AFuF++lih3IO2XE4BAjEjzSMRh949aASMPwF7kM+5zrE7YOovPcYe1yW
	4aZvE+yfvV8aBI2MLySAEpDERHl8V5p2YQqSrTyWrnsDqzdXkvlzrfFDFb+Sqgl3X3uYe+i7Zkw
	teRuVJ0qLyLHfF+Alm+eAFFRnXf5tKba8kINWyi0/
X-Gm-Gg: AR+sD13YLUSCDrgCeNaWJm4t2q0nruWbZfvF1MLXiUAjCbIVyjIQ4q+O3ubS5bEkUlA
	cd7n+2P8SjYVqPplDQhVAl6ylXoVPZm7WCTjWEejDdjt6BoU22FwRa9168BW5tOvG6GdKhW4WSd
	1Zq9wmVL8aisQTxHPahXEXHQlhhz+WsMkT/ilvDt05gJ5I6bDvIG+qlSFKj0RZP0JCWXoNw9VH1
	eJ7YRKHnKgNOinjRSLl6k2UusBYMIk5lfmfPohL3NIFcFNgigWVGkTuzZqOLFasSzd0lXw8qIZo
	1bPNICgyyBkK83F647pN0PinG6OvGUKla1zdslrWSW1rtRV3AMnt7FZ6RdvVw+xSW4pjRyri7+g
	piPGtk0n/8gaapX7jqxYLcc8LyW/rb+Lv2YF+xUoQ/ncE2/JXYBp9oydqgwGmG+rGnmtrNg==
X-Received: by 2002:a05:690c:a4d2:b0:81e:abe2:9a3b with SMTP id
 00721157ae682-857445e6731mr48323077b3.10.1787828193276; Thu, 27 Aug 2026
 03:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825023614.1228551-1-edumazet@google.com> <9eeac695-ff8b-4473-b0ab-b3ad873b6915@redhat.com>
 <CANn89iLb1qJ9asoisJzPmXQ-ZD7Xp6H5kfjOdMtjxYBuL_2sKA@mail.gmail.com> <4619ea36-bd62-4d31-b3be-c5948748046a@redhat.com>
In-Reply-To: <4619ea36-bd62-4d31-b3be-c5948748046a@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 12:56:21 +0200
X-Gm-Features: AcwNN1XCqi5IuPetZCzsptwMPSmJc1RpswhDLcqh7daPkbN8Nzwq1ZbTI-cKKIw
Message-ID: <CANn89i+Ob-n5mKN0bP6yETZ1tNUJa1XQ_+ER_dC=3HY+cSPf-A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/27/26 11:33 AM, Eric Dumazet wrote:
> > On Thu, Aug 27, 2026 at 11:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>
> >> On 8/25/26 4:36 AM, Eric Dumazet wrote:
> >>> tcp_send_active_reset() can be called from contexts where gfp_any()
> >>> (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
> >>> mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
> >>> __GFP_FS and __GFP_DIRECT_RECLAIM.
> >>>
> >>> Allocating with GFP_KERNEL while holding the socket lock (sk_lock) cr=
eates
> >>> a lockdep dependency:
> >>>   sk_lock -> fs_reclaim
> >>>
> >>> This causes false-positive lockdep circular locking warnings with sto=
rage
> >>> subsystems (such as nvme-tcp) that acquire socket locks in block I/O =
paths
> >>> and invoke tcp_disconnect() or close sockets upon teardown:
> >>>   set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu
> >>>
> >>> Active resets are small RST packet headers that should never
> >>> enter direct reclaim or block while holding socket locks.
> >>>
> >>> Hardcode GFP_ATOMIC inside tcp_send_active_reset() and remove its
> >>> priority argument since all callers now use GFP_ATOMIC.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> Sashiko has a bit to say:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825023614.122=
8551-1-edumazet%40google.com
> >>
> >> A couple of issues (the same lockdep chain still be present for
> >> regular transmissions, and SOCK_MEMALLOC being ignored) looks
> >> real to me. WDYT?
> >
> > Thanks for the pointer; my local Sashiko couldn't spot this.
> >
> > Regarding SOCK_MEMALLOC, that's a good point.
> > Using bare GFP_ATOMICdrops __GFP_MEMALLOC and misses __GFP_NOWARN.
> > We should use:
> >     sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN)
> >
> > I will squash this into V2.
>
> Thanks!
> > All the remarks against nvme will be taken care of once this patch is m=
erged.
> So the addressed lockdep splat is against nvme, right? Given the
> reclassification and memalloc_noio_save() dance performed by nvme
> noted by sashiko, I'm wondering if something alike the following
> (completely untested!) could be a viable alternative?

I considered that, but having tcp_send_active_reset() use
sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN) internally is  cleaner
and safer:

 Active resets are small control packets sent during
 abort/teardown. There is no reason to ever enter direct reclaim or
 __GFP_FS while holding socket locks, just as we never do for FINs,
 ACKs, or window probes in tcp_output.c
 Note that the current thread is likely to free memory sooner;
it's better not to block it because of GFP_KERNEL.

tcp_disconnect() was not the only caller passing GFP_KERNEL; __tcp_close()
 (when tossing unread data) and mptcp_do_fastclose() also passed
 sk->sk_allocation (GFP_KERNEL for normal sockets).

7 out of the 10 call sites of tcp_send_active_reset() were already passing
 GFP_ATOMIC (tcp_abort, timers, linger2, OOM, mptcp reset reason). Removing
 the priority argument simplifies the API and guarantees that all callers
 use a safe, non-reclaiming mask.

Other in-kernel users (or future storage drivers) that do not explicitly se=
t
 sk->sk_allocation to GFP_ATOMIC would still suffer from the same issue if
 we keep GFP_KERNEL under socket locks.
