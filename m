Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223459;
	b=ezDkaDbn4xKBJ1CBIeJTc3q8fcCNxQBApvUl0yI4Kwx4A5vSoc60PXzt80D2T3iyJg22
	 qBMvLhqUJPq4ALuOOWsHqC4wfeJBcVpg+8rPkTxfWbQjakqB3nICyeToAO/AW6YZeYmFL
	 oOMLZ1SZeMnycMhGHyRjNnVdGuB7/oanPpFdgTd6DQ8ysYUe0rTCirBDau/u2KbD7//pS
	 XCn+OVwFzXjjhxKU3Cmw9dajWSLyxQtzAV/ePdbuZ/6vvwf3e+7MBnUKfXCmDHtk/Rr3d
	 //cmj9B1P8IerbS1NSi9KCqbWDUgWCvnySpVNgimOo4owHc/pV8NUDE/rig80t5k87w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ua/WcoI63VeesHShyFwdbeqpekJg43ZdDLH5fSyDw3g=;
	b=QjczIDlI9+1il/MU4YPUXaEnpMvHU5gwwQY+3yUSvcYeQoSDKPK8//PKoRAzZc2ckO7p
	 GLTK0t+oMH1Ql59e+RGPbRXdd8jB6hRyADZzmx6z3ttQSzB/Sd3RsGnRkTZQco0akCSa9
	 48a924QEzxVtupA14FPOK2T/fiXij7oK72WRTpsPRy84WkFCQX0EN7xAZf5uQtCi5xIOF
	 WfEhwC/niEjAy+GoLg4Kq1hd3iGgJp9N3xnu0sMnYcjXC9fkL7J2VeyDuEPx7dctFG1Lb
	 kFHaDFm+uZ+ODjNkPw360lcCux5ayhsJYxStBVEmcRbNQBH3sTB74nbbvoNTNo3pv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHpD4RKE;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86621606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86621606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHpD4RKE
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e95bd1c14cso11720635ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223459; x=1793828259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ua/WcoI63VeesHShyFwdbeqpekJg43ZdDLH5fSyDw3g=;
        b=aHpD4RKE3UkTz/QNZT++24bfWRUzf75hguxqFbGeT+xQvsDLn9MufbrUbiKeHzf+DH
         EJzRWLCx7Du8hUIVMhO6Pbf0gN8NsUlpSKcHEAjcZqKwQLaX61Rd3Jj82cnsuRDqPfrN
         3ufznNRcUTLeJuSKB3N79Jaf1xU04k1kBLVZG9SlTztnQJexx4n+k5EKruaS1iHuXvt3
         EJ6fBX0xXTePFclhQPulIay5QLhCrQSlhNjvGalbsDg/ADNqNjONT5O1qBUTU5ksRvQy
         5HxegeTqaszvRG1aPAaDuQb5EWBohmI7IoMUd1x+Z/nhYGLCDS+rjd3nE1gf364AaLRc
         gDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223459; x=1793828259;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ua/WcoI63VeesHShyFwdbeqpekJg43ZdDLH5fSyDw3g=;
        b=nc79tvsrGGu4vci6zd07vIZXmLknHy75MlM/XCqqv6gOPNqUGSCD+MCvdwWLeB8daj
         Yu6SziTDcUU5cNiAoHBI9ceFEtQhAoZrAT6wxgy24TTIujxq8FEk2g0mlNG0dFOh5xFk
         PsSrwftc5gfKIMFLT6oSQ3UgwFQEGY+kgFZHi6su5AncJg5LIxipDs5l0atMa5JcCP5L
         gc3eZhDx0eILe6PFW3gCkDSksEVWKdVjxJmTnKO4pEL9bXfoPiYvIfb/nOov1nOeuiuc
         kH8MfZpi2CfC+hqlC1gRKB/re5ukbs7CRhE99FK/bKK6640pygOitJWgTeS3TR7S769b
         Rotg==
X-Gm-Message-State: AFq9FYLIbW20AgWOMaVWQ436ZzvLhW9bQzTr+XE9FDaY9VntkOLusLmI
	p+C6BSsdeg2//8fDPCH8QBEeFvcCtFgwPTqT8mxcjCPBdOMsOWtRUnnk
X-Gm-Gg: AYBFou3jzvTbPtTNvTmG8rgVP15plYuWBgQu5Jsw2SH7332gihtKaPl1YAiU4gbn/fx
	OG2XEb0/57u8mtzhdiaXmJ6FL2g/xIzDYu88BUz/yAeLq0eQBi0ob2DlPgGQXyNObf37C5SXX04
	ZUX+7gKCEjKZ7yJQhRgj/7b0ZrCeJV8JoSjVvqeOGVmPSbBhUfYBUMyAMFn92nfnL+buxgu+FDF
	MqZ1vxYeTCvs3FEyqdLYMONOT0jUWI+PmLnqNKkKZ1HL9xNUMN0Hjnunbk/feglO+Xzltxm7LNc
	hOzYY3aQflCRAaGMJVTJJmlEdin6EwkCwKlDpjA8dkLVNeXbI9nxZ6JTshT5dopj+VLk8MG0nZQ
	MfQzJXmPyyhCmGSCReQqm+vVWI6slPtHBBbyzBukda/I31Rr4qGyoYH299MBHuliXtJ3YwS4paX
	l0DQVm3YvSaBc5KaO3/Cg15g7M4kLOQa5ieB03H+l6tJ9a8VnCZwTPSWDvDpT4Ynn8yGJb9+VHH
	hw9ftbmxckOtrfIzj5PQs7Kz16dtknHhsTXxt3ZDRnVNdnaKM69WX0q8nu1MHtrYp6ZbaMmdlCF
	YwETcCH/UJdkMm4NjmgDj12TlUz+eRgNML84eiwgkxHqNVcBXMQrAmpQe5+lKh7kzgE/rxmwxmw
	/k3U6M/RpoiaIq3ZbBKFnZL8mrCPwYzMqlk8GMfQsGygO6A==
X-Received: by 2002:a17:903:24e:b0:2e9:6788:9379 with SMTP id d9443c01a7336-2eb0056060emr30831785ad.32.1793223458917;
        Wed, 28 Oct 2026 14:37:38 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b774acsm25903635ad.22.2026.10.28.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:37:37 -0700 (PDT)
Subject: [net PATCH 13/13] fbnic: Disable PTP completions during the Tx
 force-flush
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:37:36 -0700
Message-ID: 
 <179322345631.40667.15699365218498548850.stgit@ahduyck-xeon-server.home.arpa>
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

When the Tx queues fail to go idle, fbnic_wait_all_queues_idle() falls
back to fbnic_tx_flush(), which sets FBNIC_TMI_DROP_CTRL_EN. That bit
only drops packets at the Tx MAC Interface start of packet protection FIFO.

The PTP completion path is governed by a separate bit in the same
register. With only the drop enable set, a timestamped frame has its
packet discarded while the matching completion is still forwarded to
the host. fbnic_clean_tsq() then walks the ring with no packet left to
match it against and reports "Tx timestamp without matching packet".
The drop does not retire the completion either, as the completion FIFO
is only drained when the completion disable is set.

Set FBNIC_TMI_DROP_CTRL_CMPL_DIS together with the drop enable so the
completions are drained rather than leaked to the host, and clear both
bits again when the flush is turned off.

Fixes: 40bf06a160a1 ("eth: fbnic: Implement Tx queue alloc/start/stop/free")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index d7583243e5cd..c371ac9f78c1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -441,6 +441,7 @@ enum {
 #define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
 #define FBNIC_TMI_DROP_CTRL		0x04401		/* 0x11004 */
 #define FBNIC_TMI_DROP_CTRL_EN			CSR_BIT(0)
+#define FBNIC_TMI_DROP_CTRL_CMPL_DIS		CSR_BIT(1)
 #define FBNIC_TMI_DROP_PKTS		0x04402		/* 0x11008 */
 #define FBNIC_TMI_DROP_BYTE_L		0x04403		/* 0x1100c */
 #define FBNIC_TMI_ILLEGAL_PTP_REQS	0x04409		/* 0x11024 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index c572a0062e77..9bc934c6771d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2349,15 +2349,19 @@ void fbnic_disable(struct fbnic_net *fbn)
 
 static void fbnic_tx_flush(struct fbnic_dev *fbd)
 {
+	u32 drop_ctrl = FBNIC_TMI_DROP_CTRL_EN | FBNIC_TMI_DROP_CTRL_CMPL_DIS;
+
 	netdev_warn(fbd->netdev, "triggering Tx flush\n");
 
-	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN,
-		    FBNIC_TMI_DROP_CTRL_EN);
+	/* Drop packets and retire their PTP completions */
+	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, drop_ctrl, drop_ctrl);
 }
 
 static void fbnic_tx_flush_off(struct fbnic_dev *fbd)
 {
-	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN, 0);
+	u32 drop_ctrl = FBNIC_TMI_DROP_CTRL_EN | FBNIC_TMI_DROP_CTRL_CMPL_DIS;
+
+	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, drop_ctrl, 0);
 }
 
 struct fbnic_idle_regs {


