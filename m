Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206033E37C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481536; cv=none; b=rsN/3Lc9m26zz4GWSyOcvWdeuQxGvggnL+08dZtAHPuFpQHlhSYcVun5Pj+4p6766TiDELo4USswJtQTYFFyLzSLONH/x8F0KNPPXXrIvlgJTN5m8x4Y1Lbk3Ins5494OJ2npYQ9O5230KDPAz+rPk2oTViKMA6TyUl5tcRtcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481536; c=relaxed/simple;
	bh=XecrAEo3DqtUGtYdAI8FRG6FQKrQ5+SiDs/finIWQZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF2VNpFiqY026lt69Kjj0G8toibv1o5w8hclkpJ3xcSJ8DUDZIHZSAakWseDkVWQn+loZ9zvPW37v7S6HgDofzaDS4/b9fYo9WmATvgreKP5y8zLdsrpjDj8PCgGOBS1R4YxGJlg08wUvOUIv4F2KcnvnQ8gV1QYmB7U4JB2sqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=i0WWFV6V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="i0WWFV6V"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so829931b3a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785481534; x=1786086334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffyeDegVY5OzCAul1Kv1QWcYqJ0UI22/KMFweLvIIWQ=;
        b=i0WWFV6V9MkVRa97g6SRF5LgbtWQuPXnpLR5Q1DAZ0QYeGdTMLPTv1Mrr67nNKz/wd
         UrTRBw2Kd8YuAOOBsEQvjcS1j736NR1XlAyLF6dZXYnG1zMaytLXqb63oUPiytgn/9Qy
         +RPlI1GFJkgIb4SxPvK6mW6ckO//KpUpunljOcA0dquTj8HISQkgLR4Yp1Ug+zmQJ7bw
         omvctj82l2OO7FyENRP0UK34lZqAUXvQDyuTW9zK1LMPCrou8kFNcYZBhNKDYXAZ2KO/
         Va5vP4qYpnOHAFtHDcsRVc4yUiWdnRkGuGeo4ZnZtiiN4MFcpkCXorAo0uykV4v5WbAP
         MK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481534; x=1786086334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ffyeDegVY5OzCAul1Kv1QWcYqJ0UI22/KMFweLvIIWQ=;
        b=k2X3mfeyD2//JoYStfOSaX8+Plf6Pis3eT1uym1pgnEtHVsZ1yyL1KFE1d4Y7CaCLH
         mJLrX580+qVr2Rjd6XRHpci6CPe8M9zmWcaKTDIQ+UYbqTnulSg+8wNvhzBGDLouHGwD
         Crf5juJ1HoNQtXCYOeqly1akHNMLYqhcTTdBXcgjbSV7yzrG3yJqBGBS5Rm0rt/NISyi
         PuiW+My9bXXKG4nJPcGYTEPhcKkv/KVlrRCHUyXIHGzwGujcqATMikyqFBkYMbtTHoZ9
         pSpS3S7a6HTLEljXZMqKLtDaC49Ayt6+o0dE5/GGGLxCK2hNMICHT9erB+f6RSXBgl1I
         dQqg==
X-Forwarded-Encrypted: i=1; AHgh+RoKsYy3xOCy/jL8G6O3JM2ynbL6PVwHovIvR5RPFxFs1c3YKwb06+POxyJtqPkt75VeEF2dDq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2F6WveHUjdRoEDPXIL2G+bB7HnYdjwLcjAf/4O/UTsnat93o/
	l+EmsuerELorxJOP9IG6cRwmEtZZSrUW39UanFdQTIUHgOfx6cSJwcETO0z+AFEyjVE=
X-Gm-Gg: AR+sD10hhIgBpcpW1dltYoct0oCgIeWX0tUJeBXdmXS6YTsXAGo5BH5LVhBhk/0hCPT
	wLj9wQZlBHwIE49Wo9XebBVg/HtLE5nM432tioaN/pjagntwsw1JsNjKaAyDm/Qz+RJA7tWwSqp
	XIAcHNxiaBs9SByYIfrK765z6qrunKtswfAHluLUDh6uE6DmQJQVnYJDP5cUGNVonh81quhc0r0
	fCXDR8iExFBN1xT/yrAwf9tuve2yJAFBr2z7XHq8rDeD2TDmiX2Dj7apLuDu9VOxYf6JN3UNBIN
	Or1OMVcyjvUePoM59V2pbKdetkcQSp5Qa7McTVPtZN7X7fzjE2gE1zl5+AciLVehOuF/H7IKgXQ
	8YAu5E/KiEhWh/oqHh1oKQ3clGFexFYfrG+WTf05PO4jJHlO74/xgmOXL6CLrbtgZ6QwDff+470
	nvgLkv0HSJh9vq5bA3iBUEG8eSAZMbrSnE/I/7k8gdgzw/O7nQFCOF5iryev77e5AEcIGV
X-Received: by 2002:a05:6a00:298e:b0:84e:1a9d:d879 with SMTP id d2e1a72fcca58-84ed6ecedcfmr669687b3a.28.1785481534224;
        Fri, 31 Jul 2026 00:05:34 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm39233b3a.40.2026.07.31.00.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:05:33 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Fri, 31 Jul 2026 16:05:08 +0900
Message-ID: <20260731070509.1818665-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a link whose device has max_recv_sge == 1 there is no shared v2 receive
buffer, and smc_llc_save_add_link_rkeys() takes the v2 extension from 44
bytes past the start of the queue entry's inline message:

  ext = (struct smc_llc_msg_add_link_v2_ext *)(llc_msg + SMC_WR_TX_SIZE);

The entry is a 72-byte allocation and the extension starts at offset 68, so
ext->num_rkeys at offset 94 is already past it.  This happens on every
SMC-Rv2 link addition, whatever the peer sends:

  BUG: KASAN: slab-out-of-bounds in smc_llc_save_add_link_rkeys+0x333/0x350
  Read of size 2 at addr ffff8880056406de by task smctest/106
  Call Trace:
   smc_llc_save_add_link_rkeys+0x333/0x350
   smc_llc_cli_add_link+0xca7/0x1e80
   __smc_connect+0x3f5c/0x4980
   smc_connect+0x42c/0x580
   __sys_connect+0xfc/0x130
  Allocated by task 44:
   smc_llc_enqueue+0x72/0x560
   smc_wr_rx_tasklet_fn+0x474/0xa80
  The buggy address is located 22 bytes to the right of
   allocated 72-byte region [ffff888005640680, ffff8880056406c8)

Whatever that read finds then bounds the ext->rt[] loop, so a peer that
declares 255 rkeys reads much further.  smc_llc_rmt_delete_rkey() has the
same shape for llcv2->rkey[].

Bound both loops by the buffer they read from, and skip the extension
altogether when there is no shared v2 receive buffer, because nothing
beyond the 44 inline bytes was received in that case.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Measured over rxe with KASAN and max_recv_sge forced to 1, five test cells
(plain 1-rkey delete, delete declaring 255, plain ADD_LINK v2, ADD_LINK
declaring 255, and an SMC-Rv1 link group).  Without this patch four of the
five report; with it none do.  With kasan_multi_shot the unpatched kernel
reports 491 times in a single ADD_LINK run, the patched one not at all.

 net/smc/smc_llc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 90746cd1e29a..606d2dc8c7ec 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1000,13 +1000,22 @@ static void smc_llc_save_add_link_rkeys(struct smc_link *link,
 					struct smc_link *link_new,
 					u8 *llc_msg)
 {
+	const u32 rt_off = offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
 	struct smc_llc_msg_add_link_v2_ext *ext;
 	struct smc_link_group *lgr = link->lgr;
 	int max, i;
 
+	/* The extension follows the 44 bytes of the LLC message.  Without a
+	 * shared v2 receive buffer nothing beyond those 44 bytes was received,
+	 * so not even ext->num_rkeys is there to be read.
+	 */
+	if (!smc_link_shared_v2_rxbuf(link))
+		return;
 	ext = (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
 						     SMC_WR_TX_SIZE);
 	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
+	max = min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
+			      sizeof(ext->rt[0]));
 	down_write(&lgr->rmbs_lock);
 	for (i = 0; i < max; i++) {
 		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,
@@ -1813,17 +1822,27 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	link = qentry->link;
 
 	if (lgr->smc_version == SMC_V2) {
+		const u32 rkey_off =
+			offsetof(struct smc_llc_msg_delete_rkey_v2, rkey);
 		struct smc_llc_msg_delete_rkey_v2 *llcv2;
+		u32 buf_len;
 
 		if (smc_link_shared_v2_rxbuf(link)) {
 			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
 			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
+			buf_len = SMC_WR_BUF_V2_SIZE;
 		} else {
 			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)llc;
+			buf_len = sizeof(qentry->msg);
 		}
 		llcv2->num_inval_rkeys = 0;
 
 		max = min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
+		/* the rkeys live in the buffer llcv2 points at, and nothing
+		 * beyond it was received
+		 */
+		max = min_t(u32, max, (buf_len - rkey_off) /
+				      sizeof(llcv2->rkey[0]));
 		for (i = 0; i < max; i++) {
 			if (smc_rtoken_delete(link, llcv2->rkey[i]))
 				llcv2->num_inval_rkeys++;
-- 
2.43.0

