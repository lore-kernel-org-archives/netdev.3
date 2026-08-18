Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1F332EC8;
	Tue, 18 Aug 2026 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068285; cv=none; b=EFp7KGhy6K48Sdyq1vIjlYzAROLX/eZGnXUpuHzw34tbvP5d8Qk1VgxjPxAcLmjwS7Vj9Ug/udfHzBB/1bT/kNfsDhL3NKM2lPvlOmP0HPF70qzYyepHof3jq/6aUExnxmQViqtQ7anUz9jfqc/aTnvlYPpN6IWxnQZxrx1SQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068285; c=relaxed/simple;
	bh=7+sSbcLl7Kpk51vcuWNpzlw2FxTEaPcmtV9ss1+Jw/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnQcWenziC/6Q0h+1e29j9x2MnTnD/vKpxvXL5dU6pyWuDBv0NpUlpGgFE5Rtkgk9W+1Bcjte36dFq7ORzmvOqsYBINGOyPA9KJivMPZkgi7d57mH1hyBb5HqHTtGKkruRCKN/LwynZW1bLir2NOaP7Vn4GlW2y0f8BFTk7Tkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WQBh1C1Z; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WQBh1C1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HF
	lLvglkqvlGZsImVzyCEXH6iJHUPwKJ+SJYE1/eUrA=; b=WQBh1C1Z/cKkRW0gNK
	uKm5QLXNa4hrpssPdCp+j7pWGyZ3iBb0D/lmK1hvkQWVS+ATsX8dD4tRBmanoJFr
	JxYYI7DiWqt+oNdFJ3MeRGUBrM31tSIy35/VNcb7cp/351Aa1eG6G1AYhtkZXtIX
	/w6X1aNstaTNrnc1si8lVnwZo=
Received: from deepin (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgC3H4TAfYRqUTXdAA--.64466S2;
	Tue, 18 Aug 2026 23:44:01 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: Re: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
Date: Tue, 18 Aug 2026 23:42:53 +0800
Message-ID: <20260818154253.6895-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260818081346.03773154@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgC3H4TAfYRqUTXdAA--.64466S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fur47Kry8Kr4rZrWUurg_yoWfXrb_Wa
	1kKa4UKr4UWFW5CF4xKw1UC3sIkFWkuw1xJFWa9r18uFy5AFsxWF4agr9093WSyrySqrn8
	CFn8X3ZrCFW5ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNAJLDGqEfcIX2wAA3s

On Tue, 18 Aug 2026 08:13:46 -0700 Jakub Kicinski wrote:
> ## Form letter - net-next-closed
> 
> The merge window for v7.3 has started, and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We will only consider applying net-next patches which were posted
> before the announcement:
> 
> https://lore.kernel.org/20260816155953.072d73da@kernel.org
> 
> Fixes are obviously welcome at any time. net-next patches may be sent
> for review and discussion only with an RFC tag.
> 
> Please repost when net-next reopens.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> -- 
> pw-bot: defer
> pv-bot: closed

Hi Jakub,

Thanks for your reply.

I understand that net-next is currently closed. I will wait for it to reopen 
and then resubmit the patch.

Thanks,
Ziran Zhang

