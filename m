Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789E412BF6
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421217; cv=none; b=L4XFiUwo9EeUXlMtONSJ+62AKpzvvT1Pp7PIIMun+NmfJhsdFP8Syj1X35FfhfNBwAaI1Bax1vRl9wPXYM3NQExnVtXtvW2F7aOcx7hKbhS8P147WR9uKfYMdEx3Blu0/LXz+PMJCUeDkNJTL8lsB9u2eOi8UbGNKCs1GhGry1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421217; c=relaxed/simple;
	bh=070C3w55t+uB1maD7jeYZj6Uk76AHKyreBcL4GYcGpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d/4HT7cwzubZ+isKWuEE4GRQAKWi7CuMHLG7KgHQMNOH8J7dqgInj3WiW/EzwTadyMmXs9VjJvdIMkf71Rb/R6LRlL59Vr0yisD7BPhLcvxO6j1USKLtVrBcHz2ESlDIG8RSi/AMWNY5f2AUPwXGd/iSPxTr8vVBipIoPJpxnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrU8rljn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrU8rljn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B2C1F000FF;
	Mon, 14 Sep 2026 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421214;
	bh=jHlqOxiE+cluG6otzrwEcWMEstbOdt/l2DQBVoi2THA=;
	h=From:Subject:Date:To:Cc;
	b=mrU8rljnbBD7W+OvkFZrJk8BfvCT1pmkqj3pF+XnjAB/05cbrcx4OvzlxYL4ATnwg
	 tqLolZkomVBNoUDz/3wAc67XJlZkYK8NWWAc27TG5sgJIVIzhfnAf5r+3gKjvTLla9
	 NQqmXev/ftbO3srsuILIDRzHMWwZDOjuuUbGByZmaQTus1ICs041Ys6604DznMszUb
	 cip8kEq2pQQQ69tTFXiCYCHKJ5ByKpOfm9Ve4v2c7yAaeoIrd+6+4trHahEt95uSfo
	 bBPXswGQJ1144jVcnjJs+AwB+i+mhDHQqdl5AB4EacqKihkq961Y99Zgm0N1+/4Xyc
	 qrH01gXDXmLiw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v2 0/2] net: ethernet: cortina: Gemini Ethernet
 fixes, part 2
Date: Mon, 14 Sep 2026 23:26:40 +0200
Message-Id: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBREr0L+2m/aAkZceQ/DosIAP2oxbUMwh
 LtbiGuXkzczb6EALwh0yRbymCTI6FIwh4yawboeLG3KZJQ5qUqd+V5wj5c4YcQB3iFyJzMCG26
 LxgC6bLW2lA7eHjtK+xttRYc5Up3IICGO/rNbJ73zn6D6J5g0Ky5hc2vzKu8KfX1shedx9D3V6
 7p+AadLIULPAAAA
X-Change-ID: 20260908-b4-gemini-ethernet-fixes-2-d4c2ee15d11a
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Fix two RX-path issues: acknowledge FIFO overruns with the correct status
bit and bound descriptor processing when malformed chains lack EOF.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Resend as prerequisite patches didn't yet reach the merge base.
- Link to v1: https://patch.msgid.link/20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org

---
Linus Walleij (2):
      net: ethernet: cortina: Ack RX overrun interrupt correctly
      net: ethernet: cortina: Bound RX descriptor processing

 drivers/net/ethernet/cortina/gemini.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)
---
base-commit: c20065162307a94f88124f2adb00777a475ab4d7
change-id: 20260908-b4-gemini-ethernet-fixes-2-d4c2ee15d11a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

