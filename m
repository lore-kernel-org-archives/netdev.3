Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446988;
	b=LD4LxFXWejxbOUT20PWCZZnLFDbi8u08bxwb/BBpwo195UV/nfdUsE1+dtWwgVcpbcse
	 Wf2mFqz09A8uPladSeAl4gJAo+N8B4bEHP//jDHNiKb61SAw5gd+dygFWkYRPtXQ35pFz
	 DqzxgpUhI4rdVdZO93vN/Wc/5JJWhs2Ja292+3r1+r4kmJbqlHVyKXhkgDvyIVN+Rb3at
	 xLsaSghGfmkN9xX5g1iU+5UN2Olu03kQllaxjtFGFupSb3cnEARNWjMslULPQk3y+1xi6
	 pIfTcRvix5rSlsp+WPhP8cihqXHldC7oKwfrNgXMEX9wbl40UQsEWosrTJJ4SsGn6yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=xRsO3VI/AEJPpAuc7Ax9NVuLqgJxni36Vnd826zImRfJdSIkCMZhoVGiYgXVevY/NRSC
	 ZTPfrMvr72CnuS20FhMEt2pcfFkRRy93QLgQi7JLi6YsE2SgJs6u/Ha9IixVaE6YQlJA+
	 bfq+musEV0F62A+kOoy1S3QfBsoQ2c8YTFIar+T1NKJnEQgkfG4truWTq0MiXSuok6Zm4
	 iS7cdcJgVnqh4wNew9z69Y0RRfmWwqdiiR5QYgeKHjkBXSdsRPlOcPYPAktgPSVyhj72E
	 diw/UetBEwzkOA95bUFX/lrJowAm6UdK0DxdA5q+oxv3os47tGbqmyYWaZex8umMXGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfqKQQrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C2606A31A;
	Sat, 31 Oct 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfqKQQrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929181F000C1;
	Sat, 31 Oct 2026 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446987;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfqKQQrpkzof+TWnp+/5p/dcyKwL1cIHIRnhD2X0U54CCtWzAKvZLhutplO1LO+fx
	 zXuSsBCQrHM8koUGDshCnuvWIvyZSgfKJDz5zrwDt7sbYD+Tvn+CSh0IqXcRO1IlvG
	 lOJnbTq7Jvd1o+NfWo3JQmDTOfkafyuTqMnVyA4WkM4ecvMZU6wRJI8Qbr8HbABRk9
	 GX2UwQyS2HhHTfLgp28mFX3CiI4KSxqCmwwnfB1rSI8S0FxfxeEwJgJgkno+QHOGng
	 73jP4SUvHOhO/VyDlghVzClpN9Ix6Oib4KhH3R1zcipP435IaWnV7729TewpRy+AaT
	 /Q6qzSzhPJd4w==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Josef Bacik <josef@toxicpanda.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 John Hurley <john.hurley@netronome.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: reject zero MPLS TTL before decrementing
Date: Sat, 31 Oct 2026 11:43:06 +0000
Message-ID: <179344698611.3286.4682763483202215058@kernel.org>
In-Reply-To: <20261031114135.3784868-2-thnkslprpt@gmail.com>
References: <20261031114135.3784868-2-thnkslprpt@gmail.com>
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
