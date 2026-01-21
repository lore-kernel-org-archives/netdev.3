Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF7376BD9
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012416; cv=pass; b=kAZx+5y1gxTxCnqmAvFmDQUBiI3nxQwhvjmLifm3jBuqmzbLeGHX7bOjDw+Jb9WKDHk624V6jEkCjmVNKVqfQK6awV/BgIWVcy/ZgXWNhx5ComWi4buwDTCIKoUIEVkmEhrG9Z4VfYxYZq+ptykhh7Ig42WFAL3uHC7VLHmUVIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012416; c=relaxed/simple;
	bh=BVOX60AhRYJpCVhZWlYiUswA/CUiHwHgpUpr0mcZoAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg99ndnkqLCgxb+lm1zPR82PrleTMJnDN8eoprOdhqRJ/52oBEOIodYzsu9zNfn/gYZ12SM84kTB46pjjBYua8AeS6AM+doiM2pZ+YZsmKrOBovR1bfhvLX/G0eDYFLukMnYFYAul8dxc4ll9PuVFbR6YexxIGIbsD+oGN2Gfh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1gWDfHt; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1gWDfHt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-501511aa012so114691cf.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012413; cv=none;
        d=google.com; s=arc-20240605;
        b=XzhTVI95Q7wIpEdnekt9WF/uHiNxeT06NVNf/avR0l/cNOQXik3CfGW4OlPE05srdY
         yyEHlR20ub5sAbu36gRT7IVZmz+u3aiD2rlXAEV8zETxwHqj6JX7ctpn7Qp20hi8A/Ah
         SO3yC9ov1Mw+svawWl2+ES6oTaRAJrwM/cb7pPOGXTbZ9DRJ0PjU0XVPMx1yeKzTC0B8
         TbBUWM2xnYVPld4vdOKO10PgeMesdUHjWlZTU9DbBIfILOgn4SBURXOlmVBMPp9dV3iU
         okKtzNSpnBQv5oRvFxONJ+PYG0Ie+jnJdRWUgxCdxt4bNSjZnwfu+8DgIyQ213KO4mYu
         bmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdQZ3mcwy3LVvsHTwTcn6/9YcgEUCg4a834Rd65nHAk=;
        fh=wS3eqYPktg6ZJbohRt+8Cjf3OWxobKX4ddwxuG6HRHg=;
        b=gTLxSY/HyBJP+lrgJN0keRfX0Peii3QcZy2gi+nrDSK9arZDWbBjNc6teahhfEbzwh
         y+MoPI9QVHTT/LtncoaEyR5HJkFJQXHnj/PxcM85HYzR6QeDmnuUBEcSFCqjG3/4+4Qs
         hQP6w8NLFNyvNt6AXtDxljYPPM2AWkzi5yV4whQPdwWEYIBYxcUWB09DhwWajKMuzidh
         QRgXjClDSch0YTPZWiq/PAujv/7p5BAXpk6dwMuBiZcVOBTagnwEvX4d0473Zl4bFXUD
         xqS8NS3rOhAipO8w2eco4KERlodLsn0JSxThl1Ru+/xBH9eMYtNfRA+eGu+wHY92uhWX
         rIFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012413; x=1769617213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdQZ3mcwy3LVvsHTwTcn6/9YcgEUCg4a834Rd65nHAk=;
        b=n1gWDfHt/lON760GJrq0o9VXDVcCRCJ6b6lV1gEm5rGr3YQwB7qNLyOwwrUuYn55kG
         wnB36mIFGARjxve0qPhEMyPC1ItKsf/PRL9SYOxFDU+soFeV/uWgL3ypQF4i6uWqFq6Y
         I7Dj0HO3zNKlicAZGib3OAuDhAt41pwiIcF3B8gVBktDX6Xx9sTx5gOGQuTqZgzstejZ
         I9sSEmkwt9e1HiNhJQnGJTHBRll6rRVOn+h9f2CTzXOi1tl4N1/AGL9zBwrqgd69RRAh
         5/lX9B/JStwssyLHg4cKxyRAt649XN7XqpjbyuBmtRH+Ay2xaQJ4mBaMeNWx8Vhb/EQj
         ZXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012413; x=1769617213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdQZ3mcwy3LVvsHTwTcn6/9YcgEUCg4a834Rd65nHAk=;
        b=oPJHWflElhL+JzjG890bByHa2EZaN3JtPI9ogBRfsKQnf9Uh7gdK68pp4/4k8yPUVA
         l2nvBaxipftWpTURORBanBmWdpp+c3Hey4KQjWeWxVdF+FaLtNuu1PNzhTwBIXQjxlO9
         WZBYPTcmrGhxkET8ogqgHdpqrWCGfKCdyg264AF14POIhay7HWqeVMpezCN29N6oiHen
         3DSJh/mcMzvjJtu8+2cso9UrTXX1H8L7nR227rRXb/NvWwrHwvj/OU3dFSHkpJX8Sceu
         yzWJlrUPjiIseeOxZVH5+Y214WSKN2bl4XbOpNEscMXn63DG5YMq/ylspmdtFc4lcYGH
         aUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzoqE4wfEmxmJaBh5CCdMqJm7dkyPbgVE9H8xE6JL0hgrLvGI4G5dN2B0QFkq5fSwPseD9dc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU48jdkDeqiLG3meukAzewLrB3JPabegsEaFTQmz1pZdV6pERC
	45jgF+pbuNt4rkl8diH7HhQtyKS6hFETFKIBEdpav+Jkw//+1iqHC/2eBg5x3Sf0LjI/X6fkKWt
	sE2mXIhGDecBPCyDvfMqGuMH37jrgOcZ2MiOJKJa2
X-Gm-Gg: AZuq6aJuFjj4i2uoo0MZkL+TDIlZe+l4DqafPBTf4hqzices1td5APfKkmjdDUZbsjO
	mTAS1Y1S0IhS+08WnTe17HFhNybPaXzVACAgWlyTsqpQqAIthFosYlnO+cD5wY8rdYpdwldGSvb
	+XJrnGpxFkANZypXJlLge4PIglTNoR+0tqHGrpBAc8po0lrSqTJJAq2Er20j7+F6ZhrftgZFx6D
	qb+XKefZe5g9D+VAkUzF4cbgNiKwZt5NiGZGW2tLhT5O+C5IOJyUKrMUEUamDs+97xaDLnLEixO
	GaYEc+MDnEjHkMUdppApMAYGBsl6fA8sIANvQM0Lm/Nxh7L+BKtAMW7wakqj
X-Received: by 2002:a05:622a:1814:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-502e0c62949mr14732011cf.8.1769012408219; Wed, 21 Jan 2026
 08:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121095923.3134639-1-edumazet@google.com> <20260121095923.3134639-3-edumazet@google.com>
In-Reply-To: <20260121095923.3134639-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 21 Jan 2026 11:19:50 -0500
X-Gm-Features: AZwV_Qi_ieR2uhxIrLPSeVg3ield3SXNHdHpwDnX0eBobs3grYHaU6YkJ-nJX4Q
Message-ID: <CADVnQykGAG4_dSrVXLn0UQesNHMqWpPtHXwe1JoPsTWgy-NQsg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: move tcp_rate_check_app_limited() to tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_rate_check_app_limited() is used from tcp_sendmsg_locked()
> fast path and from other callers.
>
> Move it to tcp.c so that it can be inlined in tcp_sendmsg_locked().
>
> Small increase of code, for better TCP performance.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 87/0 (87)
> Function                                     old     new   delta
> tcp_sendmsg_locked                          4217    4304     +87
> Total: Before=3D22566462, After=3D22566549, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal
