Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BC22D4C3
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744651; cv=none; b=j018oCpVAgzIjGLPyY/qEce7ufZQ83+bTc/1W3HGP0jyY1IwQpR6JGItZ/6QRdHIwIFT9JIFLYavWbYH68MocAg/6TtakHKuCIhv3wu4WKEgwe/Q105Tlo//WZwPd3qD1xxbj0cu0Xk2iVUHlEYNY/X8FIQKR0M0tSxym2pWI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744651; c=relaxed/simple;
	bh=oNrurkOukbDe14TZ0qVzJNwxCeIQGO+QGwpTQDKjujA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7DP4ecxqJ0zyinuTH+u07gokzSqeP+m/NEuInx8mjUL+WEkvym9dJ5on3hUA+rpJuIqwKvubTGAtl9Bew4GOBamzypgrBW3SWMWlzs7aZMUMikQOFjHuE4dLSs0yQYbX0BiaN5pOYPHYp8ZbJP93Op1+dGda+uj2S/jaRHLdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xz5udUfk; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xz5udUfk"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-92e50a650a0so91961585a.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786744649; x=1787349449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5dga7Ak0VsESl318ftDpaJHRk5JGjddnwIvuooYKKto=;
        b=ad13FCnCPgD7/loXSRRinjzNK7fLjlfvpbzlqJGLNZlKViWwvIx7BFINpFrBFRHppS
         ZK31LiHUj/cREP7RdjOIbibIdqdufo0ih7m+BMq6COHcMkk1/ou1G3VMj5m82hIv2wK3
         oIeNCICI7SIPNlQeu9NACuTOh8Q1Xjlvgsi8LFUyCT0XaaPe8VuLT0CimFtMPM42dCaS
         kY/TTxWkZBrSAhfJ4nmvC84Inds7dHPUfBUMPcQnjJu8pXFlkEphMF4bKDa50CH8/064
         CMQs69o9ri5F8KqsSaC4zps9+eTiv3O2OosfUHrRV1tIk/NbCj9ppvwxkcoIYOJ1SPHk
         Z0eA==
X-Gm-Message-State: AOJu0YzsE4Tzxb4NTIkbD7kTGMm3Z/tXdYy2rNNxQk+pd/eG6vBhPktQ
	ucMkyeX6cggP9HJl4QZp404Z3b6GokjfRlBZXuquZZEjnVHtRFjypQM5dDAZ0LYTFVdTTuFfD9g
	pwWpwg4ddRWPE5HwmxkylvYTk4wqxAeX74ecKN/xuxsxKXucRlo+SJDO55H/JLfu0u1017pu2Y4
	k0g4xbZhNyy8RlCMGW8WR4CtN09zUlQOGZhcVINcGzSuJHwN6d36vimwx2+whDZdSNt7EFYuhP9
	ILCsBUhZek=
X-Gm-Gg: AR+sD12DQzbP77Af2Cm2Hm262OSmKKzMwKDqZ+3FX625Kl44S1CPXnkGGxMSxgEdqAo
	snc7rXkqWxQ0Qss0JOTIe2x9C10BpZRqy7SirHFTqmb3Vrhuabt3wbDJp0GcTztoe786KEaeiY2
	QZAUuhp+pOhdpbLSe6Cs6pkZ7UMUQd+hoZMgJ+TVYngD0e1vrPv7FoX0Rjv6JA8SriLCdmZWQXI
	SMEhqMf0WvkKX7f5R9AG514UZtLky/pnzVeCwzoUT4RUgLYeflp6ghYm+A3trcxqhUAWLrnHBYv
	IKCTQYfO0ZKzFuDtaDE1DuJshbb7gQwOBxQwyzPvZGamMSkNLUAekksn6TRmMqgyV3b6k9piq9p
	Gfle5k9Oo/eru+tckM9Vo9AzI1+TpeUnJz5e31jWMzjSm7LEXOhBhvb1g3Uf0UqWzbKcgWJDE4N
	PP5c1IMqCmcTpIfDV9LEKHvZTvZ3Tfwpkm59Q=
X-Received: by 2002:a05:620a:8325:b0:92e:e376:cf97 with SMTP id af79cd13be357-936d23c6b7amr872618885a.44.1786744648644;
        Fri, 14 Aug 2026 14:57:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-936ce1ff59dsm112413085a.7.2026.08.14.14.57.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 14:57:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso1021850a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786744647; x=1787349447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5dga7Ak0VsESl318ftDpaJHRk5JGjddnwIvuooYKKto=;
        b=Xz5udUfkSdmrIh5KKH/kDmzDvbjrihMod2vvxD5m0cDAaVVniBCxz/dYnawAF4cFf9
         RjTvuXefTQDn6qCldSEGRSXd8Qw2Bo2K+rfFmedjrG9nemMZIEhwoOiI5AIGI7fV5eIH
         xffHu5Cd71doF5rq4qWcFW6xZ3TVyjJNVce1E=
X-Received: by 2002:a05:6a20:94c8:b0:3cc:4d86:389c with SMTP id adf61e73a8af0-3cc71a68040mr9800933637.13.1786744647044;
        Fri, 14 Aug 2026 14:57:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:94c8:b0:3cc:4d86:389c with SMTP id adf61e73a8af0-3cc71a68040mr9800892637.13.1786744646613;
        Fri, 14 Aug 2026 14:57:26 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ed5b1sm20289431c88.8.2026.08.14.14.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 14:57:25 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net-next] bnxt_en: Add missing NETIF_F_TSO_ECN feature flag
Date: Fri, 14 Aug 2026 14:56:55 -0700
Message-ID: <20260814215655.2331655-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

All bnxt devices support TSO packets with RFC 3168 ECN flags set.  The
CWR flag is replicated only on the first segment.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1e4944f3e606..dcc8c802951a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17102,7 +17102,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
-			   NETIF_F_TSO | NETIF_F_TSO6 |
+			   NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN |
 			   NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
 			   NETIF_F_GSO_IPXIP4 |
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
@@ -17115,7 +17115,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->hw_enc_features =
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
-			NETIF_F_TSO | NETIF_F_TSO6 |
+			NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN |
 			NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
 			NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			NETIF_F_GSO_IPXIP4 | NETIF_F_GSO_PARTIAL;
-- 
2.51.0

