Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463C3CE0A2;
	Tue,  1 Sep 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273890; cv=none; b=GglTUN8b8salaTGNc1Jpoq75rl7Eejkjhdt59xGyvxaGnrpPO1wujGaplb1OKWVKCUVEbLe8+C6q7Bbh8jX6/MKt0SkwXqKwVGzIFS7HMEjq9u0IMSyadL1m2uHvyTB+h+kbwEvo1rDelTkOMsGOiRaocPQnczcawbBL83tOKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273890; c=relaxed/simple;
	bh=7bUFsheFHPtm3yDKXYBmcObqQS+gfp0xLZLH0BrdbMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr8CgdTOTZWSgD6m6ZB3VIcjb7bY2uEnDrCY7gXn9LhX/fx38U80v7LdWTR1T4aukxXLDJTK8f/4Oi5UQWKfVC3na5hk/eyhnW3UfN3OKRdA+1Xaoowhdx02o9EVEwWjEzU4HkEy1oJUltUrpZWCGyAYX5V66FUNfaw7MY/+eE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=JyBYOaUs; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="JyBYOaUs"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c2113c96;
	Tue, 1 Sep 2026 22:44:35 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	hkallweit1@gmail.com
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Tue,  1 Sep 2026 14:44:21 +0000
Message-ID: <20260901144433.143989-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANiq72m=CJ7ngSBrnteyt07fHNRJ63J7m+=LY7UDHLmwYKjCJg@mail.gmail.com>
References: <CANiq72m=CJ7ngSBrnteyt07fHNRJ63J7m+=LY7UDHLmwYKjCJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05d6dd5a403a1kunmcc180acd1735a8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0pNVkoYSB5IS01NSklNGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
	NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=JyBYOaUsA3BI+q+LS7qGY9gbB49B1h+/q2mTwohbUvnkoR+pKTaDhZPK/Z33lOPJWSVgjlDhH+fjzj4yQ1Tlrtw87TJz/JqkZQGK99nLGQQvV9sJfbytAU01dbxPYV8QoUjqLswO/TAkhMT4G+gd7eyYe+tk1c13PnKJXIZTK5s=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=ZfGR6A58caZrclbKg7yjSuAeg0+r/xLnJ4mISlTUfTg=;
	h=date:mime-version:subject:message-id:from;

Thanks for the guidance, all applied in v5:

  - Cc: stable is now scoped to 7.1.y and later, and the commit message
    notes the bindgen 0.71 dependency:

      Cc: stable@vger.kernel.org # Only 7.1.y and later (requires bindgen's
      raw pointer accessors).

  - The comparison is moved out of the `unsafe` block so that only the
    raw accessor call stays inside, in all three methods.

For the older stable branches that contain 2796ff1e3dca but whose
minimum bindgen predates the raw accessors, I'll send a separate
backport that fixes the hand-written offsets directly, once this lands
in mainline.

Cheers,
Chunfeng
