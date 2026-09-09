Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70463815CF
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939046; cv=pass; b=iApbE2QLviMA9FKhKP7x3lm4RYKjownFNo3mkDc4XEeUThlieZQX4bUFI2cWSF/+QTvmRJ0YS8AyymENntQ8YkCLjqeQf5eZCdL854tOsaiesgWTN32iiDXqvWsSxHVvNP09oWDHPdVOKGpCnuPu73wGkl8KU2mvR7vN727W7bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939046; c=relaxed/simple;
	bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOAva1jPMKmyHP9rB010q7geuDukj8kQiiXAECf9W/G6ea1VfWwTy2d7q9lB4OIPsdaRPIXoo11vz9yWaUj6NFFrBVUl4HOV+V9uheOns6o8640eS7QFvEvdHl/ZGek4knYvKzVd49yUjEEHGnUmXB2lzEuxFsXaA0/tyUia7N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eCu2AqsY; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eCu2AqsY"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a2e985245eso38708241fa.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 00:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788939036; cv=none;
        d=google.com; s=arc-20260327;
        b=Qm0hPINcHt+Zfk4YJnhIKsGV1HvJ6mAInVetZJxQVC0CD6/FTLUxNPDRQpx1yW5VBw
         9ve3gK2mQSsuSY4M1tVDQfLQsoeNE9Z0YpUhRDTspwZrF+PPWVJfqblaDMxGSsEGucyK
         ium8l4A+wr7tmr72gL6yjo5f/BDM6b1KB5YbGcj6jdqLwr23QK1HRIHhCoC10yfpU8n7
         2SKMBnnLMPXbjFw8Y4GFi5CfYZy7Z5U4jUGVh2Lot0+saLQ1r4SafUtQ24Wk+rOnJeJm
         R7lEhSqH9DB3seCKMGDlkCeH7r6joN1pZ/VdPat9rdxXP95SABmtBjYTbuRIfozDjAqy
         6OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
        fh=lv8kMQz8O+gQ3nqHDoQZliX12miycid/0FLm+oYcUWs=;
        b=PoxjVp3kl3MERr+iSY4K3DN24roZSnLOW+5Sx5orLLLpuXXunwa7GYJ9smGHZPnZVD
         82c1RO+Jib0jC90rk3mSLdbl2vjq7kOr6CEKOfMQ88KARcCqDNkPdf1NreP00eaFbhb6
         GbN46hXzxJRVQbCOk3k4BP7WwOoxqfpfg0ZOqCnZmxZc4s+bUY4O39BzKGg9OJZmjwfv
         OBqzNyC12pivzGzQbqGdicBkPj3Wt9By1ah7tWzNn6z+zakyBbFZUUCEUY3rddd3aDNF
         PMdw98COb+e9eRwZJgDswmxp4BcueIse/NJlyyqz3lYIKEcMSUTQXfJqy+d4YSNrlwkC
         gUSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788939036; x=1789543836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
        b=eCu2AqsYjrV0XGwmJJOKres5OlXvJDy+m1zvLIJQT+pWHPtC7dbOc3QSwGdye6VkrV
         2QJv6XOcz/co0uMdQwMajykM8FmdUcfbOMYBwB8d7KBN6nd9ivt+oyQf6Gac0J44DNSQ
         WOiFNtjglS5uxM097OwcvQ3jy91/RcQCMjfpqZiNXFCaYYnjaAsGpBILChg72WyeOxnA
         Rx48G+tw1orswanXUOXryaKOo1sDMXXFk+Jdjgmt8X1lgcabkkTF/03+6mXmWSNYNHSx
         ALCEYkhU8NJlcmgZ3BNPHfRbR2rchhV++hr71hC8FyyP1b4KMm/8IH/rVLNAUGnFoZV8
         03Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939036; x=1789543836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
        b=VML2Zr5WyeByKIsivACPMgLFFA6Mjbo+NUIJp+kQlgLelZ+gsZVWnVNEXSFrHDXL2S
         eRr4RiROGLm+7eY/fk6d6l59+Dn8YapAN3xyiwY2WXAnN81kGNER2pLLGeR077nS/dZZ
         /Mfe3aYgPoMnuDCgnen3PyQEIbNK1sZuimIGYq3plAZ4dIfBJ1vuK7S2PjnsC/JI5HA3
         sj6vVLU+YjddSeqsaIZo3noTD87IAFCTXI9XW5ErCR/jgm8WK8/SXvqc7bXCQIpKQQi2
         7QVvDGF7SV6Cw0Fgs4IAMsBCr2SRZl8x3Fo2oGj9TqYOECh1jl0UYx2RaJSeENntmfPF
         M96g==
X-Gm-Message-State: AFuF++mLesMCuV201Gj7txY8gdI1ZzdQfaADoXK856iL1moGxwU+cHff
	2f2HVMAmOt7lRezd2GfbyXfnxh4caXGMCNBZxWBM+DHpeakDlda+tDiHloh05d7Yt6yH8gepFBh
	lKWb1DLtSW2OCMbUimwYBt9wWOH7MAK2Qydij80m1wQA=
X-Gm-Gg: AYBFou3V88ituiF8G/4aMuUiBR5DN+FbADf6rDSA6Ueg4Vmxl8QhdPsXnuxSs4g15+q
	prQnEUGDmA28rNXc/uUL65k7rCs8tGLSvlRHbbwEgqaflHAESC80bzlcbR9NS3/8cjHYgEr7C3c
	pS++DL/ymFFYLnVWAXtI2yaAQumh01/lAzLZg6ssY8TK3T/Khjjpk2e69y0YAgtySXfBBeYJEn0
	j9GBw1z8Gejto/r10gUZt6wpOBPt5Qpf5OjEIVXBRr+vbpVOKr6UYUSdwXt9d/Wd6wlXnJCWt+0
	wyAU501tenv5S3l8DhBJtHmNegCsXOqoJJRjUJJ6eW9IYqAimy5uTZa1jaWGjpcChO80onEb8Gv
	ULEiyb1mc0hKBagbyiJLq
X-Received: by 2002:a05:651c:a385:20b0:3a3:74b9:8a7b with SMTP id
 38308e7fff4ca-3a374b98b05mr21405141fa.20.1788939036180; Wed, 09 Sep 2026
 00:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788784801.git.zihanx@nebusec.ai> <050b58f7fc6b45da0fb12768ebb62d18fa46133d.1788784801.git.zihanx@nebusec.ai>
 <20260909071000.GA1211770@shredder>
In-Reply-To: <20260909071000.GA1211770@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 9 Sep 2026 15:30:24 +0800
X-Gm-Features: AcwNN1V4-uX6lZ4IPXnkjG6wL-P5CzMbMzO8E1lpdYuY4e4s3sGr7gx-JsToyKA
Message-ID: <CAANe3eQA-eGdUdSZaFNpcuibnqTxNxmBfckoaH8fP5m4y7YuHQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ipmr: account multicast table and route memory
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:10=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Tue, Sep 08, 2026 at 11:58:39AM +0000, Zihan Xi wrote:
> > A netadmin in a user+net namespace can create many IPv4 and IPv6
> > multicast routing tables with MRT_TABLE and MRT6_TABLE. Each unseen
> > id allocates an mr_table via the shared mr_table_alloc(), links it
> > into the per-net list, and leaves it until netns teardown. Those
> > objects were not charged to memcg, so the host unreclaimable slab
> > grows with the table count.
> >
> > Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
> > IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
> > handling of IP addresses, routes and alternate interface names.
> >
> > Unresolved MFC entries are still allocated from softIRQ with
> > GFP_ATOMIC and are not charged. They expire after 10 seconds and are
> > bounded by the socket receive queue; see commit 0079ad8e8dc3
> > ("ipmr: remove hard code cache_resolve_queue_len limit").
>
> Not worth a v5, just noting in case Sashiko nit picks on it:
>
> Unresolved MFC entries can be allocated from process context and in this
> case they are charged correctly.

Thanks for pointing that out.
>
> >
> > Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
> > Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks for the review.

Zihan Xi
