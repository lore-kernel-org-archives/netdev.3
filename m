Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B120370D5E
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765509; cv=pass; b=pL/igWHXLtNK+CFQNCsEl3oVNpFGURDTVWlwQ6YKCjLDmAZYHCaaiMHdDcB8MLWb1TUUD8ROjN1++4IA7s1IeZhU4dDtsG7m1cfMrX/MGk3upns+UHlcrVdMgoIfUSv69IRx17lbZyJGUv/2YygOhckFlrxHZ/MKZFydZHHi7Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765509; c=relaxed/simple;
	bh=xvQlLrP9VZeFA4X51ntM8S07ewhUqvCn5cruzlZ0VS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7a5Vtq6hNNlz5fz6WVR5hstWXuIWOgvDek/mfyaPycFhdOgq8XU4rt6DVyPFlLQNQs4EbQnvjgULK/ND4qNSYFya1TqAFPrhK5SbiS2k4oMwSYGe3Z361tscD6OUH/tlOpwG+ETG5HJccv9QfhWSgyzsu+iev77tGII1cRwhZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b68vdhGZ; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b68vdhGZ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0c45c580so6256091cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765497; cv=none;
        d=google.com; s=arc-20260327;
        b=FVqgdGZDRcczo91ji0cW8gEkuPCnqe6KFp2x53zr7miXg40j4+brhcnK0XPzux/Y10
         kqVjUL5CNC/2Ii3Qt+LQEOoc4YWDvin981hV+QLdet2KqNApP8HmLV9McP/15OBBbG/7
         GCyAH5AE2kw4QgJkvjB0inxDIO74ZWduRsE0JOGljob81ZOpjF0BoQ5kTjoDVXB1VU0l
         92TX4wI9anu74l/gVmGN5GKjA8BEIjKnCujzEuwVzHXAuahebeyZOvOvhXoDQN3UoAxC
         ON1P8mpJlQo8ZKhnV2gzOrGJbTsYml5LPu0RDyCLUYeA0FDMOosg5FPYNOZZeApxSx4C
         3HPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        fh=/8fdF1GmWKZgBB6zYkAc9a04s+VrittseB8x4a8MzAg=;
        b=caELvwEdspCrLRwH909mfDdrjs5AxjCu0tj4px+8PZr/LamUU9GIcMWeUfg1Tnlhqr
         14VR+nuB8LBcA7aODKHecmw0i2/ZaGlhbKhEntvQHBkb+heFnQQ0t4YG9CCSgOkBlejO
         LHG8zDnTUPAczvPjBk42UBpuozsjcKAV7Cvuzues17GAge8UtlHMAgOZ8AS6E1ptqdnv
         +3frOKsUVniMxBFIKWdRqyrh6bLBkZVY2Fk1My35qAYXvEPl2a+UONnSCne4qC0+Wwmx
         m6Lhoe/8LaDz20lnzk9rsqguBrNsOhZIndUa53zH8HIJLc39YqgazlGDgn4Hiwf4E/pI
         8j0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765497; x=1788370297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=b68vdhGZgBqiRqH+9o7YVSMh8DtrwpzcwpovG91VcybnYoOwQrpqPiS91LIp0YEKwb
         JB57gPOmCxXA5wrW4ACQdxIk6cgiMRKRxK/BPeb9Z0OzjVEaKZpjJyLytaHkIDNYhjea
         niHSz1iquDjz1vdhnwlE4SM6P9G0YgnvyxWKY0rUvBru4LsvJ5jXLi7D8T2eJnV7ri73
         aM3b/1FWKTekqo+3gmXuc/Cw7xHEfT4ErGKqYqg+lPMyb7pIf7MMWgwA8Mxwr4d2rYPD
         uAsqhht7lAx9tqCUHEGdI4/cgGjoP9Q2Ah/D80KxM6g3wXN4Qaqh6WQR3ujaxU+AS50A
         IaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765497; x=1788370297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=E7kzunaKQYC00pPsfmvOkIPvQGXZafXR3VdvB0Hk7Fmi3ErN0ePadk9q3cRg2gtAaN
         5h1jpqtHqDb7bF9PNAJcfsbq5zRtbrrFOSkR4Tj4rbKDf1LVGXevTfL+AwDaX4Snayzk
         kjcAr2S0XG0o5fTink54uG4NvjxOoaUAsJQAYxER7mC4/ZU3rJDYQ7XzhVxZiPMpjae0
         f/NfwAhubOTj739i1RvO6JTHcE6r5UXhYFS8zk+Kjy/NCEfp3coFsKqCm0CgTN24/h3J
         MoA/chP6dEhcUZ5I7HUmNw7jAO1h5FwNU5YwzMPqZmWthJfwTBDyAGoYmvT8DIsncUF7
         imnw==
X-Forwarded-Encrypted: i=1; AHgh+RqTY7J3weNA0T4pFIjjGkDGRMbX2NQe/PqqlckfLrfJ1iXXbyNPn90qiv2ypOlosthouMKKiOc=@vger.kernel.org
X-Gm-Message-State: AFuF++mlOe7S68dIjptbRLKcccc4iV6W1Ne5teJvEuHXbNUvmNkMQccQ
	tmy+kV0/WxuStKKya16nv9Wh4eBzVbuTi0j0llpjnjqmi36ZwD2FgGeb24xL2Vkj62U6S/wfFKD
	PqISYlB8jA7dTapI1GkNcgiM1w6appD9cRt1fJ4Sf
X-Gm-Gg: AR+sD12lL7ZGVv2ZRwg1RyoBPWHl+5lNH2HGyhmQPZWv2wx2HSKDbGw1SAuSmx427I6
	c8ivDW2DpqrssDOKCK7QMp5aY1+qsRcbDiv4ynIQZ2KTF5ox4BO/Fl04yXl/zO+fOcUjO9lDbcc
	pd6D3bs6hgn4KVodsH3qf+FAiycDXfHVvWzqQVBFxPdxez6y5i5EB7qhM9mLfYx8u2QtIZqkCjj
	JBkhlOadevR2OvmOxpJBDV/VE4k9+Arf8FPckUoBzCaSkTLhGqqxvKBzt1qL9ToErVCHX2OugDJ
	nxuGeS72Z7dhSLaeTZIoCbZXceOaciYfBmlPfhQexC0bYAzSE62IFMT7KELyMeN4pf77+zM+rDQ
	nRL03sXU7lxgh7M87U6Hn9uiYd2fVzfufQwdmiMVKsOqB+h9BRJMe5MTa7uI=
X-Received: by 2002:a05:620a:2584:b0:934:9639:3a4 with SMTP id
 af79cd13be357-93780439e3fmr788607485a.41.1787765495949; Wed, 26 Aug 2026
 10:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-3-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-3-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:31:24 +0200
X-Gm-Features: AcwNN1W2Vlibp4Upi6ckUE2YnF-7NI1e62marZLJ6U_CKljSBV7tC__IgHY39vw
Message-ID: <CANn89iK9NyWmpuE8QM5W_t3MK30GZf_Wgbr+JsUVARnXZBgN6Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>   BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>   Read of size 8 at addr ffff888013701258 by task exploit/149
>    do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
> the icsk_ca_ops pointer.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
