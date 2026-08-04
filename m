Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654348A2A1
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865852; cv=pass; b=kjsiHfMKPpr/iS95NQPIsu8dLt2Ib5QGWsyTHX8wZWnWurKLpb33QkaOs2W0gmtbWupKMnYhpFDiVg6ECrFRjoBKfp6ekwb5XZOjfrdW6Fa0Yw8r39CaD3xFdk5iH7i7tjnDoTsdy1cFYbGY3bCpbgipF0FsTYr6PTSavHNV84s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865852; c=relaxed/simple;
	bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riEAhKNLXFbnjpCJQoZ18hq/wIwiv+1+sqSREQSwOMhDBN8t8+4OMw99qQUMMFcbmGbHCayQQ62knE5bjoAsm4n3yzlvedwQZCuRQKG1KkTEddrYeDVq5TZOfXP3yjKqa9Gyu0dNJMLu/5YOQcerTIUuSULk0RSVIWGcE+9J2Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WP6Qbi+4; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WP6Qbi+4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so45635a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865843; cv=none;
        d=google.com; s=arc-20260327;
        b=shhiSLZomwvSe/e4N4WkA8671MOHKc5oMKA2N6jNnFVn62ewDTEjPSWfQOe2nHzpnl
         U+aGkOlrrx93OC9Y8DAhsAsW6bT1zCCVW6BBwKONg/vnfdfbRXI+E7l5UOaVqGeMvKyg
         kHxloJkEU3sPBRKJIOiVmTlf/OKTBgJ+lRUlwdV3avurDOvNYPQRM0SHQQKgLKsiPsYe
         I4IdFNtNvLp5Jl5XWhhpE1Yie4EIfwfuhk7HjTkZkn54CBMOtbs9mRLRvACax9BtMM+n
         02jPgQQWFKkp387xptPkUfdZoAE4iSkBwfHzGSBpkRDwWwhPG9MW67opebAtLiVfqwp6
         P46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
        fh=9zkq0CKipJ8H19Jz1PbjT+3DV34OUZXFrTalfZr0DAw=;
        b=QkL8lVq0v84nKMnhMnXB/Tkp4Fh5JINcnN3GruYu8+nEBENNp46ogyCtelBEquvaFE
         RbxgIxU91HwYeQfm+xddTAiHqNIF1hR8Q7EFqpL1DiWxWUuHfAxRvnx3SuyfTRyAj2oR
         9G9VlETIbJBGhdQdoBRSc7eFh1dFkd2CCZefFVV+ZAUV3C/v+mdjxKJgnYmvnRKp9PeM
         TU8vRwqJg4MiJjSGQZFEVG6y46xXJKF+e0OtZ335+A0W0AL+bkgPjUHYdVM2vwHkkMJb
         QLP0zStD2yRbjCi4ikRphfikHWil4k9xRYrB6UKlFxlh2EIRlzGKDFwGdS1zSYtQdNyC
         8NIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785865843; x=1786470643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
        b=WP6Qbi+4FiXr0AGfHsHJcun3ykEqeDDKqZUz0V0sSU5RRdvukB2Hz6Nx7xJcx1srMZ
         AaVlcH3LDa8uvcK+T/nG3ZsXdrY5l8R8vopI1lYtYA+EOmLvAyJiesrHP0d+TbVdxwQV
         NYnk/J4zbXeJZkCcoJpatD9LmZEFY8mk3rpZ6U9AuphERRmJjGLE7jWS3inSXmvTBwK+
         wjHHh9NiL7HQU+zyY8qOaNtkyR/K9SoEh+9y+MIByDmpC4VvPg2YO0SAybXNqJoZZU0R
         jjZabjNvvXT6PxU6PAPWpaDuQHme5AfRWd236EnrHFr45qgTR0TcPHaZ6z++Tjy4al2T
         8TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865843; x=1786470643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
        b=q92eDxYVJBldwKq86kABJ2b20aARQhCy0f7FuclbiViez5fn1BVGZ+YzBty1wOyM0N
         r0q+HKTCWTkjToAVHaM07gK32mBkcr/PjqAC0xuELnjhQgHeYWibooOGFJpb25FznoXQ
         TFvK41bWmV4/wVK6DXWEG5doY5WSzVOtDhfUUiM3rzz69tkvHuMYfUSSh/nxGRPBiE+l
         kX70tdYSWLDUyZkAXUu/ohk2MuPGh+NUoCnNM/osHZjmxAo6Gd00tLjUHaXIyEVmTCTB
         ip+8wMNhOCvSfT3JZ7pk5WRUE7G2/Lcv8SZEFKwhrf+J8Kxuo1hZphNykctRGutK3CPf
         LwBA==
X-Forwarded-Encrypted: i=1; AHgh+RqyKDSk06fKLhgsvADJZHA9XZOL4te9dWBxMJXaPjuO2XliaWLYdf3WkuS+/G3CX1rsvqAoUZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8BEL0Rku2yNbi23ouVWCm3zlJn2Q8eOeaHsPTAnLF7SfYEoC
	yZqgQ/qFiZfQvlHYIhlSfXoa4PeLpUG7rGsfSkfiEWuaVt5l+JAUKPfIGwrF/MPm+viNqSYEYup
	ZLEatLfZ7SoE83oiJ2oBO20e6LUiMeN4UuEu+MY6B
X-Gm-Gg: AR+sD13z55xxuCoCUD52XC79c2n+j1wzR9hFXpsY0QRI+AR+n+vHE0Xaugce1cBQdJt
	l8DAFUxH2MLpYsPHhb86StakfUoj89qiBmpH2+OCZfmuZjqUsvKk/Vj+WgpZhzqfZTgXwtTl24x
	h1TnY7bxVdXyspe7j0S0c4HQuTo+Bpbld87twyTMXoz0y/OEh55iIOkUQqzGsBLt+SgzAzOM4zR
	1PlG6gcoWQDFQJcIe/BHY5qd0CeKg1gQ4JPcxtjTzXN6R5WabOoxndqkSb5Ik5CNf/3pjm+BokV
	VIULi2EumP5+tt9BX+0AnaKhdiWNtK0wOVsGHuo7sEo2yI0UWeF2ubZosKcb0Z1tkbdZaap2I01
	LvkQJoFTJyvUtLLqxDe07J2dAmUIate63X5YyWvhdZVI9GKOQOI3btvF9e7u1qJ8l8LX3bEp6cZ
	ZyWiOqrHa4Az99rPcq3BGl/w==
X-Received: by 2002:a05:6a20:da12:b0:3b4:75c0:3ec0 with SMTP id
 adf61e73a8af0-3cb85ea6f79mr547484637.30.1785865842460; Tue, 04 Aug 2026
 10:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785823138.git.rakukuip@gmail.com> <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
In-Reply-To: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:50:31 -0700
X-Gm-Features: AUfX_mzr88BizKCiqpMcqwp6xAE5qqUYy8SkO6a6S0U9m0_75sI1TYtqbRNzRI0
Message-ID: <CAAVpQUCg12BzowmXZuY5Agz1PCSdT+tCrqSpkNMfkkvDJv-KWQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
To: Ren Wei <enjou1224z@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lmb@cloudflare.com, 
	ppenkov@google.com, vega@nebusec.ai, rakukuip@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:29=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Luxiao Xu <rakukuip@gmail.com>
>
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
> 'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they acce=
ss
> sk->sk_protocol without validating whether 'sk' represents a full socket.
>
> When a BPF program passes a mini-socket (such as struct request_sock or
> struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
> is located beyond the memory boundary allocated for mini-sockets.
> Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
> kernel read.
>
> Fix this issue by checking sk->sk_state !=3D TCP_LISTEN before inspecting
> sk->sk_protocol in both bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie=
.
> Since mini-sockets are never in the TCP_LISTEN state, the condition
> short-circuits and prevents dereferencing fullsock-specific fields.
>
> Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
> Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
