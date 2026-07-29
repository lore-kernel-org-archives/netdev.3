Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599564ADDA9
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334881; cv=pass; b=s0bV3m+PZEeQC/VwPDqtYBE/ZqoA7P/tMR5S2R+uWaynhnqjzPPxShcJO8Y46/H3p2CmKBkFwKgZRpFdmtFRjm4yAUfi+AKAGjXDt/MpJMlbNcpeyHNjlVq45+4w0YZnQGu72ijgJJFFzWwuoXrbyaKdQZ1gONPQ4veNjE7Alck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334881; c=relaxed/simple;
	bh=V3TtLAGmQlfcCnbugVYuYAwlhDcUkcB452p4EfYMSG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sspq8Kbo57UwuNWgu8P9yxkEQbmvLTEg9+oLq142S556LFNeU1h6G+r/vbz7qZsF/Kgv6lh7ogtjmlss3tmBHdLKOge0YZRAzse3asYqFm0/F5hv4hQaL8O4le01bGv2lSgJK6YZzzsDx6S5Dn2ONa1JByFiqy+qqGa783ux1vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IGUwOkGY; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IGUwOkGY"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so10065881fa.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334877; cv=none;
        d=google.com; s=arc-20260327;
        b=ZGoP3SrB1glsa0dVRsQR2UfEApxgiLT6YIZKyRTmBQWp6BHCqNTyG0CE8MAwfORc1m
         Atb1i1M5jQ+WplkTr3rH6MysYH8uz8IlxuicKi7gKW8lJQ+qLgnNUsFRYj64GZs3c3cm
         FXBWmW4UF6bRKC9VXvj2dC0BjUoCtLTLvTYWWiM+XguVYfk1VToCP6MYFIXuxeP8WzQ+
         STQbqBhjBypqSWknYCjiKEokbWoh19gh8/+suus7CuGE2OkwOodzaeFeWM0MTVFVzUWQ
         cVCOh6iR7J2MhOukNYiNLsqJJd+UdqW/w8/2bEB0b+VY/ntxAEBkwre6SNWnvabAq8kG
         YbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9U+yBXZNydRZ4aLB5sQnQ5jKVySq/ApFlqzcSLrMp4Y=;
        fh=OJeZOLTg01C9jl/T+BMOKVsqqLKXRQFZfgG6l1IOHj8=;
        b=FbDERv5LwZUNRDTDVk3cj8UwA+uLvMgqEQx9TSthlUvz8G6MSVntE6BMXMakLrnDFW
         j8tqze/sC3g/dCtHws/314s6+xaO9Ge26mcy4jbJcMpMVN1/ihFy1cj6L0TK2yyXqgve
         8IUOUD72/yesxLv8iiC01o0Evge+/Egu6QmKOWh67TT4kgoabRY2mPV2jL5cFwNOXpc3
         cm5RLGeUXXE2ciU/23m9RH+QMhCQm+ht2+VfHiGc30U2Eeoqh47U1DykBA8I9wlvC9C8
         NV6CTVoUMdcs9KKqYL+b0O/GjkifUU/14WkR00+v6zlW9yO4JoAmiPH5Wm68ZgfDy6st
         BI1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785334877; x=1785939677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9U+yBXZNydRZ4aLB5sQnQ5jKVySq/ApFlqzcSLrMp4Y=;
        b=IGUwOkGYNt+c453SRfV2EOZZgtIoHmG+P5m8iP9L4hOmgkvxW6OWMcZ0j7HqHRb1tz
         0Xtlj4lLO9khzjJJfznKrQYnKomA0KnXLHLLB4Xfb7jXWm3JFmmfogKLGtuW55qhE9Cd
         tiXI2Z2M1vpc2P08xkik/4XcrOp9Ab+NlPl3iivrib+cWXG+3iaQ43JADUVf2L+BFinh
         cb3PVhN0dbqAQw2Fub4ENOA4Agm5lX5BAsUGVfYtOxiSbE0A/9J4WtbXDJWnH8HzFumi
         1ykXIVchb3sIiF/7VXcw2lO1+mtoH4kkig67x9AVenaAhTbT3I799ybNnoNgDN2BlGkB
         dnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334877; x=1785939677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9U+yBXZNydRZ4aLB5sQnQ5jKVySq/ApFlqzcSLrMp4Y=;
        b=YzB8DDLrCl+E5FqoARFCNcxXmXnFymly2uiGAbM0WY9dm0/JbbB8d7WhVhnzAlvsmc
         r3ippRtjxEhOqoss49r+m3xH31ToN1JKUrf+D9kP9h36Y+BQvloetpbPRuz/aT4so1iu
         lIi7JL7896o1/pYRkcINHb5uig+eCDStTWHtDYWOajKcj7exa8AbIKpcgUYG3lsOmQ22
         JbAYGpXSJ12TTVXAfcY+Qx86Yl51aH6SlpLr2LmXSMfG8lcsRfutJusomcqovh047i8E
         7OggApD3U2JQ0aXO1cjcvqmeWXugUg18smayOBjYh6wRsggxshG7YSuqLLJUrfOb11Y/
         cS6Q==
X-Gm-Message-State: AOJu0Yw0odqypagEu0T5HT8HqpUiShV27uz5TUqwBWOAOCXdO+aKo5qR
	VqvbI2NMw6l6lZedMp4iS9fu7GlJI2CucFtWWJINi5birQ0KdqVKsRxYXMlh6q9MpgrVOIE/Mz0
	LI8XP2Uyjgc85jYYaAbDdlXjcErCo2s2vg/xTP8PtxKY=
X-Gm-Gg: AR+sD11mR9roJh5db6HkkbR7mWrWHpYPbF/Ptc7TiUiqrd0Zel9sN9pz+o/8lhWG2Jj
	zJ1KkLAFHRrsndt8cin93vz3mefKu9gr4JJ4O6tBnQxeLyLfYdUpP7GtVX2Hd/fzrArrQtoG7FO
	qTPuy3KR5zOqz/funPeeMzGUlAjn3HLnYSeZV1G4u5uCpuL8iF7foznfiqxxOStzIEVUq5JbxPT
	1AD9if4unoj2fELyDg2b2sHc2/5sLxd93/9FDNGY+CfDP4Vug2sdxJpbbfrc36vX1JE7kA1Et8W
	BdO4sKO+E5Vu8rRKJTNQITdmCkC2MwlqOoxR9o/vkW4=
X-Received: by 2002:a2e:bc12:0:b0:39c:956e:77de with SMTP id
 38308e7fff4ca-39f605be8ddmr6515871fa.6.1785334877102; Wed, 29 Jul 2026
 07:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785307984.git.zihanx@nebusec.ai> <3b55d602-f9ce-464a-896c-8d89af572f6a@linux.dev>
In-Reply-To: <3b55d602-f9ce-464a-896c-8d89af572f6a@linux.dev>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 29 Jul 2026 22:21:02 +0800
X-Gm-Features: AUfX_mzGUlyZYlslhjWe0i5zHKVZnSYHoT6z4HjQyhgwd_5SBNN0jtS3a72-a0Q
Message-ID: <CAANe3eSDxw=r4OYo5Ch-2+u24wbC7tKyML-arrSd5VfV7zgiUw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org, kees@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, fw@strlen.de, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:55=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 7/29/26 7:28 PM, Zihan Xi wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated a issue in net/ipv4/tcp_diag.c and
> > net/mptcp/mptcp_diag.c. The bug is reachable by a
> > non-root user via user and net namespace.
> > We've tested it, and it should not affect any other functionality.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > inet_diag TCP dumps currently execute attacker-controlled
> > INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> > bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> > heavily populated and the bytecode is a large reject-all filter, the
> > dump path can spend an unbounded amount of time under the same bucket
> > lock while walking attacker-arranged sockets.
> >
> > The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> > one colliding listener bucket and then issues a NETLINK_SOCK_DIAG dump
> > request with 16380 INET_DIAG_BC_NOP instructions followed by a failing
> > INET_DIAG_BC_D_EQ test. Because every socket runs the full bytecode and
> > none reaches the reply fill path, skb backpressure does not terminate t=
he
> > walk early. On the unfixed kernel this triggers a watchdog soft lockup
> > and then a panic in inet_diag_bc_sk().
> >
> > The earlier batching fix direction was still too narrow: it only counte=
d
> > sockets that survived the cheap prefilters and reached the expensive du=
mp
> > path. An attacker can therefore populate one bucket with many sockets o=
r
> > listeners that fail the netns/family/port or MPTCP-specific prefilters,
> > causing the same bucket lock to be scanned far past the 16-entry batch
> > threshold before control is returned.
> >
> > The same root cause also exists in MPTCP listener dumping. The
> > MPTCP-specific mptcp_diag_dump_listeners() path reuses sk_diag_dump(),
> > which runs inet_diag_bc_sk() before filling the netlink reply, while th=
e
> > listener bucket lock is still held.
> >
> > We additionally profiled the MPTCP-specific path locally with a
> > separate debugging artifact. Because struct inet_diag_req_v2 stores
> > sdiag_protocol in an __u8 field, that request must keep
> > sdiag_protocol =3D IPPROTO_TCP and pass INET_DIAG_REQ_PROTOCOL =3D
> > u32(IPPROTO_MPTCP), otherwise 262 truncates back to TCP and never reach=
es
> > the MPTCP handler. With that corrected request, a 1-group run with 3276=
8
> > listeners and 16380 NOP bytecode steps took 2082.608 ms on the fixed
> > kernel versus 8.601 ms on the unfixed kernel, and kprobe profiling show=
ed
> > inet_diag_bc_sk() executing 32768 times on the fixed kernel but only 25=
6
> > times on the unfixed one. That 256-count is not a missed path: the
> > unfixed mptcp_diag_dump_listeners() reuses one counter both as the
> > in-bucket index and as the resume cursor, so each dump restart advances
> > in a triangular skip pattern and stops after approximately sqrt(2N)
> > bytecode executions. The inline reproducer and decoded crash log below
> > cover the TCP panic path; the MPTCP results above are included only as
> > supporting local validation for the second patch.
> >
> > This series fixes both sites by keeping bucket-locked sections limited =
to
> > raw socket collection and lifetime pinning, and moving all filtering,
> > inet_diag_bc_sk(), and socket filling work out of the locked regions so
> > the batch limit applies to raw bucket traversal itself. For TCP listene=
r,
> > bind, and ehash buckets, and for the MPTCP listener bucket, restarts no=
w
> > keep a referenced dump cursor so the next batch resumes after the
> > previous socket instead of rescanning the bucket head under the same
> > lock.
> >
> > For the TCP patch, the underlying root cause predates modern git histor=
y.
> > The Fixes tag therefore uses commit 1da177e4c3f4
> > ("Linux-2.6.12-rc2") as the earliest git-import boundary that still
> > anchors the pre-git bug in the current repository, rather than
> > incorrectly attributing it to a later helper or refactor commit. The
> > MPTCP patch uses the real introduction boundary, commit 4fa39b701ce9
> > ("mptcp: listen diag dump support").
> >
> > Reproducer:
> >
> >      gcc -O2 -static -o poc poc.c
> >      unshare -Urn ./poc
> >
> > For the reproduced panic log below, we enabled
> > softlockup panic sysctls and ran the local helper that executes:
> >
> >      ./poc --listen --groups 4 --stride 2048 --count 32768 --nops 16380
> >
> > We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
> >
> > ------BEGIN poc.c------
> > #define _GNU_SOURCE
> >
> > #
> [...]
> > static size_t build_request(void *buf, bool listen_mode, bool with_atta=
ck,
> >                           unsigned int nops)
> > {
> >       size_t msg_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2));
> >       struct nlmsghdr *nlh =3D buf;
> >       struct inet_diag_req_v2 *req;
> >
> >       memset(buf, 0, msg_len);
> >       nlh->nlmsg_len =3D msg_len;
> >       nlh->nlmsg_type =3D SOCK_DIAG_BY_FAMILY;
> >       nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;
> >       nlh->nlmsg_seq =3D 1;
> >
> >       req =3D NLMSG_DATA(nlh);
> >       req->sdiag_family =3D AF_INET;
> >       req->sdiag_protocol =3D IPPROTO_TCP;
> >       req->idiag_states =3D listen_mode ? TCPF_LISTEN : (1U << 12);
>
> 1U << 12
>
> 12 is TCP_NEW_SYN_RECV. Is TCP_BOUND_INACTIVE what you expected ?
>
Hi,

You're right, `1U << 12` is `TCP_NEW_SYN_RECV`, not
`TCP_BOUND_INACTIVE`.

The inline crash reproducer only exercised the `--listen` path, so this did
not affect the reproduced panic there, but the non-listener branch in the
PoC is indeed wrong.

The intended state there is:

    req->idiag_states =3D listen_mode ? TCPF_LISTEN : TCPF_BOUND_INACTIVE;

I'll include this PoC/cover-letter fix in the next reroll.

Thanks for catching this.

Best regards,
Zihan
>
> >       req->id.idiag_cookie[0] =3D INET_DIAG_NOCOOKIE;
> >       req->id.idiag_cookie[1] =3D INET_DIAG_NOCOOKIE;
