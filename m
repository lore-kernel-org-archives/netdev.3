Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423041;
	b=TE0+ij4stB1XuRml7Tonrtxv0kturUidZGPurJot4lk6jN4ZU42A9jUluAagUHo5nmAu
	 E3DcGYyUURol9Fs75/Mp2dM2E8P+Lrb/rzE9NchFna5BsIIM4DTPf5YiBeWjUnYgs5RMt
	 M/6NUR+TzYZt/txZY/Qoh1Yg2ny6kUPY0eBaNMqq9XNtkslhYRNCd8Ni7dBn9nkRM+FkO
	 oE0QFZzQWK0ldkADB/3CgLaGCK3VYhvYHKCDXjE+Kgsjjf/dMSuVkXw6tbWoVC6d9Bf63
	 E37tpWr2hUe/PkizcvlfPGU0n+YwsS2NQRB58zLUmhGY2jhB0GvI7NQfXtAtyrRBWIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
	b=0RBeZSM7UzHSvjvAF96CPpPcPNsoKeJv9qb3F4yDTt1jN/z52ZS3CUb/vBH190LBABab
	 rpr5kHjv8kVswf9oxw8+DxYQvxE73KPep/TpL85xfOSPLQW65HEwE9VDC7ghGBQV5jtJE
	 8gGbMttrJ7/OxpWpJR0yw0S77RodODeHYNpWdaoT7CLUyVR1QMHbiZRM495xvHbIa5XVi
	 Et82CaZiF1oU4+HCJ2J6AkcuLNhXZl51nNLQA4ahakL6fYmgKETvnD5rZFDHB1+71Z40h
	 QlMPW2AItWYkzF+Ign4iGndGIJ/myxyB+T7+vHpXFNmVxnCBVeGpjZbbCIck68Y5nOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ezLXwHIz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94D60A0AB8
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A94D60A0AB8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ezLXwHIz
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so18007a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792423040; cv=none;
        d=google.com; s=arc-20260327;
        b=HOZRkbGxCNCS89UOzN3cT5ZCXLcYe68QLIyEMW3ixZUWBIkeqNENN5ALVOQBQF5GMP
         Wt8gHo7CkiEDTolqDZtKLaRXKoL2Lq3Gw6HXchezB3/JFFAINGzCDFrPXFBWf1TiW/O0
         E1KDgE4x3DkcbuNANAJt15iaTTo3DoKDv8n6MZJlfwQS7YE2R/VXga7KmzMVlS9mU54C
         lkCZ+H8Xbhs1zulU6YoSb1Hy2jzQuL8rDCsuCiSxxyoTrS0u9H+PN1u9ctIZUZyBGGfo
         U4GKIp60LInt2LbTBObXpf6fyCAk1leO7E6W3se21bzzwCuE/2PbAbunRrlhrgIBEPxV
         wvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
        fh=1qiJ3F5uBo3fC5LI1LrOGTcuGDFIRg99y0nYm63EnrE=;
        b=CQfHtiim3d5jrhfUYD9a8esc8m2X5ezWfG+LiFUCcjIy7iYaZoSSNwn6Oq9UH0isaO
         zH0E7iuOoouUVCa+XyY83dIwRZmuKP6ONfS57ZWD/MKipEthdYgtanA1wIHuAkHa9KSG
         7zVtJYUjwclxcfNdwZmXt98E8SSww0vX1g/8iXCGxFjg5oqQkPxSzYMwEhAXdQ5vI8uI
         Cr3yH9ES7qFsKhz0yiBcR8BOycd+EiIvimJmuPnub9CVcS6cXQ7h0dcbzoplMFNSRmdB
         ptjsnfFK1R3ZMM2lnuM0u0Dwx5oDSVhh2XfCsgmFPrYecK2+2fCCc5eqYoyNbzpXZtTV
         Oyvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792423040; x=1793027840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
        b=ezLXwHIzPfS4sEb4a/lZXhXGEhuDtOUs1if1P/9Ak+Qq4maPAojdQ/9u0w1JCobLs6
         X2qdgAH/pLcQQVTxacqSHUYx6U1JRUcIZn4tCqNb3LkXxjpcgVHNqa3WoTOGvqyOills
         BiT2SHvEyuzjoiUDwEqrkKaqqIzh6GuaX4ulvYHeJnHQYLR1ElbgGP4U4xx7Lagi2fO0
         Vynf2ZaV+Wzz0LcbAkKRjY0IP9jZkLPwazVoJg22qEttAj4FtBF1o+o2OJakE541fU8u
         FgKrm31Dik2dQYyZFm8ilfQpMr5pGVDf4JR9znCUx7KiyvzqmlL+y1djjhWdf7HTbGCf
         568A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423040; x=1793027840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
        b=aAjiqk/K6pxPSkC/Hs5PBp0TrB1TS+5LPw01DGluFWqpx8DAcbFZPLQYm2Igjhx9XA
         ywofGQ2Zy/+cJbjECVNRQOzi8xupsmIUbRPubG1aieARdo7D5Dj1OKB/QeMuGXpiWlMY
         OQ7gU85OUbyp86nDXA3YyDn3u2eoHaMCPZAzPOW1MwAHUnHy2QvmIwyaAfTTqUKNTp3n
         p0gq/SJJ4y4AY2ajPOF2rOsqyCRqclQfJWB/S/02PVb+szszPErUfoUHT2/XL7SK2cWA
         KSgMSzHUjpCACjBMMADuTyRloAnKJh+B7hsfJRbhe4uH026mHUEcmuU3OMQB+UdpDIoL
         vVcQ==
X-Gm-Message-State: AFq9FYLF1T4URVFYs055PGDWWpVloLZICbM3G+OdqAQNLbDzb2OP9Nfo
	2X4cZ7EcTd76oP/krL8DKF0nKSi06Z4R2gNrh1Z/AI6fxLYLOzwd5x/IJY7fIE9VLXC6WMoJ8+a
	RLyeURf4GMhl1FbRONfmV5b8YtIfikSHGbv1Eoky9
X-Gm-Gg: AYBFou26x5nSTk1s6ttTRYoCNVoCe7HlbIi8OjPf2DwBU04XQ49ewEgy8KHBM0ZveYY
	tywCxlGZXg33n+jan7nRlDA7fZe30HIkunUzIWcYA2FLDHYsap9XIblnrk5fmhN8+GcwJH2qiTE
	z1JXafV1DsjW4X9pVpu7SfFC+CME7MABTbFybFL/dq7w/YWlwa9gBFD2D7cTm/S6a32LirxWOeR
	GGxFtCCE8AEBywo8Y7AbV9oCjAPUiuPL/RCBVpLQBxiXrOTDQZ3EbrW0fi3kPgFnU5p3MeEOpmy
	3z30orpoaauOz5pRquVItGe5zAU6fUx+nmMIEq2oARgG3biujgXxFosWTU9aa0ABXlUC1X7ILOA
	yg1PpiNJobA==
X-Received: by 2002:a05:6402:24ca:10b0:6b1:cee4:8d8e with SMTP id
 4fb4d7f45d1cf-6b3c73e2b3amr54877a12.14.1792423039402; Mon, 19 Oct 2026
 08:17:19 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-5-almasrymina@google.com> <179209666252.434549.1850964039919625643@kernel.org>
In-Reply-To: <179209666252.434549.1850964039919625643@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 08:17:07 -0700
X-Gm-Features: AclHuK-S5bmzvfsy_xN2FySxs-CZRN_0ke8ew0HfEdZQ0PJrgt9ujVcZv4HD-hY
Message-ID: <CAHS8izPkWy4mMj+mDyHq8rKfthzj3n7dj7=Phzq2sut79JydkA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/6] net: skbuff: replace __skb_frag_ref()
 with symmetric skb_netmem_ref()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit fixes reachable page_pool refcount imbalances but
>   has no Fixes: tag, so the fix will not be picked up for stable.

Yes, this series completely cleans up the skb frag refcounting IMO and
makes it all make sense and touches a lot of the skb frag refcounting
call sites. It's a bit too drastic to mark this refactor to net. I'm
suggesting just fixnig this forward for net-next.

--=20
Thanks,
Mina
