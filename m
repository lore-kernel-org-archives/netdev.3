Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79738D41F
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967154; cv=none; b=lQ5An0N8GMKxW+KV2agt93rgUhvRtb1pnTlImG3Mdhg/p/tqhPLj8vwxMCdm6VyeFP8kffwUHSu99XLQVmTa0C+os0XSo2VWZJg3p/bqnYdP6dyG27TqCJbOQ5A8ZdgHmyS6oI57M9iuKUGOuD5Jjn34OAkb5Qi9y7bt//rr10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967154; c=relaxed/simple;
	bh=sjqdxrjwM8lbjfKQguLQ5AhPBdxiJNS6omgV95zmsqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDTYwC7HxwH0r5i8vbFMDB79RaUAGMLmEES/MhNaD8TB9a2jnX6besIEJoOvV3mdZqz2avgoQizuANntGmTxOr2CGJSZYDyIvDom/iNaLU9OCcnQmEqH9IezU8g3DcG6yw4rgjS6blwJDMpInGxjLSSPIyuT72+FV6BZzkE0pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeM8ABig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeM8ABig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1421F0089A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967152;
	bh=sjqdxrjwM8lbjfKQguLQ5AhPBdxiJNS6omgV95zmsqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EeM8ABigxuJByKYKD2ACVhJEWIbD2flhJWzEQ/yeXES0fvVk5XGv2KwV+lIVANrXd
	 JhHZyj4JYmGkB/ubbW3e/AdKyS4hLnZzWfE09Kx35iI5+BiFi28xuE6W9yLL4GwLua
	 7w0ayw3c7DxRjno8aqc5dkk1Gj2anUHtrP9a0yMwiPgBb2d/skB6vl47Je0TVq5/9b
	 zXYfbMpEQ1TN9rQyScYT79reO3XA6SCbecXTOP68346VV8amNkwmAzKSQylGaT41Io
	 0j7GZ0MPM97Sl/2yMD0vy6xWWvS9mtJ1KIXh8W2bF4Osafgz9U5VGmY5H/KOLPda8r
	 rYrrjuX+bWWSA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6c8f6a53fabso172604eaf.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:52:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxUb5Qwf+cCMrDDwXe/dbLXuiSuwf1QP5BfEfGDB2FXSezj9Mtq0Mh1RvswntcefIpWf8p4uv0=@vger.kernel.org
X-Gm-Message-State: AFuF++nqICBzFpGaodxmfSPW1ZFSvyrPTnk5AC3uf2cPO530t6Nc2U17
	Elnzgop2Yf6Yyc5FsaSDcMmIJrgXELlBkXPpZ/bVxJ0ZrW9xK7XilrMR1cbLISKf803bWiH5uq4
	b5Uvzxqb79zQ8LFGewRiWz3bXEpgUCAg=
X-Received: by 2002:a05:6820:2226:b0:6d7:fb8b:20dc with SMTP id
 006d021491bc7-6ddbb2b3d0amr5629396eaf.35.1790967151757; Fri, 02 Oct 2026
 11:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930172957.897342-1-edumazet@kernel.org>
In-Reply-To: <20260930172957.897342-1-edumazet@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 20:52:20 +0200
X-Gmail-Original-Message-ID: <CAL4WiipQ9fm_NGxVBHdAzFKffKfQnXefmD_dyuwc-E8s44Yhqg@mail.gmail.com>
X-Gm-Features: AclHuK9upUUC7WEfZND1fCZqM1PYKV-GPzoinl8lXw3C0rKOA7b7xRoGYibJ5dQ
Message-ID: <CAL4WiipQ9fm_NGxVBHdAzFKffKfQnXefmD_dyuwc-E8s44Yhqg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: inline eth_type_trans() fast path
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 30 sept. 2026 =C3=A0 19:30, Eric Dumazet <edumazet@kernel.org> a =
=C3=A9crit :
>
> eth_type_trans() is called once per received packet by most
> Ethernet drivers, and by core helpers (napi_gro_frags(),
> xdp_build_skb_from_*(), veth, tun, tunnels, loopback...).
>
> With CONFIG_MITIGATION_RETHUNK / SRSO, the call and return
> are not free anymore.
>
> Add eth_type_trans_inline(), handling the common case inline:
> unicast frame sent to dev->dev_addr, with a real ethertype,
> on a device which is not a DSA conduit. All other frames
> (multicast, broadcast, otherhost, 802.2, runts, DSA)
> are handled by the out-of-line eth_type_trans().
>
> eth_type_trans() is now a macro calling eth_type_trans_inline(),
> so that all existing callers get the fast path. The out-of-line
> version remains exported, and can be called with
> (eth_type_trans)(skb, dev). bpf_prog_test_run_skb() uses this
> to keep tools/testing/selftests/bpf fentry/fexit tests working.
>
> The inline part is about 25 instructions on x86_64, and the whole
> function would be almost twice as big when fully inlined.

I think we can fully inline it.

I will remove PX raw 802.3 detection from eth_type_trans() first.

pw-bot: cr
