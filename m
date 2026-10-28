Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223452;
	b=nNvr51HyUT+9l3SoiwMprodVIjeYFR8tINEVh9iM0Qbt5C3omxOcylEzDf92QBIaNbII
	 6mufl3/j6bX81tYFgWGfRk1bMAAsx9ePTL5VsiN1MGBBy7X4jvp7mFyiOlSMQhpqGSTcW
	 zkHVFWqq86N65XhMQH0PEtIY34l6EnGQB20fX5fzjVy5ASMyKIFIqW2Z5dYS/FT4fKWyw
	 whjKHSiIlkSE7oooSKpu3U67Ex9PgFBWl2etq0bi46cxnFUlcfvjotOFTxMJhfk40Ddxq
	 nuIDIGGYzdVaI/fZjPhBRwTZcUB8ow9GWMsAid/21Sw5VLUqT1cDXn+/Hw7MOeZ5VsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+SO6JKjC4hDBNLlADRNP3/4AQmkpmDLlT2I1AwNn/OM=;
	b=j0yeLOm6KgOtYw/doR6B+SiY/DpDeN05cyfbY6x+zFYjjX33fsSU28a10xh5tNTtIyYV
	 To5MOwo42FBuejA1W6A82nKQvnsw+EfBjY5lc6vnvxG5skh1V3MjGxVlbp5D2I68x3Obc
	 BKkriHHrk8VnIqTG6c5u+nj8M8BBdYqylUGW1jFwxkpWb1z6rbE/0G6i4sTCh7CoNRBG/
	 Fm3O373lJWSKTlcQHheqjg5RKD0i5M6GXeluOnyrwLScYPFNb689Shhpo4wpmzv1jq+4z
	 eL2Ad+qQNWusAxX+Tl/oDAgThJN3zy/yjDGBXjlgHxjWBY6y9cKUP8vTTf6ZthCuuhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqQxnUUb;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74CA606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C74CA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqQxnUUb
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9f6a16aedso9610445ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223451; x=1793828251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+SO6JKjC4hDBNLlADRNP3/4AQmkpmDLlT2I1AwNn/OM=;
        b=nqQxnUUbn9ueIhjiiVJKDmBhm6WGRZa9pJ7S/ji26unoe9n9H3IHFIMyzc6jviDvLD
         CARNxPHV2RBrYD+l4UiGPIRGfVuLB0qnZ9sQmh/oyEf7Ns8zCkpCY3NzR5cJGag+K9C/
         7ciNF7uD1N11JL9Q9jeKrgA7IAvkoTn4pUCIxrkFrS1eng5ZSsmJaGdhizYQKH/s7+Mk
         Czb67BVzDy7sh2EgbRHbNGIidEufzvesSoTQcJCZkflyDzvDHaYi2c55iPpcKjDXgsvl
         J6pqyLsLLwNNzZTc0+xlpKExtOmCd9uG3j1BDdHd+3C/y0wQYvy0P0xjG0tKKfFM5GDM
         lq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223451; x=1793828251;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SO6JKjC4hDBNLlADRNP3/4AQmkpmDLlT2I1AwNn/OM=;
        b=CRKoA9VLxAO+nXza1ed2yY79ckmGD6lbEVsLvrJgsfJeVmIo1mJepg1WFV6FxpyD1n
         qgl6hOqzy6CGPdCCrKycw+u38d7ot4F3JQrY+pzD7wYS+VKiS4znwBHUOLmUJeRjyoiF
         5UzqpMFCmATvnOUoAzFSR/3JG1hWRfvS1bqdYIkJCjqbrHnLnkB+0pFLEaM/zJYHRxWI
         6fze4oxXXzVElWaRM5psiyp+MVL8miIr+z0JyXxgaWVXlpCc6fyzK4DZxYhWDBqbJNhj
         NCrlTvtKfRGJEWZ05XJwIjnVRkOmaUS9dsinC4wa4d16EqzoUSdc0H6EbdMvGDovS83q
         DWxg==
X-Gm-Message-State: AFq9FYL/NILrHWAZuYN4WxWBoYHloeb0wq8454faBMZpagiJYnHFliSm
	cE6iktu1jOqXIdy0FQ/VOV23jR6LUFAzj2DITBABKBiqAN9JkrhnK7N0
X-Gm-Gg: AYBFou3P7BuXIcpuhuR5nkAsgGdicXyMcLxlAJMX+YUIcXaEheX5Y3Mi3A6qLoXpcxA
	x/CePQp2gbH7ZbN5aX1KFC8PfpewymzqTY2nhvc+QKrHJMFLHKBOWcYy7WdIL3VOsd3y0pSpnnW
	RvZyRvcRq9PPdeY2BMr0dNtRfKyvLwsChzPiOHiugA+JC3V8xanwuM5g4/APsoGlyhX0mydrb+J
	kxST/NZcbnd5y0MHwSaQe9vjBPev2TTf+SJPbf0YFWf9SdtJroiC1wlo7SPWlXpK57TFubnimzY
	eGsCGim/foY/dwEHS1mjEezdl9a5MoFN1oCiJG+e5t/Hx86bc7dF6qduZzL95FC08gXuPBcISYD
	10k4rdwn1a672oBw5JgrtkX+FjGNpUWm9eeqbRNtVKlzdPmrOhqnrdsH7KON25Y6BKdudI5Zgkn
	fI+HWwhgf/IWC2xetW166paY/vUCcaE4xQ5WgnnFdBYVJcbjtiricMNuxGo4nT/CvL96NLV4cwD
	YQ+FGS5FTMQPiwJLtMKUykqwBaHDIj80nnki6AgbaTPJqguVBAuVIFsXxMR4s3cHSasYenkW97Z
	cccSMe9htTsrtfnuA8DPc9RruS7LAnYxVub2mO9ZAtHS0Q1jQ9VG+z74wdMS9RZk89K0NGduanR
	fzB74ek9GMX8hGSTM7YQ89hLtHIyMwU21twQm52XCjsHZMw==
X-Received: by 2002:a17:90b:3e86:b0:3ad:eb29:3383 with SMTP id 98e67ed59e1d1-3ae57f9b10bmr2579752a91.22.1793223451126;
        Wed, 28 Oct 2026 14:37:31 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm1038659a91.8.2026.10.28.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:37:30 -0700 (PDT)
Subject: [net PATCH 12/13] fbnic: Wait for the outbound flush to complete on
 mailbox teardown
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:37:29 -0700
Message-ID: 
 <179322344904.40667.15350816992837956463.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_mbx_reset_desc_ring function drops bus mastering and arms the
outbound read and write flush in a single register write, but nothing
waits for that flush to finish. The fbnic_mbx_clean function returns as
soon as the rings are torn down, so the caller is free to let the device
reset while the outbound path still owns read requests it has not
retired. A completion landing after that point, or a tag handed back out
while the old one is still live, has nowhere valid to go.

The PUL link reset status register reports when the flush has drained in
both directions, so poll it before returning. The flush only has to
retire what is already in flight, so it settles well inside a
microsecond; the 1ms cap is there so a wedged device cannot spin.

Every caller of the fbnic_mbx_clean function runs with the datapath
already down, which matters because the flush covers all outstanding
reads, not just the mailbox ones. A device that has lost its link reads
back as all ones, so both done bits appear set and the poll ends on the
first pass.

Fixes: 3b12f00ddd08 ("fbnic: Gate AXI read/write enabling on FW mailbox")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |    4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index cbb25d11638c..d7583243e5cd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -955,6 +955,10 @@ enum {
 
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
+#define FBNIC_PUL_USER_IP_LINK_RST_STATUS \
+					0x31030		/* 0xc40c0 */
+#define FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE	CSR_BIT(7)
+#define FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE	CSR_BIT(8)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE	CSR_BIT(20)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 09d03274be08..32a18cb8990c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -7,6 +7,7 @@
 #include <linux/dev_printk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/iopoll.h>
 #include <linux/types.h>
 
 #include "fbnic.h"
@@ -187,10 +188,25 @@ static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 
 void fbnic_mbx_clean(struct fbnic_dev *fbd)
 {
+	u32 flush_done = FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE |
+			 FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE;
+	u32 val;
 	int i;
 
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
 		fbnic_mbx_clean_desc_ring(fbd, i);
+
+	/* Arming the flush above only starts it. Wait for the outbound path
+	 * to retire the requests it still owns so none of them can complete
+	 * after the reset that follows. A lost link reads back as all ones,
+	 * which ends the poll on the first pass.
+	 */
+	if (read_poll_timeout_atomic(fbnic_rd32, val,
+				     (val & flush_done) == flush_done, 2, 1000,
+				     false, fbd,
+				     FBNIC_PUL_USER_IP_LINK_RST_STATUS))
+		dev_warn(fbd->dev, "Outbound flush did not complete: %08x\n",
+			 val);
 }
 
 #define FBNIC_MBX_MAX_PAGE_SIZE	FIELD_MAX(FBNIC_IPC_MBX_DESC_LEN_MASK)


