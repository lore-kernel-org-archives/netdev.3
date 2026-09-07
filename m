Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B17377ED7
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756416; cv=none; b=OsnoIIJ9/EsahaleVqyuNiFt+SQiKHQ62jJV+1/EZ9Dz2rFXXOY7poVn1Nn0pA1y6LqAUNiXCbWn7oFbFpJw+MDSBqpjFjIxWxj5gpeYLH4e9uwbAIJ3ajSsLDtPpqAiW+8xtSvXI7M7DgBe7jC7R4RdMlxesOxPg6xIp1RZoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756416; c=relaxed/simple;
	bh=6p6f+df7snFRvPwjOFv6KgfQzHYAQCGkqU2mMZozh8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5IYc/zsbuyif2tgTsl3b8vmB4P1r2UXo0NSRCDDeH/vxa/e9jPu7odBaq3MARpEkyb7BEyaLVYjxjRt5hsyCLZ6/qVWBqDsG5CPqdm72VaPSeGUl94woFNMsD9tIHkZYoRMFDYP/pOqzRUT6Phr2p4LkYxImpFrOOHy5c5tzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPcRYs0j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPcRYs0j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d94c868ea5so31579295ad.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 21:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756415; x=1789361215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=igwbwoIkm59vj4ArfYtMkHGEc2L+jTWh6hxW3NeB46o=;
        b=EPcRYs0jmy1DiFWPpHzhxGGDukqApEn75U15wXRo2Ds9Rgbb/RJVvr25gRmEmrVNpJ
         wLpAdzb707URL3dI0VbLqvZRDWieNlrQxIQntAE02QaxJAmn9+/MQGRAS95mODfW2h4p
         sMsYlkwd5cEq/6jlZQ7C127nxNqEUSue+KEuyOQ3hkAwcgpDhoEEoJhEkyXVyMWeDJUw
         D+I1e3N7wEnAhXmxFRA90o0DP2kzirfJNHKYS2nujJ6BhbEbaRWKavl27C5Bb/ID3uwI
         nmR15L+Z/oBs+jwyYorWKSnp++euNCt9acmt9S4xdPun5A8hgesdYsQLMRjODpcmtLsB
         biAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756415; x=1789361215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=igwbwoIkm59vj4ArfYtMkHGEc2L+jTWh6hxW3NeB46o=;
        b=fdP3mbfUVr6iWbDgCy7vA/ALiv3acwTgFDBNdg7i3WIfNtYYyG7TV9V6qKgFrYFlfO
         mHOoZCFvINcMfABOkepdCrlMc7L+KWUrjEX/3dsPRsNFeTd7+TVoybHxyqIWQP+/mGUW
         7lzQsS0KGfuBEc+bM8ts0uUcVHg8sewi5O8732E1t8SMZlR6YSM14kOZlDJni/ql+kFL
         R9/xEPXLu1HpesgV8OPQo/9LAM/QkyKLizMv8zxJzsQzlXjW11Gwd+4ImLnUlvra66EU
         q/miLsb7CDYxufXJm9A47N4e5QlZaqpvkvRiEBl4gp7j7ZpGNigyBon8/QmvxzewThgg
         qbFQ==
X-Gm-Message-State: AFuF++kXH4l/O+Fp7ukmIkryaWIoxbvyvTlIVcG2aBn7zm+qLMMm13W/
	uIjAVB7Ye3XvS2+Zo5NO8c7ggyTeqDmrenWR+FSQep/zrOF7XdJwdXUK
X-Gm-Gg: AYBFou26RyUwysgXnb3Dx+5j4gXxD6obyxyKpkegZuqPLKlpkGDijuwXdapXgyF+5Pw
	FNobBfShQ1erokzFrSkSp6S7Nmq/yRHPgbpiIgPkgJYUsBKFuS3tpRzDLESzUp2eouUINDf4JSg
	Weo6DUKNWeIT4J7wUKkCMZpKnRV/5FE0g3ZDY/Luf5usWOVNPaWTYfg6gDqKEu4aIKOsg55zL7T
	k+f9SSa2FMGJbb7Z/MegTrwfjRC2B8MMgq57PVzhDOQHdB13UL1o6NyhxBlR2uVMy3YilitXvrF
	GsG0rvj2XYTBHyr37oTbN2x5HK1HnP2rUHh+JspOERudPUluCWqVQmm9lUpG+4Y1RkpKJIHE0mm
	ahnQF2Buutiq+o231bwPAhEetSXUPePAfZNelKB3WcO8wH717WcPFRPvdk4lm3V3Ai/WLBFikLA
	aCyY6v1GcB8UwXx749dwmOhRR/34wMzgFuDKtk+u9iypDFQSCKJueRX/cou22sPPLz+aKY/TVSj
	VVohbheo5IFjl9mwmAHPnKw
X-Received: by 2002:a17:903:284:b0:2d9:464f:d45f with SMTP id d9443c01a7336-2db125ca396mr284219835ad.5.1788756414805;
        Sun, 06 Sep 2026 21:46:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37844565eec.16.2026.09.06.21.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:46:54 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 2/6] net: broadcom: fix repeated word 'will' in comment
Date: Mon,  7 Sep 2026 10:16:31 +0530
Message-ID: <20260907044635.7141-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044635.7141-1-hemanth.selam@gmail.com>
References: <20260907044635.7141-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'will', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index a2050083048b..28ea4a33f245 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -280,7 +280,7 @@ enum {
  * (db_msg_sz 1 << 7 * cid + 0x40 DPM offset) it can come up with a valid number
  * We must avoid coming up with cid 8 for iscsi since according to this method
  * the designated UIO cid will come out 0 and it has a special handling for that
- * case which doesn't suit us. Therefore will will cieling to closes cid which
+ * case which doesn't suit us. Therefore will cieling to closes cid which
  * has least signigifcant nibble 8 and if it is 8 we will move forward to 0x18.
  */
 
