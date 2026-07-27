Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50636F8F0
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169399; cv=pass; b=mEDRXXTWk6/EnPyEA1fTmjLfSJ/rRg2Hoy6v+jpsEUB708IHNjy6acso8zI+alvSQ6oS6LNLyHxeg2Imv4EGBVz54XPB7hKIYn7jPkTXldVZPkWknYtTVKqqSCMF5Grve2NKSTUzbnyRSQLsem/i02+skNwROjNnUoEFfNqVUt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169399; c=relaxed/simple;
	bh=yYRASoVkj8hdVAqGUL+43B00+jgnCtRcBZHHxUOgYoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnOG/AKhPmX0Cd245BcG2sXIIdUe5U20LjnNirHvGNcKqaAX2lRns5R2A409ZdYquBVwWYtP5UFk79V84Evjl4eETu9lx2hGv30dlee4oHv+8Yv0W7vNH548cqeSpZWvmOywqmTEYH4uv5p08uwS2MUAmYRxzm9iaMcXz9CRMZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvHAtR5I; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvHAtR5I"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c167c58f2so21237161cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169396; cv=none;
        d=google.com; s=arc-20260327;
        b=XWh0+WTrCPXKWZNlKWobw26XlOiaIaJRuPe29kw+bysn+uvG8A1ydu3vvSHVt3I6MW
         fWjLkBTaMrDjwrhJWaqkkVL9aRIqwMaNBRKPLk9k6o8xivoK01cKmuemd5Bi4FEd4xns
         4Ro1SKInQ0FScnbSI0U/O2fZwHmkHGoxJfElBZ6Xa+cieayadVDxhxPCz8/Pn9TUMBj4
         RH5/JjCgqKXsccP5ld5co7JicsqCsvpOskKqGQn8yyQ/PBuoyQc3RV/hqFDc1qKYXmZs
         KeOxdnLuRxbHxC8/Cple+zW+/yTGYdmFv8L1PrLDYnpQYVsnR2dWkYHTEfu1gfQmGoQ+
         N1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+6qpEF7FerlNezj1zDE8a3yg+4UnysbIHm+GwH3GYs=;
        fh=tUQh+cDt9fnmMjjBcop3mnX55a40zZA2JggFMDLPF+c=;
        b=b9O0OPnj4c22rw2WoajeQlvjhYYXvBNQhFZvT6kIzH7iXndAsq6OFVRp6SuXVFE6Jh
         +dgaz+IEMDJkJ6GHHhOe86KXKZnPgQLpnZ9pHQkJQ3Fzqb7j3JSAQYXT3jNpb5dW7l0h
         Ykz0DB7Z7IKc3BCNG/E/qYQigehzMvB+OXpMx1T7b68i3kJgTIZWIp2ldHPwkwryrWxn
         bfb/82eFrYV7PcUJVeiSF5wQVwfq1fUgCKKvH3sIjtl3SYXH8QaSFIvPKp00+zDoOar/
         IidwSCprLn426d8NZIkdVmt1Ch1PeQrO5UVS12/pf6gqq6/8A8ma+EpqTNxc0Zb3wiCG
         KB1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785169396; x=1785774196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+6qpEF7FerlNezj1zDE8a3yg+4UnysbIHm+GwH3GYs=;
        b=TvHAtR5IIAhyFI1x7YJCPToCpKGvtKpyMm2ug8hXTC8LlwK0TTV1jNXWc4FV80yE4O
         jnLGh/rhL6IlCx3yYBdMv4C79nnAaqSL5+OWl6iPnQuzcsAlqRPPdwM60hmh9icRPX0c
         Ueyx4JSA4HVTHnyE2CojeGuL1gnut70ukzmNZLmkdyVPDbFLVTrgC1jLlkPMKSMpchNK
         BDqTV5UpNqNEYRzM4dwgeCN+JUML+oMBt7aXt+qoJW5zGk5cicYLz7wjdP3RXZDCKXvo
         zBfex+ETOebi/9+XdBe5hAfDIBVe0A4Zz/TLor+R5dYLEOGplBn/ygaOI75HX2gfBmDf
         YdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169396; x=1785774196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+6qpEF7FerlNezj1zDE8a3yg+4UnysbIHm+GwH3GYs=;
        b=dvmt7VQUtR1BeW35fecSJR9RoytIgz7z7vz5FNovNURH1meOOgxIQ6jNQTh9w2WVK9
         xoQ/UpRVjXnS8+UQuqxSGPZahHDQEL0NCtZ06ShbtlQUKdxBUULV38MbCj/gMwgIZt9i
         r8Dg2yNrlbiin3ImMsg8qdz1GgzO7H39VJIQunbDYKOGH/az1Lr9jH5yD58yIBtvDSLo
         g1OHzQOLmAItQidMfDQppFmclXAGlRvpuQ8YP2Prb+YfNL1+aqOEFhlOYGWbzrv0QteR
         g+O7GtTtIYPq/5gMDKcpbsNpFG6Q0eEWFU8Dx4pnfhImpcnGnWv4hKeQlAUYQQCGsNSH
         UlTQ==
X-Gm-Message-State: AOJu0Yy5iaCT5Y2zQ8nZAAG+2Jye747NHSzqnAEdIhQX4lWaSR2V4/aA
	+IsqU2KqSc165IqHhT9FiUR5rJ1liJ1x4XvZ2chhjva6260JZh17clhZNbX3fH/zk1SM+IP5p/o
	7/tsMBQC+p0idVE7wNPQ8yYy80Cv5GPfjWndfD+k9
X-Gm-Gg: AR+sD13wfL9rXD7Hl7rROPIKzkrJeV0/VtJRQswrOZAN4Y1EGwaUhfcEoxIktgos15G
	Cw/avFSWcCIjXLVgj2ly2+sDTfMHFGR8vsBnVgntD5ucvdjGuHn9Lghd696maaWehDx+aJX9FEj
	k4fxMYjcx9T2yNYO8OtGEMF4DLNyGeEtpblKu4SCIoGO2Mmgsvxj4JrcNbCoIauAnYagyyxabdS
	5pfV+K1jH+hr8F/rq58KEPghQLkOiCjP9NcHLOINJkLYLSDWT1MdWCEEyEGQ0xGvfgMy1RALFGt
	1EYOwX6umSljiwR8DjDaroqWaFuejfUXT7qOrTKYLnSV5DN1ggx3w9nc8xGPNZvPr90VV5xa
X-Received: by 2002:a05:622a:6094:b0:51c:c6c:9d65 with SMTP id
 d75a77b69052e-529d17183a2mr2551161cf.1.1785169395691; Mon, 27 Jul 2026
 09:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727153936.28944-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260727153936.28944-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Jul 2026 18:23:04 +0200
X-Gm-Features: AUfX_myp0M31i5POJqgwIBmicFeDvDah0ZwNODRaGRtohglf96SONtod1CL6a4Q
Message-ID: <CANn89i+g1sjqLFCK=Ro3_rGobUAVnzc37JG8_UCLjoW4EOS=cw@mail.gmail.com>
Subject: Re: [PATCH net] inet_diag: make bytecode audit O(n) to prevent CPU DoS
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:39=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> inet_diag: make bytecode audit O(n) to prevent CPU DoS
>
> inet_diag_bc_audit() validates the user-supplied INET_DIAG_REQ_BYTECODE
> filter of a SOCK_DIAG dump request.  It runs synchronously in the sender'=
s
> sendmsg() at dump start, before any socket is iterated.
>
> The audit's outer loop walks one opcode per iteration following the
> yes-chain, and for every non-NOP opcode whose 'no' branch stays inside th=
e
> buffer it calls valid_cc(bytecode, bytecode_len, len - op->no).  valid_cc=
()
> re-walks the bytecode from offset 0 following yes-jumps until it reaches
> the target offset.  This is O(n) per opcode, nested inside the O(n) outer
> loop, making the whole audit O(n^2) in the bytecode length.
>
> NETLINK_SOCK_DIAG is reachable by unprivileged users (diag_nlsk is create=
d
> with NL_CFG_F_NONROOT_RECV, the SOCK_DIAG_BY_FAMILY dump path has no
> capability gate, and netlink_sendmsg skips the NL_CFG_F_NONROOT_SEND chec=
k
> when dst_portid =3D=3D 0 && dst_group =3D=3D 0).  The bytecode length is =
bounded
> only by the u16 nla_len cap (~64 KB), so a local unprivileged attacker ca=
n
> submit a ~64 KB bytecode of JMP ops {yes=3D4, no=3D4} that passes every
> validation check, is accepted, and forces ~n^2/2 (~1.3e8) inner iteration=
s
> per request, pinning a CPU for hundreds of milliseconds; concurrent
> requests pin all CPUs.  The burn happens at dump start, so it occurs even
> when zero sockets match.
>
> Replace the repeated from-start re-walk with a single-pass bitmap
> reachability check that preserves the exact semantics of valid_cc().
> Allocate one bit per 4-byte slot: when an opcode's 'no' branch targets an
> offset strictly inside the buffer (op->no < len), set the bit for that
> target; when the yes-chain later arrives at an offset, clear its bit
> (proving it is a reachable opcode boundary).  After the walk, any bit sti=
ll
> set marks a 'no' target the yes-chain never lands on -- i.e. it points
> mid-opcode or at an unreachable op -- which is exactly the condition
> valid_cc() rejected, so the audit returns -EINVAL.  Each opcode now does
> O(1) bitmap work, making the audit O(n).

Say no to kernel bloat.

If a use wants to eat cpu cycles, I see no reason to be nice.

We have generic ways to deal with this nowadays.

grep PREEMPT .config
