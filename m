Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AA40B0F8;
	Thu, 23 Jul 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795680; cv=none; b=Y8TXbiqC+KBXPeyPXnc2S+4UDkizdof9E97K+spagBH+65434yh9Dk8P1mDIrdjSDdmoFzIzmLBbYUMrj77C6bq0oYF90XAUGNjIGai1Jjd9GfEtKWwMECQyFnsFY3J2vnT7NXpKbP7W5FT3A7vl0jlcZc+TvtcbHuaUv1YdvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795680; c=relaxed/simple;
	bh=MqxExXUarY1v5ejap/smzcDumYmeKzgFttH5TV4bZGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpd6mCGkqV8KAjg6SA8UalXuFk6/4qWuWoaeg8bdpBCNyBSmhUT6eu1US035odZseB3qOkrdrGLivORziPLnRxo646J48G4rGtb20kIQ4mIr2OeD7sSuYWd2ZL6rLIL6j0T+zKSx9wcnY3z0IR1KdaGnQn/yyft3RKCfKA8LRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx9c/pnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx9c/pnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18E03C2BCC7;
	Thu, 23 Jul 2026 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784795680;
	bh=MqxExXUarY1v5ejap/smzcDumYmeKzgFttH5TV4bZGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Cx9c/pnQskjW481HtEjC/X6x4MFBo02ZYjXO52+JMt+0SXnTIbbT+KBOqsygGqBG3
	 7s2aqVWPotoJzNIKhv0awcdD7EaVl+Qhaj9WRzagT6JAJX+KrRzFrcWxpe4rcRSsfi
	 edbpcyvZ7lryEsN94J7rtMwUC0V/demY6fFyAl8Zg88RhLRITSFxt5nJmR3luEEiY3
	 gSq2TttuH2ctsBhDm9YL5nJRHA0JaQJ7YNSVZzr8znZZqp1CckxHVRj8J06w7LLAVD
	 EeT/vHu4UROeT+x1EddyGEGeFYW4tCdXi54I9QQHzpg7WBguYjtzTHEch1kbQL0TXF
	 eiKKxFeXQG3ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF6C531CD;
	Thu, 23 Jul 2026 08:34:40 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Thu, 23 Jul 2026 16:34:32 +0800
Subject: [PATCH v5 7/7] net: wwan: t9xx: Add maintainers entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-t9xx_driver_v1-v5-7-b27afb99ccbb@compal.com>
References: <20260723-t9xx_driver_v1-v5-0-b27afb99ccbb@compal.com>
In-Reply-To: <20260723-t9xx_driver_v1-v5-0-b27afb99ccbb@compal.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784795677; l=899;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=6MpjgGzXcGI3PS41xWiOq6mWrN6ZuUsiO+32dtE4ZE0=;
 b=HPw8pOFkwieUGpIkewogampNKF3EYt/SPcEABsAam5beBqmdF83brjUE/xr4SpNKq0qeIvdOQ
 Fr7pL34fTvOCDpP/QSmM35gbjXiczCe2hrKuNKIZFG7kpyR4sBV/rAr
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


