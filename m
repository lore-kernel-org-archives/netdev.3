Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02E377A8B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845228; cv=none; b=VAmu8UeyHq+Q1sOveRFgUHe66kDZSHdFYGJk+1AehIepgWjtz7D0w4Zz0CnasZ5q4uDSVSEQU12ELlS2FOil8kV0UWGyimCHgzbUa9HPcuPe0dxgooj27kRvgi6gndrzwvX1KYiInfLGzQ7ZemgGRp2HpM1jnGwg8feehI/yIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845228; c=relaxed/simple;
	bh=T4JVOAZANZ6C1YahNa+Jhd7yYk1njwqrdyNjpmXVS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG9taRQRYezZrRhQwJfwK736M4G+uwFClQlAm7ukf6yDFI7/eLC5oC5EihatlDpLzm00uiOOvHs2Ld8qqmz7pOHhPUhsasRszcjuCscUSZw0NehFVF/P3CoXyPqCGSkW8pihgpYGq3cJmxM3ap5EUr2a0uYboXupP344NjIjAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifBrSWDj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifBrSWDj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso3516542b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845225; x=1789450025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeACi7rIC37eW3ZQypGb8w+9vS3x8jaLiLrfiFFFVvQ=;
        b=ifBrSWDj0nH/G01Kb0UDBd1fYJsUkb7MuEDYXpxSJiWHfGBaWfRxa+jV82Ght3yEAH
         6ek4uU1AbIrhXuS5FFzuhJqaob4D9aLXcc95PLQN4sjvU1MeZWy4Hl6h8aKk+Se2KUm/
         I09r5d1h0xaLYjYaIcPXsA85mfFoz9DDMiIQGjqCdWQUZrDAyTIPvVMiKnq/nYsZjCwD
         JrulUcW9nyHZfPtSYv44uXpOiykWyMFsGFQKnaV7Sv1HUqkeW7Wp0K+z5xLbweXafubm
         zXX1/CHWMXMqqsM+x5f4N1aX6V9jyKbfkXqNA4ZMPxPfXZjBFiviAyz9oaLkdz1ynjOj
         nWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845225; x=1789450025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeACi7rIC37eW3ZQypGb8w+9vS3x8jaLiLrfiFFFVvQ=;
        b=bDeDJMNohfwjQfoW+fr6RLPwbioWy605/16/X7MrrZg0iavohdr/mFCEUccO0WIhQX
         KtQOGoxkXkPvT+29a0ZCTVzdnIFXtrD1eK5JwCohkLbb+wbxa6xe4BmQxa66TVclsqla
         gdavyq0aPe01nVlHNXnH6d+3LRUxRZSnTdz5LFOvNSG4YZUywhxBcpEgqJXeI46LJ5cv
         3sG4FWkFo4Hb0tisKkgmZRTcbVDx/Jy2rpc8zVpUugyKgK1R1KiaakGzzudl58XW23wS
         jcxIFGJ2JiffehIkPaQaD4n9ZRPWHVc1JKZdRYSFBOOFn5J+ZBoasFhaJgFl9liTKUyH
         YemA==
X-Forwarded-Encrypted: i=1; AKwUvByIub5hq1yKwK+2Dgq90kOSxlBE1PJvir1KJe6oZtGdTv+v8xnb9cXT21M9nT22t7jp5oSi3Lo=@vger.kernel.org
X-Gm-Message-State: AFuF++lDsp/AnKbVLT4bMM3XdIu1v+dqPyOZvrbbpcfi2IQ0+rFrI2Jz
	W6dyynuwndOMHN3uVmXohjjUk+Cp5ucs3H9yhtJ+XQm/oOeU/YjhIwfY
X-Gm-Gg: AYBFou02V8RGUXLPQq5GfnYPKiLkryAnM2lQqNk7YUJkaQlf05aS1EyK8nnQq4XMO5N
	7Tl+Jid6NZKqk850OLYila+wRyMvviouCIDYalN3dxtQSmI63TdoYdmBMCWgiBmFgELbyFVrx/F
	2QXCN+hSWPs52VMX6GOGHrDXYvbDYfgRvktVZAg40cmJpODhflsRkwyjDgVGCN6Do0s7xQ3T3ek
	xAKNsSTCXNhpDQrLxavvk6BSenjYj1jJ2gFl/vf1NoUDH7lnPEJ2Lu5GRFO9qTKzX38mcNtME8H
	OvCfeaAim30YSaCB+zTxSymdbk4BRkbUlJbi3R4jBkjZTCFnjpRQ2vFzjgPOsBkOeNnCYUlapsW
	6pW9hMNLI2JAavmzSxShUXTbmxf8SmoVRov8LHK20WRngZG/7XMlaIeI1Dmx0k+OR5+FjWV1RqM
	+CnZ+xoqEt3ZpJpbT7oh8tLC+cZYtzvzjN2eM/1bzVFznwcxRbFgPui09qxPpJpO7XUpNPPTar1
	aDfV1PkOdz9wILOCeo9GUTb
X-Received: by 2002:a05:6a21:15cf:b0:3cc:ec12:a788 with SMTP id adf61e73a8af0-3da39b57e15mr43900792637.4.1788845224592;
        Mon, 07 Sep 2026 22:27:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm11720586c88.9.2026.09.07.22.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:27:04 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Chris Snook <chris.snook@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Geetha sowjanya <gakula@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Manish Chopra <manishc@marvell.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Verma <rahulv@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Russell King <linux@armlinux.org.uk>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 06/10] net: fddi: fix typos in comments
Date: Tue,  8 Sep 2026 10:55:58 +0530
Message-ID: <20260908052602.27497-7-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908052602.27497-1-hemanth.selam@gmail.com>
References: <20260908052602.27497-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings in comments, found with scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/fddi/skfp/cfm.c     | 2 +-
 drivers/net/fddi/skfp/ecm.c     | 2 +-
 drivers/net/fddi/skfp/fplustm.c | 4 ++--
 drivers/net/fddi/skfp/h/hwmtm.h | 2 +-
 drivers/net/fddi/skfp/h/sba.h   | 2 +-
 drivers/net/fddi/skfp/pcmplc.c  | 2 +-
 drivers/net/fddi/skfp/rmt.c     | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/fddi/skfp/cfm.c b/drivers/net/fddi/skfp/cfm.c
index 4eea3408034b..b722a195d831 100644
--- a/drivers/net/fddi/skfp/cfm.c
+++ b/drivers/net/fddi/skfp/cfm.c
@@ -17,7 +17,7 @@
 */
 
 /*
- *	Hardware independent state machine implemantation
+ *	Hardware independent state machine implementation
  *	The following external SMT functions are referenced :
  *
  *		queue_event()
diff --git a/drivers/net/fddi/skfp/ecm.c b/drivers/net/fddi/skfp/ecm.c
index 2f5f5f26bb43..e418ab65cb61 100644
--- a/drivers/net/fddi/skfp/ecm.c
+++ b/drivers/net/fddi/skfp/ecm.c
@@ -17,7 +17,7 @@
 */
 
 /*
- * Hardware independent state machine implemantation
+ * Hardware independent state machine implementation
  * The following external SMT functions are referenced :
  *
  * 		queue_event()
diff --git a/drivers/net/fddi/skfp/fplustm.c b/drivers/net/fddi/skfp/fplustm.c
index 036062376c06..0d4201345f9b 100644
--- a/drivers/net/fddi/skfp/fplustm.c
+++ b/drivers/net/fddi/skfp/fplustm.c
@@ -150,7 +150,7 @@ static u_long read_mdr(struct s_smc *smc, unsigned int addr)
 	CHECK_NPP() ;
 	MARR(addr) ;
 	outpw(FM_A(FM_CMDREG1),FM_IRMEMWO) ;
-	CHECK_NPP() ;	/* needed for PCI to prevent from timeing violations */
+	CHECK_NPP() ;	/* needed for PCI to prevent from timing violations */
 /*	p = MDRR() ; */	/* bad read values if the workaround */
 			/* smc->hw.mc_dummy = *((short volatile far *)(addr)))*/
 			/* is used */
@@ -572,7 +572,7 @@ Note	After any ring operational change the transmit complete
 	The operating system dependent module must enable
 	the transmit complete interrupt of a queue,
 		- when it queues the first frame,
-		  because of no transmit resources are beeing
+		  because of no transmit resources are being
 		  available and
 		- when it escapes from the function llc_restart_tx
 		  while some frames are still queued.
diff --git a/drivers/net/fddi/skfp/h/hwmtm.h b/drivers/net/fddi/skfp/h/hwmtm.h
index e97db826cdd4..0ab49cc0a8bd 100644
--- a/drivers/net/fddi/skfp/h/hwmtm.h
+++ b/drivers/net/fddi/skfp/h/hwmtm.h
@@ -113,7 +113,7 @@ struct hw_modul {
 	struct	s_mbuf_pool	mbuf_pool ;
 	struct	hwm_r	r ;
 
-	union s_fp_descr volatile *descr_p ; /* points to the desriptor area */
+	union s_fp_descr volatile *descr_p ; /* points to the descriptor area */
 
 	u_short pass_SMT ;		/* pass SMT frames */
 	u_short pass_NSA ;		/* pass all NSA frames */
diff --git a/drivers/net/fddi/skfp/h/sba.h b/drivers/net/fddi/skfp/h/sba.h
index f30301fcd022..7fe99c12e201 100644
--- a/drivers/net/fddi/skfp/h/sba.h
+++ b/drivers/net/fddi/skfp/h/sba.h
@@ -94,7 +94,7 @@ struct s_sba {
 	long		msg_mib_ov ;		/* Current Overhead for this Path*/
 	long		msg_category ;		/* Category of the Allocation */
 	u_long		msg_max_t_neg ;		/* longest T_Neg acceptable */
-	u_long		msg_min_seg_siz ;	/* minimum segement size */
+	u_long		msg_min_seg_siz ;	/* minimum segment size */
 	struct smt_header	*sm ;		/* points to the rec message */
 	struct fddi_addr	*msg_alloc_addr ;	/* Allocation Address */
 
diff --git a/drivers/net/fddi/skfp/pcmplc.c b/drivers/net/fddi/skfp/pcmplc.c
index 90e8df6d9a88..745285d4d6d2 100644
--- a/drivers/net/fddi/skfp/pcmplc.c
+++ b/drivers/net/fddi/skfp/pcmplc.c
@@ -16,7 +16,7 @@
 */
 
 /*
- * Hardware independent state machine implemantation
+ * Hardware independent state machine implementation
  * The following external SMT functions are referenced :
  *
  * 		queue_event()
diff --git a/drivers/net/fddi/skfp/rmt.c b/drivers/net/fddi/skfp/rmt.c
index 314623650a84..5708124f05d2 100644
--- a/drivers/net/fddi/skfp/rmt.c
+++ b/drivers/net/fddi/skfp/rmt.c
@@ -16,7 +16,7 @@
 */
 
 /*
- * Hardware independent state machine implemantation
+ * Hardware independent state machine implementation
  * The following external SMT functions are referenced :
  *
  * 		queue_event()
-- 
2.48.1

