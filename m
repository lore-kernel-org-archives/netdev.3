Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3143E49B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388330; cv=none; b=SBhn6rJjO8minqNLweqBAqjcNmnFteQbYTiyPNb6YUg9FkWEWeG2tTSavL9sYhSlGmZ0ubcdOXqHH6OxeEpoxtjsu3EJFK04wc2ewyWtIow5kcV3STUEb+XzwvY9NXQHKAlRoRSMop2avwM+hgZ63i+xXR75vS+H+WPIdwvOglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388330; c=relaxed/simple;
	bh=U2FyTgB44Anc/HvR8J4NpqdwZUTvwDFzA19j6jFIn94=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erYAKZkTRQBax69cC143Hkot1FdFYv7qcKono2mpi3MOTCDebnD725TkAv1INJYFzO7aCKEqRSLDlxvO48KwrVXciv1s0s2Tq8SainPqAIHb83qgIBoc1xnm0CAhBy3UlY02hbcQXqsjcbQTYcul9xsMe5pNuopQcEuKdvuTksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0Tp9DwR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0Tp9DwR"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8525efa7274so1356791b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388320; x=1788993120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Nk5UnSsb6l4Ex7AkWhZotOeEzDzNmZaLsq5WOGz5Zmk=;
        b=D0Tp9DwRJDkTbWjHzpaoUERLSC/U8ECZSNXAR4rXFltRkL2wvOJfGzbXC054uTUJZe
         Uo3YZfDreU2zQ8+yympsdk4Yks5s5pNCoc2XBiICnunL/n+CcjUOgS/i6eiRBCfPZDXs
         4feSDZnFOH805ucb3cWHVHQCd4w8SWBCAqlJ3i0bLD1YklYTkK4GXxk2ojLIgDfeNlBW
         PgyJftZrMtTCfFBDTPp5KTRMRVlRQoauWWGsdp1hNRzNnTWl5FgjLR6PxH5gZtjMSz35
         5rPOgU/AJWa5/w/ZUOhHo+X5sWiuaWLW4zYzs0DjTDYZOirnhwaneXBYduVXQXEnQZOm
         jqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388320; x=1788993120;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nk5UnSsb6l4Ex7AkWhZotOeEzDzNmZaLsq5WOGz5Zmk=;
        b=AKW5Bq06v90M2nFxJDMuR82Tr6qsFp2hkqVBuprVzysTu1noWNA6WUarG6fGM31ZKv
         A1k9pD36EdqmrumGDpSuuOJ6gOClgXjD5WssQkT33HNMv/+zT6mo9z9w/QXUsFSlFNSh
         dv4yov6637yrOKPXrX2ati5FZ9XkQVOKUaY4CQInYtaHrhHRpX2+QcUiTjUegYR8HST7
         dqH069HJbyZDo2vxsv0ljzs4ifr88PO5jRLqekiXqNhpAmqKSvLhVvMYtNRlB5pm/6cb
         oWoeWi91PIuOXJhFNOURWPrVRlNsMkinz9d7qJsL/hCqJz0A6+9VyTO7TquYaz6Sm1Yg
         Ulpg==
X-Gm-Message-State: AFuF++mDcG2UfX4dstyIrd3gpCDdUaZFsaT5DWNE2+42bkVeXTBupbCv
	uUEjkvFRv/WkGNl71sklDquge490vO9ndCWCmbLRjwh+E/U6H8tRTUPl
X-Gm-Gg: AYBFou0HY9sejjdRLJxfk/SfoU2OzZyOvY/wn84LXvTI4zJUAbobXRziEMi3bE27nrW
	Z9QHn08DYl4YJyZyQGTzocMBUqs+FdnA2AEtVdiI+eoj8dQFjr1XKsUDBpr2Ruw1CsSOhZYD+me
	wqiqia8+hP192T7jcQhveNkWHOSVlFtL28IpJ3qUV0xzOtdNDWEyu4C9EPRK9awAVlOIw0ho7Qd
	B1d7WTrmowvVMBSjKldyfAsTklPbVYNkvDVIt9kMksYqKIOd1haN663U0q7cit/YHJ2//l1vqga
	wqbexqxBVXByh2XMPoi8JcwkAoilEI7/hBtZbMw4kBJbko/qeRtE/J9LWr2zmTEoMmlwif6y/1M
	OUes4gWmuP6FO8PXdV+RjWooUCLjFrbeedV5DGiczJQsU5l7lGHe2uWvSrtu8/Zzel7JGXV4HJA
	BWHnWR3WIlAhq+7LFtatoOHL51GL6FOeYBRFodLgrjXYV7UJcks0eSO/Mmvt+WuPOqG1TNazmhS
	UGrzIHKJbtUnNkvX+ojcDvZCILVnnKIOMJ40R16IqjjwpqntNagcjXloc3roeTJUSqKOL1ku/bq
	Ay1bXS2g
X-Received: by 2002:a05:6a00:3d82:b0:85f:7e51:a9ec with SMTP id d2e1a72fcca58-85f7e51b8a7mr6915636b3a.0.1788388320220;
        Wed, 02 Sep 2026 15:32:00 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adc8e1sm1952060b3a.24.2026.09.02.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:31:59 -0700 (PDT)
Subject: [net PATCH 2/4] fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when
 flushing the mailbox
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Wed, 02 Sep 2026 15:31:58 -0700
Message-ID: 
 <178838831819.11136.3279654005346776816.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

When tearing down the FW mailbox Rx ring, fbnic_mbx_reset_desc_ring()
writes AW_CFG with FLUSH set and everything else, BME included, cleared.
On the write path that is not enough to terminate the outstanding
requests. The PUL write pipeline only forces the staged requests out
when both FLUSH and FLUSH_MODE are set; with FLUSH alone the writes keep
obeying the halt that comes from clearing BME, so nothing drains and the
flush never completes.

Add the FLUSH_MODE definition and set both bits so the flush terminates
the outstanding writes on its own.

The read path is unaffected. AR_CFG has no equivalent mode bit and
AR_FLUSH terminates the outstanding reads by itself, so it is left as
is.

Both writes remain plain stores rather than read-modify-writes. That is
deliberate: the matching write in fbnic_mbx_init_desc_ring() restores
BME and the TLP attributes, and clears both flush bits as a side effect.

Fixes: 3b12f00ddd08 ("fbnic: Gate AXI read/write enabling on FW mailbox")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 64b958df7774..14af30e189d6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -974,6 +974,7 @@ enum {
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE	CSR_BIT(20)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_RDE_ATTR	CSR_GENMASK(17, 15)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 283d25fae79e..ace6685df039 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -60,8 +60,14 @@ static void fbnic_mbx_reset_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 	 */
 	switch (mbx_idx) {
 	case FBNIC_IPC_MBX_RX_IDX:
+		/* The write path only terminates outstanding requests when
+		 * both FLUSH and FLUSH_MODE are set. With FLUSH alone the
+		 * writes still obey the halt asserted by clearing BME, so
+		 * nothing drains and AW_FLUSH_DONE never asserts.
+		 */
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
-		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH);
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH |
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE);
 		break;
 	case FBNIC_IPC_MBX_TX_IDX:
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,


