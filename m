Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF98529409;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068250; cv=none; b=P8Yb369QclIsqXEWstSn7UKrOvQl0ISDGVc4PNPYaNn7V3ZsoeUErB3mAtESji6q1BF2U4VqeyNeXf1/ZvrU6nnL/xPfkeIZtfLcJhPBJEknuyAtaFegOkCbMrVwI0hYju0ENUSQCQZIXC7qQikPkWFUhWqwdfVmk76gQYwzWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068250; c=relaxed/simple;
	bh=X1GP/FVanbarJEdKN96y1vp3UjUCwpi/jJmoo2IVnwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2qoNBxE4P/I0D/gMlVofHqfZVzRgT1TfvsUJkcy1gx34Q7D/U/qDop93rzu/kesWaCp2IY8+W8varResZZUE+jc3weflXGjTud/eI8Hn6A8bsyYXVYKPT6JpfUSDdjNLKJG3zaZBXbQBqRjAaciEQXYKjkyhrKUE9taklDWUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsHRP1Ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsHRP1Ad"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57EA2C2BCFB;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790068250;
	bh=X1GP/FVanbarJEdKN96y1vp3UjUCwpi/jJmoo2IVnwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WsHRP1Ad8WSOp3MURDN8rp0fI4KJLSR1rox8asoY58fHbwxFRvKEpi8/jRiJDggOo
	 y85tTFOlK7StKLz7K1QL3G1JpCBjOyO+N7aDJ7CGcNYbNrfCDwCgjWEqkNn/7LrsEy
	 VPHDT58dLuRgBU2w3kqxPFXZ6Qns00paGuNhKZMetMLeu+cOv/fOCA38qaADp5JvUo
	 vR1w4nGJ7sqPnkGmvWi8lvxPb54I6QH9IaT8fTp+1hxBLQgU7jyl4JjGs4yH2Fp0P4
	 eoXlFPe9+v3nPWXnxQ6xvhNRqxLCig+NC5eaBvqVu5NczACd51r52BGrL7Uk8iFiou
	 7b11AU5LiTGYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399ACC982F1;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Date: Tue, 22 Sep 2026 18:10:50 +0900
Subject: [PATCH net-next 2/4] net: macb: Enable RX timestamping for
 specific PTPv1 filters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-codex-macb-hwtstamp-submit-v1-2-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
To: netdev@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rafal Ozieblo <rafalo@cadence.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, linux-kernel@vger.kernel.org, 
 Kim Wooseok <5mghybrid@khu.ac.kr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790068248; l=1704;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=05d3+CCGF+y6/qkvPziNFKV5JO+MRqQk0vWJIck2XbY=;
 b=BjzpZj5RdiFWJ1zAgBFdT58RNlAD67fXhVaHfPmCgmKQ/6AW29OnPsOrZ3rL5mQuYdFo9DjIC
 6qdQVdFmNXDCkr+3o9ol+ChqbbV8dZLveyw4HhjoxsSMSdLgAzW0uvj
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

From: Kim Wooseok <5mghybrid@khu.ac.kr>

Selecting a PTPv1 Sync or Delay_Req filter in gem_set_hwtst() returns
success, but leaves rx_bd_control at its initial value of
TSTAMP_DISABLED. The requested filter therefore appears to have been
applied, even though received packets have no hardware timestamps.

The PTPv1 event case already enables timestamping for all frames, so
use that path for Sync and Delay_Req as well. This enables timestamping
for both requests and returns HWTSTAMP_FILTER_ALL to tell the caller
which filter was actually applied.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 4dbb6daa6..b6d17fef4 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -419,10 +419,6 @@ int gem_set_hwtst(struct net_device *netdev,
 	switch (rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
-	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		break;
-	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
@@ -437,6 +433,8 @@ int gem_set_hwtst(struct net_device *netdev,
 		ncr_mask |= MACB_BIT(SRTSM);
 		ncr_bits |= MACB_BIT(SRTSM);
 		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_ALL:
 		rx_bd_control = TSTAMP_ALL_FRAMES;

-- 
2.53.0


