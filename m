Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAC4746C4
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714859; cv=none; b=NSaLb9QeeZCkP4j5gCy+G5kEY9v7cSHsiXKopF2i57XCnPq6ZPxUg0MNqQ+cXU9KfCwrrY1Q+Ry0GAMUUlE3vpM2vutG7IEQYH6cGO877/9PxBLmnUrp+dy3PTlb4nyg6C7YGjI5xwOTCWbR2GN23bh96V3cB37NVOu8NMnNusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714859; c=relaxed/simple;
	bh=bfr5UQ52z+ob0i0GfikTYdIoHwp78ufkfUxMioBpH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBuSAlegynpHw0DaQbKfJ77k1SfyrQ5Ryy8VwFfMzs7hYdt/OKSCrQKA/jg/RGBrsZvTACRoxk01cX15D4CbmadMapWagj7ndUjUblOStuEY5+/0BLldsvjd1MxleCp/cqR+Sc+zwEIOoldEr+zR/lNfIneU/THzSSqrmff/iSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxxkdqfP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxxkdqfP"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso939435a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714853; x=1787319653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7lYZe8NGu+MK4GxONcPyD0+PJYVMFmf3DLvaElNpb94=;
        b=QxxkdqfPH1Dhu+NOUkKRMI+xxSzflkL3dbtPRfju6AJ12RNeRD9eRMLJUTuj9U/43P
         8gJDTCiyjugBj/zTTVK7m+VRfiXj1MoO95FhSePa3T5IFqphVeHn6O2WVOUXbde+KMv6
         KwRuWBHgFCKBupqMWQK7icaahdAAliGpVuH1Kp3P5+jmyC40PKyvkApROwm1gTniGLzi
         qCNtFRRlyd/IJaS2c6CLCY//cbm6iy5xZ+NSoMeyHTpMsprb6o9kyDWDbfEYLj4FIDG3
         orFrtmszWGy9eKkmQkX+11iSmm0g0Z5dAZpa0+tWwJe929ZJ+aRPA1Eik2Hmc3bJ5SN1
         SCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714853; x=1787319653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7lYZe8NGu+MK4GxONcPyD0+PJYVMFmf3DLvaElNpb94=;
        b=DW1xpa9ExP57RyM99CD95O96ALevhzLiN9/iiZqnnNeZcrQN7PbeEZ3MVd6c7Zp24v
         dsdcClmYyyH8vLTlvTj26dayHPqR3IaZiRtBT487nUgMw5clGIcxtpbyOb39QhsqRyMP
         Y2BrxYDptVglZGIZO/lERFlh44Es9kxeouWzuudgM4DaQ9uZHGN+IgMCe1bOP0+6jOXM
         SIRGC26m+LARIoLBcCDYOA2OEcUgG5kz/Uuo0zAwcgxeu7c267tQA0UB9HMLuTHdimXF
         iZ9iZWJjG0usvNQeMBHyQodxg8WkKypM9XFoCt0sRhNv4pVTBE1nkxqu4Zz8qlQ3ZEe5
         //2g==
X-Gm-Message-State: AOJu0YwUuoLr6vI5Td/AhOYVu7c7mDr1nq28EEijIANWtyMwdp0pVHWC
	MD22VgqWyYV4ldy7RnkR2ldCXdkcU1fE0M3Aee5o2uuZ2mUJp3yJYf5P
X-Gm-Gg: AR+sD11Xs43zz2zcZIvXJE0C0pNAd03t8Ff8U2Be04PQLne9Dc/OYBZYflh0GPhtvdh
	QiEa6ruU0guAqpraokMZ5V6EmcbwVlgGLUX1crMjmJvhavYVs+RrTP+SGMY2uCeNI8kxOkwqy22
	WaDS+hsYA56FJ5II4Je4a2T2n4kJO6hcZ1KfclPWUH0IfIbC5Mmh8/LiIk4/OwZQOdWNTFQLgPI
	vqIDYepSS36sqIJ3RhEVwOzCv4jnqWrZETVKOzXNMcbNDK3B6RYIUixTj/uyfIVyszZlVwbYrDJ
	Gj61CTAqhF3FCQbvbD3TnFmylotF8n4AwDdH7dKnOBcRtvZK2ceA2wFSn9BLTDzPF14qkvLI8NW
	Y74p14rxczcc6eMSXOFWjBtK1nUqya/fj15HOT8hGP2pQuELbmbpxkN3lV+EBaw9t5VdguM/Lc+
	/bFtUa8JRMBJhPZqZpcvXJ6XZ1zaspZCv188D8ns+THz9EQAXYjDAw2lwrnzGdS/djOur/s+e4s
	o5FgWip
X-Received: by 2002:a17:90b:4c48:b0:38e:b3fd:d584 with SMTP id 98e67ed59e1d1-3933b0d5cc6mr4319255a91.15.1786714853237;
        Fri, 14 Aug 2026 06:40:53 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888d8sm2758886a91.12.2026.08.14.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:52 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: ipa: balance runtime PM reference on remove error
Date: Fri, 14 Aug 2026 21:40:47 +0800
Message-ID: <20260814134047.1387177-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipa_remove() takes a runtime PM reference before accessing IPA hardware
during teardown. If a concurrent modem start or stop keeps
ipa_modem_stop() busy across both attempts, the callback intentionally
returns without releasing the remaining resources because proceeding
with teardown could crash. That return also skips the matching
pm_runtime_put_noidle(), leaving the callback's usage-count reference
held.

Drop only this runtime PM reference before returning.
pm_runtime_put_noidle() does not request an idle transition, so the
hardware and resources retained on this exceptional path remain
untouched while the usage count stays balanced.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 923a6b698447 ("net: ipa: get clock in ipa_probe()")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/ipa/ipa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 788dd99af2a4d..aab38fea91c61 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -975,6 +975,7 @@ static void ipa_remove(struct platform_device *pdev)
 			 */
 			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
 				ERR_PTR(ret));
+			pm_runtime_put_noidle(dev);
 			return;
 		}
 
-- 
2.51.0
