Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769899;
	b=lKxYLlTIEPCpzyW3MR1dSf+zgFaQ46/F7NUrkEuzrRrMiy67BoKD3IgXy+00at1/BIi+
	 SHajSIHM8rNChUy3oylYVtW6OTw8H9dMGtehcQuIxPD25uzqIbdWMYHOH3oU6F9kN23bT
	 aAWwsUCmAi2ZuXODqGCixyiutm7sEFRh/SkucvbPWbzeiUjA6UwPPwi8JqD+d91/BODoi
	 ZJUkXCj0j6uZBwuvhb4f8IJ4T6a1siMEFKpnjuxjF4r0cPPtDnrR0CsLXMBc/AvcxJWSr
	 xb5eDGVQHOg4K+UeaNTxoTmg6oZ7DDFG8guucKfTrDbHyhkYjlmgujboNVvOrVNgJJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769899;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eoBDVmnVXuE8Yo+S60hLCqU6/yj3dqT4h3cmEdolbz0=;
	b=WudViZ/WU3muLe3LfanRq4hYe2zPZqjKNC1aYmUyacKvKqE/4ZTFhggc1CMLKQrEd6k5
	 s3Dk/umiYynez1QLIqBhmRzNK0jbqNDdP3uZJpTTmdnUfKXVn1g7DGgPKEcs4amnAxs/u
	 TYQDfMe+9rWeZ3OUWrLs77aA2q5PYinqutE2J5hSXCc3Ob2BcYLzlAQvVMosTKMGaXqJ6
	 cdeMhnOqJaSL9OSgoREPiDILvJPdEJ0WVU1x4YQQYJiUmsCWFkAxS1jWldAZPi+u9zGA+
	 K4u0WTtOwFcnt7/gxRczwCpGmce1RJ4govU3C5eY1hB71HV7e4GIK56klX8hksfj/WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKex3rK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFE606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKex3rK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E51F00A2B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 05:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769898;
	bh=eoBDVmnVXuE8Yo+S60hLCqU6/yj3dqT4h3cmEdolbz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HKex3rK3eL7Rp+GBrver63QLhTNWwbrojE6jrALo/bgcnVPFsgJw69EDdGp9yf0At
	 UJCYzMiHiMm8mro3z0bORkKypfRCvYuyw0KZIgXNsbPwDTpnsKi3VWl75HxnPBSnfN
	 vwWQj0xjj7wdxmwhl5W9vaEBE01eD74N08NnyBkn/yH7yDjlOubDBt4cJLgWHi8vVU
	 ypkweTk0bpKGBm/+6ZHfgln3QvR3vhFeAfACoYkq48/lm3pZSZyiIJhhjjkTqzW9+k
	 frv64kta+N44II0PcjIjZNMJqd/uICDBJayXP4ZnG4FWNvlhm5L51ZJXf/QlPIp3Dd
	 /r/NgnopgPFHQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a822463a22so214453fac.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 21:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwSTgkwUypUrzodDiSFjPMzcb5BT4UKj/sJvRF8urXJwqLpx6mhTumyEGGqPXN4vY0mP2IBzho=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YyiU88Hn/FYeHo7wPHeVVK8mNMjCgZnyv1AVpQO9GXeO84AN2
	fQklTjPcgHvDhO62u7rKCIMDhPCxJMPSOqVIhwv4oU/zh6/oVUxCqmfcfXgy2RaW4WtijcX7q0z
	YD26YkdHiRkYviLrNUqjA89VmdpZv8p4=
X-Received: by 2002:a05:6870:960e:b0:4a6:fa51:3c89 with SMTP id
 586e51a60fabf-4a9077ef1a1mr9007007fac.51.1793769897717; Tue, 03 Nov 2026
 21:24:57 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <aujuOJCs5zZyon2k@john-p8>
In-Reply-To: <aujuOJCs5zZyon2k@john-p8>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 06:24:46 +0100
X-Gmail-Original-Message-ID: <CAL4WiirLdpvLGKDrfM3s1Gx_JsUuA+QVQS_3TY28gttdQnEF6g@mail.gmail.com>
X-Gm-Features: AclHuK-kl3984ixA3XfcRldmIqqk9PcGSyvzJ0kBvOxBMRAIApqefCIEr1A6YD0
Message-ID: <CAL4WiirLdpvLGKDrfM3s1Gx_JsUuA+QVQS_3TY28gttdQnEF6g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects,
 corks and recvmsg()
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, 
	matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, 
	josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 21:11, John Fastabend <john.fastabend@gmail.com>=
 a =C3=A9crit :
>
> On Mon, Nov 02, 2026 at 07:20:57AM +0000, Alexei Starovoitov wrote:
> >From: Alexei Starovoitov <ast@kernel.org>
> >
> >These patches fix bugs in sockmap:
> >
> >  patches  area
> >  -------  -------------------------------------------------------------=
---
> >  01       recvmsg() after a fault
> >  02-04    the verdict of an sk_msg prog and the return value of sendmsg=
()
> >  05       the backlog of a stopped psock
> >  06       TCP listeners
> >  07-08    the target of an egress redirect
> >  09       the TCP state in recvmsg()
> >  10-14    corks and the redirect target
> >  15       bpf_msg_push_data() and bpf_msg_pop_data()
> >
> >8 of the patches are from Chris Mason and Josef Bacik.
>
> Thanks everyone lgtm. For the series.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

For the series:

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
