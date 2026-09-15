Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141B370D4F;
	Tue, 15 Sep 2026 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502515; cv=none; b=Rv63+p5IrnrrKNEmAa5trwRM8hAyddPxAl7sw5SyfISeaYWjTJQLL0pe1FcpZkc3e/ZWj9rSAzW5DwK/fHLRyZD7tcI3roOfc786LlBkFXaI8vAPNzWWk1afxm10KRhYp2VgF/zUZKO4/BfziCrqu1KPqrr3VV0xDCbK5iMiGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502515; c=relaxed/simple;
	bh=elXMMDfxJ06plAVOSmlt54Gn5RmP+d9uKdiJKzYrwM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IM6W55PdQmdjqsAwzgEAW/2q8c0nUwGZE0NzOZ0+AXSGgSBJVCE7WJ7r7//gf/E9ebTM4+u99YCphFBq6+PWZub0GSDhsQULO6sA/DhvnG/HqO6Efm3d8KCAkZ/jUtEa285RdNNLNJlppbFEmFOxEzfTezjq+xH3E8ABVqGDqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYGVX2bS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYGVX2bS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9DD1F000FF;
	Tue, 15 Sep 2026 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502513;
	bh=J31+QE5Mgz0UyzNL1NCZXLhhmSVG+6HAi0sru7AMhMg=;
	h=From:To:Cc:Subject:Date;
	b=hYGVX2bSrPEDBGVIjoPqZTCQ2RYQBemlZFCkuDjMwHTKkNn+hWPdvMRj4Jb8mfit3
	 GXfjPcSYqYYEN0E95i1lgp5FnyfX53djAKxjKjKEbIL1IRsI4CLQ+dauJlc7HiVbdj
	 e9Ytr7pjY6Gs99w9ssHe67oKY3ctN0DcdiRC24cmN8U6MaagaeFHgbuIOSMRLEGCNE
	 Rcl1/g+E2ZQnPLmzYYG5IHmXFmk4DUrwWqHd9Dz1UAEaU6vk0haD6qxjJ1iQzjNXbC
	 i4qQ9/CvbnAh2Ua0iS/waLBTWNpzvaBjSmux5IaDQDNs2hOPHvpG+DhGCNZS8e73yC
	 SMhDAI3OBXihA==
From: Arnd Bergmann <arnd@kernel.org>
To: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: motorcomm: avoid unused variable warning
Date: Tue, 15 Sep 2026 22:01:30 +0200
Message-ID: <20260915200148.3523045-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'priv' variable is defined before an #ifdef block but used inside
of it:

drivers/net/dsa/motorcomm/chip.c: In function 'yt921x_dsa_teardown':
drivers/net/dsa/motorcomm/chip.c:4229:29: error: unused variable 'priv' [-Werror=unused-variable]

Move it one line down.

Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/motorcomm/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d663af010f43..8b0ac5fc8c8b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4226,9 +4226,9 @@ static int yt921x_edata_read(struct yt921x_priv *priv, u8 addr, u8 *valp)
 
 static void yt921x_dsa_teardown(struct dsa_switch *ds)
 {
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 
-#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	yt921x_leds_remove(priv);
 #endif
 }
-- 
2.53.0

