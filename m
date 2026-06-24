Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949E3BAD89;
	Wed, 24 Jun 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295458; cv=none; b=WHvLkARd9PgK42Th8QKyYP9VbS+ybJS0/3E6T3xT1qnVGmhyuC7S1MypTBj4o+I8fJKXQefz2Lhb8j61g+11Ey+oqoVlKAi1A5mnkd8fhp+gwomO1lQ+MFd0NjXk8tJkk18JjcaR0W9itlT36lg3l5NKWvpIcecYS+HgEXDXrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295458; c=relaxed/simple;
	bh=QOGjg1/RGN8flpFs/dZ2Z3VqQGhz2cw/vr/wk+e5KKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWXS2C7k+arkdTwUj9Kw97DdmsEZ2E22CR4rULgkYld6WrabY0ZG+WjNGIhPdTyl/6g9ZX9yVTsjZaWthGDCHAL2v5AY+WPHO3kMQYlfYyV++S/kHaQhmD0SABGzV/cNIdYHZRpjSuxZYdAy5/iY4EOnB1JNjqWKsZTGFlBKKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNp7CUeM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNp7CUeM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77D94C2BCFD;
	Wed, 24 Jun 2026 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782295458;
	bh=QOGjg1/RGN8flpFs/dZ2Z3VqQGhz2cw/vr/wk+e5KKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oNp7CUeMACf21wTPc2GGtAngja6hSBZOjS1i/DTzCHvMwzFrZlJ5KQKmmYzRk8hAg
	 VCCHh6zCkVshYVfBA2fB8dwcorW4GJ/5zmcGTk2uRSh+5rGjzCHboPvQ7zi9zxWESQ
	 Mf/wW9mEvoODQz9vJA9t9+lQJX+TlyLjuHcGnWSgjFqKFuklLN5EpBcXKEp/4UZKrs
	 4LuPNJlodj7GeN6qvkVTEh3gYFfnIYngM34+3qcbZLTSRERi+pkoJtnMBwcZI6aqzj
	 YcI/TlZKu1ZimQzL0AoWuTk7yu3VdpGwpN/VWQ8s7DMZTLvjKPYeERJlWBCXSEmhQs
	 oS5yWlyrw23KA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF40CDB47C;
	Wed, 24 Jun 2026 10:04:18 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Wed, 24 Jun 2026 18:04:13 +0800
Subject: [PATCH v3 7/7] net: wwan: t9xx: Add maintainers entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-t9xx_driver_v1-v3-7-73ff03f60c48@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
In-Reply-To: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
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
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782295455; l=817;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=r28B5Pv3emoSo+1n1DcJ9EobPmHHNOtOYu07ftmyDY8=;
 b=/tZOgGPZzEx4tKYfFAbEzjLrB7Sue+BbAfRGyvCb9yAneg7nS84kOWl60dYGQXpstbW6gaa3A
 SfVgkEoLgVSAVFs5+SxiGuS12SOyiKto0mSbetvxBkajeaAnUZGP/Dx
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
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..8155d26bff03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16494,6 +16494,15 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/wwan/t7xx/
 
+MEDIATEK T9XX 5G WWAN MODEM DRIVER
+M:	Jack Wu <jackbb_wu@compal.com>
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


