Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28A3B47DF
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390468; cv=none; b=OR17jbdO4ZAkmP977wMmZ0qNspiRff9HIbo6/k096lqWGDRRBEDaepBGW9NlAOPi2633+K4LxVk8EOlBgpidA65eGZDl8CWAwpiANLIMBjABbcg3Kcyu3xlRK7TbqVC0oP3a0bUda4B0j6+hGazOoxikMUHrOtsWRQd3TNrg+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390468; c=relaxed/simple;
	bh=dlQdsE/j5toYF22//TfvaBwvC0qznaCOAVpREJNhW7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl7DZy7iRWcLvxBOqSzIbeB0gZI2cloJWTRf9dNSDVLtis6tEElvMhINeya/InTKkV8mGEOb8+ozBHNvguhU1k0GVCZJrSD6U/UoEiVuYxwb+IqvGUA0n3wy89g6MamUGKcrNNGYkPNa+vfw6ngoW9DMdu6JbTd+2ndhdLvFA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZYp1D91; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZYp1D91"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f4f53975e6so1227860a34.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390466; x=1788995266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2VflTBzZUeF8WMa8K3rMUAeHff9Bp3DON6+AOExJg0Q=;
        b=bZYp1D91XQU49q+dEoZ+qlZO0rM7LDA2G2m2PJJix8/yrxYN2EJGj3ctHc+xUq5UaN
         WlfD0Bl1p0vt5wnapf/VYgMGl/WAnJn9E8eLhsghm9oXb3/YpvdS3MoCPdIxt87xOB5m
         76qmJn8q8C7nk0XPeiWw9pXOUYZ2r7335aF51dKrVKKl0x640bMR6+biitHzWsBgEcNO
         2HgQQBHo4NTXeYsoOh7Z2HFdniKmSBFCrKht55xwtSsDM0JqbVfThGsY3m/eKyugExM7
         nPnCHnXA9uc4NpOXmlW3b2zVEmWo4beZNXMPCwME+K8+FmkT0NSpFrJ76hYu+A9MzASZ
         L2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390466; x=1788995266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2VflTBzZUeF8WMa8K3rMUAeHff9Bp3DON6+AOExJg0Q=;
        b=sLPS9/HOkRAMIU6fNp+fqZIOHlbSR/Zgxr79FG6atj12isfFN+1F6Kih1pT1IclMgu
         MssFBCR6rbDV5Mw9d4zmxCzh5WTOKWOKH/x/HRvDhCjstpI9MfkOsZN6/kYCdGhDovke
         MzXn3HVKWPimRAKAamEfF7ypi6U3a2hzwfrfV2Ka+NQT6pfGCeZUf9ZpYaDGZCVV9EWM
         30kKr+NcIofYfwAS5WWeDgq9sFC78OL+7A1aZ2MvT8+Vj9clL44JLJ8cU1cqqSxX4xOf
         UamCcad+fjigw4x/dL8YOIVHEvM1x07IADhJW7487ZYMi+LKeI6ifIYdaGk1JySZRrhv
         3q6g==
X-Gm-Message-State: AFuF++mc80CWfacgjzWZ4P5RRCTqEwI60CPDFrnu1tehOIPbNRM/2iMB
	DjwvFQ2jfN9y24VovEauwIoPKjQqipP84P+qHrj5L8O7dHO8uaUjmQPd
X-Gm-Gg: AYBFou0dPwVPLgFujUDv8aUfOOaYyJbfhDEkbAfzsfqYYCZdyKncVuODHbJ339YdocU
	CK61zfyUAWgaW9faz5X3FFgCbXZdCZ0T40/eQf+NH61qHtRgJDmIGn5/7S6nYXHeptM7H3pAoyU
	ICUeM2fBKatL3DNdc94qiQ2iXNIOBBsDo8ku6UFZ6gpmXXdFrrXb/Jla/PRPquK5hzknznUJd5z
	fdIe+a2ATB537Xnqo64G1pTU2+rkMvoTdU50JTlNDCFpKhGJdaqa0vOvzZXNegBQohLZDpantQx
	+4cnJOxCDEE4DFtMJc8ciOXSPyaryCrPbncT5OFV0rMNxz8SVNRDx+QYO8zQKERGYcNwrVzppGR
	o1IrEVImpwxjNYMXm3L+DSESSEzQW6tk0MJc9PB4C3yk65NMkf2RIyAABr6UnAXWXMR6d9Jahul
	ahaxv21gYKIv5v+WyBRSY6DM8d3wrlsjI7Lqqw4jFyMElCxosSROfxjbSBfw==
X-Received: by 2002:a05:6830:4390:b0:7f4:effa:a5c4 with SMTP id 46e09a7af769-7f77f3d222cmr8059577a34.1.1788390465632;
        Wed, 02 Sep 2026 16:07:45 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:26::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74caad7dbsm3277884a34.2.2026.09.02.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:07:44 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	mohsin.bashr@gmail.com
Subject: [PATCH ethtool 1/3] ethtool: fbnic: fix off-by-one shift in reg dump parser
Date: Wed,  2 Sep 2026 16:07:37 -0700
Message-ID: <20260902230739.2241212-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
References: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

The INTR, INTR_CQ, QM_TX, QM_RX, TCE and TCE_RAM section parsers skipped
the first register value and stopped before the final register. Every
decoded value was consequently associated with the preceding CSR while
the section length still appeared valid.

Consume the first value without an extra increment and iterate through
the inclusive section end.

Fixes: a38a2d3a8271 ("ethtool: fbnic: ethtool dump parser")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 fbnic.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fbnic.c b/fbnic.c
index a5b1d76..e368c60 100644
--- a/fbnic.c
+++ b/fbnic.c
@@ -5598,8 +5598,7 @@ static int fbnic_dump_fb_nic_intr_global(uint32_t **regs_buffp,
 		return -1;
 	}
 
-	regs_buff++;
-	for (csr_offset = csr_start_addr; csr_offset < csr_end_addr;
+	for (csr_offset = csr_start_addr; csr_offset <= csr_end_addr;
 		csr_offset += k) {
 		k = 1;
 		reg_val = *regs_buff;
@@ -5728,9 +5727,8 @@ static int fbnic_dump_fb_nic_intr_msix(uint32_t **regs_buffp,
 	 * from a different register array at the same index.
 	 * Every 4th register belongs to one register array
 	 */
-	regs_buff++;
 	for (csr_offset = csr_start_addr;
-	     csr_offset < csr_end_addr; csr_offset++) {
+	     csr_offset <= csr_end_addr; csr_offset++) {
 
 		i = csr_offset - *section_start;
 		reg_val = *regs_buff;
@@ -5818,9 +5816,8 @@ static int fbnic_dump_fb_nic_qm_tx_global(uint32_t **regs_buffp,
 		return -1;
 	}
 
-	regs_buff++;
 	for (csr_offset = csr_start_addr;
-		csr_offset < csr_end_addr; csr_offset++) {
+		csr_offset <= csr_end_addr; csr_offset++) {
 		reg_val = *regs_buff;
 		switch (csr_offset) {
 		case REGISTER_RANGE(FBNIC_QM_TWQ_IDLE):
@@ -6301,9 +6298,8 @@ static int fbnic_dump_fb_nic_qm_rx_global(uint32_t **regs_buffp,
 		return -1;
 	}
 
-	regs_buff++;
 	for (csr_offset = csr_start_addr;
-		csr_offset < csr_end_addr; csr_offset++) {
+		csr_offset <= csr_end_addr; csr_offset++) {
 
 		reg_val = *regs_buff;
 		switch (csr_offset) {
@@ -6750,9 +6746,8 @@ static int fbnic_dump_fb_nic_tce(uint32_t **regs_buffp,
 		return -1;
 	}
 
-	regs_buff++;
 	for (csr_offset = csr_start_addr;
-	     csr_offset < csr_end_addr; csr_offset++) {
+	     csr_offset <= csr_end_addr; csr_offset++) {
 
 		reg_val = *regs_buff;
 		switch (csr_offset) {
@@ -7450,9 +7445,8 @@ static int fbnic_dump_fb_nic_tce_ram(uint32_t **regs_buffp,
 		return -1;
 	}
 
-	regs_buff++;
 	for (csr_offset = csr_start_addr;
-	     csr_offset < csr_end_addr; csr_offset++) {
+	     csr_offset <= csr_end_addr; csr_offset++) {
 
 		reg_val = *regs_buff;
 		switch (csr_offset) {
-- 
2.53.0-Meta

