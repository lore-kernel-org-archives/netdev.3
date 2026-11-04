Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792933;
	b=QFdiJnJ5m182WBOYECg7DOwnqhaHwXhlb1Fe3yluazi0OTIa/jSoxQex4YHTLbAIc2Qb
	 t9QjmdMj5gjvpRBTFB97iQQLvNykNFJk9f/rW3Rf+8SP8MEiv3R2+hehBwE0A1W4Iz7pt
	 LBmUJiBB3As0xYew+7elVuvDOwRJ42sslTbu0jZarjXtOjERLJeeqPlo/1BBwKBFfsxic
	 XU9w12I31GCdjWGla40DJoMk00g3ukI+3rfbm8nTuTFXRdgmI69IIfuKyr2iZkLldbCs9
	 y1M5qeSopanAYMR+XDGGsiZga1fWrTAJFyR3xlVMhPXFgv+80ooO/+QSxKKTLrnFk2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792933;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SLd6whTF9qUDoR0fVo12Cf3HHuqcOluoucBX/L/t/TI=;
	b=dix4Ye0JiKi0CQmsXH1bh59csLWc7hv4/L9PDgJkoys9/dXkuUDyuyWaXA0KZTxrZUi5
	 ysW0KZ87JcBkbv+OPYc5GD1DIUn7czXQuKpz9f9rKaGlmq/yDTqZF+l3cAQ+huYWu4NxW
	 hoI2+AxJ/47wVL/TgUAP0ZLox7G98/v6HSLr9eP5voWvRVjLr8+SBrYW5CxHjf7kxd5kb
	 NY7K4XI29YhZzHTXyZj5gCWgmao6jT9RZpW6yCIlz0RTmC/Z+OHFl8k8ZEp3H3WajuOnf
	 UUky1XDb27NtQPOJP3cKxVB7Uun5es/kmpKD2AcxhkucNEIjuszkIRJgfYT7mSWKdkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WetzKgej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A4606D807
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WetzKgej
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE21F00A21
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792933;
	bh=SLd6whTF9qUDoR0fVo12Cf3HHuqcOluoucBX/L/t/TI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WetzKgejnWMvNgHlzbGsA1T4YPCHtDZ4oDsvSjr5+OcpCBag+6+LqRci/CqY+anFf
	 gHs+eatnSDm+KP+IBYHmMPm8VLvM3VKzkI17dLVz44hjwFwtE4cbyKJ6l6wpbBFXJR
	 87NgVdozDOEyepDZ9Gvh++a4dywXHPQylaFNsnEF7q3gRK+KvOQ8vvJNm7zAb8aUKb
	 KQKJ7IYN30DEjtdDjMV70UPqnxGzV5n6XF+6nyVpRgvswyBHxwns8wboRsgnH/gK82
	 Wl9Yyld6Vw6RC09r20cntpruJyYrb9HR0DR1hOyvKKAHniULLi6NRmI5RXzo0GkGC0
	 hYl3SmIfBQP9w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4932b13c4ccso350626fac.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 03:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzhsXWVPCD4wuEZplH73Fp8DYfbQrA8QaImolbLyaTdj7BRHGaFDGrMf5Np3cRm4my58C3J69U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yIVy6lCRThqJP0WiUdgpJQwi2T8irZ+7vZ5uKrFxc8g8CQa8R
	f0tD86h9m7/vcwxeXE3kY+63mFodC+VvwvmrSyqbA1IgdgvgfuKfGb36F6jQurnEpAnnWNTi7WH
	pqE13XEffdUMxNtODpCeMvElXgGjttXo=
X-Received: by 2002:a05:6870:8dca:b0:4a7:4c99:8d96 with SMTP id
 586e51a60fabf-4a907292865mr10290934fac.2.1793792932513; Wed, 04 Nov 2026
 03:48:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104113530.986664-1-edumazet@kernel.org> <179379235268.488859.11510660996410063187@kernel.org>
In-Reply-To: <179379235268.488859.11510660996410063187@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 12:48:41 +0100
X-Gmail-Original-Message-ID: <CAL4WiipcBrAKR2-NvpusgiowxRphsFdogqWKAwJJjsB_bh8C=A@mail.gmail.com>
X-Gm-Features: AclHuK-8mSgOKnJ4Sa9CdxvouKxlGwMVl21C9ZVzB-CreZa6Ymgh_SFvJJEhI40
Message-ID: <CAL4WiipcBrAKR2-NvpusgiowxRphsFdogqWKAwJJjsB_bh8C=A@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: make outbound skb headers writable
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Mahesh Bandewar <maheshb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 12:39, <netdev-bot+sinfo@kernel.org> a =C3=A9cri=
t :
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Discovered by an LLM scan. The bug seems plausible to me and needs to be fi=
xed.

>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
