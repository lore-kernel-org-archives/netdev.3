Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0F4252AB;
	Thu,  3 Sep 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431864; cv=none; b=JCBkMtIDL4O8s+V6KdIQwI/ifNqYSIqnII0uM6xU0F0bDcp+jIQnFmOFkjVaPoVT+HIEpV6hmGwZEbyZzJxmJ3eS6IqUqIviu1rRA/GXMZ/U9A+QMjwBhJPBW+AQtlYFcmPou99eDw9AUv7urywA2Qx5dZuyZeT9CJutoP1oCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431864; c=relaxed/simple;
	bh=8dzafWTsJWi6DVsbBpyIgMWXv+QNRzjvZBIVcpcP66Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSM/qE0Cw9CcjoRZtyg/SIXwhNCfeX0hRpJcqs7RtSRQDWaWswxDRCl0OkOlAv3F7eBF/ac2i5qpYQep0FT5SpC9lxDlX9S4fCU553fxXmEm1NhWNFK9miLYgRkFrubtC9AQ7a2t2g3SYlFG8z60FmwJ0oVLNIJ5CVEFWF5NtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Ic85yrXQ; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Ic85yrXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8d
	zafWTsJWi6DVsbBpyIgMWXv+QNRzjvZBIVcpcP66Y=; b=Ic85yrXQh5TP6WoWTE
	OsdrTCLjd4Tby43XygO/OLfMpojnnH1EoLutiiMW2hBa4BgcmrhOABOy/qNWtbu4
	4Y29jNJX9umWI1dL8Bb0eqJx5W7GphYcDxXs8bu72xroFJI2eYR7C4sEqcmv06Hr
	ZO0/TOez/LYeNuLGKIyFIkBnA=
Received: from deepin (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgCHx4PATZlq5acfAg--.13509S2;
	Thu, 03 Sep 2026 18:36:49 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: Re: [PATCH net-next v2] tcp: fix mdev comment in tcp_rtt_estimator()
Date: Thu,  3 Sep 2026 18:36:30 +0800
Message-ID: <20260903103631.6965-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CANn89i+LS8aefxHe7MvV7DZ7kSWrLPQpfB-OHa76O_jm8_fbYA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgCHx4PATZlq5acfAg--.13509S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNwGERWqZTcFruQAA3a

On Thu, 3 Sep 2026 12:21:45 +0200, Eric Dumazet <edumazet@google.com> wrote:
> We asked you to leave this comment as it is. Thank you.

> pw-bot: rejected

Hi Eric,

Thanks for your final decision. I understand and will respect it.

I learned a lot about the RTO estimator logic through this discussion,
so the time was well spent.

Best,
Ziran Zhang

