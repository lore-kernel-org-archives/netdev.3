Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110437F730
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300104; cv=none; b=OM46wyPFVYG4UMt/vDAhc/up5GbC30gat2N/bsbiZOgY/FpPM9+IzBwqmBqVfb+VrAqVL50nm1b7zCHRZz8dsuBmtTcP6rR0NbrN8qgCh/oK1rQD9FAsjNA/MDfSETsPsXDPcQvX6UR90oCjD6TFlPmybX+JLeCUEYLrpomV+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300104; c=relaxed/simple;
	bh=PPh/yHJJEF2dtbBl9akX/pPPG7e96JnmJHW2v4Ya+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7aozcD2TGSLd7wK8XU77d8cBKyWf/HwyXZqCjgrxt8RWT5b+4bhOHkqfJhv5oWSybr67xywCbIYuji/gS2ATkB0vra0ebIr9zmj3BXayELIQqOd7lIyEScSnKYHXyYdUMU+62V7OVXJo1qRMtgbkfxNfHlP1pVRCoOyO7RVb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=xF5fUvel; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="xF5fUvel"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-852c481415fso471089b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788300102; x=1788904902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKG+1F163T0ywi6cswcJCCbU9NOXY8GkYbOubzp5VMQ=;
        b=xF5fUvelAiJ7VmKh2BkYwvE+Uc4S9+nrwi5xkG9yNMEZJW9gIGb1Fvf97k1mtdMfkB
         6NhmtaE9Hr7an2ze3EvDihhEEs8tf6J/KFi0PRwxJ34lerYzKOxzea2odQeJ5waT3Al8
         V8DVc+evecd9L0ZMg2Pu71lxUxff0qO+Tbaz9F3C0mI2KFBy1d/gZIuQ5OI3cjix5SuN
         qW097xLXUm7zAdcLspHg+j+KNYLyUBYwglhYJXR8xkcsFOOdG/rugE11jrv+gGN6i3HG
         Fv26oT7qaBSNG1/HNLVuszqlVcFfQOSUp/nExwCTRt5i4Y0FEK+GdLa6bkP8CHcT03Pc
         k4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300102; x=1788904902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zKG+1F163T0ywi6cswcJCCbU9NOXY8GkYbOubzp5VMQ=;
        b=lZaaDKtIv0SFtFUlGFieTADinROrDMjhT17HDKci27cNoLxuZ+vKfvlA67KtotbGxH
         XB4LLpbX1Hrct1ZdbCLANkL9iIspkMAvmDV919MgcbO33cNKzJjAd7lx6FhLxcIdcoMP
         UG9fNnTRNPBRn+seTBdJi6plYT2jMhwxklogg6xKobRFpnta7dLga5KGCUSL5kWyEJkW
         sVBQ9kj0QWxbWT5FiSaVZvSc1wT8aQJvLb53uZ1w8SPQBp7AQVzLQID4vW2dlsLD3OAh
         F1ug8YNk99C+RgiOBYXb21cQm+uXFcqWa/z01VFYd6TZWVmPCzA275+NDbp8zzsLT38y
         UkEg==
X-Forwarded-Encrypted: i=1; AHgh+RqAnzHATdbD3G63ykqMF8lGfLsKl9BmXC4vT9PPQDUNCEqh7bvccLIZiJCyURHYs04QbEP3Wa4=@vger.kernel.org
X-Gm-Message-State: AFuF++lNOWfwL22h3ldVGMX3+Eh+cQVpeOC+Hp94lwVMux823m6slizP
	GAWswLbPLgZr7P2raM0/aoRxo4kL8Y1VaA5ZNbGIBCMSYR3kAH8KJhw1bmOmiKXpcIo=
X-Gm-Gg: AR+sD13BIOQ2WrxjM9azHpjXokZ7J/dJwsmqo/w5dTnIk7/yACJVUDIjRxqrOQ9Z0CQ
	5Q6jinJlAhBU4qyYhh5ln/5WvRiCDc1wZVNphdUDvHPWbS5EyDsi/Ief1APfy8eWOcUzM5BOHpd
	1X9uVyUm+b1ExaZssAGf76w8XCusob1V3GTmQBfwTBsXIKvpiaaBtYn1mEVup4ogKDB7nAK2yeP
	qi/Jr7BCuq9bQzxz7sdJmMVRG+Xq5QD0/pc3Mg9NShmLI2NvuxRDdQQ4+R75nxlEaQ4wOu5Byyb
	y6UTwXpTTJ1MDZzsKCcVP5aHl1nZHhj6/p5gSN7PNkB+6aApumuP0phU8b8RBvT7GX28zANtcZU
	7mrg2EG79V4Xhn/prElid0wZ5rHVl+eqNT/8L6x2NpzXAVFLg2NXHatrAggSYd54ElRj/Kam7XC
	KksAhBoVAbpG/+QXCT/VBmo+Xw/4qiFPlZfAG8mI4osA==
X-Received: by 2002:a05:6a21:7d0c:b0:3d1:fb2b:c74 with SMTP id adf61e73a8af0-3d9ae9eb81cmr337044637.12.1788300102006;
        Tue, 01 Sep 2026 15:01:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc347422728sm127798a12.12.2026.09.01.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:01:41 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:01:40 -0700
From: Joe Damato <joe@dama.to>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] net: ethernet: cortina: Count RX descriptors for
 freeq refill
Message-ID: <apdLRLTDFk7VPjwW@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Linus Walleij <linusw@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
 <20260901-gemini-ethernet-fixes-v1-3-ee6b09675876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-3-ee6b09675876@kernel.org>

On Tue, Sep 01, 2026 at 07:04:57PM +0200, Linus Walleij wrote:
> The software free queue provides one buffer fragment for every descriptor
> moved to an RX queue. The refill heuristic instead advances by NAPI work,
> which counts frames. A fragmented or discarded frame can consume several
> queue entries while adding only one to the refill count.
> 
> Count the RX descriptors as they are consumed and report that separately
> from NAPI work. Use the descriptor count to drive free queue refills.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
