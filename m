Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F74F3914
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568502; cv=none; b=m04ka9wfDMhBaxOl+P9jS1xo3LEC0e5bO6nIWPpEBtTm9r39FteqIyJgeBROxiAESXuBKvdihex5J2QpSruI3jDZxb/3hTNHmAarsJ+lHNB39TcoUzq7EYpiM0+Zbh/HzHt8Xw1HH7Wji0DZoVNCJVqOq1/XucwZcc/F/U7wDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568502; c=relaxed/simple;
	bh=1Um5EiCJSDVvTwK1Tyd0ZORnY2SUAT6cpGWylov2DI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WH4u3pGjE+DFPUomjdheODv+e7d7j24knNoFxajlu05CyJ6hvPjpnyI+X2OH/LULuFrI6fZfEtMk+Rv6hp3F3MZbehqubS/wGDgGF+EC3Cp2FdMO2XzOTUBKGLUomqkriqnj5aHw7w0cscFy8dyiw85XbVe6nogfonZxNme/7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=A0iXw+PB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="A0iXw+PB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab41538192so763681a91.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791568491; x=1792173291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC+umOfWsHMMd5xQqstPSm9nZ9qFadOsLmNye9AbZ80=;
        b=A0iXw+PBenJQucA9MRKSCMdBIpbtEELjLYLLA6u9GZGelwN4kFCkQ/Qo4KcZWT5eEc
         Br7gsCfLatAg1S+pObeAqhF45gn9iwVXAYibG3ORIfKTIwVijAny6pEkQfiqs0WX7Zk+
         m4fjeQMZ//qvhn3jGPjs7UmIWCATpGwrgclAPGH7tzJrApbrwinucXCSJQLP6Zt4Lvfw
         UFg4/Q77nFZIw8waLGOfyP3Z4EycDd/OgA1zOb8IGCh5C0716QxxW5jLtPuNmWz/yYfG
         5Li/QFD1VIsQylPzG7LzArYMT2ea5pP1+S8LmHr3MS3880mhiB1xbHBZwXTfN3l8k8Gh
         Vk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791568491; x=1792173291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC+umOfWsHMMd5xQqstPSm9nZ9qFadOsLmNye9AbZ80=;
        b=2gVVGcNv7aa6cm8jq600iMqee3W+3BYmPebsZ7C1VrxKPpaTP3A5DBc7hkJlnt3IFK
         IXc7ft64k9LKaoVgKKVuUP3gPyRqn8qE7R2MC7FBvNFdkszVD1CarnIyken28GsjFwSy
         q7rqwWjRg//tgYo3urKWLXLWSNb8X+m5R6BQ1nb5NYGLS0bEdm8Vur/Vss62DeITQan3
         T0DDSoRYtmRuOt7VdxqKsxfRVPJ9ceGaQ/znTUsFE7VFeK9HWvV/zK02HucKU/mQ8r4H
         mzS5iaK/lHug4VQJDwaO4mx/r4dKIqqWDRuN/fneuxPCcIWXwyqHt/BDIPUXHKu3DDTU
         igoA==
X-Forwarded-Encrypted: i=1; AKwUvBwyB0zPA1zoCnl7qywPbVYQ1oKN++/H99PTCiEXlGtooYGmP+rEUSMQppTXPRFzloSCOKAI/vI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSKjmgPpaAlw7e4Svmgf19nuS1tmXzTe9AAY91XRunkK2F0LKf
	YgHsUSfaabswlE0hh0Qd1KHJ02NP7UAVzbcbJjao4v6in0VVzR9V3avpCnV9qo90Ga4=
X-Gm-Gg: AYBFou0oOoWbD6JQJHM8cSFbH2l33FXT+ThU0+ZMZ6FuE3fsfeK7+VuIXE/HKdGhK8K
	hkou9p8aUFdWsQAuu0e67DxxzoM95sP0ZfZ2Bz3lp7kIJ1gQyIwCy5gVqIA/1wjLmx3dYqA9Jo+
	IupzrJNuSGlgtm0M3Hv34XmJNxaBF0LNL+9NJ5dmGgzDr1wfBKtuumRh6P7rHDZr2/oJH+M5bes
	tfCAg/CHihc1MknmybA+4oOMy0VERiyDW8KMyUQh8g8X8PMmp1vgfx29R9tsLsZZN3MeDyakXxI
	v0t8McjJWy+hguv4AnY2r2wBr1TPeSjAXjJY2oa8iAoqSJw7SWqQiFdg+VWs6QfAUfxnyYUPx7G
	c6KVe9RGXjnmUqdUXriZ/9ZkfdjyR8/y+po1krSWF54rO7EKZODO9VSnIlBGc2gQUwu5RGubB1k
	f8j7cltFOHY5FoheOScigXSTI9/I8iKyv3AByyX0cxB3NKg+xH3bZs8F1C4hBNE02qKWHsj6Cb0
	nhCQhY05dTXq+Nvutvv4w==
X-Received: by 2002:a17:90b:2688:b0:3a4:adea:50ad with SMTP id 98e67ed59e1d1-3ab3a775938mr2547113a91.27.1791568490985;
        Fri, 09 Oct 2026 10:54:50 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c95f:28ac:324a:cdc3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm5596962a91.6.2026.10.09.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:54:50 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net] eth: fbnic: validate the Rx completion buffer index
Date: Sat, 10 Oct 2026 02:53:58 +0900
Message-ID: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer ID in an address/length Rx completion descriptor is a 16 bit
field, FBNIC_RCD_AL_BUFF_PAGE_MASK being DESC_GENMASK(15, 0) once the
fragment bits are removed, so the device can name any index from 0 to
65535.  fbnic_pkt_prepare() and fbnic_add_rx_frag() feed that value
straight into fbnic_page_pool_get_head() and fbnic_page_pool_get_data(),
which use it to subscript qt->sub0.rx_buf[] and qt->sub1.rx_buf[].

Those arrays only cover the buffers the driver posted.  They are
allocated with size_mask + 1 entries, and size_mask comes from
hpq_size / FBNIC_BD_FRAG_COUNT, so at the default FBNIC_HPQ_SIZE_DEFAULT
of 256 each array holds 256 entries of 16 bytes, that is 4096 bytes.  A
buffer ID of 65535 reaches 1048560 bytes past the start of the
allocation.

The fill side already masks every index it computes against
bdq->size_mask, and so does all of the ring head and tail arithmetic.
The completion side does not.  A descriptor naming a buffer that was
never posted makes fbnic_page_pool_get_head() decrement pagecnt_bias
through a pointer outside the array and hand the out-of-bounds
netmem_ref back as a struct page; page_pool_get_dma_addr() and
page_address() then dereference it and the skb is built on whatever it
points at.

Injecting an out-of-range header completion reports under KASAN:

  BUG: KASAN: slab-out-of-bounds in fbnic_page_pool_get_head
  Read of size 8 at addr ffff88800c719008
  The buggy address is located 8 bytes to the right of
   allocated 4096-byte region [ffff88800c718000, ffff88800c719000)

Check the ID against size_mask before it is used and drop the packet if
it is out of range.  Masking it instead would keep the access in bounds
but would silently attribute the completion to an unrelated buffer that
the driver does own, which is worse than a drop.  Set add_frag_failed so
the frame takes the existing error path.

Rejecting the header completion leaves pkt->buff uninitialized, and the
payload completions that follow are handled before the metadata
descriptor that looks at add_frag_failed, so fbnic_add_rx_frag() has to
bail out as well or xdp_buff_add_frag() writes through a shared info
pointer derived from a NULL data_hard_start.  Key that on
data_hard_start, the way fbnic_put_pkt_buff() already does, so the
buffer accounting on the normal path is untouched.

Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 27 ++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 10caacffee0f0..d85daab06c99c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -985,14 +985,24 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 {
 	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
 	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
-	struct page *page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
 	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
 	unsigned char *hdr_start;
+	struct page *page;
 
 	/* data_hard_start should always be NULL when this is called */
 	WARN_ON_ONCE(pkt->buff.data_hard_start);
 
+	/* A buffer ID the device never got from us cannot name a buffer we
+	 * own, so drop the packet instead of running off the end of rx_buf[].
+	 */
+	if (unlikely(hdr_pg_idx > qt->sub0.size_mask)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
@@ -1026,10 +1036,23 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
 	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
-	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
 	unsigned int truesize;
+	netmem_ref netmem;
 	bool added;
 
+	/* The header completion was rejected, so buff was never initialized
+	 * and add_frag_failed is already set.  There is nothing to add to.
+	 */
+	if (unlikely(!pkt->buff.data_hard_start))
+		return;
+
+	if (unlikely(pg_idx > qt->sub1.size_mask)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	netmem = fbnic_page_pool_get_data(qt, pg_idx);
+
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
 
-- 
2.43.0

