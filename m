Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515148;
	b=yB+I0+CZf+7SJeirQs9C/ClUI4i+hA3Z0deNfWMmyGGKEt3dgbIcPVk8F3vFt7IUny6U
	 j40LONmULcq7e1Lixoj3oHmiQzxUg5uadM5KybPJiIwWNbPGtg8Db+BYzlCAI80+JWBnC
	 9WElcBTCMzdtnx61zFcao6iWyUE9iHaslN+vjLqF28/u4sCtU7fCVwY2WC8vF4dHWDzb/
	 M+xlNeCanMuI5mYABWg/i1wjGFQngfxAIbj/yLLoAvm3zEkaQ90N2qN/ckyRPH2LmkuLk
	 AzkN2oEHNWopR4K6lBTzR85yLwYIcwDv5z3d7FUY4ApvN4V4N+KsJ8eyoCIOJ0xNMfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=CTna/wiXP5/NUyBLzytTu4ESJYNBaE3GOT6pFR2PaGg=;
	b=vNExJt2ISgBTuaIdYiXJ/wxOL3/1Bau9nst4NpenuQ2SGIreOMUoCOQ4vFKCXYClfZIz
	 OKLePMDKVS8WqMHkmjw+yFOzYzwIXtW+NDSd1JfQ4qLcHLKM5YUnCKPyiLg7UGM9lmCz8
	 dwInvHmVaC1EL43p3EcI2gX+qv6jpUr2oi2SfEcpW+C0di0qe+PPTSOF9Sw37FEukAdeA
	 nLyQNYPM1nQaxe2LTKUzsiWodXQN4dIvCcGbNZph46ISdneeySmSTW1dDeD7uxD7W6goF
	 SEsyfSRgXSYfnWTJeYvs7llN+3XB7kAELbVkWlaM9OxQi7VXnPAd5b/uOU/H/dQFJsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=S00pw48A;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D927606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D927606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=S00pw48A
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a069928ff5so638633b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792515147; x=1793119947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CTna/wiXP5/NUyBLzytTu4ESJYNBaE3GOT6pFR2PaGg=;
        b=S00pw48A0Roj8F8hjMojnQgp7f8ZdyPs+tySSobgYMoWy1fo5AtyLz8kNvoXiRwXir
         2DfToqxMJIKI3Au4icO/K2C3ac1przmzR31jOElJyw7Z8duCKCJrndRfgTnICovLlAIh
         dXlwlBou5fdbsW5DcK06mrSVEHAdfRAXGCbmWqqeGYSjlw2xytyWekpHODPIwz+CNN51
         zqjtXrAX2bgQklq6ohxbv6nXdeyElHUF/peGo5I4TSyz4bd1YbIRRN2YLN5uq5Bfsblg
         T14oJ+G57wmvgxfxo0PPwQExUeNhIYBHjaCnOwUAi7XPaebtPR6hpdsedsyRZNaQf0+n
         cnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515147; x=1793119947;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTna/wiXP5/NUyBLzytTu4ESJYNBaE3GOT6pFR2PaGg=;
        b=qwqgjOZ7bC+hI1FJOuqqVPZXqEE6Q1fwDFIz+wC4+9sQ0g/I3Y8TQfeHQG3D6T/bit
         C6YvwRYCstxUxt9MesirqTob3xhhX/68+1bfQSCIvrNnKrAcqlDOhRA1TDQD+DlofSme
         sMkBa3alETYPst0nySbERtn/CcT1U6tHkREj5T8xvLH6wCRS8k00W5p0iuWv6BOyEg9Z
         J3VKmxMNtmPdng8KXB+ZNai+zQAYU2o6o/nWx3WRUjmMz/0SjT4IhWEA1RRlizI4sY/A
         bSZzOSjFuxfRvgqiga2RpUip+Kml6R1iQm84zdHC51flaufC8j/F2P+Y32HEtEZy5jJ7
         dvog==
X-Forwarded-Encrypted: i=1; AKwUvBzRA9Pqqj2ykkGFovrJ4yVd22pPVi6LndRAoxVuD2qfQB0ldBe3ECKiGkXlf+O1sia8lDBaglw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPga6aqIa5YEjiwbPHM4kSLI0cZto+4ElUICFtDRjWQo8XZxOG
	usFJ/D2vLl3fN3S8weHubIHF+Wee2S4EqvoZNb2DuSuKwqApAANFOyOf0KCLeCpSfEsMumviCcX
	4n7F/lQ==
X-Received: from pghm19.prod.google.com ([2002:a63:f613:0:b0:cd6:1195:61cb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328c:b0:3e2:43f9:b56
 with SMTP id adf61e73a8af0-3e26fdcd926mr1596048637.50.1792515147352; Tue, 20
 Oct 2026 09:52:27 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:52:26 +0000
In-Reply-To: <willemdebruijn.kernel.1a81a5aacc334@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019230758.2960779-1-joshdon@google.com> <CAL+tcoBjWDwA+MrjzRapUeAom-4siL-cnXXLQrVf-A4myNRxyg@mail.gmail.com>
 <willemdebruijn.kernel.1a81a5aacc334@gmail.com>
Message-ID: <ateasbpJlRipuEmi@google.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for udp{,_v6}_send_skb()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Josh Don <joshdon@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2026 09:50:32 -0400, Willem de Bruijn wrote:
> Jason Xing wrote:
> > On Tue, Oct 20, 2026 at 7:08=E2=80=AFAM Josh Don <joshdon@google.com> w=
rote:
> > >
> > > We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry program=
s
> > > to monitor UDP transmits. Both functions are static and have two
> > > callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
> > >
> > > After an FDO profile update, udp_v6_send_skb() is now inlined into
> > > udpv6_sendmsg(), while an out-of-line copy remains for
> > > udp_v6_push_pending_frames(). The fentry program still attaches
> > > successfully, but it is silently bypassed for all uncorked sends.
> > >
> > > To address this, make both functions noinline explicitly for tracing,
> > > as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> > > Add noinline_for_tracing annotation for tcp_drop_reason()").
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Josh Don <joshdon@google.com>
> >=20
> > I actually mentioned this thing a few times before. The original
> > thread was from Breno who tried to apply a similar change for tcp
> > sendmsg. The fact is until now we don't guarantee those functions
> > should be kept noinline like how uAPI works just for BPF prog. What I
> > suggested was to select a series of functions in one Doc so that we
> > could tell people those functions should be noinline or whatever else
> > just for tracing in a soft way?
> >=20
> > Otherwise people would argue there are more functions that should be
> > done in the same way because they internally trace it.
> >=20
> > Willem, Kuniyuki, any thoughts?
>=20
> We'll have to review hooks on a case-by-case basis for performance
> impact.
>=20
> If possible, it's preferable to select hooks that cannot be inlined.
> Over limiting what the compiler is allowed to do.

Agreed, FDO is critical especially for UDP, e.g. udp_rr
w/ 20000 flows will gain high performance boost 14Mpps -> 21Mpps.
