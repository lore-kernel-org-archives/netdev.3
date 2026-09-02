Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8F274B39
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309234; cv=none; b=RrBiLwHauxFSNt2hiSHqap+9n4JAV1DKN3G5h5c6eZSrbHdWlH8VTCO/KJRi4GodJKaWAi8c9uaKWM2DFffZYCvW0AV9c7d4msAdEm8rOhrlOWAf8/RfPcpsym25T2nLP3tYK2C9Evi/+OCB0q60rDdqN1DMvmUNTmkrE/HeHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309234; c=relaxed/simple;
	bh=TGEpHKExHlTpqKa1LaJ5ZclyTmgH8aMQuEyRzbeRmpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXTRO7wduEUblIlFPKYQOUC3ZgabBnUrjvXUk5h8NWmpq9FRXV5meg8aHTvMaX/QDmYouRa0q9APo5Yvbn8RUSnCmjjeNx7c+vPy/8E/CCGjMq4/rB4tKFaFwCa08cKKcS7skfEMdY+Jpyv3bgq7YLMwSZPND2p/hFGUGkKk+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+8IvUEh; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+8IvUEh"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93922c75037so71430385a.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309231; x=1788914031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/COFEFUUF6XuBqZQSq12yqeZNIpaTEXVYwzYS0UG748=;
        b=O+8IvUEhTgJJ38ZJy2RZJco5e2CycN+G2DXu2vdc1C1bhyiX2FSgPhUlofQ+cloIk8
         Zf3zKqTWAhco3cl0YOgUhEpAsMTLA+CZ+34EH1/590xAMtS1ZeflWam5IzxBHh4VibGZ
         SMpzuj1gIqqkrMGLivbG9bUySOU+Z3x1pMhNofsKc+kDrq1CVYZRCv2yZw2dQdh25Teb
         ZM3BKCBrTei6k5BgiQXsuxKgM3LfeTwFeBSokrSt+SYJwpQ5cR6RABzxXzOLjg5X6zas
         znwJqBM2KQNvs6k6ELsVciq6WEPWsNaKhHnYMfKZhq1NNa3JW02Al2N38nyA/qPqK57s
         R7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309231; x=1788914031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/COFEFUUF6XuBqZQSq12yqeZNIpaTEXVYwzYS0UG748=;
        b=XtIMRpG/2CY8qk2BITG8FB6XqhGbNrQQp301SUuCMogppFqGzCS1A2fI88AExOXW8m
         pPsu0e8akAK2AQu2mfBTXcXvElCF1QewUXI3YMKwFXWRYz5Jpb9bEiv2+C6IYme5o1dJ
         dAdhAIyhjCZSCZGjACNb1F1/qrA8Hj+Nh5ZLBEQu9vUlzxoHPI2tG4jEaGKGqLCP4JYG
         vkXN8YRlmePnqKEdshYi838MUIqhAXaGa206777Zmt5tRBrYuykAjaeat+PPzNJkBZ5L
         kA0HQxEdYK8oslLaOpTaQwn444JbJEw6PBAQ5BOE+pGsSyqrGxqG1EJBHIq3x+Q8McCu
         fu8w==
X-Forwarded-Encrypted: i=1; AHgh+Rp5UXtQtHroaG8zMic23uo8eA/ocv/sbTHt53YRbMLjUzmtam97eyskQvm/hFgqgcVvPo8vgHM=@vger.kernel.org
X-Gm-Message-State: AFuF++nXy+5zzeWx2HcfmHb7v7+kjatdvyu9RoyDVBR9+QVDrtnK9MDN
	hSeTMuJCV8veLOyXTv8q7VQ2wGbW4YPTcppRv4AzIxqHvvs6VAPKCr1nE9x44p5ai+RcxnYtfTK
	gcBYlCDyDITkM8A==
X-Received: from qkoi22.prod.google.com ([2002:a05:620a:4056:b0:938:8ae:b4d8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28c1:b0:939:7fc:cec3 with SMTP id af79cd13be357-93960ff9acdmr131052385a.41.1788309231054;
 Tue, 01 Sep 2026 17:33:51 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:37 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-4-edumazet@google.com>
Subject: [PATCH net-next 03/10] ibmveth: do not assume mac header is set in ibmveth_start_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d8887cfed1c4168684ae199bd3108..88e8bdfbcd11293d2cc0a36ebea6dfffa50bcedd 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1218,7 +1218,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 	struct ethhdr *ether_header;
 	int ret = 0;
 
-	ether_header = eth_hdr(skb);
+	ether_header = skb_eth_hdr(skb);
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-- 
2.55.0.966.g6673acef38-goog

