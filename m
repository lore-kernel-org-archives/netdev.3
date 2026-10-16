Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209B380FC3;
	Fri, 16 Oct 2026 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121334; cv=none; b=DpxBXB2QKTcyTotwy+P8VwmCbTKorlg0idcy1kmMjcP9XRb+XEU6Q8q5yGBfTxvmwWkfFrhTsfk7dgzusM2O4BITf5rQtQE41Ify/ZN5cSF1qFzIoeDURNm1IiCS55EK5Z83EzM6idkBi0P3YWHWs5ihzvPnH4+yf2KucLpOI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121334; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNo9eJ4pjtapCJ3cfLOxP5wBKxTtyZwd9MhAiMw+tquv0kIYHsHwMA8NnDj0Atbq1e77DZkm1IkbUrekiiaZwgRmiwaSzylWUl9yjcKBbopX6Qn5hlavi5OFmcMQlqphX3RLegduki1uNMVRjzRhcm2EDgLbS0vkbTmgayhZ/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4f1CS7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4f1CS7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B811F000C4;
	Fri, 16 Oct 2026 03:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792121332;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4f1CS7VNu7ZbPH4bITThJ+xgXiFo8bULNYGyBKKx8rnL/Tdq1uxkYqijCxG9XxUR
	 UoZssQbsn38VHhosVOXsNkW2LDROExTFhAROCqBCA+OIWkcavgX3u+v6p+r6c5/GXa
	 Pxg/1dt1qEtbk2jyUwi0eo4B6zXVjzkL8ZT4P972xoWt2Me4RBa0XZRKcMmj2ElFUk
	 F3RjhGeQysKD54V1cfB9z3fyHwaYkJt6SsfuooiqNk1t0mUcgfgtpI8N+z5y+N327H
	 J8LEx7QqBd+jRSNsCiEkchvi8TR22hChFFAOKC2UpaW15077RXUKe9+3Fk7hBnUUdf
	 EXjrEry8NqX3g==
From: netdev-bot+sinfo@kernel.org
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: aquantia: fix PMA capability
 reporting and EEE discovery
Date: Fri, 16 Oct 2026 03:28:51 +0000
Message-ID: <179212133172.408196.2062975886921402757@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0?=
 =?utf-8?q?bbb1b84035d=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0b?=
 =?utf-8?q?bb1b84035d=40oss=2Equalcomm=2Ecom=3E?=
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
