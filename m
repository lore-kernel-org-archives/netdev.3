Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF991399892
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390415; cv=pass; b=r4Agje+YDUo5klgXJiN2nM7AmvB694+n5it5EmbHbGB0vE7Ji7Dueo/fRwpdThHPh6klMMm+srS0a0cof5fMdpYqtzQkNmOiuTtRpMmt3Dmf/9eFdTk6nRDqgg7ujG/qj3LO8UDLnwPIw76TDwXe1Vl5dYjdgQc+NygmPdyDSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390415; c=relaxed/simple;
	bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXGKdOzTXflREOTgaCulANEBlTDLdaYQ5Ze6uWw6beuL39ZmGBkZVMwTT5xTBqZDGe4V0aDKj+WBG6g1AR8aEdXmTy1SAa7sUuD+VQNiYcLdyJb6Af7W7VSt+/eBmIRHy86SfSkUqpEAReDKtSDKefjjgCTDL1KNgBx7O1scO4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XitNxZTJ; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XitNxZTJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d53197d8b5so15249525ad.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390413; cv=none;
        d=google.com; s=arc-20260327;
        b=THVdjjnbEvhkwCN+sL+sPXXphzM56kBk+55sMX9/IQKd5GtAHgtel5fsf7mWc3fSlA
         C8RIw1O6ec0hj+/kb+czXYB8NgvLno/ZFONb77A/bn+HqI02XaqR+KFsqxYYfdgKbDdh
         29IPiIbOGUTCZ+ps34E2YBl7adxW25LKz0lQz8vC8Uv2qzhRD3tjRziu4ebglrdXgGDH
         NegfCogoL1lj+eIPANmsOQclPav/8Gi9FSdPFkRvsrFHs8ckTcWzAKmRgTY8UeDiA38o
         xYVCQfRu1E135kRMA2QVy+6eXN2u3Yd1v8mosTpkjh1r3UlM1ELiGehPZoULASc5WKd7
         qoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
        fh=eNv6SN7aJHtu71XfbTJ/7JgvYKz0BshPcb52AGXmQ44=;
        b=rCoW+4tscxjQBObVjgmOb8Q13oEkbUJHWyO7Knhu49HjRr7XhlhlmHuS8DegVmrZNV
         vxEJ3DZ+viXkqr4sfApOkQ4KBU3zyXRFoGeuBWCoAy6K1fIbXdsCItMOp16BwWGy3FME
         5fat+8dCYlAqIYdMb94Opa0rkD60jtqN/dcCnOYi8MrDlkE3L9mM8w/shEvATrcHqHdM
         SjyGyawtm1zHPln3w2OTGT8XX0MLy/a0p9vuM0d4NE48UQx+XK0pMuDpTpfJ56IZ+C2R
         fTjlOJYwqk18T84dHPnuLBMXYkuYOyePEzTQSD/eCW7KnGwt2OXzhCFMrGghXtJywKYf
         zX3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390413; x=1788995213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
        b=XitNxZTJ09uvzoUwOzTftYhHODsEy6nLHo46uZbaIONoDW/z8eo5dJmoVuw1Wv7VXO
         JikoTn+0Xwwed0w9GgbXl4YipeoTlB/mZ2IFYGbPqgUpBzNWpJUweZOjWQ7pWus8rq+c
         YQYn2ltbPZkQ7wR6P4A8F7Q2NLAuRmhwJrTm+d4xmC1EEenqOld9yaxGOFmO3f5SmLjI
         52L08G1/pdooVZ++CucMGIj3vUHptDpZUHKyxPPs3c76/7EfmMNRmEY5iqkmg3PAN5xn
         ybPJD/DwG9Bb+2QxC151wb7nOiq/jZMivMW4/VmpxbV6Ls1GxjhuFowL4jTxG7hLxhVr
         yD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390413; x=1788995213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
        b=WBpajyWK4WKf6Is5tUwHXFzlRPDJq4j1Z9qYxZTuZGg0hPLQJ8wy0qX6Y63sNvlAdJ
         eGdWBuesX54Turwh0BHw3ouiBquUph5ae6waw3yYy6QAqiMnyEMWN+powORfAUCgyyEW
         1j6IKiLo84uhE/W8FKIdZ/ODR5OFYKYgN0NPdQSHPwD9VNlJXaGekceYdKdRfWbeAU1v
         yJ4iqmdeirU6cP4gkT1nB4+f80l/d72cXhroUi5MfMYjE3zPLli7NunFaMEIPzsRJ86l
         TYmqCWklKGpShFMp3jNH7yJVu7MqYQL9l65WE+IdZ9YZZhAHmzllXSuzJ1kxff57TdDH
         htXw==
X-Forwarded-Encrypted: i=1; AKwUvBwiU1NgNzx08Jhpgv6EU4UDl+8F1RN0XfmMIXbcyu2OrkQ000PB5+PtIJz5iPjZFIfXUdheN9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mtu5MsYZd8dQxx5OfY1oflFjqBsF+Lf/WcY8rbIE/wxmzKCP4a
	YZSNdxLyTe29dDRsePu4iwNkts0G+1DJ8eFhCdOCMHmaEM5EkQNJ8ChSBb8Kl3cIRa882vRzjGl
	6nmnDXTas2AljGl2mj2CvD00kaNBuRSP2Gd/Fsj6E
X-Gm-Gg: AYBFou0HG6CYf87eDIMJ6v+/5+3vgHBMiyfgtdWlgVwptv1okmlTl5AffWThOf9KdU2
	AJvt3HZ+lTmIaX+fIJmMhampOs4QP6CrCG7Lx/spU5753xGwPZ5XdnP6GRmFAS/U0Ylq9csOxap
	uT7lJ+IHlJ+PAvyc+MAf29TEPcVMP97xYbp8tJOGpEBXrJP3AvP2QJjUowtvGa2sWy19BrLy3rq
	wnGM1wZ8aNG0aFCdf96xVYu+q93nKIqomv6Fn4fdfOetM8ygJGabrZ4nN1q9Cg8PrftumMo8eec
	VM1NNoR8AX+w1Dz30wxnUPtyfwuTEt2K27RsWZbxmdKWKL1GbWncYrDWFQNUHkALyrhWGomC7rZ
	2KaiRgLJaHGOWqSE/z7X+L/16/9jyw/qrbHtVEh8+1E/3/aiG38GL2iQaEIRu0VOixzDFpMkbv/
	sQns9/eMO8MGrJTcuksPHJRz4=
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id
 98e67ed59e1d1-39aee219f45mr11238909a91.17.1788390412505; Wed, 02 Sep 2026
 16:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com>
 <20260902155216.4fa23444@kernel.org> <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
In-Reply-To: <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 16:06:39 -0700
X-Gm-Features: AcwNN1WMA28CGWvKALBaFm1vrr9aTSS6G_YD085NjQpsHnEJcUtVs3PqmfzqfQ4
Message-ID: <CAAVpQUATOCCc0N1jnfy2+tkD_zj1su-a-4+bV6qXOSzR7y_iQQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Sep 2, 2026 at 3:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 2 Sep 2026 11:58:49 -0700 Kuniyuki Iwashima wrote:
> > > > Several BPF socket helpers acquire a socket reference only when
> > > > sk_is_refcounted() =3D=3D true, and release it, independently, by
> > > > re-evaluating sk_is_refcounted() again at the time the release runs=
. TCP
> > > > connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established so=
cket.
> > >
> > > Due to several bug reports, we are now inclined to forbid the
> > > buggy transformation.
> > > https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguRo1=
Z_4FxO=3D02KLmwmQ@mail.gmail.com/
> >
> > Kuniyuki, would you be willing to send a patch to do that?
> > Not sure if anyone else is planning to, I wasn't..
>
> Sure, I'll post one like this with s/synchronize_rcu()/-EINVAL/g
> https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com=
/

and cover IPV6_ADDRFORM.
