Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450626;
	b=rKzLQ3sfVt9qXW0UJxUIwcg05xse3I+ziFAmpYBcd9AZU/XXf5Wd3T3NOQIdvM7S/jJy
	 +c3FbfylEug0ayC4u+u/zPgw29BEsmxWXKpwNBLSWRkEfW6tREgvnmEi5RvEhgIfceaEM
	 Wetdzjls5u5nKQeR9QN3W7q7ZDtY2vl3PFbSMz7pCmykq2ld0ezHJhl4eVJM9FEoIbvGK
	 NqDhqOFfz/2dXSAPK+y+zGTRZ69MDh2ZW8z0lYi3Z5wQy6DZormys/S1AtrUmFjXQ0jqv
	 DOQ4Sc4iBKXofFDN4qrALQ5b+NDpR76IRdE2VAkdnHwM4RdlD4PaLM8tzawdm4Z0vmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450626;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n9S1OY6SpcMsf7cQVxs9wiXOIhv8Y8pMCiR1hHn5Wzk=;
	b=TuwmCov6tg05taL+sHNBcSDFOm+BkgllzdXQIICBcvARgjVjpyGGtRTx3nLWXOAPWybk
	 UnaU2QxIED+FydShznnuHXfkd78V1pTZ+bX3S5walKFo3byuT0XflyC5jzulg+9Pvk3zR
	 Lt1qZAsIzemfZ1DxOUzNeB78SUQcNnDL5+aPOktzde42E1+IgukRp6gcvhG1wSAxsyvkG
	 Z5xBC7MRQHY/HZF871LPq4SmeRDNEF+yfiTPUuldWoR/fjlxW5G2w77YlZlw2X4rj7Aap
	 bMz2CZ1WLuPd61Cd1t7xAcX1dfveGHNmSINr8zJsEVEcO7iJBDjPEPIh8OaAkSKvh+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=VYj4Dliy;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F4606A31C;
	Thu, 12 Nov 2026 02:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA2F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=VYj4Dliy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=VYj4DliyMQ4bzc2JVPNp3ba7I66E3rTO8N2X7pTWuWwOckkzH2Qp7HaJfR2awzOTKW5DqKfeN+9Yu
	 jiulTiXtCL5zlfLUQG1Ekkreh3tlVuwlKolVMn+vS1peZ6NLmCOZbpQh8o64laswr2HV3LCx/NrCP9
	 835UCkorNJAgc81k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af524be549-7c7b5;
	Thu, 12 Nov 2026 10:30:23 +0800 (CST)
X-RM-TRANSID:2ee86af524be549-7c7b5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af524bdef0-ee27f;
	Thu, 12 Nov 2026 10:30:23 +0800 (CST)
X-RM-TRANSID:2ee36af524bdef0-ee27f
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: Jason@zx2c4.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] wireguard: Mark concurrent accesses to reused indices
Date: Thu, 12 Nov 2026 10:30:22 +0800
Message-ID: <20261112023022.118119-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

Removing a handshake entry from the index table does not wait for RCU
readers that already found it. Reinserting the entry assigns a new index
while those readers may still compare the old entry's index, which KCSAN
reports as a data race.

Use WRITE_ONCE() for index reassignment and READ_ONCE() for index
comparisons in the table walks. Keep the existing RCU lifetime protection
and locked collision check.

OpenAI Codex assisted with analysis and patch preparation.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/net/wireguard/peerlookup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/peerlookup.c b/drivers/net/wireguard/peerlookup.c
index 99651a86ac95..c8d943711a6a 100644
--- a/drivers/net/wireguard/peerlookup.c
+++ b/drivers/net/wireguard/peerlookup.c
@@ -129,11 +129,11 @@ __le32 wg_index_hashtable_insert(struct index_hashtable *table,
 
 search_unused_slot:
 	/* First we try to find an unused slot, randomly, while unlocked. */
-	entry->index = (__force __le32)get_random_u32();
+	WRITE_ONCE(entry->index, (__force __le32)get_random_u32());
 	hlist_for_each_entry_rcu_bh(existing_entry,
 				    index_bucket(table, entry->index),
 				    index_hash) {
-		if (existing_entry->index == entry->index)
+		if (READ_ONCE(existing_entry->index) == entry->index)
 			/* If it's already in use, we continue searching. */
 			goto search_unused_slot;
 	}
@@ -145,7 +145,7 @@ __le32 wg_index_hashtable_insert(struct index_hashtable *table,
 	hlist_for_each_entry_rcu_bh(existing_entry,
 				    index_bucket(table, entry->index),
 				    index_hash) {
-		if (existing_entry->index == entry->index) {
+		if (READ_ONCE(existing_entry->index) == entry->index) {
 			spin_unlock_bh(&table->lock);
 			/* If it was stolen, we start over. */
 			goto search_unused_slot;
@@ -208,7 +208,7 @@ wg_index_hashtable_lookup(struct index_hashtable *table,
 	rcu_read_lock_bh();
 	hlist_for_each_entry_rcu_bh(iter_entry, index_bucket(table, index),
 				    index_hash) {
-		if (iter_entry->index == index) {
+		if (READ_ONCE(iter_entry->index) == index) {
 			if (likely(iter_entry->type & type_mask))
 				entry = iter_entry;
 			break;
-- 
2.51.0



