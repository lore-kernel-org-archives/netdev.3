Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0815AADA;
	Sat,  3 Oct 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020584; cv=none; b=Cx35MzcgNnMuyK+coeFccm1Hj2GTzVciq6jktypLDbpSdNZZAxFBjmyIg+pwg+CQ/YAFXo/ja9rn2MYy5eckybJPOeXD0d+0PxpJCiFS+OtiyKScbzaXiLr67suMStNUTjJj+82smEoybFzChhWbrgD9lkcU9+QcRfT/I0pm794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020584; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hA+Q22nMO7BoCV1UTt+fF0xGzAcxGi8KwGYOOJEnQrg/vVLP7DkhhOYuB1J0+5m10TF9evsEmFyfheuiUyLpuSCwEl+KVyL2Xed8FUe+qquUBmMXuUHUkjD41fS8vbTPsAlvCKcDHay0A9TQjlZjS6EhcK8r4qMJFmekLUHp6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdYM2XRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdYM2XRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703171F0089B;
	Sat,  3 Oct 2026 09:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791020582;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FdYM2XRlX+MvHBx5H8B43BsooytwXXOnmTx05w4uOHc6o2qeO8GyikzAiXrTg4MpO
	 mOuRSGeum5+0F1aybZ6cGBSJdJB5iFVDFVMILBicnBks3hji65XAOlNj7ypSWfBAO6
	 eFy9ZRz4vK/DqQq3D5NWu5vEGa/ziYIyg/n9/WIBnCKdA2iNtsx4h7UTZTva8aEDYP
	 5Is9TMaKXNYIhq0nqXIze3HTOJUR3sw4r2sGRhCfsOivCY+BM3d4jGn7zXtWe029TH
	 NsI9s0X9V3TrDuXXnqbgki3byJevMTp0B1kWA7ohb2xRVxOAuLnKb9T5Sy4eC2NkHW
	 UOCSWYZg6fEqQ==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tun: Drain eBPF RCU callbacks on module exit
Date: Sat, 03 Oct 2026 09:43:01 +0000
Message-ID: <179102058192.1402591.6469519866772089867@kernel.org>
In-Reply-To: <20261003093822.544964-1-yaojiale02@163.com>
References: <20261003093822.544964-1-yaojiale02@163.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
