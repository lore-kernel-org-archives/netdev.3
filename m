Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925D23C4FF
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392712; cv=pass; b=lIPoVrwaR3f/ZoONBgOjzrH4yPNOxbIwKTw/8F2Uo19H/9YniBxdjyf7wY6dV5oWcepyfzIiYl9FgB1NbIY8BK4WAYyVa+jqhsirYMBfJBS9vZcI/CdYEAFegYcXXJ9fRYEoGVHhliLQNFdUbHZu7uWzcwqJMqXeSsYlV9K1Bto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392712; c=relaxed/simple;
	bh=ZR6CRlm+kjUynyI/TJRUEnDkvMkUBO9Ysvtfa/jLYNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyEFMA0Z18QSDOqWgjAm0XKjCUWplj3HIgd8qrgE8XVpjtxNm7VQ2TStY6g47pS3VMUf+5l+RcPB3fn9t4CKQesJuG1MBsi9oZet0ruQhLveasLzZz8ja3rOjsB8UAk1CKo1/XUGD5F5pzGq9aF4AS2jGh9M6cdAIVKd2E8cd5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1RVJlSe; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1RVJlSe"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1384ebe7a10so1864953c88.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781392711; cv=none;
        d=google.com; s=arc-20240605;
        b=Olb1O8kA1W9MW17+fg5toN88E056dsVk4+rT1k5lq4bvdqdOjleT+7HzRlvhZjwDMR
         JwFz6K/rt0kcq1vH/j/Nmn9h2c2/q89xuar7DqaalTgz+5Q08lOT5BBN3+kCm2Dwmgcr
         aoLm1TykTMSYIZb4vFrL8r1tDT2cLgyX/JyXdh2wTEM0Dwdwd1FQGF3ZAZJooUPm/cnZ
         nDBomwfYJix20WKR4rA3rHiok9Wau8kDwxcHM+tkMedf0blDpRZSzdtaQhhYhcQQfnmK
         kApePOnoNVheIBwzlGwpZ4t8zor2eNSmEU6mnUYrMWVJ6OCfWslOL0eK9TByf9rLUAL+
         B1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrh3mtw21uDqAv+fInBxgdwwmlvcEY/ppShhIMRJqV8=;
        fh=q1xxoMfkOASrZ+gGYar5igC/9r99u1ZBytQQ7mDoRSQ=;
        b=a2dQ3MAmpbtLrAg4Zj+nIrXdGnJHlCqpQULK48LR+mIZOBXUoLUBP0ZChImerdD6fM
         EXmTiU8hRicFy6ON05v1kt4/jR4GwVoNhxE2GX4UAKznFyANcFFJ7AOjWXmgxqLGcXR3
         A0p8rleEQMDrYrLD8di32LKMYg7fmNMXzw2zWewa2PbJOX0be5XsJCXKo2fchvEaXbu4
         Ey88KmgtrsxkPP1vI/8tiUr4+Dq5wiRe25ue60dDsHSlRGF9MnFzNk8fsX10/VQJR7tJ
         a/7OhYRLAP8hl4blUhBdVIjd10db9ri2/WttuvYfWTDwWxJsn8mWzV9bWIhdqdyUSOaH
         j+Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781392711; x=1781997511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrh3mtw21uDqAv+fInBxgdwwmlvcEY/ppShhIMRJqV8=;
        b=k1RVJlSeqUhRHAWLeR5bCLHief97nYMl+zbIqJBKCpn3asDCW/ooMhqoY6bxTr2mXU
         hHzd0j+Vgovum/i24MivwBymcjy8OswC2vPHkSzW8rdk2Bq/n7vzupAHpQK/nvm6CG55
         V2vplDHZjo0nsrRhRe+odo84tBi/Hoqvqjn0hpN+s+BcJZNNiweyK7xw6F6GSi8xe8Rz
         qzF/SzIqhzfFCBVUpZpfeK5RM+zvX6XOkRHk16Ajhiq80ZuBR9MNgh2jbvwdBDIBwhIZ
         zoqyGNRVP3FXOlxlgD6TOaV3md7cQgySn7b2bCcqnuqRCPN9uiO1MZ02TAEIcL6qDspr
         4eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781392711; x=1781997511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hrh3mtw21uDqAv+fInBxgdwwmlvcEY/ppShhIMRJqV8=;
        b=cT/7O61FqhA1FLIhHljueaHLTTMfsqd7XF3UiHifv6vLYcZ+eW3rAinFTx/RBe024+
         SvLlbDDbGzUbMayGT+jNSPHGdU/DwGqRBH/oEMDvFi9p6U+OsdIoUddC1+inaWkb0vui
         QHf9NYSgJOlzpxI+oQusnkEQbDKWrZr5jM59Hk3n8pvrQ7kAvlAsDSwrctFN1x2VxKAq
         R8Wa7MBl2sImsYQltYlG+ncYqb4Qzny8vmeWbaTVa/3hmQS9+xpt9KfVPCNSD6prPqyd
         i1/aj6o1EWSWlmGdlFSgJhbD4Osf2I/xGZJX5ZhHSpwyklR67cmlZpwKMXkTPGukzJKr
         TO3g==
X-Forwarded-Encrypted: i=1; AFNElJ8MJdXsFgV4QPHH2Tjfx3cZODXeoLQ4VX/qCsCkBm/EKgXDJtCF7kbyY7AwNstjJTspjV24dSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfldPgbCg4LJYhcT/euqzoAmM4VZQtwmdVuE+h05LHGL0Rzd7
	GRihCvMDYzk9iEmTyp8/ui949JUFimY9/b7leJBcu/ou3m4r6D09gwl5o/7/DLnTcx5nUjp/6xu
	ReOunuc23BlMHffNds8Xr4QOSGalcV3Oc2AYpxgTz
X-Gm-Gg: Acq92OGru57KE/ud6JBOlvIgA//SRPXEoPiCZoSQNjNKQjNTvkE9uCqMSBPKc/f5hxG
	JhNpJaRyrAPE9eONNlXnBPr8YiODbajXmuY9VT5fvL9s6ZWYkkqcI0JbxKO+ybNIh0v1UPtEfhV
	ZdoSJ6VEoWWSVoGpf72RlK0Jx7efn4cUNovqyuJWlWvSnZKIJ8rsDtcPMxQOqvPea4p2QXTM/nn
	lc1hmKS/tyyU5Y208+JaKp+G+QK3UK4nLLCh2tXa5NF/26OLNtrjZgDWX928xPXaubAFkG+pzhe
	Cs8HnjXviZ3+ihHW2R5yz1nA28BYz2C/1cdsUrSfl7mdxvA9j9C/0oa1UT073ol8Z1PjnsaLPrQ
	ui4zjkcm3u+EKM+k/mSgMLVZl8kxP/N7IN9+pUr7jhFhDMOOFKAsk
X-Received: by 2002:a05:7022:4394:b0:138:33cc:d886 with SMTP id
 a92af1059eb24-1384bb1c329mr3810295c88.3.1781392709721; Sat, 13 Jun 2026
 16:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613102041.55e3b50e@kernel.org>
 <CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com> <20260613154750.0a2355a4@kernel.org>
In-Reply-To: <20260613154750.0a2355a4@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 16:18:18 -0700
X-Gm-Features: AVVi8CfWRjua43N5R25Ec3lhUHEDNvyeW-Rh2Ag46NdaoqpMNy3Y7Ggc1m-MHFQ
Message-ID: <CAAVpQUA0hA8DmR3Yaww-KjbdmoFK2b25hqec5zz9tdnKHjYJCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 3:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 14:43:46 -0700 Kuniyuki Iwashima wrote:
> > On Sat, Jun 13, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote:
> > > > When standard socket applications are run on these hosts,
> > > > a userspace proxy is required to mediate traffic between the
> > > > hardware and the applications.
> > > >
> > > >             +---------+                 +----------------------+
> > > >             |  proxy  |                 |  socket application  |
> > > >             +---------+                 +----------------------+
> > > >               ^     ^                               ^
> > > >   userspace   |     |                               |
> > > >   -----------| |-----------------------------------------------
> > > >              | |    |    +---------------------+    | skb
> > > >              | |    `--->|  virtual interface  |<---'
> > > >   kernel     | |   skb   +---------------------+
> > > >   -----------| |-----------------------------------------------
> > > >               |
> > > >               v
> > > >        +------------+
> > > >        |  hardware  |
> > > >        +------------+
> > >
> > > The first patch looks kinda nonsensical but then I saw this diagram.
> > > Looks like you're vibe coding an integration that makes it easier to
> > > treat netdev as a slow path for a user networking stack.
> > > Please tell me if I'm missing anything otherwise add my nack if you
> > > repost.
> >
> > Hmm, what would be a better way to tell users that HW TS is
> > available on tunnel devices ?
> >
> > Other options were 1) add attribute to tie the tunnel to a physical
> > device and use its ndo_hwtstamp_set/get, or 2) add bpf retval
> > hook in the path like update_socket_protocol().
>
> Can you explain the use case for HW timestamps on tunnels?
> I see you have some diagrams in patches 3 and 4 but the motivation
> isn't really explained, and we have 250 patches in the queue still.
> Not much time to play detective right now :/

To be clear, this series is not related to Swift.

Our RPC library capture timestamps as many places as possible
so that we can visualise the RPC calls and know/debug where the
latency comes from: application, library, kernel, network.

This is not specific to tunnels and applied to all workloads running
on container w/ virtual devices and init_net w/ physical devices.


>
> > Or do you think applications should handle ENOTSUP by ioctl
> > as soft error and always set SOF_TIMESTAMPING_XXX_HARDWARE
> > since the underlying physical device may support it ?
>
> And explain the deployment model and API semantics you have in mind.

The application first calls ioctl(SIOCSHWTSTAMP) and only when
hwtstamp is supported, it uses SOF_TIMESTAMPING_XXX_HARDARE.

The doc mentions ioctl(SIOCSHWTSTAMP) may overwrite the
configuration and ioctl(SIOCGHWTSTAMP) is not always implemented.
https://docs.kernel.org/networking/timestamping.html

But it does not say ioctl(SIOCSHWTSTAMP) may fail although
SOF_TIMESTAMPING_XXX_HARDARE could be supported.


>
> > Anyway, I'm happy to drop patch 1 for now and explore options.
>
> Not patch 1, all of it. I get the feeling y'all are sitting on a pile
> of Swift related code that needs to be made upstreamable. Odd series
> like this make me think it's never going to happen.
>
> > (Believe it or not, I haven't let AI write code because I don't
> >  want AI to take over the most fun part.)
