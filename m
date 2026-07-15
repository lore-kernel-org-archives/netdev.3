Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2848A2A7
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129450; cv=pass; b=JKhl9QZSMk8Dag0Z1FibVKs/ASXQNk4h0xMh8uNgxTNpcCB1Paps32gVGkCiYs9KkxU4dfiGg1AQeZaiivkacEfZR8S5g6n6/ZDrHAegPga1JMHizmXvsftGWbOv/qlgA1HJfMeXJD7mvKfRVjIC+EHyhu6UnmHEt1yjgOJeVVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129450; c=relaxed/simple;
	bh=a5mdkI2L/Dbv1+W+Y3MrrreSzCjtlRhjsUjoxEMa4d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKK88NCO9fabTiBVyavuA/P80tMSZLy4esVrQPsnwKqIC74bLVuUz28MF8/UVSAv+4I7tKVIfynA8izy623VsXX4gpES3tBvvCnb/JrDCSO42f3OntQR41vtjiyfvonm53cB2HpaqLKPkQ50opDi4h1nPMxepzygbwPrdF6RKl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wwqk7p4s; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wwqk7p4s"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e533aacf2so127606585a.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784129448; cv=none;
        d=google.com; s=arc-20260327;
        b=nV9xrkYeL6FlOzEREuZw/dSR3OCWeSwuUVZhNFEd7CB6Uj6TzogQf9K3AXBaSSwn7k
         HXO5TasJ7S+kQazxYU3eSwBjcCIgWsjzLn8lIfOE4K6WapuswAsqV5/KckirfNSGMisN
         7A+faUOSDxCAVDEdB33Q5ZnabzfBnzh2jLUjeVLxoSXcFKvn+4Npn+r6g4+HSos8tHVH
         dDhCSiHzMywvXZ+DigNkJ5RP3c5xxQjLb8DTHA3TejRIIoGIXbeolTmo/tMwEgDutHAr
         YB64Zq6DiSzNVg3RAZjkXygnDtgVASpghMDN9R0a/qXMQghfEMCyODfVkdKzPaomWhtw
         3x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YVV2ZbfQNvN6Fg6uxe70CkyOoUGkDw0WBSeQAqc4p6s=;
        fh=M+vdSeqmnik+Pbwv3aA2xStlam2/wtnvfiAzxZw31YI=;
        b=Rybrbp8m1FfzZ0Q6eBHPIq22Pn5gIlYHXA/Rhj0ag+KA99Cf3jbB+HkZukXD2ZGefO
         IdwIARzT4AaaLXEwEJXnpwxKzWMpOqCv7ttRDgqFqlShU0sG6nq9u19rPKqfE5DuKNm2
         ZJ9C1nJFjPLozM/V2uRELggcSrxlbzx2ovwyxw3pZaeGh/yrhXyRX33QmTmb0BWrwMAk
         qjiqLrQyyRT3V0ri6i/15vX20+ScunEdS1pEa+xhok3wHqbpz45b1wMWw7n01DFP0Epi
         OCKiVnd2vMpqWZoqHV/nVjjGAwcKc1THn5hV0Y7gsRW/mnyanKiPYZyAmPbAwJ5wqKo4
         Vcwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784129448; x=1784734248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YVV2ZbfQNvN6Fg6uxe70CkyOoUGkDw0WBSeQAqc4p6s=;
        b=Wwqk7p4sYWz/0i+KkwtuzmR5u49LxegFq1+corwSUFTk6KO9ovfkBuV+ftmGO+QD6W
         GtNhj0+xHsOT41Gm84Dg7XSsOm2d8b6WW1jX1R5raIk+oSDfTJFRXn2Fz+TMvjLp3D9W
         RIqaEw6auog+LdjIIQGkjwRCY9JZK3pBydMPilp4tOonZNyaoB5bo027nyk9+pxgJeq8
         hHLm8yN5FvgizY/cTKxlmIxbzAYlVvKFTW20O2ZDIh1SgifIqqhSH7/Wj06m2io363Nl
         JKkXelCsgmfIKzdqbMkRu3oMusxwObiYu/ZUxIVzDYBY9FWFfEVzuzYZDHrE5N9R/VMc
         Lqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129448; x=1784734248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVV2ZbfQNvN6Fg6uxe70CkyOoUGkDw0WBSeQAqc4p6s=;
        b=CJ3iVXxELxgJ+JVBgRFu+Pghm6uWmfTwhHZif/yJD6QQaTc6GvJBWpBS38Hat05Tf0
         kJjaNh/j20qiMuhFPLrU7Ya+1FvpcdZXuiTyHhCDrOqdxEyJpuzKv1TY7rkA+MwXsQg0
         QpOWFVxit6ByHY8r+fhicWlSlzuLhEghC3yw1as9QkUjOsvASWlQ1sirSY3vtHWSnbNE
         PXloMX+yO1U9cb7Sf7bC+eisO5Q67ATzAxmnXX/1QkLXRL4PHdVrvQomjusQrRLBQLeZ
         CMhxIVh3W1uMsve8sSgeF0zj1AngMdFWBdpDikU0PaWCYxX999rYaUA40WQJuGmGqDVJ
         nqcw==
X-Gm-Message-State: AOJu0YyxPXZkupDhIUeuPSltvpHj3NUuKN4t2zgHa4sDs6E+HQc4FIjL
	cky1+KUi6JnFiK+a5W0o+ySdAPXEH05OklZ/3FABJer2f4DvttysdzzykbMoLA6FzGBgXcxEVkX
	URcmT6SM9m0RVZ///UEhcwJjNHEMHX5eHEd1Bogqb
X-Gm-Gg: AfdE7clHp0ujucp1dD7ocnn8J8bd4HTY99R+U1GLTJvPKdbc4ulDvfNh8IABbi0xbb7
	EHFGNewjzEbG1FQwQHLxo7YQJbJSXg0eCr2S2Xu8UlGAbG1Am4pN+dAeP4LSnpuUPtcxFkub1w4
	onM5Bfo3kOuhvuINLwiuFuCNrR4IaR02qT0MrC2z0Lk4r1R3tGzie2WPc5+6YzZwZ1GmLkqAtYu
	KMjrugNmWkMEGoFjQOKIQ69gbVmpzvWVayB2ZtMXCCb4UvW7ktI39Oyr2eMHWDKGPGnh8F3LsDb
	xYck6wWgNjmpynRF2tURmE4SoVtKtZgJwW2QN+Teic5U2IgC5Nz7PIJQA9TFewDMGNdjPijy3ft
	god8xHekYi78vKmVvtJusvw==
X-Received: by 2002:a05:622a:55:b0:51c:17cd:1fe8 with SMTP id
 d75a77b69052e-51cbf0e6241mr163158791cf.33.1784129447058; Wed, 15 Jul 2026
 08:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715145328.54597-1-leon.hwang@linux.dev> <20260715145328.54597-2-leon.hwang@linux.dev>
 <CANn89iLyeAPNV2VHTM3w0-zpzjZNFy3aJDsVUERYyniLN4ub7A@mail.gmail.com> <2dc3d52b-ce4a-411d-9c30-934318ee98b0@linux.dev>
In-Reply-To: <2dc3d52b-ce4a-411d-9c30-934318ee98b0@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Jul 2026 17:30:35 +0200
X-Gm-Features: AUfX_mzy7J4tzxjjlmG1HjDmg9aSDxMDxT9_M1uN2gCzgz8_R9SHMTPEMeYAqpY
Message-ID: <CANn89iLV9pyCKU4vyNMzW5FFv4=Xcq_pgvZaFhzJHAAbCK0h7w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 1/2] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Lance Yang <lance.yang@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:26=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/7/15 23:15, Eric Dumazet wrote:
> > On Wed, Jul 15, 2026 at 4:54=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
>
> [...]
>
> >> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >> index 61045a8886e4..4f1027173e95 100644
> >> --- a/net/ipv4/tcp_input.c
> >> +++ b/net/ipv4/tcp_input.c
> >> @@ -4853,6 +4853,7 @@ void tcp_done_with_error(struct sock *sk, int er=
r)
> >>  /* When we get a reset we do this. */
> >>  void tcp_reset(struct sock *sk, struct sk_buff *skb)
> >>  {
> >> +       const struct net *net =3D sock_net(sk);
> >>         int err;
> >>
> >>         trace_tcp_receive_reset(sk);
> >> @@ -4869,6 +4870,27 @@ void tcp_reset(struct sock *sk, struct sk_buff =
*skb)
> >>                 err =3D ECONNREFUSED;
> >>                 break;
> >>         case TCP_CLOSE_WAIT:
> >> +               /* RFC9293 3.10.7.4. Other States
> >> +                *   Second, check the RST bit:
> >> +                *     CLOSE-WAIT STATE
> >> +                *
> >> +                * If the RST bit is set, then any outstanding RECEIVE=
s and
> >> +                * SEND should receive "reset" responses.  All segment=
 queues
> >> +                * should be flushed.  Users should also receive an un=
solicited
> >> +                * general "connection reset" signal.  Enter the CLOSE=
D state,
> >> +                * delete the TCB, and return.
> >> +                *
> >> +                * If net.ipv4.tcp_purge_receive_queue is enabled,
> >> +                * sk_receive_queue will be flushed too.
> >> +                */
> >> +               if (unlikely(READ_ONCE(net->ipv4.sysctl_tcp_purge_rece=
ive_queue))) {
> >> +                       struct tcp_sock *tp =3D tcp_sk(sk);
> >> +
> >> +                       skb_queue_purge(&sk->sk_receive_queue);
> >> +                       WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
> >> +                       WRITE_ONCE(tp->urg_data, 0);
> >> +                       sk_set_peek_off(sk, -1);
> >> +               }
> >>                 err =3D EPIPE;
> >>                 break;
> >>         case TCP_CLOSE:
> >> --
> >> 2.55.0
> >>
> >
> > My thoughts are:
> >
> > out_of_order_queue has been forgotten. skbs could be there and still
> > 'block devmem'
> >
> > WRITE_ONCE(tp->copied_seq, tp->rcv_nxt) is certainly wrong, because
> > read() will return 0, instead of -1 (errno =3D EPIPE or ECONNRESET)
> > So the application will not know a RST was received :/
> >
> > I think that BSD and linux implementations have historically retained
> > acknowledged,
> > buffered receive data upon RST to allow applications to drain data
> > already ACKed prior to the reset.
> >
> > Adding a narrow sysctl specifically for CLOSE_WAIT creates
> > inconsistent behavior across TCP states.
>
>
> Got it. I won't pursue this sysctl approach in the future. Thanks for
> the review.

My intention was not to kill your proposal, only to start a conversation...
