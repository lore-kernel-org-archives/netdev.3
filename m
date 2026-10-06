Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548D4A0915
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303837; cv=none; b=YtjDj6pOwM7pg8itFCKkiLP+XyNDOeWcr1CGz7jqBHwE49bXDe6VbPopvRgESY1iU6AQW9cqsTjtmUMmQLTUC6yAs4fDhDaQGmZiydydZpBDee6EyN4DxCkVYbzR7viX37KEReSetVOBp3I/3FnnohL0TY3Vq87siBSEnvf7piY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303837; c=relaxed/simple;
	bh=VxMNyDoWxVlJ7T0GoD5YGGuBg3vpoeSHQkr1MLBpXfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhIE4hTIu4/AXc2Y2gm1WUT4jaQNKlcVlCCWS0btvyVaAwqQVF7dVjJDxtg/igLmJtI3ZrqGimB8ksg060szSlf57oElZmOy5J7QVp9tuR0DIthY3AT3a8K4xxDOTxsOkqpvqSeMBExKCK6CF1qmV1l8TRXLJopvXxFN+7UAu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cm6wAsod; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cm6wAsod"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1057827a91.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303833; x=1791908633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fd78CaQGDmDD1ZFQcb9JSvynsD0IJAgYRm2QVzW7Ldg=;
        b=CpgJ1IxO+IBMN77VT6Ebrc6zV0/D0opxJWfmzJKtY1lzYCTcTf7UV+7U1iMHkkoXP+
         RUYQz0nWA2iRz4tf/sDvuwugIZfK/zWoE4yf2ac10cegPTp5IQESKe3jkhcQvvxo49zX
         w3lmBKTUm+a+yreFKp9lcG970a6EyU6SKPrvMarYZ/Hh8KMB25hQFeQATK2PkPmIGpYF
         lNXMWM9gPlCKymzd1OlXy/0R198LfHsm0pVdUvIIdZDzjj44F1W3uxu8eQWmaL6oHHox
         Ka6TD/mAT5ybd95VN9nEWG/AoOe4sc4XfYiLesXt3kHpKmoxwOd1eJtJl/o89UVczyO2
         R7yw==
X-Forwarded-Encrypted: i=1; AKwUvBw3ysdYI0pGIAPapHHRNvlpTUl+Vi2N9epglqJjn9XvEkSwXL2XITonFv4OyqYYGndBw+AniSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJntRQEnPNKH6O9UwqZ+SH2oYRNqua5kUFwdgC0IoPNJN72WhT
	IojFnaS34ncVieJpq2/Hyf/LTy+TMfYbNGc7jySkDl90ws9ngfGtxhGN7TP2rKm0YDwdq3xWp5A
	C77xlsLh58XSphAUot9gXRYM/gWmLZ9idA0dLiS2AVeTNH91s3aQkvGYQdBAoUcSrsQyASjscIg
	M92xvU0XWd5lG3vReTGn7WQ1XlT/wnxPNxD5oBoBwgkAoTs+GlwvXhfXgCZhV5jYa1RY5Ggw2yh
	fZBu0HrUgw0
X-Gm-Gg: AYBFou1ksspU4aPR61/u7+A70Ybs4KQ/r4Q9g9RBMBRvzOE331o0op3+YUWKHE9E/1e
	q94EedwoMO17o8yI3tURD+3lhTsHXDMsU5KmIN7A7n99wLUIFAIZiiMiD+dYkA/AA/fBX5a2ykU
	PUpArPe6B1u9Rzr53Jd7Q847oDQqXCu+J4krHGzHAkuGSTdog6pyO/K2lVsfhfXpQCHE9C5eyiz
	NmMstD6Od6ouI5EnrqToUpNXwygWjf/z32q7sCS1ijq+5QpTHYtP/UzYU5juAplzW+AYcYZaw4/
	co6wvuW/gAoM6IZNHoC1yIU8hz6RhfrIhZoRBejc0TbKbBBJtsxaN97N6+v7Thp7wXB7zxC2Ym5
	puKdgcDAvWd/UoopqIz7MNxuDJK9Mcw48yrcHwbcjtZ2kCer5vQrSqtCp/sRVbt5bwQ1R8kPaey
	jPOq/NFdqlNgseAJKqprO3Ref3l0g7V9EXxg==
X-Received: by 2002:a17:90b:3c11:b0:3a7:9413:cfa3 with SMTP id 98e67ed59e1d1-3a8737a3725mr1322577a91.55.1791303832451;
        Tue, 06 Oct 2026 09:23:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a897a1e0dasm84251a91.0.2026.10.06.09.23.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:23:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5337f26ee19so84932411cf.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791303831; x=1791908631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fd78CaQGDmDD1ZFQcb9JSvynsD0IJAgYRm2QVzW7Ldg=;
        b=cm6wAsod7QzwpvP+UScMzoULxd9+GPD36ZF45anzBL37elGK3nyZS9QYL0dF4D7mqg
         jGkFVv0uO+9iyVsv+HcCxNKBjH1aszrFZmza3Yjo7jRWHisSjhrrLRhJmZlhqBKdDXJ1
         UUEO0AuVQAqX87xn/X1olFL70TBZQ3l22kliQ=
X-Forwarded-Encrypted: i=1; AKwUvBzgf2/2XoblMyV7rbH3tZQUQJi6uXP22pcZeY8dUHxUybeWPP65bs/Pyvkr6qNUIWVnCsbutgw=@vger.kernel.org
X-Received: by 2002:a05:622a:64a:b0:532:18a0:491a with SMTP id d75a77b69052e-535671b6c03mr33111151cf.60.1791303830352;
        Tue, 06 Oct 2026 09:23:50 -0700 (PDT)
X-Received: by 2002:a05:622a:64a:b0:532:18a0:491a with SMTP id d75a77b69052e-535671b6c03mr33110691cf.60.1791303829742;
        Tue, 06 Oct 2026 09:23:49 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5356b860df8sm9020961cf.14.2026.10.06.09.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:23:48 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saswati Das <saswati.das@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [net-next v2 1/3] bnge: Add infrastructure support for RoCE MPC channels
Date: Tue,  6 Oct 2026 09:12:54 -0700
Message-ID: <20261006161256.1493672-2-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261006161256.1493672-1-siva.kallam@broadcom.com>
References: <20261006161256.1493672-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saswati Das <saswati.das@broadcom.com>

Add the initial L2 driver plumbing for RoCE MPC (PRIMATE channel)
support:

- Plumb BAR1 through to the RoCE auxiliary device info, alongside the
  existing BAR0, so the RoCE driver can reach the doorbell BAR.

This will be used by follow-on patches to issue RoCE commands over the
MPC channels to the firmware.

Signed-off-by: Saswati Das <saswati.das@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c | 1 +
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index 0955b488b6fe..87ae40eab592 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -181,6 +181,7 @@ static void bnge_set_auxr_dev_info(struct bnge_auxr_dev *auxr_dev,
 	auxr_dev->pf_port_id = bd->pf.port_id;
 	auxr_dev->en_state = bd->state;
 	auxr_dev->bar0 = bd->bar0;
+	auxr_dev->bar1 = bd->bar1;
 }
 
 void bnge_rdma_aux_device_add(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
index 6c5c15ef2b0a..13cb9289f5b8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
@@ -46,6 +46,7 @@ struct bnge_auxr_dev {
 	struct net_device	*net;
 	struct pci_dev		*pdev;
 	void __iomem		*bar0;
+	void __iomem		*bar1;
 
 	struct bnge_msix_info	msix_info[BNGE_MAX_ROCE_MSIX];
 
-- 
2.43.5

