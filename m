Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5D1D5CFE
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310432; cv=none; b=Reeec9MYyqn7CtRu0qs2jS9Rvvlk1PHp9N1mk+Vk11Pq0nNa7bCK79zkjDIAjlHRxbsW/JDAMv/RgUa/xR5i3he7rBGlPD/N/ZzfPmjholj9k36z0/9Bn1eXGWKKK8Ofm5AqyvxAhYUfNPbVptLC72sxg5XO0HabNIU71iuyYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310432; c=relaxed/simple;
	bh=ky7NlLqsBt6fB9bGL3H9bCyfLVKnOE5dGAWmja+F5Gw=;
	h=Message-ID:From:Date:Subject:To:Cc; b=u0x29kIII6RNQjTRaxQdeNVuqCDJKxi+r9SXZWPU9WKPFJNlY71DNzwj9dC7bA+eMYPrWmzSQc0SxP3V6D/zGrNBpdBoy5J8DQZRvSwNA5D7ZlttwZ6pyd5Xl2HBHr7S8Vko8K1e9YUZH7gafB2kR4wu/pkYzgr4xZJHD8mOrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGeD9RdR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGeD9RdR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso1103709a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781310430; x=1781915230; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAEQuq4z5dW0AnrothciojC8/CjIG+BXfxwJ5kTAGpw=;
        b=fGeD9RdRgo+nuFRN6RBW6HFEOQI0hFRD0La3sJTZbKkDb0Ijc5PVgVjId34njfSsN2
         hHqt/DhKGNuLVzUv6lW6UIYXK7ywVu6q3iqgtrkBLaLpOdHk7HLXLY/pE54C6gPj1RBp
         KKdjy4S4lBS1yZWRnQvUsaet73cly8jX0M9UfMtbM8mx/u7F2fKeP4C+oa71zgnWIWjC
         wcEzmJqfRNx29C1r7Wp7FYImhhBrrHpsBY67r5bijV3GxD6SbvgCGoO0imgi++G/PN51
         Lyd0XY5GsITFqcUGtqkPUQEGfA02UHPObg5hfweRk8uhmmVdWgepHTBbJ8k915BiZKCB
         919w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310430; x=1781915230;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CAEQuq4z5dW0AnrothciojC8/CjIG+BXfxwJ5kTAGpw=;
        b=QDG4D9STe/pLUqEe8BK8sSXfDWALnB04A+Wja/DphoD0wmxwnlU8nCYuzzspLh/MNl
         MQOpYa54NIsaf0891NbPfHAeOGnS/RYhlmPlVGpwX7Y21WYvqd09tZEwYXdTEUXfTx3k
         Ue3HgbDWxjrlgy7pi/tIF1QupqEU1iOc0k2cTMqBt+LNGpNsuykyd2uz/+wTB5Bsdzxj
         W7liBudT98Efws5c8phazjOVO3s0Vigd/2aTJqvN2++r1KaFJ6rllz6Bn8erplqG8MLV
         5NY4PTzpX09ANF++eCmMhxNtumR3CMOQNVtihYe7XKMkQRx72peEVsbw3YYWuVbW1kWN
         v+vg==
X-Gm-Message-State: AOJu0YxCNyaHSNGRG20n5UBRtxBZso6vdYG7Pw35qjTtIoB6BMXgvtD1
	CmRXQj7BS7y/QYLacnxSsedT4rqp0rhZB1O0feihmuBPBNYGHYt0JgFChF5owi7nuPY=
X-Gm-Gg: Acq92OHyE+G+fEqnGrPwPZFhdkk3PZx6wgcbdqNjT9oYq1BmX8N3QgeB7dfvQJaJxUt
	fpkzXArFqQiK3QW+Jb4FRFbfH6R9PaToujk+yCLA1tuXyJT2kVhR9ce9b5JzNsEGPNamjpRHqru
	AwNde16UR0sKAVFsvp7emy05DL5jMthIIY98bSmVeFoFUYCbD21rXIalbOyAtBP6kEYMl3P4yVD
	R9gZHxQnUaW6lO/l9Zdb4Kn/WUIvsMWTAtMg6sevbU0bBUX64x5YZF3ylT24lyibPnoLoPZi2V1
	+pj97Igbi8IcFdKRqG3eTuq2FX2q104zoO2RMam2NVxjpAZKpj4igbGkgfynpigdq5Gdx/cwsa5
	RkMkzaZs/FEx585l4jFkJobOcjSFBIN7ZvE+3wZVGyHHSSbRbxVoczFveBwGkeZoArY5cpYIONL
	tj+Qk4MbPBzD4N3B5GVyjoAfRLf6M=
X-Received: by 2002:a17:90b:1b04:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-379ff644660mr5554949a91.0.1781310430554;
        Fri, 12 Jun 2026 17:27:10 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8ea7sm3441412a91.1.2026.06.12.17.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:27:10 -0700 (PDT)
Message-ID: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sat, 13 Jun 2026 08:23:12 +0800
Subject: [PATCH] net: airoha: Fix always-true condition in PPE1 queue
 reservation loop
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

In airoha_fe_pse_ports_init(), the inner condition for PPE1 queue
reservation is identical to the for-loop bound, making it always true
and the else branch dead code:

  for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_PPE1]; q++) {
      if (q < pse_port_num_queues[FE_PSE_PORT_PPE1])  /* always true */
          set RSV_PAGES;
      else
          set 0;  /* unreachable */
  }

The intended behavior is to reserve pages only for the first half of
the queues, matching the PPE2 implementation on line 334 which
correctly uses the /2 divisor. Fix the PPE1 condition accordingly.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11..999f517 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -311,7 +311,7 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 					 PSE_QUEUE_RSV_PAGES);
 	/* PPE1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_PPE1]; q++) {
-		if (q < pse_port_num_queues[FE_PSE_PORT_PPE1])
+		if (q < pse_port_num_queues[FE_PSE_PORT_PPE1] / 2)
 			airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_PPE1, q,
 						 PSE_QUEUE_RSV_PAGES);
 		else
-- 
2.51.0


