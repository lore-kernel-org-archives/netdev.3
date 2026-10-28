Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204827;
	b=zn56UM5F1/TZMJ2NfZ95TryC1kXK3v7xfr5+sTU2HyBtYrwxF6AZ4bPle+Z7QloRprH7
	 9zsmnVf/AdZ1NWZsXA8HJBQgCWPUEa5rgHBlUTJxNd4F9ENmeTKv6iOoF0iyF/jFc4L4N
	 yIAkER6Dg4FfH7dE/18UADwooDJJzrN5CLkf4tCiuzU8uXqVPQPJ5DPCigu2DB6EYAYwF
	 anyTRksVg3sHfdJBZ3JfsT1BzM7+krgGfjPyZqYM9aL6G5xMkX7I1Hrsv+EppuerV/OcX
	 b5ENxB1ByqUQF1TJRcq5zGftFBXoZIkauvnULgULBEUd4myRAYU6hyeKQIkSnYKOQVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
	b=TwLOTAfFK1UGh0sEpg6FufaMF3GEC8KDV/HrEa+NMSaYZiiHRn7opCB+B17T7pBjpHuK
	 K37p8KdGpirL5dyHekyKmWDmUMiVs77m8eqxOUgg6pRH80hztFr4Mc4HaatNY7gh4dixl
	 G003Q7a9ef8PxiEsl0KgtA9rWbApgyP0WXjckD1xuceIf7mHykqlDAdGhUgumtAWwhHaP
	 RUvG8GkpNGZMpqL+P8gl8GACcY/claJG/AYT4vJ0YvcKM/idFSlszj+7hdQk7ZxCfBMmC
	 AC9xuQI/nGcVPD5vwVJQqetDE5QiyjkKmtK6MAbhodr++HRF25pKjT7I3FbRPLlmalA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UaioioWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC9606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UaioioWE
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so12059a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793204826; cv=none;
        d=google.com; s=arc-20260327;
        b=dqb/jlEBHASl7gIq65WadATBIvZtUWc1CXUO3pt9SrG3Fd2ARvqiOEACknoxwyIplo
         tlJN21EKTzT51vYZJ4HXYpYCOyheSQahlmLd72k23zDIeKNUBQuVU2CChGNttErSLLyW
         J6u+guv73j3SUpQaJLjxV04V8dRI6q5C+aX7M6ZmV08MrhTtxOPFxRa899qCF0KjSjB+
         PxCMiYYLtUJAP7ykQJYGu+0vCO0cNxn/D+SZuaeFh7xK1/CrkLCVrANMhPxwalQsUEkF
         WA3d6eRmI/TscNPBKJVHy7DRVN1ebGC8ut+K3WPM1e267OrUto10F8NFhTTWDUEPeYY+
         djDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
        fh=wnpYfeWhwZjDgU3DDPiu+wqYEL+/AfqFiorl/tYMsdc=;
        b=cUwT6+lqmhm7+IE19lOZEkMyY8LmpdhqzP1+jYhQZoqBRRjWzMtBc1SHt3So+wlSfa
         nNOL41talpC9d1aFZUlMAsRKrBAmuxq3Bk+CTSyR6NRfiF320LK8IJAA96mln0dFAWV7
         hvNhb5+JiMC0y2gQinnvMPxO7iaVIQLicxgg2L6X4PbsikNToYDj5dsFM5cVlCkCbgoa
         QY4UPUyTxzgk64dMe5wczn6OPqVkyHN/wkEDL2IhJmbjMgUAM8t8UAbFWD16NO2RVPdH
         tSy+69aTPK5KU9KpRLlCAR0GqXWF0wsnaa0KRWRCeFJ0q5yD4Hu1feuWON6Deq9eKsDw
         Y9RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793204826; x=1793809626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
        b=UaioioWEjjYNGTIHp8DvJGB3OxcgRAv+ZpIBH/xBuVGgEzpDmH046N/W1+1owmEp1l
         Xe+xnwQvWD7o2XcXq5ngdP8NQUShP4+/jcZlnso96hJc9Oh8RooarJBi1GbUA8pbkNj5
         jJtWGdgKxUuDccy3AvmoKspzxAkMs6Ezh1ThYC6mItK5S4p4/qJwuqQ3BhrFvWxnAncY
         VlcViopPRkE8rCViTl9PsyuNxINotVfn3WibDujgKKoQC+MR/3gOdWF54jn5OFIV+TCN
         sLnL6i15siEMlYcsOzROIFm6yILBZTwGAle3wjgeeG7VrwDoLJycipor4MSUxGl4IHiz
         IUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204826; x=1793809626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
        b=x0w9H0RraY4XT1KxWXY7T5W3AzhlR0QlgE+nEGu1vfn8IyHvPqqZf/zk222ZScuUEp
         7/t4ab1ZYKCYle2FVE/silF2G8PeOQRWj/R09o6wrLKmatJz87K638VzDbNObKsjj8KK
         P/PS0L/6l33HdKMGKMj3QEFWn68f5Wo6qBeiB0jQo1zznPvUnAlEfwSs4pLWF2GWAvFK
         XJGKfCwSFFUZ5vQBRRMRUR5T2skzwBvkD/7zFA5WB7kPwKUuTz/OVUJ9wFKwI4HuqgoA
         TeK9TXqD7fGYFvdt+/XHIDTYSIvDvkypECpc0KEV7E/zblek2ZQzLLgvxrSXuDLyN/Fr
         QRCg==
X-Forwarded-Encrypted: i=1; AKwUvBzU3+6YOznZ8G2kxwfJQD0YeoUXSXZJ4Pp8Wh+OEgSuantQ6S47VbfbdQqufUrOcC3Q7PKlaL4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfFfKamGg5GLlGg2xECs+AuS0EhnyLC5RWqGFwLM1c2q9BfR3r
	ZYgLn3M9bGhceG4fR2/V65D7PYF2iroCbZHrJFqJxYkTN7NZXPgu2uLj8Vg8ogGBqHubO0FcIXE
	fddwweRy4qoENEhlVCTdalRt3fJZWJhZw9eesaWLg
X-Gm-Gg: AYBFou3vODpuXMQAEQzH1syzcLQPsR7JTOalL0AH/9H65e0Klqmb15boC6UNQC3BkLQ
	oAFqA3fYJriBR9weZRlHyyvppUlCvTyz9mZPpQVDdYijpvZi0veuTu2TFggM4C/eyzV2FND1wL6
	tHUfUNNKzFSRh1VffP9iLBIooMglaUAfvm8mz4di/gB1LOwZe+dGrAtf7D6NYOAxEk6rmczGJwn
	V7BLhS4EKeu5QODLZuz9gIWkh6RDbvzjLbYHHiSsAZCiYJ6cMSAyekgVMxtvhSEiF8ueJE7+gFZ
	uxxMl6ZWjMxDOEFlm8VrcjQSOgRXLK1u8dDuc+SqVjcuSK+fFTfKN7TON29xIoMWzRXjw50JhdH
	1l4sVJvzZRFnY5yUOWe6d2grjfFAFe8tqi2U5DgwPEPLD/cPnf3y+W93JR4DUETJdkQzDc9RWj1
	LQsoWR3GUmGl0DS7KvmiclyuvdgY0=
X-Received: by 2002:a05:6402:c20d:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b49c12bda5mr82863a12.15.1793204825348; Wed, 28 Oct 2026
 09:27:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028160226.2170244-1-edumazet@kernel.org>
In-Reply-To: <20261028160226.2170244-1-edumazet@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 28 Oct 2026 12:26:45 -0400
X-Gm-Features: AclHuK_y2lwU2dfxPHC5zpefWOEB9ROEQsLXt441lxysDlYZ1eijDbr_ZkGEi3E
Message-ID: <CADVnQy=Yy=3BPdxNesgfPUtpHT+R7nodcz39a3SCW4e+WcnwhQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix reordering addition overflow in MTU probing
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Ren Wei <n05ec@lzu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> From: Kyle Zeng <kylebot@openai.com>
>
> Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
> MTU probe sizes") widened size_needed and the MSS multiplication, but
> tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
> an unrestricted u32, and tcp_init_metrics() can install U32_MAX.
>
> In that case the extra-data requirement becomes zero. A write queue
> with probe_size - 1 data bytes and a FIN satisfies the sequence-space
> check. The coalescing walk can pass the queue head to
> tcp_skb_can_collapse(), and tcp_clone_payload() can produce an skb
> whose advertised payload exceeds the data in its fragments. Local
> delivery followed by TCP_ZEROCOPY_RECEIVE can then walk beyond the
> fragment array. KASAN reports a slab-out-of-bounds read in
> can_map_frag().
>
> Cast reordering before incrementing it so the arithmetic handles the
> entire u32 metric range. For U32_MAX, the required size exceeds the
> 32-bit queue and window limits, so the existing checks skip the probe.
> The calculation is unchanged for all other reordering values.
>
> Fixes: efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and M=
TU probe sizes")
> Cc: stable@vger.kernel.org
> Cc: Wyatt Feng <bronzed_45_vested@icloud.com>
> Cc: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index c8865205cdc8bacea4e37f67eb60730cb17294aa..39803b874c3373ca635454690=
a445ba072c05a62 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2720,7 +2720,7 @@ static int tcp_mtu_probe(struct sock *sk)
>         mss_now =3D tcp_current_mss(sk);
>         probe_size =3D tcp_mtu_to_mss(sk, (icsk->icsk_mtup.search_high +
>                                     icsk->icsk_mtup.search_low) >> 1);
> -       size_needed =3D probe_size + (tp->reordering + 1) * (u64)tp->mss_=
cache;
> +       size_needed =3D probe_size + ((u64)tp->reordering + 1) * tp->mss_=
cache;
>         interval =3D icsk->icsk_mtup.search_high - icsk->icsk_mtup.search=
_low;
>         /* When misfortune happens, we are reprobing actively,
>          * and then reprobe timer has expired. We stick with current
> --

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks Kyle and Eric!

neal

ps: It also looks good to the frontier LLM I checked with.
