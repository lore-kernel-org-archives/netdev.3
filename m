Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B1346ADC;
	Wed, 14 Oct 2026 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948619; cv=none; b=Bkp3n34M3qtwbmig/3zuOQ9aULo9Yn1IBXGrjFAYKLqFor7n4V7Dcv85rmn0LFGkifjGjSgpFV0QZahLbsVdCqvnkZ1yH0KRFaDZdu/GMo4s9+4uwOquKVE9QjANTH9z+P/K34HPII7xUbWyxcBCKtgwMY5LeSewPM/YeYKavLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948619; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZmrxRqrf9/DWHaWSWaM8jE0VM3J3uy8d89jqUh1QDCfygGFj10dQAdctOu4bRDOwJZYrzzkA7plhOf6IidZGTny6QDBKxZUi8kRtG/3lSzVZmOMBmM7TZeIE2md69Ga558c63Rop7FbzjrlxiFMnMJNBQzTnfwAgECiIPK6yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTsS+XOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTsS+XOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ABD1F000FF;
	Wed, 14 Oct 2026 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791948618;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTsS+XOSiovAiWdtmKLsTKPuzA9O/ur6rFlm0JZqiLT0t7rnppKXFapRtcVfi30+1
	 OtGXmpbeDL0BYSCwk7MDwG5pBENE7aJdio7Mflupr0HnhbERiSjLjepLC4RZpEYxS5
	 y57z1sHmCzTYNBKolGfRLsRDzzI3syeoJMy6xu4+oOb52pSX8iUNNNVlnnurwPBbGk
	 rB6wKddKl9SGwCDV+v/BcUpDn2KXFxT5pEGKOM+KyrMSDMON9QiPFAarikInRLpeqF
	 21Zctd+xUxQ9yhi46NW4y+ST7reQshPjO4GFpaWhJR/61M5kTw9k/vb5mjXzPJdk4L
	 e1oGxhZwyoFUw==
From: netdev-bot+sinfo@kernel.org
To: Pengpeng Hou <hppiscas@163.com>
Cc: Elad Nachman <enachman@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: prestera: avoid overreading a short firmware tail
Date: Wed, 14 Oct 2026 03:30:17 +0000
Message-ID: <179194861751.160550.7509459587869597580@kernel.org>
In-Reply-To: <20261014032540.14311-1-hppiscas@163.com>
References: <20261014032540.14311-1-hppiscas@163.com>
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
