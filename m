Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466656;
	b=cQej7T8RMNb+RlrxhESGnc/4CMys+F5k78wXpVN8Vli6niS0f875frfUx0poYLqGPL6G
	 x8Y7fYTgi+Q0Zbbo6SlJA3/PvuFhmxqHxsOHd7L9duz8Xrers9LnEjaAMpPMVKv2Am9fd
	 9EFOZCXmFsyYPPJuPQW3+ckkHDQga5jkQpFiW+2FQJJaY/zVc5kZk4Fs2SsM5fj1jEWWv
	 GoCT5XWKLSI5soAZxnbSNBkeSQT7pV2+5h2y0Ub0pNn0ktEw/eDsfdOg62JlJ1PkDhurL
	 VuzeT0nin4HR5WQkzC91sf4kGwlHJP15FrSaUyFcdKQahZPHL1MVrwxeJpNa9jGGSkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=nxc4/wwi6XxzNyHnLVdy6S5s1zdy6DILq8PSK2dwAOwz1/iinojrdKSIC4dPS2X5UmK1
	 I8KVakehw/6bMQFUM/SHOfXwdAMbWpitPXQKmn/1D4vbv9wPLLmY8bzTN9vHrNH3/yD3e
	 c+s3p59TFryiIQWOxogRcU9jyZiisMICiFKDX2LjLPTz2+dsh4qQo68DX/jCAa4bnhSjY
	 vyejzdeIK91g0QiaG9dHq1WDhddCUC3I4KVTzd/8SqXIdGLcB4e3uQrFkMvlWe9SzGxUT
	 av4MndWH92C26e+UQnkC1VTA/c1oabARACDm6+88IeZsBvamo+w/uneTpw++1/IFkgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HPFvQU/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86257606A31A;
	Tue, 20 Oct 2026 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPFvQU/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5630F1F000C4;
	Tue, 20 Oct 2026 03:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792466656;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPFvQU/G1+S4/DGfPTaVfsoTIqqqc7LeTJ3jsF3YKB+kIOwovd6gXx2uD4fjF56MQ
	 6jp7hnsh540WJg9jGvkXPnTyaF2j57u98qxwkLElhfh3NSwdpIYCadMW6GJ/d74jzM
	 QPFsHF6p59K6eXm0n2opu6JrQuCpIp5LJQXBI5nESGv8fTB95WiG93F1Cpk7G2alVc
	 0d4hXSWVLB8jwrCG3JteyXF2F1T2/+Dl1a0BaAWzIbfRu6VJBgJH7B2bbC/KbyP6HV
	 l+UXsLyyfSuDp+dnHSQ8zWECV0n1EfolIjfmE229kU4n3QSlUGA5W7pm5RpsGuhDXi
	 eB/AGSpOL+USg==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>,
 Jeff Layton <jlayton@kernel.org>, Kexin Sun <kexinsun@smail.nju.edu.cn>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
Date: Tue, 20 Oct 2026 03:24:14 +0000
Message-ID: <179246665484.3290.1043894447004854565@kernel.org>
In-Reply-To: <20261020032119.1334986-1-bsdhenrymartin@gmail.com>
References: <20261020032119.1334986-1-bsdhenrymartin@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
