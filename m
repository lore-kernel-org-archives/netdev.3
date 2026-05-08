Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD39390235
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278440; cv=none; b=np3QWYKHQSo7CFSS5TE+zL+mDzvIsQt/4sc0w9b0Xx4e2gG6TUCz7OxdLqIqLrPUrcHs+pn8Pzg6oif3qZu7B07CXW8LREdlOOjr/kUp97m7hQp9A8xd4VTfi67M2YJLLMVD3dqCD77937g6IDlTZPgCKBc0Vx2BexC7jspR/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278440; c=relaxed/simple;
	bh=QHOnZOnFQq+K97zolvP03OM4MfRAYDoDiZ0LVdxHK/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INGqnOfqKB7J8+WJv9AW95s2LP/QKgmnDZoPBMhmZu/m7TxTS91JGwVlgzpXbET78JQHE2yy08MjXwwDrrATHK8NrXcvW1u/IwxZyfv/CuHPZ4VLqadEWZD7MbgsXiD8hzR2uzNdeQCQNM0a+MugKWDwqTcte719Z1Ba6piiPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHH1J9Nh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHH1J9Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9432C2BCC9;
	Fri,  8 May 2026 22:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278436;
	bh=QHOnZOnFQq+K97zolvP03OM4MfRAYDoDiZ0LVdxHK/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XHH1J9Nhq3OO6ixIEpSrzTu0JmBN6VdJyE9++iIVvHccR9aja9fhCM81mpnfBAbIJ
	 K40KTzFMcsTw6GeRyvJ59HgCW3QgGVubt8lzDCl2IzXNwZnEW5tmjnISbYUQLZHE2x
	 2pQRxrjH0eYzhfrGgzzGSy2e0uBbzjVuoG9cDxbRw3JlUDaCelTjOxgEcbwKedctoA
	 9fMRiL+yivenUWQXWFYcKacRHz7Jfw1nVpqMP2c5p37H2LoGZLasI+RAbFyfsOROxw
	 yDfHLUbcA88CcNBT5cBhZoJ9Q4AaoBmqRntQA6W8EZtUkd0CfmROqMlGnMxoEmv+TS
	 wwSFdQzOsMxqA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 09 May 2026 00:13:36 +0200
Subject: [PATCH net 1/4] net: ethernet: cortina: No mapping is a dropped rx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-gemini-ethernet-fixes-v1-1-6c5d20ddc35b@kernel.org>
References: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
In-Reply-To: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
To: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Increase stats.rx_dropped++ even if this is the first fragment
(skb == NULL) so we are doing proper accounting.

Fixes: b266bacba796 ("net: ethernet: cortina: Drop half-assembled SKB")
Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 065cbbf52686..466445c9e08b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1491,9 +1491,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
+			port->stats.rx_dropped++;
 			if (skb) {
 				napi_free_frags(&port->napi);
-				port->stats.rx_dropped++;
 				skb = NULL;
 			}
 			continue;

-- 
2.54.0

