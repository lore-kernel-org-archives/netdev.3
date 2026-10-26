Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006897;
	b=ru3euSSwtHMLx6TWk7ZsSuGu1Klen9iPiiz3AVutnY4pgIzLsw1KvKbr11N9Tu+fyY6v
	 CB5MXoPZ94wOwLPkE4ttd4ldcjusUxtPcGpYZT5pVK1BFeX84vZbIrmjbcGrxIEpZnVTD
	 +jfcr7yeyib/pXTqX/Ape929dSC5lQ3uxsjungdRA2cAU2Bu12US1Oh0/HFV6yfYWiS05
	 oXoe3Ho4y/+ZkY3zdySa94qUSSv5nv7XDH/EeMw9/vwG+JpH1Lk5ncqEbp80gcK+hG4HI
	 hB0CfLHHi+NqmYYe0OkK1n2dFkX7r3TFT+dKUrFyFZZz7DgTrG0GfyMZhg9UAj9yvVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006897;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=rilc6HUjydimDhHnBpKE0cl6+BsSplovl/iWC5aCtQE=;
	b=20HtBo2SnU2Ns9IGJPYedG7e4uJ/d1XtrnEPMqADyqU9uurEQJx5vjYsvQ2rb5Fc/wxX
	 dpaaxU/Zyb/Vx65a6rqo1LTgbEE9/qkr7jADYsD/SANsbWkUJYn4uWWvsOh4L5ENCxqCy
	 Njm+boBkxhbMih661fJYfpH86Zj9ahB33yS342rpBqEKk7sCgulS096G043wQfMvM4vXO
	 jHCULuTrXsyG5v9uNIsw4LX6xuL03vyDuyDuhLPrqff/L/KyJn96vRbu3bt7w1UsPMJry
	 ixHLhMeg9OIF4j6h/Ybtbvdn127STw5ChxJhY45eXA5ckKBJ9WTddV0P9XDIGm+WJ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hbsUGgGA;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9414606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9414606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hbsUGgGA
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso852951a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006896; x=1793611696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rilc6HUjydimDhHnBpKE0cl6+BsSplovl/iWC5aCtQE=;
        b=F2YYkkpPmAHz+Ie1uW3Cw1wOTH7jVirfuAk9get9I0dxrRK4UOaI8CYB3CsLxQzVBV
         +RVeMHBYs971sPL74Nz0Ob3qHsPuiSpiJts8sDN8wQhxXOJpeafbePLpC1sumgFV44/Z
         GDqd8UCEZYkv+21UEvFpKgT1yZgmHurW58y/c/70SeC5bEn+zGYCzDgljVKmnvZdZcJI
         ot71NTwK1kxqBUM2Jv3Q3ThjWXLdZftGs/Ummsikm5QRk0mgoYzDlM+lIQdRppTyZVZe
         xoBy3GSSoiN9L+dBXDGPvY8s2faVg0WB+B280GLA3MA8P/DgK7o1u7zLj+ZjqIkm8ibj
         x0NA==
X-Gm-Message-State: AFq9FYLzJS+4EVvbL/tlbhW/DtlI2VBsoRpW1VgY5p2VbCPRsy0Syapp
	/BayRBQ9MOO3sYjIC8FYggoEyegi2nEId2E2Aw56ieWjmT+SiBbBrLSM+febNeCAtJwAUJ8zVFe
	OWBcYYxGrHiGGq1jGnn0cUpKAF1AkI9707LTAX3EW/GGHA0q0SQzTgbCEJXhYtCLQA7bEYSBJte
	5kCo7WNUnL8EV98CXVtuqbdllVQks4g6I5s0RB8VktxaGotHvGDGwB+CmHjz25KZ12WeVtCVKAF
	ju+vYfZTQ==
X-Gm-Gg: AYBFou2+ZWVYQ2ycrvxXS05ukSjFC0neerwNmiteZqyBqnl/CNJOThOx4C18ikTgmFf
	lWyPShNj0qf83pYHkjBURw3SF4EKE1ofTLn9J/5iuvhZgWY1np5BojRTdGuI4fuvDqFShFrgqG5
	BSfrq1RSbjwg+vV67my6ldH0Ap2vX7ZZ37drN/XfFefkVtjnKlKdFveASC78nFp0mxzotjxquYi
	wRs6FpXCcMLqVvloYR+JddWtXbfhVQOHNBS2j4qD5VQIdinFXhF/02p6oAdGE1WyvSUTDS7dJVH
	54CTQuZ6li+tRdQnVJl3dwlfXWTfrFJd+3mA1ou6crW784zBy5hZpmzppSTjIerC2/U1m6tBa/I
	L3za2zZebiAGFj/fl5hgXPehH+sDC/vTa+HGvUtLHQvfknzxJx1VgIbYmYJygyizW7mS9xOdwYF
	oJNV29DwYJ2R/H/EIMhXcfDxTZVEaqn1jG1g==
X-Received: by 2002:a17:90b:4a84:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3adeb15557amr5336281a91.67.1793006895970;
        Mon, 26 Oct 2026 02:28:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeba1bd56sm6048390a91.2.2026.10.26.02.28.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:28:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso4883061eec.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793006894; x=1793611694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rilc6HUjydimDhHnBpKE0cl6+BsSplovl/iWC5aCtQE=;
        b=hbsUGgGA3ZljkDwooOxvXgOVp6GeHcrACI+SQPsYJsCMaTi/cBXxQD7RLrkk3UgwNu
         ItNev6DVi9HFxsKamxXXMgCBpq6KNyahnGwnp2EmxxcZUUxPJ6bnOg3tJ9pxzbBiBRGw
         dhc37QDpKl7iYVQEVQcNtidcDMSYz4OFRy3cY=
X-Received: by 2002:a05:693c:41d7:10b0:36a:433:9ef0 with SMTP id 5a478bee46e88-36a04339f31mr1944766eec.14.1793006894004;
        Mon, 26 Oct 2026 02:28:14 -0700 (PDT)
X-Received: by 2002:a05:693c:41d7:10b0:36a:433:9ef0 with SMTP id 5a478bee46e88-36a04339f31mr1944734eec.14.1793006893249;
        Mon, 26 Oct 2026 02:28:13 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm16711294eec.7.2026.10.26.02.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:28:12 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v3 1/2] bnge: cap RSS contexts and RX rings to the RSS table size
Date: Mon, 26 Oct 2026 14:57:56 +0530
Message-ID: <20261026092757.9168-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261026092757.9168-1-vikas.gupta@broadcom.com>
References: <20261026092757.9168-1-vikas.gupta@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Dharmender Garg <dharmender.garg@broadcom.com>

The hardware supports at most BNGE_RSS_TABLE_MAX_TBL (8) RSS contexts.
They are stored in vnic->fw_rss_cos_lb_ctx[8] and back a 512-entry
(BNGE_MAX_RSS_TABLE_ENTRIES) indirection table and DMA buffer, so at
most 512 RX rings can be served by RSS.

bnge_cal_nr_rss_ctxs() has no upper bound, so with more RX rings it
returns more than 8 contexts: bnge_setup_vnic() writes past
fw_rss_cos_lb_ctx[], bnge_set_dflt_rss_indir_tbl() and
bnge_fill_hw_rss_tbl() write past the indirection table and its DMA
buffer, and the pad computation in bnge_set_dflt_rss_indir_tbl()
underflows into a huge memset().

Cap the number of contexts at BNGE_RSS_TABLE_MAX_TBL and the number
of RX rings at BNGE_MAX_RSS_TABLE_ENTRIES, so the sizes derived from
the ring count always fit the arrays.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 4711dd4945ff..b540eed12fc6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -182,8 +182,9 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
 	if (!rx_rings)
 		return 0;
 
-	return bnge_adjust_pow_two(rx_rings - 1,
-				   BNGE_RSS_TABLE_ENTRIES);
+	return min_t(int, bnge_adjust_pow_two(rx_rings - 1,
+					      BNGE_RSS_TABLE_ENTRIES),
+		     BNGE_RSS_TABLE_MAX_TBL);
 }
 
 static u16 bnge_rss_ctxs_in_use(struct bnge_dev *bd,
@@ -459,6 +460,7 @@ static void _bnge_get_max_rings(struct bnge_dev *bd, u16 *max_rx,
 	}
 
 	*max_rx = min_t(int, *max_rx, max_ring_grps);
+	*max_rx = min_t(int, *max_rx, BNGE_MAX_RSS_TABLE_ENTRIES);
 }
 
 static int bnge_get_max_rings(struct bnge_dev *bd, u16 *max_rx,
-- 
2.52.0

