Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418734D4D6
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749762; cv=pass; b=P9Fzg1Lw1i2b7WXYH0ih2tX5qwsRG3KbfCqt1FLq67c4SDatx5xh7qzV9Cz++r3oPT+g3YIu3yw48LWA6KhMU5tCgl9SQBibRZ3lch+2Srbv5Op5btPz7Kf7VRiejov8Z1DTWSz/6JVs8morB2JHrrVCZeL96r5CK3kkPMMajyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749762; c=relaxed/simple;
	bh=1/gZeMfGVv3FIHZDlt9Ut+RQNovU9/42KA/yQdjOjZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0l/8x+OpfU5dfi5mkmtTzMIjOVJVa/m61w/OaTTd2IKMCy7Lv+HLtm8fHJVa9h/bWOwM2g1O/Gp9qJzzSwhN/tcYzC7xxuQ0WiP5Py7lP8jZxNB/gSxecULhkyxPIeY93sBLPGZ7QE7PWUF7BNnaYivOO18Hk2S6Y2i27NvaTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmI3l4lI; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmI3l4lI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso19795ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784749760; cv=none;
        d=google.com; s=arc-20260327;
        b=J77KkLaGWnKdz0l2neHVIUilCHn9y188DqYg0lP2VSgjbqDAIn+KlAb09cndFGydZj
         jgTKmYKOKmb97yECvFi4HF3A4PohLMDcguefnKF/fuaCt7h9m8MU8kw4/v1HGEGul3dO
         x8MluXWaeCxkBmkBVyUGU1h7LdkK68bF7ZnUsh2TUQ0Pj0lF2HxDdqdH8xSywBtYxDvh
         8sTjHHp2OL8SCpttV2bom2QTlq4o6+zofIFYygDEMVgcizuvg1EiVWgFs035FDT6vH2b
         o+gyonjmMbD7nvTsqJH/83QaFaCKpe1OsE/3vOGmhfHNrgw0nChKQ530z4tC9kOV7d/X
         mDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/gZeMfGVv3FIHZDlt9Ut+RQNovU9/42KA/yQdjOjZ0=;
        fh=dI4IPUe2Aw0HuFO+p/a40Xxz2j4jWp4jV4JL28SXwyQ=;
        b=dCMhBxCmtKFYqM57vu2OLeGMfnqLIYHI76wrWe56Gd3ICTYj7gPulJVIawYRGhRU1J
         WXW1SAwWv5tPVSK/wR4/rJKRZ6f8bAYAwHhyHSoED69IblUvWUi/8TCZm8Kp7zm0W0gW
         V1WsJhZuvaSTEHuHhHCW2h5MS8fR2w1sXeiybzXhT5HLD8fl7fZBJZcC8+IZxvScKX5+
         UsS44dlMh3C3x2bTotXpFQ9BCIPpYC6Ruj55mp5TQHFQAkiqaFmqTcbSpCzhD1S9zEuE
         DLMvZbZGxwN2YkmOjokPeuh63DUCeZtJ7SkTJnHlKbsGHP2adtSGZ2J5iKatKmSX59hu
         6sAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784749760; x=1785354560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/gZeMfGVv3FIHZDlt9Ut+RQNovU9/42KA/yQdjOjZ0=;
        b=FmI3l4lIrfIYw/84a0ZQiaA4SvqD8osLSWKzNIVIaVn73FgNl3jJ3BDYkVDGy6nzJf
         NmLGs9NDFU96Dxg0g5EHhI3M609fp+teo1zcceVPbUOpJvEM8/PVcaZsgGfAuRebCaeM
         MeJpBQj1HdnDD9jBGlNck/hWPcXWtCSSgjEYyGjb1Cs+P7HSymDaBKJ9okxZgoN2QhbN
         nbK/xECDw3LdtuPfUIvmbHCErpFeCVEg/RBO/zRUmzGuEiKLSeb13k9/o3/+sOWSsM2j
         cxOc1uJ3M6ZtUu8jhncV1TdyOHkl4IbdtFGl22/PaXZnmPbwbYvpXwvVMiyjChk6Bqyw
         gm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749760; x=1785354560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/gZeMfGVv3FIHZDlt9Ut+RQNovU9/42KA/yQdjOjZ0=;
        b=pbAhUlpzQQknFNZkm91N+hrAa3hBSJcr5X7dbuhwBSgTFS8LloS9L0HwjVHyOcJd7v
         uz74FKCZn3st8veoFrUYPLvr0+P9gFjWTSuJ7m3v3Bzph2VfLYCDqoV984XzcXJiB8/z
         Xaeh9pYxVvNi6jggBWnATWHVlrdaGVt1Ray9N8pCgNhCWN6coO5qnMeZ8NC/VhiXRKfa
         8Ij2ICWd6BIxkHKa0zbAdhBfw19I9Xqv1C6V4FQjDAOH95Wmz68fL7kyTCzuz+FP2K2B
         WnBXx1VpzhpFkPASxEaCndnVMAXqXcgJjQcTG94nWMWsb9QUCkKW8tVYCLwytoAU3h5a
         sWIA==
X-Forwarded-Encrypted: i=1; AHgh+RpjBxXGtUTC088pdQOu+7RbJ0adoWZEHiji2obm1z0jnci9pvJYgHBYkcN3nJF8iF/LthLtbSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRExx2CDMfrK7Gab4M+QP6pgqpAj6PgmvkhP4Vpf8oVM3c2mvg
	sVMoBhx8INz8FziBg9fzoDy/GmswqIIB+JBHmrGXCDGV/nAWFp9XShjb1osCehCn0s32xzCiiV0
	GxVU1VWNg/8Sb0zTapLLJ/FTX91XbPijOogTZ6DiG
X-Gm-Gg: AR+sD11YI6lQqZlGszLrR4TTWOBtQWtQYg++TsyO6IL7RSq53qjPrt5KCCumQWlgf3R
	iOPKbqj57BaKCbBeDe0FMF4KEvbMTLS9mkaN0YTdUBTohRjEMPFoM8eCm4/YdtRCwRri/UkoFWk
	ecHF6WWjQaYito85fT/U6txKcEFFjI5akyav3ZWv4brHkyQ1uFYbq9csDmUGmdSueHMJ+byQp0k
	uDZZDtCpUkVp8cr49JwK2gbTiskImLZ8xfhOBym9IYuBNw1ekJVBt/pdqFmgqpXRfPnaIUnT9kf
	BzHWbYTgc19pn/FwDJA4H6CU3+U=
X-Received: by 2002:a17:903:198c:b0:2ca:be81:b469 with SMTP id
 d9443c01a7336-2cfa422522fmr1360705ad.0.1784749759768; Wed, 22 Jul 2026
 12:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
In-Reply-To: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 12:49:07 -0700
X-Gm-Features: AUfX_mwrk9inWgQBT2WJjCz3rpnOkwiRW5-1uHLp95YZdn6ed3rUv9fq2_YU0pc
Message-ID: <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:59=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
>
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

It's true that we don't support mixing niov types and doing so would
blow up, but this is an unnecessary defensive check imo. The calling
code should not (and does not, I hope) have an edge case where it
tries to mix and match niov types.

Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
may be fine?

Also we don't really support mixing different niov sub-types in an skb
(like IO_URING + DMABUF) afaict, so might as well go the extra mile
and check that it's all devmem niovs specifically.

And might as well put the check in skb_add_rx_frag_netmem. It's the
same situation on RX, we don't support mixing there (and I hope no
code path leads to mixing today).

--=20
Thanks,
Mina
