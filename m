Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187339CCEB;
	Tue, 11 Aug 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432483; cv=none; b=hh8EUSeEu78P8j0ymazEAvtXOk3E5ta+OzBok2XYvZQUl6OdOXvfQk8gr8C1TSZH28TNIyEsgxKErdvXa9JSZ4uyYFS+EB2h1TXlfWyq+hCsbtXJPjWxuDmqVboJcQcgQPlq0/RYeisrpPcSKTwckO6YFCgcN14R/23q5Y84tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432483; c=relaxed/simple;
	bh=MqxExXUarY1v5ejap/smzcDumYmeKzgFttH5TV4bZGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROpGO4RAfW1sSU8O01ZpXiSQz7o2JKpIdWmSygzlJZpTbhJElO+7l1uMYUt6PDCcGVZXKrzCNws1Nxgcq3tpOCcNSK/tB2DzZ1wNOK+iIEkckUw+kTTXVm8dAF30mlbC6QIyiZcsA5jihiIrKF5kJp/B0Z3RNs+1/CQjLlJ1k6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbndWgat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbndWgat"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4763C32782;
	Tue, 11 Aug 2026 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786432482;
	bh=MqxExXUarY1v5ejap/smzcDumYmeKzgFttH5TV4bZGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XbndWgatSFottIo/F0yTAUUYs/CDjNo1KUGozgmux2IzpjpwHsb/Rhi2w3uB276GP
	 sB+S+Z3g1l7hW5SsjHckmMjhaxJgQsZ8OkH9IL8bReZXyqINi/y6eqP45ctkGRsB7V
	 WmN0SRwTwnWi+w4CxckbA3rbIKV1UXIrnGhZXobOHSlpvaEkgFkmccM+rAs0qowS+H
	 FOu9KKUK26UkTmUGgHRewsKNVQNWgUdoNnDv3O7XbTqoWIpukDgNVh4DCyZmqkI+Ny
	 UuxxG1CcC+/ydI5+q6Bpvp2YSXxuYtjQ3FvM3QbrP7RY9sX/BZEkGg5HFCvO/knKb2
	 zOqwbKwRaXycg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A8C5B574;
	Tue, 11 Aug 2026 07:14:42 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Tue, 11 Aug 2026 15:14:29 +0800
Subject: [PATCH v6 7/7] net: wwan: t9xx: Add maintainers entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-t9xx_driver_v1-v6-7-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-0-2c969fad57c6@compal.com>
In-Reply-To: <20260811-t9xx_driver_v1-v6-0-2c969fad57c6@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Robert Yu <robert_yu@compal.com>, 
 Jeff Chang <Jeff_Chang@compal.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786432480; l=899;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=6MpjgGzXcGI3PS41xWiOq6mWrN6ZuUsiO+32dtE4ZE0=;
 b=2m97pkv5qgyJNL2LjE0BGHoX6krzmCBtsm3Uz/xHwiTO1kG2/LKUf9Btkvq3D7IQs1wAKFyn+
 Ox9tUnH93i9DzS/PukWK2Azgh4NJiDe941HmSUqE+EdygJJAx1UgXbA
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com

From: Jack Wu <jackbb_wu@compal.com>

Add MAINTAINERS entry for the MediaTek T9XX 5G WWAN modem device
driver.

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..8f13ef7440ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16494,6 +16494,17 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/wwan/t7xx/
 
+MEDIATEK T9XX 5G WWAN MODEM DRIVER
+M:	Jack Wu <jackbb_wu@compal.com>
+M:	Robert Yu <robert_yu@compal.com>
+M:	Jeff Chang <Jeff_Chang@compal.com>
+R:	Wen-Zhi Huang <wen-zhi.huang@mediatek.com>
+R:	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>
+R:	Minano Tseng <Minano.tseng@mediatek.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/wwan/t9xx/
+
 MEDIATEK USB3 DRD IP DRIVER
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-usb@vger.kernel.org

-- 
2.34.1


