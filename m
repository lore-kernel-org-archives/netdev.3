Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793296283;
	b=nzLV64CdjPG1xhPTMk+fyRnBFCaL7nXfdOqTJ747lZNwfS6HwMwwaM9A3QS7LcFkainE
	 HQjaqtzy1l2X0WD/4tVF+CgQmyH774JRzsoRhZ1oDMQZL6zWqvExS/fJkLFjOSAP2hgZi
	 KF0Tgwpzy3QEbSx2uxhIpJO4DMpXBS0KjjfI1i1SO7AJjCJnX3qEDJJlGb9T9NTGbGv7D
	 azRa4119chv5aQZ7QllEKl6nbXii1xir9LRTuzeSxP5VF31E+pAJq4kYqev9cvAMlyBzV
	 bT6qOHDWbt6660Wvx5QlfxNpmRZZg0cB2CnT9WY4PXhGBqzSx4lAyRsoxtJml99MXuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
	b=Nhtn73WDUS0KZFgTi+ahydwN/yfyCCZnSqxbG78VwaC9D9Z1yow1cQ4xSxGCvO3LKMg6
	 CarxquhWiNr1fOsOwK5+KAToWyREjBVVKR7x76nNicKFVTW7Lq0yIxve+SkwkVL+OamP3
	 XAcsm5EiGfCUMA9Ks6OiBamVOyS2eJaSJSdz35YDKxz515Aloy9Ky1HR4aP2ISnDF0Yli
	 MiEr2pd3fix5RktpHkPcruyLblhG9G1Qgapnb9Ex78EjHXqWNAnyspxcoLF90HzUkfXz7
	 ijntlRofow36LTFfETNnQ0sbMqqZyb6AQhCPsdoUFObvLI8YnSIHcDvpEWU1UTqNxdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsUMIjZr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5A606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E5A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsUMIjZr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so21775725e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793296282; cv=none;
        d=google.com; s=arc-20260327;
        b=SluGvdts0FUgyPrp/WEgQGKBsSJ08uJgNXtdi3/5vDrJMshGUS1EcKbfE9SXh8fx5r
         VF/1cmGZFIZJw34IXH1y5QhjH6Rv5pvMptJ5EwMA7E0spngbsFBy4XjEGThbqRJKmOjq
         cwVLFg/hJL0edcWOtCVInmUFr72wbTZYnRW7JWexeJrrlgjGa61qcFFksAeQwnK9sKFA
         Z1tSNbhdFGp2jnZTJI8WZOuKNGQFqG8VWpRSqchmbDpgcAOq89XoOJaRfiPyVYgc4itQ
         z1YEgtOR/w5+XnH+qHqzo6azGjcLYUOGYLw7+VYR0jQRn8Ge0xPaRUsq3W6qgZIkCIQR
         HPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
        fh=Mfa4qLr50hfI3cgoJIU/lX5//1YOun4jmMiUmf0BnsY=;
        b=TNxLBdeCrJHsuI38oXxlkoueR4HnCCgwTVk11S/zjBXtgIXji/n3aUzVnwfgSWDogp
         iOLeKPcMqS9SnTPG6tmeRPUTVGgQLajqqvHQhW+7/SIiSR3X7rojBcbGSGv7xCvHGSNO
         1L9OBscvGRbxj4yq3r6UPipQmS1a8LaySQOrASRFOTTblaLUgUENkHnEv4Q1eHsbGvZS
         CXDJv97Och/lM/sfAWtWC9nCgPs92ifm5YCh+DXJhAFt2k2FiZWO1+zuLwkvCfVAxzZB
         C+Uibq3cyrO71ku4totLuCRw8zolzYbmUt83yuGnr8PGJqApzepPxK/xUGceD0k3JmTL
         Jbtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793296282; x=1793901082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
        b=dsUMIjZrl7C+D72ks+mMd6uVvuKH6tmCREMXGG111TaB7HyXv6AQbiQNUFzIwXinn2
         DGAjeSUGTzceE2KWNIs7Xk2nGxv+fXrGAurSgVGDmYbLbguOJyh8mqVh5Fx3qQ8qxbiv
         4e0tqMrrQFcmAcys65CZKuOSnnwH8V2nAAQ3p27d+dHoFzbSSN2e3M/u7FYQJRqQACK/
         TSxHvs4CtD81JhMWF2+xQJ4oYZ9z1zgx41kQSCh3DYyhhlrCEPtaBEs3dBHrPl2HF/mQ
         kpw4/IbPYVK4bydt0cFFlc81eBiRmR49ngFCQAJHw2gakaZm7YpZ+L6AQCDKKRF0+s6S
         TVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296282; x=1793901082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
        b=1z7p7WJR+S/vZwY3OlkenaugwGj8x0xU1f8VIHRwKpejl+7wFFaVorHue660CJMIg+
         SgGLetqOwC0xQzDr6P1GhNKrZpdbMIZYjIWkMAlkKAYLX/77aA+81evcNQUPl2rxMtsq
         upVeQpfiULc9pkMhPSJ1fQ8JQnlFSR9e8QIRHFB46dT9LA7X6YkUoFnKW9WWNwSSNYdo
         63qJZhKQZHvB8vD2e2NGXNpWfvtYr01S/VWtii0P56vBkm7lBsABn64dxdYd7zRfg7xH
         ZfJVIfvUlZdxwVOnT/+qGVl0uyAyMiWnXFx8Yu3ArUoiB+SLAtdqrrGadQRzxYPE4iit
         ftQA==
X-Forwarded-Encrypted: i=1; AKwUvBzYudGrxvZWu6k5Ryz6NcZ/+NCbeOte/irs4/MVaPv5VkUXWMjgWIxmy/XgyZM6vhOFbvsmmYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZtgWu9lDmpOGhsD6+JI2/jypLAnbAXqvOb2mUqLoQ/LndKjyj
	bzDR84G8Whu6DwFPtIN5nDO0N32Q2iW9q4POVATxXARcNy8x6c7tR/n6frJ0nWALqiDF6moFNn0
	XwHKQ4AvaumSaB6kkPgX/+JfSYvlPaRM=
X-Gm-Gg: AYBFou2RM9P9lPl0HUSGjGg9RxRJG8L362NLAJTvLCV5Ur7e5R6a1OuaoGugnZ1t7gf
	mhGJ1q2GM00OrO9B8+ael1CyScBli0cJL5TP19/pTfV+EO0yxM4pynJmU174L+7GjnfExLYDAA7
	1eXWnafIFS++kG9KM/n4bdBl9R0knBJHVsbk8Aj7yXmO8Dt7UmhrTclw3IweNyqWIyhxnM0X0L0
	GVdWBDPTH4NB6BuBlLum9F3uPyMRKmpFW+zw1mjm1W/GUbzuZe77tM3tExAT0hSGo7WzX1SwI8M
	kOMCBcby9Hq6KMqSVJAJYPJsRqBX2XLXrItEATjv0tpmpcc8Z/xmB0B6qqvdTlEgKU67ifmtm5L
	3JTjKE7V64gXgw9c+XEM7aF7BxKUfP43e1mhMAcno1bVtqQzqAWjtV04DS2LYTRfovnLGRMQB0p
	u13mDb28aHM/XftrUC
X-Received: by 2002:a05:600c:46cd:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a96695ec9cmr127938455e9.15.1793296281562; Thu, 29 Oct 2026
 10:51:21 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
 <willemdebruijn.kernel.26e1d6a9b487@gmail.com>
In-Reply-To: <willemdebruijn.kernel.26e1d6a9b487@gmail.com>
From: Ahmad AG <ahmadag1001@gmail.com>
Date: Thu, 29 Oct 2026 20:51:09 +0300
X-Gm-Features: AclHuK_BDFig-sbWsCR5OlIR4qFenHDi679NHRbcj2yJJ_-aS7hAWsW_5ci89gg
Message-ID: <CAASqGyYuJCObsoPsifvbksJqjtyx4sPZKNzCb4eo8HG_CjW+=A@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: charge fanout groups to the memory cgroup
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. I will scan all allocations in net/packet/ and send a v2
covering them in one patch, using a mail setup that keeps the patch
intact.

On Thu, Oct 29, 2026 at 7:10=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Ahmad AG wrote:
> > fanout_add() allocates a new group with room for max_num_members
> > socket pointers. Since commit 9c661b0b8544 ("net/packet: make
> > packet_fanout.arr size configurable up to 64K") that is up to 64K
> > pointers, 512 KB per group, from a single PACKET_FANOUT setsockopt().
> > The allocation uses GFP_KERNEL, so it is not charged to the caller's
> > memory cgroup.
> >
> > Each packet socket can create its own group, so a process with
> > CAP_NET_RAW in its own user and network namespace holds about 512 KB
> > of kernel memory per open socket that its memory cgroup never sees.
> > In a cgroup with memory.max set to 16M, 256 sockets each creating a
> > group with max_num_members =3D 65536 took 264 MB of system memory while
> > memory.current grew by 380 KB.
> >
> > Allocate the group with GFP_KERNEL_ACCOUNT, as other allocations a
>
> This is not the only such allocation in packet sockets that does not
> account. If addressing that, probably scan all such allocations and
> update them in one go.
>
> > user can make on demand in the networking stack already do. With the
> > change the same test in the 16M cgroup is stopped by the cgroup's OOM
> > killer, and with memory.max at 512M the 256 groups charge 262656 KB
> > for 264640 KB of system memory used.
> >
> > The missing charge was found by code inspection of net/packet/ with
> > the help of an LLM and then triggered with a small test program that
> > creates the sockets and groups and reads memory.current; the numbers
> > above are from that run. Tested in a QEMU/KVM guest on this tree
> > (x86_64_defconfig plus kvm_guest.config, KASAN, MEMCG, PACKET),
> > running the test as uid 1000 in a cgroup v2 memory cgroup.
> > tools/testing/selftests/net/psock_fanout passes before and after.
> >
> > Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size
> > configurable up to 64K")
>
> Your email client corrupted the patch.
>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude Code
> > Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> > ---
> >  net/packet/af_packet.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 823e0911c91..406397acc5c 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct
> > fanout_args *args)
> >   /* legacy PACKET_FANOUT_MAX */
> >   args->max_num_members =3D 256;
> >   err =3D -ENOMEM;
> > - match =3D kvzalloc_flex(*match, arr, args->max_num_members);
> > + match =3D kvzalloc_flex(*match, arr, args->max_num_members,
> > +      GFP_KERNEL_ACCOUNT);
> >   if (!match)
> >   goto out;
> >   write_pnet(&match->net, sock_net(sk));
> >
> > base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> > --
> > 2.43.0
>
>
