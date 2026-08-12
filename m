Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AB39020C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551939; cv=none; b=IBTXSlmlUOnPlcIX8IbNE4PF6A53tZkMs+Qi03/voYSLLmXzGX95UZZTSJdXf8Gpse4LyS1ImkU719PHraZw+CPSfmAsmOfiHCDOy7ny9WNzdhH++mcUAC+C33nTTyNoXUkiIWoBzgJhvbRpq05Ds7FkyQvmpHaywYvxgxm7TuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551939; c=relaxed/simple;
	bh=TY3KWn1JzXr2UezWchebIm1iBX/Q2dvo2T3wp6pS4PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0Qf8+6/Cjg9uP5NZ3Lpo9Qy3HCYyRp9G+C451p/HhUSyN5DExu8N2VLE0XSyyZ8s2DAneLYJQJueN2a/R5xasEs42EDltZjw1/pHgOMRQYaHYE7MWZ+iifB/S4LqLlTC11fWJzVlb1inJhTvhvY2bDT8MKatIijYdSLZUa974Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZSwd3r4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZSwd3r4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E21F000E9
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551938;
	bh=TY3KWn1JzXr2UezWchebIm1iBX/Q2dvo2T3wp6pS4PM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iZSwd3r4ss/DJI8uyg3ppdP/zhJcoCo1Wk8stKDqO4AEZeDXxMixlRSmDEedzjMLo
	 BTPVfXLDFWh1LOIrNVrVD++1jMgt3116ayjR7htpfWwCxzUBTgDTXXW1uAenTGM9ev
	 SUWNuuI7SQ/vyNDmwoLbG3UWevhP0++tBF3n4J+P02mB8BdS3Kk9gXAaYjclKlKnSZ
	 dhqafPHak3XRQoNPDFCK7d02BhCMAZdIs0j7WQnDJ2xdbtO2R+F13+CZIl139Sfz3U
	 kpcZ+DNaFk7hvDCSWK9zO/V/62lB5Iis5wtwuYN8tOyhpULHpzOzOn1nNon5qyss7q
	 p1RbD5Og+3Cng==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930f4e5eed1so90955285a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:25:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoVjKntPgK7qdKp/d7h6PPjk0bc2yGvx50yKhTUEfMJ8S9mzrNVMP7otuT8nA7eQFfMG6Tt5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVa/UOm6WCwO0sWf4FvZVEyc7GzMEJP40nWhY5LvtWZ8HM/RJ
	AqNHhlhFm3p0tnTfcXMPtWh2ZQ+dEy/+zg63BFGnLQLq7JNoVo1txeRcaIjUtbbrVLjEjQEq9c9
	xMiQX8nk0ryp/z+IFtB7Somlzhuby/sw=
X-Received: by 2002:a05:620a:43a6:b0:92e:9d63:a700 with SMTP id
 af79cd13be357-936b3a20e63mr565881085a.9.1786551937034; Wed, 12 Aug 2026
 09:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812154328.72834-1-mahe.tardy@gmail.com> <20260812154328.72834-6-mahe.tardy@gmail.com>
In-Reply-To: <20260812154328.72834-6-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Aug 2026 09:25:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4A++FepX9LAR5scLh62fG0NH9oMQ0xwCEVS4=76PVA=Q@mail.gmail.com>
X-Gm-Features: AUfX_mzWX7aTt3SMUKwJ9r74fq8ciEI7bBsIz1h7rTwgDeyK3eDA8B5ljxnBIlA
Message-ID: <CAPhsuW4A++FepX9LAR5scLh62fG0NH9oMQ0xwCEVS4=76PVA=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add ksock test for async
 callback guard
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:43=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> Because the kfuncs are going through LSM hooks, allowing their use via
> workqueue callbacks would expose the wrong credentials. This test
> ensures the kfunc are preventing any use from these contexts.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Song Liu <song@kernel.org>
