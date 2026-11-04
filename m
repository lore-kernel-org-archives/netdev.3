Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760671;
	b=X4kPqFi6Yyntv4HmEBFRAmLukLOtTDznDT2bnuqFxA6snBSbGtaqxEmbtPKMka9XpPB1
	 ZpcjLTMmhOd+U/x+4YEc79f7115szJ7mPyfkp7rstc4mxd7eqoWyi/i1avsrMYM7ZouvX
	 QAYPU/zoliNA0ASubZkzogxqjZnI7RlgMomqoRpAEZA0J5VqmY9L4u+HbdFdKTE/bXIDW
	 s8fxJUvHHIk2yOgxG6SRFv+98tmwYlN71r0itwmPmyt3F90Ml3gfCB9KXbLFMFwV8DueC
	 dFfL4rG8nSSjqhYgb2P9r5WL+C/f7DQm2hb9WwBMtuRXOIzbD1X7eHzUq9t0gOZ17CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760671;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UUhFrC9KIt/+WPshEq4e2ByV/S4rjw7qIzYClVi5EXM=;
	b=PKUHMtkUzmuQOd8P4l5ZMdpWpGmggK4VtI68dvQW7nDh7jvMTiv+d04+BBMN61JOP8+q
	 /cniE5xaLFpD8jdILYp9it4Vu00Fnpl/qfl8jKGQTinRwfZL6bBjs7Y8FFgqUcA6bEHhB
	 BsQiL5pVlgQvR+OsdCAw8ODvuFn5tT8vPZ7IRfjfW9kNDzF82M7PhUxsh5T5UFD+mJ6t7
	 sDlmovU6Itw1f6qvBGKSPuofr28jYk14diBaaXseCypPSEyAHhcqUqrIWimm14aQRIhec
	 SPNEOX7qADLwWaRnVsajWr4wtaaTxrnmKZ63tlg37tfjfDaXcAXRnv825DwDoU7r2kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ncWYpGBl;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F53606A331;
	Wed,  4 Nov 2026 02:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F53606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ncWYpGBl
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793760663; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UUhFrC9KIt/+WPshEq4e2ByV/S4rjw7qIzYClVi5EXM=;
	b=ncWYpGBleOih+MAOQsyXUP1WpXoIuOoDKr0o26tNEOQQ5dD2HW4HR7NM6yO66GSiZY1YCGHEqVvJwU5K9hjPaMF7xdeIJ0ieSSBC0sUhGToVW3QZdfKitdlgVeHGxtqdqbJMCzQIcZ3ODimxlBmkuCKHQS1poSHXca9BVZbjAqE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743648|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00499233-7.36624e-05-0.994934;FP=16207564753372531952|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jwK3XLT_1793760661;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jwK3XLT_1793760661 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 10:51:02 +0800
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
Subject: [PATCH v2 2/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Wed,  4 Nov 2026 10:50:58 +0800
Message-ID: <20261104025058.2650911-3-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261104025058.2650911-1-liuc63@xiaopeng.com>
References: <20261104025058.2650911-1-liuc63@xiaopeng.com>
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

get_ether_addr() walks the MAC address string with a fixed six iteration
loop, calling hex_to_bin() twice per iteration, and never checks for the
terminating NUL.  A short string therefore makes it read past the end of
the buffer.  The dev_addr and host_addr module parameters of the legacy
gadget drivers are copied into their own kmalloc'ed buffer by
param_set_charp(), so the overrun crosses a slab boundary and KASAN
reports it at insmod time:

  # insmod g_ether.ko dev_addr=ab

  BUG: KASAN: slab-out-of-bounds in get_ether_addr+0x1ec/0x230
  Read of size 1 at addr ffff888009f91f53 by task insmod/70
  ...
   get_ether_addr+0x1ec/0x230
   gether_set_dev_addr+0x6b/0x180
   eth_bind+0xfd/0x3b0 [g_ether]
   composite_bind+0x1bb/0x7b0
   gadget_bind_driver+0x229/0xb00
  ...
  Allocated by task 70:
   __kmalloc_noprof+0x1d1/0x4a0
   param_set_charp+0x4a/0x220
   parse_args+0x267/0x5c0
   load_module+0x4f6a/0x6600
  ...
  The buggy address is located 0 bytes to the right of
   allocated 19-byte region [ffff888009f91f40, ffff888009f91f53)

Besides reading past the end of the string, the loop ignores what
hex_to_bin() returns: it yields -1 for a character that is not a hex
digit, and that value is shifted and OR'ed into dev_addr unchecked, so a
malformed address can be accepted as a valid one and the interface comes
up with an address that nobody asked for:

  # insmod g_ether.ko dev_addr=aazz:cc:dd:ee:ff
  # cat /sys/class/net/usb0/address
  aa:ff:cc:dd:ee:ff

The configfs dev_addr and host_addr attributes of the ECM and NCM
functions reach the same parser through gether_set_dev_addr() and
gether_set_host_addr().  Their store handler passes the page-sized
configfs buffer straight on, so an overrun there stays inside the same
object and is never reported, but a malformed address is silently
accepted all the same.

Replace the open coded loop with parse_mac_pton(), which checks the
length and every digit before writing anything to dev_addr, and keep the
existing eth_random_addr() fallback for all failures.

Note that this makes the accepted syntax stricter: the old loop also took
a separator-less string such as "aabbccddeeff" and the Cisco notation
"aabb.ccdd.eeff", both of which parse_mac_pton() rejects, so such input
now falls back to a random address instead of being parsed.

Select GENERIC_NET_UTILS so that parse_mac_pton() is built in.

Fixes: 2b3d942c4878 ("usb ethernet gadget: split out network core")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
v2: rework on top of parse_mac_pton() instead of open coding the bounds

 drivers/usb/gadget/Kconfig            |  1 +
 drivers/usb/gadget/function/u_ether.c | 14 +++-----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 76521555e3c1..b83c42be686b 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -158,6 +158,7 @@ config USB_U_SERIAL
 
 config USB_U_ETHER
 	tristate
+	select GENERIC_NET_UTILS
 
 config USB_U_AUDIO
 	tristate
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 59d85d6a84a8..26471cb086b3 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -686,18 +686,10 @@ static int eth_stop(struct net_device *net)
 static int get_ether_addr(const char *str, u8 *dev_addr)
 {
 	if (str) {
-		unsigned	i;
+		bool valid;
 
-		for (i = 0; i < 6; i++) {
-			unsigned char num;
-
-			if ((*str == '.') || (*str == ':'))
-				str++;
-			num = hex_to_bin(*str++) << 4;
-			num |= hex_to_bin(*str++);
-			dev_addr [i] = num;
-		}
-		if (is_valid_ether_addr(dev_addr))
+		valid = parse_mac_pton(str, dev_addr, ".:");
+		if (valid && is_valid_ether_addr(dev_addr))
 			return 0;
 	}
 	eth_random_addr(dev_addr);
-- 
2.50.1

