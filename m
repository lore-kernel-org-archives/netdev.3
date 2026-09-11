Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB2443E2A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114549; cv=none; b=dpcoT457v6+Ak0xGABY+g6PlWIGGZ8nBbBG/oTtXmEo0oO6qNIqawFlTtYvutgv+v7TT922Mh0fLoHujcGFXJOvQ3uKzqxgj2WKCSA0JSJfopA1vFrtGrdRNqtNtK2dHozgTBau/slHd3/EPAAsGgB29ga13pH3CiJrwR6/Atvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114549; c=relaxed/simple;
	bh=FJVnMpFahWnvr/TrIq6oKej9mRKZ7QHxinDF+MV22So=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+JwmvfUb1SWqQ3Tjcj/uZMOeboiT9DNWbj11g0r6ueYdmymlj6ZgJC0BZwynP68HErGlihESvr/vsSvLy3tVCGktAFPPXPPG76xD25xJbYVEE+xK+OHzzWWJr8jOYAnKs3ezMBgWzxxypYJsS2D+hyvSLG7uh6Bh/sx7YH47Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=kqz8NXL7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="kqz8NXL7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3d66515so827670a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1789114546; x=1789719346; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t0iUfkOuA3ojMqhIpEsjDXiaM0I81VSZfab8pVnkc+o=;
        b=kqz8NXL7KRUG0IKbWVpcSZZkxkN0FsTBVwCdkobWr3OabzXw4/Ejh8SPM4ewCKgvjI
         rkXJOM3+uNDbQxF5KES07W5bp90r56dR5Z3JclhL+uszV1shInRfZr++54nACODB7BmF
         PY9axNeanphAKlPbFpOWo5jmuKzdEi5NHoMjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789114546; x=1789719346;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0iUfkOuA3ojMqhIpEsjDXiaM0I81VSZfab8pVnkc+o=;
        b=AIldC/hwpg5++uZ9KAGjZmd5EgRjOaPQG0VoWj5Zsk32MgopoknB3tr2C9KYEHx9gX
         m0yB7vizvMUq/w28jiXNZP7RKKA92EUMJshmSq7nH0a05mMOej8Fb+H1nMS49lpa9cmi
         nA1StiAvzrsjqO45jshwGaZrTAHvi1lmPCbvDdlsBh4AU5nRV9H0dHYNENau2OQumZY6
         15MRrhlFn4IZ1ePaw4PIjqszx1CSETfk7f09o4Lox0uxxYWj4I1G7Y/+Qk8C/Fmheo26
         4E/wglRmmZibq/+hqFmnpuLWDDEMW3njY2KZAQB4iHCwyMADkd6nMftFzXhFAN0rwnVc
         ItaA==
X-Gm-Message-State: AFuF++lWRnrHzDToVKQ9sE3moFy4/18sENcTqhHw+Ed+J04v08jSwdAD
	23yYAg1FsSlBAEV/uVAjw/20LGYzTBjsxdWwUqdBZeNnRO2OnOzxS7xXSrliBM+si6sfw9oDBw3
	hyxoEf0L7cA==
X-Gm-Gg: AYBFou0K9BX/m2TSLPhR7f7PCjHBjF4BnLnzDynVHDMEorkZ2DcGT5T+GRmLll9ilZe
	Qc/+6dJZzHndZfubhis2OBl0ghRRCY60Aey4rwwzvowyz9NcWUQYR9/wv0xm9WJ4pf5VFHCIe1F
	lx9p4Q1GxaUKAfi65dy1e5Ilbok+GANnjhgHkV8SK4cBSLKlno7COPyo9Y9nurA23cPu/C4+WFQ
	t66/ItXKqjmTKxAi2IqwEITyPXlAQbWQnMF7okuwnZ7qRgJ2gTn3dcaAs2DFMZDlw7MmwaXuaq7
	xxbJSA7szUVLUFyuPdKAbfhmmy0N+eok9/aDw0WxohCkRKtn8GXqt0nbtw65eqXgb/aWWblZExW
	k67D9wHTymsDs54AhBHUWbB2dmvSWB3jTfTDR6thOG7jsBLoBMPtLyA/0tT3ELKYnr0C2Uhsbiz
	BEE8nSskbVhJ1C/ViBrW9oJbT672gZcRuoMFbJ++a5VW3DcTrlTwh9WTou3ZQDx+fyymLTSk1BE
	NBii7qWfiNEZq1jMBs=
X-Received: by 2002:a17:90b:560e:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39d9c34a6femr4850840a91.21.1789114546224;
        Fri, 11 Sep 2026 01:15:46 -0700 (PDT)
Received: from localhost ([106.101.10.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm3534834a91.8.2026.09.11.01.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 01:15:45 -0700 (PDT)
From: kimwooseok <5mghybrid@khu.ac.kr>
To: netdev@vger.kernel.org, theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 17:04:46 +0900
Subject: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on rejected
 timestamp requests
Message-ID: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
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

gem_set_hwtst() programs NCR.OSSMODE while processing tx_type, before
validating rx_filter. An unsupported receive filter can therefore cause
the operation to return -ERANGE after changing the active transmit mode.
The cached configuration is not updated, so a subsequent SIOCGHWTSTAMP
reports the previous transmit mode even though the hardware has changed.

For example, configure HWTSTAMP_TX_ON with HWTSTAMP_FILTER_ALL, then
request HWTSTAMP_TX_ONESTEP_SYNC with HWTSTAMP_FILTER_NTP_ALL. The latter
request fails but enables one-step synchronization. The reverse
transition can clear one-step mode despite returning the same error.

Defer programming the one-step mode until both the transmit type and
receive filter have been validated. Rejected receive filters then leave
the active transmit mode unchanged.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Assisted-by: GPT-6 Astra
Signed-off-by: kimwooseok <5mghybrid@khu.ac.kr>
---
Resending as plain text because the previous webmail submission included
HTML and quoted and rewrapped the patch. No code changes; the Assisted-by
trailer now names the tool.

 drivers/net/ethernet/cadence/macb_ptp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7..51659bb 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -418,11 +418,9 @@ int gem_set_hwtst(struct net_device *netdev,
 	case HWTSTAMP_TX_OFF:
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		gem_ptp_set_one_step_sync(bp, 1);
 		tx_bd_control = TSTAMP_ALL_FRAMES;
 		break;
 	case HWTSTAMP_TX_ON:
-		gem_ptp_set_one_step_sync(bp, 0);
 		tx_bd_control = TSTAMP_ALL_FRAMES;
 		break;
 	default:
@@ -460,6 +458,11 @@ int gem_set_hwtst(struct net_device *netdev,
 		return -ERANGE;
 	}
 
+	if (tstamp_config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		gem_ptp_set_one_step_sync(bp, 1);
+	else if (tstamp_config->tx_type == HWTSTAMP_TX_ON)
+		gem_ptp_set_one_step_sync(bp, 0);
+
 	bp->tstamp_config = *tstamp_config;
 
 	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)
-- 
2.53.0.windows.3

