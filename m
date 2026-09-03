Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0F4A387D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439022; cv=none; b=jKElhV9dMJtwimUAcNwoLHOnTIpGmEYlCXhanZx9+zbR5eytZ6v7vVjfguUwCn3MAGxMaWzP5DvazmbuKGf7gFlvw9LpAaFBCKjGRMv92qF5uH7RRHtkf4eJ3rlK1jfkk2inIN6OqwPwMhF99S/3hL8kHUvLbnZNDYgbE0Osh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439022; c=relaxed/simple;
	bh=2kqKYR1QUDhefQ9mtzEn4vrDPiegHctkgB7rCH0dTq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owuh9o7nAgP9s0tfClX9UB0435Tu3RuRCapwVL0OPEilN7YTM1DeGgZKX21zFqjfNwYXzIKtXrYzThgKjumO64KLJfjfwwYxXbNdGpyOSToKiIno9BKKAJ08rZ/ihP22H8JbnwrPfBmmbf7zdE8ex3dCjcNfu+UvWMyaWi91qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Bk2bCKt1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Bk2bCKt1"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-485852d03a4so246365f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439015; x=1789043815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCBxR++js24lbF6C7j/EAYfoUlbqxlXsgowc3cJHzVA=;
        b=Bk2bCKt1K3EamYdDQ0xWCH3FBDmcYz890ZevTPmvAAUD7yVqWEpuVE73qA/owJ51Fk
         1V3zeRVn+9U2DKFACDT7L518pvEIUxRtwaZZdRghwxYcEyEArNGYza3FKzJg02QWXN28
         Dwb/TlTrTB+dUByVX1YQ0Me4DJCtoSRSdffYDaOluA3EFG1iiKLGEOiFAExs+KnbY9/C
         aw98YDiXxV3zI8S3Zmv+i6VXxF8OOwXYN4zaj+ryhhyGTWmU7MHelwxkaBXFh9t5gSJ0
         zQ8W9418S1o7OAuWLgcM5xyhCf1tIqaMEBYVsEWijMIR+VG5/MsaAztr/i+2J7YIFKtZ
         n4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439015; x=1789043815;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCBxR++js24lbF6C7j/EAYfoUlbqxlXsgowc3cJHzVA=;
        b=pbJPFhgOp1W5UeJVnBpzyx+YqBLwGJqrPoQAjzeExIxLgY9kqVsy8omH/XWEZsbLh8
         2f88+PskDCzLBfDgLPW5kOGfAeXgGCfu9+N3eDgpJuVP4zSFc+8xt9d7gR4hzFJrx/ud
         +4PCagIZnVG71P3AS0Eikk3YRYJuYUcbPJCLfL+sjIGYnGzlWB9/0eFErah0MYJo7Zup
         8CO5mfjHMlTsWLmz+F+9FCG1Z63JtMSSsW4KdhxVsH0ggjtjsrLkRBz2rgOVvfCc++bh
         HFut5MBQv8rpZRbZu84aEvmUUr6toa0rzzf444YlmW8i7wY3IZ052OiJOi1UQs5jqm5O
         mpwg==
X-Forwarded-Encrypted: i=1; AKwUvByCclZxgqUTOaVV91R5On0XmLP0OmmfrmhZ2a0DTqHrDjpWVLtFU590Wiz1ncUgefPvD6EOM6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mrZvtZz0GyvEEKNFK4d86NVmU0nkWbS+AYaJGoaYvnmgEF7y4/
	dNr24GMgbOzdt7wPRKnE+Z5mg3wk+CfT2yTiE1Zmhth1qv3meqs76C3QZQmVYLOIpXM=
X-Gm-Gg: AYBFou0mM5x85xkzZKPyu9HkkF0TeU+wMES2KfHaNvlM0fnJOdFryU8HlVCpLiFK5Rc
	mcj8a3IgIV56FUwbP2Ex2A+6BYxt7NVYewEEoE0owe8ekqt/KF2YCXUOtQFlHLZkIGEMoEwDg09
	P+Df8Pir64qJzV/fmfGPEN2tisdWf+a5aKWnSQ/2cVWOyLrz5zG7dXHhW3zsAnI+cIpEhYbCNgU
	yML5GIImbKr62FJNufjZYRi+VCURM2kLzyKAOdl7fLMH8GKDQECbIZIcGbL7rUe5dToYB/HFaBl
	UHmcpzVNHNrC3Msz1m0bR+6XC9lINIobIRgz92t4SbvbetMElZS4BtOB6qbNiSTCZ454FLsLk1x
	UdAw+BhrGbBefWXNMpaYpQJq+pRsG+qXp4KwloKx6O1cY+hlwTrdBsw+loqYP+Mi5MoyR3cPrh5
	cBV3CcrmrDX6vj59Y9ntlPEKBHhNlMi+pZHWKhKPXJRkuxJ8R6wg==
X-Received: by 2002:adf:e196:0:b0:482:e451:6810 with SMTP id ffacd0b85a97d-48488dee050mr25646457f8f.1.1788439015587;
        Thu, 03 Sep 2026 05:36:55 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed2edfsm13223248f8f.23.2026.09.03.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:55 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Th\u00e9o Lebrun" <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: macb: zero the link settings taprio reads back
Date: Thu,  3 Sep 2026 12:36:51 +0000
Message-ID: <20260903123652.23900-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903123652.23900-1-f@lex.la>
References: <20260903123652.23900-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

macb_taprio_setup_replace() calls phylink_ethtool_ksettings_get() with
an uninitialised kset, and kset is not only an out-parameter. On a
fixed link, or an in-band link with no PHY, phylink writes speed and
duplex only if kset->base.rate_matching already reads RATE_MATCH_NONE,
a field it never writes itself; in PHY mode before the PHY is attached
it writes port and supported and nothing more. Either way the speed
read back afterwards can be stack garbage. The ethtool core zeroes the
structure on every path into the op, which is why its callers never
see this; taprio is the only in-kernel caller passing its own variable.

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
v2: message rewritten, declaration in reverse xmas tree order (Théo
    Lebrun).

 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506033..61838084989a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4295,9 +4295,9 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	u64 total_on_time = 0, start_time_sec = 0, start_time = conf->base_time;
 	u32 configured_queues = 0, speed = 0, start_time_nsec;
 	struct macb_queue_enst_config *enst_queue;
-	struct tc_taprio_sched_entry *entry;
+	struct ethtool_link_ksettings kset = {};
 	struct macb *bp = netdev_priv(netdev);
-	struct ethtool_link_ksettings kset;
+	struct tc_taprio_sched_entry *entry;
 	struct macb_queue *queue;
 	u32 queue_mask;
 	u8 queue_id;
-- 
2.53.0

