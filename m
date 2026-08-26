Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02784326939
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787717738; cv=none; b=txr1hRbeO8e+Dg35KBi7ZWSlYVCQV1JYqFznc/nUKsYm6PJFXHBEbgMfvjXnCFnid9Zn5jJmzMOOYNZd7CNscHagLwJGUTSw8+aEuyohteRPY2UyvK0SKVjLwvU4nTSibwtSMCxH+SY9keCTmfCVbzOFCrS4SeDDy/v7XVHUIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787717738; c=relaxed/simple;
	bh=4ONt0gXh/2uHX6zYjWxw7ziwPFAUYEy4Miwa68YuEo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB+mMsNjcBuzVECQO8cnaw039Ba1pTuEAVtKdEVYr1M7z70LqABfit6Y6hBq11IsXKezKEOedyygkhpwjd4JlMgKLKEuzrcpRo2B8h8ZJSVFAtVDUA4xIgrLG4L/nah7T6p5xvZBaQ38TNUNnWxQE7HbJk0d+E4+8CD1FfwaX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRUvSnWZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRUvSnWZ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c718715fso4681007b3.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787717736; x=1788322536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=np00EX9dbTGoqYjv7UUjptr42nQcnWt1jorSNIDNa/c=;
        b=qRUvSnWZCPQIfhyLRibyMFsMqurZjKOJxG51cVW7lOya6H9nexTWD+WKoCdn6nOXIf
         agu/AVay7YAcztdDrDnBljr7dUhlOt4+ZCdGOBkf4JrWYTnTfRG+6/06WKS0bGlLPvef
         gvVy/h95yY5FkIQxyuS1+QoTtxFMMwZvl5ZPOErzQwrTCb9gY/OdhIiT+5VEbWv1+0/g
         iJdNLR3QX1KVWudxOd/Po77esBWrnBH6GGcWuMr5TPeftL+Yq/gcUbWJKT1woIo+XOSw
         LkfZOBSdWg/O2ii5pFslktF/wAM0zVx+AWgZKSxYOJL5fTfSontaJ/Xi+rd+uPGcJvOx
         CWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787717736; x=1788322536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=np00EX9dbTGoqYjv7UUjptr42nQcnWt1jorSNIDNa/c=;
        b=AM9fnzeTx9XR0bQKBRtnM6qfKCD7xkHLDNSuo/AchNrnMcmWSyW9Uwxbx1tI3+vwVg
         GbBA2aieZtbHTzdCMbObQSsRmfIz87qXtFg28RTciNDQ7/Cj3dADB3u953NiM9dYUW3s
         5/fw5ttROicVaXBpQgyYTRaywVpO/zJGVB1CJwPzOERQYVVhxbKqIxZhS+7yQ3xKQtZO
         dx1sclCbW5MxNoi0qpGjw3/fkle5umUJH9n8kepkCYADOxBD2RWkIjFnLT2sjtE3ghgQ
         GV8CLJPQOC9W4WlSQFMKHf7Bjge+F0xOfmsPZPHjH681gp2Y3smBD58O7emRaXHOvq4X
         FGrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr71RV4+DamYauZY+m09fNbddGS/dR1JASyH0dsaWaSYXmkmqR/8Kbvlvf69jPxDlVLav2MrtA=@vger.kernel.org
X-Gm-Message-State: AFuF++lDVFkHy6X8F9M7T7LC7YEof8qhEJmsBQiPGrQ+obXDBVzy90vV
	gEpv5ldoqieBXUcP2OOaXEYNdqkue9+r6gbpDsEse4PBbpC8FTvwGIoL
X-Gm-Gg: AR+sD13Lz93namsm8FXBj5lqGJjm86hSKVGEW51Z73tzA9EURcDx/0P+lkbWJIkwh35
	KTtlF4w/Qzwyeu1N5l/j8on0KMgcwWwJyGKAHT1hxhLMFxZV6hc8HQJDnXV6/0aZmtc/u2gPSKT
	g6s7YOWwg09PX0+Wx6Zz2ggu2XjPCRjAuMOhhn3pfN4WIujHRqdcog2Iq+2zKNRrFJPbISa0HJt
	4zQ76wYOHUsOzBZltlGU9sMMn+rDkYjXgKyDPkKZu/K1KYwuOrDbLj3SiOF8clBBjUAKkGbkH+z
	AfO1tQZ+hlCVnL9avRzKOL9hyzkDjVLSeTUMxSjvpl9YfsHn46bhegD4z+uCJ/JkGp7QhhvqSAQ
	GTd6RFpjAGu2QARkaaNFnk+LfNCHW+OoaX5ZzjnKLRmWOmT7js8UIFw7H2CvIZkUEYJwWtpLu28
	8+Wzrbg8P6UySe9N+g8P2s2Ei44XAVqxn0SYejrw/4L5G/q5PjBND0OwsCqEYiBAt+zB8=
X-Received: by 2002:a05:690c:3747:b0:7db:a109:f12f with SMTP id 00721157ae682-8573be1b0bamr18128917b3.1.1787717735885;
        Tue, 25 Aug 2026 21:15:35 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85705380b5esm10344257b3.8.2026.08.25.21.15.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 21:15:35 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: ap420073@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andrew+netdev@lunn.ch,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] amt: do not store tunnel pointer in skb control block
Date: Wed, 26 Aug 2026 00:15:29 -0400
Message-ID: <20260826041529.46139-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAMArcTUmACRn_h2sthPwsi3jYjKWRM6+Pnhg=tN4jn4VZThHCA@mail.gmail.com>
References: <CAMArcTUmACRn_h2sthPwsi3jYjKWRM6+Pnhg=tN4jn4VZThHCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the feedback. Just getting back to this thread.

On Thu, Aug 20, 2026 at 10:18:43PM +0900, Taehee Yoo wrote:
> This looks like it adds a per-packet linear scan over all tunnels,
> so I'm concerned about performance when there are many tunnels.
> Do you have any idea how to avoid this regression?

I see two possible approaches:

1. Keep the v1 implementation. It is the simplest fix, but changes the
   Query dequeue path from an O(1) pointer access to an O(n) lookup. I am
   not sure whether that cost is significant in practice for two reasons:
   this handles IGMP/MLD Query control packets rather than multicast data
   packets [1], while the hotter multicast data path already walks
   tunnel_list for each skb [2]; and max_tunnels defaults to 128. However,
   max_tunnels is configurable, so users can set it much higher.

2. Add a small per-device bucket hash keyed by (ip4, source_port) to [1],
   while keeping tunnel_list for multicast fan-out in [2]. This avoids
   a new linear lookup cost, but adds a second index that must be
   maintained during tunnel creation, expiry, and device teardown.
   I am not sure whether that is overkill for this fix.

I would appreciate your further feedback here and will prepare v2 after
settling on the approach.

> I think this comment is not necessary. Please remove it.

Agreed. I will remove it in v2.

[1] https://github.com/torvalds/linux/blob/0f23d56f17fdfc7db69d51f64c8b91bbab947aa9/drivers/net/amt.c#L1261
[2] https://github.com/torvalds/linux/blob/0f23d56f17fdfc7db69d51f64c8b91bbab947aa9/drivers/net/amt.c#L1276
