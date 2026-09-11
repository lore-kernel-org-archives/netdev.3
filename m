Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544E44F56E
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114552; cv=none; b=EhYcTjHtzwf6C9O7EuI4JNZR75WigMEh25kWlcUKrl4vt9c/zKYJtuzycAcm8lwVhfe3URFS7PAvlk1gxcflhZGcJzMu4IjKvgCrCOKZs4RSkYXvOWBqyxzyl3sbFDMnp58P+HoUop9TYgwgYz2ckOUU4LlxWIWwK4qSuR1IpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114552; c=relaxed/simple;
	bh=J6q9EHrfbJVo8kVqCaYkGKEF3G1EcWWL4QKywVpxoO0=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSE7/qU29nzveCTdpWJ0lPY5PTLkqcC9JMYd+/oshTDu3OgomVr88iXFBQVavVq6IgiF9vIg7HE3FTBX763DXgXHnHF5guLvrUE4v+D1tcq9gIQg44huqADMZdExqJ0gZfD1dMH93Y8PZHaD6NT0cZ0ASH48j/VhWuEydA/LCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=BGyob8YM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="BGyob8YM"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0248cfso736645a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1789114550; x=1789719350; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rF31rq5u2Ejrgd2GDHtEaw5FZnwlakbF/ays9ggaUPw=;
        b=BGyob8YMIxRBck1yY+FVKozfN4OcZ17/rHcdHopvCs41KYlnhvyoocP6u3TZTASJUD
         9GxB4PcW4qXk8boTLkCsRILDH1HzyMVYw4ZN0Qij5OUr0wiNsngAmhqOGAMo3j7lXXYJ
         S0UYc7/8yJyfE4/pP0GfsZUYAnTg4J6YyxKtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789114550; x=1789719350;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rF31rq5u2Ejrgd2GDHtEaw5FZnwlakbF/ays9ggaUPw=;
        b=YYsBvQQaoqzX2MeAY86F3UkX9cg81rvV+9K9QA5eLwqaIAZH+5wl2/nQCr5Ezn73jj
         31FH4vVAQQketFfliJFHAHUBuGBqKdc9orKQwbkz8oPazVluI901mfJHZkv3xpsyFIlM
         EoFZvRCSUAT0qrJbepcMI3wjYxUCIrjPyfG51DqdNtagVJqgsfgrDXWJu6rC1JaGf9OL
         bdh8H/talHhXog6x9NGqKX5P4HzJSbIw/i2lmGtsJS+h1cxykTVKdwoZRlHp3ccaOGjG
         QZQXAGed1sThABtBFecVCYr9C8NXQ2rj13gZnN5v3KkBpkIPDbi+5XWy3NmsnJVQ7hr1
         y09Q==
X-Gm-Message-State: AFuF++kKTl3JPpLQUIAZ9xgfLG4ZK/AH7lXvFbVf2QKZuPtz62DbUNTT
	e0ujxPGgV8jKPpJBevYPDj9Y3FTXowQU7ywM7QhItyxiG8kBOrLsw6gX0SGZYoZ6lZ7HGU/n6Kv
	6HMWHi5cJaw==
X-Gm-Gg: AYBFou3nQkof2+36pJ0qbY1Brnvt322JEuUH/PIQLwSEtdQ+iScnBnZyhL6EptTVjfN
	y+atwhCWjGWyrSwX0OKKhTuN+PAf6qpdGKhkD8LzGxAsnO+vbHpzztQujiYuXL/y4obyOct/CwC
	sttyw4w2crBaYOB8U24qk5p2IsboO7wai2qjG1zOpn8KaEK0Bf5GWSAz1Zzm4Ruu0PVlwDANO1/
	kQyp6vt29qSnpavs9wcaSZ8JfwydbEEz9iPmsDvhzIfJX5xeHfin3FgUSS2oottXX7uZPbJ0U+t
	oNJ6L/Ihp3agkIHQg5fO1hjHRVyGNpqFprGNU/88jhhfvIRUm5lbxm/H23OVfY/8/mra6A9/vlS
	tuET/2b6F7pZZ15o+HHQaMRUKbVbfDbJGRrR9Ke0kRYALWpfCMD3ba/ifyvOQuUFirWKWnHXvo1
	Wafr3yBGcwXxFkyXgkPf82PBKUd1XsJXW+mr27CFW/Z7FezN29ndx1A/OEcssQNc633p+yQatjy
	G6ZrM2x
X-Received: by 2002:a17:90b:3d87:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39d9bd951ecmr5459367a91.10.1789114550542;
        Fri, 11 Sep 2026 01:15:50 -0700 (PDT)
Received: from localhost ([106.101.10.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm3534834a91.8.2026.09.11.01.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 01:15:49 -0700 (PDT)
From: kimwooseok <5mghybrid@khu.ac.kr>
To: netdev@vger.kernel.org, theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 17:04:46 +0900
Subject: [PATCH net RESEND 2/2] net: macb: Use all-frame timestamping for
 PTPv1 RX filters
Message-ID: <178911388671.25348.11008812384009904081.macb-resend-2@khu.ac.kr>
In-Reply-To:
 <178911388592.25348.177462085059763031.macb-plaintext-resend-cover@khu.ac.kr>
References:
 <178911388592.25348.177462085059763031.macb-plaintext-resend-cover@khu.ac.kr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

gem_set_hwtst() accepts HWTSTAMP_FILTER_PTP_V1_L4_SYNC and
HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ without changing rx_bd_control from
TSTAMP_DISABLED. A successful request thus disables receive timestamping
while reporting the requested nonempty filter to userspace.

Handle these two filters through the existing all-frame fallback used
for HWTSTAMP_FILTER_PTP_V1_L4_EVENT. This enables receive timestamping
for a superset of the requested packets and returns HWTSTAMP_FILTER_ALL
to describe the configuration actually selected.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Assisted-by: GPT-6 Astra
Signed-off-by: kimwooseok <5mghybrid@khu.ac.kr>
---
Resending as plain text because the previous webmail submission included
HTML and quoted and rewrapped the patch. No code changes; the Assisted-by
trailer now names the tool.

 drivers/net/ethernet/cadence/macb_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 51659bb..2ffc46b 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -430,10 +430,6 @@ int gem_set_hwtst(struct net_device *netdev,
 	switch (tstamp_config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
-	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		break;
-	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
@@ -448,6 +444,8 @@ int gem_set_hwtst(struct net_device *netdev,
 		regval = macb_readl(bp, NCR);
 		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));
 		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_ALL:
 		rx_bd_control = TSTAMP_ALL_FRAMES;
-- 
2.53.0.windows.3

