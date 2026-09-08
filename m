Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C74A090A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856900; cv=none; b=YqE5Jm7yoTCw6hwelyEQ7PKyDzn6V/VKktzGcRHL7ZX+2gt4CwwWXrAaiIJlCngwFhE+AglvLwPchi3Fk/nEuZ3wypwhin04aj7uiJOcsavrhoIDSyucG/uX+j80xtfhqAMdE125lNM7+i591OHH5VZZ5jKb5Mjjf7lc0plE2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856900; c=relaxed/simple;
	bh=wY3VV5WDN1nI99aH2yAc9UFlxwaH9JlgtrHoShr7BTI=;
	h=To:Date:From:Message-Id:Subject:Content-Type:Cc:Mime-Version; b=hle9eOZSS5GS/Vh5wTefa2YZyifJHPCtJbbyxpGeepw59wXjJvFQhYEg8YjwEH9Q+4dtsl7kUSpFV0f27zNnpI+n2TmWOcW2eg4wVklEZQ1aHGLLRIuGmya617OdbkgWX30M9G/kUSsMvxwUnlKOr4ZxNE5gy5kgdqAO+LhSnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=igU+VauJ; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="igU+VauJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788856886; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5o7fWMlFekwwncUURIGYfK7rbrZX2OhHQRVSVrU9p+w=;
 b=igU+VauJ8HLhNVdaQf16qG27f3O9AROpbiVYrV+3fvNwBlwVMYcp5svve6kEboFl/LN4M2
 mW9kFqvmDVO9esq6fJk5TtdD/P8gYWb/RNOL7mhaDPIAXEPvE5zt2bOiQYIyVsSakfbt/g
 GkKS8oHbkVMY/GTkpHJxWwX8K6tZ3Xt9Yj7exbHWrn39Zp8+aBuYJ/BQQeXZJNqF2uDwC3
 gmy+evkeJVDvnwQQkwXrw7GfiMrM4cjPIyQ4PBxVF15s5o+Fu1fdjDlgmOGeqhIX+TOkHj
 smw/BEzrpxnhzOk3N/I9XwFMvMsbVkau72Zt/2EnGHOhcwvnM9eaUGMZ27fL3Q==
To: "Paul Mackerras" <paulus@ozlabs.org>
Date: Tue,  8 Sep 2026 16:41:16 +0800
X-Lms-Return-Path: <lba+26a9fca35+6aa51c+vger.kernel.org+yilinzhang@moonshot.ai>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Message-Id: <20260908084116.634633-1-yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Tue, 08 Sep 2026 16:41:23 +0800
Subject: [PATCH net v2] ppp: enforce minimum MTU/MRU to fix Deflate buffer underflows
Content-Type: text/plain; charset=UTF-8
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <linux-ppp@vger.kernel.org>, 
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1

z_compress() assumes that its output buffer can hold the six-byte
PPP/Deflate header.  A user with CAP_NET_ADMIN can set the MTU to 1,
making pad_compress_skb() allocate a five-byte skb.  z_compress() then
writes the header past the end and makes avail_out wrap when subtracting
the header length, allowing zlib to continue writing past the allocation.

On receive, PPPIOCSMRU accepts any signed int.  An MRU of -1 makes
ppp_decompress_frame() allocate a three-byte skb, after which
z_decompress() writes the PPP header and makes avail_out wrap when
subtracting PPP_HDRLEN, letting inflate overwrite the skb.

Set the PPP netdevice minimum MTU to 128 and reject MRU values below 128
(or large enough to overflow the allocation-size calculation) in
PPPIOCSMRU, matching the minimum that pppd uses when negotiating MRU
values.  This ensures that the output buffer seen by z_compress() and
z_decompress() always covers the PPP/Deflate header, so avail_out
cannot wrap.

Take one MTU snapshot when calculating both the skb allocation and
compressor sizes, so a concurrent MTU change cannot make them
inconsistent.

The two memory-corruption paths produce (Linux 6.1.0, KASAN, decoded):

  BUG: KASAN: slab-out-of-bounds in deflate_slow (lib/zlib_deflate/defutil.h:431 lib/zlib_deflate/deflate.c:1123)
  Write of size 8198 at addr ff110000045edc06 by task exp/78
  CPU: 1 PID: 78 Comm: exp Not tainted 6.1.0 #1
  Call Trace:
    kasan_check_range (mm/kasan/generic.c:190)
    memcpy (mm/kasan/shadow.c:65)
    deflate_slow (lib/zlib_deflate/defutil.h:431 lib/zlib_deflate/deflate.c:1123)
    zlib_deflate (lib/zlib_deflate/deflate.c:412)
    z_compress (drivers/net/ppp/ppp_deflate.c:227)
    __ppp_xmit_process (drivers/net/ppp/ppp_generic.c:1703 drivers/net/ppp/ppp_generic.c:1826 drivers/net/ppp/ppp_generic.c:1646)
    ppp_xmit_process (drivers/net/ppp/ppp_generic.c:1668)
    ppp_write (drivers/net/ppp/ppp_generic.c:520)

  Allocated by task 78:
    __alloc_skb (net/core/skbuff.c:437 net/core/skbuff.c:509)
    __ppp_xmit_process (include/linux/skbuff.h:1267 drivers/net/ppp/ppp_generic.c:1692 drivers/net/ppp/ppp_generic.c:1826 drivers/net/ppp/ppp_generic.c:1646)
    ppp_xmit_process (drivers/net/ppp/ppp_generic.c:1668)
    ppp_write (drivers/net/ppp/ppp_generic.c:520)

  The buggy address belongs to the object at ff110000045edc00
   which belongs to the cache kmalloc-512 of size 512
  The buggy address is located 6 bytes inside of
   512-byte region [ff110000045edc00, ff110000045ede00)

  BUG: KASAN: slab-out-of-bounds in zlib_inflate (lib/zlib_inflate/inflate.c:458)
  Write of size 8191 at addr ff110000021d1044 by task ksoftirqd/0/12
  CPU: 0 PID: 12 Comm: ksoftirqd/0 Not tainted 6.1.0 #1
  Call Trace:
    kasan_check_range (mm/kasan/generic.c:190)
    memcpy (mm/kasan/shadow.c:65)
    zlib_inflate (lib/zlib_inflate/inflate.c:458)
    z_decompress (drivers/net/ppp/ppp_deflate.c:460)
    ppp_receive_nonmp_frame (drivers/net/ppp/ppp_generic.c:2546 drivers/net/ppp/ppp_generic.c:2383)
    ppp_input (drivers/net/ppp/ppp_generic.c:2355 drivers/net/ppp/ppp_generic.c:2195 drivers/net/ppp/ppp_generic.c:2310)
    ppp_async_process (drivers/net/ppp/ppp_async.c:496)

  Allocated by task 12:
    __alloc_skb (net/core/skbuff.c:437 net/core/skbuff.c:509)
    __netdev_alloc_skb (net/core/skbuff.c:575)
    ppp_receive_nonmp_frame (include/linux/skbuff.h:3155 include/linux/skbuff.h:3168 drivers/net/ppp/ppp_generic.c:2539 drivers/net/ppp/ppp_generic.c:2383)
    ppp_input (drivers/net/ppp/ppp_generic.c:2355 drivers/net/ppp/ppp_generic.c:2195 drivers/net/ppp/ppp_generic.c:2310)
    ppp_async_process (drivers/net/ppp/ppp_async.c:496)

  The buggy address belongs to the object at ff110000021d1000
   which belongs to the cache kmalloc-512 of size 512
  The buggy address is located 68 bytes inside of
   512-byte region [ff110000021d1000, ff110000021d1200)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Co-developed-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 drivers/net/ppp/ppp_generic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Changes in v2:
- Set dev->min_mtu = 128 and reject MRU < 128 in PPPIOCSMRU per Paul's
  suggestion; drop the z_compress()/z_decompress() changes from v1.

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a1..4022117 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,8 @@
 
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
+#define PPP_MIN_MTU	128
+#define PPP_MIN_MRU	128
 
 /* The filter instructions generated by libpcap are constructed
  * assuming a four-byte PPP header on each packet, where the last
@@ -808,6 +810,10 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		if (val < PPP_MIN_MRU || val > INT_MAX - PPP_HDRLEN - 1) {
+			err = -EINVAL;
+			break;
+		}
 		ppp_recv_lock(ppp);
 		ppp->mru = val;
 		ppp_recv_unlock(ppp);
@@ -1628,6 +1634,7 @@ static void ppp_setup(struct net_device *dev)
 
 	dev->hard_header_len = PPP_HDRLEN;
 	dev->mtu = PPP_MRU;
+	dev->min_mtu = PPP_MIN_MTU;
 	dev->addr_len = 0;
 	dev->tx_queue_len = 3;
 	dev->type = ARPHRD_PPP;
@@ -1719,10 +1726,11 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 {
 	struct net_device *dev = netdev_from_priv(ppp);
 	struct sk_buff *new_skb;
+	int mtu = READ_ONCE(dev->mtu);
 	int len;
-	int new_skb_size = dev->mtu +
+	int new_skb_size = mtu +
 		ppp->xcomp->comp_extra + dev->hard_header_len;
-	int compressor_skb_size = dev->mtu +
+	int compressor_skb_size = mtu +
 		ppp->xcomp->comp_extra + PPP_HDRLEN;
 
 	if (skb_linearize(skb))
-- 
2.55.0
