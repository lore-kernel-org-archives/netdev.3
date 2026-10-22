Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661689;
	b=HqEvcdP3vGKO8XdhJqS5lK8HSym+Hx5z4Ybnbk2so+1uHc3h+buX7xwVYqyNuxotMBpZ
	 gABzf/9Ciw8mKn6VXLpVyQJpV4Qr7fLZQGKGrTWtKqEYxwYtMNNVVUa0x8V5uwwgjDg0m
	 lYdAbfTn7NsYR6cybyAmjvOy40I6xT0Gk6fd5LM1YpAy76kvTKMoGWClZbpOUxshmHtBa
	 BJYEGlNTsYGor5p7FW4s59yJ/VK4rAQvGMmvD+YY0OkqqEPntOLEmwsN5LACqls8W2ncw
	 wPWqqd9dTDi6BlCB6CzkkZXheSVi6emV5A2k7pfaDvL9rzh/VPePRtyMo0ZynvqojVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pVN1mqrOhYalxYFr7VReSIpfsAYguArpSUX3xTADh9w=;
	b=2KihHD3lB1CLusnO7bueTyi9PoC5gRESXYq2og4scYYHECKEXPmzvJDCG+HfkxKkrAAv
	 oo341nU1HkcD5aPUqsc6G/sHGQ6wNqJo5h9MsWfiTKf6qz61+x1Kz6I68/0ddTzBY44mJ
	 eJAHFvtRrC30h0UrDYbv2fpDnT/Z0PzkpchaWHnHMx3DCUtRM2MOBSfpyg7vLIJ2nm4UO
	 gtkUu8F0l6MlfAYMs9CbbFCBZAHeCQb5ZV+ZFQxKZVHGrvMNhuJ1mi5PBjv7+8aogBK0D
	 AY5m8EpQLX7ces22AJJffRxgYw5f8R1hE1Xph5yfNdTyL0TrelhRzEN7OtCBdUqMSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QOuNwM+u;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D5606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754D5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QOuNwM+u
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso1046615f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792661688; x=1793266488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pVN1mqrOhYalxYFr7VReSIpfsAYguArpSUX3xTADh9w=;
        b=QOuNwM+ut/XXfjXB039CTGSCzy8xsloaZdU5WvFi47yBZN9UVjzOndqXFgzO7mDjp5
         mkutKz5IeyUOk3yIX3FqigGFlDAW6BuAque+RcAG0Fyrqhu2KjuybfY0iLX2peTAqiPZ
         4rPEkh0A78fmZ1DkUT9wSb6gklNxpI6WiCIByQVRI7Gp9UG443Inw24cO7jHgVlQbFe7
         NRjqhAXVpHoIjq0U+UpLmUlk0LLBDAdzkrfo1m96BT0jXmhH1fj7+hwmlKcgFVQunGnE
         woL0qJRQibe9q87rMmdOiUojPzGBKF1qZy8PZl5WDQoZNzsbOk4/QZEQO7b1a+Aoxgb0
         hxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661688; x=1793266488;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVN1mqrOhYalxYFr7VReSIpfsAYguArpSUX3xTADh9w=;
        b=ZN9RWu+nSaQzyPy3/aZ0bxgHTkgccng3PytcLR9WRfkhaAJP7M91cOoynnNunt8zSL
         TMwr8vhpQL3Juczz237FHVmmA3sz7JDRLkaKkRhwKNDL9wLe/iGIFWV5jQ/90P/EGNVi
         c1fS1ygYk6mKoTSEPbkWBuDTYh7UQ8Kpp/MsuO3gz/KQhhUZWTnJaxpzFynZH8JeT6on
         sc7zAPZerlJYY2Bixqb6soQ5M5wFa7thZncGoRcxJ/fy4CJowNccuZ/pOa5s/tbS8+SF
         daXoxAkIgXvwnM7FOpPUQNNdpqCA2soPwZ2L0Mn/Cz45DAkFE/bHE1NAduqoIFBH57Ra
         15WQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoyMx/YljI9MW1U74sreq57uFajH8iipOlMa8HoRgxQaiQwUwmer2IL7VtS+SQfgiVoMf97ak=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEffgfN2eUFf+pl7o6HasygIQr561bIxCKyDC2EhWHS0Ddygd5
	IwXaB3Tv4TNX23peyZMK9NT9tJeqYox/sOkrxa9WDRVFZQsY62LwTM7h
X-Gm-Gg: AYBFou20QmmbjEM30d+CiTKlitxS4NEM77FQQqcpwhkB1JSfjL3eOXmpYfME39uD/Wi
	ZUnrr6GXxh9DUI7D82yAyrKkRfCiqQa0oI1XDlYEL1OC15q2vMKRCHpzotq1NEuhn+hFhnz1i3M
	6MyxySAkgrmz87LqIhyt/TJktuPFmpm5bfBep187jW5M+ZxAhGF5jWynZz3ShLyFearfP9Rq5lr
	G9x1D/su70upGSxLblUba2pARA9ha1j3KRhcMlHqnd21bwYK2F7uSDo5ziV361ATj1THvDlakyA
	/Ko8hpfJg1o8NxBPaxE81KGarqPT/4a+oVP6OB4XdUbuGWvBEO/tGRpgHa8WvLW42N4PT94SVtV
	WHNTo7RBB8Wpl5SNdR7lIYjO9Ea0cBdtHMEdcZR60VY6Ly9KfcK0ejm2acDETfbvY7+PhDGnMFz
	IG0wzC82eDmlP29jX3DpCDFFiyYxb9dGWLVXV6u/W7WfOQMhlWsH0dP4o1WlnP/rpJldU18f7YD
	72ileH7RiCqt4vVBiV19HHWz8lhC4Xwhmll720IR5I/WR60VNsV88mo1F2U+9idiqx0AjP70JtV
	ISdh1tg+URvsFnYs
X-Received: by 2002:a05:6000:4806:b0:48b:451:4f19 with SMTP id ffacd0b85a97d-48e264e2f10mr9528690f8f.51.1792661687521;
        Thu, 22 Oct 2026 02:34:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e72sm10420288f8f.26.2026.10.22.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:34:46 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:34:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: dma: run threaded NAPI kthreads with
 SCHED_FIFO low priority
Message-ID: <20261022103445.34cede9d@pumpkin>
In-Reply-To: <179259275334.35963.15413466304986880275@gmail.com>
References: <20261020-b4-mt76-napi-fifo-v1-1-ac8a24e2062a@gmail.com>
	<179259275334.35963.15413466304986880275@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 17:25:53 +0300
Fil Dunsky <filipp.dunsky@gmail.com> wrote:

> Adding netdev to Cc, as suggested on the GitHub mirror of this patch [1],
> since it touches the scheduling policy of threaded NAPI kthreads.

I had to fix the same thing for other NAPI threads when doing some
tests that were receiving 'silly numbers' of RTP (aka very short UDP)
packets.

There is a similar problem with the softint threads.
Softint callbacks drop form being the very highest priority items
to things that really won't be run in a timely manner.

David

> 
> For context on why this is done in the driver rather than left to the
> admin (chrt / sysfs): mt76 already does exactly this for its other
> rx/status and tx workers (sched_set_fifo_low() for the usb and sdio
> workers and for the tx worker), so the dma napi kthreads were the only
> mt76 rx path left at SCHED_OTHER. A userspace chrt also has to race
> the creation of the napi threads at boot and module reload.
> 
> Numbers from the setup in the commit message (MT7621 + MT7612E as 5 GHz
> client, 3 runs x 5 min each, ~200-280 Mbit/s rx with userspace load):
> 
>   stock:                  ~500 full-ring events / 5 min, watchdog
>                           resets and MCU timeouts, occasional hard hang
>   this patch:             0 resets in 3 runs, rx 276-288 Mbit/s
>   stock + chrt -f 1:      0 resets in 3 runs, rx 249-273 Mbit/s
>   napi_threaded=0:        0 resets
>   rx ring 1024 (stock):   800-1300 full-ring events / run, more resets
> 
> A similar restart pattern is reported on single-core MT7620 at much
> lower rates [2], which fits CPU contention rather than throughput as the
> trigger.
> 
> [1] https://github.com/openwrt/mt76/pull/1164
> [2] https://github.com/openwrt/mt76/issues/457
> 
> Thanks,
> Fil
> 
> 

