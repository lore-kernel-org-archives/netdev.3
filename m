Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7308551985
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924333; cv=none; b=rQIk/bNfrM/b7MhxbDUsSjKZUAbpBLc1U6XDKKAoAWYVWtVzUZejgCL2wJFjq+Nq2TpGoOB2DH2WDDK0kMpuPI2y3hqIM9MI42sqH1jxglfz4uJ2VHiR98O//PyqV/xpA6cCVLfYFTutO0Kt5oHoT2ntHa7SvYnoSkZlAiX0rOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924333; c=relaxed/simple;
	bh=+1K4HSp6pmkiyvbf8tMwek+cg4bb7uAnoYbeytWGhB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbbi6hxoYS8wz24otMC/MgZRot4RragNT1ZwPiXfr5Sp4f+qngEDR3su++RYPFMlbqznHWHmKHuLEssug2kYYv3mmrb1w8JzLmiMd44Dq6UzipcOeCfH5a51Ut48KwH7Xg2/pfd0DpRytm0sTHmShz9ckkTi5sfQJUoMspRxDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uj1GCdnG; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uj1GCdnG"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so104310a91.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924331; x=1792529131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkGR/Azw8eHXBpqAVq4rJc9RgjV7wncIp3Qnhd9zmto=;
        b=JPsIeLXu8Hjl2JGbyAN84aPYM6uUrKrDTcZw+FQsi6d+JnuQelOKc67C4PlCRaQX6Z
         NGDvtvspX+mpPzvy1vsFGDwXlqESdiofMjFVjBwPonkEaCDUtnU93ngDTBWnDODIqg/o
         Qc7uI9Nvbs3de1lRh+BMNePmMtsxkPb4qiht5RY+Hsp9KOodKdmsRY0TV5BjASrJI6IO
         fonO0OvGv8vwQs+OBnsWgYdPsWJP89j1QlKf6owAcD3CHAUtFi0fkPx6uLzP9pB4GCyd
         O6V8OsokZE96g+stBQGUvizibKZ3TxNbpIsmaLa02iont/lAXNNByAaMBjj51A3MQWwW
         uQ8g==
X-Gm-Message-State: AFq9FYItAj5CgHGeaph2+PyaoV50HbToc4KTJQFSzOUOOxpR4/1CiF2r
	srdsZh8jvrKJOqyTgbwOpS+enD4ydXEBHt7gSszMg/Onj2EjInV17FFEtauUa49PsS+/5q6l7nG
	0IH0jppFNs4K7A6dj8k7NL4RhK2ajFaYoIP9Bm4iON3nslLvHNjKQrIwHXMUte9XTzUtO6LZmXN
	cNwwG2bvSTsX0D1IpCfKy7kWz4e2fjdwQxJD3B27gOOVcHw6BS8J/ynGOZC9cZTR/CiNjqUC9sB
	aNgAVgCR6TILLPK
X-Gm-Gg: AYBFou24K9JH5/Zl8RzYMf3KR1AoCQsD71a5MlGLIQUQnbYY5wGA8bxIGHXpD9oDFU/
	E6mJClRMrGAWM/Xtu8Ei9GBgo9zu+HnIBysQ9KmzyR/JNZpoJtsLFoT9i/yMKmDX495heMrYuZJ
	kUasRcWnSE7N26Ns5PJuZnntbbnH48JC5H0o86EhDSI7AgrS3fgVxywD0vsgBXz5u8Or5EO/wfi
	FmtD3khE9hXCO5Rb9uqf8AYMH8q4btDFV8p2d2mMKj5fbZhadEH6W+GifUKnS8dSAu8z/TTyrtU
	IY90WhNL6HPaPobusCS+ulAUQfGUGF+N4ruxFBWQH7XpuvCXxwZ9OdVYt3Vd0Mxp1c7Q6uI8Ewd
	3O2E0rZYnxl63KaAKUQKHYel6wUTMdSi6wNuUX02JsyS7o4dQzJRpLIwbHwbIp2+HkTwrDtHkMU
	dLKCxB4uMzZUaNG9t+8JtYOO3gyIdBF1lNVUlkhYhtMjk=
X-Received: by 2002:a17:90b:562c:b0:3ab:1285:dfd6 with SMTP id 98e67ed59e1d1-3ab3ac6c99dmr12454720a91.38.1791924330884;
        Tue, 13 Oct 2026 13:45:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac5f3d0b15sm374985a91.1.2026.10.13.13.45.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:45:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5352436cd78so34334181cf.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791924329; x=1792529129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkGR/Azw8eHXBpqAVq4rJc9RgjV7wncIp3Qnhd9zmto=;
        b=Uj1GCdnGqu73PgZ3u/rY1h3lxAETBtxYTZa5giSnyIKcfcQ9NffYoudLiiTckzNgko
         3VCn8e3/iJBu/B6VIT7QfbQpv5PXHmoUngrcoOeTBDagOMZU7lH8Xbs3YVx32AtCxW2A
         q2OKzgWw8j11P0tpV10BVzKBKztaGXQrW0GnI=
X-Received: by 2002:a05:622a:1c15:b0:535:d7e:dc4 with SMTP id d75a77b69052e-5359fa908d7mr215397901cf.19.1791924329226;
        Tue, 13 Oct 2026 13:45:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1c15:b0:535:d7e:dc4 with SMTP id d75a77b69052e-5359fa908d7mr215397281cf.19.1791924328474;
        Tue, 13 Oct 2026 13:45:28 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535f4eee7bcsm15879231cf.30.2026.10.13.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:45:27 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 RESEND 1/6] net: bcmasp: fix mib counters struct alignment with ethtool stats
Date: Tue, 13 Oct 2026 13:44:34 -0700
Message-Id: <20261013204439.3494046-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When EDPKT stats were removed in commit e9f31435ee7d ("net: bcmasp: Add
support for asp-v3.0"), the corresponding entries were removed from
bcmasp_gstrings_stats in bcmasp_ethtool.c, but the edpkt_* fields were
left at the beginning of struct bcmasp_mib_counters in bcmasp.h.

Because bcmasp_update_mib_counters() and bcmasp_get_ethtool_stats() index
into struct bcmasp_mib_counters sequentially based on the order of
bcmasp_gstrings_stats, this 16-byte offset caused ethtool to read from
shifted offsets: the first four software counters read unused fields and
reported 0, the next four software counters reported the values of
alloc_rx_skb_failed, tx_dma_failed, mc_filters_full_cnt, and
uc_filters_full_cnt, while filters_combine_cnt, promisc_filters_cnt,
tx_realloc_offload_failed, and tx_timeout_cnt were never reported.

Remove the obsolete edpkt_* fields from struct bcmasp_mib_counters so
that it aligns with bcmasp_gstrings_stats.

Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 8c8ffaeadc79..9c9721da1662 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -250,10 +250,6 @@ struct bcmasp_intf_stats64 {
 };
 
 struct bcmasp_mib_counters {
-	u32	edpkt_ts;
-	u32	edpkt_rx_pkt_cnt;
-	u32	edpkt_hdr_ext_cnt;
-	u32	edpkt_hdr_out_cnt;
 	u32	umac_frm_cnt;
 	u32	fb_frm_cnt;
 	u32	fb_rx_fifo_depth;
-- 
2.34.1

