Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005827;
	b=pXA1Er3dLURuGdhdbcl2bVRztkuM0Frv13HD6z9G8HLT3KwBy2ujPNpXMEVm0gYTB21/
	 RWqoiXNon9xJ2E4u2Jea3xrtE/9QeYnXSKW5gVPY2HcComte42RIcdBGIWXusyxcCv+H7
	 FZmWySVwNoOas7hJUBo9w7hAa5o/0dLacSBxS9AaNpeLJiSFXEQVo3rskrPI6HcGlfT0H
	 g4WFR0ukuknfHf6AH9/aUIHk9w1o32AJlzAKq49WFf1np1ihAdea8xvo9xbpc1HGtGhqB
	 w8gZU5QeOmuRacTdWX71OZK6srhMH/UTZJLjO43Y8MbgaOHVH9BCKe8PHWlLMPpPQOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=VwDKz4B6hs/XgGCXZeJOjjKLX6NrBM8Mcc1J6UKkC9XgpnKO5FTcJk1h5bdQJwzAP1AM
	 yuIt55xt6dK3z3NjWm9QRAcLAfLGLhix8EKxZoFiyIJrrfylPabAHNZUDS5kP+yogNYWc
	 kc9tD6Kj1dYvV1H0GsRhxSPFKpYSRK5Qs8GUl+sXzrmPrHpt3+bAHcHscDTD7YE2lGFMq
	 Hs6VvAJD40XMxMHSV/pV76IAoZnB4v8ABslBOYoAa89mA/wiBP3llsf1BZWn0a6C7H5C1
	 h3gtRTL3GtU7ZUk20Np4k35broPkaH/oycDcUO5zRJBae2UNBO7ZxRDY5EkpifykGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1HMM5BG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A29606A31F;
	Mon, 26 Oct 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1HMM5BG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C421F01825;
	Mon, 26 Oct 2026 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005827;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1HMM5BGJJ/MmGFgyWTYHL8xitMNPkUKsYvI7PLJ1x5yo5/E+VPMjafw4QMv9MVbh
	 RYzAdYtPhEsu5jHEYcnXHCsGZ+5nm3IJ8P+F1aUYS20nnk0g/2Zsz2+AML+CRlSVWs
	 iT8RbmQYCkC9nB76R2iw0NWlMDldJ0DVJC7qiwDDCDXCCrk8qYDA0DIggqiUR+r6a+
	 QwYbeZl7LAf/GkMUcouQTpQgoQIPqULFhDy90lDBr1HwQQyqDIYj0bcZSm1Di/Xob6
	 h4zqjLboj7vQwbJTmOJRsUu+FyVsaU5SGpe921NqyYKC029zlUwH0EPSrkIZt01ozK
	 lGafvB/dWw2Xw==
From: netdev-bot+sinfo@kernel.org
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 eyal.birger@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 liuwb@xiaopeng.com, zhugl3@xiaopeng.com
Subject: Re: [PATCH] net: sched: em_ipt: validate hook value from netlink
Date: Mon, 26 Oct 2026 09:10:25 +0000
Message-ID: <179300582598.3327.5117567372202949701@kernel.org>
In-Reply-To: <20261026090717.41597-1-fangxy@xiaopeng.com>
References: <20261026090717.41597-1-fangxy@xiaopeng.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
