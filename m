Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3409346FB3
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060092; cv=none; b=tmxuNswWzEAzcbPjKVngTaprGZWl+rWz+ON6gplTx9a1QXm1ifuz+/GdyQ5mr98EnBbA1DQW+k7ZpnA0IJbRKTSoTkXbBrx3Ep1XQdNoD7AP22mEJawxhGpKAZ4vbuqWOarkxwRHiaJ/fvLauSMwFpLCHDz19R+0kNeO9bo/wgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060092; c=relaxed/simple;
	bh=E6OYkIaqPnUxrvuUCIn54MgF/0vP3bL77kQ5vHowhhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2WaSyquu3Q4mH4ejzmHa1CYeBwd/R31AJQR+Y0hIhLfdxzhmv/7v3EgukcixN7w541LTyPIpIXcOIeBMaLtldiYBnSDOYA87SnWNmlay87C6sSrCUcOfSBH7iUNyx1H8p1qMJsZXhQ2bGL6RG+ojxC4Vrh6mRyhr6n31srxDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8DzpLQ4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8DzpLQ4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49ff680331aso7429705e9.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791060089; x=1791664889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6OYkIaqPnUxrvuUCIn54MgF/0vP3bL77kQ5vHowhhU=;
        b=E8DzpLQ4BKQgvWvxXVaW+Gl43J2+DyddDb4+0WjX7UnbFdmicwyQpUxUM55+l3dldI
         3GZh8oHjwVl9+KpzS82iw9oAWQyBxCX+iCGI57TekQ7gSQy6MaQygANQNVoArFpPdZkW
         TliQljcE0KalYhmI1z3hy9K5hgiJTbNaBDhie+6ApvHQH7wRdUPk0pn+KJf0V+aTktrZ
         ohzW47SHyhgqOqWD+stxeHN/qTc/+AuIwcXE6quFMYRNSrS4YcYmwlQNMb0ruRxEy81b
         FvJ21qHTbrdUgHrBdf0FJFSHP/nk4vknaVOHX+zaaZ6MU4s88QP5IuldKI2lqhvJ0iS4
         z7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791060089; x=1791664889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E6OYkIaqPnUxrvuUCIn54MgF/0vP3bL77kQ5vHowhhU=;
        b=oexVRjTAaT4vBx78TmqX/YYseXMel304v5Izui0P8KguZVTam0Sy2kMgosGx6DnTCh
         KZrUTR3i3gtLjitcdXwcDG20SmDEHZPM5evrum25ddD8Xmq4283kAOKJjbcxt9NxPzT/
         0++RmnPodPxxKvEj/0obX8rjy9Wcp/Gsc1tkajtc8Cd6Qxe3ntAsqA6c8UzAOIXV20xa
         bppytRfK1xSKSi689h76aiocakigTj0E5l4xsNA3JIsx4SuynFupl8xHuBZbNwCZ/FRO
         ++0f64fWtn6Y3pOslaeE1/tdOukMxU9YbMFeSEWUsdiuuXV46Pa+KDPeIe2llJhjZ5K0
         R1TQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+cu5ae8b9m3zFZ0jyX5ekOED+QoDGura9QSiuJvHeHDAXh8+GS2Yo9eVRiPuOUq+E3u+2Qcg=@vger.kernel.org
X-Gm-Message-State: AFuF++noKjGuMBPVYm0/mRZkyRJZvPRcCszJGH7YFIcivIkes40YKnos
	e7yFXy38lq64JEsH862pJreEQzGAgjG3Lao91dy4k1m5sTxR8iL3ht04rSkH4pT9XNI=
X-Gm-Gg: AYBFou0MTec0X5J8/fHKHZNMc2evvBbkNzkH+yO3Y4rZy2c/KTNTvwKSX09mrGJJQz6
	RTMLzwK1l5pbfU7ScJFSnooQ/o8hM+rOou0bUaK6YpvxuIJw9Qwvr7GqoNdVCCJnVlyZ6Jnfs81
	h+65UKShxAZm6NUiI1S1YL44qNeC7mSWeyQA5SPww1Q2DXNDZmu+H0YwOwvCToTC+8WVIqsVyFW
	GLDLom84Psh4qMQgrYTvzNLQI+62NTkDr2wdE2HQuOtVhoU0VlBUx/gcv4C9ESTM8+IbWls5usF
	CkBvx6sTOBcv6oduSLnuTjfKWFLx9gzWwCyNvo26BPNMxmXpxL927w9bUJBgq7HLcVn1lYmg/d8
	W7VKOgxEJCmtH8wlgTkcbedko9uzAcGrTwHw6SKAtkW5wH7LWvUqN1gYRl3bWvIjB1mRBl86C0w
	mV9iL4qwjhFy8zv83LDtnF79jSKgXBWf0CjXFT1jM72NsPPms3TIQmPsJm6hlwPgQvqt71zo2vW
	Zw=
X-Received: by 2002:a05:600c:6212:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-4a1680e9466mr44010265e9.10.1791060088970;
        Sat, 03 Oct 2026 13:41:28 -0700 (PDT)
Received: from Mac ([188.163.8.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027741586sm197124835e9.14.2026.10.03.13.41.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 13:41:28 -0700 (PDT)
From: Andrii Pasichnyk <apasichnik9@gmail.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev-bot+sinfo@kernel.org
Subject: Re: [PATCH net] wireguard: peer: free packets left on the per-peer queues on removal
Date: Sat,  3 Oct 2026 23:41:27 +0300
Message-ID: <20261003204127.15139-1-apasichnik9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179105878022.1402591.10615903497956533993@kernel.org>
References: <20261003201625.4572-1-apasichnik9@gmail.com> <179105878022.1402591.10615903497956533993@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 3 Oct 2026 20:19:40 +0000 netdev-bot wrote:
> - How the issue was discovered, e.g. hit in production, hit during
> development, syzbot report, manual code inspection, LLM or static
> analysis tool scan.

It was found by an LLM-assisted review of the peer removal path, while
I was working on a WireGuard change for single-CPU systems; it was not
hit in production. I then checked the mechanism by hand against
__napi_poll() and the WireGuard history, and confirmed it with a stress
test in the WireGuard selftest VM: remove a peer while a UDP flood keeps
its receive queue busy, re-add it, repeat, then run the selftest's
created/destroyed object check. Unpatched net-next leaked a peer and its
keypair 5 times in 2140 removals; with the patch, 0 times in another
2140.

Thanks,
Andrii
