Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794154756;
	b=Vmf4EsPRdEf03QVZOomg/cj/7ST8xhE/n0aJ4monDiL7iyzuDcoXotjno1be164909iE
	 0vTXOXHMq5cuQ/MLfTITicteJ8hxMGQdrZnycBbjOmSYVFW34ms70g0gZd4bVzkUyFpm6
	 7/F67t0xtWMsGlQP5nmEG0fXC8hBNhkFsHeh+/3HV4JclNG3DrFJVrUsAPmwWJPFNAzIX
	 aiWlHzxZqxhhyL4k6gLTlAOhWUD7Neyq6CyQ3PtmTQ6TjlYcvUb8MrmE134q5RoM8lgPZ
	 qwfZogOu9l6qoa88oWVsmdhuJwW6sEkyJlo73CkwKCpyEXkLB1L9ML5Asi38MVHpQMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
	b=R+SyUprqqIo4TF4tKTJAM3aOVnMpRiSOBHGQL2VwwucTb89DHhpFm4IMz+CevX5drE7c
	 mS4SK00YSyWyrvIX++oQT84AtlKtFCavgTRYDLx9iXRurS1f0bGBOEOnZxyWuhcqiLobF
	 p6pbHL/Xbybysr8w1ysUJPD4XWoIoM2jFIdyDEry76p/fFFOacNnIQKR5ehc51d956353
	 pWmfBlImHMGlHLk4IHE584JOFolH3uaskxPLGugVqVZx3F3LAg92d9WIahKD+96TIXZPp
	 HcJnNB9R137862GCuRizW8ozm+HnFsl2eHZVINRhj7pOX+iOAga4TilCG62nGlkNmlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=UnHJPzGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB17606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 16:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB17606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=UnHJPzGX
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c247f6687dcso24319266b.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:19:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794154754; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfTerIQyNOkOf9RkiG/v/bypSve8X4w3eeMz1fueMXDMbKc91rvERBx70fDCVQoQHX
         3t/UEqvIY3o6na62jC2638+fWyxm/lcP+jJaBFlC+aH0xM3nYLgJzqf95NqjSR/m+iX7
         VK8qXRV24rd3b3GxVsztJOUel/jNSVTyUxeo8cay4MOFJwBKtmVpQxxhh/nGiMuUq7Y1
         NX0UnK4eAwzuWy6mGzRWJxj1W2iQpoYzUdULiyEHscVa4WnrOnJ7IJ7D3zW2ZhBRSyz6
         CtYqeAw/pfI+i/vqoNjdSRcRbuDOVJCWrg8r6cRvCCHMgKce3kMEDkRfUiAZhXj/AuKG
         Dajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
        fh=5P34O9BiSm3lpSGLVJ/dZNzdg+/do69B07Y4/GwVQNM=;
        b=s9OMEvOWV+SxO8vP+bIWfyu/buwYvCWMLhG8eMfNXMf7703bwBmgq0rWYV7uCiMBXy
         ODqelEYMaFXQf9Ru3rPe/V7HAZFINK+abU4eMR0bOh5EPK+x8B4imEHTDhdrUW1gLsy6
         XCZvUU9Y0SM/me2CGaO8cTviNorvdJ4blKB7JLG3Ndl/1JbPtb00f4lI5NCv232PXeq4
         uJXJutsqTsd/7fMduMEl77PYNjkJ/+XsTBgLBWyIKpv8NfkNvsNPqLvRh7hurKXls4Xk
         yG6gfszMxYtmRJSLeJZCgrSizuv+zl2uIsaGFFxnUtoOM1hhullxpQw24FBGKhGqz5sB
         DmKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794154754; x=1794759554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
        b=UnHJPzGXqtf5M6DSoZKrR6UHFBMfoWqYMQ1Rv17g7fWWT+sUOEqe3QB3lY70652EHs
         R4u9V0gcMFrFvvSx2428DKOdXjulw15zG2Gy+Qfh3Tw2JxCfbPsye6YS1qby+4Vh/LcO
         Xzdrbu808uhG44B8h5piODGDrpJo9JOx93iFfrb/IqbcGKOeWlNJGCJ0hA5eBs0PBuPf
         gCPhGndoxAT6kRnicgZ706hl6Gnyq556H8teishi0UUNNcmQmMprjdC/vEt+ztlS80Ks
         vDgdeb3d6MYYHH7yqg4ylxT4o6vYu9P0xtrKBd0wphb4zuKRPhhIaLnZx88GNjKCbx1+
         M+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154754; x=1794759554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
        b=ZIiguHfDiJHCfJLXLaO/lgpRlRbpRN5DWZ50FlHhxh8NcCp5d7Mg3g+Y+0WnSkTK91
         P/RXSYhMhdLq6xgfq0QJw4DZwhYuZytRQ4wkwFLNglX3i5UUQC1b3JE8wIIVSPiCKtzJ
         QS8xND1MsLTV+K5S7bjNyRcJj/0SrRP8VfXanK2HWiv38AZl2s+m0stdeAip/ahAitUu
         FoXaCybwWTG9P0xW6a3MdwTRavCsqpUVKkOrqIfdZBfHPMCS4bBnMDDSnENEiRj7FhOC
         3YkVlzJwW+GzONzh2/IjCGf76DPnQw2VFjdgRLRW4Yb/ozktFbNncntd+B7Nt0KTUjhf
         A0RQ==
X-Forwarded-Encrypted: i=1; AL+hErFEwl8sB7TIRSrfhil6ZZl9Q+Hu3r+OIw7bHwjl4Qr2OzNq095NX3l8KnG24gVELFsA+Lkgx/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VR9lDM4UNcn63+QFrxrIUJrXZL1u2BSDVF/lA2/AhDw56Ofai
	sZwh72dcPbyrwPvrzHdY08nU5zhaKSrKuNIVRwyoqyNtxwCXzdLplubMY9ifdNV3ZwvcTLT0V/P
	IlRWy+V+97YTOD7pPBgwKex0IeuL3Kvy42PIlcdTi
X-Gm-Gg: AYBFou2fQ0NIKkV7XEvroIKUo4H9QBRf83aI6I6IVHmyxhML0gth1q9xAuTw11Lj9hQ
	iXwIecFgwp0S61ksUrFN7TohBCXJN9zeIaNIwDcvvXDQRaee/V4SgS7EneIZb7mAmOTh5QwyEiE
	5GR8Ib15d4OnccX2XNeuEXNOMOgLD5qaQzvwYq1dYO5Mbd9UaGxAeUiRzVjeBUd2M0UZ51eDwAe
	PKuWU5pJmC0vWxlSkLdFAdPY/pBxfvnvpPh2yCqDmFPYR69wqFCv/QH7hcE8Qy/rBzTXTuFb7sg
	RQf/3A0Y8RsSKIqWYcKxNGW/7401Z/uytnaSi7nRpZEHrsibOLkE6dBHXdGfPeGtt/92Qn7geiE
	u71oooHH9p7x/q0IDWsoWeopqDkSxyD8rjfxOptEAZMoCIW9kOMdDxzpcolLfNCHVt4MEdgFaE5
	36NNY9So8F+KVqJsyWEw==
X-Received: by 2002:a17:907:3f8f:b0:c46:7ec3:fdfb with SMTP id
 a640c23a62f3a-c4d6d1af6fbmr112340366b.7.1794154753715; Sun, 08 Nov 2026
 08:19:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Dmitry Safonov <dima@arista.com>
Date: Sun, 8 Nov 2026 16:19:00 +0000
X-Gm-Features: AclHuK-RlKB8cK6nkN9idStz4fDt7ECu6dP4yCWsCwUDnlTQSNjJu1k9KvIrby8
Message-ID: <CAGrbwDQFY8gBtEKi2RaSMUSEvLLVADspgoLLppwNt5XQgd-hxw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: fix authentication bypass via unsupported TCP
 auth options
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 10:49=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
> least one of the two features is enabled. With TCP_MD5SIG=3Dy and
> TCP_AO=3Dn, a packet carrying an AO option reaches the disabled
> tcp_inbound_ao_hash() stub. That stub returns success, so sockets
> configured to require MD5 authentication end up accepting
> unauthenticated data. A forged AO option skips the unsigned fast
> path, which is the only place where tcp_inbound_hash() can return
> SKB_DROP_REASON_TCP_MD5NOTFOUND.
>
> The inverse configuration with TCP_MD5SIG=3Dn and TCP_AO=3Dy has the same
> problem for an MD5 option on AO sockets.
>
> Note that TCP-AO depends on 64BIT: therefore, every 32-bit kernel with
> TCP_MD5SIG=3Dy is in the vulnerable configuration.
>
> Make the disabled stubs reject options for the unsupported
> authentication scheme. This matches the real helpers' behavior for
> sockets without keys. It also means that kernels with TCP_MD5SIG=3Dn and
> TCP_AO=3Dy now drop segments carrying an MD5 option on unkeyed sockets,
> as kernels configured with TCP_MD5SIG=3Dy already do.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>


Acked-by: Dmitry Safonov <dima@arista.com>

Thanks! Nice find.

I think TCP-AO patches tried to preserve accepting MD5-signed segments
on !CONFIG_TCP_MD5SIG kernels and AO segments on !CONFIG_TCP_AO ones.
That's why the default stub was to accept the segments.

And I prefer we don't add prematurely ifdeffery to tcp_inbound_hash()
as long as no-one complains on this changed behaviour under kernels
with disabled auth options.

Thanks,
           Dmitry
