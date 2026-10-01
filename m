Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B0383339
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830884; cv=none; b=SY16PcVkQbcVQujdpoMoJXrg0FSH3c1Wogc63FV3JRqwqSvFU3qYuQMM3oZXUMTDLUxi/1TBAk9ABDeTODQUDwk8t1T4Bn7qPlJhU55KSqp98IXhwau7NyJOuqkLooPAQUBNe01ZCZD+wQLOmPclvnzb4hoGomsnnxsP1M0nUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830884; c=relaxed/simple;
	bh=LB1sY84a1EE+3kSSw4xtbjuyLg1kQRZO7UTUKIYXGMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9O0Kj0W9myFJqNWHV98Elxxyp+MbN09MhP5tfGtzGeZ7UJvKmvV8W28rQHc13mAiOjCQsk8j60xVQw/o2bJBzL38NMi16GDcfaTQKZP1ZITB15fGjoNYBRe3NeuoJWMH7oduBCdhe1nqup4Z18Xg3d/5l11ZWy4OIPsynhSbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoVc71j2; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoVc71j2"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd77300825so32630735ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790830880; x=1791435680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTxV+1nEYr5jusQwn3L4od+0vUpR+87EIFrgdrNzUZg=;
        b=RoVc71j2mX+Q5evTGwASdtomsgJFX6LyGmM0T8WH308T+798n9bW6H+F5yJjgM/gXN
         s/5kO4DupWobHRRjL3SK4OKOzs1ggBscJHC2lt5CdekZxFi5olhUZ2FALxuSYdbBlClM
         uu3KNedqaHFQJV70Tx1uo7QR2XZSCSsKVaS1vRQ6hhVzi2qjacsXY0tZrpFeRmWpxMoP
         1bnzbEWjfbKHlsDxpm7eiUVu8bkUhDamxGOkgtqUvFuiPZCVnT9712SXHZT/T+6eUjN9
         tO1uHrkk0ck98rAac5+h/UHTZGypfaFK8ryYSilbKKVitYBJg6JII0t46cMK+i9j4pFl
         wEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790830880; x=1791435680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTxV+1nEYr5jusQwn3L4od+0vUpR+87EIFrgdrNzUZg=;
        b=QGJyTOO5ZGmA2tr/+B7OP9zsmmXaQKM8cNIHEApxx7nQWyAQtYNBXksXqxrR/iE/WM
         CCWAlHZVoNBB3iGHj3ngVGEqkg2QqZmhzjvx/v7HHZyeB+g3NoyziVHLvlroTysFJpzs
         EsyV7ZgKu75xCP2KycblwQOTXX6np2hRNyhWdUPfaairNxRs7UrpczpEGL2q36aDyWJ9
         M6EurUeEMrGI6+B3Dhr/7Ja6RxscacLftHAZ0pOL+SpLr18oSavlcaU7ZwhpT/LB5cbe
         ZT/48S/fvPjDe8FkVbwNEa6ko7NzdiHPeM7Ub96RJP3IHdHjyvdIh5dizh9+qeOjHVQ6
         mVjQ==
X-Forwarded-Encrypted: i=1; AKwUvByQQKMvrat6st+ht0CS9gi9RfxCIVEeupsYmLRCa4FVXg8C4OBFMbf6JFjY6pEZklKmWhv0EEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKo7UOYH3lNijMHTSoRqXFwL1f6JKOCOwYoWEVvrMAOTMiCw6HJ
	cDEbKrIdMbrH2XNX8XjDTSby1Z+p2ogNVmOsEznPsULq/0IhesvK550JDzzGIw==
X-Gm-Gg: AYBFou0iHQ8bGWcuxa7vuhSwdnqDAO6HRZ67PkWQoSFwg5ZPh2FKyJRZU0L4UySIVMZ
	NqqbBv3+ocvNcHLIat7dZGYX4gaGVYfd9fw2eAlTf1k256xzVNDXneI5O9UTUsSFdqgRpsUKone
	uULR9VJ6HjKY5z96EOVeb2+jHT9zp+5VtbXyWdNCL/xA3yWQZ2FREMYkP94wWW5AY+oY6y7rw5e
	VA5YixXM+ZSZAGOTEkPLQ0itw2yriRLFmUmc9FDjgEfOB+y68+h9ldOTUK20tn1BW8oQ2R9Rlfy
	pgUptArLLIItvssApZJPk6bmUjd5lIq15dg/kiRh+yKL4CX1WI43giNho6ix7u231lh8RoyW7Jv
	4AGgn3kTXR5WB8BNh93l3xLuODh8axoqw8kl4I31wJ8j4FAy3MBLBqKTcJmEiGL1PBUXj09byPv
	nf7n956fRZ5SsKiFMCnO8BqWxD4yZsLuCM+1SDJm45g74y+CxglDu5RrSazq6DosSEOkLx8INLA
	cDnVXtPE3FIwbU+KcdGlA==
X-Received: by 2002:a17:902:ce8c:b0:2e2:cc25:b232 with SMTP id d9443c01a7336-2e2e4b75346mr29200155ad.42.1790830879917;
        Wed, 30 Sep 2026 22:01:19 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b21912sm5112085ad.54.2026.09.30.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:01:19 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2 2/2] wifi: iwlwifi: mld: Fix GP2 to nanoseconds overflow on 32-bit
Date: Thu,  1 Oct 2026 13:01:03 +0800
Message-ID: <20261001050103.860584-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001050103.860584-1-zhanxusheng@xiaomi.com>
References: <20261001050103.860584-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same problem as the mvm driver: scale_update_gp2 is a u32 GP2 timestamp
in microseconds and NSEC_PER_USEC is 1000L, so on 32-bit

	u64 scale_time_gp2_ns = mld->ptp_data.scale_update_gp2 * NSEC_PER_USEC;

truncates to 32 bits for any GP2 value above 4.295 s.

iwl_mld_ptp_gettime() and iwl_mld_ptp_get_crosstimestamp() in the same
file already cast to u64 before multiplying.  Do the same here.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 9f7d17dbdee1..643664d35772 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -49,7 +49,8 @@ static void iwl_mld_ptp_update_new_read(struct iwl_mld *mld, u32 gp2)
 u64 iwl_mld_ptp_get_adj_time(struct iwl_mld *mld, u64 base_time_ns)
 {
 	struct ptp_data *data = &mld->ptp_data;
-	u64 scale_time_gp2_ns = mld->ptp_data.scale_update_gp2 * NSEC_PER_USEC;
+	u64 scale_time_gp2_ns = (u64)mld->ptp_data.scale_update_gp2 *
+				NSEC_PER_USEC;
 	u64 res;
 	u64 diff;
 	s64 scaled_diff;
@@ -149,7 +150,7 @@ static int iwl_mld_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 
 	spin_lock_bh(&data->lock);
 	data->scale_update_adj_time_ns =
-		iwl_mld_ptp_get_adj_time(mld, gp2 * NSEC_PER_USEC);
+		iwl_mld_ptp_get_adj_time(mld, (u64)gp2 * NSEC_PER_USEC);
 	data->scale_update_gp2 = gp2;
 
 	/* scale_update_adj_time_ns now relects the configured delta, the
-- 
2.43.0

