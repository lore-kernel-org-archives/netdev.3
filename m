Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C8301708;
	Mon, 16 Feb 2026 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239306; cv=none; b=hHvGHOdTzRRPrA1zpzQQ6IOWI11nq+OP4g0C5wlSIQozVAov1OD61x+peQPqMaZpc/uPRphp7qq/Uncnu1pEJ2BKfefxFIeWo+orPLrl/S8Q1DNJy1CN2bdErUy7AQMEYEU2pGvSSZ8PNzZTnecLSYPedRl8ESon7FcK6WV6J0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239306; c=relaxed/simple;
	bh=CzJneGfBZ/MVgk9B7Rn9V47T4HVP1vjMZluNKM8JQtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TbYd+gGHEO0dux+tZYlo2JgW334URGH1LIEMV/uCr21obDVVs17U/t3HcR+TWYlxpeJhzDaA2Nk6SnpSzYHAQZm0pSMg2GVNCDcDprWHlnkD+e2ILvNWnp/Fygxve701wp1O8eTvdjwkTVSWJnDcDqMOM3B0IZhlYNx1KH6q8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Hv6kB4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Hv6kB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A262DC116C6;
	Mon, 16 Feb 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771239305;
	bh=CzJneGfBZ/MVgk9B7Rn9V47T4HVP1vjMZluNKM8JQtc=;
	h=From:To:Cc:Subject:Date:From;
	b=F3Hv6kB4n5mnx57zpuUi3VJzsCqZ7nA5pMGp+CjGEBgaVVjmqk8PTWDOix+A75vX3
	 XU/V1qbT7fFt5fZ78ZCQzEvHQt/fJiLm2MyWCFuaM3oHlTy1ttJlpvTfYn46cYXUQw
	 TJXqt4Q2EeDn6g2mJF2jJTjFqQw0NRg+oDVS+7s35I2ZsG1V5J7skC+8lwamOGL9rl
	 t6IHDqkJBeD5KZStjUeo2KygfHXsmIa/6+ihg8b7mrr0Gb6eI2yOnjNUJQZ9uy3WT8
	 WF1nftVg47a8U5sw4u9fMIuHRiDLfuMegJD9/ivi9DwM7q/C98yzqsBnE8GEGmv71X
	 u5HUzzKdAPfNQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: psp: select CONFIG_SKB_EXTENSIONS
Date: Mon, 16 Feb 2026 11:54:54 +0100
Message-Id: <20260216105500.2382181-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

psp now uses skb extensions, failing to build when that is disabled:

In file included from include/net/psp.h:7,
                 from net/psp/psp_sock.c:9:
include/net/psp/functions.h: In function '__psp_skb_coalesce_diff':
include/net/psp/functions.h:60:13: error: implicit declaration of function 'skb_ext_find'; did you mean 'skb_ext_copy'? [-Wimplicit-function-declaration]
   60 |         a = skb_ext_find(one, SKB_EXT_PSP);
      |             ^~~~~~~~~~~~
      |             skb_ext_copy
include/net/psp/functions.h:60:31: error: 'SKB_EXT_PSP' undeclared (first use in this function)
   60 |         a = skb_ext_find(one, SKB_EXT_PSP);
      |                               ^~~~~~~~~~~
include/net/psp/functions.h:60:31: note: each undeclared identifier is reported only once for each function it appears in
include/net/psp/functions.h: In function '__psp_sk_rx_policy_check':
include/net/psp/functions.h:94:53: error: 'SKB_EXT_PSP' undeclared (first use in this function)
   94 |         struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
      |                                                     ^~~~~~~~~~~
net/psp/psp_sock.c: In function 'psp_sock_recv_queue_check':
net/psp/psp_sock.c:164:41: error: 'SKB_EXT_PSP' undeclared (first use in this function)
  164 |                 pse = skb_ext_find(skb, SKB_EXT_PSP);
      |                                         ^~~~~~~~~~~

Select the Kconfig symbol as we do from its other users.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/psp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/psp/Kconfig b/net/psp/Kconfig
index 371e8771f3bd..84d6b0f25460 100644
--- a/net/psp/Kconfig
+++ b/net/psp/Kconfig
@@ -6,6 +6,7 @@ config INET_PSP
 	bool "PSP Security Protocol support"
 	depends on INET
 	select SKB_DECRYPTED
+	select SKB_EXTENSIONS
 	select SOCK_VALIDATE_XMIT
 	help
 	Enable kernel support for the PSP Security Protocol (PSP).
-- 
2.39.5

