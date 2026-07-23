Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4933A71B
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816399; cv=pass; b=nrx0Pzggw7jrvcmDrhV8yRQs96QvgM92zlx5tZURlmVQ8f1m8EUzv18xMnGVUHkGoXbvglt7Ft9xy6+vmEtXtYI27xye4PEU4p2t/gIGXIqqeqkwoAMxM+KvwjTMsv6Ts/dWKS/x4kIRjbNn5cm254qT++Vh8iqJgBLzz2drFfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816399; c=relaxed/simple;
	bh=I450LK2R/t5kaadEBFtXOgikuDhtpabWGQBLX1/MBfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEaNGylBUNCJP3t8xZkshkLXjAU23P0B0RBVHnWMKJ1ADYmCApxjjzabAkXwpDkoKpM9c6XNOJd1qCy3QApgQlHpJQWThQ/usNs09tLj6nM7TOSFXGCUhy4pCsonAiarn3VUePN2XDwNEs86u/geGMcu2g3B6gQRsItln9d0uzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=NXUsaF5i; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="NXUsaF5i"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6689402c7bfso509804d50.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784816396; cv=none;
        d=google.com; s=arc-20260327;
        b=ocsPJouoqJRmHE35b2RCyb+Gpd1hg1S2O7WySNp7E2/VyrHp/kqXERMqxMFR/Fmc3u
         Ukl1p6P0D05oGRjhPF/O0lV1JMO1eSlT9cLE9U6R/lm3j3PoD8uBi67NNE1r6+dcMTdy
         PUegizUFYREwaEUs/GsUTZh3SKBLmXphRpxi3tLYVDbp+ahrIEf3BDWahrNot5N74BkF
         OY0osdfpu/U7Qa4ICmnQPBk2GvFP8EmgC+D3/6geC+hnoXwBC7TXBmtH5OKx6JDygNM6
         n0wv1kaOLMUx/3OmRO0PTWbwm7Vo6fDajLt9jlDFaRVKE2cC4qrpecJEQjc2PKeTIvEM
         GG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I450LK2R/t5kaadEBFtXOgikuDhtpabWGQBLX1/MBfs=;
        fh=BnRjVoGrZ7E3gqtj12e83gnjXGZQ15fLkkvn18TWdTk=;
        b=G70JJuUprhyV/niISBl0WAhuWLBiqO0aROPjPzbAq+ry7akLwxQH52LqJ+cD+Gofkn
         X7Orj0hcg/M4pXHxCrc/qoVCH6hkH+qMQnPN7LUHSsMDChlCfOnFnR42tSjVa/ekpR2K
         p/RREJ9yHZp5+rjXkdDZX8byedlVd6cVkjEwmMPEiy1oj47iiEK9kVaLuwq8QpOwgvNS
         pLbjO7rHjMYEtCiE7/VtGQCLbE1tlpoJEqVB2eP5t2MqeXjXokkkyYITkiCUlll7cFAt
         u3esodustu9qsgXrVnaCT2QAxpVS2Mmp+23ZWYeSZezUuLw/kNeO2i4uXAvvwpMYvwur
         wmMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784816396; x=1785421196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I450LK2R/t5kaadEBFtXOgikuDhtpabWGQBLX1/MBfs=;
        b=NXUsaF5idjQ0jIabPGBRPczBoyj0AyVfCuIA5QUyxNXwVJlhP9Ytr0vOauWUfYVd/T
         qFj9SIxObDkYe+hFSc1egaG8yhAUTHoVIybLjT4lEOL0cizPsqlCaqs273yy8iv1ACXr
         8ubD/ZDXjnjtlaklQYHtgUMDIOvNtPTTh3QvHSSEq8N+pjF2fOJEJlOsddnnwtHEkj8e
         CQCtzSqKs/Vz1gNkV5R8zR3rczafgsI1PXyHOd/MAhYYdz13jpTA7UFIu1rAeCSC3GuA
         WCGFYF8iGsTk4lbpLMo4xK63PiONUPRc9t1kdUD4ZKXxkSu/+k0020I03h7vA12g0uMU
         hreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784816396; x=1785421196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I450LK2R/t5kaadEBFtXOgikuDhtpabWGQBLX1/MBfs=;
        b=bHeH61SBhWMGtGcVEQeTC/ZxMv51+0Qtw60LQmq2/FDwAGt4+FPJimk8NAw1saoC9b
         ISEksYHzFnwht7S40wAYcgCsHUe9wsoG/cOAk0pUssbL7Tha3VdRufHPOw+4xUPPBbFU
         C/LQPc3051XxE5jyeNt6Ni8T90gmBRQ/6dNAWwZWog8y3EUTkRiNITgDKd1ZBU6RkMXE
         9lAq0JRBtzURMV9zRmLf2IlsPenHurGFLLri/b6nuhw5ugRDawZPksnstsg0mqOOy8Yc
         fEKnfLH2LBKBLefZUraqrdjeeYvnMc+x1WyH4o2PgwQJbzdErYsEmA9W1HiX1VGQtodd
         aK0Q==
X-Forwarded-Encrypted: i=1; AHgh+RragrnFGmpqeDfiFIYSf5DGwACELU1818s7G+aZgl+SoeIDFZxH6X7PfYTJFl0C/uKR80k5tNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnyMph3lGLcFXu+ID1O89GeL0BJmSRNhRdw8u46IMrr1lhFak
	5kTsy7P8aGqvItVDhwirzkyPPWxDJFPr0IWd51CQn51Cu1iJk/U8vC1tXAUjpJjyJHK8gu5I4Q2
	r+E2zNwbCRuK/TD2e1zBBW+LQoByHQ9bHM5TQeW9BEw==
X-Gm-Gg: AR+sD12kJJP1l1pRza8edRXYe8OzmaYxvKoE6LsHb1NFNnGnlr/2p3vE4sVI2MTGsLI
	rNw4LC1MkIq4n986O0PLNvtkqnrpx5fDnG4xtl51FsX+7HNcGDtklnvgXykCFJR5Iw/oCT92+L5
	ND93eXgNLlBpWlbLFfa2zJRfB84LVJiW9k/He9tNwZuwloACfMg7oX+w+RYm3WFoK6oVcaIiulf
	Jl7uN6EyaBIgLSTA5avGqrJRnc0ESXtVUb5x6DTBWdKwAYDaTPx/o6k3b9kzYYC3EZOMVfltOOn
	2yFUhDkZ2EKi06ZJS8Ys0VfdJ+moWDV7LjSk6EEqB9QR/Od4
X-Received: by 2002:a53:ee44:0:b0:668:973d:5ba1 with SMTP id
 956f58d0204a3-668a4f89bd1mr724612d50.79.1784816396342; Thu, 23 Jul 2026
 07:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-1-alice.kernel@fastmail.im> <32f55932-e7b6-40ad-95f9-9daff98356c4@redhat.com>
In-Reply-To: <32f55932-e7b6-40ad-95f9-9daff98356c4@redhat.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 23 Jul 2026 17:19:38 +0300
X-Gm-Features: AUfX_mwarOzqaZjkxP23smrajUPjFq-iwmjZ3hAq7Bb2tcwqpxgn2TiIEnaHYhg
Message-ID: <CAD0BsJX25madq3ChHPfij0Z0c9_7sbwKcuCUwDWVNGzcxUxBng@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Breno Leitao <leitao@debian.org>, 
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 at 15:01, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 7/10/26 3:42 PM, Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> >
> > This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> > support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> > IPv6 BIG TCP doesn't require stripping the HBH in all various
> > combinations in tunneled traffic, adding BIG TCP becomes feasible.
> >
> > Patch 01 adds accessors for the length field in the UDP header, as
> > suggested by Paolo in review. The usage of udp_set_len is then added in
> > the following patches that start using length=0 in BIG TCP UDP packets.
> >
> > Patches 02-04 close the gaps that prevent BIG TCP packets from going
> > through UDP tunnel code.
> >
> > Patch 05 validates packets in udp_gro_receive to exclude packets with
> > length=0 from GRO aggregation.
> >
> > Patch 06 is for proper formatting in tcpdump (set UDP len to 0 rather
> > than a trimmed value on overflow).
> >
> > Patches 07-08 bump up tso_max_size for VXLAN and GENEVE.
> >
> > Patch 09 adds selftests.
> Thanks for the effort and the persistence! I understand the frustration
> with AI review and discontinuous feedback, unfortunately the volume of
> patches on the ML makes such sloops more frequent than before.
>
> I merged this version, addressing an hopefully trivial conflict.

Thanks so much! I'm preparing the follow-ups on the gso_segs overflow
first, then I hope to address the other points about compatibility
with GRO hints, early flush of malformed packets, and to explore UDP
GRO > 64k.

> @Breno:
> a second pair of eyes on the resolution would be appreciated.
>
> @Alice: please follow-up on the possible gso_segs overflow ASAP.
>
> Thanks,
>
> Paolo
>
