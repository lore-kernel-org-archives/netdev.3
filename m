Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868D4963CD
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521468; cv=none; b=NUHtTokttC1BzicEp+ayS1cRJIp8M1wUorqmusb9gTCBmTgDZhIvHaSqd6k4a5Bt45x25g/zLedK9WCoRGiJYUfhJcMkdTwg315grPy1cicbV8ohYnZyHAsYVhquqKBr4wbcw+jLLGzwGk0kPrZfWxbjiaX79aWxEZJTl8ayBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521468; c=relaxed/simple;
	bh=cC2THtMvsKyfTnqSrCUcXu0Wb3XRjrvrr6iNqn0oj+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEXbiybUw9fUswdtdXWh+wDNuLDAUyAvvilAAfWPhhE3NkU0WbZc9usB7BLOVn4bfQDt2tL7lI76zkwCqkejjPuFzLWYmok8vN89JtVWZcD6/c68pHDEM2lu+QWm43Hk7EJcl7vbpQm+arV9Gbotda+Lh66bTrPC3whggoM2u0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua8Hv2Nj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua8Hv2Nj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b64c8311so116565e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780521463; x=1781126263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B/50xn270YOFb+RgL3nLDaMTNlbmRRwqq6mUIoXECM=;
        b=Ua8Hv2NjDhBwpbXMMTrtgdqfGxnxB3V4oAlPhNb4DDqYcqNs65iveFVYdULOA1DUnU
         BpQSPb2jqYNWmHTswSPVJ9NuvC8c3QF0UlPm/8Y6sU3UIdwIVsTiTA4ySbWX/G7kpzjB
         l0ldPPRdq3E2v6BpyGFfJJcFjiEbA5EdsGub/5VE2Y/NeEHsqT+A0zjow9dkaNkwP0gE
         bcTP/gNMDjT7K0dnXaNbQ7lvW9XD5QbrGu7z/Ahs5rnw28hEpIwddzVe6hIMSYlDgi0Q
         nXBTLYmGwX4Kbmn13v+r3JrRAhmIQxzp/nLcZ+8uflc/eKgniCrSVV4qAx/jBkQJAuQl
         l+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780521463; x=1781126263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6B/50xn270YOFb+RgL3nLDaMTNlbmRRwqq6mUIoXECM=;
        b=fY0WNJchQGIj1OhK+1VsxEpzEhehTHFGt6OUQIo6qoV8iOkw55JjRLcfhHq57n+034
         Bm9rbj551KHyYXVc/f5eCP5fl2wkezLSAngd3ca48IamSDN45njKmIqhVryh10BTfYPG
         GA1fooG6EiROa+RK7Uj9Z6JlVFIIFQGZGiAMASAotV1bKc/XRKzM+Hmo6tN3zQCN76kT
         UKmR3u025aWe6QIm8TNVGmWK8ryPJqAcQSzfERMRQsjsyLWKbdWj9vyj2vPPeNFN/fEz
         LolelkGhJtjGfckLvCC3CRJivoK+d0vca3+zYBdbBgYC6WztaRDW2JUC1FVrJRHFQul6
         us9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/aT4cAx6L24eH6Zq7Lj1MEuqRrbZiZfrr6BwHPw/sIt7wjMcpQzUOUtVyrCpXtKmyqcM0KSLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGSz97skX99mT7VKH0ns/BZQlTfIYEEC/keETZbfrpk0jvBFk
	bIrHjnreZeEa2E0rfAvIo+bh9niKd3ef+ugab6eyoaiUx4aEO6+5YM+P
X-Gm-Gg: Acq92OHjaJo+JWjNjA0irD8VfmgvzTMObErlf6EygfyUhNgRhrMR2fnmF5FNB6YYfw3
	1ICW31x2GAoYVkFkdeaTCKPqwZ5aadeqYcbcKwAbrRGy/EJbwo7umP3C538dLMoXMWLtWD0JICC
	jNhjOaBdztCzMGGt++VtrTGR6ntul/CF4pMKzMMVw81lnZwlwL9DShfR4y3DtZx1f2lsN/OawS1
	pTWcMgAjlHFhQmMjlaBzyoVhQ8Xj+7GiVhJeB5yVlqwTO0Si3j3KWTlTPoXs+IXN9TiFPQ9H01I
	8hXxqKCd25AOsZhF8u/XsErOdDvQcZvhX6c47MNBZUhAl6274ZSNfGs1qi5PvEFVjW4FPIkbxwB
	hqm4/JXGeobJoLsmjpA6Gjj8vqh+/m3VkL8TLEwl/M1FidDBVvfhGtYvhTujgCvmgmj0Xw9mxcx
	mts3ISJHmF7zwB3xoTivkM/7th+rFzEA==
X-Received: by 2002:a05:600c:19d2:b0:490:7136:ad02 with SMTP id 5b1f17b1804b1-490b5e94d63mr81490465e9.7.1780521462549;
        Wed, 03 Jun 2026 14:17:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7a273e3sm59171155e9.0.2026.06.03.14.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:17:41 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: metze@samba.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 00:17:36 +0300
Message-ID: <20260603211736.755139-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stefan Metzmacher <metze@samba.org>:
> Why is 'int fd' changed to 'unsigned long fd'?

Because preadv2 and pwritev2 take "unsigned long". I want vmsplice
to be as similar as possible to preadv2 and pwritev2.

> Should that be its own commit if the change is desired?

Yes, possibly. But this patchset already got to next.

-- 
Askar Safin
