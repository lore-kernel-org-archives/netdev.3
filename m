Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545725;
	b=imqn/ePpsVQl5U37n5X5PB/vgEPOwcKde0KkuIS7yTbMt4B35VlEtApo4Opprj74Stbe
	 SCWvmvu6bg7PFe0O/kN1NH+jj5ftdydQq3O29NUMQTwS82MucCFRD8Ey9kUkyR028UCtZ
	 w0PVl27Dwo5chZox9MQuUfoKnT66ulbDGd9qTHwcRgdMXTeAp8nuAzq/d9zihnsear0FO
	 vXAZ12F3TgZjFeeAeAo1IZncr2ZEIMnVkAKWF7aO7agbfEGxmK0itADm49U1jQMINNW6d
	 weD5cmt6LIZQtW7mxm3Ozqw07ry2LtwuIEO4z0v3pNI2Nfkgb8ebaSlknFEUWgTTcLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545725;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=GhbhiD3mjZdHsJBgoXnB+sYsNcL4Jsx528h0eh+D4gJyolfQwVgak7fTHDW2RnHMKwEF
	 zZC2SlUKsXT9P+JJBBBtVvcnVkPCegNQPWhXxU/fkMdje7j8PiXlyHppRgaiMRFDseMFF
	 b0X/QhNpzyS1i2vS5ZS7lrilW5cKSANOhLupjTBlO74vC1uGg2uc6ppSXnBW+p942aZWZ
	 BL0z1KCLE2UmtapmUiOIlR9aFvsRHGZUcJr3T1sBGgBlRREiDaUVwoNS/j+3vw7kxRdSe
	 bhZ32Mul/st8cvq/pW3IzU/W7Ve3Gr0Pw1lYk5a+6iKav5TAeeJr65GvZ+v7a1BgJ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiT++yNO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBE606A324;
	Sun,  1 Nov 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiT++yNO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D6F1F000C1;
	Sun,  1 Nov 2026 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793545724;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XiT++yNOKfnvNBBl725bUWEFhfgmbwr3gapNjEqSssbFkWvxAy4SXoXkdBr1pIV+3
	 XuIs/AgGN88pqIlkUaTA3a4nbxd1P5wVqAKfhqA3gSYCyzAKsByBbRDv4CSvhbDFQm
	 jf437Bbj96VBezgARrCWtvTX7pHG+TVuYzWEzcJVjna7BcOMLypAq8Ck267VXHMKjD
	 SAR8NoxOAp4tYXbQTyzW555vK47x3AZu8vZ6mXLaE6zfp40P+1TW1q4IHtMLOcesRx
	 tfs//CwBnnnrwBmGEDEl6gFRUN3NIqENa0h5NzkodYmSIYs72paNklHPscqQ82zDqz
	 s3mjekBhRaSfw==
From: netdev-bot+sinfo@kernel.org
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <hangbin.liu@linux.dev>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Date: Sun, 01 Nov 2026 15:08:43 +0000
Message-ID: <179354572351.3286.5042962273582442842@kernel.org>
In-Reply-To: <20261101150240.66292-1-timur.stukan.linux@gmail.com>
References: <20261101150240.66292-1-timur.stukan.linux@gmail.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
