Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169143B5820
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133114; cv=none; b=frZavqq6+oeMQG9rJgs1et0VqtzRizJe7blj971jlzfoI5vClbghDUBnrxDSAAJhMrjs+cgPhYb3kIsHOGF6eTPAvcBGAdtX33GYNIyiVKPCrf+rs9snOriQtF+a1u9tWSFNJRaJLtJ6mskbfx+f3gf2qMZioPKWDDlX64gIDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133114; c=relaxed/simple;
	bh=6LSdRyI1a8+RjM8OUlL/uRa4qcy1C1V+2Rpy+ji4r54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlJJRLLAkjhyuroOyEzb/SBb6WXfmcEAkR12FoguaKBd5enE3aBu2qkLH4pULQGSoRJOCRn3PcJNW1n01vvSMmbONcOdPy3Ebf9NFfCJK2NXCouE5q97mYKTP2hDljUhPiq2Oyjg8lD5NiZbDObgz1pKCNj8o2DY4z9+OtXrP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fu37WhOp; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fu37WhOp"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e985106c0cso2899505ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133112; x=1792737912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZyNk37UsbYI/nTh5O/ADoyezfPGkUF9C2TiowYCXXM=;
        b=CXsLt08lbsP3726yfi7Rg2+ixYZt4IVtjYU4o4E6OUEK3jQ27hiyLH0ZNOSOLsY0b+
         KTt0L4g0hnbnHi2nX3ojYXWPeAncYyMHSzsr/OjsMqTnKydB5YRlsAnGWyXhNcu/e3bN
         ILGeOLAJuxJMCYySgnRARanUgCzqW5mMimL25/QD3hg/XYtVMV+BX8mqf7NrWFgCAaXK
         FR4g1fcoMAnX6vwmazQHRu5YtZQFm4q2UlWSd5vLd8niK+J02IdER8SEq3lsqItprl9f
         pZ8oDn7wUGvPeRb7MU8QCx93dq4ME40/GScMoZVHg6K2o4RJ1S30VCVxKd+3Ywk9oe3Q
         wJTQ==
X-Gm-Message-State: AFq9FYLLSoqQN9sQzDtcNCOh6TQmtdhe/eMNaBkFC4nGqz618LVoLxOI
	h9GHWPKaj6jEGSSQm4rNiYBcAyT43lcPb7A4XSJzXYJ6ivDlvBSSgL+VoVb3KzZXzyazt3SC5SK
	71Tp97wtgq/DQttUF7FipqFmIAPbaChDsNWECZLYG9I2NJK3e90ugBEBY5dIFXEz9xXiknfT4TT
	iSlZjXbWRIhCcIjdA6En40Ja0qMQpprfRq7jTgM07CY+5wxlXwIiLMU8shTecybl28KD40ydxhi
	wbaPYnxKXM=
X-Gm-Gg: AYBFou2s2Bo1z7wH8NkkQo3IeTlnAxeJxYG/22NEmr9j8KJ3r4vZSO3HmF9r1M0nTek
	MDhzpWITF3OotANE1JFgXBoynXplbr7vmcb2ebdixfNtiPNVdACyHM/DqGp/L2gIqD76ndE5gOf
	FGa9psJK6QGBPOxwdCA7Mx/kQPW1dAXD7A6gQ+9hnk0OAB/XoSHKdtpkm+hsBcWT1OxwRw3HkCb
	CmGFUdptuaTLiGjdpQxEExeVAwhmCE38IKH+hwYzYT+tLmB2trg+AR86g2pJEjxGaDG/GxALaZN
	eEvxIL9/Gkh7j/59Opy2WlQbyrsaUwY2I3tIFhmry980+B2+FkK5tbUkgtrsHFeMK+Kajx6Ala9
	AfhXxVzQrx6yXzWk6LxwFaYzV1o+8tl/KACvjaR60zsNq7H06J+JQkGFG3rvMpXrJcJBpgTfWvi
	/78FG1ZxQk7NHG+7O9FB9B6a+MB4U1W3ihiVS2aw==
X-Received: by 2002:a17:90b:55c3:b0:3ac:3e42:60a2 with SMTP id 98e67ed59e1d1-3ac3e426341mr9524513a91.33.1792133112140;
        Thu, 15 Oct 2026 23:45:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbe52f169sm1252358a91.4.2026.10.15.23.45.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso10850290eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133110; x=1792737910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZyNk37UsbYI/nTh5O/ADoyezfPGkUF9C2TiowYCXXM=;
        b=Fu37WhOpCsXGOfrijIXWtscEFlyiU1o0pbzGvuUg9NCvmgsmhsYv/fMUiCd9+AFtjI
         Zhx3pbFIuhNN6jvyddon3yU2wp4GrG3WZNJptsczXh+nzul3YD0rhgVZA5Sr2ijW56iA
         o8JLBaWCWOG37pXwgRxRHGcicxkvUwLqh/KLM=
X-Received: by 2002:a05:701b:4212:20b0:168:e942:4e62 with SMTP id a92af1059eb24-16a61789c56mr29462493c88.40.1792133110352;
        Thu, 15 Oct 2026 23:45:10 -0700 (PDT)
X-Received: by 2002:a05:701b:4212:20b0:168:e942:4e62 with SMTP id a92af1059eb24-16a61789c56mr29462462c88.40.1792133109678;
        Thu, 15 Oct 2026 23:45:09 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:08 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 2/8] bnxt_en: Fix bnxt_reinit_features() when irq_re_init is true
Date: Thu, 15 Oct 2026 23:44:21 -0700
Message-ID: <20261016064427.496944-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016064427.496944-1-michael.chan@broadcom.com>
References: <20261016064427.496944-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

bnxt_set_features() takes a snapshot of bp->flags, closes the device,
and then blindly restores the entire bp->flags.  bp->flags contains
statistics flags that may be cleared and the memory freed when
irq_re_init is true.  Do not restore these statistics flags until
bnxt_open_nic() reallocates the memory.  bnxt_open_nic() can
potentially fail to allocate the stats memory and the restored flags
can potentially cause NULL dereference of the stats memory.

Fixes: 93e90104bd12 ("bnxt_en: Create and setup the additional VNIC for adding ntuple filters")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 19b4d3b92352..2eb9fa21eae0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14091,7 +14091,8 @@ static int bnxt_reinit_features(struct bnxt *bp, bool irq_re_init,
 				bool link_re_init, u32 flags, bool update_tpa)
 {
 	bnxt_close_nic(bp, irq_re_init, link_re_init);
-	bp->flags = flags;
+	bp->flags = (bp->flags & ~BNXT_FLAG_ALL_CONFIG_FEATS) |
+		    (flags & BNXT_FLAG_ALL_CONFIG_FEATS);
 	if (update_tpa)
 		bnxt_set_ring_params(bp);
 	return bnxt_open_nic(bp, irq_re_init, link_re_init);
-- 
2.51.0

