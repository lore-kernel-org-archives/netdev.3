Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863323;
	b=4NvlAybg7TYoiBWxrtM1pmIbLgcTuOp0t1NxQtFX60u3gPUB4xckl/5lq/FQcpnPJMCV
	 oVBFpiu6GChx/J9Df7SemnVls7aLrmZLlgqae593nqIaIa5xClyf5EwllAC2J0deBRbbz
	 2HpaaJwT6xamyqGkmFeNgLCjYwg/0Zf9lvtHfmSPPdG7G+iz5ErIZAsTQoZ7+r2Ak0AdA
	 7R167hr0vPGVbd0imv3KFfSJhyRF67PqhKsUhfPUMqmZG7ZvRp4NcK7uO/0dN7L8u+cAw
	 xO+ArDiP346v7GjjqNT1FhOEq/7vSts82oAcY9YbpLpsXofhOz/U+SwVEN7w5sC+7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863323;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hg58L7xDwQVAJ3hw6OqpVhSA1s+HPAkziUwOWGZkNlw=;
	b=YwhISdsAHfrz/L2ga4dqXg5X6mQxtnwcus51EywY1y0rE+eXdGUZSigMFhIo3z8V85+d
	 JGSlooIsJrlgzSnlWYep8w3rl7jNIe24/2dTFyg1l6OmsNhGomhGml179/uMxs5UmND8u
	 GAW/Fm+zjXaH7ssTFkJypfghTjk+xZ2BhZwjo660ucOXbzDzJk/AFMUZAt3Yf61LDA6P1
	 ToBJiz4USEduWkw6CIRs7VpikIseIu+9YmwwqObHf6Uf2qkoKOhanGtG9YR8lh+sZL4xB
	 mxQmJRLfOA1w0e/DDRh9Mfm98uAiUZXYXSKGSQzyreyqNuHfSPibTp9XdCs8+PRW1zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GUpr1NgQ;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8D606A32D;
	Thu,  5 Nov 2026 07:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F8D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GUpr1NgQ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793863311; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hg58L7xDwQVAJ3hw6OqpVhSA1s+HPAkziUwOWGZkNlw=;
	b=GUpr1NgQy2tgshr+xAk+Sjsv7D9+sLfLZeFbqsDhGR9qyia35UdkRNbR3Ro4ss1h5gSOM/5JWOGYKcgNJ5p92e2ovMGRV9z6aZt2zOdcWNo1QNd9/DVk8vzofDN0ocGX9wUqL46xL9+YxEeK8FLuQNKzfyp4BektG5JqG8exFmw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00337272-2.50226e-05-0.996602;FP=18050258625328350394|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxPfos9_1793863309;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxPfos9_1793863309 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 15:21:50 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	khtsai@google.com,
	fangxy@xiaopeng.com,
	Randy Dunlap <rdunlap@infradead.org>,
	dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 1/2] lib/net_utils: allow mac_pton() to take a custom delimiter
Date: Thu,  5 Nov 2026 15:21:46 +0800
Message-ID: <20261105072147.3383565-2-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105072147.3383565-1-liuc63@xiaopeng.com>
References: <20261105072147.3383565-1-liuc63@xiaopeng.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mac_pton() hardcodes ':' as the only accepted separator, which pushes
callers that need a different notation to open-code their own parser.

Split the body out into parse_mac_pton() taking the set of accepted
delimiters as a string, and turn mac_pton() into a static inline wrapper
passing ":" so that every existing caller keeps its current behaviour.
The strnlen() guard still runs before any delimiter is inspected, so
strchr() is never handed a NUL character.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v3: pick up Andy's Reviewed-by, no code change.
v2: new patch, split out of the u_ether fix at Andy's suggestion.
Link: https://lore.kernel.org/all/20261104025058.2650911-2-liuc63@xiaopeng.com/

 include/linux/hex.h |  7 ++++++-
 lib/net_utils.c     | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/hex.h b/include/linux/hex.h
index 2618382e5b0c..408825478cda 100644
--- a/include/linux/hex.h
+++ b/include/linux/hex.h
@@ -30,6 +30,11 @@ extern int hex_to_bin(unsigned char ch);
 extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 extern char *bin2hex(char *dst, const void *src, size_t count);
 
-bool mac_pton(const char *s, u8 *mac);
+bool parse_mac_pton(const char *s, u8 *mac, const char *delim);
+
+static inline bool mac_pton(const char *s, u8 *mac)
+{
+	return parse_mac_pton(s, mac, ":");
+}
 
 #endif
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 215cda672fee..011857cc978b 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -5,7 +5,18 @@
 #include <linux/export.h>
 #include <linux/hex.h>
 
-bool mac_pton(const char *s, u8 *mac)
+/**
+ * parse_mac_pton - convert a MAC address string using a custom delimiter
+ * @s: string to be parsed
+ * @mac: buffer to store the result, left untouched if @s is malformed
+ * @delim: characters accepted as a separator between the byte pairs
+ *
+ * @s must be MAC_ADDR_STR_LEN characters long and use a character from
+ * @delim at every separator position, e.g. "aa.bb:cc.dd:ee.ff" with ".:".
+ *
+ * Return: true on success, false if @s is malformed.
+ */
+bool parse_mac_pton(const char *s, u8 *mac, const char *delim)
 {
 	int i;
 
@@ -16,7 +27,7 @@ bool mac_pton(const char *s, u8 *mac)
 	for (i = 0; i < ETH_ALEN; i++) {
 		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
 			return false;
-		if (i != ETH_ALEN - 1 && s[i * 3 + 2] != ':')
+		if (i != ETH_ALEN - 1 && !strchr(delim, s[i * 3 + 2]))
 			return false;
 	}
 	for (i = 0; i < ETH_ALEN; i++) {
@@ -24,4 +35,4 @@ bool mac_pton(const char *s, u8 *mac)
 	}
 	return true;
 }
-EXPORT_SYMBOL(mac_pton);
+EXPORT_SYMBOL(parse_mac_pton);
-- 
2.50.1

