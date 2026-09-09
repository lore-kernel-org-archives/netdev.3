Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D687345CDD
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929099; cv=pass; b=TO4i/nFD7indGWsrkI5zp6XOTpoVByITe6C/e2XPerDH0SXjs8N4aT0ObDNbLGYv34M4r0thBucyEaocNr3UYl3oOOO/E1QaqZneluQgCpseDH8VdvLkK7zqmf/wB3r1vzRWuBhqfv0rTRtTd+wSQ/EMCz3aa4Q5cOxmVym4k4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929099; c=relaxed/simple;
	bh=3svEKaHfGaq/kOZo3u0CMncNwF10yJJZpEhbUWM0dTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGATMbmw294T1rQPGjDnDLLdEGrTRbo3wjbjRK6/od99cJNC1a3CGN/ToutElit77Q8P5O1SPaC+kqCpee570z1sLCTLQkdvNp4v86cNY9AVGOTg0fx0Lmb1Ti+ouFSaJqkhWWOmdnzgtd8Zh5ZN3eMeqFteu+Gt5SYwL+4as3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnXh/1PT; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnXh/1PT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb750so591421a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788929097; cv=none;
        d=google.com; s=arc-20260327;
        b=FOf6SUTTKQbSjXs7YpxAU5Ss+kpr8kvpDwQGAHlpRziPeEB5fNVB+cZkEsvaiAt7r8
         k0IEOiL54d0nwp24fbG7wiMwDfkCFItrdHI61ypWu0u1P4XjEuFpfXISWjU0W1NOwDzu
         1oPsDhDXmL8n8taLkb2lEwLkpA/EjkfI1Kt1lfYITc9HcYh9g+ECtGG7lDLhehFfzb94
         DN2cfTm+8YSPikdxU00qNJoqTTDxQey0MVN4gap5vSGU5VcIXhU2/zoPbq0WZsC2h7B0
         v5RiWSs9PJRl0FnDOHLuNgzhgA9c2AcEAJT6byDGu73yhlo5Pb3EEhYws/PWjIuWvKdN
         1Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ju7SuTTIBf8rTvIMLLG6zQ41U8RGiQrFPUiOKv5pUY0=;
        fh=fMPa3dZn5ecJtcl4K00b25mN7OIrLgItlUQ0TRDVLCc=;
        b=T/PvqRPSrpNXIX1Fax7CesNp9tqM9kq+BMqs7Sc3BcY2lylYXgMWLiTkNZ3xrM/s3P
         EU3Yvz6JtBAT/uUFnoRMB+qZIejzP+SMuYPDq1kjry2roXRkngU16Ou2KkVgekcMCUwm
         a4Mn5dSTIMvB6760YoqxyVbEzLwiwiwG4EN8OpKfUCvWXfNe14nmkgXWkBRkmu0FtsIj
         XPrHwrLuHp4Mzg5K1GN0hLhtRFa3HkBhaCwpUwfymLgf7EiATPJc8TeSRtceZ7yMKK2K
         heQsmv1YttEl7ULtrgmE3t4DPAmhnX6dP6Dsj6H+DWE+6IwO1vbgGuoND+qD9PvAMvD/
         Butg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788929097; x=1789533897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ju7SuTTIBf8rTvIMLLG6zQ41U8RGiQrFPUiOKv5pUY0=;
        b=TnXh/1PTsvaAzpVyvTPjyFDdxrCdwJ2dcIZb/eZQ5yIrOfSbftmEYraXCrVRQcE/Cd
         NbPKvfzR6rk/g3WwamCied5wHGcjs+bFxnxyJOA6rLgres3is6w73B0L/xHGPCv/2OOf
         yHIclZLJmyEcE+k06PNx+F0JWSgftkcvLahnsuLYjg4FIbAAwE94JZKMI5Nj9aYZ8O8D
         JAqyM/xeQxFWZetfE7XfsvDi3/9vPk3fu2HltrWgGZFtxRvUfd/WhNAWn7jTy/f/gF3O
         yPOGYAemOcS27Z+vr4VfqongWs60diKJNpnLSyVFwdlMmOWUpjMjuufP6JcjX2pQ1rWw
         2ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929097; x=1789533897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ju7SuTTIBf8rTvIMLLG6zQ41U8RGiQrFPUiOKv5pUY0=;
        b=kLpGduRoeq6d1jujbNMW6EA+TVEmZ8SU+QZlZM5CQo7fxc7oCKLFx7YWarxj8EMr88
         L13XnfVxOals3NyruIADmcqqzdE+MtDyKQGKRzh9Ff1CZDF42DjZUkaq4R7Qphqz0Qt3
         JehYpbW3IwQvXT8U2wOMqG3KBLD4mUhkXZxuVfACZr3C6vBo6FZzRg0UktFzvEpMDz1I
         6DW1NAJh2rNdUO2G/BGbUUTBYRHcfOqmgOY9kXxfEH9aWRUn4d+nhrdnX2y9M0udOlFs
         07wdr9eWF+DhQ6Er43wx4JUtPsDWxTudvRVR32MuBZby/rTT2jQbgLfT4eDEEfECWezm
         uv+w==
X-Forwarded-Encrypted: i=1; AKwUvBwQtL3ezmYVv3Z5nsQkqyISDJ7S5L8cMy/qv6xYgGuHav8vJ3XqfdAqd6yBHB2Q5YMKFX2a5tw=@vger.kernel.org
X-Gm-Message-State: AFuF++lzzISxVTukuCmXSpsxro87HaDZ+CBvJksMKPQTvTLAwko3wQGJ
	7L4Ks+Vvi/j0mbyQQrqronEjlW3XZ2o3Mac9IoSPR95GSha2TVlRAAX8K+B9BTXkC2yW9EUEzJF
	+G9f8OZP72R31GncmGs2Zsi/2f/10bpqYb2LQkCKU
X-Gm-Gg: AYBFou1VKSuGoxsa3Ze7IF6VxE3vvC8XDTqtZQDilnFLjkM8t2EWrl9gP5J/tD1aMCl
	HWQ4eOpwZ1vZoulzqmDq6Z2t8BKcIzdHtl+nrTdU3yHSXPZeGjwusJqJ7ysXxgs4k2f2AQFoaOp
	NZQqOm1aJ+Cl6cwDB0FCfftjzF2m5xMA6LAoEp7FSrUW/t9u+UorCj2ObQ7au461iw+lfm/Ayk6
	leGjA9tz6UM80G/jNHIHJD22vhYZ25+mEupWd+9OMICgthwS8MZb81eMBf2g0VsBxMuFwvNVBid
	fQh6/OkEbW4l3sdB5aXilB0HCCxx0K4mR3l2oeUvzikMRwVzoBe2mqBDuHc0XZ1nBP2OU8EXEt0
	RGmY0DQnk3g7gI5SfqmnpjmsIA+byi3ufujHmbEu2KlfagunaZJjVPdfylQkCZdMiMao=
X-Received: by 2002:a17:90b:5485:b0:396:b918:c2a with SMTP id
 98e67ed59e1d1-39bac34a3cemr5391070a91.12.1788929096668; Tue, 08 Sep 2026
 21:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906030429.2085375-1-xmei5@asu.edu> <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
In-Reply-To: <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 21:44:45 -0700
X-Gm-Features: AcwNN1WU3N1Z_n3o-LBfKOjs8mI-QxbQ-KQSqXbqITays-pmKu02oWr-sEtiZYY
Message-ID: <CAAVpQUDuHr4WxEOUwikYqdG9FncoY09LOMGDPciHex2bQ51ePQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/tcp-ao: don't dereference NULL current_key/rnext_key
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, co+2c72469dbbec34af@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 9:31=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Xiang,
>
> Thanks for your report and the proposed fix.
> I remember I wanted to write tests for re-connect() on the same
> socket, but never found time for this, as it's not really used in BGP,
> as far as I'm aware.
>
> On Sun, 6 Sept 2026 at 04:04, Xiang Mei <xmei5@asu.edu> wrote:
> >
> > TCP_AO_DEL_KEY with del_async=3D1 is accepted in TCP_LISTEN and NULLs
> > current_key and rnext_key; tcp_ao_connect_init() clears them on a
> > reconnect.  Five readers dereference them without a check.
> >
> > tcp_ao_time_wait() leaves tp->ao_info pointing at the tcp_ao_info it
> > hands the TIME_WAIT socket, and tcp_done() skips inet_csk_destroy_sock(=
)
> > on the tcp_fin() FIN_WAIT2 path, so the full socket stays in TCP_CLOSE
> > with its fd open, sharing that object.  An unprivileged
> > connect(AF_UNSPEC) + listen() then clears rnext_key while the TIME_WAIT
> > socket reads it from softirq, and tcp_v4_timewait_ack() dereferences it=
.
> > The segment need not be authenticated: tcp_v4_rcv()'s do_time_wait: pat=
h
> > skips tcp_inbound_hash().
> >
> > Check both fields and drop the segment when the key is gone; without on=
e
> > no valid signature can be produced.  In tcp_inbound_ao_hash() this must
> > be a drop rather than a fallthrough to the keyid lookup, which would le=
t
> > the peer pick the verification key that rnext_key pins.
> >
> > This removes the dereferences only; the two sockets still share one
> > mutable tcp_ao_info, leaving snd_sne, lisn and sk_omem_alloc racy.  The
> > first Fixes: is where the unchecked read came from, not the sharing.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >     0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087=
]
> >   RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:23=
33)
> >   Call Trace:
> >    <IRQ>
> >    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
> >    ip_local_deliver (net/ipv4/ip_input.c:262)
> >    ip_rcv (net/ipv4/ip_input.c:612)
> >    __netif_receive_skb_one_core (net/core/dev.c:6264)
> >    process_backlog (net/core/dev.c:6728)
> >    net_rx_action (net/core/dev.c:8007)
> >    handle_softirqs (kernel/softirq.c:645)
> >    </IRQ>
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
> > Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> > Cc: stable@vger.kernel.org
> > Reported-by: co+2c72469dbbec34af@bugs.sh
> > Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA5=
7%40bugs.sh/
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: drop the incomplete v1 fix; adding missing checks to avoid null-der=
ef
> >
> >  net/ipv4/tcp_ao.c   | 6 ++++++
> >  net/ipv4/tcp_ipv4.c | 4 ++++
> >  net/ipv6/tcp_ipv6.c | 2 ++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index bb7bbc20ba3f..9c2e5c8c8fe3 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, str=
uct sk_buff *skb,
> >                         return -ENOENT;
> >                 *traffic_key =3D snd_other_key(*key);
> >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > +               if (!rnext_key)
> > +                       return -ENOENT;
>
> I think this is quite a big hammer to fix the re-connect() issue.
> In theory, we could even restrict connect()/listen() after TCP_CLOSE,

As there were too many rehash issues, we disallowed it.

8cc3aef0cb19 tcp: Do not allow buggy transitions between ehash and lhash2.


> but I think I have an idea how to address it "properly".
>
> I have a draft of a patch; I'll test it today and send it for review.
>
> >                 *keyid =3D rnext_key->rcvid;
> >                 *sne =3D tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne)=
,
> >                                           snd_basis, seq);
> > @@ -1026,6 +1028,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct=
 sk_buff *skb,
> >                  * matching the rcvid in the mkt.
> >                  */
> >                 key =3D READ_ONCE(info->rnext_key);
> > +               if (!key)
> > +                       goto key_not_found;
> >                 if (key->rcvid !=3D aoh->keyid) {
> >                         key =3D tcp_ao_established_key(sk, info, -1, ao=
h->keyid);
> >                         if (!key)
> > @@ -1045,6 +1049,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct=
 sk_buff *skb,
> >                 if (err)
> >                         return err;
> >                 current_key =3D READ_ONCE(info->current_key);
> > +               if (!current_key)
> > +                       return SKB_DROP_REASON_TCP_AOFAILURE;
> >                 /* Key rotation: the peer asks us to use new key (RNext=
) */
> >                 if (unlikely(aoh->rnext_keyid !=3D current_key->sndid))=
 {
> >                         trace_tcp_ao_rnext_request(sk, skb, current_key=
->sndid,
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 9f053eb8b46e..93e073065b1b 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1052,6 +1052,10 @@ static void tcp_v4_timewait_ack(struct sock *sk,=
 struct sk_buff *skb,
> >                 key.traffic_key =3D snd_other_key(key.ao_key);
> >                 key.sne =3D READ_ONCE(ao_info->snd_sne);
> >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > +               if (!rnext_key) {
> > +                       inet_twsk_put(tw);
> > +                       return;
> > +               }
> >                 key.rcv_next =3D rnext_key->rcvid;
> >                 key.type =3D TCP_KEY_AO;
> >  #else
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index df9c29eb5c1f..0fb75d139430 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1182,6 +1182,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, =
struct sk_buff *skb,
> >                 key.traffic_key =3D snd_other_key(key.ao_key);
> >                 /* rcv_next switches to our rcv_next */
> >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > +               if (!rnext_key)
> > +                       goto out;
> >                 key.rcv_next =3D rnext_key->rcvid;
> >                 key.sne =3D READ_ONCE(ao_info->snd_sne);
> >                 key.type =3D TCP_KEY_AO;
> > --
> > 2.43.0
> >
>
> Thanks again,
>              Dmitry
