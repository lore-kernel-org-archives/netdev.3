Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455629;
	b=HKGhhpOoynXNrlPIeK9R+GilbZt+YRqJ2llOoweWsNO6tk3z4an1BFh7EdDP2zhrpjRi
	 c5P2kB4aRleZpL3DiAJgEW2Bnd/nuiDIfWF+kumXxUJDjwgGFh5WB2VLhSiqhHeCewfds
	 j5YkjIdClwvcXrDYBfzJZGztNd+x2eom2JDK0esNBMSYyMA4N7Hu3dJTGlW2ryXYXSLYM
	 kat9APQZafIQLYzZm9KR5JJQrgPldWWUokbZ5Hjn9vDERF+taV+NuKNixT9/fLnPnZEmv
	 W1deVGWdJYX/+fVds4TdrTehrrdHqRFtdtHDgFR6gyaennr2jiYNL/9OOfx9/IN8xxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
	b=UIctoywtqhFLqM9ILDYgQnxLtr1OhOlHAuiF/k4sQSHnbkTLXQX1LO4bvZ5cybOYpNZk
	 +UuSIgxYZmIYgkBjRrW6qEfiDIvmD/VPiRLrHQwi3hfRMUbh/XUWEot0c3bKt/W6tZs14
	 z1MjS3b/fQmENm60izitOBtMM38pNkd5+wTSRN01dpkxcbv6cyIuEPDSNY6mOx3yM+NWL
	 R50tqr0nWOntN1DH0QErPYBv8cOY4ILfLs5j2iWT9P//NDEyi5AMBDjx2OJjXmApRJd5f
	 bFHLGlRkt6XNtw7OF9sV2/5dw1biUWS8nJCdHYHAfglOqY0vH/ORMJ/XJVpb/F7h7CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=TE84NacE;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2C606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=TE84NacE
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1791537a91.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792455628; x=1793060428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=TE84NacEl3T3mzY4W5rPDIpq+6Lfc1rNcOh90s8Y5vYh6NNcH93ogskkvSMh77tyF8
         4LgFPp6S8w3qhRfFgUZO6pLVeeEpPlMLrzo2n/BkMLZovv8DeaxJ8aK4m3wedYOi82BH
         ucyhxq8lB3pkJ7nIltsjr9LJGTBFRRQWYWF8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455628; x=1793060428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=eJNlqyjvRpISkZpun/+OcO/USG73wLGBh/ZBB+1hyStx4PWG0v480ZC8F5oTaex658
         0E8inXhynFGedCYuAzpE32L/whe85v51J4VkKwicdVYmMcczc3iumuIymDivL1plxqMW
         +A7cHHRUQga26hGW6/LqiQmavrz2ufe1fU81qS1ZHq1fRYpak3jCTcjVmmf57dY3czn/
         Ul/uCMTcKOY8ibMd7fROS4VUjaC7gggGFO70dTPJ3G3szwZQ9ijTI0FrP0B2BTMSh/q8
         QwrzYnkBMVgXxCJ1+Z8dOPBoFRZSCB2S764k359D7mMOiLzFEdkU+M/ctuXaY8MyMgFe
         6UZg==
X-Forwarded-Encrypted: i=1; AKwUvBy1RkyoF+gYWsVhwz5la2KxS6CJ5bterPJ6UvcphKq9QvzNurqbKcYZ6ijdNjZ4Dk/OTy0h4BY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNVn/k8lYxfr+bkL5LjOraPcBMV89s1bWZsAFV4kh/V9xTSFgG
	BDcjnf7dU9K1opwGdeNS8Pze8NLUujwA9BZp83dBLr7T7bOR7D6U1mu8ky53AxoLDxvTWL5N+dI
	4zMscnuM=
X-Gm-Gg: AYBFou1Psw6q3TGglzxBOYYXZLeYnj6qHUwP5OuPhmqzpYS5rHKxW7bH6Xr6KEznBtc
	ygZLjttHxQ3t19qEqfZ577M0kmGXngejtJ13BE281aT4GhJ6RdMJn092lFzPjcfLVpbXg4mgLl1
	s8lBLWNn8ZGQiHghFSh0G2GE4+dOc5WgqJuzRouydOolTcmAij5a+sEYX8oPrirnAb3QFAOoH0y
	zjgdG9RSEZoqr/AfI96zdGGQEHDEZ/bdTpvKp0ZyWawrnx5H5zeQFG+3/gPeAfJ1w2kPn5z/54V
	MB/h6+hKA35XucNl8LkJHgAagC7bPJSRbMIt5zOdl1loWPvGnz1xVPkeSOf978nTj9HdjX6yVmd
	SUgnDZ4uQweOxpYasJiSThqV/lFQ+NFLMXQHRut8ov5zKoR9MOsYJ3u1PqPwUkg+rY9oYHPb4+d
	JDPtw/ySWqCqpq2KW/nOXVB8ZNU0Z+8Q30p0wsZ4H7klBVvrQdGextBmRcIJMlbE3B4co/Y2Dw+
	V2id0wOQ4WrqL6XGMMzm1TCgB5XdTAg7iGg/vQflzcFZwI6X9PgUm2+fOxDRVdHt3SQv5lce8Bp
	YMOWVGihW56qLFv15Tsp3IAvXp0AKL/crYhO
X-Received: by 2002:a17:90a:d44d:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3acef19cb63mr7592251a91.25.1792455628530;
        Mon, 19 Oct 2026 17:20:28 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df89fsm1694273a91.11.2026.10.19.17.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:19:20 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Tue, 20 Oct 2026 08:16:20 +0800
Message-ID: <20261020001621.2920-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
References: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_update_stats() reads the hardware counters into an on-stack
struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
rollover check is skipped: the counters are still recomputed from the
uninitialized stack buffer and stored in dev->stats.curr_stat, which is
then reported to user space by ethtool -S.

Keep the previous values when the read fails.

Found by code review with LLM assistance. Tested together with the next
patch, which makes short reads fail: with an emulated device, ethtool -S
then keeps reporting the previous counters.

Fixes: 20ff55655a93 ("lan78xx: handle statistics counter rollover")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..cb8204371f5c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -789,11 +789,13 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 
-	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
+	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
 		lan78xx_check_stat_rollover(dev, &lan78xx_stats);
 
-	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
-		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));
+		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
+			data[i] = (u64)p[i] +
+				  ((u64)count[i] * ((u64)max[i] + 1));
+	}
 
 	mutex_unlock(&dev->stats.access_lock);
 
-- 
2.43.0

