Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8A3D75BE;
	Sun, 18 Oct 2026 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296817; cv=none; b=R0VBwMHYfrF1I5P2iu3wdYHR93lRcrN9Z+NMjB4yogu0x9gCvQzlRzi+Ft0eMMbrgFf/aWze01Qs9GQ5xeMTV0WNI8vIHpCV6x3Gz8yfhJMbCRD2b6UDqO9/1PMfs0eQZ8Cl4L3c23ovhLPR6glezcSzBe0+cbXJXI21Hv5NWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296817; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INpXGz/ugLjShG3cqSQb5YYAPR4OhI/OpCZf1fR4as3ih1tJMmH2ij8GXJobdWK2+D/Mrfn185jADjDHH4LE2ADgUb5whPkoWDT2QfcwDTib6uqu/Ir3Iz/krOmPeWRqL8dH9Y4NFcR4gke3xbkg8H/AxEbPWz9+XNR4L5w0Hzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHZC9g8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHZC9g8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80E21F000C4;
	Sun, 18 Oct 2026 04:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792296812;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHZC9g8w5vWr0BhJo1y71v/2Zk2HI0Jls4PEWmndz3wHHH6IeEgTJGRa5i/7BMxhU
	 zJppWt3C7chw74j3vmJvI9VFpNbaAIDxMPqVQcu+2zwlD2sPzuHdvO/D7nb5ONILaM
	 lZLC9EH9NGjWRawqLaR9arMBqyhy9T/GWlZgCh8CVwGWcv4V1pEYXTv+M2adM9WnM8
	 RMkf4nsqFns8asDqhKiM+1e/ZIhKWKavXqhho8+7Qj0H6suqYs25FlnHR3xgu4I9DP
	 PNqEVVE43Yxc2L34THPp+9+AbBigtdN6mQ0YJWwSHYhZSxGsXjH7wkaWMxV64fI2zo
	 tDoAeJxu9pqOg==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ns83820: drain RX tasklet when stopping the device
Date: Sun, 18 Oct 2026 04:13:31 +0000
Message-ID: <179229681136.3290.16604815821219206628@kernel.org>
In-Reply-To: <20261018040708.534335-1-yaojiale02@163.com>
References: <20261018040708.534335-1-yaojiale02@163.com>
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
