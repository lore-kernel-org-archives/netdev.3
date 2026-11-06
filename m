Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959017;
	b=zt+vcOs2SGieqSvaOB4CpfnDEMe7ME79/NZCDBLskKvTAno9OEV7X6/AeqVvnMGoop0m
	 BLL39AosUKRJnrbSPYUCjnZr6yZ0dOhC5WFyu30YmpQfyHoHIj2iu6dgA416lr2W7nI1P
	 Hywcvi8LSl3G4DJMQW1xLbt2m3ZEUlwoBteppPN3ctcQIGpO2MIpj1q3NNU8n2XnVmhko
	 K+Ptejla2oh4LmIGMDkDd6jt57M3Ih9BSOmTdKun8WG8lBneuzSdZaw5qZOxMbGenebF+
	 MhmVeOMM1/KCvXC9L5HOY5+v/YfqkUWbemmbhzn/PGvP8llTlfRmLHCI+UtkZPnjhtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959017;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EshULAsB+qGkuxyBRGHV+fcTIV3hUxTmA5rU2C9/N6o=;
	b=YBaIuSYkT84PlWT3tz7pVa5rmLrnnKYXe9qlk+BEIhHQd4WklaUFYru0okGNMlIHGpSL
	 aZ6JXeEBGeUr3gXSw2ry+woRbGE4VcvsgZR3UCkT6J9GLJ13MmD7mNYhJBBI8KQLb6d2y
	 U0auv0G6kzSaoqcls8smTQTRkFTWJJKrDR4YvlybG9JX7GHHK3zIOPf7jHILqbOeEogUd
	 Oc1B+uRC8VduELD31e0eGEiCFkupOT9FtmNGqMVqeMmX2pqSqlZ13QtfrcT8fiklq2SIp
	 JE7uaxD+RjZbonbGt+I5JdlX6z0ds/UuwmSgDwXQD8OsxyQfT9qxnVA1EUuZJIqbZyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nKcC1rdn;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C33606EE96;
	Fri,  6 Nov 2026 09:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47C33606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nKcC1rdn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nKcC1rdnYc6YvlXlDFcL9eKIGnxU4ZEbHdw40+WruBOn0PI3vs6tw2oB9JczW6C4y6wJ2NskfAubd
	 Tj2UE1sApyaleDSFt/yl7SxA147LyxVZHsMMGfPfdb7LLnfaKYXwXaas2XM5Ch5k3goDyB9SWskmUz
	 hmOOoNmhUdh++H38=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aeda46595f-8cbeb;
	Fri, 06 Nov 2026 17:56:53 +0800 (CST)
X-RM-TRANSID:2ee16aeda46595f-8cbeb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aeda462b7f-1c0fe;
	Fri, 06 Nov 2026 17:56:53 +0800 (CST)
X-RM-TRANSID:2ee56aeda462b7f-1c0fe
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: tongzhiwei@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] lib: objagg: Fix stats imbalance on hinted-parent error path
Date: Fri,  6 Nov 2026 17:55:58 +0800
Message-ID: <20261106095621.143-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
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

NOTE: this commit is worked by llm completely

In objagg_obj_init_with_hints(), the parent is obtained via
__objagg_obj_get() which increments only the refcount without
touching stats.  The matching release for internal references is
__objagg_obj_put() (no stats adjustment), as used in the success
path in objagg_obj_parent_unassign().

However, the error cleanup at err_parent_assign calls the public
objagg_obj_put(), which additionally runs objagg_obj_stats_dec(),
decrementing user_count and delta_user_count with no prior
increment.  This corrupts the parent stats, leading to
under-reporting and potential user_count underflow.

Use __objagg_obj_put() to match the internal __objagg_obj_get().

Assisted-by: LLM
Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
---
 lib/objagg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/objagg.c b/lib/objagg.c
index 23c7105a3f9f..6c4144213eb8 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -327,7 +327,7 @@ static int objagg_obj_init_with_hints(struct objagg *objagg,
 	return 0;
 
 err_parent_assign:
-	objagg_obj_put(objagg, parent);
+	__objagg_obj_put(objagg, parent);
 	return err;
 }
 
-- 
2.43.0



