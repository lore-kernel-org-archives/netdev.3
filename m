Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079102;
	b=5RKsmWB5dftYmLwW5t7AVWRwOMWVD/KWhLqmqaRvI7nkhIJ6u8L1gSni2XVkI5OXlOrV
	 MI5Bo6N3F36okUTJmjaXF01Gte37xfaE2zS81srRPG9TSIEDycJz0Bn8uGVnvO/A+dcK3
	 oQwXU/OcxrSEDUPDvpP/Qpj2vyAOjRC1I0tN3mKGC7EWh2HF93kCcSBFegD9i9suS2HiF
	 fbcg/sLugKlcW4dO+Qb/G+A7IEGeJeXjZGNhuSLxnsbm2Dsn0QG8nl3aQDev4LZFA/pow
	 gRfXXoBi91gmZkVoiTbdPkviweOX0d3cjxWvSJpojgkS7f2Fuja3Nz17wWV/M9qfHYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079102;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Vdr4C3PkcbVZsQqqGDmD8tEhG/m1kQL4TeacGRf3vdo=;
	b=SwlO+64rD6/CZZnOELHJtT714m4uCBZHFTF2P8JzNQ4kmjuk0S6ZHNOlpuqG5PQ2R6ca
	 Iezv9UQ/nx+qrDgKfPGaJpWaINRDT/qd+pWYKsclMuNp2FiwuRkwpklJ6g4LTq9MPXGBy
	 rzboNg6zk4UDwYMxdKbTUCncU8eW3BRyJ5H1SwH9woAxKKYDWSYUSHq6vaDbtyZeL6S5E
	 QSmik5AxGQBd4Ra05UDXWrabscSeBnEw0CjVXiM6IPWTFcbWazJKaux2y4Nwn5bifkWCI
	 wATUayopoigLizubYj5k4eif6QsBdDSDTJkFZO6Xq+R4Ep7uOKGEsQjBoUVcIABI6zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyO1L8zA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFA606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyO1L8zA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26EF1F031E3
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079101;
	bh=Vdr4C3PkcbVZsQqqGDmD8tEhG/m1kQL4TeacGRf3vdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kyO1L8zAQpWi9xUkQbRxPY6Jss1nVwpRvCFjx05ldBQvcEb/zrIuYt4szVNe89Qg6
	 zmtRPChFJtOxHgQHxO0VrMSGeuSJGPZYSR+HWAIHDYpTeI8GDqOaSpH+Qd9q1Ycg+/
	 8IHawtMy6hfe0KIhBcFIO+/2URBo27mByOov2euanpvGGSrLp49MuY/009gBHToflQ
	 L35MgGMwd8bCFhVZyFeSoECY2g58JK3/XvqnmLdJ1SXOHTFNuEhHQ/s2UdiNR1ja0v
	 oW5sF54BYPB1cUIAnhxbCb6CZcWBJz2OHIpZH2WXGBEn9QAuU8eKThiRFeeorV0SHg
	 FNGbFIYk9Wxhg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-49429181ce9so2099784fac.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:31:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByhiTk1HcR8LNpOWiFHYue//OPmw7hnvwY9efpbT2k2dEjtdQWl9OJgE3jf4moQAcoRDUcAJcY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJa1p3ue9aiTrRE194M+zFRWdqrBXTrhyfTkq7ZaRdSyeilNkO/
	Mj3c0foolVABDAw4YsiP0o0rscV5WP0XB/MG+PSwuiA5ayEzMR30FIT4Vds2stz3AXcKi1WV8jk
	VCdVwJyX7SMwgvLJSE2uj3uXWzelQV8o=
X-Received: by 2002:a05:6870:82a2:b0:45e:25a9:5455 with SMTP id
 586e51a60fabf-4a83f1cb4e4mr5508785fac.2.1793079101053; Mon, 26 Oct 2026
 22:31:41 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
 <auAv3AoY0FkcXIEr@google.com>
In-Reply-To: <auAv3AoY0FkcXIEr@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 06:31:30 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqu2Az-B1dZnVRJefW-F52ouzLQ5VQ56L3FxSaeXcXGvA@mail.gmail.com>
X-Gm-Features: AclHuK-fAzYz3D12aaK1VJX8HEDAnoy13ILnQawpMb1g_qhckuAXvvyZa-sKNj4
Message-ID: <CAL4Wiiqu2Az-B1dZnVRJefW-F52ouzLQ5VQ56L3FxSaeXcXGvA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] tcp: check congestion control restriction first
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ncardwell@google.com, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, jonathon.reinhart@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 06:00, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Tue, 27 Oct 2026 12:46:49 +0800, Zhiling Zou wrote:
> > tcp_set_default_congestion_control() takes a reference to an algorithm
> > before checking whether a non-init network namespace may select it. A
> > rejected request returns -EPERM without dropping the reference.
> >
> > This affects module-backed algorithms too; BPF is not required. For
> > example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
> > non-init network namespace can repeatedly request it as the default
> > although it is not in tcp_allowed_congestion_control. Each rejected
> > write leaks a module reference. Since module->refcnt is an atomic_t,
> > 2^31 such writes can make it negative; later module_put() calls warn,
> > and rmmod can hit the BUG_ON() in try_release_module_ref().
> >
> > Check the namespace restriction before acquiring the reference, as
> > tcp_set_congestion_control() already does.
> >
> > Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp con=
g to a restricted algo")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
