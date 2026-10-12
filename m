Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE773AF65C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783829; cv=none; b=eU1aKTifxMKfby2Ruor1HDUCLcdIVfrWiL6c6j+navkBL543/HMm8sktyW228r/xIUHgCgLEe92H9CWUTht74YKAfTqoJ7aRL8HOMXF8Bntbry3rTLMpzOHeQkoR8K8/yUu8AS7tp+1oDixShAD8St8crWFWpewlVaWLlmVClhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783829; c=relaxed/simple;
	bh=mLCMVbIggOYh5eoX77hLmcDhSE2spEx3Zw3hG8Tvkoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWRrRRJUp08bVh2Puq2mRsn2q/PtRYY1KGKVVb/00+aQeJ//1A3oqAscKuUboWE6gKTJkqptdiv6I9IEf///5CzVU7vstiWxQOUun5Nl3586gz4q2oT/v1irSxuPpN5s1/4aKi482SpomgRbxDtnvls1mCfoS6E7RsU6IDVRmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GqGp4ZM8; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GqGp4ZM8"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so294625a12.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791783827; x=1792388627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9teWJDYdRdzoEnukU/RejkAIu0GQPduV0KwkxT/T+Zg=;
        b=SJ/Yx2T+X7G/03+urlgrDVQ8aGFt2Jb9RyOdhA4ePPgHFZdpTwpJtRWBg6oMDROU6D
         qkASLorJj9NCeIiPyGiohbqZgWCBJgB4bTOrUX+a0T8MnnULcVt6FPsWPrsJI8crsv/t
         GSZ21HFAK+juFPh2wYY32ETlEZ5WmkTvlBAdpCHkwJDgD2bRmFjS4ZAxCnS7Y6BBm3X0
         SpNGgpHnotkiogntuIvOEEMxt60WfS5e93257qKv+ua2g9L2JqRsrsidTp8laHIhRLNZ
         0go/VRyfslcuve84KzDqm6LATrUbJs6g+gJR8Grr4ebRcppM4G70VP61uXGwJNUiM3iy
         RZhA==
X-Gm-Message-State: AFq9FYJ8KCLZEFCu2mpR5hHVaig/rWKxJ1RTPUS1z0U7o8Z/zQPi8Ir8
	IAITs7l3QGiH2l7+dmBnaOdy2efdhbSNVeyWGDfkRz5ij5G4S418+MuRkDzSDddg09uujfbskZ+
	uUZtBhZHaSTid3hyzJPmvVttIK0rLTliMJEEL9ZsmFji9KwJfLtIpHVEAv2jtzxsiHpBihKrw2v
	/154qQFdQHq62sOoqaX9xFxiirRG/NnWlzv1AbCAQNojlEDqZ5HYhUD7SAKs9PRNk0Z0/Ub1PC0
	tJlXZrXZQ==
X-Gm-Gg: AYBFou1blRHt7ZgCJYPqjTXI8z3DyhaYa9d1J5B808++iYLa7cb61v2ZV+mZL24Bk4/
	nc3ZJlwlW5TsO72qtj46nfteIevV/8JuUvswtsFMj7CsjRO5hN3M3SvRBlHfrcQmgfULy4ufx7F
	SHHJcB8lfJFvg997/wsCU1fVmyUKKEBYoFPUnWGA8psIFbwyX2UsE3aAnlnd7Gsc4UkJWEL0uYE
	ueQQ/E8pW2jHjvOuBZ2zMMkB6Z/T7CJ97uqhbpnjsgwMFTBxXtcbZ2skkngczMiKBID20qDK980
	xkHBbT81ATpksapYAjNjrrgpia1EPWUSBF0jlrWJVmxOl32WH+OaRBJ/thjLj32mj9e/CCDC1dU
	ioHexKzdnas3GTCY3UKsHs4rxHUMYCwSPFvpNX/bOLLYnZ6E050ZN1gueZg0M3bB+teg725roZU
	gHXuAleuiPJuUh0WtSfSORmEo6zcG2CahvxPep
X-Received: by 2002:a17:90b:53c6:b0:3ab:e588:c275 with SMTP id 98e67ed59e1d1-3abe588f863mr1578161a91.20.1791783827152;
        Sun, 11 Oct 2026 22:43:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36baf8a2sm5312963a91.1.2026.10.11.22.43.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2026 22:43:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd1e45a268cso599979a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791783825; x=1792388625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9teWJDYdRdzoEnukU/RejkAIu0GQPduV0KwkxT/T+Zg=;
        b=GqGp4ZM8IxeWfrecpKH/xehIjfMr+oLKwbzKK9xUsZ5LP2pITWc7TgJHNlv6nqdHln
         prf8FSJA8ARfFl9m5sdVunDb0Mb6fjWs9vRn4kLDLp8xbsE6vsSO8jJhgMwpTdE3d51d
         1gM88qj9qayKSUGs2nkXBNRmM5QUx4fFENzu8=
X-Received: by 2002:a17:90a:109:b0:3a8:2046:7e5f with SMTP id 98e67ed59e1d1-3ab3a747e69mr5117670a91.12.1791783825475;
        Sun, 11 Oct 2026 22:43:45 -0700 (PDT)
X-Received: by 2002:a17:90a:109:b0:3a8:2046:7e5f with SMTP id 98e67ed59e1d1-3ab3a747e69mr5117666a91.12.1791783825005;
        Sun, 11 Oct 2026 22:43:45 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm14615587a91.11.2026.10.11.22.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 22:43:44 -0700 (PDT)
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
Subject: [PATCH net 2/2] bnge: cap RSS contexts and RX rings to the RSS table size
Date: Mon, 12 Oct 2026 11:13:25 +0530
Message-ID: <20261012054325.1782819-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
References: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Dharmender Garg <dharmender.garg@broadcom.com>

bnge_cal_nr_rss_ctxs() has no upper bound. The VNIC holds at most
BNGE_RSS_TABLE_MAX_TBL (8) RSS contexts, in fw_rss_cos_lb_ctx[] and in
a 512-entry indirection table and DMA buffer. With 577 or more RX rings
the function returns more than 8, so bnge_setup_vnic() writes past
vnic->fw_rss_cos_lb_ctx[], bnge_set_dflt_rss_indir_tbl() and
bnge_fill_hw_rss_tbl() write past the indirection table and its DMA
buffer, and the pad computation in bnge_set_dflt_rss_indir_tbl() and
bnge_modify_rss() underflows into a huge memset().

Cap the number of contexts at BNGE_RSS_TABLE_MAX_TBL and the number of
RX rings at BNGE_MAX_RSS_TABLE_ENTRIES, so the sizes derived from the
ring count always fit the arrays.

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

