Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9C3B27E3
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157671; cv=none; b=lSXU5yEeOphNueyLDj38bpbJ0jJnOfudyFiGTDZHei8qBRN2bHcWIx+xIdxTh0tiG3iAXuHzCvD+jXn3d7/b/60oI+IBU3aL6YM/KWomoZ//r81d75hXSDOIvxqeUS9S3XrkZ9OGJhwWmFEho1WgwOarATLR07esUeg42lq/AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157671; c=relaxed/simple;
	bh=uyz/iG22EQ1cE1shTE/tz55aLL5WmcZtVb0ryFqx3MI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g3P9tF4ctoZTJQlYe7+QnLuQmbb+icbGdH+vQgjwEjhvcZ2FkwOU4BpE/CZmcKOoksC0Y+ctTxeBtBE2Thb4hkkRCQh247imI82hvQzdt09I495R0UdTnWFhjavlzYIUUx4eGuAEhmOqFshC8MSp4hos7f+PIid5ctjJLaR8Dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RwmwC4TZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RwmwC4TZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2531f453eeso469132466b.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788157668; x=1788762468; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KQDT/SFGyAqseQi8iwPfFYHbeuqX+da8RkpHa7uHvug=;
        b=RwmwC4TZCzyD/aEggEOeCNJrCIdPueoejndUacQEdcrq9SZhnBsMI5kYyCgd92/puY
         fqLGaDH5jFySAssK5e6chjzaf5G/5sgP1zeISQBWU5TrhzBy4ZhbUdsCMlJBzBWapqAe
         jVxzqAELxZXSoiR/Tr5g5Mb9BhZEgKRSzOrXZP2Fx0OZ4Tc4SuMjhlOrWc3islAL4VXa
         Hef+Y8vml8PhpT52Sc/p/aDk3jz0zQJmNSS0zUA2FL9E/KeTM4LlLceeQm4MRq3LIb9i
         8MKbuZukk3VdV1ojAmoAwTUF9uIkRNMexci8eC36wA9C59bw2QnVgX3Jiel1auTTOAQX
         v+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788157668; x=1788762468;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KQDT/SFGyAqseQi8iwPfFYHbeuqX+da8RkpHa7uHvug=;
        b=eiEpX5Sa8jGceNttxZm+fLoOJtycHzIDL2RIBF5sPmAr4XFNjUf3Xaau+sVBon0ntC
         cwwIEGIKfshcwYVt93qYkMCfAis0bn9JOHGPvPRzAvlBrXI14eH+ciBWkh7S6yipCs+7
         tngzG6fhxKojBYcqRTgun8uQa+8c3UsMQ9KcbIIOft9KxRQku1FfUhNuMh2WrxcbhHvd
         tYuBOwgMeQtNkbek7/p5mn5PrVy4zSMMDFxWqPLk+TJnLxM+9QLC3ghYj1SrW4hC/Oi/
         /WYxqcxXz8FN/E88WMSB81bEnrJGXi2E1Gja3br1jfSkuSeuMu9BCm3yrHmthC+JwQqa
         slSw==
X-Gm-Message-State: AFuF++kqic/ZidJZ1XtcG/AE1KeScV9lcbhOKYQRQaYH43lY6FGPb4+L
	CCLrgKZgIDstj38fjh0Mwx3SgNRlO8xPG7a0nDjKwzzKChqWQSpgGlI8IlRAWn4mT/c=
X-Gm-Gg: AR+sD12CjKoyNWKvTZfGvbWyqzmFs1bJP5CIhpEN9SlVBBTrQRGGq5g6Nf7m5DFp8b7
	TlqZh+rVOiOdv6zZGvRD1RDjPnqK7i4Sy/EcdCgPZ84uEC2/YiLnP8iJ2jU+UZ0jPZPvA6SqPGl
	qHp4IENVAsOgbaQ0U34ZPkYeTXj2grGMziwJi6VlGc8cO7S/GovzNMFqzfSx16lBuJKHwvIPImX
	gcMh/AkcRVBEIXw7Pjs5CnhQhorkJdTdPlPd/6NtUCoi17iBZCDkzNLBILvYEQI2m3xecgLfYL+
	MTdQL57lu4iyOU/8IRlLQ4wAZ0dQyGsEqCtyJgEibkCrvoLkk1zZjj97bO2wdydzi9oBDKmDYJX
	fV3WTa7akOYa1XAOOJCPJbguoUteG4LOuMfgkMwDeKMjxrB+LpP8Kw5My6lIsJF5MX8dBvYcFTv
	895JoO1u8CS0bBnjVwWChBYJWNEXyZ7HkelMJ7qEfpV/IZS9So/qIDV9o3vDF/GNS3hO97OmP00
	GklX5FlAHVPmKIQ3qFEX+mAbnkGStoHA2BpsQ==
X-Received: by 2002:a17:907:1c0d:b0:c25:8c05:902f with SMTP id a640c23a62f3a-c25ab453e48mr82721966b.13.1788157668444;
        Sun, 30 Aug 2026 23:27:48 -0700 (PDT)
Received: from cloudflare.com (79.184.131.109.ipv4.supernova.orange.pl. [79.184.131.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2564e314a1sm353166466b.42.2026.08.30.23.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:27:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next 0/2] net: Prepare skb extensions for reuse across
 scrubs
Date: Mon, 31 Aug 2026 08:27:37 +0200
Message-Id: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkelWoC/yWMQQ6CQBAEv0L67CTrCkT9iuHAwoAjyUJ2ViUh/
 N1Rj5Xqrg3KSVhxLTYkfonKHA2OhwLdvY0jk/TG8M7X7uwvpFMgXjMtiRd6z2kiN5yqsueqLUO
 A/cwMsv6aN0TOFG2P5m/0GR7c5W8S+/4BAzJaBX8AAAA=
X-Change-ID: 20260829-skb-ext-prep-work-0f354de5a4bb
To: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

Following Florian's suggestion from the discussion in [1].

The skb extension allocator retains the extension's offset after the
extension is deleted. This, in theory, allows skb_ext_add() to reuse the
existing storage instead of appending another copy when an extension is
added again.  However, it also means that we can't rely on the offset as an
indicator that the extension is present.

Make the extension cleanup safe, even when the offset is already allocated
and set, by making the individual extension put helpers idempotent, so that
they can be called multiple times.

This is preparatory work to support skb extension chunk area reuse after
skb scrubbing, which would be needed to persist BPF metadata skb extension
across scrubs [2].

[1] https://lore.kernel.org/all/ao9UV9S7rUkyQ8jv@strlen.de/
[2] https://lore.kernel.org/all/64365932-c765-472e-bf6c-b07c9ee25eaf@kernel.org/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (2):
      net: Make skb_ext_put_sp() idempotent
      net: Make skb_ext_put_mctp() idempotent

 net/core/skbuff.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

