Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD8411691;
	Thu,  9 Jul 2026 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594410; cv=none; b=M8buuzBJEDdzC81XNf7dSB4mKyKpluw5bCftiU/htJKvclDfhlSUtsEuYF44kyWkL+VCt2q5l90ZZlJvYugeQcOSnaFkrGGf/jNF6pFKgfC0VjoL4P17QC6M/gaFIKnJzsSKT59OkZqOAyTre81sdoBER821h1dJnqWYPWtErn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594410; c=relaxed/simple;
	bh=QOGjg1/RGN8flpFs/dZ2Z3VqQGhz2cw/vr/wk+e5KKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuahY8GfEd6735V1BOHF3q+JHosLm8OO1HnQZfTvhPa7iun32KsRDe7SFNy+bUbQ5DnEmb5Hbng4vK+tnWeYFUipJPkLXVd44NrijbGKbGxWcUAXOLS2mEVth68kSSLKOSKXCwjcglNzGtW0ifYNzWdiyOm4CM/FgpNAUhNNIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqVV3yhk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqVV3yhk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB433C2BCF6;
	Thu,  9 Jul 2026 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783594409;
	bh=QOGjg1/RGN8flpFs/dZ2Z3VqQGhz2cw/vr/wk+e5KKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HqVV3yhkSXk/HVlsmafNx1gc/znDcEQGYrEuInXS9n0c3WQ/lew3827+dp3e4xz9i
	 RlQRusTz5tmpIryNsNt02x9fAk1MpEAb1yM0ij3YiJ086On1MYH77/750YDj1qJBTy
	 saVtjjNAjQ0bWkOUVMHUM9ZiSISZhoQHzKnpRDLhNtdi+zwUogvYW7fplHVOMNLmiV
	 LMPwA3VZvEJ28i1c/MHiyQ64eNVuxdTu01sIS4pMOvRpgsnaj6BfVmvxRzKtKdnWHF
	 iilUUq7NiJgnwcjCCliJhJpcel/klV+OuWG1JcivH3ingezVrsmwvZWT6D+LZwp6oP
	 3Mve9scPeUE5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA335C44506;
	Thu,  9 Jul 2026 10:53:29 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Thu, 09 Jul 2026 18:53:29 +0800
Subject: [PATCH v4 7/7] net: wwan: t9xx: Add maintainers entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-t9xx_driver_v1-v4-7-a8c009d509c5@compal.com>
References: <20260709-t9xx_driver_v1-v4-0-a8c009d509c5@compal.com>
In-Reply-To: <20260709-t9xx_driver_v1-v4-0-a8c009d509c5@compal.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783594407; l=817;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=r28B5Pv3emoSo+1n1DcJ9EobPmHHNOtOYu07ftmyDY8=;
 b=PiBgIiVz9ksnTjvb0CYcJcpobiGD8EdCYsdrvrKB3iyw8F0A4HI43IHVNa3bcV2KbIM2gEv8V
 C2d/d6NkbzNCEajOfj+bffGiqBWS4VOwuHSql5ANfknvjWPlSPnDkLl
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


