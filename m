Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B436B92F
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772607; cv=none; b=YGoQc8qitymQQ9hLPvP3Re2IRyJiE7MBWyrxeztq8+YSMobx6T2mkanVgSDGVYPFpNxUiG8mZCleeoMztDOrHBzWtUKRR1//QNLRaTJmE7Cr5xyNfMVJbxYO5U7DzIxKY5IiJVG2V802hMbWiV04tmVzwA/fFNL9zMK77r7PlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772607; c=relaxed/simple;
	bh=1dBSEPFbG3i1TEybvcJA+2NU0Tdz+t86sHKmRjb7naE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV1rmQ+L/OnEq+4E5ODGpm3ZBhPevftZz77p1MIuD5uQCUXpWSc8nw1UloblQSd4mGesRWiqzT4RBDj1PJdwVV2syeXgZQAdZOZcm9zQydJY9UervOvcpYS+/dYB6YErLjD+3S84nl+8RXZbbpnyWkZQdFbwemnZ+UTxKUkeGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTTUbWKn; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTTUbWKn"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836ce5d6e85so21869337b3.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787772596; x=1788377396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dBSEPFbG3i1TEybvcJA+2NU0Tdz+t86sHKmRjb7naE=;
        b=WTTUbWKnif8MeCy7Dynx6X3LRBG0tL6yD/6rwAcy7pFVPFigrl3PLLkBAGrAu/tHm3
         hSGHZqOnzyVeaw6W/9AfnEld+BN5xTvImVor2a2/ehshmk+wrfBIz2fNKdray4wku4II
         tsCp2r9pUqZSwINpeqQGG3BPn0Za7/lYD2PXB3e/wY25E/836yG0MFaLB6/iEkV3rDS1
         Mo7IZNWlgDpOdhvXWo7GS9dfPlSOVeHxwPLpX347zMSZol1aTnDzZFx3XDxpRsezSCuN
         kdtAVB6sbV6u0386Wr9k4oF8IPb1977gEvbyvKlCbTymZvBFamelC4eLtiRA8aOiF2fT
         VcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787772596; x=1788377396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dBSEPFbG3i1TEybvcJA+2NU0Tdz+t86sHKmRjb7naE=;
        b=LCYR5fjS1B3qhrh5IzCSh/93rI23ptyXnUz1nu4zFnBLf3Aa4UAEaRqUhLK3/laca3
         zRHtW2hcgNZBHJD8bQwLSHSJG+b0omEvbQ09pS7x4khg3nWzbWRcNekmd58wqIZtp6Oa
         7dqyUaBwK6g3UUUndNM5OwIWuijl3YYvJczo/OOL8dl6jRyLZpu427DKvpDAzYTbFe/a
         23C/YPkdBx15YO4PnGigRcZABSBsTvzAVZANNYj0zHV7SuS2Dav9JzjpbvXV4BkuSj0Q
         B+qvmD5bTW8Fwwibcg4WiiOKSOeAodY0+PqDJVfLy/bJG6ycFxBulV98ITb0AXSapE5h
         KkaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1akCnS1zm1ppybzfp+ZDeDnyvi85ZDST0ddt+I8jv6OgIiZ9NYESXKB6EWAUXMamDycsLH3A=@vger.kernel.org
X-Gm-Message-State: AFuF++l9VvpNkNXZ8zBwxGg4W91PF/WrEsNrZny1CQkPnIf7+TD9lK90
	RQlxsZqzU0hceIYKGtyn7kc34cwVfYMmsUoRSSv2ScZbq6WjM+g7n2Sq
X-Gm-Gg: AR+sD11CXp15JdujCZg7PFCxs0nFpmjdsmMZORrImekS6Gl2+ooLjf1crGATpOQKeJY
	kX2j+6/YWCBLfURwe1oOugxjcdvsEDuY+Tniw5jfLKJbwk+KPVZOW/QhMcwo0HTt43NIwRcj48k
	p4kszSLzIDP1L6WSyXu/LXxrrtzKNyiF5JJMCYOLHjmNNng/0rm80ZUP14j8E8ZMWNEhcYLsuof
	a9SRmkiLkd9BRN11Azt15hS08KCMj42xmJHLDjTPAr2bDjkLe8ktsaHFb2SdXIUMRnw15NUDiM7
	FrWN9YElMfPtXkYjd/LaV5sEcTS1es1/lRa888AXvW4ijE87ei5H0PmerdFqafrsdgemWHNSyAg
	5Nsc/LWexDQTIy8n0+/0eVT1YqmXc27HTjHNtbLba/rZrhvytLogU26ilnXKGDmXkueTsyRxcrt
	pOg5Kc8ZR4ZN1N2ZRkvtJBUD9nWabH6s9rULUsaybBEI7Ki0tHWd6FNXhDnjmR25MWelA=
X-Received: by 2002:a05:690c:a5cd:b0:81e:d792:a019 with SMTP id 00721157ae682-8573b451362mr39369637b3.6.1787772596387;
        Wed, 26 Aug 2026 12:29:56 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85a7d6cbf12sm4423317b3.30.2026.08.26.12.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 12:29:55 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: steffen.klassert@secunet.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] xfrm: hold net_device reference under RCU in bundle creation
Date: Wed, 26 Aug 2026 15:29:48 -0400
Message-ID: <20260826192949.32706-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aov1hEK0BjxGe4xg@secunet.com>
References: <aov1hEK0BjxGe4xg@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24, 2026 at 09:40:52AM +0200, Steffen Klassert wrote:
> Can't we move the rcu_read_unlock() to the end of the function and
> avoid the additional refcount?
>
> Same here.

Thanks for pointing out, will resend as v2 soon.

Cen
