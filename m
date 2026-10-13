Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783048A8A4;
	Tue, 13 Oct 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914395; cv=none; b=Kuy8nSnyeeL+fZTdW+SyjGt59xbLSWov7cIopfrHkGCTsb/imQ8srudTnoftv9uMYyoK+v7lWuHcKn+50opXC+UyWCop+ZhRQBetqpwxwoZT1oWPpYeiCBNgRlLIqn73138U4v0bUuQekOYfaxZLSRMSZRMHXoBMFOkcbY6NsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914395; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bY6mYvO0W1dhhiYicvMaOxot5Ipk5/gW5Sg9Orsmn9TfJLZBl1kS2kFqWw8i4nGNEinNDA7exdnduXtY8RX9+n/zl+VK6MlKyQRTQdwsqO1q1TjFSliCseA8/Bh7j59rpqiAuQ0/pg+ikd0lNR3DV3rxW2shtGNegexWishquUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIe0hG9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIe0hG9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E94C1F00893;
	Tue, 13 Oct 2026 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914394;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIe0hG9ciCwR/r9Yt3vMacuEOEaXE5YtjGpWHMXA/XMP7Y95qh5/ZIMxgUgtfoFP1
	 iORsnYhcrVDjGqBZD4aH8gdvlm6MM6A2okz+5adVO2Ek/0/EtEIVs8b5hDolVDt/qo
	 OFTKGGqt2GhtS6Sil1/f0netw+kO+A+3ePiyEveEnl9Wo8g0NZfeRcyPpgqgVt1md7
	 8QlCmmold99jXy1wUa7S+QbeHyeQjlKwDoEQ5UxJ8gO6XqOn88SQZIjY8MnwyUYx1D
	 PYjB5MPfsC0SlndUPnSRcBTkjmgmcmZCJz5j6azrOv0NxWqYu2qD1BiNX8+W6w1CB1
	 xvfSMbotzBlhQ==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and
 request-path hardening
Date: Tue, 13 Oct 2026 17:59:53 +0000
Message-ID: <179191439302.99822.7003892633293783340@kernel.org>
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
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
