Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9103272E56
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780611; cv=none; b=IFxPl5rBsOyA+ypanYcRieiGrBeyCnDVc0Xea/5/Jcz4j9oPx26hBP67uIJJOJf3a4X0vvhh0lt6s6Q2WRw9swknkYIWoGXh9JH3S5Y8wJqIDqPOMAJbxAsQA7L0ML3hRK7jbaht2DojdbT8JNugkxKHsrv5OxeYA3VouoUShvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780611; c=relaxed/simple;
	bh=ih1hA9pkwP8L/MCNP4uRdj5lWZxa52mA9WZkZEjpN1I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=JNCOMPPbhBCfF/EwPLJRLEqF4HufxSFqVgtlbXL9hc3veBFY4LOOgswhtwBJeuf8O4hjcrnqATkFX4xcRP5XL7QMR+31yGutOjhLG7zbRmkRMt+pLjnuDAkcSzWz/ph3YgD5wcZ3bt06zSreU3GhVQko/QoZgfA0b3nzxhomYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orc04B5C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orc04B5C"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2247e38eso9627655ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781780610; x=1782385410; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ih1hA9pkwP8L/MCNP4uRdj5lWZxa52mA9WZkZEjpN1I=;
        b=orc04B5CsDOnBkE9B757tiunTwtc6FAlJajDjwl1WBbiw/3p3ijVG4fnTPzY4T+vPl
         ImfZ6i5Zv+z+oJ0L3mN0ynm1CRmPlIwfiHuNWHa0lHRTWc/4LXQv+CEXS/fmgjtGhoPA
         Jqb2WS7xWBlATZBVHWHFVSaVeFVSUzaTzIRQWV4LWs0W7qJLQNeNSqWWQhAeA9t051kF
         deBD2Wglapg2iNvw0C50ELbXEALG1PXJnT+34lP6/oZfmWME2dP/FK5jA4jJzMwiqran
         InYt9mPay9ikdC1QjIZ7KcemAtwllMd33oXLWmUf3PdJJPD4+kdmg/rEswm6RW3riWsY
         HANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781780610; x=1782385410;
        h=references:in-reply-to:mime-version:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ih1hA9pkwP8L/MCNP4uRdj5lWZxa52mA9WZkZEjpN1I=;
        b=LkkEjALAu+dOoiw4C+Xvhg/WeYd0WInbwq3fMxrGAYodA13RtuG2oJuxETfjhCeLzu
         Cq6UBv+D9HOUK8Uh2GffNYwSCnsSiW1yuAw8jKRGdOHFfzVMcSWx/TsQSxsD9K/d/oGk
         4ys6MKPjljKc2WCz92YNtau4IkdgHyWh4lUZTln/YYcgfwVbN66fA+U6w7Ykiv8aBKG3
         OMc7/LoNNI67hYirCzghGdx1uUsdOEILKW4TunEiTk/xpmdeDLmWkSkCw8dq9IY51nct
         prSxV2T5Did6cwbfVJxX6p3/GPLz+K+bF5yGLz3MBFufvCFFt40CnTbNLCiQgGwn1Lxt
         m3/w==
X-Forwarded-Encrypted: i=1; AFNElJ9AUve3ONFgqwAiVq1heH9ekjzjnVi6XyM8pkvK+57cCLidp38Uyf5GwA40mxXb3hdo7/1xIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jbMmPSuBJrrqBlYAIs65rc9BaKRIHtf8yd+E7v2wtQozfChx
	JBN5umdfH/5vQ7g3nls/uM077dvUeNNyRW9bIc5JhBSoZ3zjK34qPNDU
X-Gm-Gg: AfdE7ck5QOzMs0itD9/2bhm0LBLbIg/4fjBW5WvnpF/jrXMy4L6BrNQWNmn0wSiJxbc
	yH0CsvPcg2SiI6kxKQc1lRNjgm8uf6zDb9Jv6aeeV0xHb8OaLVA97j+sz1NNdEVnGZ2nETaMW9B
	B7ms+H74AfVD92W5gHLJadaSN+UJ9qjiuC1qc0MfXNEKqF42DmaIrIuQT7IzJyn3Z8Ewk/YEeKF
	C8D+d8JIlV1lCGqDcQhxCkDwnH7XG8PDsYNrg77IhNTnx0Dlv5/Bur26hf+J4LYyRNATpN5dfpV
	p9L9lAA1hEJ6KGLpNw95E7KDUnMq7dHGcsL8/M5TbtY34ua3llflSOv+qHjuauKAFHfLB/AlMes
	t/ADtvTLRx4F3HyE604XkMG3kkfZmLXzCtvwtoKuMphPYBVQ1C1h+fIBE6SCPiJ/1hBYlceNrv4
	6Ly1tSLQ==
X-Received: by 2002:a17:903:2a8b:b0:2c0:c940:dc32 with SMTP id d9443c01a7336-2c6bc0cc732mr87305065ad.16.1781780610103;
        Thu, 18 Jun 2026 04:03:30 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8c1f9sm199005805ad.59.2026.06.18.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 04:03:29 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
Date: Thu, 18 Jun 2026 22:10:00 +0800
Message-ID: <178178060540.2320032.8413754929321784354@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260617161951.52abe413@kernel.org>
References: <178161373805.2167512.2544164327472822616@gmail.com> <20260617161951.52abe413@kernel.org>

On Wed, Jun 18, 2026 at 08:19:51AM +0200, Jakub Kicinski wrote:
> Hi Lorenzo, is there a reason we're subtracting 1 here in the first
> place? Could be just me, but may be worth adding a comment here.
>
> Please respin with some sort of an explanation..

Hi Jakub,

The (priority - 1) mapping predates my involvement — I only addressed
the underflow bug when skb->priority is 0, where the unsigned
subtraction wraps and routes best-effort packets to the highest-priority
queue.

Lorenzo, could you clarify the intended priority-to-queue mapping so
I can add a proper comment in the respin?

Regards,
Wayen

