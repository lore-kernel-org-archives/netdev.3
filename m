Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F403EFD0E
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792345881; cv=pass; b=utIV6E4Un9wYIVR04nMxDFmjDE0vLBGKtetHwdOCQyHjUmrhXY6DpJtzMf3rAlS9ZzdhIpOe8KidTxgbZYERZkejEren1Qsajn82oy0y4Nja7xk7f3+zuc5NpLwQCa1ImE0C54hTe/PgPsZoCPwhVZXdZ/Zydng28hZhINa+Kr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792345881; c=relaxed/simple;
	bh=HJ7jCLw2FdEx8ZSWU4kyWZlj4e9ArZJhEALqSqij3gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OK8hhQ8I2o83+nb/wwuWCsr+YxJ/EUZMhsRec77kjmRZwN1/di2itCkkeNoZIYfaxy8APcN4ffEJgvpbr4JLVCFdudmzUcpvDkqc+G8LygqvoWKa2fmg+6zaS7Suv+BbMOGwrM8REeUUO5moz7HMNxyaQh3J7ZMpJ/3ayTYwYmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1nYoBWr; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1nYoBWr"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a75f960be3so14467601fa.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792345878; cv=none;
        d=google.com; s=arc-20260327;
        b=RE5/dtwsYY2XxolK+yGsYGEQh2bW+N4XUDmBceBdKffyVOo9nWTZgBXmqQr/ikK37e
         fsslr2zitr83EPiloPDFowlTwXsPhi0wcbs6emv5UO4MAiwDapa6VWFvbARysA/NUkgW
         0NOGJMev9mxLoniRQhTJIYd6nYboL/jgMYN+SYZY9qmMGzTu8RfU2WSmFT1SvrcZmj0+
         3x5cGAZOirT5Z2ykB2Z60ECAz5YygDLCwvQ9LjbS32sW1UaYqzgoyhJqtFhW3SBOmZFF
         zWzgscbjlw5uFCE7h2nnbse91WrJkhXtmwKjdgk/s7YL30xsOp3PP6ZHhWIuoYUqHM+K
         qMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HJ7jCLw2FdEx8ZSWU4kyWZlj4e9ArZJhEALqSqij3gI=;
        fh=QoNkdOVEGDbk55en4mgAljOBROBT6XpMK/w+BBd5WIA=;
        b=lzZqm6FCBbHD5Y3/B12zSS0VS2wYnDWIMghq+eMeQSlHZj4ugEzrGEqML5SIVuNLfy
         1yYHahJx0KE63+rYqwYiF95PrvpB0+1opUi2mBkPVN6UMQjVLJjMZzEPLYQvO6iZy9tz
         K6/lHfe7JkAeOEJfyRxIrb8xw6geQTkDbEnJIfMBjisB78Gik/WJuOHjG5oBElBFWjvx
         BZnW9MUtsbPo86fWWEiC6j47Bi5ZX7VlM+WUR68bqsxkmYtckbyLFZjF69Ay6xNBwLwz
         IzUSQm1PZ0LI+U4TkxN9zTWJK50dux6hTl+MbZa9xau44dNbwiR7HQOr22ofxUupuWw5
         CiKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792345878; x=1792950678; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJ7jCLw2FdEx8ZSWU4kyWZlj4e9ArZJhEALqSqij3gI=;
        b=c1nYoBWrKJY2+CLJeXf06moOwiYUv+ca63JF3b3TZtUuo989bYJ/pd73DCPBKtPObH
         /PYjIkEF7UcIZRV777lw3Rvi0eJd8UByvd4FpADF4CR4JfwFedGYRBGVoukXSycm0U+D
         w/8cydt58Aj5ps2S6ZPTotLqQL7QCM3v+ahDVquZvQg3yv5LCxOW6zES1LIhqYGaJyBV
         1XqhaWrLjUlRkjV5oPDo52TlnYktnN9R3qRfm9PZXy2EH0Jx3u8MqUDy1mL7NH+H4XCT
         pWcJxhal5fsN4zZxqY8UPIRc4VXHOIPCDWHUJVO6EwR29E0ckrdYJfHtwPaRxsIDMKc5
         XcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792345878; x=1792950678;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HJ7jCLw2FdEx8ZSWU4kyWZlj4e9ArZJhEALqSqij3gI=;
        b=SCbG2+9NJt6FmOxREPODZVFGyTPvAX2APyOThqZZBr+gooC6PeY7gOLnEg1QMOglTS
         cvZnRlTw9DGzgL7TNlHA95FTNkDJ4i97Ffm+zk8vRbJt5xXKG+cNiQ2I2o5ibhYaJ5Yk
         H9ltzPNXBZHpaSUfmWWOQVpniDmZz5E9GQhuWB4nrB+S0/L7WPLcM5tsBHGh+t+POAeW
         jHIA+i+ZyRBAbc0HVqA3FpH9khENnXr7D1xrFAQrMhuOefG7MnnJIL/0VsMJi451Swyn
         4x0rT39LZWTOyAyyltk2lte2H0glibH0ueGucHLZMICMaUB369jQ5C9MJB8EamN42BAP
         sIzA==
X-Forwarded-Encrypted: i=1; AKwUvBxoHnHKbFV5osln6XMCXSQ21AENejdLI30LeOdFxS2pz/C+VHiRfNCfdCPLSAu5iSYr/SkLZEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuK6KB1ABuiMrdHfsxEpuScTaMsdx6hwwq06nq46c14obMHavk
	lq+iRV8jsDU7kVoouDiyhyoeLdUdD8vYzCW9p0j58AMDPUqxdigWiGWMb5hM1mLnVsuIHH+mh2e
	Eay9qDHVjdpmkgHPGx5X6RzCxmYEB6Oo=
X-Gm-Gg: AYBFou0iRxmlkaTY3JKR5YsCuBKHTQRcvXiV/Sj70DRHTxTYPN/ysiRzJTReuPRGUMG
	PSsZTRhFV4DWgBTqw4U4ivATgw5Ogsy3DCPYO4TRw6iCgzg1PBSGaVOXvn0oftLvEVTHB0AicAa
	RLDZWqzTlQ5ykdNwbW35Irn9qdRVoY/iwXe1krPsDo2Qpr7oBtpOdFLRBzuISLGzpTbsgksFN0d
	+Q+TZYqpxQ71S0auu3DjYLmbcoyQ7VyfnNLJpGZXIgqe2vRa4xQd285nfdkmFZknyph8uIUPn1F
	hahlqU3UvYHTjz7xMc7lwg5Zr9r3L8fjzezeobxOS8+RlCj29tsDhAY=
X-Received: by 2002:a05:651c:a20d:20b0:3ab:2517:6a6e with SMTP id
 38308e7fff4ca-3ab292d34a9mr8826631fa.25.1792345878330; Sun, 18 Oct 2026
 10:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016045849.813696-6-oss.patchbox@gmail.com> <20261018125520.GE64621@unreal>
In-Reply-To: <20261018125520.GE64621@unreal>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Sun, 18 Oct 2026 13:51:05 -0400
X-Gm-Features: AclHuK9VhtPON4CZXI1t-EARaMx8fGG5lLL9rRYVGDPs8VyZqR0bY4J0-Y_FAtc
Message-ID: <CAGG=RgAjY-TFDq4+rEspF5R_dTC=6jjHfS3cRsG39fi_LKVN0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/4] net/mlx5: Don't free CQs whose destroy failed
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ariel Levkovich <lariel@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Alex Vesker <valex@nvidia.com>, 
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 08:55, Leon Romanovsky <leon@kernel.org> wrote:
> Please drop this series. The flow is impossible in current HW implementation.

Thanks for the explanation, Leon. I'll drop it.

Thanks,
Yuho
