Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02777428474
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502186; cv=none; b=ALCR+4s2/mua5ET89cbPfLtwwgpyUdj2sZUx+4AySYL0VIXN17HCvfUNbygGS/Ke4FbJLMFYh4XB1SYG9AIxnWqFjLkQMWFJpPwjKTqPGwxNwkAdhhSrgVQFztJa3EPObpLsXtaSVeCzEb4xQOWceg5ZxFQKDP0II72/eQNnXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502186; c=relaxed/simple;
	bh=9P0WpGY72xMhlB4Udj2rQ82OrLDkKvAS4z6Gv+1k6i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YShkRv1Fom/3aWVcFecqpIfef5znW4eHaTXOVOMHAwFMMTj9lM2KyUaiR/3kVgHDD8fsnNyJAhJQElI8JfKNNyvE99H6iuGUH3cxgMt+b5FS/Y375NDBCOPA9lFbWFfUttxi8Z6KqLZl/TeFE59F8f+aY6s9mHxHsulQ38v5NQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xca6Ga2t; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xca6Ga2t"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8143daf89c7so9065147b3.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785502184; x=1786106984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMT9YR+Z2gS6Eh7vbnulZB5ih8XO9hWY1MpWR6T+nYA=;
        b=Xca6Ga2tJScuSlmKm+nbmNria8pJ72Gn5autHpxMnJokzaNsQFjUr3dEbij2kgjIZV
         V2y2rPS93lFCaRjnyGQwMHVr8ZZuVWjznMLDhzBWvyVBLwIujBN8xYsKBiq8ApHD3uqt
         uKz6wCN+DiOojl9UcQzXCrvx4j4T1ln/v3OAqrJQl3km5ptEeVGtYC4dtHQTiTro663E
         6FqQ0XmKWupxMxuPpBZtEzWwZpVDP9v5kxUeTrRR9y/vC7cJ7Rz/cObw/Zrj+hmQKVvZ
         6VgaMoowqF5w4tIy63CCZgYoGGzQZuOPEQ4AQiVH1E87Jwue8QNfAFp//udY+c0LrLNn
         zjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502184; x=1786106984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMT9YR+Z2gS6Eh7vbnulZB5ih8XO9hWY1MpWR6T+nYA=;
        b=HXDRaya1xxus/J0iEqrp1LI5uxCZI+ONcurOI/9T4xusS2ZRJUVpEXiwYKiT+//5cQ
         zNIpS11CILg15N0QsxYL/+tAv2UU6oM9oTVBFBiQdPw0ANWr1pCtI16rjtYYyIealyT6
         o75/fS+mXgyJMNiNPPMIxkCpNPdnGfBezVAkBIG8hWklL8on0NQKIqjGtmpX2rGhYx14
         Obs3/rtrGf6VFshX85RkGxJJJA7FNs1BeycN0sbwcoCpV587TkHH94/RM6stSSXhoPvj
         +AEXSBDT9p6vZcKAH58gfSO6CSehDbXnN9s+tFjCR2qFt/5h4fm7lzo7VlnMFycgHVs6
         7fvQ==
X-Gm-Message-State: AOJu0YxrgSXJ6c6nzPRASE68JKciDTMPtJZFm7/B9d4SGZ27IhOVXJuN
	St02Kg5FRoeuPlOuILCoy1oXxVKlmbvRXu/B4941tFMIkoqzzot00S1+
X-Gm-Gg: AR+sD111TlpKQJ7omXIfbL1oE1RLAQ1872DuidqFercv3YMr5D648gJe5SJAKCKSUYo
	ZYq/+Mx8VBITBgC9UlVnlsJgDJ6x2pOCOti+FXfasU6B/C8Q/qTvfExVTYcx3VIUv+zMhO9E2HR
	Y5Ef1bLDB0d9ioK+0GbgrBXNgbArJjpipbMFmz151XWj887pV5RiwWaNXGYF+rXj2owDP8e9Ofy
	1k2aIXHgwhbOwfTNeOWh0XygGE5nfRMW7IcFZdjOpmsniPW36mnu0ekT+O/LiZvm73IlcveyLbo
	S5i8EEBGO71TIZP4x3pU5ES3xmBZg9BQplUhYffGF/bahXGDggdH3Au0v+t/k/ocwJvS5nG+zf/
	LwgBqFgm6ANoHmppnG0V9vWKP3F84Umfs/1TFGLn8lDn9SOZwhbCNpTt5Or5oyikag1kF7cvx96
	kLt2LczfYN2aLsEJPvy52jUkfoelPYVq3syasLeLRJ5bhLY2cXa9bin/vehkQ2/Ys=
X-Received: by 2002:a05:690c:318:b0:81d:c233:aea0 with SMTP id 00721157ae682-81fcbab8b90mr16379287b3.18.1785502183999;
        Fri, 31 Jul 2026 05:49:43 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:49:43 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 3/3] iavf: use cached page_pool ref in skb helpers
Date: Fri, 31 Jul 2026 08:41:09 -0400
Message-ID: <20260731124109.99065-4-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
References: <20260731124109.99065-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deriving a reference to the page pool from netmem_desc requires loading
the struct. We already have a cached reference to the pool, so use that
instead.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 3ae2f0a0ee4d..9dc5f0761d8b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1184,6 +1184,7 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
 
 /**
  * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
+ * @pp: page pool the buffer was allocated from
  * @skb: sk_buff to place the data into
  * @rx_buffer: buffer containing page to add
  * @size: packet length from rx_desc
@@ -1193,11 +1194,11 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
  *
  * The function will then update the page offset.
  **/
-static void iavf_add_rx_frag(struct sk_buff *skb,
+static void iavf_add_rx_frag(const struct page_pool *pp, struct sk_buff *skb,
 			     const struct libeth_fqe *rx_buffer,
 			     unsigned int size)
 {
-	u32 hr = netmem_get_pp(rx_buffer->netmem)->p.offset;
+	u32 hr = pp->p.offset;
 
 	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
 			       rx_buffer->netmem, rx_buffer->offset + hr,
@@ -1206,17 +1207,19 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 
 /**
  * iavf_build_skb - Build skb around an existing buffer
+ * @pp: page pool the buffer was allocated from
  * @rx_buffer: Rx buffer to pull data from
  * @size: size of buffer to add to skb
  *
  * This function builds an skb around an existing Rx buffer, taking care
  * to set up the skb correctly and avoid any memcpy overhead.
  */
-static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
+static struct sk_buff *iavf_build_skb(const struct page_pool *pp,
+				      const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
 	struct page *buf_page = __netmem_to_page(rx_buffer->netmem);
-	u32 hr = pp_page_to_nmdesc(buf_page)->pp->p.offset;
+	u32 hr = pp->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
@@ -1430,9 +1433,9 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 
 		/* retrieve a buffer from the ring */
 		if (skb)
-			iavf_add_rx_frag(skb, rx_buffer, fields.len);
+			iavf_add_rx_frag(pp, skb, rx_buffer, fields.len);
 		else
-			skb = iavf_build_skb(rx_buffer, fields.len);
+			skb = iavf_build_skb(pp, rx_buffer, fields.len);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-- 
2.43.0

