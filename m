Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B663BB669
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494138; cv=pass; b=FcusFc+VxmMEaxMB/CeR8JgVJdo025Pafh0XQcp4hM+WYdyyrXKcYnnAIgWgmnrDpDyo0UNixSmeqixMGMGshUnXAUIqysID+RY0uY1ZINhRKSiYtXsPdxdphM4BPRA1TUjI55BQ/Syz0DEyDPkUI3/0wrL9C6I78dzujpxjx+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494138; c=relaxed/simple;
	bh=ehijlCEC3hrjcJAznMfeQDeOfDoaMPKsYEk0yQczBFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj40qTaGDqRgUsuW5gFAXLqLyhcUYZ2W2iD9Nvrh8pi6bx8P/UcAP08lpEsUvlfn4+BJdwOsDyM9LMHREk2UAZgGFtr1AuWTuTBnh2qK8aDhE+/0UFyU8Zy0YEHIN5tSbx2q7m8e0IQ73/98CWnQZiGWeDMnjeY9dQrYAE4DTlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUP7ST4H; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUP7ST4H"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76ff64d78so2063040e87.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790494135; cv=none;
        d=google.com; s=arc-20260327;
        b=ZnEzwN9ZZy/IO6pmirikht0g3EjW8giZvz5TBY1vD9GbCjc2EX8uLCk4rt7NhBXYXO
         7e+hyNtXmenC5ozX0ENv4TFX/Bah7p/XkiSXm6fr6HzcffdMJE1fGBFeSDH4O4QLib3V
         G/54k4wUpxt7vrw2B3erhFKpBmBBgZa1hZSrjingpwEbWgTp4feD6rNojjw0+aAi0A7h
         3h9e1qg1d11ciORQQIDB1WkiuDCWsXPFOexguQdqvQ0IyCIyT61a5Uds8Z7gA2XZgCnn
         NbmMiOHZiiKKaoQNdpqnrrHH/5NSEYYuViTubUobLdWVJuenDyTCMXIVTJZGrAocQWf/
         YEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/XyK2jKdoKkKL5T7snSnH60cAWdSpGKwMQSo4tA4mUM=;
        fh=vKFja0LSr0FxQhvuerK1UD7EXjSKsFax19DrbRxRzps=;
        b=rqPgYXCx8x5N3zoPAf/24TzgxZXRg6bztfcR8pRHt7jb0vkn9qQdQw4dDDrzH4pTtV
         O/3q+HxD6suejdTBA9hlKXKs41PZ2w4HdZwZs3OtW+wGvHRhKIe7LNdc2sKsOYNVs8yM
         gkAGU9Lk4ADP/QAv6FtPIxQankqzZ0fteSCTE/S8m8iIGd5cNcADV31Bchh4owSeLEa4
         7x9OHQi4ECTm7F1t6nTKGAsLJZIQ5leJhgnfiTHq9HS8NQ8VFol2CrgNYUHr1dhj+C5g
         6bqYAd17XjUDbCmEvd0mxHJ1vlJIlQFnBarwK6ZiENlq/GaL3c1Pt75mriH4XQJnU4DD
         fANQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790494135; x=1791098935; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XyK2jKdoKkKL5T7snSnH60cAWdSpGKwMQSo4tA4mUM=;
        b=QUP7ST4HD4hHwLCrhLalJyjqqJxSSLxvhkwndOV3EcxUNDfLEIj7jTjaccryR8DqTp
         FksqFwirqQJrhUIFhNsu3UDaL+soJ7AfXvMm6jBF8lU6EBBgGRsvGZNiGcooaxmdO5+U
         wXZNFJ9ngRXIfc+xdCOkkJRyCzp6mAuRIT01rCnKhvDxmI+COG2YOy8mOYUicZpYzMc5
         c41cZ3Jk7cNODF3W8/eZhddzuhSRLTzInShZ3a0yVDunpC16nujtzoYVehcR+rkO/qeM
         fJ8xGfDsQWCvIr8v9Ya324Uze6JO2YplDEPD/mCEAN+4jApZyWln7Y5iiQhuusfKoHG2
         T/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494135; x=1791098935;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/XyK2jKdoKkKL5T7snSnH60cAWdSpGKwMQSo4tA4mUM=;
        b=LY08q+2S8yoWG7iZqeK/kp+qzSIdDZeZ2UhSqA3HbxeawOJmMiZ7x1/nGiAgzTF7lh
         Vf9C9fZQRrB1tOVe/kP6PNEEULZJC6WHIzJlFIsTN/QkjVneac7K9+mtahIla+0YXKvR
         Hq4bq5zsJXbt3H0PJ3g5I6HcvEEfeYxvQyH2gExI7RzLvqkV01qZcJ+KxANnKb5xsHLm
         qy03EDFs0/WFa8eFe56YzX5KOI19/LStTr+gOVLZ+VtnFDEMAUJ7KRwOlhFF7cBp04y9
         NttmU+/Hak7XnLG86d+K8R++lq2tmVWtk765rpbJpMNdZPlmTf6eS/o3PyoJEsd5xLd1
         YcxQ==
X-Gm-Message-State: AFq9FYK7C/uTfJxWOlLdItfl5bxrUnewuAgd4IrTTCN9+pKk6ZEwqfTu
	djVQCEytkTdVaEltgZysQPCZ27kjx3W0CDVrE+WLXcmoKxbtZhAT9BT9QVsPaJyb1wtYc9zCPvs
	XlgwphOGLZQ3bXsqmDMFeFrEpzAk7qJkllN/0omo=
X-Gm-Gg: AYBFou0ONF5f2YSt2LrHhJ+Wex/4Oc0gFbY+1ph41HMkakWBg/Pwlbvw0CFTt2LsLcS
	M4F5fmOMAZ2FHYu62nYG0c5u1MaIZRI1tEPnRlcRGeANeOMEZVnfwgVy/bkeJbhX4BGvxLD1/0e
	t1qYDLHt41MMFWsCq1vN1xJTshTLRzFUsHFvssJZnyoOchJOGLOmGe67KpoWGyDBGCrOgA2T/sW
	1etr+7Ahh/sIg22rfCKX88V1ql8ztBeLicPax9YbtQOjtHBG1pozqM9tm/dORRm/MXamKRZU2cw
	IxObkPCe8cd8U/S3sMkywIy/ddtlJl6Wr5slytF08Cda+LL/ktUq1Q==
X-Received: by 2002:a05:6512:39c3:b0:5b8:f42b:ee35 with SMTP id
 2adb3069b0e04-5b8f42bf011mr467408e87.51.1790494135280; Sun, 27 Sep 2026
 00:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924135116.185161-1-maimon.sagi@gmail.com>
In-Reply-To: <20260924135116.185161-1-maimon.sagi@gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 27 Sep 2026 10:28:29 +0300
X-Gm-Features: AclHuK9jR81YtUx1RQCcrT9bGJMnvoX8CDMxKrKA2UGl4RFqsdHHmwLzPsS4b9g
Message-ID: <CAMuE1bE9XGm31fKRf62kD_rP7xFvkjjePRTPfRSjwH815PPbBA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] net: axienet: fix TX queue handling around a
 DMA error reset
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com, michal.simek@amd.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, daniel@iogearbox.net, andybnac@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am withdrawing this series.

The review of v2 found a real gap in 3/4: axienet_open() and
axienet_resume() can still wake the queue while the error handler is
running, so the claim that the handler owns the queue state for its
whole duration does not hold.  4/4 has a smaller hole in the same resume
window.  The other findings are older problems on the same paths:
axienet_open() ignores the result of axienet_device_reset(),
axienet_resume() ignores the result of axienet_open(), and the dmaengine
stop path has the same suspend race as the legacy one.

Fixing that properly means reworking open, suspend and resume together,
and I cannot test suspend and resume on the hardware I have.  I would
rather not keep posting partial fixes for paths I cannot test, so I am
dropping the series.  The TX buffer leak in axienet_dma_bd_release() is
posted as a separate patch.

pw-bot: cr
