Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E43E6DE0
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927288; cv=none; b=XxcDkvH9Ggy9Lj8mYkMg0oh6pKIeKPo2sZInsSHA0EdOZ2hHXNHBonUjrt7ZYnalcS69nXY9Mm4f/qYgf4QHda6L2ir7dm3MY+a/XieKytlf9Z/AySb0DhVo/F/CQQZq1PIDJgtXBMDI977rSmfqAAPdzY4T/DJdJM7vPIrt4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927288; c=relaxed/simple;
	bh=6eo3KQY2ySfIaIa1WX5e1AM0sQq/F9xwU7bekekv7ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBHHQxxQGVuTAMiZqMZi1hXjMcM8VAHn5zEFsiN2lwUwI+YXAZLpCG9fh5ks2cACmfN3BwHSnVn64d8D1uZEWxZAPpz9+5RLpH2mLLhgFvf9xiPopzQXYcJ+Kx7IEVxNuaJ+wGX1c8MRXPXmbciHXKYg+Pf+8WpI+jdtc+zGqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS3TkFhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS3TkFhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FF01F000E9;
	Fri, 24 Jul 2026 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927279;
	bh=aJub5PRn0ePtVBohqEfb9bAy0GRd/qDO3UmXSREORbY=;
	h=From:To:Cc:Subject:Date;
	b=SS3TkFhzJPiPG91FyGZTCnoeGwGVtRaPl3UPoKhuZDFE/M8DdZqj+OLt3btYHP9JX
	 sd6gHWsd6J7NZGepVQ85sIO5OtoWDDuE7dgZlIKkjL49mZlxRaR1MSDvn436k1fZra
	 Q8DtXAO8ZFzlJFoLVJKh8J070l8NVXvQTHDLjXfzQO0rMdP+Nc7waPW+m7CdNw8QUC
	 Em+fr2BeKrPC7WmVw9cSUBXNd/oRdJbm8aU2wEqcHD3tTuqZN/eHy67Q/FmwXToF2h
	 TwF9956xFKYsLEeBtkpRYSL6CFA9Qojs0M0L2gsMftP31yNjSxQpxNYWqD7feA0hQS
	 bzJ4A43RgkSEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] net_shaper: clarify kernel API docs
Date: Fri, 24 Jul 2026 14:07:53 -0700
Message-ID: <20260724210756.1553565-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handful of improvements to struct net_shaper_ops kdoc.
Today driver authors have to dig thru the shaper.c code
to understand the behavior. I'm covering things I wish
were explained already during recent reviews (within Meta).
There may be more things that need to be explained, incrementally.

Jakub Kicinski (3):
  net_shaper: remove incorrect comment about group leaves
  net_shaper: clarify the kernel API / comments
  net_shaper: add some notes on re-parenting

 include/net/net_shaper.h | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.55.0

