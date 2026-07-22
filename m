Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66C361977
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735505; cv=none; b=rUssb6qQRYhRn+EaCrmahMRK0g7ISL8sgCmTSnlpVflhFG0O0vGN4yPBdzVi2jrfmgbtaZieWh53DxiZpP0H7fisF51qBRoer1iAUjL7Wb51hjpQnviGQER01IvDRaroFVSdeOknV4IqFm75Fz8KbItOpujqA2XIMXRWNR/jvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735505; c=relaxed/simple;
	bh=gPrUQdO25OwByqCIyJlEUK/ELw4zeJKA7HgCL0t4JFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKCnMF4vzi8Y0yM1XOJ+XvHkE2ehPHuFEnqOf7whUplVBoPJjuTwPRGHP/m6/l0snpSApsUfx+gj2WiNU094Ozwo5cKKtf2vSuIH7azhizVHaGag3mmiqdHCblL/6q4pQNsL2fmL4031WJSMBS83FlbBtdxMR/nVadeZXQE4iEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+ei2Sb/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+ei2Sb/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so12974127b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784735503; x=1785340303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vWgKUErhnh3LH7sgMXLGxx8WVFuBhCCZ3IuRApi8yg=;
        b=F+ei2Sb/CXoI3UnlCtNMuM1h0lpKRg0UoQWh7g6lFQFhHQnmxFwY8BVRq0AgFSr3ZM
         kULnRyydxMOCtMRf3C6yr21yAyDX/rJqBu1EKlbnbwj9j+jpxMVi2gMhAaOy2yVJszKT
         2Cy3EuGjGrJtylGY6YV6feiPkxPYxQIHwGtEf+eCyl8PkR02uBOS7DnB/7y/6/6Ikurj
         ZCSV51y4j0dyHLUErzClIE2l1fkrFJGRaeSfMlZOJyFQK2yoP853B4Y18fRttyOnKw5g
         HszfLzjPFZc13NhdFykr80rB58GNEYgobveqIcGgUIWQ+fqCfuKS6JMctyaCbbvbhvVU
         rgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735503; x=1785340303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vWgKUErhnh3LH7sgMXLGxx8WVFuBhCCZ3IuRApi8yg=;
        b=jH+keBGcWplfkh3oSayPdejQDhA0Xz6DoepgXKNpIyvY2GpIhBrmJvugAX8pm8V6MY
         qNMU6Yg9zOujuNxJP+i46gDmJ9ZFN29wUg4j6cY3BrLWp4V9KXMeryKAyGwxHiowwrlk
         nAPjD7Qmlw7zrsOE6xJpAr2Z+WEZgWd4dnBxXJpP1p82JTNhkFA3BHqMdsOS2fQqF11I
         rZs1NqaDBrmpaHqegdL+JsOcXVI4j24iB0Wg8URXvso0cN2p5ueUMxNtSPAozsgGuRd/
         7hl8VssLXl/cgZRLJFpVditY5aCGEXN2UOUkdbQXpku0ymwxh7Z35oyMtT6JX/MsXnpE
         vM8w==
X-Forwarded-Encrypted: i=1; AHgh+RqlGjD//1hoCeJ15feFI+J+YSqNslbhLWoqb6uVra/5fv1Ec9cacfPLHq0f1SR4kbALxWFGuRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjrn8BVH9iKZTAHck/yvci8pfkwh8i57/wZULzpVkzJAaX2j5
	G9hb4sr8zkf3rVzCaNTlyl3NxV6/nXIJcTp18mIEoIo0H6MHf4JMwyw9DRQqlShkUAQ=
X-Gm-Gg: AR+sD11R0rw40NTiu/G2ofN0ROGxaIt3J0x/Tlq1Yz5wWG3ix6aBrjZXMHm+4PMVtru
	CGMrFS/86reBnw5KyC9zu14n04xA6sjtgNOcUGF4+BYY9M2MGNdASvCQWdZqUfAKQW1KDL+BC08
	YmEOR1qdAfuC10TUtx1bbsNjrG2zKt6zSdnYvkGzjfMi+y48KguDV71t1aixeZmEew+sJB8JFP7
	G8tp11HiPM7wRKZFAC0ybENta8MY5WHB+u3FlKJAXGfEkGfqz2bBcz86pKGEadE5UxAQOk+wFn1
	308fOt60dkURjNmz/n7UngBJpbYjuvCgjY0bhP82Tw8uWUIo0+5A4/h33VVUlKK6XKZpye8iiuc
	aiMF7vHkztKyWyOH8MlWruKh4UEjvAjv6XTvXVYBSaVHORekGQowcyl08LexefFp8+R31l1P+Lo
	pxdNsa9ONAKkOZzHcqBDkGSREHPtc=
X-Received: by 2002:a05:6a21:478c:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c3ad66b538mr26308040637.5.1784735502943;
        Wed, 22 Jul 2026 08:51:42 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm11123125eec.17.2026.07.22.08.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:51:42 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 1/4] octeon_ep: free the dropped RX buffer pages
Date: Wed, 22 Jul 2026 23:51:28 +0800
Message-Id: <20260722155131.2017597-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

octep_oq_drop_rx() drains a dropped multi-buffer RX packet but never
frees its pages. It unmaps each fragment descriptor and leaves the page
behind. It also reuses the head buff_info for every fragment.
octep_oq_next_pkt() then clears the head slot again instead of the
fragment slot. The fragment slots keep their page pointers. A later ring
teardown unmaps those descriptors a second time. The build_skb() failure
path frees no page either. The head page leaks too.

octep_oq_drop_rx() now indexes each fragment slot. It unmaps the slot and
frees its page. The unmap stays before the free to keep the DMA API
contract. The build_skb() failure path frees the head page.

buff_info->len comes from the device and is not bounded. The drain length
derives from it. A bad length could run the loop past the ring. It would
then free live pages of other packets. The loop now stops after
MAX_SKB_FRAGS fragments. A valid packet never holds more.

Fixes: eb592008f79b ("octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index e6ebc7e44a..b0162fb9d9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -388,9 +388,15 @@ static void octep_oq_drop_rx(struct octep_oq *oq,
 			     u32 *read_idx, u32 *desc_used)
 {
 	int data_len = buff_info->len - oq->max_single_buffer_size;
+	int i;
+
+	for (i = 0; i < MAX_SKB_FRAGS && data_len > 0; i++) {
+		struct page *page;
 
-	while (data_len > 0) {
+		buff_info = (struct octep_rx_buffer *)&oq->buff_info[*read_idx];
+		page = buff_info->page;
 		octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
+		put_page(page);
 		data_len -= oq->buffer_size;
 	}
 }
@@ -457,6 +463,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
 					 &read_idx, &desc_used);
+			put_page(virt_to_page(resp_hw));
 			oq->stats->alloc_failures++;
 			continue;
 		}
-- 
2.34.1

