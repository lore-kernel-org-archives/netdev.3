Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26733ADAC
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471943; cv=none; b=dK1rgLuUmefYaDdffF8w82VNWXCOGUikxVI25i2mkXQp1hSmDLgGK5nm11k9f7SLQ5IHgK8dOM2dUeOUF3CbRvCZSrd0D0mDf5rzkk7DuwjgMoWJd7myuU2IEziqjXqUipPZSarf2rNpQN96yl+vEn8J5ooBhJ3q14S+kruxRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471943; c=relaxed/simple;
	bh=d2V21AVMJDMSN+v/+1TPenyVNVUr6JOmerRtt1SA2Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqAAQzKFq8TMYHi2NgC6HKhLpWRuSdJLct/mSrcIGMxFc6XLmGLHtBDQfvzf8JDWL9QHr80MoKuWOFEA/EwX2CGHhITDIxSbWNKDQPqJZFLTB4MgnIYDKb/DmIs1ZDfBtsBLI7phPUFGbZkzM0LBLlOqIOKeNynVMP+Wf7AXbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLg0SzV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLg0SzV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF801F00A3D;
	Thu,  3 Sep 2026 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471942;
	bh=RDBBRTeYgIO+jb+rLGsptJabDgxzie9/exrdTPMikgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RLg0SzV8ia95x7tzngWmIpNczWjFZbzwr/lnK56i+rgzPvwvpe+GLqW7c8kktl5cN
	 bVTsj9VpqyzoTTr5k2F/WBOdEqc3O8x556LvwLgIALKxNcge3mUNiTAu5w6hpP9kBD
	 qrYOr5VTyI/PfQrYJWVlwhqIp5fj8ta9k1cCCsOcF/m+XaX2Zr+a6f8Gk9FMITfFak
	 LAHw9NsuyV3ikSSqPkkz0tOTWHnJ4lR9B1SPLs/5kFc0yD5arMfDlSECJScjzDCurN
	 KYxUISFXcOIG8Y9BBIZRrSgmFt6QL/iAmmUHUUyfTHucKgJEmOg7Im56iWvn3jQrnX
	 XAd7BsARtS99Q==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:45:31 +0200
Subject: [PATCH v2 3/5] net: ethernet: cortina: Count dropped frames as
 NAPI work
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-gemini-ethernet-fixes-v2-3-2bbbd598ca6e@kernel.org>
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The RX loop only consumes budget when it successfully delivers a frame.
Error paths keep consuming descriptors without reducing the budget, so a
stream of bad frames can process the entire receive ring in one poll.

Move the budget accounting to a common end-of-frame path. This counts
each completed frame as NAPI work whether it was delivered or dropped,
matching the behavior of the vendor driver.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 6502220362cb..33e9763b32fe 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1501,7 +1501,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 				skb = NULL;
 				frag_nr = 0;
 			}
-			continue;
+			goto next_desc;
 		}
 		page = gpage->page;
 
@@ -1523,7 +1523,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 
 		} else if (!skb) {
 			put_page(page);
-			continue;
+			goto next_desc;
 		}
 
 		if (word3.bits32 & EOF_BIT)
@@ -1546,10 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			napi_gro_frags(&port->napi);
 			skb = NULL;
 			frag_nr = 0;
-			budget--;
-			received++;
 		}
-		continue;
+		goto next_desc;
 
 err_drop:
 		if (skb) {
@@ -1562,6 +1560,13 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			put_page(page);
 
 		port->stats.rx_dropped++;
+
+next_desc:
+		/* Final or single-descriptor fragment, advance things */
+		if (word3.bits32 & EOF_BIT) {
+			budget--;
+			received++;
+		}
 	}
 
 	port->rx_skb = skb;

-- 
2.55.0

