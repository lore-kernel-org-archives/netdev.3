Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E246DFF8
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439172; cv=none; b=TUqSsQBSyO3iJ+TRQgEQnqZNNUCbr/BLKPIH197BxnguCwYy3KGi7AmSM9w7/LkGPCOrLqr8eKFWgWqXykQi9aAVoO3mLj7Z6K/GI82vJ1DGS81UFSjudad2ZK041rO4hamdH+KvoKgOTVG+GNgvX+Y+I1TVOrhKyL7sciBfcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439172; c=relaxed/simple;
	bh=5MWlkUscioaz4T7q6K7F2Izuv8Xf3+6P8tTxcoY6fiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rrq3+uqld3wp1UISLPGoX6JH8HGc2ddvEjAq1VcKj6ANa+KYdwabosRPS+YwQtOUNa0FR2BRkNWPf1XCZd+iM45x4yMXYdGWcD7rqqtMekp2fR/AbVqsGnN8jtBY5B7U1/zE8XNwig5aGRGYfSoJ9FIlYz65FNjvNsZCc8J4xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=pgZYd9nH; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="pgZYd9nH"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6acabd2c8bdso37880eaf.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785439168; x=1786043968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6IshN5/VXdxYv0X3fYgM6YON9yzW3236B5zgI/BdEw=;
        b=pgZYd9nHmxSI3TNj+2Vrco4n4CWwgRYpw9swtnRmbuhQKd5oP3em6xsvZUMLGuLc2t
         OgvkmTCLGPnjwwbYO5NcaQD2mXezzWvHTvODddXcPQEUItCbMOTmlFrsoCfbDlthMOJX
         TR6icgc0XdLRcQ52rTrGFXc0iQSIPnpdhh0wODc8Y1p/pOQ2LLrm9u4vT8vZ+N9avuTW
         KTI0uWva9Wwx5jPQdg4YYTF8dv+GOWHyBVhDxsAnzlU5ynxh4tI46mtQNypULNiLQNP/
         JTEKJaFFhbA/fiIQ9HCBFhZmxkIuLKyAW+zkg5k1vvtxSwzypCuETzzK9SXATKjUzL9l
         dSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439168; x=1786043968;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6IshN5/VXdxYv0X3fYgM6YON9yzW3236B5zgI/BdEw=;
        b=FZqcA4kALL+G2fGvF+M767fIIQKBU/fy9er5mVwHW53LjMr3TSd4OKpAxPX3ycCLXw
         +p0ZmkeDkVlY3roiULa4W6UC01/XPrviuimAqLnXurgf76nfwaOuGEHtkCXYUVubJE12
         KTngHnH/U+vWeNWYfppzU02slZrh1fdY6vxMIdq6t+tFjwwDX/SgctJE+ETY1SPY1ngP
         yoxgeN94+518BatNH/tUKdrtKSn28W8PYQlVZdN/7aB3NgVH3jXTwm5w/ujPv+gi9VoO
         twOngcZ0+Q7F4uMlHLdDGAQBvCkbH2MVmkyWgc95KaYhOFBvC/q7WCiUCNPVt/Qpzafu
         uU3A==
X-Forwarded-Encrypted: i=1; AHgh+RqxIogQsPuo/o6oTwbwCA0xGx3ZvxhBL6dy37xqqgd4cfyd8GDH56F3VHI4BKRkbA5QucLpKX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTok5yOOXb8i/itBVdYzGmWgPfbqGw1Ora25ka2BEFHyPbF9O
	aA94ROIWHC7HcZU/QKGm+A5dcZNsEFM1/oHvrIUbnueHaHk1XcT9DZGHZENV5ItSkoPLDo1Nkto
	nFlV7QmZZsg==
X-Gm-Gg: AR+sD10U+aCQbWMV73EWfgi+3LNJ6GhwoXHZyUS0Zgg+ccBNYuIdhD1yikeK7JBTbfy
	3oXUYdyK2plO36tehEmGodmF7hPqH/c0vAoy4Dk90rVOk7UuguX+RKfAmxVZ4yjBoB7yJ8/Ttvd
	skrihslwvKXo9awrOly3u7tOQVX50CjPvOAegFzaDBDX9x97dA1ErmG8HPOVqWH46rmT8zCRnh4
	9Dtrsk4YwwPhqXUMMhwiV4KX42Iu2clW1CuuRmeYUuiRqOvrkoyBnFu4uqXxBMwJNvjI99FsA16
	NRurvwSgDXyxE/H1GA2V4eDYbNItUjsAGaDHaHRWPn5iwamOrESLO7tbMJXpxCYwcA0jcQ9Gkd1
	ogFG5va8JlaDRZPo9vQtxk9q2nFJxQomdag6YYfPGiC81zWBucJ1DZ0mgWZTiw9j0tK83l3IXRQ
	Bpi3EPWRMGNlBMTprRJeXkcTsZrDef0aIjst6GdaarwsHFPbJKw6NB28Ct4lgFu/tE0+mevc57n
	BbNNkv5P/4yFMchzoV+FMo45sK4h8kdOyTRRfljSg==
X-Received: by 2002:a05:6820:8185:b0:6ac:afe4:80ff with SMTP id 006d021491bc7-6acbc0df6bbmr2522567eaf.56.1785439168404;
        Thu, 30 Jul 2026 12:19:28 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c2948e5fsm2934332fac.9.2026.07.30.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:19:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Woraphat Khiaodaeng <worapat.kd2@gmail.com>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260730162741.1125-1-worapat.kd2@gmail.com>
References: <20260730162741.1125-1-worapat.kd2@gmail.com>
Subject: Re: [PATCH] io_uring/zcrx: don't clear master_ctx from the import
 path
Message-Id: <178543916694.3222099.11337731480734777962.b4-ty@b4>
Date: Thu, 30 Jul 2026 13:19:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 30 Jul 2026 16:27:41 +0000, Woraphat Khiaodaeng wrote:
> import_zcrx() attaches an existing ifq to another ring.  It never calls
> zcrx_set_ring_ctx() and so never takes the ->master_ctx reference, but
> its error path still passes @ctx to zcrx_unregister(), which clears
> ->master_ctx and drops its percpu_ref whenever ifq->master_ctx == ctx.
> 
> That condition is reachable.  A ring that registers an ifq with a
> non-zero event type_mask gets ->master_ctx pointed at itself, and
> nothing stops it from exporting that ifq with ZCRX_CTRL_EXPORT and
> importing the resulting fd back into the same ring.  Failing the import
> after the refcount bumps -- an argument page mapped PROT_READ makes the
> copy_to_user() in import_zcrx() return -EFAULT -- then clears the
> ->master_ctx owned by the original registration, which is still live.
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: don't clear master_ctx from the import path
      commit: fa1ac3b9eb62918f039276d4d11cc02f682bf93c

Best regards,
-- 
Jens Axboe



