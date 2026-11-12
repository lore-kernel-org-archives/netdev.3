Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794495328;
	b=SJtSo43V7OJ+nf8clD39G966BQnDtryTMd3tRxCU5zhRFrQkq/HSyakBGsguaqbyu6tN
	 GQEQl2Ine1+Zisx+sw9A4pPtlklrM9SXkUVYnXHen15VyIdLc8uzGccN5y0uhgaRbmxT8
	 75jVV1+23itNyPG41vx3G/ZCmYKGRJFc/0uOPdUiCZ5NKyV+V70E0pBerxVawhY1838gF
	 B3UsFqVDXMAXu2w0CVj7fKRn3mkYcXEz8xEvBaAdrNfU/Tyz1TyaaVqD3o/mGy9twKCSo
	 AIPPAlpmg5Kcv2AlYtvD0BDTXLYUmwkVScEk8t+ywuw/9JFPK9NeK//S9O5BuaJhtkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
	b=d+FzWq+6hY6CsJIuqOOZxFD3ZGZeNFweTwaQHGxxrDk0n4iLGFgovM1FVNw1QHe2IVE7
	 l5/ap4zq/Xy66iS/VnDKggmKfunR05ZwxWi5l5bQUH0BrAm6chYqbwGrssqQ+giVYR3g8
	 EMR90FjCEHuGmCxeVFIut4rEw0Wg5jt2VgbGPw8aOqx1EihQkOZb4usnt5YmfcC+CCG9l
	 QiQcQZ3pMulJt0WQhmyYewHsaZTj2+f1GL7f6Nn2O/TNszXyWamFAnWiQDjLTgpq9CZm1
	 mZu97SZbCpF+25CD8aEgtbEkO6t88nVpM11xOlM2AxDlDU87Lo8a2ISSx6CkOQnZbWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=U5KQI7tP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D0606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799D0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=U5KQI7tP
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-706113e92f9so2474898eaf.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:55:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794495327; cv=none;
        d=google.com; s=arc-20260327;
        b=ObiDdrSd+tHDZAbeHpUfGvCWl07rbk9v3wSNTCzzBHKsmfcYjVzTq7QDXaTmd7Ht0k
         8NfY4wBRllj+8B9QJCYSkO/14jyAYjVmt5WClUx/gVjuWYYRq5Z340JrEY26npVrHO74
         UITd4bxh5UdyvvOi8I7MmNnQUydJsspIIdF3bP0wT7l5tE9+L60odIvtHSKLp7RTqJGX
         POCdOScg087+Q4X+xozKAFM4le4xfUfBUT5F7aiLKC7zSSeVJDUS8YEsd/TndoCjwhUm
         hrciDTMSyARz8XxERXTdZ17yhnHzZai7Q8tPv67erKmyMP8TS1ClqtvWhmPPdCf+5z1b
         iUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
        fh=fdN35gsqVx97PB5JCyMnvbTyQoNZifAJEpt9z9ETDOo=;
        b=BW8xfmwyx4UOcQ4sBF390AjfKMqCg/BRFdgvDPe28k8JWx0XfsvLrtvNbcebjDTfwQ
         aISYe3zwgN4HVsUzpFbdu6/qMljz1cwKMj3nW9Wy5RX1JSS1QfdienzyyIPazGLUbf2j
         LR9CEkFxpL8dAKI+vQIgiwgWKNdlL2dZaae5JPM2fpA2ppDvfZgsEJ1EP+1kc5HUjxGh
         nYQUHvZYPyM3OvXpjmW+gBrd9ii9UXN+62BGKUXRPcSBwUsDaQ7g96tj6GoVshbPdE1w
         XX28Djam3+8g7Tekl/1sMkCG6FcZtruJ/aNU0Mucd/mWubem6KSIk8Lj8q2JGe5WDYQA
         9k6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794495327; x=1795100127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
        b=U5KQI7tPQrZmVs2O+/K/2qinNoIrgmL+JN3JGy7b9UiDPeSLDrYZUz8m3+Fi+GmK4d
         FPhVPTsRS15yE/k7GknytYpWAG6MwHXBIIKa8+5OUMRQdlbNuFvA+ep3tr0dGAEsUuqS
         a+qAoHXBep9HV3bGKKYHTsPNJ9pBthMfNLk3q0DuYIG3pLV59xn/MzPe5hgZKfRheDNT
         6JXrnL43z2Low687s4+keArBSR7IBzhVjsWA3Ig96aNpRQIwExEY7RDDcIQ+BgeozV2b
         TQoClntxCegkGq8td3fNEFFkUr2rZefYM3k1Tn1u2EN6NmmUeW9xJMDbZ19emN/tNOTo
         3cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495327; x=1795100127;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
        b=vlYOzUO4CkjXO2jOZFNvfM+8qJ63ZgO2CHun+XKfdACAnIRB7ZnU/m5x8TzuFM6lz4
         jfom2xnCOmHKMHXMdLpC+n8HxEW4ooaVxSFlp5nc0Q8v/nSXXhTPEMk4Iv1Z7PGDbfMr
         /3SZiczku6dui3Pn1w7CoTV1/kwCL8SksuiYrq1b3hsc9yzdgNHkXdAd8iIYWtyNiWs8
         24vo+N5oRz0veqryOkBOY7oszsToVbgat24JR9JyiK5biYQHGkOWkM+bnZH1lsTMCWQv
         QBxvbj91pm5DzrUiGzl8aV+OZbjCM3+R/9PzK5i+bgAvx13UpmpRNHFLNone3S11Yzdm
         t9Jg==
X-Forwarded-Encrypted: i=1; AL+hErFw/x4mOtkFLFW/Np5SLteA8yuWtUEkGf/YIrf3BXRVMQzp4jwhSI8cVVXhZ++CYN5uA1DbII0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U1/o33Ldl5E2Hmek8vSGqCxfKlcAfzErYaah0eFMR0J+Nlr20
	rV4HPiwH7m3cfaWM2gaS2LxhUcdWM0R5xTwVD8hw2oC658qmdN/hRyMLTXu0OvpQDV2wXYWl4a1
	XR1/ZKktchaz/Y0uGLgMJ66KMFLosl4v3BH3tbSfr1Q/GQ9ew+EcVtPfgB1fY
X-Gm-Gg: AYBFou2VOQ/NYz1vkvSfUubgZ9ulLezgJN8VKv4uA+4KpUASrEPXNyfcvRh7v0lS785
	6ZZ3JdzIGIlXXlt08oAKIhfs4uH1davT6GRHWLpdYl4fQsp0WMp24lkoMYtQGlqlsR27YmtP0nF
	HZUf9h0Ah9XGYmSiJ2K1pYQshsznKfEMHiSuDEQHMTGhErCMdJlNfIiT1M97XOeVeEJe2LwJU6L
	BlPzFT6CpmGCUBStlgyPLyw06LLnxFDA2kDJNQzIvzWrCUYttqw5zrLNSjEJ9vJq+PPE2w9PyAh
	ZXI5Uz2a5zFgVJVTAhgoBuStyc4FocFp35UIeUpAklhvltIjUXLg8H1jAM5T5gNx8/4uLz7yv99
	Lm4N7gAgW7x8QNJQQEIxJq3xSrwqwcz2WoTxYrAEQnxHQR9xT7A3xnGWe3I7AA6rNheF3Wb7G5i
	N5BZS40XqY2w==
X-Received: by 2002:a05:6820:a50f:20b0:716:bb4f:9d1c with SMTP id
 006d021491bc7-719179b52cdmr2435932eaf.70.1794495327350; Thu, 12 Nov 2026
 06:55:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
In-Reply-To: <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 12 Nov 2026 14:55:16 +0000
X-Gm-Features: AclHuK_osBWVQK63DcE7gK81kaRbLSav5BXe8bL_6Bp3W1Mewum9RV7hacJBHqc
Message-ID: <CAG4wq-cXJtTzG2GO9KTL04b=prS+X67fRBJ=nriOO0G-24Rjzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

Hi Alexei,

On Thu, 12 Nov 2026 00:34:54 +0000, Alexei Starovoitov wrote:
> I'm with Stan on this. It looks heavy.
>
> How about the following idea:

Thank you very much for the patch and the idea. I really appreciate it!

v1 uses the skb_ext-like layout mainly because of the earlier pushback
on a fixed struct [1][2]. This series adds only the three most commonly
needed types of RX metadata. A 12-byte fixed struct that takes headroom
only when any RX metadata is stored can be a reasonable middle ground.

I would like to hear from Jesper and Jakub before I move to v2.

Thanks,
Tianyi

[1] https://lore.kernel.org/all/20250805172831.213ddd8d@kernel.org/
[2] https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
