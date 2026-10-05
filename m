Received: from mail-yx2-f0.google.com (mail-yx2-f0.google.com [74.125.224.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3A4CDA2B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215970; cv=none; b=uZTMVqebhuUPBIlPY6SS6zcPaPezE9B/8ozWJK+tKK2Xk7jP+cLzQSsEAENWhCxIkQIFj14JCfqfBw7qVy7L1hbnJRv8edJC6swvq4MGZYKl3dqfaRLICunPPbM0mfiOyWI8pF+dzI4uxZkntZiTu8MViO0xegQF54L/j6S8vQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215970; c=relaxed/simple;
	bh=c3qxAorHfh38vflfMPUBH0Ur8Gz0Oqq0Sn71Zrw4KYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2m3JYctWpGcthkXfCIDqzyBELP3CKesd+Ckp926ZbD3I7MHiPThdX43NZ8OIEFd3pPmBnFBU43T8AuD+Gb7vPIqMbrHC4RnHS5Xd3BsP2uXW8gjRe9X8mf3Z+Dg+mWHj8dlQnjDm1DjWeI9nHesexg4ejpx6gyMzV/M8CajBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDWMIqrP; arc=none smtp.client-ip=74.125.224.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDWMIqrP"
Received: by mail-yx2-f0.google.com with SMTP id 00721157ae682-8ae7b865b4bso6466397b3.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791215968; x=1791820768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ee5rySe2ispQ9mLUw+vla1nzkwDJ4O9A8IBEsYRC2hk=;
        b=MDWMIqrP33x78/GSVamq/u6qrR1gspN1BSGu15mQgrgvleWyfyJzpuD30+UjywurMU
         KZzWX/8eIaLnCFAEctNMmi30L1uKhmnIVVNOw1NFUGMfjXu5y7KoZL+T6zFPE6EadCXu
         oHQq++I8LA5g2SfHc2vojxFeNne5hmZKNMV6BVLquAn28EzCNsiAoo14A+wcjSsWf7C3
         9vae331YSZZ2mq8XzoA04J256uju/B0w6yIB/QGUQax9wYu7kPKki0kGfUenG9DTedKQ
         qX+8+lPy4aQx9Le1tTSJt4Z2QAaFzT8hS5It9DxPRoMOVNvSF41BYEH1mRgmRod85uOt
         d3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215968; x=1791820768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ee5rySe2ispQ9mLUw+vla1nzkwDJ4O9A8IBEsYRC2hk=;
        b=1DkfoFB0+Ag8N0G3SeiP3bD30h7SAOBwlW/W8qjkFQ9c1Ot86C0ACJ+Iaz7aj8WrI4
         O6qOgtFynBdJ2fhXnyeggYasmrbBdC2HdUzKwdo1vtZyHtjDvymQyVNsWHiaHo/GXVc/
         ZRgPaDxVftKsf9Iw38vZBCsnCCUKiARcPDcsASigZjr2qFmqsZZuuLRiQLLQqO7KfHX+
         df3liskC3b6kDXrzaEnfmi7wUsblbkflOy4PaEIOMRaQL8vVmfO3i9t0tFpyNB9lpRIm
         PGed0MakTz5KKZ48Oe6TqcmV4IUJckj5zN7Zx0Sx5GQCO9XT6HPqJRC6nQhe1jX6xail
         BypA==
X-Gm-Message-State: AFq9FYJ754IOL7nWmsTg0DMCUWpcO4Yea47pQ8/MAsqPzs65pYu9E7V8
	0PZAZNKs0kw+P014SXb3IVA4XmKYc8Qi1pwiMdvCco3BGjFF+GaLiHLaBq2f8D7np/kZTg==
X-Gm-Gg: AYBFou0XR+dLo/Qe7mFXJqs2i2lgROD0sfjZSbGvx4jy400J/IcTuwL0jTymp/9A9cP
	Zb/rRi62fPBVqOGVC1OtrkvQY5z4xBYL3H36KzePrrC+9RMWjcrGzLt5+HZl4zDo6oayvwCdNiC
	BWH3SwFjFepCI11kACaDpjC6knpVCFRu2BFjWB4yEeSOY1MQ0HL9vbr1jYW2yeYAkJ4mJKgP3SM
	Wcj1F9OiJYgFww2JxDknIZy75obKEUrpXg7CAOLlP7oHaQ0rynIC+Ycora9RcXgimohF3berYHQ
	k2oCqk5GkKwRerbboJrngnrIrNFjNHdlV43+tNyirvbc5U/YDOkDiGG6Az83ImDfxhtiwD4K7qo
	rs0CqhF1DkkH7qVKuewtAgu3J0ZfRO5REwaCn9+jwNk5qETpmZajOLMHCHiPhLi4EejMpso9LEO
	UWZ9+1E2sBN1VOsg9YgiHR2oVjeSxmVkKop+O9h79mr3t5n3W8BYUH6zUBLwWHIDMSVfF04ja8Y
	qRLGrujtn57OF1SB5R4C92AvcbqKFLacKl3xfd+SGqZMFV7tgvR
X-Received: by 2002:a05:690c:113:b0:8ac:42c5:a7b7 with SMTP id 00721157ae682-8ae39bd9f85mr47899477b3.39.1791215968309;
        Mon, 05 Oct 2026 08:59:28 -0700 (PDT)
Received: from Xinshengs-MBP.attlocal.net ([2600:1702:7d20:7d20:edd1:61d6:442f:e3ff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae8a2d41easm33779167b3.45.2026.10.05.08.59.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 08:59:28 -0700 (PDT)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	rfiler@sierrawireless.com,
	epasheva@sierrawireless.com
Subject: [PATCH net] net: usb: sierra_net: reject short firmware attribute reads
Date: Mon,  5 Oct 2026 11:59:20 -0400
Message-ID: <20261005155920.27735-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sierra_net_get_fw_attr() only checks usbnet_read_cmd() for negative
return values before converting attrdata and storing it in *datap.
A zero-length or one-byte response leaves attrdata wholly or partially
uninitialized.

Although sierra_net_bind() rejects responses of unexpected length, its
dev_dbg() call uses fwattr before that check. When the debug message is
enabled, the incomplete value may therefore be used in the debug output.

Require the return value to equal sizeof(attrdata) before accessing the
buffer. Return -EIO for short reads, retaining the existing handling of
negative errors and leaving the output parameter untouched on failure.

Found by manual code inspection with LLM assistance. The issue has not
been reproduced at runtime.

Fixes: eb4fd8cd355c ("net/usb: add sierra_net.c driver")
Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
 drivers/net/usb/sierra_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 4d3ed642b3e7..95668a5ccd5f 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -637,7 +637,7 @@ static int sierra_net_get_fw_attr(struct usbnet *dev, u16 *datap)
 				sizeof(attrdata)	/* __u16 size */
 				);
 
-	if (result < 0)
+	if (result != sizeof(attrdata))
 		return -EIO;
 
 	*datap = le16_to_cpu(attrdata);

base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
-- 
2.54.0 (Apple Git-157)

