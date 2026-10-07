Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DB1A2C04
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416549; cv=pass; b=RWTjcYaNAMAGM1w6Z28rq0xlt5CtXjtAs8tHb0ptm1je8OmkSvLrwOEyCysMdmlt6XX4336BC8vygQjLK0U4sDnAalspWA3JP9lBC+pOU81EOM8Km8nKF21hzIl1fQfXtgShv1SmkEE1Obym87Ew2AtWPJK0UASNNn2KSaOEihU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416549; c=relaxed/simple;
	bh=ro4+/i2TM4zywI6a2AaHcGTylLGRLEcMZCi8IHwFh6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV+DtXeLYMi4ekbwfu5C1hznN942jm4WTqItRcZI/9ZuNQ/4GV8gem1n0VQwP/QacOu9V/ANZnXXS9zYFl6cPE1YlQ5EA3y2Z99ZtQdRmHK7JOaU3g4sNXnNf8jjZsuuFbwaNkZjm2XlJIK9sragN39Ba5X64hFG93yJWRZuv9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYMB2EIw; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYMB2EIw"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4911df1e196so2297046fac.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 16:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791416545; cv=none;
        d=google.com; s=arc-20260327;
        b=ZzcdGkCIMCjZKxVJqk2/SUmRDLkid42+9SmqyfOZSI0onI9NJd/joYpAqaxuTV/a8G
         +5MlBbICsOLzXBuk/qXxGk+BMRFuX7cTG8c+o6X2V9cZADJfsmEUSmrv8IiTn5aZfQ0U
         iairXiwOG4fijast+p74C/+2HdMLQ1o7KWlv0145NQpa0pT+ZBwxc0vCKAJC35v/ZB6g
         rHR35V1oiXsadpKW9vCNmZXUscaZ6lnpE07e3NE7XCnWoZ2VLsul1np32Eooerqzp6/i
         UjoSaG/tHjasf+nPU8vlPshgJ2OaCfUEAWI3p3oVyvCMSakNgNlMyEZDny3m/Z+caUF9
         3UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yGYj5b6U1++JQdGjDtNa0FrBS6zy0pR6vz75C3C1YPI=;
        fh=Kyl3xZKQ6iVk/v2nqDFGutS2dXlRwNsmpswFop/Do/k=;
        b=rdGD9V6yclju5Ly+40emYpPHq65MDgDS7IU5zDFPHR6Dk4A3wyqD+AxKK2LLx8KwL1
         5cUWj3uIzmNHrsUlD4ZnezA3R+H638csSMO1rpb2YDl0bO3ouK3qdzkkQN2T80zZLphO
         dzAWc+gahlpvUjeaW0Wq5eBXo0bHOvXBbTq75u9U3UaMk1df0JHfa+oEW+17ZcU+97yt
         PzW7T/KuBHGvrtj6yB4c6dI9zLbe+5YtSS6loJKCZkxg83nLROggOXegZRBgy8reYbbB
         8xbRXSbsKZoCK8KIh8IY5/+O/nol3Xrm+iMjjuxE9UXgFCc0p5wzuO8BlYo9X5Gaawio
         CaRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791416545; x=1792021345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yGYj5b6U1++JQdGjDtNa0FrBS6zy0pR6vz75C3C1YPI=;
        b=UYMB2EIw5Dj4ij9cLgi6uuIFR79RPMatOGiYjb35a5BXqRilX0QTUL5LEvd3Tdyv3g
         WYk9mOO+uB4dDZoW1FjJpq8DW4sNg3xv048OzE7M8pBj3obopps3dOYG+gBOhQQSUqqt
         zh3Rjhl0+jXgYQwCurqlBfn2Z5z+Q402Y60PaFElDs+Hb4tJGorFJydbYaOFqptNEpeq
         cI3CM2hWV8UUafLPiTEL6XN8vd4Us04pVvsSvlDfuCMqCj2xEfzU/fgEK+fqSCa1evX+
         1vB0EMI2vMP50kQITwhi+UFSsO2cF3a0D7S5GbePLpwa1VZ7ouNLjH6WS8fsaKqW+veO
         JAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791416545; x=1792021345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yGYj5b6U1++JQdGjDtNa0FrBS6zy0pR6vz75C3C1YPI=;
        b=s5zIQB3ouvQzCa0tQgciPaLfKEut/yIxgC997tVTIDXgwTtc1kCdN2S/6QBzZwv0q5
         bM7SyA7ft1sCVsAcgfjcaO/1TlXTVVJqXmqdl3epez3o6iFSh5sGIdXQuiWsKGuBcUaT
         wznpBAMY/wIlOXNWgfNfLyxd4VJPcosM3w2XVNhP0U3AM4tP/8FMo5HRnqawXZ0UelfT
         AE9PBsza/2lzUMRjCL6kFDOO9O1IR0QUXjA9Fs+3tzpCJj3ZNuOBSDtbvNPaUf0r+V6T
         7YuLUC6KdIwTFwuKTf8QLwy+gKhF5pLb3GDDQa9jMUD4rxbidVWvjBZlpqXZXY119ggD
         Oh5Q==
X-Forwarded-Encrypted: i=1; AKwUvBybG/j7Rp46Zn4HqpMf3oAukBXmlL5l0bZpWS0Xz+0+lb+WXr7/SAXv4xigBBRpqBqMVDXjdkc=@vger.kernel.org
X-Gm-Message-State: AFuF++kIB4vJgDbcait3Ye74/3R7jXOV1Xp6GjEyqwSBWI/l8IM2ekb2
	aIDhFgTudnxl/y4nt/cnw5VjxCthKCJlDm7cuf613HCcvp/BGYuwFRXTkvyCOue7ohbUos28qCx
	owrw7vNQmIsB8QM883y5h5rY7Na0Ns+I=
X-Gm-Gg: AYBFou2chL+HHktP1QyLL4RPfNFMpdh2PMfX2K19LT0zoSm/UzTXaO+sP0GOoTA7K1P
	oe2nGTxQ4yNFoOOgHv+cU+Z5X4s3VjKMHZlBDRRAHsCHM/50c8pb58fQ65cGp/aicYE5WsQoTWk
	k/9cN1fTGuwrosp1rFfUaHlNUS+KLws+zlydktHdFOn0ucN1FA7EdvCEX0MzDLDws886wdrummJ
	EYft89x/KMXOl+mDFIdjeVJrcoz8rXqyFDZmCcIU5tclTvfzpgo6j8UCAI3NqMlmN+cI74p6Brf
	PQ9F0Ux4KsqTHCTbEFgFUhtbYsuvX5Zlh0Up5pEaGIucUQEE0KLp5hE=
X-Received: by 2002:a05:6808:3091:b0:4d5:27da:a496 with SMTP id
 5614622812f47-4fc46578fc2mr4036254b6e.48.1791416545324; Wed, 07 Oct 2026
 16:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-10-kuniyu@google.com>
 <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com> <CAAVpQUApCBTdHQDjf0NRXhE55fcg0wtmjGz9yEuQhsbQ8xm3rw@mail.gmail.com>
In-Reply-To: <CAAVpQUApCBTdHQDjf0NRXhE55fcg0wtmjGz9yEuQhsbQ8xm3rw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 16:42:14 -0700
X-Gm-Features: AclHuK-Nt_1xRb-O29Tb35isp6a4Vi2zZyko6wRWS0DCOsb6YDS_tJOHheNbCYM
Message-ID: <CAMB2axMECgYbMO172_3enQh+Sg75yRZSBE3ihvOKDqw6qkSxjw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Kuniyuki Iwashima <kuniyu@google.com>
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

On Wed, Oct 7, 2026 at 4:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Oct 7, 2026 at 4:06=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> > > adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> > >
> > > Let's add a new kfunc to set sk->sk_rcvlowat.
> > >
> > > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> > >
> > > For enqueue_rcvq(), wakeup is set to false because:
> > >
> > >   * tcp_data_ready() is always called after the hooks in
> > >     tcp_queue_rcv() and tcp_ofo_queue().
> > >
> > >   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
> > >     not yet accept()ed, and when called for TFO SYN+ACK, the socket
> > >     is woken up by sk->sk_state_change() anyway.
> > >
> > > For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> > > is not called in that path.
> > >
> > > An alternative would be to support bpf_setsockopt() for these
> > > hooks.
> > >
> > > However, that approach involves excessive conditionals and an
> > > unnecessary memcpy(), costs we do not want to pay for every skb
> > > in the TCP fast path.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > > Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>
> > > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > ---
> > >  net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > > index 8182037c4269..2ba73dd6c52c 100644
> > > --- a/net/ipv4/bpf_tcp_ops.c
> > > +++ b/net/ipv4/bpf_tcp_ops.c
> > > @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tc=
p_sock *tp, u32 enable, u32 disab
> > >         return 0;
> > >  }
> > >
> > > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlow=
at,
> > > +                                        const struct bpf_prog_aux *a=
ux)
> > > +{
> >
> > Is there a reason this takes struct sock * instead of struct tcp_sock
> > *, like bpf_tcp_ops_set_flags() in patch 2?
>
> It also works, but bpf prog needs to cast sk to tcp_sock.
>
> This patch is straightforward and rather patch 2 has a
> reason to enforce bpf tcp_sk helper use in cgroup hooks.

Make sense. Thanks.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
