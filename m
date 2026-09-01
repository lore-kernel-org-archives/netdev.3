Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5314A2A5E
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290327; cv=none; b=NQTM/sl3IGuOh1cbpjKcoodTL03N2qiyBoiRdeNEsTJI0lBCvVeyZizPsInpvuNkBbLoBJw8udOSKqwDGzQw3M/ulPSKd9gFQLU3OG8DjWW4R/bZCUP0AgjHc25ifJs1jwc2EKd1rHXScdfkvYKKRBNjYjWdZczSvBk9LNN1Tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290327; c=relaxed/simple;
	bh=ct3wjDm9DioxEoU5z5Oc8L7zod1x2daMyErzOnMcehk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4IQmWwDMARrBb8+Rq4GqMNxswmORCNs1/2QRnmXoTJ9xTmz9KMsS7/CZYmeYAH7JjS5ef5/0cBYZ8cpPdXVwJlUmkThaP8qNHpLRR1eb8twoPMAQLD7PGMb+J/cbQCGwVUrieBAefx4XQdKp0G2iHL2f3PrbPdsWO0PO/8Cis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DRqJ4cJq; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DRqJ4cJq"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7f3ece23165so120894a34.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290325; x=1788895125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8eXtyQc0pvhajUfFg9n3BqpX27RWj/RmfivJgYatSZg=;
        b=AmWly0cNq55aYNG1LRgo/XuDkeXfAQutW3fEVawGHnaK7i+GvlZdX/lBMl7NY/61AJ
         tHVgIV0mXKmZcn4P3NlEU07Z8GduYgNQsHMF+kejAErKxQ3hgwtfAWliiYPno5i8WIeo
         wfQNaJ5COzZuK3Ixu9TRC4zORBysq1aKQLWxzNR7DZC0htXzyWqmVfIqhsZM2rQPGDpd
         rpum/ApPPQDZP6T7ytgyDXkEQVtvKd8CjEH8wrNK3pmZkTQgtaX0kwppn8ahc8yjo+55
         /MIPo8PS8FQ5GjYOP28IPYrz/zh3al4/M5gnk291JZ5OSh7lUAkqWx/58g5JY5fxq7rH
         E0Kg==
X-Gm-Message-State: AFuF++moMwlayh+N3C3e0IOCltwxWSiNRaQsrPioUzHy63kCoAo2rbQ1
	vrBu4J4okW5KFIDrFaySW0Tbw8YPMI6rPydT5VCVy7x6ziJ3zfo8fNzBS3sce4HWXnVqm2ejoiQ
	L8eM1iEv/NeWmWdrOefgHZMBQJzVLsyk1NdPksIKuSxOBxCPz2VfniScOl223rl/NLDjEuRochg
	VY6hRIBJwbVkVrVdzTCNdL8ZcVdQuz8ecuRr2dUBBMPm8GaIpePmvAiTVFAcWwiNNFCkSqMcHV8
	OKbZER3ijb/uLGz3A==
X-Gm-Gg: AR+sD13RLUwjiJlQ/Tyxbt8+9GRfkZ5Gg9ZkJpkqYek8UJToNlyvgjOMnwy6jjsySc1
	5KNeJmrZ94BPi083dhJzwBJ47wo3YdosR0PWCzCR2YyXx+jFTzRIr7yP/K0iAupFq2etUTObHlB
	MnpEeHmjkRocXl6fiZDwxDl7Uft/BRt2UhVIZGEw9yL8Do/SOxVvAlvGpE/oz8AUYpkhCybPBi7
	jRwos/6z2OciFW2+19K7fzp2QgQ8Tt7IZE2yeWZPkCzx7yniuUyHp1Bix3oh1POD5Mhqb1pBZ2D
	Mut/m9JRMWfVqVHb8fEZ9EPBr5no4Zf4tOoM+nD3qvhzpDKX/Durc/OSHVk+3Mpm/TtJ9dyV7Ys
	Bst8ICYEHzc4oDqWMgp9exwylhoZgIi69TaxEPA9YwF86sK5Vka2pJWZ3/UeV2k2M1kLKgIsUQm
	jrG5C5qQA9xt8SkPoj7sckYF2xrZdkmRXkC1Domq5D1w==
X-Received: by 2002:a05:6830:83a1:b0:7e9:cd7a:7c34 with SMTP id 46e09a7af769-7f4f23666bdmr47278149a34.10.1788290324776;
        Tue, 01 Sep 2026 12:18:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f74f5f11e5sm18867a34.7.2026.09.01.12.18.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d94f086fedso1725205ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290323; x=1788895123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eXtyQc0pvhajUfFg9n3BqpX27RWj/RmfivJgYatSZg=;
        b=DRqJ4cJqjknGFxeE6TL7igw/LDuPQfLUyHzNNAV9jPM6AZMBw797Q3oAXw8j4b8MU3
         ZUjb+BvzOd/TAAwfIK3zRTbR/A4VDo4MwfkkY7G9UEs0AMycHino4hHklYHkX23NhWU2
         R1+HL+q2tuBZnbK0zl1TZlvdsWz7Ft03PC+fI=
X-Received: by 2002:a17:902:f68c:b0:2d8:d4cd:dc8f with SMTP id d9443c01a7336-2d8d4cddf3dmr351189055ad.18.1788290322852;
        Tue, 01 Sep 2026 12:18:42 -0700 (PDT)
X-Received: by 2002:a17:902:f68c:b0:2d8:d4cd:dc8f with SMTP id d9443c01a7336-2d8d4cddf3dmr351188305ad.18.1788290322387;
        Tue, 01 Sep 2026 12:18:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:41 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH net-next 7/7] bnge: Process async events while administratively down
Date: Wed,  2 Sep 2026 00:47:28 +0530
Message-ID: <20260901191728.643212-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Restructure bnge_sp_task() to skip only periodic stats via goto when the
interface is down, allowing it to fall through to async event handling.
Previously, clearing BNGE_STATE_OPEN caused an early return that dropped all
async events while down.

Additionally, add a netif_running() early return to bnge_report_link() to avoid
updating carrier state or printing link messages while closed, while still
updating bd->link_info safely in the background.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_link.c   | 3 +++
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 7 +++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index 3b0dfcf27376..31e2ede2e537 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -402,6 +402,9 @@ static char *bnge_report_fec(struct bnge_link_info *link_info)
 
 void bnge_report_link(struct bnge_dev *bd)
 {
+	if (!netif_running(bd->netdev))
+		return;
+
 	if (BNGE_LINK_IS_UP(bd)) {
 		const char *signal = "";
 		const char *flow_ctrl;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index d11c404acd4e..49e27cbc6394 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -394,10 +394,8 @@ static void bnge_sp_task(struct work_struct *work)
 	struct bnge_dev *bd = bn->bd;
 
 	netdev_lock(bn->netdev);
-	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
-		netdev_unlock(bn->netdev);
-		return;
-	}
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state))
+		goto async_evt;
 
 	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bn->sp_event)) {
 		bnge_hwrm_port_qstats(bd, 0);
@@ -405,6 +403,7 @@ static void bnge_sp_task(struct work_struct *work)
 		bnge_accumulate_all_stats(bd);
 	}
 
+async_evt:
 	if (test_and_clear_bit(BNGE_UPDATE_PHY_SP_EVENT, &bn->sp_event)) {
 		int rc;
 
-- 
2.47.3

