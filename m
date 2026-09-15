Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533D3CBE9C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437595; cv=none; b=YCZRqIkxpEaG+at4lfk87B0DzesHRRK4Xf/uA1Sr1Qvt/IPQxzdkeXwuPdQK8Zd8H5elwsmeL57h8QbfkE7HWeTViPP9pClPfPZjWQ29ddUzrWLLdpLmGDxbU27EhvMez8bvWE4UDrcEkDV/5B/hBwmc2COfOi1eN9HbbVFLmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437595; c=relaxed/simple;
	bh=+uL7gF2g0/TZv16n3YoEteaP89TWBxkKh2ww7oIIoow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abLYhmJfSCB8vCjMCkTunaf1WTZGke56jK0eluJFaVcGkmBjhh7hj3KAF/eEbFStc+srsQT4grINm6AuYvcLUcX3yUZbD+WqyRwJzutYJXjH4mUPjc0GEEkK0KdFNKRqgDmO7dL5uOZ9VxEma96TMvf2i09nudFev/pLbJbJR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY29vr1J; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY29vr1J"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb4so384721585a.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437593; x=1790042393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hf+CFdNUbLJ7V2+bEHmHU2ffZSj8H/v1W4UactONX8U=;
        b=nY29vr1Jfp6DnIWUF8yhIX/ducD5FXkMuomKAeFlwF3N/leypUDzD8fZ+61WPVmdlK
         tn46ebkPqAcSMgvRGbVpenYNkwxAlcSltb8IoVYF+2P8wV3bvuyDrFmf/KdmykXpqA/V
         y0Vt+oqoacoR4XfogeCSp9CqGrzjAmx6gAELWudtVSYDMqb1I1PrAzSk3MWNHBhrAk4w
         qRgxte/JHHwLRplAzzLvjNf7/7ZkO67AnN7zY89hnlcmPriU6zz1t2eKe+DAi8B3zb1d
         JJO3I7DMU4f7bwKVAVxhFvMlOIQzZ3nF//gnKG3wfcTh3T+b8SjWX79PryYVaVAthXum
         Fy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437593; x=1790042393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hf+CFdNUbLJ7V2+bEHmHU2ffZSj8H/v1W4UactONX8U=;
        b=JIM+mVYnH1qCWiFcgbj2Wqs192ryQdik+7LWCTrOByGEeRe04dewg8eph4gsdoz7JY
         eYompu/CpgvkY1mOOliJaTtxh4ha/XVDM8GuGIWHkJFJy6PyW7RLuUaPJZY+6L8KnCe2
         8PTCLgjCzac58dXNFHe2kMrlpWE09c+DOX1l17Lxf+Srn9wiPCYXPlaKuRg3d652syhx
         lH6brwBFqgAXz4uHwPScmAf1m+0668bgSlf377lGlVeuXhAuQ1GQX9XRo3raIuecxd0R
         6iT/2ncL779ay0KZSBIAuEtYDkxNfHdOF0q3jQaFPnl2o+uzobDxMiYX+n94BKkqvtwJ
         gbWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpoNiggJ4R3LsXc5GRlS/CS+iyMj/O1mXzTk48C4WPKzHhrYpkPowMj0pGwiwBL9kS6hq+TUA=@vger.kernel.org
X-Gm-Message-State: AFuF++kUE610rGUSLy6iYOA7yb9khQikhJSEruk/f7bmuisnxCTbWaAB
	uESTD7p+eiAxjgJgTOxxNnL72gPLbwzJIiU4pZwYkxWUtKxl2yE7h8g=
X-Gm-Gg: AYBFou1dH0AtIjt2ZarrAf7QMxLgFrZ5NYf/J9cTK5NhM4oFYXDtgI7ues5bJtHPZs6
	J9U1X5q/DQkNkPTzH6SMPpBdZzLttnvB9u6yizKxjUw9Be44qxyzQXMqCkXQrjcWDe4kvnR05L7
	WrL8Lyv+zuaPBgq0lUq88sbDaZoDuHiYPcNcpFBOITu0VU+TNarYQeH30GXJH0jYILDOzTdVvOe
	HXsANFrV16NK+QphBJ7hMOxJ/CxnECMvDf94efYJh8wFPXoy2jKwGMoZp2+DxxnYHc9F5BNVu2C
	YioSwA0R58Snmy7pYQRkCXvGZM99tWYKgKeUlRrv9JsROXUClJBkb1RGSNvQ7iJzqj1c97pfFXn
	f/KJz1QnA6eobtz9Hhp0GS3aaihP8j5oc438o1xOGFq9b1LpQ8OP9l/QNNbmqAT4BIQ2mQ+P0VD
	iSqWbMaLFsKHbahxcigD7HRIejj+mEmo6wUme1dFzjjp4vcD0AkTW1RDEJRu37/bjQDUIWv3eNG
	wkK13YF8u/d9U2GhoVH4TEgykuJC+goJ2DMyvCKYV+eZbV64ihW7ugwKDDpxyCyolKUp2NOftW1
	8HgcLRnb/ql3Tg0tx2CZmrWATrttqrJCEAA4CCQUiRD86xf6y9/kpv179I8oV760KF/Epg==
X-Received: by 2002:a05:620a:1a06:b0:92e:520a:ffab with SMTP id af79cd13be357-93a29a07d87mr837367585a.38.1789437588673;
        Mon, 14 Sep 2026 18:59:48 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e807eba7sm1137116085a.29.2026.09.14.18.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:59:47 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Kevin Curtis <kevin.curtis@farsite.co.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: wan: farsync: Disable PCI device on removal
Date: Mon, 14 Sep 2026 21:59:40 -0400
Message-ID: <20260915015941.86661-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fst_add_one() enables the PCI device and disables it on probe failures,
but fst_remove_one() never releases the successful probe's enable
reference. Disable the PCI device after the existing interrupt, tasklet,
mapping and DMA cleanup has completed.

This issue is already present in the initial Git import; its pre-Git
introduction is unknown.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/farsync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 6508c53..0ea6372 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2561,6 +2561,7 @@ fst_remove_one(struct pci_dev *pdev)
 				  card->tx_dma_handle_card);
 	}
 	fst_card_array[card->card_no] = NULL;
+	pci_disable_device(pdev);
 	kfree(card);
 }
 
