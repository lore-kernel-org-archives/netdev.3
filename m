Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366F4AE8DC;
	Mon, 21 Sep 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004876; cv=none; b=AX983ZeK/+Oz+e9JlZnavr2MClaFCnRkgMvpkOdNH6Ch+d1hIna4SlEhVxeOzlt1Q70PSvxccp6zbJqEC6NQHKAk894w9EWVBPnK+8LTkOOdAhM0Es0PnxHjIcYlVD3RHrJUaP2esFSzvLNTH3ABAXxQCNpAwfQAmqK4ZLzohAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004876; c=relaxed/simple;
	bh=03oo6f8GY6QS8TGX+QQVt9ojqT57JJaSIqUOi3/xve0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEchVxL/7aKA1l1tRS2ifGFTAph6QP8zxjBmuC5OqUJoupIMi8Nv5nJWnBwmZio78FZmJeDr40Agn6wV5fjMtk7JzOziJwH9dQaybV6TnHXI3KpNsarFLVsjWZmk8hFI9x4lbR25Fi2SiPg1yg8JXD1ELAwT/hRcuTM/nsdmndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kxsi7EyN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdosJhyd; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kxsi7EyN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdosJhyd"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 223EA7A00B7;
	Mon, 21 Sep 2026 11:34:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Sep 2026 11:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790004870; x=
	1790091270; bh=aMdaYGC3dnikrNUPNPCmeJLmSD7iW9O1fy55of4fPO8=; b=k
	xsi7EyNriDDkNGk+2xy9ofkCfcMa8AAsb6zm57yQGRaZL0DhV+BTkAQxbc4NnYsx
	so9skDmkPgdKVBsYB47E8FtK0ryh3g7ARDd3EWBPE4TXq8vkiKUfzybz2KfLPHw6
	6wQ8/SfAP656fAkkcr+lA3sD+1xZz8of02JuuFVKBFrNV+wwBuEVn5Q0I8gZK9c5
	rev1gixAzZf0RCeeWqq2wQl52alPr2MspZNu8uE7rEDWQdHIL6l7Pi0h9AcD66n0
	8apnmrla3VNv4b0OhLgb3kw2IvJh3Eo5DOXqHS068DmolJ0CBYdtKvaIQBJpOI0q
	p7sRDP3OVCfyeXVxZLJKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790004870; x=1790091270; bh=aMdaYGC3dnikrNUPNPCmeJLmSD7iW9O1fy5
	5of4fPO8=; b=MdosJhyddaKnUckZcdVnIKGMgCBcjx/LpU9OuUNrCN3M8u8D4ge
	+pum1jvX/mIj0aWqNRWv5qpOBNv0siFftO/ECKuqQ5QL1YAEFm9HGsST6hZxGTsI
	0JqKJeuPJbmzK8x8VwaD0dlCKijY/jviGVAbaaits+NbOPZI/7vEOXfTlHBdsszr
	2rVT0/EUuTzUXI9ZbelBm07zMT5sNkzWk8DdthfpXNLO/rRnpVIhiwZabl9GLZzz
	EYh1N8Ok+vb2CQawsZj2qTET4biDe5mzsV7Jx/KMLYbfOYxx+/VuekNnMaGo1fFp
	INsHY388fRaiVYuTKd0o02Zdx5jRgJFe6eQ==
X-ME-Sender: <xms:hk6xarkOheFpMGO8ZuVp3hU_SJ_RSfnEjLr5ENWFz8Dq88OsL-BsGQ>
    <xme:hk6xanCL31MrV50yEC8KrDcjYEsDR2XHrml9Yttvds-kHDqs8oBwbrGU8JF-JyXKv
    EqwQtcwjRAHWTft7BYGACHyJeLhxKqRs-MrLbFKEqkwOoEo2UoggffKPw>
X-ME-Received: <xmr:hk6xatPAL8K-mmssrvC-Mdb_mTjplqzUZ5Ou5OZEn570Ko92MDBL32Y2fkDk>
X-ME-Proxy-Cause: dmFkZTFllKuC9KsVdYPELHsEO6nuJE3c8+Q6qpBuZWlfQQ8JVpYTFzypQoka5m3tbFgruJ
    OkxApyKYE9NKMWcURB7pIWcb6EiJ287Gzn+qF2aHYsbjuRHXsHrq/BrlMC+qtzMTx3BnM/
    7d/55+QogLmhnw+v2+EBNo9Jh72lMhJuULoQ5BIASRrXfOS/qqmUlAfeuekfYMKWPRTGC1
    NF83IWOYkQtIFbmCadgZQcGzkeBkc6hlmbcad9mlKHpPQOp+eN697ymzDLmKVBCK04xKFz
    SzmHuHc2shSrx6vSQK9LATrYX8D5+/s0r8jQcCod0QCm5tNTaGq7B49/tZIRZNi/lZVynp
    gajk5TprgQpYKZo7NFKezPTf6kFk2r8Cu/jXa1NJsaqhO1XzYQVbUj9li/hIZiSESsQTDG
    3tZ0wrg1iwFwM5FbDbsuDTQXzP2LYUzV6+UZzsmKQVpc529j69G33sMPwOcJCfISxkQk9y
    Gkz9RYqjvTzEsqSFgOFX0g2xj7WK4KaA31YQxAz/zWEXdqAkXtJU/CHNnlPaR3itf2O0sa
    ox9HBeSEJ8FcxbwkgLiKUyxfivNmbSZW7R1L5ngll6TW5YI3Zn3AfoUCvxfcI0t6dwH6IZ
    YM1TWqN7Ag9AmO8tQbWVDYGYNjGpgknhaPfek5EA/6lYJsy2/Ri0MwJK3ZAA
X-ME-Proxy: <xmx:hk6xauMxj7SjMwDE1Ub3HHF8w-0XYrahM3wPFJ8RghIGExuoQoNDIg>
    <xmx:hk6xallzXFZC0ZanRfi9u7ez0HagX98VfFY-hJCe43SLfmXVMNkzRg>
    <xmx:hk6xasvl70918AX1qzeqbfCxufCUCXPHRo9XWELu6roVfOdvR6qwwQ>
    <xmx:hk6xaopUiEIRuX7tZ9zgiThUBH1Tsy0jFtWvruQ25P565m2A6Oy-lg>
    <xmx:hk6xav4ndPLZV8tUH4n3DK0NOfoEpKArSsPELmjDp1eNQR9rUCP-L7r3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 11:34:29 -0400 (EDT)
Date: Mon, 21 Sep 2026 17:34:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hui Peng <benquike@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: reject sub-32-bit or unaligned alg_trunc_len in
 attach_auth_trunc()
Message-ID: <arFOgwhswr1MoKVm@krikkit>
References: <20260919210623.3030144-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919210623.3030144-1-benquike@gmail.com>

I'm really confused here.

2026-09-19, 21:06:23 +0000, Hui Peng wrote:
> In attach_auth_trunc(), userspace supplies `ualg->alg_trunc_len` (in
> bits) via XFRMA_ALG_AUTH_TRUNC, and attach_auth_trunc() only checks that
> `ualg->alg_trunc_len <= algo->uinfo.auth.icv_fullbits`.
> 
> However, ESP and AH convert `alg_trunc_len` to bytes via `esp_authsize =
> ALIGN(x->aalg->alg_trunc_len, 8) >> 3` or `ah_authsize =
> x->aalg->alg_trunc_len >> 3`, and pass `authsize` to

Did your LLM make this up? My kernel sources don't have any of this.

> `crypto_aead_setauthsize()` or `ah_init_state()`. If `alg_trunc_len` is
> not a multiple of 8 bits (or is between 1 and 31 bits), integer division
> by 8 truncates the requested bit length (for example, `alg_trunc_len ==
> 7` yields a 0-byte ICV in AH, or `alg_trunc_len` not divisible by 8

and what problem does that pose exactly, for each of those cases?

-- 
Sabrina
