Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEB4503FA
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525041; cv=none; b=Y9uo3gw1xv5tyiM0ofFvC8eZgIgfrZ46wQIoDMiESDYAup/SlYQ+SACd9WGfWSvz/KmFalYAAEaEi9g92IjxqkCnjHzJfQtFQFkdl+RgrDT/qK0EMz+70XXXJTYFlmfaU5lfOfZOB0cuA29Th9acIfOvdIrsYEiLe49SFPzuC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525041; c=relaxed/simple;
	bh=cSeTe/7ue/PJkTh3HAQDPlgacK5xqgU2vePXNUiF7T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH00WUqzy5cBWiigBiGhHqpSwOOyMlAxlU6WtV3NeC/nmB/ysFr+gqgMzNNowZ7z/DN+dgYwSBgiRqeGyFZyGaPfkKSqcumI0XghpyYNdx04qDR7rt2+rRg1F5IvRJa13x4Gl14GNzqYnKvD1ro2/ar6T+B4UJ/1f5QbwWg8xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gyu+6u2c; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gyu+6u2c"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-7389cff36bdso433416137.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525039; x=1786129839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oBLUnf/M4QJM/XerNH9JctFhChXIJGp99U9nmkgibc=;
        b=Mf5/RmbcmzR/Tfmal2AtJ0oDErL8xrybirNNq2naP0TAbJagWGtnllX3NqDgtQ2W7X
         QjjwlrCkJRNbK1vAumkhTWxjV4Eo/IRzpH9kut5Tp9r0WEYIGZ+e7GUckyu1I/9+HmgT
         YfXuz0UnKXQie7s9RgzNusrH+noqLf3I1JsYqIS1aOeiZsGeuPDNQ7jLHdQC7wzCCvJw
         tZFwf60DsqabipNphPKNkfQleNmxTo6dRddAIdcbtO/CoH81TDGjMXSmWTefwP5XGPJK
         kCpEK+8c6/b3vyIqCtSdhULoD3SxJZ4V2lIy6gkg2YrN1w5ijOuiQM9LUDu4sUNz+Wkq
         98Fg==
X-Gm-Message-State: AOJu0YzAXO8zyS6p7dAHvCAZi+18UhOz8XiqSTo21TUeAHkQBC8eeu06
	Xd9eCMugQSJ1a0sgAF8SsAhtE5ubVenAMsbocngdjVMR+F9laSjJhxZjCGqzx/dKaVLCBTXnJ8B
	3X8W5ugHhdOmFxXx0gQ3Yyq0xFAG63G7Tp7kVlz4vSjS+3YmJgu/Vg1OSeHE5nggE3R5Xptn0EB
	W36bPz1eYWWcDQNkcqmYq0p6AJc0C5Y3XJ8P1WCGe/o4ym+Z7ZLCG1ETbQoRAUpK70lkGJUBKh3
	7D/OTgUqDQ=
X-Gm-Gg: AR+sD10LQpSA+zllgbCzUTaoBapMo0bT4SCk+4qr0zIiLbcvACvbny6CGHT0TtFWNle
	2/tq1pbgEFhgoTz60HcAmntZ+74vEshBjfuiAU9Mv7jtmSMk7NoVizRF59sbPsKhhYTs28j9ejc
	zUWEzqwX8Ya+S6yGgbYQxshQUrmpr83Ak5S7V9le2uN9LvNA6R/F7ywDX2Rtg0x5UE8/WQVE+Yt
	ulOGk7lm1n4EWuhyKFVFHEY27+CRHZRhWd5c29QkO62bhOVki4pPuGuimVF6eOZ76dtVZfzAuSZ
	bp6Etjhcrx9R+I+l2W6PfdTmFQ3bXnm6UY0UdZdJ62j4fKxyoCqjawPhLo4jIcfr/gN1tzwaorM
	9Tefjjb/8RA6N+I6I/ZAunsRJ5zrM1/bNjr7TnAW0ZzIwcv9qfJ1PkdPLQkW13jcO46CEbsPC8V
	gJxuaueOPeaE6cgGhixS2Cf0YzAX+j2INLVXs=
X-Received: by 2002:a05:6102:6892:b0:738:be7b:add3 with SMTP id ada2fe7eead31-75b21d5d57bmr822201137.6.1785525038670;
        Fri, 31 Jul 2026 12:10:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-977eacfe625sm61080241.0.2026.07.31.12.10.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:10:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2118916a91.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785525036; x=1786129836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oBLUnf/M4QJM/XerNH9JctFhChXIJGp99U9nmkgibc=;
        b=gyu+6u2cUyzF+vTpu7If69poudTX2lRiuyM17XNV5HS2B3Ha2eV0wNtXg9//iJocSt
         Qa94Zna5mf2m/LmSlYEiKfX9ljhTErrWuvpZqezSHGfsb8b4Rn9vhL1zdFKvAmjnfLdk
         w/hU/FnJOQ/NRwUTbAujPL4jMzRj+1xlc1r3M=
X-Received: by 2002:a17:90b:5403:b0:38f:81ac:e1c8 with SMTP id 98e67ed59e1d1-38fbc54273bmr852394a91.38.1785525036384;
        Fri, 31 Jul 2026 12:10:36 -0700 (PDT)
X-Received: by 2002:a17:90b:5403:b0:38f:81ac:e1c8 with SMTP id 98e67ed59e1d1-38fbc54273bmr852377a91.38.1785525035950;
        Fri, 31 Jul 2026 12:10:35 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8667714eec.10.2026.07.31.12.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:10:34 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 3/5] bnxt_en: Refresh VNIC default ring on queue restart if needed
Date: Fri, 31 Jul 2026 12:09:35 -0700
Message-ID: <20260731190937.807270-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
References: <20260731190937.807270-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shravya KN <shravya.k-n@broadcom.com>

When a queue is restarted, refresh VNIC_CFG for all VNICs whose
default RX ring is the restarted ring.  This will eliminate this
possible FW warning caused by a stale default ring in the VNIC:

FW reported unknown error type 10

Fixes: 5ac066b7b062 ("bnxt_en: Fix queue start to update vnic RSS table")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ff098d959741..97cae19643c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11098,6 +11098,11 @@ static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 				   vnic->vnic_id, rc);
 			return rc;
 		}
+		if (rxr_id == vnic->default_rx_ring) {
+			rc = bnxt_hwrm_vnic_cfg(bp, vnic);
+			if (rc)
+				return rc;
+		}
 	}
 	vnic->mru = mru;
 	bnxt_hwrm_vnic_update(bp, vnic,
-- 
2.51.0

