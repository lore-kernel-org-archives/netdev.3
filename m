Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1238B7DC
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787482255; cv=pass; b=tjxZE//Wr7hnb8//O+kP2QK28AcbP/ne5axaU4t18tTbZiLxUHgOFD7n/DsjTHxm/H9ifx5xwsybhRJF4mvOgmL2WyGtyFUd6en1tB1cefdcmsPhktwzgwROtSofeLeEpq1RgvxHLVeA2o4toyj0moPxju5m/YIdGIe/BDfR13Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787482255; c=relaxed/simple;
	bh=8kglFWqTCwHtE9XrFU6hsXHswROaTysasuAI1AQqwzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BX2yiyoUJhsVudteQqOW0YMYVsT38xetX+KQRY2g41a/0tnp205w6k9qHvzLy0CIM595yn4Nj8vfcOO3NEwFEflZF8SHWRy3XvgZ9le1RS1+WoNml1dZ4tiCoUgZQlwk70hqGE+IrN2hnC3eQLeuJ1NHxSvsBrtw58gPUXbBVTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pR24J/Tl; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR24J/Tl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d03fcd26a6so2641055ad.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787482252; cv=none;
        d=google.com; s=arc-20260327;
        b=rLBSESRewdibhj20lZF4zdR3Pb6MUjxeft2+BiJm8DmIo09e/lLJrySohq46k4HRv4
         S0hvT8t1p/r3YI1P2HZv3phKLLMRpeIu3KzZweAX01mJs6I/nILCFr610hX6ejF6veze
         Nk0R5dkTL9fkgv63J2JPi+nWEOJHU9vvZ1PquBGsEWtE/dHvFWJzPSyUOGddog4Hx24u
         0DA4QOiKJDNZDyAJElvVleHDIL/dTNzhhl8EJ7Su0l4C2xqYIKyQ1VQHwwGCOW3fTiPz
         SeMoGUghqJa2mXFRKDWBkaKQ+dWt6rm8fYB/lE3tkBg4VY5SWv3w4ul2xPIqH38tVTp3
         G2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kglFWqTCwHtE9XrFU6hsXHswROaTysasuAI1AQqwzA=;
        fh=YKZbRo17X06x80y1Eleh+CxqIVmiBIGewjkqWaSgj8s=;
        b=f7z57fURc5FRr+AaGYqJ9f1tau5+0yWseYHde1xgIBDJuUx/SEixm7s9YuSYcXDOnm
         3cMsDtwSPBTd1tW4PbYV/F775LxHtvUwqPeGN5SVrV0fIYhdY7VKrcnjoq9+i4A2UCys
         3FgJrvKx3cfYpQrEKOHbc7KFmgBxc5ySiIO9vl+pv3L8bMEbm4c9KbGJ0CfBPdnkxdYD
         uMRCHehAFynf9n7PTuIgAd9b+l2DIRW0GwiaP3HVY1CAMy7s7eI1KxFcqs+7nEFl0WP9
         DPQdaB8I5LqLdlP7KdK1aqgmZAFCEANYXjJGqTratU0F2FEnGrqqYNFj8GNFf8p9g/5P
         +WkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787482252; x=1788087052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kglFWqTCwHtE9XrFU6hsXHswROaTysasuAI1AQqwzA=;
        b=pR24J/TlYUjxGBCt7rWgY4YDRb9RbnNX4F6ZfQolxvk5VDmndiGEcWTTTPhP1fJlpj
         /mdgfOONgDCHqyDm0yR8bWjPLQ4hdmrlrQ2TkmvGsOPB/aQtgeVxlyaaw3ZNuqxC/UjH
         Z37e211/Xfg/drIXMZmIDLz7bNd8U1bvqvQLHgBEVsgFAqV0zd+HXcl2zO+Vf5IK9j1f
         RvJPE5m3XzdpxafDYTIRhUA4M7aqOq3F2XVU5KdN9DLCr7xHP0gZeu7j2//hN1gObZb8
         AYE+pq+WH10qhehdXc0zr2RFmSZz1HPlxwMsdVbJOQr/v+yFwOL9TN4d3Q1+HVfKHy3x
         f3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787482252; x=1788087052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kglFWqTCwHtE9XrFU6hsXHswROaTysasuAI1AQqwzA=;
        b=OsI6m6FUM0EyiUo6IePxMKmur+PZe3LaFq6l9EURGjF7kHfef9PovVFLpE9PVeAfxl
         vhUKX3IUpta4EamUqjvBRSK/nT5ig3Bf9O/4iyjuTwSj3saLo1XpTHF4hOEEmCDIM03O
         szN6JVLWRRCBO8PhQBq1sRbs90TXIbhInwuvuAk+KGgLV/2FJSSKEO7AIUrwchv2f0Xs
         YthQ9L0GTocvt1Z7uokgD6I/9Cvz/8h0pSuNawVoUXS6jq6wHT4hkvwoHjBWM9Yknukr
         jH/SBxRJjA5X4jcopcWiK6OJnYJjNrOLV1oy8WsVhn6jiaAal+Im7bFm0oZG66r4ums7
         7U1g==
X-Forwarded-Encrypted: i=1; AHgh+RpnFgdWEby5osgviwXw9RqxNCWCVURu7c8XpVY2xaUiVgwChmE543DUtGXG7nag1SURFRxg5+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mA9hzuSsw0uV+2O13Xda7k84uKnXWBy+tmbRg74p10uUL26M2x
	KJsIUdJjjTHcfBPNvSAtHJQw97BGT1b9VeNX+PIQ9uPFpwLcd7KLHTe9XofAuGuxJyb7Gso5/8y
	64tkwq+t5oUrzg7yEO+MV5j/85/c6mVU=
X-Gm-Gg: AR+sD10lqco2fPdo97IA8rLNZ7DIRG13bEZosurye+Jv2hRs8IbQmZfHtY5MSUPU8v8
	p5UeklEe6xeDIbRfg23cxdSkjcl8UnRPWJHJEB4JOaMnA/1nKWS9mglZ5XHZHsLU/13kPXZ7NNI
	QJswu0kcPVHwi5Vm/xvmOpTnpXiEJslONPVeTbKijhvH/lodCNcZxuRt+3hvUREpTmFo1rCHHnp
	dcPKjH47tUjb8yYGvmkbdiUsZLk8zYWR/0l5dS+0xoBvsqw0QUqovtHvI8a6oFvWz7UpeSiZfcS
	u+3sNHuD355erSIVlV59yeEWG6vTyS6g+9R9i+NM+0jP1AfpgVAzJdg5FD2bSGiajJ0254MXY6P
	Xs2kbJKr9E291yrAY0DMie03DMLx0s3wO/iLqz4wCTvTZS+sRF6biZrE0Fba/
X-Received: by 2002:a17:902:ef01:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d64aff2aa4mr169800735ad.2.1787482251737; Sun, 23 Aug 2026
 03:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823103644.342849-1-springbreeze@stu.pku.edu.cn>
In-Reply-To: <20260823103644.342849-1-springbreeze@stu.pku.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Aug 2026 12:50:39 +0200
X-Gm-Features: AcwNN1U32Y3hhanB8r-CtzhdGzr7wCxmADWbHO0oI_XJH4CRbLj7vuGyKQElzTQ
Message-ID: <CANiq72mUbkEcvffQV-mNLfCxGkgTqwq1qQLuWpENsUCCBAHOqw@mail.gmail.com>
Subject: Re: [PATCH] rust: net: phy: fix off-by-one bit positions in device
 status accessors
To: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 12:37=E2=80=AFPM Chunfeng Song
<springbreeze@stu.pku.edu.cn> wrote:
>
> Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
> Link: https://www.spinics.net/lists/netdev/msg951815.html (v8 cover lette=
r, where the bitfield access was flagged as needing a fix)

I assume that this will need:

| Cc: stable@vger.kernel.org

By the way, a link to lore.kernel.org would be better.

In addition, is there a way to avoid this to begin with? e.g. why are
hardcoded literals used?

Thanks!

Cheers,
Miguel
