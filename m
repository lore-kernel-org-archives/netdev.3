Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449106;
	b=x3TqHb0HVXzxeAqtasNF5DaUi3R1EFWHKDVYmHrMYpW8p1xAdmA+dfiQ9bqWYzjlZXsE
	 VgrQgvYaeDgPhES8DRux6McK7rsL6H8I0XmR6T+ApFENx/fNRVd2MFIWGAK6ya0bziWdk
	 1LgOpvnBnv0y26pCFU8Og8Zkn5RJMruQ3zAZS77M1hsbFFOUTdbUAmoBtg9mJMdPFZxbm
	 RqwNhRZodTWDwiORpASen5SDDghsl9NMXs2vF6YviJjbfYpiVjAOUINIzxC90xuuYwi1z
	 UOSTLQ0NbOCkhUoXASDSjRvrDLlgWKFeTA6nOll950UfJPohFAqlXmEZ7yVIbVN97GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c2ejXARH8fi3zSiN3X1ykeCRFk4Sl3myGRGrC/Z2MzA=;
	b=Mgl0nlnlchzHl2RVQnuhx8QlFj3deRpVEHqBSKZwPdtym7KY3GPxG6/Uy9ss9SK8+MsP
	 QelkbiYy/9FZvObWO959WGkxETpJxQmbMmIBqxhNmw0X7JEiURBlBlKs+yGZsda5l6GOe
	 a/iYHqMgnGD6UqOJRRRIRxVFZ3SlhfwzeNtMNlk6END+lm6zptVWZ5elEPo/unrM+trtZ
	 37tRN1Cf01smctcxPIIOs04wHjDsnNYvs36UpXLC0amElk9cgu5WSeSFrKdYUyGCj2cdu
	 dUfGokjOPdVTpe31mMGDWFBDQrx74OI8hJLjOJxxJe/9pdtE5wecC4LFyGV1GgEZpFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brUl30iq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F64606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brUl30iq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33061F00A05;
	Thu, 12 Nov 2026 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449106;
	bh=c2ejXARH8fi3zSiN3X1ykeCRFk4Sl3myGRGrC/Z2MzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=brUl30iqqv1Nt5c2nMQEVCHKkbu9x+E1ijibW6nJ2HchleGsHTfAx1Hbpa++58Xz2
	 r7+mIzjuQLcDsj/4Mq++wS/mWuEaAv1dgg80eUIBZO3DOGrdvFz5tXqEpUbeiKnqGv
	 UU0lMK2r09n38kAgGWIiT4HhX9Ecg9gdFvzr2zzEf95huMKCMluZQGpAjKR8cRcntJ
	 QJczicLC32/dPenI1VaQCG1NDzGx5ABk9Vooi6PDXYvjXqiNPGlM/P1IW0c44/63NN
	 LdwE4Lj+kgxpizp53h75eA7rEn0uGiEqn24CuCMKVDEMBzcaJtS5CRa/1UUXySR4RI
	 xWZ9r3nRly82w==
Date: Wed, 11 Nov 2026 18:05:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: houminxi@gmail.com, netdev@vger.kernel.org, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, dev@openvswitch.org
Subject: Re: [PATCH net-next v7 1/2] netlink: specs: add ovs_flow del and
 set operations
Message-ID: <20261111180505.530e85f3@kernel.org>
In-Reply-To: <179444894546.2199510.2728310247051508293@kernel.org>
References: <20261110174751.973464-2-houminxi@gmail.com>
	<179444894546.2199510.2728310247051508293@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 02:02:25 +0000 netdev-bot+sashiko@kernel.org wrote:
> > +          value of the OVS_FLOW_ATTR_KEY attribute. A value longer than 16
> > +          octets is treated as if the attribute were absent, so a new flow is
> > +          indexed by its key. A zero-length value is rejected with -ERANGE.
> > +          Optional for all requests. Present in notifications if the flow was
> > +          created with this attribute. A dump does not read it.  
> 
> [Severity: Low]
> Is "A dump does not read it" accurate when it sits next to the -ERANGE
> sentence? The commit message goes further:
> 
>   "A dump does not read the attribute at all."

Please don't over-describe things if the description isn't 100%
correct.. IDK if you added this here based on previous AI feedback
but if so - please feel free to ignore the AI feedback about
documenting things. It's often wrong / leading down the wrong path.
