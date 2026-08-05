Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEB40097C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922911; cv=none; b=obzBRYisPKqix8+E9bqRP3SzzfE9vXCo4+pVrSZl1VWCi4bTlQSX58wNibrJR0gLtMkuIrHc25ukSCY7lXqFDGphK8/LplOOaejYHQgex1Q6g3TO9pcJuT9llb5a5hfUQ5BRAHQl35gOojg0VaP4OQxWLAodKUUqXiGlzitZxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922911; c=relaxed/simple;
	bh=gKhD9uzcTs6ZkGqBbh/L1p5FfLiWUK43uRNvxA1pEfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+xizv/7h5dfiEuRYnZSsMmxSu+aqrxXATRZNadbjL6039QMDR0XMcpwdZiKdiwF482GzssQbUZzjXuMbbQIv8hxO7jf2z3zLoDtvADcWsEDypyoFPS9SqK2VN9jKJfu02hUXnXid7QtpXf3QbWRF/fxE7tb9KEdzBqJ/wO8j9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OPFtnBT/; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OPFtnBT/"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7eb6573bd52so585350a34.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 02:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922909; x=1786527709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qjJiLC9fkagfT2Fe4y8Vi9rY7+5d6Oe0cJwGKTVGzJY=;
        b=btYZpMxz2wkMNe7VukdoVixyEcoX+SbUgRdNJ7MLfR2ep9bH/2MDlrXynYbDecgTqO
         tjJe3+Mmqrz+7ashdLmGkxo8eyi2+I8k4DryafkXCNZBYA9ohTY3dpRgUUsgfVDROnLK
         PXWL6uJcTJrvyNNFGb18RQKqEX6/WJbQp1riqoLQxOc+EhGsSmuJS3cIpl5GsAJiz37W
         Tb1nlC374StGnjdx77W47AyLzJRGbX02SD1WeurA7E57oswzQh0+OXEOACu6CbsGTpAn
         poENPCZMB9zewFgpKuY/V6ICShnLiwcrT3Wq/asyMTVwwPkLraq+9TMjS3yt3ZaRgT0H
         lcgg==
X-Gm-Message-State: AOJu0YxRE9LUbIFGTSdLXOjkVlMOBuQyD0tW43xW6G0amvFhSZxM3b8T
	co9PCfY9WH+enZFJjWzv/jK47YvKAvn2RCg3kGsMrEL6tIpyA7+Gr2w8bjKDncTLpLH6oey2/4o
	IwHBqV+1OhUFDSpj2SVN+2p2+Q1uQtqM+L1r5FHVNPUl+zwGJZQkU4AVInUBPOE6P6oW3KxXH8W
	ctqYJ0ZSNtCPgk26Po/bEAc1sRf+lfSj7nUkFI/z4iIjYbCIlI1loFXB+ZRXMKn0bUoPkleC2PL
	xmmyVkVnh7zwmG72Q==
X-Gm-Gg: AR+sD13VEY3pvGG56a3v3gspe+02lXJC5GjIclbFJGWVIKQXFKzJs5exg83Uo/OZ3BG
	lps4kL77cl/DAnBw6XrRt5JL2t5urLvr9ZPICpjLO/b3a5WejdNyEvh5e6DPkl3oQFpm6LXuBqr
	g4ao0ojft6PGe0EemFzrWGgOf40SODYC48qo3k1f2vw9hWthpAQwwH7aW8oJGCprGlvI36aHOS+
	foIDLC0/MNlt5hbds3CTh54GD4C/jdQoa3av8W3vXHdZlPJfIo5Y5MRmxReEmH8X5ugsIIzMJcK
	Z1diBdg9zlo3SWTAlw00HZ3hsRjSGh4d478rtp3HCYj2Bi6sgO/F1cJk6wb6sLCqmyT9fl8yAN7
	JE+leRa6TFMnrnPhpneYQSH17XjvAbk8t37Zu+bZlmZ3+bZD1f56sUg/HqSE+iCgoO0w35ocT/t
	xU2lqJeWAwFKsN9IVCzmN4QEnOFPNu5lT4UTNEDU4JGg==
X-Received: by 2002:a05:6830:3889:b0:7e9:adef:4fd4 with SMTP id 46e09a7af769-7f1e5e1e5c9mr3691180a34.11.1785922908961;
        Wed, 05 Aug 2026 02:41:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f1df55e29esm415240a34.3.2026.08.05.02.41.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:41:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so1323809a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785922907; x=1786527707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjJiLC9fkagfT2Fe4y8Vi9rY7+5d6Oe0cJwGKTVGzJY=;
        b=OPFtnBT/dBTlbKL4vg29cqOvjEVgpJ/Ydz2hMmHhbuUsL3r+tmQNSu9Kc5iug2yryi
         awven/1zeES+pRTOH4rjhFWS6DR0MAfvFl97nMAtElLWh6yTn9gTaOWrSrsQGMuGyTkR
         LKnPEDufqgziHJ7jZKiRemfIM4qkb/JBJhSNc=
X-Received: by 2002:a17:90b:1e53:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-3903c5501efmr4607404a91.3.1785922906943;
        Wed, 05 Aug 2026 02:41:46 -0700 (PDT)
X-Received: by 2002:a17:90b:1e53:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-3903c5501efmr4607359a91.3.1785922906445;
        Wed, 05 Aug 2026 02:41:46 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca92ada6sm12358662c88.15.2026.08.05.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:41:45 -0700 (PDT)
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
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [PATCH net] bnge: Fix resource leak in bnge_init_nic() error path
Date: Wed,  5 Aug 2026 15:10:22 +0530
Message-ID: <20260805094022.15487-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

If bnge_init_chip() fails, bnge_init_nic() jumps to err_free_ring_grps
and returns immediately, skipping cleanup for RX ring pair buffers.

Remove the early return so execution falls through to
err_free_rx_ring_pair_bufs to properly free resources on error.

Fixes: 23df6aebf803 ("bng_en: Allocate stat contexts")
Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c2e865f8d9c..a4288f0258f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2820,8 +2820,6 @@ static int bnge_init_nic(struct bnge_net *bn)
 
 err_free_ring_grps:
 	bnge_free_ring_grps(bn);
-	return rc;
-
 err_free_rx_ring_pair_bufs:
 	bnge_free_rx_ring_pair_bufs(bn);
 	return rc;
-- 
2.47.3

