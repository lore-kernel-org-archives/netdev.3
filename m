Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934373;
	b=CGhgwkmF3lnB6KylHnvwuJc8NT60JuoLtvX5HuIQXUiukjeSxAIi3JQyfqZg+BGa6aY4
	 kv1S/T5T2KGHmNj3uLfCyyCxWP3a6Cyz+b5dxVnC6HMi0lTQsoqgbevNko7hOejk9d4iU
	 1slLvJZSlLoeKM0yHhKoYORG6ug1CV9p27nNEC7Mb+5bOm33G23MXapz74gNyCgcjIhYj
	 My+zYE9exN6UfO2n9eeWA1pJ03RJy8a2+fk9INbWwkD8TFzSel58NvvApspp9O6CpwpaS
	 RMt12O5XzRkNRFy0+T2JFLUqkewfuLlsKqK/oMDZM2MpfUZo+VwPNnz3kQEuWWH9gQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934373;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=anavCBK3SCp8Ujq//YSmuDMckikQh71WLxxHmaHr4cw=;
	b=gA+7rsMQOzFA00LW2uaj8sJMd53ddz+5SNQHm9L8jt0KvujFvYkdNghZlkQGgZ14zMtu
	 9MVlqbRBZRBcmfvZeN50DWey1L4BKpp/s0kWBd+0CpusYh3vdpT6JzrbZBSWb4bZJ+37g
	 KwaUwlGLt1uJoD9iLYOYIyTUXABcmTmMRl/0ltMe+9Nq4XZadfEfVQsxQdJBvoAiZI+am
	 Mtjm6E9Q+7El6ckoNfZbxe8bsYunHVI/0kpAgn+QUfG/JNGqlrN1EwELahbzH1aGLXDX9
	 DSR/s583j0KoXDljmjmdopFBVeeWmcc6Afyx9RaH0VrdUs0sk05kv9uBmcnLoFY5ljA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=bnihwohJ;
	arc=none smtp.remote-ip=115.124.28.4
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8E606A326;
	Fri,  6 Nov 2026 03:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C8E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=bnihwohJ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793934369; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=anavCBK3SCp8Ujq//YSmuDMckikQh71WLxxHmaHr4cw=;
	b=bnihwohJEoU/va55tbf0n1YF50PQrQy4yNIADVahhBBY5jfgEdRCYNv9Wp3FOksxRCxTAhYj8MHWhGLynyBc+6SXwjd+jzZFf3t3O563tk+X7SgTHvNXpaMAE28BHQVq4PF6zGpc1py2yLcozxRCWyB62JyTc/APKJJohnWKBzM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00337272-2.50226e-05-0.996602;FP=18050258625328350392|14|2|19|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxsfG50_1793934367;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxsfG50_1793934367 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 11:06:08 +0800
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
Subject: [PATCH v4 1/2] lib/net_utils: allow mac_pton() to take a custom delimiter
Date: Fri,  6 Nov 2026 11:06:04 +0800
Message-ID: <20261106030605.576584-2-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106030605.576584-1-liuc63@xiaopeng.com>
References: <20261106030605.576584-1-liuc63@xiaopeng.com>
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
v4: no change.
v3: pick up Andy's Reviewed-by, no code change.
v2: new patch, split out of the u_ether fix at Andy's suggestion.
Link: https://lore.kernel.org/all/20261105072147.3383565-2-liuc63@xiaopeng.com/

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

