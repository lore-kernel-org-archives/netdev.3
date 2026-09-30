Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970236C5A1;
	Wed, 30 Sep 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781872; cv=none; b=UDSUz/OrjGJJBOxED2PPbCDrj6A4gqTnm2kw7XPrT2OixyPTWo/E9UbxjYuiLkWbCE+AKUIsOBg4L2YTa8joPRux3mezAkyiXRp7esIwO5jIz0emlWc1g9JO5w0AoO4X0aUtZ7GS7q60yk06nYoTYaS1xknBNQiW85UuDTSPRwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781872; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIbRL1D2jAbUgrC8pgwQEEUHgLYzXBkw+IMdfMBHVnpz5dRUBj1PHr+Edkt5t2+TmoY5HxyaVBoSlZ8Lt0DXP8iuBhjVw4/dVzhira41GbH2uYAUoLz9a/+ZcTIT22e4kIr2E97fXa7pgP/TBcSE4TC2Nvi2JZYWBaZPZPoRzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZRIFGSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZRIFGSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F8B1F00893;
	Wed, 30 Sep 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781862;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZRIFGSzrn12wiEyXLFbsi2CvL0VAby5ISOpTiwHy9OVpOnR+Zcf/BKkpFXVdUPo8
	 LfyhYpUCDfKzo4lhxqmDO2nrA2xWnkiViaj6VeSaHVniglJThfCyJugqabXDYjn6B0
	 JC4kGwOxLNR8jlhrdZOi5B2N6aET3+Gf7vHjbh6r1Z3vp699Ha6R4Y2dxk0/yxftMJ
	 Ergmh89k6Cb6jKkr8475YnTrlD+mRHuFyTXxeIxZ0KBaaxnVuQ9IgDOtl1tKaPUGjc
	 jHN97Q0HZ2k84uSpGdQgqYMuNapxhXKvisCwuutYVBQRpYpkWy0zi9rN+Yab+FLZ1t
	 tqkLNoicgHQUw==
From: netdev-bot+sinfo@kernel.org
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] pfcp: fix two bugs in the receive path
Date: Wed, 30 Sep 2026 15:24:21 +0000
Message-ID: <179078186129.31693.12859971722109795431@kernel.org>
In-Reply-To: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
References: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
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
