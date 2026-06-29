Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA43FF8A4
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736414; cv=none; b=L9cGRWUx3UMefXkamnnzlQn0BenlwMDCxwcw3BzxNBwtPPCHeBP1pxCdIRhW8eLg2QYrP0+T23RU552UKwT+Iq1XWO2ZuHueB+z45t5DAr4G/2e0tYJSQtZmdswPKPvB992spYqzW6OfQWKgsWN3Prb+3kZCMI5ZnXTTjLU/AUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736414; c=relaxed/simple;
	bh=to4R4ee8k2o5804/vpzYrLJhMjVE1Ml1XXys9wSRdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZn+4fKa1JCFI65cR68gOq6i8xKmOu5NDYWjQB/uUpp96j8/E21gZxIrqu1QCWV5LjPz+QEUqhxBekOPsIMSLJC8401Bcoi1qvr/eLTrzHtbRctYBWleY1KTodpnIbA4COZV47fVzDzNrdhEewbMgiehZYy3h7WZb0IKp2RnGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP82+Ly+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP82+Ly+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c126e47a82cso95924566b.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736410; x=1783341210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=qP82+Ly+pTyhNmHfZVdXAkqPPxuYMLaGEYeFWzOyAq29zwQoqp+uKOlbqywHHMqu9a
         nx0If8obfUutF05+AzCXfgdR3ZBshK5+ljNNRdXccgnQYMCQYJktM/nzHvGgo8ftDZGo
         G1OUezFh6atAsSgf7e1RqDrYuigwFQ/n8jcMbPPNgOzihyUJvo6QwxhE6rerbga4TZTm
         0t6+8yEPhxtxaywRKdIhUbxd5suOJqq9i1RaHkdbKGkMrC/4K9/2aweb35O5GutGGOvX
         bihLa7SiqLIn89jC9eSAFZKTXj3pzjw0vYUZOXLQsTy3mvZ9DmrhrpYgrIeNxRpXUeE2
         Y1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736410; x=1783341210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=HLQxLxtNDZE5Y1SHjdmpDtaGu7hhP5VVEjlosqXjfl55z0yRMCFDX5pxpXw6VsyL9g
         bUpO/wINJQeQ37PRdAqb8UWP9Mk9lKQziuqI/3QnyHsErPHIbp3qFHPcRfVFymUfOg7z
         uraAdvhL+lTgaNCULDROrZ0qoKSgfZxNHdM0HzOykQKjnqUh+g6C3gFaarsNo8XMLQCd
         IfXzj0T6u5p+5cUv0wxCbD46QOegE1Rvfz3mW1o2g9cJRuEdOOiTFianeSJXHTRun0jS
         0UFj607nqGX3cDnMLA8kjh2RQm+k0G/pN5147C7a0l2IleJIaYJcfMtpw0z9TZEN9xsU
         qtjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsQ6tvmZvM6P4i/J1XpbWidxcX/lK08vAskVqNBa7gP9XttJzIYd/Wn53pYxCmFVxqUIucNi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrr5md815IdadDdv8xN/Te9H82rmzPt4VZ7+hI+WGdKmAgRLgS
	QAUpmm285Yks++eCn8bIRz7RjTfBJleShpHfYc62y2UdQTPLtLL9iSYS
X-Gm-Gg: AfdE7cl83vR57mYWWYHH3wa0GTAJcxHOYmw/Ke2mEyP+GRrk/R9LMLiEbM3W6Il+gpG
	O2S0yTxFEfXX+26Ju4HKUgVKtRYYLu+/MRyYwq+YQQroQttTZWpJy9zjFRw++DsWo8rnj2exT0K
	BeOyepAXTOqTODHkn+sCcBw4bkKrIlrLPCyOlWp9ECePpxCr+K8HhSO5Zhi/Y5d+xukxwB1MR18
	6RDwODg5nDFFeyKk+8SoWZ58oac7e86jnSZc6AU6sH3PmJTndoq1KEnpwzCD2SlmrI1tj0+6NER
	63qx17y6EEDvVzpJhKZ0khQADGiNN44opR4KcfLtdyr5zh+WYudsWLgKHRFPBf6lDJ4HHP/1I1a
	QQDh5lf5V2BNSFD2eYsxX7w+t2ovgI44TAvtg6I/oA9/dUorE2TB8S6KhUhS8uZyv9ZS5oau29Z
	vVoG4LaJE=
X-Received: by 2002:a17:906:6a1b:b0:c12:6b39:2211 with SMTP id a640c23a62f3a-c126b392346mr184315266b.43.1782736410170;
        Mon, 29 Jun 2026 05:33:30 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:28 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 4/5] netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
Date: Mon, 29 Jun 2026 14:32:52 +0200
Message-ID: <20260629123253.1912621-5-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629123253.1912621-1-pawlik.dan@gmail.com>
References: <20260629123253.1912621-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Chen <rchen14b@gmail.com>

Without this change, nft_dev_path_info() hits the default -ENOENT path
for WiFi bridge offload via WDMA on MT7996. When a bridged flow goes
through the MT7996 WiFi device, the DEV_PATH_MTK_WDMA step does not set
h_source, causing the PPE entry to receive a zero source MAC and packets
to stall in both software fastpath and hardware path.

Based on a MediaTek SDK patch by Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Signed-off-by: Ryan Chen <rchen14b@gmail.com>
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 6c470854127f..580aa1db3cb4 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -219,6 +219,10 @@ static int nft_dev_path_info(const struct net_device_path_stack *stack,
 			}
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
+		case DEV_PATH_MTK_WDMA:
+			if (is_zero_ether_addr(info->h_source))
+				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
+			break;
 		default:
 			return -1;
 		}
-- 
2.54.0

