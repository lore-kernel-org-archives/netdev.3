Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC083793A9
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415333; cv=pass; b=M9WG6oG5ATBH6UZKggRvJmdrCtC+M8i98Op3mUhwTbKBXWe/GZcMwEYoHBqhquF0Y4aWMUPGfRtgx99fI5/4LlJRdWmyVuVpsmo4DqyUB46vhdoKbX4WT544NYDO6tqj9AHrpwHk04PJEZMl8HQKqj+c9LnuwprhdtAZL3hSHn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415333; c=relaxed/simple;
	bh=HiqG8AVCq1Z3K5J4ljs1aq2aJn6IW98a+B5RG4+qpRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqv0jv7L5309A3Yio/APIpDNVfSisdqYHa/uFxM7uUcShvTmh9Y72LGl0kiw6LtHCZkI9tjGQSGCZ0zkLXaSHOv4XO2Kwicnit03iXDKP3oZmw0l3StsoH/PlPc+sTW11w+gIToT5L3Ai2CUAc6Nt/f1RjNNnT2cJmePHla2ScQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPvt1N5i; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPvt1N5i"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so12663391eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 16:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791415331; cv=none;
        d=google.com; s=arc-20260327;
        b=KAfqNKfzxtzZoji+zr6qH17rtFcTIqJ7H/ByayeKs6t8LzJ1cnxFX9YAH0UTNQIAVY
         EFzaLOxwOu6OYuIkuOJaqx+bZJReRrXoTP81hhI+zcQyUShjhVhGpCjpJW1t6bSTZQgq
         dkn7RsGuGI6oAshareUoEjbia27GZtMBmYIqGIT9dVEMDs7PLsOHE2XPI4wpGKhZY2oX
         n8djdMZzcKArnwgSR6/LaooWucK/DzHRod+rAd+a5Xck1Sk+0SE8EA+Eck3eiKiguT7X
         /3MJi0GoVgyLEKGe4AK6NFofmN+XYuCtlOF0Nr+MI9MZ9vHFBd5xC0SHsmyXAprSUUJQ
         R3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prskCRIuYR+XX8F5YqRlwpvMCkHISXsdKM8mbnGxz2U=;
        fh=ajvN7kIo/0F2eOcU+ZOK+83ejWp0QUwQYUS7eR27iEU=;
        b=M7wfPkqZQ/swC/wObZKnbYOvVNP1kznFMNEKsPhgoZlIg7uSMbWjpP35nuYOApMQRn
         OSCBmx1qr8cfC8cfICgylPtQgS2OZpKBzJVl6nfkJloFM+K5h0upEdJU6IqDSuQr5r9F
         IqpN/a0ro0j5M4b76m70YoUwKBn323Y9fiSmyLQiAB2HlSOe9RQ7dmGZJI+jKOHaYzDm
         TtPJxn9y08kl1Wv53shOZ0Ts6hT32CJ11YNRnT68mcaSU62Edwqi6DM+wyd4l8eQPQ6c
         +gpmlldfmO7jHD4rxsBwwlkkswvjjL5R8VG3lLUUZkyKOuAnqPPNp+gsJBNT4yWnP1xO
         BeFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791415331; x=1792020131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prskCRIuYR+XX8F5YqRlwpvMCkHISXsdKM8mbnGxz2U=;
        b=WPvt1N5iKX6ZjGfV5bB4O9c9Gtf9I+slPSTYptr3KXquMUI50tlXWTlL7oSf9xi+iy
         yGTstoN3YmWKG8YEGR7DHwHkG/J1CIsy1e9Hm9RUnopVu+eV001pbgAhNJTG1HSGtu9+
         gjc0kSbYkgbDYt1vqoEPYc3OPw3R09UyRyhh17IyU3RaRLhpT8avZup49uUPPx5QFBgw
         qYZ93IpOv816JWiQRMrtDa6dRrGzZNhqzQ+6M+Q9iztvJ9samfuOtFrHUKi0EITmPXsh
         NWQcgBXTk/cPYh8avEELQEeHTY2jUNuOuaMx0sILDtWmtXSs9DryHzOtM83CznxhW7X1
         1dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791415331; x=1792020131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prskCRIuYR+XX8F5YqRlwpvMCkHISXsdKM8mbnGxz2U=;
        b=Peh4A+Ohp9qZeySQZgIh8qT4vGjJ1vTudSVSXTaFhUPMba34xTMxSwf33ohdgu269Q
         yOUBi/jCNnVufzTDiKDgM3aS6ZSOipyECjuCl6IhgVtrQ3BQQT3oMSfOGxaN6/iRl5Rh
         LpzH+uVIJIt7ivAzA1g1rzgOFPUfS0PYQx7uZ4fBqhVHln1bdnfYS/mwBnNGOnbkT9lv
         NG71ypQ/cKHMl42UqX64Ow3gmLjFjmAbqhkVYUAGd3UEouGUKoKQhzDvKHCKKtk+jgVD
         n9Y0noxx1JYgCXdknCsuAX+4gaZSZBl/dbV57f87x5V3vLpKPY8JuKbSYqH2wv4KGH5+
         Im/Q==
X-Forwarded-Encrypted: i=1; AKwUvByal9j0R0P8EzhEDWZD2iTg6BmUbwL/yk3yCCb3u5DeLg1F6he1TXZ+j3M7Uz5lw1nMkZUroc0=@vger.kernel.org
X-Gm-Message-State: AFuF++mEbRM6LLdXueI1wNb0OSWBV/oFn0k1NdEudJtHnTPhGPG7j99R
	0dGpUgkYl919BzDWPWbgezukPLhCqbukr9qznE1cbAEDJq3cA+pixc5ABUl3gBhu8E+JR+hOFEh
	TjhtbsSj0Sd9ajv1JKQbdCai08iLVLAOJUHL9tnDY
X-Gm-Gg: AYBFou0UB/n61ICStD7Z7OrpiBER7Xqjb3qbjXoQuYq+pShiSnPdTT5Ut4/78q9Dke+
	B98yECNm2Q4wXUGeGLaBb/lzbt9dKUU9cMHaS9sGeuiD3hy836b/PBfgJISu+ZdOEu6G2tX7+9n
	wjDZlDv6m/HqTuSGwqhIPVFI/6ND9J5051ua7gTXN/fd5s5NitQ9sv+cD6933GnQToUUHBe0IyN
	+TUzoZvUuJmzruzC3V2COraxtAybSct5TH9Cna24RVGfzJWgINJnA/f3W5ekE67UGDLyvHFTYiu
	j6jghtcYRBuVskxoIQqMdjftNLq3odAxeoJSRIPdPkBm9lBGw1jZYVb0boc2msWENBDDaEYtLK0
	olxpBudApVHK2WSHRGp8RbDeW2o8A1fcmWDQQJzLIF0Exy2dTViRBNnUGo+VTvr2It1vs6RdUsT
	aAztlXBXCqxT7u9KF13LRF2zRZokyaHP1nQlo=
X-Received: by 2002:a05:7300:f78e:b0:351:679e:ba2a with SMTP id
 5a478bee46e88-351679ebac1mr3190407eec.23.1791415330456; Wed, 07 Oct 2026
 16:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-10-kuniyu@google.com>
 <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com>
In-Reply-To: <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 16:21:58 -0700
X-Gm-Features: AclHuK82upe5Al7QcZBohwpUxhHT6jCeGNSyHxlFXHnLXVMJkE7hHINjz_ruQp4
Message-ID: <CAAVpQUApCBTdHQDjf0NRXhE55fcg0wtmjGz9yEuQhsbQ8xm3rw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:06=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> > adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> >
> > Let's add a new kfunc to set sk->sk_rcvlowat.
> >
> > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> >
> > For enqueue_rcvq(), wakeup is set to false because:
> >
> >   * tcp_data_ready() is always called after the hooks in
> >     tcp_queue_rcv() and tcp_ofo_queue().
> >
> >   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
> >     not yet accept()ed, and when called for TFO SYN+ACK, the socket
> >     is woken up by sk->sk_state_change() anyway.
> >
> > For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> > is not called in that path.
> >
> > An alternative would be to support bpf_setsockopt() for these
> > hooks.
> >
> > However, that approach involves excessive conditionals and an
> > unnecessary memcpy(), costs we do not want to pay for every skb
> > in the TCP fast path.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index 8182037c4269..2ba73dd6c52c 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_=
sock *tp, u32 enable, u32 disab
> >         return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat=
,
> > +                                        const struct bpf_prog_aux *aux=
)
> > +{
>
> Is there a reason this takes struct sock * instead of struct tcp_sock
> *, like bpf_tcp_ops_set_flags() in patch 2?

It also works, but bpf prog needs to cast sk to tcp_sock.

This patch is straightforward and rather patch 2 has a
reason to enforce bpf tcp_sk helper use in cgroup hooks.
