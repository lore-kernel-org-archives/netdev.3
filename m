Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143413890E0
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760710; cv=none; b=srx/I/caYKzfe2AgkWu6q3qaCJ7ov+lc2mQoHdASzN8bCSmmCZy2FeMXrRQtz7JPy7mdyOmlNj5e+zz8bjiSmQmaGgcsmXtzTBDkEFo0uoXu4dEm0fuSWyxpMy2k1uNskeZMeuEWBPzJd2O+5A0HavKPrhftekO6iBrLRlafpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760710; c=relaxed/simple;
	bh=UVqQr7ZzsWjJxJKPp0/dlfrz/Hzlj+Njg9CldDgfT3c=;
	h=From:Mime-Version:Content-Type:To:Subject:Message-Id:Cc:Date; b=rFBQOvDo/ic8uDIYpWYR6fPP8eaPL5U+MAMmmAC6cmrRaNkLprKiC1GCUYwFeFlsYPQ1DGGQx9KfCSbknIKOcORHjSGbusKhHLLViNMh2+NSknIKV+aNYrRS/BJG3G5aYRghSxQX3uu7Z3DWA6zfK586DEI58Av2auzVNggv4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=XssAbK15; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="XssAbK15"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788760697; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EXce8WNCt7tmMo1/aZLT8dvcxxF3rqzOVQZpw6dbimM=;
 b=XssAbK15OS9bVJcgI170RDSVxMTYrOUZruJDXvLB3tGmrfz1T8tEBabIVfDfo6KPHjWNxH
 PdOSzkEViL+FOP5FDcOx3QvPh7x10or29mVOb+K0h7hGb2YDwB2fDUl1ZtLKFblpfU2Xqf
 zr2VAK71LiWOqs3QQIfd9RG087jQte6S4CaldDpFeijtASrObXuNDZ/r5Sk2tJIrrvjVQc
 MttJSpdcn/nVQqpOGQY3aztzquMHCq6aLF7sf2qdl6xDOqBTYvy7tuBLZuIWmnq/jK2RjL
 RzwuIID3nvfJU0eNg21taOJVQVlwu7on770xkxQcwxddpYJ+AlbV0FhX/Ewgdg==
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
To: "Paul Mackerras" <paulus@samba.org>
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Mon, 07 Sep 2026 13:58:14 +0800
Subject: [PATCH net] ppp: deflate: validate output buffer sizes
Message-Id: <20260907055809.3379942-1-yilinzhang@moonshot.ai>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <linux-ppp@vger.kernel.org>, 
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
X-Lms-Return-Path: <lba+26a9e5277+f740bd+vger.kernel.org+yilinzhang@moonshot.ai>
Date: Mon,  7 Sep 2026 13:58:09 +0800

z_compress() assumes that the output buffer can hold the six-byte
PPP/Deflate header.  With an MTU of 1, pad_compress_skb() supplies an
output size of 5.  The header write overruns the skb and subtracting the
header length makes avail_out wrap, allowing zlib to continue writing
past the allocation.

Use a real scratch buffer to discard compressed output when the caller's
buffer has no payload space or becomes full.  Continue consuming input so
the compressor history remains synchronized with the peer.  Unlike the
previous NULL output convention, a real buffer is also safe for the s390
DFLTCC backend.

Take one READ_ONCE() snapshot of the MTU when deriving both the allocation
and compressor sizes.  Otherwise a concurrent MTU increase can make the
compressor receive a size larger than the skb allocated from an earlier
read, bypassing its bounds check.

z_decompress() likewise assumes that the output buffer can hold a PPP
header.  PPPIOCSMRU accepts -1, causing ppp_decompress_frame() to allocate
a three-byte skb.  After decoding the first protocol byte, subtracting
PPP_HDRLEN makes avail_out wrap and lets inflate overwrite the skb.

Reject undersized decompression buffers before writing the header.

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
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Co-developed-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 drivers/net/ppp/ppp_deflate.c | 43 +++++++++++++++++++++++------------
 drivers/net/ppp/ppp_generic.c |  5 ++--
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ppp/ppp_deflate.c b/drivers/net/ppp/ppp_deflate.c
index d6d5e656b3f4..96d689b97fdf 100644
--- a/drivers/net/ppp/ppp_deflate.c
+++ b/drivers/net/ppp/ppp_deflate.c
@@ -186,7 +186,9 @@ static int z_compress(void *arg, unsigned char *rptr, unsigned char *obuf,
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 	int r, proto, off, olen, oavail;
+	unsigned char discard_buf[64];
 	unsigned char *wptr;
+	bool discard;
 
 	/*
 	 * Check that the protocol is in the range we handle.
@@ -200,20 +202,29 @@ static int z_compress(void *arg, unsigned char *rptr, unsigned char *obuf,
 	if (osize > isize)
 		osize = isize;
 
-	wptr = obuf;
-
 	/*
-	 * Copy over the PPP header and store the 2-byte sequence number.
+	 * Copy over the PPP header and store the 2-byte sequence number only if
+	 * there is room for compressed data.  Otherwise discard the compressed
+	 * output while consuming the input, so the compressor history remains
+	 * synchronized with the peer.
 	 */
-	wptr[0] = PPP_ADDRESS(rptr);
-	wptr[1] = PPP_CONTROL(rptr);
-	put_unaligned_be16(PPP_COMP, wptr + 2);
-	wptr += PPP_HDRLEN;
-	put_unaligned_be16(state->seqno, wptr);
-	wptr += DEFLATE_OVHD;
 	olen = PPP_HDRLEN + DEFLATE_OVHD;
-	state->strm.next_out = wptr;
-	state->strm.avail_out = oavail = osize - olen;
+	discard = osize <= olen;
+	if (discard) {
+		state->strm.next_out = discard_buf;
+		oavail = sizeof(discard_buf);
+	} else {
+		wptr = obuf;
+		wptr[0] = PPP_ADDRESS(rptr);
+		wptr[1] = PPP_CONTROL(rptr);
+		put_unaligned_be16(PPP_COMP, wptr + 2);
+		wptr += PPP_HDRLEN;
+		put_unaligned_be16(state->seqno, wptr);
+		wptr += DEFLATE_OVHD;
+		state->strm.next_out = wptr;
+		oavail = osize - olen;
+	}
+	state->strm.avail_out = oavail;
 	++state->seqno;
 
 	off = (proto > 0xff) ? 2 : 3;	/* skip 1st proto byte if 0 */
@@ -231,8 +242,10 @@ static int z_compress(void *arg, unsigned char *rptr, unsigned char *obuf,
 		}
 		if (state->strm.avail_out == 0) {
 			olen += oavail;
-			state->strm.next_out = NULL;
-			state->strm.avail_out = oavail = 1000000;
+			discard = true;
+			state->strm.next_out = discard_buf;
+			oavail = sizeof(discard_buf);
+			state->strm.avail_out = oavail;
 		} else {
 			break;		/* all done */
 		}
@@ -242,7 +255,7 @@ static int z_compress(void *arg, unsigned char *rptr, unsigned char *obuf,
 	/*
 	 * See if we managed to reduce the size of the packet.
 	 */
-	if (olen < isize && olen <= osize) {
+	if (!discard && olen < isize && olen <= osize) {
 		state->stats.comp_bytes += olen;
 		state->stats.comp_packets++;
 	} else {
@@ -420,6 +433,8 @@ static int z_decompress(void *arg, unsigned char *ibuf, int isize,
 			       state->unit, isize);
 		return DECOMP_ERROR;
 	}
+	if (osize < PPP_HDRLEN)
+		return DECOMP_ERROR;
 
 	/* Check the sequence number. */
 	seq = get_unaligned_be16(ibuf + PPP_HDRLEN);
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893b..0443af231e8b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1719,10 +1719,11 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
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
