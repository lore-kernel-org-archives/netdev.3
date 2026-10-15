Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3B48C405
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066400; cv=pass; b=ayMIRmmZjrBHiqqqdEByf+kmDQUyT0XjuKj8zLvkFv/wFpEenjs2j//HyerR8UEhbm2pf+VJzMiBUomJhHEcTMcHN/fd9Frckt1KAflbYz/k9X8e6qToigyF98rYe++2GH24mMx7atHVk3pXkhFfz0hxmh5uMGjWqKUKcIZNG0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066400; c=relaxed/simple;
	bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFz2VIZqyReJqr36irVKGaDMDXSWtWL3V9ufCnaTGkpIcqPSh+QXDUsxVb2/ZzuZLblSay1U2CrQvUsAC2b0hvmQZYewiIzTyH/Ptts9GKlNlzPhZw/xbQlA8XPSwFS12Tiz2vG2I+cVLmxxaP5y4zN8p6t6V6VQ7kajshujwQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFUv0rFw; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFUv0rFw"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso2304963e87.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792066397; cv=none;
        d=google.com; s=arc-20260327;
        b=LPczGlNZ5j3d8YeaspXxaUlU0P1W5b5ImwegnqnwGBgAaro84ZJHZ5ZCpcV6ZPHtDW
         90qjnwXz2/KVZR3M/oINte2x+h30k3VD4iXSCsI6Biyw/46x6ssjIns01IcdXj8+q8Im
         bj2AUuaiGsc6As/KgK6DX61K9jH3RPjQPHhWRVcgocGcLmddowfHYjrLeZf4hPWZdJ8f
         V2KGQ88kiQ7tVO0rHrD7jnfxfPNbSMQIW88rHvETVvxaxrmOmH7O+6+sVn1isQK1VHZv
         Y6Z/hNgixGXsu4ipx78tNG/IIuHR9SLZUjBFaFA+8PCTNQa4E9Wh6ws2hInxc4FiUOVK
         guzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
        fh=eu3fNylAgjgul50jhoh2fhz7ga7Bz+ie34HO8yf3GnA=;
        b=gzC42sJyAECBmlNFqN/H+CDbD0oUGQ33qm38Kjz4XZtOLpEO97wNWdCglBqJ/Levap
         1/EZONQArI+VYsMQfGVInkk8DiDas+JBnVHM94j3MTcjpr9yEIFklShBgVXr40whJUB2
         SX2CVAY70j9gWNdOvRwVGf9ZhBviMkYBTrnyJC5GndI59nTKDRoG1ZuPnzuMmMTd8nUM
         j701NbVBrMh85NORFK2FPia6EA484a+IoYlkl5pPKAGKT3FCSu+V5OpOqAsNKxbAfZKi
         tfWS5kXunsXPmRoMKi/mnI3PTQcEl7gJLdnqM0oSJm1/qCxbJBqBzXs6D7sI1REkPJ6I
         s0gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792066397; x=1792671197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
        b=MFUv0rFwkY46TMBt7X8wNlMgYfH2YjM20arVDogzgWTSRu/Y6LyM+DTrbXsuUU4IIM
         KMefd9j1ptRsfqlo0pBgpWwYnuwS7fgCGXKEckghBS+1MbY5V0k43XFCPQfNBRIo7rqn
         7ogA4wk4yI3JLiTiW/wgvj+yXuLzs7al5YO7pu1bm4MGoB+M3Ehh8qJsKATWAJkHuduv
         PK7Sw7a+CUJ3u0rQgaaMXwZoRqciyvgFJdV9v6dr96LtRVBOr1510olmTRyInjU3Gj5i
         ycB+cHUT0QzW4clXhHZ1Tr619ClxvRi78UB0NIs+BHrDyy9A1FwE0I9Iucm1YJ3qhBiM
         Q9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066397; x=1792671197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
        b=TOmFw5MIPYOWQPUpghuXAn+W5W22Cb1CJ8PORFubGbG/RnAP6mRC28RTymOOxS2rz2
         LfNZbeD9mZyUltxa4k1EgCQk7CKbIf3S2coVWsfw5K0v+bj8LHW7pRoKG82FxMg7LGto
         8BtrOs7/2mmXYvOIjdcA/2MmBM5rVURUc+R/QzwyY3w6LOr+X3XOZ5mDd5KNbGI0gNDp
         1sMcO8+8ChgL0yU6L3jdcSEZbLg5hEODZCtPxwt9WVqEemQTZn75RnY+yHCBt9HDc20/
         K3cS28EXKODkG/aOj+RD+RKSv0jbdqmy4av/tFYkp93jyxJuIHOMv5V4PDHMuSI1eFMN
         QB+A==
X-Forwarded-Encrypted: i=1; AKwUvBxInRGmajBrDAQlicnz8S8Ke3yUqmHIFCnFRRlu5O8aITg2XQgtSXtpbJH8YzLQYTAE0sstcMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPorVooxreoW9oH9RCVqO770KYik0lpFH8Sz31pjE1NZVZ2kG6
	q5LWAdoaKitgOKy7XdgZx1joig+fnYTvdvOeLTrj1B957wBcoooWajqnanKjc51cbyb7LFbfO5s
	mOZ+eoAWLxQ+crz0hApACuX0iY7YVUYqU3QLag2bFNw==
X-Gm-Gg: AYBFou3GjmoPtr6UQ74+yg+kzRMuqlsMFt5azGE4skIGIVJ31v0gtjXfu0zgeBBvLNN
	8jGXBkyN3fHEuawV4Jk43npKFyR/vQ5m+1Ck8uaokBPuhs+H94MgCB0YN2ctmgu+Hq6RcZUiouJ
	umxdboHn3YniN+zLMOur97ZaWLsEsSUeAr/KkPoPH5Kyb1vg44eWjuh/Hwe2A4nJC29fAkkvUA2
	irgetroWfC06c+ZKVS20d3PJUOwISIs6mu74yoz01z5W90kMSGzwz8OzsYlYbt1JrFuhjIYpeVT
	mHkn3ELwUmqTR4DsJxrOfb7BF1ZMrQ2h0w6BxEWCzzagiNG0lGx/XGF0MfO7xzt1CVcLwMqcXRj
	Bp2FGztrSEtzaPTZOgG8VQe04eRVzKxctBOfMm26k0leKcl0Ymp9IwwPceh5c3FSWlyJXEw==
X-Received: by 2002:a05:6512:b1c:b0:5b8:e9cf:daa6 with SMTP id
 2adb3069b0e04-5bcdd4f080cmr6853474e87.10.1792066396625; Thu, 15 Oct 2026
 05:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
 <20261013103906.2660384-3-wferguson@cloudflare.com> <877bjk893u.fsf@cloudflare.com>
In-Reply-To: <877bjk893u.fsf@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Oct 2026 20:12:39 +0800
X-Gm-Features: AclHuK9xypnzrrqwCcprd2CwQO7kzSIQ141D-bgf0CuqS7x-S8jo7RzifyoP-go
Message-ID: <CAL+tcoBjfDEVGvvSXZHkiMjq5jat+5OJE-7uJr3MvtFyzn+KUg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/4] tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to
 assign a TSval identifier
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem Ferguson <wferguson@cloudflare.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:51=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Oct 13, 2026 at 10:39 AM GMT, Willem Ferguson wrote:
> > Let a sock_ops program pick the identifier that the previous patch
> > encodes in the low bits of TSval, for passively opened connections.
> >
> > The width is set per network namespace by the new tcp_ts_id_bits sysctl
> > (0 to 8, default 0). A listener opts in by setting
> > BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG, typically from BPF_SOCK_OPS_TCP_LISTEN_=
CB.
> > tcp_conn_request() then runs BPF_SOCK_OPS_TCP_TS_ID_CB once the request
> > socket exists and before the SYN-ACK is built, so the SYN-ACK already
> > carries the identifier. The program sees the request socket, the SYN
> > (bpf_load_hdr_opt() works on it) and the available width in args[1]. A
> > reply that fits in that width is stored with the width in the request
> > socket and is inherited by the child, including Fast Open children; any
> > other reply leaves the connection unencoded.
> >
> > The callback is not run for SYN cookies, which have nowhere to keep the
> > identifier, or when the peer did not negotiate timestamps. It is skippe=
d
> > for connections using microsecond timestamps and while the sysctl is 0.
> > The width is captured per connection, so changing the sysctl does not
> > affect existing connections.
> >
> > New /proc/net/netstat counters report how often an identifier was
> > assigned, declined by the program or skipped. TCPTSIdEchoMismatch count=
s
> > third ACKs whose TSecr no longer carries the identifier, which shows th=
e
> > echo was rewritten in flight.
> >
> > BPF_SOCK_OPS_ALL_CB_FLAGS grows from 0x7f to 0xff. The tcpbpf selftest
> > used 0x80 as an example of an unsupported flag, so move it to 0x100.
> >
> > Encoding makes the timestamp clock appear 2^bits times faster to the
> > peer. That shrinks the real-time span of the peer's PAWS window, and
> > peers that keep ts_recent for the RFC 7323 24 days stall connections
> > idle for longer than 24.8/2^bits days. ip-sysctl.rst documents both,
> > along with the lack of TCP_REPAIR support.
> >
> > Signed-off-by: Willem Ferguson <wferguson@cloudflare.com>
> > ---
>
> I think SOCK_OPS are considered legacy.
> We probably want bpf_tcp_ops struct_ops.
> See [1] for an example.
>
> [1] https://lore.kernel.org/all/20261006192601.1875100-11-kuniyu@google.c=
om/
>

Exactly!

Thanks,
Jason
