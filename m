Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4774C10DD;
	Wed, 30 Sep 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793514; cv=none; b=UYQKiYaLVeXjOiNqu1PRAr9Dt4sdrYFsSDSjyKyRpYZhVsu4SIUTDCwW6je9f/P8mf6gEbMztqrzDlmNVagyaygEaMIizLIoSKY9ajea8v3ke4baoCmFvOy1Z5kiTd6FTgL+Fo+Xcn2U9lcZ1c85nKbD54O+pECobAHHL/cESXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793514; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDZQmDxU4E1YvvyCwD0/rRvJ0326ZI9kbiupjPZ+TKvE+Zxl52wo8x25BpzCXwoA8aA2XFO2MZS6cw30iTze64w24cgC3aKKe3BFHZk+wt7hLquwndPjylGyN1h4GmMq8+IHULEZ9FUTKNBAGdCDjNSP6UFtcil304vxvoVwJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGTioOBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGTioOBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F4D1F00898;
	Wed, 30 Sep 2026 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790793512;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fGTioOBOlXmKYHCQionP2c0+DVb8QLcK3p7ehZDfO3RmraNwMImTPF+Nzp2N5cOH8
	 Kiv5Rymln/IobsPBtdci95lGj9w7EpRoa05+FGYen9tiEpIs1gD/HdYvBauawFFm1O
	 qn9/e2pRiHZZlCL6Fnapd9KIxiaceJ1N6veU6LPgoiKlu4xCWUl+FypSy9An5CYk7g
	 x1s8A3pK75BSB419Ew6rYhjgjZWqsX9ff/leBjH3eZkIgewQu/saq1vNI5WJh+3k5T
	 31taXdJDW5Jj3xN7YHJM+Gl92E4RtTdNa3Ibo0ygPAcnto6UpEFTqLZctBD3XvsxaO
	 yg+ub8FFkfNaA==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?utf-8?q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: move printk() calls out of bp->lock
 critical section
Date: Wed, 30 Sep 2026 18:38:31 +0000
Message-ID: <179079351154.31693.11286897642165841220@kernel.org>
In-Reply-To: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
References: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
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
