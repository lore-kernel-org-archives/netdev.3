Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383A416869;
	Mon, 12 Oct 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825054; cv=none; b=t/qkWEtjpeME+I2rxKzNb4ib2MxJ10fQPr4gzrnH3fRveRs68L+C57Q5O3UYyyF56Aee6iDXEOF7sDi82q5K6mMOUJIvvfVWFlSvjftpfGx3rG04B05j6GvArA00cVRRq3JVcLTohuQtQ01hf7Nc6B8QNM5K3YlinG3NzOVHtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825054; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kC1kM1MO0ylD4uam+81Skk2cff534WBT7gs5t2B0wO+z27hqafzDrEFK+OYC2Uwkr0hyxAnDw0O2Mno4pWXuYG7baTorZSGaX7XI+lGdbvvsBhi1SYzvR9L1mfuej5caLlFlvp5b/+yxZ5FSx4MGW0DtuwPZEA+vieYAzIZtjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRyrqQHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRyrqQHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DCF1F0089B;
	Mon, 12 Oct 2026 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825053;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRyrqQHv0R2SDnUg32wiWYkJ9nPJyKTLYWWnYzdmilNjoNZJCO3eL5WisIUlEodFm
	 MLk4BXNpT9LapFM4CTRax4jiwAHRQzb4JmHm6p7VzBUxHfEwv/R13i9rHeX0Hgx/eD
	 XTWB3/qyUiE1Ih/Ab6jZu3/DIK24xDk4h99xpmPj+5BL4q8Yz1PDtJS1KgwNkd0nbe
	 08fCMkZqD5pj8uqEjkJuwSfSPRiI1avEJv/ZcmU3pZKb0xpmeXEz9byunjv+Ia3sEY
	 DXkHwUOqNSO9+GnjG2OzGO3YnVF5BvKrqPeC+l2BBGIkecr/9DWIhg4ZvxzmCuiaaU
	 Fol+K71kefBUA==
From: netdev-bot+sinfo@kernel.org
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] netconsole: add locking to configfs _show
 callbacks
Date: Mon, 12 Oct 2026 17:10:52 +0000
Message-ID: <179182505209.2527009.17085719146800522977@kernel.org>
In-Reply-To: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
References: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
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
