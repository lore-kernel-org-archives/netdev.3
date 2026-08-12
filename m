Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006F434E4F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537187; cv=none; b=ohJq6TFh8in2ZVKY8fNHiR2r/E8iY4zno4TnsLT7OUqgwE3697J46Jdu/fWN3Qcu9SS6M2dJzwVICvYI+mBPKav5hYe+o8VBWh9W0UNMcrOX1tweZMAD8aiH1xFSUpTMomiUpA4MKqN6Mo2N+77t3t/H1hEEPAC7t8cZcDRuAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537187; c=relaxed/simple;
	bh=yeiI06WvHdXmkq0yqqJR1C3yb7k/gKs4/f4gmZjGFLU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bOo1RMQshgh7wiANtfMOMy4NYIA/aKAUfV8994g2q/5uYwgWjqvFtJ0pRbxk/lpHg5S+LyqOpRYImpgvpwtTDoXtojvMWwihDx+yXYeUdok+TeL+pRMfdiAKWcjoZKtBAtltc1OcQr2pRzSswrmbcWuWKFJgsRvJsJFg3eJEAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd0DH2l+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd0DH2l+"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f3b227a4aso13498477b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537184; x=1787141984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E2ri2e2NGzYZHg9FODJ9M3blhs1q66ct/sjUHUEplCI=;
        b=Rd0DH2l+v+1n0nvGjCd6OHhhzffx+pg1ojL5Tel9m6/2SH9BKBbjK1ivkwc0HQI8wR
         rNPKFtEXdrsidT/OPJN37NF26lBKccr3k75DF3MY3Akhqka7Fy6SKXNAqdR8OFB1SN8o
         oBGZn94cPwpRzJuxMYBn0ZQ0uxj+iPnYqGKHL+dB5hor8cSRO7l6dt6P0GtZpfEF4F3e
         IPtQpDHirtE8TM5isZPYSWC+qaQ+cUJZelbaKOx1vqS3+XBKjkGvP29qQX57Df1XLyIQ
         cG7asFO2GWE45bYN1+4E19V6M4o36by7mgyE+cqfr14ypa2d9JB+DO2pJE5O4hwk/CP0
         dLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537184; x=1787141984;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2ri2e2NGzYZHg9FODJ9M3blhs1q66ct/sjUHUEplCI=;
        b=fEQ52KQiIzqlMxK1A4/mYiDq6W5bOxScsMEm8vjFH1XPF32A8GpaTswyDJAl89DEfB
         pF9PO20wqJcDl4+J4nTkYcetetfGskXpdN047APJ0HDB2vK7Yg3s401hc6zgZe1oLQRt
         rM88D/Leaw1dp31lFiFwTkSuKycrKKGxVG+slXhOsmHKBEQKBoHmWAxc6Im448TLHzxj
         QAX4O7zDLO0E36mIR+Lu/vFx+BJY0mCGELHpS/YqHb2sXLLlAXHbHWrQJaWBiyjvWRdo
         ZiDvhuARRNXnqT/FLp8NCGwWp5s+hlGVhsyFTJKiX+jCjCTrEcUr4/QOLNaEWEN0R9g/
         22oA==
X-Forwarded-Encrypted: i=1; AHgh+RquF8BxbCR9DoUGJMO2IxzpYGcIBtFakj07ZrUD0rryjRVjLGl5BWL2ox7K62cKAOsqzsSCRuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEqsmWVWk4Xy+Qpmd1rjvvzh/va7XiKGRa7/6T+SsWK22qBj9
	Dti5CDqJ+YW9i9Cs3Wgq7tCWFfS6UFYk7inFq1WjiMe0vUJ6SAAo3p5M
X-Gm-Gg: AR+sD13gVqkxabaPi8UdvaXJSu64Nc3FocAriV5XWNVxBp8vauSnd8z0DVBj3oY9FSm
	Hxn5szRlsN5gRSQQ1e/6dlVQ60uy0YP6+TWjgmgvOqTCQ62bcQNhGkUWBbqPH6Kbm9qJPk3CCbe
	SfqX0IW0C2Z/oiFWhkFXciZ8Oxy8ymLmdrlmxQTZauUvfon2TZRv+j+plLGqHRE4j0Fy/woI4Ek
	0wP3FiRrjw3ErfyjiLEs0YEOLoVJRIF7sAEt1YcDKa+7ywbzl9K7Wy0Nc4Xtw0AvC+LLMU//TH1
	/Z+pu0s5SHK8rAAXHP1gubvPqxAHwCUUNWUE6cVnA3PNooH400rx5TvyL8Mh3I4OQ2J0gLNS3MT
	/mYHlK0awO8hhcg+5fvKLL3bStw8MOfEQSKVaBeqvknaYyN6izjCRui7n6uQKacQm4ZzpGECHw1
	j3avPIzuaSeDkhstbENJEiZnhw3rvuFODt9/SNLhnTD6Nocg3eANFk+XLfV1Cuh7++FRRpeSmxn
	Ii5EJxaHYUY3nPqGXg8QJspdhgwvMpzqDhb
X-Received: by 2002:a05:690c:2783:b0:80c:f6bb:565d with SMTP id 00721157ae682-83108d7fd1cmr25152457b3.19.1786537184641;
        Wed, 12 Aug 2026 05:19:44 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a414e953sm11804117b3.14.2026.08.12.05.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:19:43 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:19:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1318c21ec3aca@gmail.com>
In-Reply-To: <20260811184722.2612345-3-joe@dama.to>
References: <20260811184722.2612345-1-joe@dama.to>
 <20260811184722.2612345-3-joe@dama.to>
Subject: Re: [PATCH net-next 2/2] net/packet: Use copy_safe_from_sockptr to
 dedupe code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Reduce code duplication by using copy_safe_from_sockptr instead of
> repeated length checks followed by a copy.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
