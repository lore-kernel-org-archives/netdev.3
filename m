Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818427;
	b=ngg49r7rQQAPiLSjPCWSAD3He0V2NvgbBDy+VWI2C5sf5S36VVBXiMBCtlf7CgJEi/z6
	 DauRRK43qR2LVQqxIK6JvBjPv6umxRKP6dwi2m84Zg8GlawM6uw4uRyW+0oDxQugH227/
	 eHnJaGPVp09xUakP6XI8OVLwkrhzP47M4jD6T1V2K2c51DgssPaoeBggLL5nej3UHk33k
	 XGMVsPibZXcmh9BBUa2SP1Xlqs+xE3QMw/TFVAwxajsnaIl1fkhDUzDKmWvnnAZSEn+hD
	 7OCJnlzbR4xnlwU7/9M9+r4gHWC0vLwvtFB/nDg0a2IVqvh1pOJ7LLIUf8sgclkuUnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=l7RPkmFgH3sEPSTQxX9NpZBFdmxa4whqio0R3eebRBh4m4AnK5goDjO9MAdo45qPWOIC
	 vlS9mTJPBJEvIm9MttLxsh5+Y7A/yV9MUtlBr1seGQDKVxZz+17uBLKlTJ9iLM0vXfb6S
	 zkPqbvqgkdUZw6ZXwckejQJbkUNpMvyfbci3XgnxFVIKRlVUBPeurAjzo8V9VPagLv8mb
	 uCOiPMAHHY5JRjYRpZRVwwpmtZdmZJi8AmizD9PQc/eKm9NAJ9CKEvwH9/p7LKeF1qNEa
	 hI9vLmuNx6ZBLwcOtofBizel1rjfcpFmuvqeDKyZDcz+nUIhyolbjc0qb6BgJSuwAHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXCvFuDU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9C606A330;
	Wed,  4 Nov 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXCvFuDU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A721F000C1;
	Wed,  4 Nov 2026 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818426;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXCvFuDUA5RNtyc/tcg5n5mfR4ya7s4aCqBXwm/WLftspUNTI7WpiyHUk/ojFTbeH
	 C522E53qNf++5aiP9nwFo6L0aYLjujRjpi5Fy1D1crIuU1k44FBWwiaKdpTflD2i9Y
	 6cOFJZ6WXymiJ4/+cRgJ1NGDYR7tEA7E5ZCR+oMyga4kZLzblMcy25qcw03yOqyIx8
	 1IuJVpFfYo5ek/Nq7OSIQwdTLWw2iKHF16TLosoiCWfwNE9UmmvUyzIZ5pV9YEWKTE
	 ECLxueLk4dsNjCndFdU4KZ6KqgzzMSEf3uAmZ2h1vDZ0RCPXYG5dnBjISElVswmCgr
	 ZEI6M9eHlJrTg==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Piotr Wejman <piotrwejman90@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: rebuild VLAN priority steering when
 filters change
Date: Wed, 04 Nov 2026 18:53:45 +0000
Message-ID: <179381842538.488859.11490770653999769834@kernel.org>
In-Reply-To: <20261104-submit-stmmac-vlan-prio-v1-v2-1-6cfc71e636ad@gmail.com>
References: <20261104-submit-stmmac-vlan-prio-v1-v2-1-6cfc71e636ad@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
