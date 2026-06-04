Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DB47ECF9
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579619; cv=pass; b=c1nsRdfTco8tmaxzUzVuYb1lH0ukqzrtXq38RSDPHO4cYqU35VThGzl8eLNmctP3TaFik8pKEWg7+m88rl7fHfdLfMR1iUAJl+wyK/XEd2zO18vzeghu6UitsSja6A4u0v6/54R86F7zHvcUQvUyvBZVLZoar6gM9pgI0AXwUf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579619; c=relaxed/simple;
	bh=Y/exHIc9brVjKunGoHXR95ATn0QtNMmHP85zIf3yQGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeNPeDB9rcTq4v6uzLBdnt8vhY28d39oqpX9CFM9e9DY2y3ad5mY+hg9kRerX946mJwyIft/HvUeHPsfn/E6OXhVsybX4J6HnYuqInt47wgAQSiPFvixXI4vtfNdyn0/Dwe4mByr9PMFsO2ZLYv+/1aVgnn8bJkq5SzddhStgO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFNt+FSk; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFNt+FSk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9158fbaa4bbso94813785a.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780579617; cv=none;
        d=google.com; s=arc-20240605;
        b=NUrlBTH632oPj/NKue3v7qDz/V2m7t7iFVA/m8a17GjQpNX868uwUFYKM9qevxd/P5
         l9tTejdaQ6vpT3jK3igHu6XxK05EgpO9ZFN2iBvdCMBu3rs0zBIuD+oREjy1oI7n8DMF
         YPWuQs6nNVMtEYlnDt8NXl5WWzhpLjk2DWW494sNhudAuc21XECWgWA9Oj+B5dwjJ8Cq
         cOg1DErwzSNPzAJHfJS22+D0vUiAeACsU+lkzTZwT1fzf4W8QBvI822h/6geaLqVvwXI
         U/hEueyzvu+MtbeOjEJdj4Gxe9GE+IxP+0QYBvVN3aZlI35PE+etV5GgBz55ZaFhlE8Z
         tyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KY3HsjCQui9i18mE5QmqfIjfXKZSET3GoS4sPvYKb/M=;
        fh=kJGKBeDQrK0LSYFvX0wIBUTYEI1t3w3FcK0Bkx1ol64=;
        b=gIvl05mM3C3LLqI69di6rK4gRBLdsGB+mYJ1gT6rp0Dnj9Ujqhglb8Ka+lMXVPcpiZ
         tldHn24q0IkuXObbBN/LOtZX9ceopSZeTCkRbRnPbA9PoUSHTE1+zyIv9JlaLMU2M2YN
         pwo8+dxRlAqzvPdDiuwsjItrmJwUXtmqsQT0Jg/nIGsq0yuDugcTJKkAwuQXEB96BLN9
         9TrVPdowbmYaIKGPVMnw7jGz3Xp4Nq37RrJ8deMQhTxKTmLuSuHvD/Y771Y35JflSAO8
         CjqDXrNG1MEwGy6A+cMhxEmT6kXT+0DHxdPRx1AEjJ1HhTxVTelm32ZkOiXqX5nzFmfD
         32Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780579617; x=1781184417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY3HsjCQui9i18mE5QmqfIjfXKZSET3GoS4sPvYKb/M=;
        b=AFNt+FSk3RpbkN1JGw8qtwiVspRQiWJqRZnRmLaydkqUOfuQb0M2UukeKFIzEKFxWT
         LJy0IXpS7kzvYR6PuAD9anV367O64GXgRmK6t2MdEbmLiLZMslK6wzwiUOlQFG+FytRx
         glfNkoC6zl/6jneq/nIzSohxUGBq+pcqoXul8s/oajvXcN9dP9FkMsfIt+3eBQNrh9vM
         OpJSvYM1LOvwYFt/xapDFgUsnzazEevHdU8bvthj6TemNOxerFF3BWIooAZJOmoYcAtR
         CUQLooKbMCepQkdug+oEkY2Kt1SUYIe9D0eNu/7L894nxExcPQx1gj5FpVMPXN/7WnXU
         cRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579617; x=1781184417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KY3HsjCQui9i18mE5QmqfIjfXKZSET3GoS4sPvYKb/M=;
        b=i6CFHuFxo0WbKyuo8LFmAugu7bbXopSh7SqeQbeBenvQ1r2rFH6dV04vtjaUYlUQMw
         ffrRffHagMhR9eWoHQWCTvLjMeFLj/6BijZBGItGFo2q9pCpwtHfGMxbvXVFpZbmE2k4
         +TfALqyOrSCAdo7FvpR++C0EEwt3iMSGZhK4+Ttsf89bZXmdkYwY6pzSuobG5f3qnvp/
         a5e9r4jds+1ZsBqwBvU5vjgUGliT3/1DEZia4OLVlWOZG6FXzQrQAoa4w6iVcJj11F4p
         AXbOwaOdJXMhXtFktAZrd9aVYK/ek8tfibcXuTdOmmVzNeneoxHgG6QUvuzRlS6r/S8d
         Pinw==
X-Forwarded-Encrypted: i=1; AFNElJ/RyZKmoOiZubeWkZz73eAxG0c3AShxd/Rp8azIzzFDiiGmijWUsyLZRiaXeB8+lzkR/Il4p+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkucXHWDfPg/ehShMW78syWE6fgJP1X2+VnT1JXqU7bKFm++QR
	ElmgH7kAvleujnws6ynggqMMHUkYvbgSKV+C6zgjaz7I3nvdPeYVGtDLVfkp60wrFf0qw4G1J7M
	jVCP+KKK1Qlj3rqyPv2IYip3cScIIJ4obUU+w7Y6/
X-Gm-Gg: Acq92OGUw0QmFdm60b6fKrLKIGMEmIU1zBdEd3gG3hwCp5+MExzwTIo0VbLj/yb2G3h
	Yw09zj6bvvAsMrA2oBtHq5bQcYHP1RsOw1hYxgW8z05opXhIaJ9OhN6jpVdFCqNb6cMgD6+0pH1
	oJhhKI6enB9s8W+0pgqHbxTp/77CPzQx0mqx2KhNi3RWaAgxpk8I57LUYY8VRqijtaQxhKEj389
	CtiIOThO4R7cxRXak97J5FqrihxZxNEqurZq/17ukIgFVlH/MlRaxEGViz9Xrx663ZabI0PLnSG
	UJiIZ2HqnHrjUytts7wjarrtcAix0LY7vTFsrvGzPdEXTbl/dcmiXs3MyCKJYv7NFRclZ+AWWsV
	W3JOOFSzYUWHPO2PtDmAN+qOGN28jvQ==
X-Received: by 2002:a05:622a:2b0a:b0:517:72e0:612 with SMTP id
 d75a77b69052e-5177874af42mr110703141cf.42.1780579616768; Thu, 04 Jun 2026
 06:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com> <20260603062043.3911278-7-edumazet@google.com>
 <20260604105030.GA775294@shredder>
In-Reply-To: <20260604105030.GA775294@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jun 2026 06:26:45 -0700
X-Gm-Features: AVHnY4KOIq5euv12ttKrv6Vtt7j6hZ67FlRTPV1uzCbWBM0DtU1djnN-iGtuwh0
Message-ID: <CANn89iJ-v_Nrc+wP53WnWxcPjo2zM4TkWc8ufGm9iO1pZ+8uuw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/11] bridge: provide lockless access to p->designated_cost
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:50=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Wed, Jun 03, 2026 at 06:20:38AM +0000, Eric Dumazet wrote:
> > @@ -302,9 +304,10 @@ static int br_should_become_designated_port(const =
struct net_bridge_port *p)
> >       if (memcmp(&p->designated_root, &br->designated_root, 8))
> >               return 1;
> >
> > -     if (br->root_path_cost < p->designated_cost)
> > +     t =3D br->root_path_cost - READ_ONCE(p->designated_cost);
> > +     if (t < 0)
> >               return 1;
> > -     else if (br->root_path_cost > p->designated_cost)
> > +     else if (t > 0)
> >               return 0;
>
> Eric, I think you meant:
>
> p_designated_cost =3D READ_ONCE(p->designated_cost);
>
> if (br->root_path_cost < p_designated_cost)
>         return 1;
> else if (br->root_path_cost > p_designated_cost)
>         return 0;
>
> ?
>
> >
> >       t =3D memcmp(&br->bridge_id, &p->designated_bridge, 8);
> > @@ -344,9 +347,10 @@ static int br_supersedes_port_info(const struct ne=
t_bridge_port *p,
> >       else if (t > 0)
> >               return 0;
> >
> > -     if (bpdu->root_path_cost < p->designated_cost)
> > +     t =3D bpdu->root_path_cost < READ_ONCE(p->designated_cost);
> > +     if (t < 0)
> >               return 1;
> > -     else if (bpdu->root_path_cost > p->designated_cost)
> > +     else if (t > 0)
> >               return 0;
>
> Similarly here?

Oh well, time for a V3 I guess.

Thanks.
