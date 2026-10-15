Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312203BCD37
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066747; cv=none; b=S8KdARBSJDb/QzBXhl8LWmErcpDcZST3R8Fp+djLW7EkehD1JkQx5Dro/dGVodCGj5Hf+BdAFdd6SkNaEg6/AGjG5XOVjh7wIkz1nNjETHBloAdVtco4hR5p3oiSkxOByr/eaKMTg4n4IPXd9/0CtyO1CwSjf/HfKcpLzwIpx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066747; c=relaxed/simple;
	bh=USxceNv93mvO+qYyxsutIULkz6xx7E7suaD9GJik7LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puDXZ09Wy7hJ4+yvoKHb39EHvRUNo7zqC5wlSZxH0CigmIDgjrn2yKXjBJnREPwhCjtSukYeKNi0ZWj1CSXz0q0Rz73XOzVpyDJx7GmZCneulxUyu/kzyrf2UjGqzq7de5UWCyWaskjUDWSnjKVzU4KqontQan+lNPFyF+xacFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AYmBolax; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AYmBolax"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-91b52ba422cso57049166d6.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066745; x=1792671545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rxq3hfUR8X6WLnz0/5e9y66/fCs1i78EHHGa1XswQAY=;
        b=nJMFwpar8X4K/aVGFvfLOOy1q87XEXZ3ooeZ/QjZUKLcnNCYPd0KcSUyv3rZz5nemx
         CH+szngjorlzLnkDugGIBwPjjv3l9VinnzDcNLybDYWcTZmSPXYhTcW+cXD+vhnaI+dg
         dDI9GGKJqEuAjpbo/3Pmt1th7D5TF85LKjfWXDG3PplUVaxdEUya22qLXnbkqoEi4qhT
         50FtIEYndPG4KkIK/inNMzOwUimws/e0vw3CTZVD1aJSCcnc3y40+gsnMYUp8zYiexrj
         dClVhqXGDbk5tiZbbaSbQzPtIjcI1rzGImoIOPgRsm5Zwyr4Buk8zxUn7/8+NyFwWt5c
         XZhg==
X-Gm-Message-State: AFq9FYIvaPLgNIRM/Mq7Iv/b2SZqZBI/Bv6c4ZkrdFpoha/JdKwtvwNW
	yymZPIWwP2I2tkZTOWYlPSqblnIIwKNQHu0BjQHQBFj9/k1czzy34XrHbbCOL1Cq3+q9pwE4snS
	zCusoD+lrqSkgpT8wl3pepiTEkyoh1ZBlii4dLAZdDKf56MOjiIp3hx9s+Tk8koRrsMFQYAAME9
	1wPxW9E0E3RcO0TxzG3vFmLGI2P25YJjeDFBUP3Q2U9MBm1CAq7PXYwt4W5sYlziE10WIe41iup
	c5i3NE/Ng==
X-Gm-Gg: AYBFou06nfJ0NAwzL9c4dBZlwvyqixXQQEVxrcxsG6MC4bfMdcnN0KAoAIpzELs85dp
	IGmzuQasFveVUyeSKD67hl37covWAPBzEBfo8GbOQN7SMgq7ucbZ6wguqK1P/nA+h7fNQAJL2cK
	cuDgExVXF+c+MUUqu5r5zJPPvTgyJvpKfz30nE1OUcn46C7vpNujocEHJvm7IQyszdWKTHNyNGt
	AeHt+50Ee22Nk279WcEs/jhzsZ/0IPALICZynvAHkTW/bGdufIzD+JjzvKcwTn3MApxxUWhstY5
	EPV3ofe6jE/byc197TwnCaNKhyzxVVGzog0WpGEIyHZmdG5nzBz/fHoHv3loThFdjjnXcfkNuQh
	/gBHRo5vUFd00HJ2SU9StizGVpvTQplGSk3I7tOHVCti65AevjXV6dP4/wKr5ubBWgeKsRCgP9g
	uWO9/bX6o4i9FtnETXy+hMOQNpWAlE+Onh29BX
X-Received: by 2002:a05:6214:2e45:b0:91b:5d39:e13f with SMTP id 6a1803df08f44-91b5d39e9a0mr309281106d6.52.1792066744407;
        Thu, 15 Oct 2026 05:19:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91b97b1080dsm617186d6.8.2026.10.15.05.19.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:19:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso8228590eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792066743; x=1792671543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rxq3hfUR8X6WLnz0/5e9y66/fCs1i78EHHGa1XswQAY=;
        b=AYmBolaxe/87sCZDDd8Dd+5/RQzjX9p8DESwWTWh8W3Fl87h/qdLekqhu/LxBwVZ8K
         h10cSjSPkpLh+H3f8YEIBNgXUSAaI548Ugok7KUnroRmZcM6N8E05pardllgGo0e7hos
         Ja+9rABMpTupCbP+68YyxQbYKIFtPbdYLSczg=
X-Received: by 2002:a05:693c:26c1:b0:351:7e5d:2de9 with SMTP id 5a478bee46e88-3537ddd6142mr23491568eec.1.1792066742977;
        Thu, 15 Oct 2026 05:19:02 -0700 (PDT)
X-Received: by 2002:a05:693c:26c1:b0:351:7e5d:2de9 with SMTP id 5a478bee46e88-3537ddd6142mr23491537eec.1.1792066742277;
        Thu, 15 Oct 2026 05:19:02 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm64496032eec.26.2026.10.15.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:19:01 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] bnge: cap RSS contexts and RX rings to the RSS table size
Date: Thu, 15 Oct 2026 17:48:46 +0530
Message-ID: <20261015121847.1933308-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
References: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Dharmender Garg <dharmender.garg@broadcom.com>

The hardware supports at most BNGE_RSS_TABLE_MAX_TBL (8) RSS contexts.
They are stored in vnic->fw_rss_cos_lb_ctx[8] and back a 512-entry
(BNGE_MAX_RSS_TABLE_ENTRIES) indirection table and DMA buffer, so at most
512 RX rings can be served by RSS.

bnge_cal_nr_rss_ctxs() has no upper bound, so with more RX rings it
returns more than 8 contexts: bnge_setup_vnic() writes past
fw_rss_cos_lb_ctx[], bnge_set_dflt_rss_indir_tbl() and
bnge_fill_hw_rss_tbl() write past the indirection table and its DMA
buffer, and the pad computation in bnge_set_dflt_rss_indir_tbl()
underflows into a huge memset().

Cap the number of contexts at BNGE_RSS_TABLE_MAX_TBL and the number of RX
rings at BNGE_MAX_RSS_TABLE_ENTRIES, so the sizes derived from the ring
count always fit the arrays.

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

