Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431515;
	b=t4CrTza14dXU4yC7wwSuc7uaOaFd8HCip/Qj+qvgkrHLNrXz8EK4wNdNJ75j7xYpuwSD
	 S++kfoaeaYh4X6k7Cxm+bHOJ3euRlFaAqrEC/Wb7hMDWLz6bhRtakOpNLDToYx2TV4skz
	 1u2JpWssa4Y0DF+/CGhYgBQwPOlPcDjmIdipYwjADDw5qurfIUiFQ0LS0xJl8gCNPFBCo
	 cEkUzxI+fJ8lVqAxiYDrCgzCO1glK+LeQwv2EkLPvSY7/7jvAWWyyFak5GX34ecmzb1Ra
	 EGy9fjJMYBTZJ4ivm74Q9zgykajEmZpVUPpxUEzW38yHlwh+KC4K/mHyRN9zuPXvazQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431515;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=s6W52NLboX/AFrON+F4OTdfp/qkLqq0IjDzO/k4MGLA=;
	b=wdse8cKeeKSgsWOMzg5CIBTj5AueDHP0ivPvpcOBucXd9gM5Q4tnWmmS2m+g+IM2AJpt
	 0XY2PbPeEEUJmJF/BJLt+NGVhdZ8x0grSa0j3IBXSAyd0USLuCI5WPV5t2WG4AJNdeA2J
	 kQny65RnSmRgSS65Uqe4SGWnB+w6pNAH3JrU2RwQsvKpnw9SxEtUo1OWWBLX+FGU0JxjN
	 TIU/RANdFB7E8BMJOttzVWwCOvjkHbex9HsXFYKxVzWVd+GSJra+HAhLEd6t7jnYHrIFk
	 h6qYN33kPrHyOO4RSfMr8PkeykSNdpmdYYc5P5HTogacn/N65YXLOXH9Z1yyBzyFwzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbsDr3kV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38D606A331
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbsDr3kV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21D81F01573
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431514;
	bh=s6W52NLboX/AFrON+F4OTdfp/qkLqq0IjDzO/k4MGLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FbsDr3kVT9I0w6k9SF5ZxWq2MbBiWKCgI4YoK0iErcif68QqUS7X3h/x5FiwrI3Ca
	 MdC5DZpHQPvhAQn/aLdexPKQLOj1pWdfroyQPogJUIIUeUmYAwo3Xg53EXaHMF+W9P
	 FMK/NaBBY9u9YieM0lT26TBDNz40+nGJTRfMCZarwcxLlZARhycl9tAlOSSMA5rthB
	 m4Li99yORqeciCLayBPkE8NLE/PbRhXrqLfNuW9S+Z/EqQlLHBH5/FLAQOLGHBTA/x
	 vMH/QR2+bZh89JWGXb2TUGx6HCht4GNYEzPMeBEggYLJmNl/J5V1Kbe8rl4Ojv1q9S
	 MaFyMP+gh9fww==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-48e9476e26aso669772fac.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:38:34 -0700 (PDT)
X-Gm-Message-State: AFq9FYJlgWMgaN4nEqaHJ6C/zkjx//tk0GRCNHMCbc1fg08UYsBUuZIm
	JZk5Wyyk1pwdXy1tK/nIOU+jEeK/EpNuI2LztwfBQiv/rl3vMvTrFSxZGib8Ek4PuOpBchmhuEI
	wQn3Wq0u4AsRQCu7viC0r5GPM9brwvio=
X-Received: by 2002:a05:6871:385a:b0:49e:670d:78a9 with SMTP id
 586e51a60fabf-4a757b9621bmr6971161fac.57.1792431514134; Mon, 19 Oct 2026
 10:38:34 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019170225.729789-1-vlad.wing@gmail.com> <20261019170225.729789-2-vlad.wing@gmail.com>
In-Reply-To: <20261019170225.729789-2-vlad.wing@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 19 Oct 2026 19:38:22 +0200
X-Gmail-Original-Message-ID: <CAL4WiioPv0k+MKGwtX9B1TGPmKv66rvGsYn1hKBxQG9Rie9qoA@mail.gmail.com>
X-Gm-Features: AclHuK82pczAE9KFR8j9a3CaRLQliaZrf66et_YIl0AKM8Sjxsa0n1iyw5RxUvw
Message-ID: <CAL4WiioPv0k+MKGwtX9B1TGPmKv66rvGsYn1hKBxQG9Rie9qoA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] lockdep: Introduce lockdep_unregister_key_nosync()
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Davide Caratti <dcaratti@redhat.com>, 
	Breno Leitao <leitao@debian.org>, Nilay Shroff <nilay@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 19:02, Vlad Poenaru <vlad.wing@gmail.com> a =C3=
=A9crit :
>
> From: Bart Van Assche <bvanassche@acm.org>
>
> Add a variant of lockdep_unregister_key() that neither sleeps nor waits
> for an RCU grace period. Instead the caller must make sure that a grace
> period elapses after the call before the memory holding the key is
> freed or reused.
>
> That lets callers that already free the key's memory with call_rcu() or
> kfree_rcu() avoid waiting for a second grace period. The qdisc code is
> such a caller: all qdiscs except ingress, clsact and noqueue embed a
> dynamic lockdep key and are freed with call_rcu(), and replacing an mq
> root on a multi-queue NIC destroys one qdisc per TX queue under RTNL,
> each currently waiting for its own expedited grace period.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun@kernel.org>
> Link: https://lore.kernel.org/all/20250203175939.3133477-2-bvanassche@acm=
.org/
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> [vlad: rebase onto synchronize_rcu_expedited(), spell out the grace
>  period requirement in the comments and changelog, describe the qdisc
>  use case]
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Acked-by: Eric Dumazet <edumazet@kenel.org>

Thanks.
