Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4C3E8337
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918415; cv=none; b=B37n23Twbo2i36UH3YLyDs0RxYlyxp94YTLteVY0gs7KxNKNq10Tfv6uufIgdfj+zDXmK403Ck63RSbG2T7PwLMhWD5Wxae3/RjcwCYyTfT6KQ2OGqvu8w6tchg1OtOZJsSZFMfhI9CHfqTYdPGzeF2M+3fA1FiSlaJzZtMP1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918415; c=relaxed/simple;
	bh=H2ueGBpKNnuryYzHaXv8zqEJaPP0wOpOcMhcerSG1BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haxEumDyNLZmtuGxim/MpLeBIhYp1fvfKeiz+sW4U0JAbHvuPfHso44my66gb9aPIoBXy62niJ9hifwjGRU646BqU79kDdy21biJrC1Nm2nnu8pQBWeSrCQX5HJRIIHvkQYoxOboCLAXS821h3B79B49iN6Lk8fb2EYXnKRoXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9CZ1cKF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9CZ1cKF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so738241a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785918413; x=1786523213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYomsqlGTKbFGFVO2mSphr/IfNChhNad8g6UC8Dwxng=;
        b=l9CZ1cKFlMWrGi4bdAd2EMaijRAs8bhvSDd14sov4cGucuvaAE/mHtXWWmOuU5xf6g
         Cpa/SmUYs6bitZhL95iQGrIR+7TvlIveCO/sc47ShDa1eqV99AmqqRom7FOWgrTUk+Qa
         XHk005GREdZBcGTyTC4B1T8XkINrRFcq3qbJTK+Hq+e8RUVeD2fuja7AE521vgEQ/xxE
         RB5ITqipLD0WqFfc/7fEhi8H8Fh5rRejaW/PLd22OgmxHBacqLTXM7ooMI5ePCwH8Hxj
         21h4XMwk5c9IKE7X4S+yR0MKWuc2nZV8nBAYKUxVgjPgUqW4PcRXto3vMNIYvpWGOe25
         evwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918413; x=1786523213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYomsqlGTKbFGFVO2mSphr/IfNChhNad8g6UC8Dwxng=;
        b=oL9u2ROUwf4SlX69TnsoEqhK2pizcCTDyr6zp/8x+xhxwGoX+/+X6K0fkPbwJkRkyd
         qivmXI+BVPpKf6NL3Y60oD32jUyLBI8m1uwg23c+4ovOouXXGKAOBEOKjGM2gV/uvWVs
         ASJg06bTz1gFjsreuGZSLoX78g7aLlPAbe8CFNzz5hBKzx/JqEk+u0HsibYOwJBvFxib
         c4WHZnMabl3vwP2KPcf+kSlvBWFiWuGOi4Z8ic8j5wsf3AHPqH8yALHTCkq1CizTetyp
         J0bv7N90zEVaWuyixR1JipNTH2NuIdFjzbgYXSv+eecT1fGD/EUSKjPXPmsLc7QAXXtu
         cPdA==
X-Forwarded-Encrypted: i=1; AHgh+Ror8LZzzjjY42O6QDiM3nUh0AEzEw4A7wOX0MDVgy1Qg0XXOomoJyAbSBy3sp4VzKJP2qOJbKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SC0J2HehRlb4b0HPT81SURHv/JWp2P5eI6YfFJ6dKNEzeIpd
	oFk7rvEhbvC6X7svCly9gUiYOEYmuq0eZYVF+UNEAuyPwKIZJFtsvIBG
X-Gm-Gg: AR+sD12j4R6CTGwg7qAuN/1gJRJaEU/lnSQEJnHyPLoRDueZLXDB92ljsTOGHbV2oVt
	uMUkuzaVh2KzxMH+e0kAC8+S6GUXAeckAh7/zczZIidP4Qo5rBNJPdL4uJyn9b4c1G2db6+F7g7
	CFhQY4zE+G1K7x/980oNMQTvxcJ6IHcdGfWVgiJ2+Ay7PfqtLLuOJfd2cD/6l0hochimCcNI3RW
	m7DmcivjeIqU4ijccVqD+PlN3FW+VUEP1QGkpt8vNwgXm147cWLvn2n3JSSAG1eQAihe+cmRmqq
	GFXUTAier2bA0u0O1HwBSsID+3h1yZIddIvf46xGrwe2V2BMyPHwmO6Z8Ukj3M5HHxHtDCvVblx
	5URM0XF7rS5FD+HGcyqzZc1tJuYhHK6GxQNgBr1o0DvSBaXU6Tfd8dMP3U9zWYQH6RIRaKzYxzd
	d0tAVkwjrdD/x0DbyuW5iZaLdQa7WqI7Om0pMupnR1+8OJiBPt0TRWmzu3XhHfLoBRhNjjmt5D
X-Received: by 2002:a17:90a:ec8e:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-3903c53827bmr5571839a91.2.1785918412732;
        Wed, 05 Aug 2026 01:26:52 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f5fdfe5sm1263278a91.4.2026.08.05.01.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:26:52 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH 2/2] wifi: iwlwifi: mld: Fix GP2 to nanoseconds overflow on 32-bit
Date: Wed,  5 Aug 2026 16:25:15 +0800
Message-ID: <20260805082515.4136842-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805082515.4136842-1-zhanxusheng@xiaomi.com>
References: <20260805082515.4136842-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GP2 is a free-running 32-bit microsecond hardware counter. The PTP code
converts a u32 GP2 value to nanoseconds as:

	gp2 * NSEC_PER_USEC

NSEC_PER_USEC is a plain 'long' (1000L), so on 32-bit builds this
multiplication is evaluated in 32-bit arithmetic and overflows once the
GP2 value exceeds ~4.29 million microseconds (~4.3 s). GP2 wraps only
every 2^32 microseconds (~71.5 min), so the product is truncated for
almost the entire counter range, producing bogus PTP timestamps.

Neighbouring conversions already cast to u64 first (e.g.
(u64)gp2 * NSEC_PER_USEC); these sites just missed the cast. Cast to u64
so the multiplication is performed in 64-bit, matching the existing call
sites. 64-bit builds are unaffected.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Fixes: f1699ad5857d ("wifi: iwlwifi: mld: add debugfs for using ptp clock time for monitor interface")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/rx.c  | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 1ac85d6ce1d7..81645f8caa54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -59,7 +59,7 @@ static void iwl_mld_ptp_update_new_read(struct iwl_mld *mld, u32 gp2)
 u64 iwl_mld_ptp_get_adj_time(struct iwl_mld *mld, u64 base_time_ns)
 {
 	struct ptp_data *data = &mld->ptp_data;
-	u64 scale_time_gp2_ns = mld->ptp_data.scale_update_gp2 * NSEC_PER_USEC;
+	u64 scale_time_gp2_ns = (u64)mld->ptp_data.scale_update_gp2 * NSEC_PER_USEC;
 	u64 res;
 	u64 diff;
 	s64 scaled_diff;
@@ -159,7 +159,7 @@ static int iwl_mld_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 
 	spin_lock_bh(&data->lock);
 	data->scale_update_adj_time_ns =
-		iwl_mld_ptp_get_adj_time(mld, gp2 * NSEC_PER_USEC);
+		iwl_mld_ptp_get_adj_time(mld, (u64)gp2 * NSEC_PER_USEC);
 	data->scale_update_gp2 = gp2;
 
 	/* scale_update_adj_time_ns now relects the configured delta, the
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 269439d789f4..108ac70bfb14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1524,10 +1524,8 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
 		iwl_mld_add_rtap_sniffer_config(mld, skb);
 
 		if (mld->monitor.ptp_time) {
-			u64 adj_time =
-				iwl_mld_ptp_get_adj_time(mld,
-							 phy_data->gp2_on_air_rise *
-							 NSEC_PER_USEC);
+			u64 gp2_ns = (u64)phy_data->gp2_on_air_rise * NSEC_PER_USEC;
+			u64 adj_time = iwl_mld_ptp_get_adj_time(mld, gp2_ns);
 
 			rx_status->mactime = div64_u64(adj_time, NSEC_PER_USEC);
 			rx_status->flag |= RX_FLAG_MACTIME_IS_RTAP_TS64;
-- 
2.43.0

