Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862B470E90
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265911; cv=none; b=A8Gr//H7zcEiSWAJCf57qz2/24IC2iYybBLkiKxfefHBXmTrZIDQQGwRfIH80K/OkF30O92AemtBESjUw3F218WbIXuP9u5xSLelTODOWUCGrWy2Q6xMlCiMsDdBLIydB/+0vIbMu+acdRREeMUpsucu2BNPbtoAn2jlrm/rQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265911; c=relaxed/simple;
	bh=2Cq26Os1YYml7ySX7sq0FFrtje2EO3bOEcgDwVVJsrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dUjfy4azJ0UkHlpb7j5g6Si9gOzzVFSI93FMSIBV4rB4dSr1n4lE0vjWJOQeDmANvoii/J/Z0lFtuoGK/CDsVVkD3UpgdCvLJLZ9N39+Lrg+ZEEutjCcUMZQ63gqGoKTIuZqChoY5Mp7KigmgAjs8GvZISW7Jkwaph3lw+bsaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fudapTEu; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fudapTEu"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ec58fa3e01so116399a34.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265907; x=1785870707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsgU+jaIJSPOtOW4fRT9Ixh2JPmbi7dF3B+OsSALrFE=;
        b=fudapTEuELG5NCi3gUdTrH9cMbeKXrFsc+5o6yLmD/PVgyVG81BGXT0WWbWCeNpMb0
         agBHo7YeaCxtZZcgNBPolOcTFknaTdJ8UZQ/op44ZucHowonok4Z34GWr/BR2laEybSR
         jHs2R7LU9DJlxVGNSfYGm8fvytPyTzSl87FtkFMiH9AYPYR/ytxhdzLVi2NoBwDgbG48
         ogBKSqFoTP9KeY9Q9eTG/ztdNjPn8e/zsjBAktHTNp1TveCXrJTWWGYmfkd0bSCDORp2
         V6AiC83zbV3hUYf3c3uTvEMldaHyeHnroicbCTObXX12fSRHfHreLpx+dRQtBcG7CbFy
         pRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265907; x=1785870707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KsgU+jaIJSPOtOW4fRT9Ixh2JPmbi7dF3B+OsSALrFE=;
        b=MvVcIbNeGBzmqoMf4vXgjzuFc0bEgdewWFG8tEy8AmNbM0D5MDlTGoLx+sp23YJ1jS
         /GQDBPE0P3NHrEEjF6ssviXFvw+raS1YIURc3TzIl8xmUSYrok5w+UxIXBGMOTV1iOUM
         IiwwUjg34yStB+ILtFIohaUE2WeCZcClRSCJVKH5jPDY2RfhG1XZAqeojS8/lOqU0ms6
         RnfMc01mAIZYbqemhJig5tx1Z71GRX6HmCaXfektFnNwVY3yYFi456AP/CqHE59mwYcg
         tTlhJa+CxBb9ivpik7ivAtatp4W790t8j+xnrw7+II4ahCjSEkKZkj2YYu3uphMitN3B
         mfKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3N+C+YYHoBJizMmkVJ/b/kirDv+p5TO54ItadIdtXmOas8j+Tu7gqM9CTthRexmJssW2pekk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJz5ZDyC8olt6Kmr0lGdXj/ie8QCLs1J+yIyXQRaf6N+AMiIB
	JX06iR7xCiohIGBTqG4IwqQgJ+chjCelDMTZi8d1Lp6yfAX1/kY+NdNsP4jzLgegGfs=
X-Gm-Gg: AR+sD12baJVop0RcK93Hd/WOORd2GP/Ct8uOplFMOCQyPFvx8vcLOgpUnldSEAf5bJn
	4YQrXKF1cIwSxyRiceVWTa8Ln2BoBpEvYPKu/k1rMuiS/wstMnNlHXLy0xAJxGV0hDPQtot+c+N
	L7kC44x32APeDaXkcf2qqT+jfFcKdLngTNHPfyil/kkjKVGzqKal/hwBtvt6fw8nHxo02JE5KNE
	a7Nm3bdzuTF1D6io0OqYCf/oNfMc2meExUxUtZMCnJkKV6nCipksvyCfLEim4UQJzyeL6IANLnF
	oInPbI80k1iSSTzR2fqqZdwYlugJwJAyGmplPkNG4RGonklQ7CgdxDpYJpi7PQn2fe0oWwQpD//
	gWWLeI8N2UAcVXStQOLdxesfEn1BjlmeCCe1f7DH9tbdqSEOCVYVIvkdvOOvFSRb9IKLuE0Eqgc
	kk3u3TA9GGYg==
X-Received: by 2002:a05:6830:6102:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7effeebf16bmr2243434a34.1.1785265907477;
        Tue, 28 Jul 2026 12:11:47 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d5f3aebsm473712a34.9.2026.07.28.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:11:47 -0700 (PDT)
From: Will Chen <will.chen.tty@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bnxt: fix memory leak in bnxt_queue_mem_alloc error cases
Date: Tue, 28 Jul 2026 12:11:45 -0700
Message-ID: <20260728191146.1744825-1-will.chen.tty@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a small memory leak in bnxt_queue_mem_alloc:
when bnxt_alloc_rx_agg_bmap() succeeds
but bnxt_alloc_one_tpa_info() later fails,
the rx_agg_bmap allocated by bnxt_alloc_rx_agg_bmap()
is not freed in the fallthrough cleanup cases.

Simply free the rx_agg_bmap in the err_free_tpa_info case,
as this is the only remaining error path where
rx_agg_bmap is allocated and needs to be freed.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Signed-off-by: Will Chen <will.chen.tty@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7513618793da..c30507dd824e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16267,6 +16267,8 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 
 err_free_tpa_info:
 	bnxt_free_one_tpa_info(bp, clone);
+	kfree(clone->rx_agg_bmap);
+	clone->rx_agg_bmap = NULL;
 err_free_rx_agg_ring:
 	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
 err_free_rx_ring:

base-commit: 3f1f755366687d051174739fb99f7d560202f60b
-- 
2.53.0-Meta

