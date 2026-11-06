Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934377;
	b=Wkzcaq/ggUazPOaorTH0VXI0l9wY+ID66NvXuHpSLXoM6QprEJ7Chn4VBBJiWv+jbYqs
	 6jCQmFfJJiMJepvycFGTLTIHZ1I5f8WvGWlyNuFtUOcOPdGxrynmENS4KT86nmdgQFhAa
	 z9q2kLNQdBspDKkDoyrsHSDygNzQsPrMpDyc5Cns1A0QvUsI+zK5b3LkQurc0njDDCjPw
	 ghZwVjI5dqbaC2UYyTg71CvHRBAi65VC01OwchHBeRI+h8k2gBAe7T7wuZJo4b0qwC2Ea
	 z4Rpw/a/Ka3laVDjUTndk3mleHdHDLxX+t/I0hkvFCrGJGbtHHMfaadImZ93h6MmpNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934377;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NSqBRurZnkKGw7ftlXj3isVOHyFEsCJCLlFKOaQYeiA=;
	b=hivuoLkpiSeiI0Qcdi/JFNFx431TObxzzzSDY2bBv9YL7XK5/7pcYG4ymJ+scEwCxgCa
	 SzbCWYI+KdcDUzj7w9m1isIQZrU8Ek9YdDA1glBvBwmvBRj8YaIQFXwfKzzVzOrf4vY4h
	 fDdQOY+tosCdNUgfS/PdZuEKQ4hIBwsNiowUDVCQEZbYwMqZQ52UNiVi+pyZrbDAtWTit
	 +BQbL/iGDSV+NNsJyLiuf+lMPNp+499UbkdN0rfTGZ183d6IstenhoX6jwMv4wOT4Vh9r
	 ZG792eODINMZg0nQXy5douz8vvtgWzFI99iHiw7FQavj9YQ+Hz6vIDgRJJ2/bL9LMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hKxsXw6X;
	arc=none smtp.remote-ip=115.124.28.121
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC3606A330;
	Fri,  6 Nov 2026 03:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98BC3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hKxsXw6X
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793934372; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NSqBRurZnkKGw7ftlXj3isVOHyFEsCJCLlFKOaQYeiA=;
	b=hKxsXw6X2LNykoVMWlOW5c16e588thX4MzVQ8qpL3yZ0Lvh1i1njE5qkzxHU+gv7NMj/ShLLrXsu57OmrLHcFStKQjtdab/rDQgD3VVG3l8JVVxZpkuODRdYegbkvG4a0q4lWKqe1RzhaTyKdHJbZC6WCSiOhg9JSI5ofoJPfAM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436267|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00409698-7.81501e-05-0.995825;FP=17340114214213848240|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxsfG6T_1793934368;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxsfG6T_1793934368 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 11:06:09 +0800
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
Subject: [PATCH v4 2/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Fri,  6 Nov 2026 11:06:05 +0800
Message-ID: <20261106030605.576584-3-liuc63@xiaopeng.com>
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
gether_set_host_addr().  Their store handler passes the whole configfs
buffer on, so an overrun there stays inside the same object and is never
reported, but a malformed address is silently accepted all the same.

Replace the open coded loop with parse_mac_pton() for the delimited
notations and hex2bin() for the raw one, and keep the existing
eth_random_addr() fallback for everything both of them reject.
parse_mac_pton() checks the length and every digit before writing
anything to dev_addr, and hex2bin() stops at the first character that is
not a hex digit, which the NUL terminator is, so neither reads past the
end of the string.

The notations that keep working are the byte pair ones, ':' and '.', in
any mixture, and the separator-less "aabbccddeeff".  What stops working
is the Cisco notation "aabb.ccdd.eeff" and irregular groupings such as
"123456:789abc", which the old loop only accepted because it skipped a
delimiter wherever it happened to find one.  Supporting them would need
a parser per grouping, so such input now falls back to a random address.

Neither of the two should be missed: they are historical notations that
are rarely met these days, and the commit that introduced the loop never
said that it accepted them.  That commit only explains that it resolves
a FIXME by adding module parameters for stable addresses, so skipping a
delimiter wherever one happens to turn up reads as a simplification of
the parser rather than as support for non-standard formats.

Select GENERIC_NET_UTILS so that parse_mac_pton() is built in.

The loop is older than the git history.  It was introduced by
331a2d82bcaf ("[PATCH] USB: ethernet/rndis gadget address params") from
v2.6.7 in drivers/usb/gadget/ether.c, and commit 2b3d942c4878 ("usb
ethernet gadget: split out network core") copied it into u_ether.c.
331a2d82bcaf predates the git conversion and only resolves in the
historic tree history.git, so a Fixes: tag naming it would not resolve
for most readers and is left out.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v4: pick up Andy's Reviewed-by; name 331a2d82bcaf from v2.6.7 as the
    commit that introduced the loop and note that it only resolves in
    history.git; record that the notations being dropped are historical
    and were never documented as supported.  No code change.
v3: fall back to hex2bin() so that the separator-less notation keeps
    working, as suggested by Andy; drop the Fixes tag, the loop predates
    the git history.
v2: rework on top of parse_mac_pton(), add the KASAN report and the
    malformed address example, select GENERIC_NET_UTILS, drop Cc: stable
    and the Reviewed-by.
Link: https://lore.kernel.org/all/20261105072147.3383565-3-liuc63@xiaopeng.com/

 drivers/usb/gadget/Kconfig            |  1 +
 drivers/usb/gadget/function/u_ether.c | 18 ++++++++----------
 2 files changed, 9 insertions(+), 10 deletions(-)

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
index 59d85d6a84a8..deedea8a19fd 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -686,18 +686,16 @@ static int eth_stop(struct net_device *net)
 static int get_ether_addr(const char *str, u8 *dev_addr)
 {
 	if (str) {
-		unsigned	i;
+		bool valid;
 
-		for (i = 0; i < 6; i++) {
-			unsigned char num;
+		/* Try the delimited formats first */
+		valid = parse_mac_pton(str, dev_addr, ".:");
+		if (valid && is_valid_ether_addr(dev_addr))
+			return 0;
 
-			if ((*str == '.') || (*str == ':'))
-				str++;
-			num = hex_to_bin(*str++) << 4;
-			num |= hex_to_bin(*str++);
-			dev_addr [i] = num;
-		}
-		if (is_valid_ether_addr(dev_addr))
+		/* Fall back to the raw format */
+		valid = hex2bin(dev_addr, str, ETH_ALEN) == 0;
+		if (valid && is_valid_ether_addr(dev_addr))
 			return 0;
 	}
 	eth_random_addr(dev_addr);
-- 
2.50.1

