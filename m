Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389671;
	b=5jxT4ebU9WIRR5q6T73vTY0AbeCEgFpCMzuwZ2aRys2pu5EDV8ectT6OJv0TvMIwYg+J
	 NIut04Evfmu67O7SwoE6BX74Ah9pypz0k1i4PWBlrcRW5Arf/AgvBp+M3c7tx6FMhPKHN
	 8iq1A6xX4NIL51wsEumwPB5oET9Yb47aVAzRU687nK7z7v2R6EGAfzdMdkPK4j0BCxApm
	 nnEsMCsB+C66PC5hnLKIuA7Eq3rkXLf6UddeCRlVJeL9lzzmWnLmhwMfBgKmoIgP1+IEw
	 9GOmFYVpA+8/kp44/NUvVK23SS7Hx/Xix7Xq4RuMPqH4E/oGXYXdYB7M1ECNNYSwHng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389671;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=w2FctwDLdLDAkukKWTGqgk6qc1mhPemD+CCv6GK4dYQ=;
	b=1uSct0z3j4f8tG7TEAEQ5qfNXRdSk8RSyfUWCosE2E3/8yXMr/80bJnfGKb211LVyF/i
	 2ceWhna86lBAeEqBQ8ZtWuag2YvHaFCxDZRo1ePYzrxnJVdwR1kzGVJZ1bPrqixxe8MFc
	 XKb27fC7jGJCdt3z7gK9BdRycRv93++1bjqwJ2EKasYV8KIVY4SSriaxKnkE+QpJQXDeu
	 RicugZ1SnNwVv9BUTBTiQYw4xN/9ho07f1acpAvUR4jKkvtOUxBcOE8r/qqRKOmv8HSbi
	 Ij4YCRa5UI1FTQoaoQIK1o9HQdMo0OIktlByEK6pCvEr4F71X9JrEvhmUX8AvdG88Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839A606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3839A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from imini.taila1aac7.ts.net (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHZbqhNvRq183fAA--.7089S3;
	Wed, 11 Nov 2026 17:34:25 +0800 (CST)
From: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
To: Sunil Goutham <sgoutham@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org
Subject:
 [RFC net-next 1/2] octeontx2-af: reject an out of range MCAM counter on CN20K
Date: Wed, 11 Nov 2026 09:34:25 -0000
Message-ID: <179438966513.1752948.9405325090310502892@mails.ucas.ac.cn>
In-Reply-To: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
References: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowAAHZbqhNvRq183fAA--.7089S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fKw4DZry7JF1xZF45Awb_yoW8Cr4UpF
	s0yFyIkr1kJr13uw4UJ3WrtFZ8CanrJFW3Kr18Kr4rZan5tr4Sq3Z8Kay0gFy7J3yruFyj
	yF12v3yrCFZ8XFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv04
	87Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE
	zuAUUUUU=
X-CM-SenderInfo: x2kr0wx1lfxvtqjskio6pdxz3voxutnvoduhdfq/

The CN20K branch of rvu_mbox_handler_npc_mcam_counter_stats() derives the
bank and the register offset from the counter argument without checking it
against the table, unlike the path the other silicons take.  With a counter
past mcam->total_entries the bank number selects a bank that does not exist,
so the register offset leaves the NPC block and the caller reads a register
of a neighbouring block.

Bound the counter to the table before deriving bank and index, which keeps
the access inside the block; an ownership check would need the caller to be
compared against the MCAM entry owner and is not added here.

Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
Signed-off-by: Yicheng Zhong <zhongyicheng2025@iscas.ac.cn>
Signed-off-by: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 42a601976db..be8e3518e7b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -4015,6 +4015,13 @@ int rvu_mbox_handler_npc_mcam_counter_stats(struct rvu *rvu,
 	 * has its own counter. No need to verify the counter index.
 	 */
 	if (is_cn20k(rvu->pdev)) {
+		/* cntr is an MCAM entry index on CN20K.  An index past the
+		 * table would derive a bank that does not exist and take the
+		 * register offset out of the NPC block.
+		 */
+		if (req->cntr >= mcam->total_entries)
+			return NPC_MCAM_INVALID_REQ;
+
 		index = req->cntr & (mcam->banksize - 1);
 		bank = npc_get_bank(mcam, req->cntr);
 		regval = rvu_read64(rvu, blkaddr,
-- 
2.43.0

