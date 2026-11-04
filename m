Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815149;
	b=Ja98HebiOQRQqsUn06wiQ60PPhvkGYM+2kmRvREIgnhKV8krWc67Ne7ityjPCQ//lqxI
	 jz+/5+vO7ldXodxBoQELJGH4yOEvqdunxSegMwHPKvB4t6Me86tOYxgXZZe4AVWbXtVnL
	 JTjthBTcZdKV2mL0v5kiql0/+PLm3Ruf0DASFWxZ44DPiNGKxzeWIP2IV+AO8GO4PB9UA
	 NE7VhVfHafcARxWzdjxmz6teYJH9BT1M93YFQw8hRaoI3LOmV25OrVXGTzJP/JrlGFxPK
	 23zXrNBhOZalcOfEjkcq2CZ5sPhJ2IiZRt4lM8an26SPLfbwKkOR94e7qEKm0VkPK0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9OTNLiIqnUXo5KXOl56BbVvGFg7giq+An3nV/JQrijE=;
	b=4lJ2NvkVYyr3rOQlCNXQQ29nAmGh6IGUCVxW75F4cZYA2SPbDiqTM1Pzd6BiS40COYir
	 vvN85fKetRAZv/gI+vULAQf6u6h9Ysd+fWJ2mD5+b/Bo2UVXmHpWuBNvMTmSGc+q/kS2T
	 fytVhU38V8LXbVcQGcCJ/WPFE2oek9JltyFO00Zu/QbHHUaIIe9+b6gsg9JZVZSkYIbm4
	 QW2TA+VpLBhjIvW5gAmfO0RLd4D87chSbJ/Kuvwt9yUFq59qHoedct3IjKAt2tXa/YQJf
	 IMqD6hdSdkUlKDUUlf805XnkwdtBAXU9vn+5g2nUKYKmfGnoRkQtz4k49Dn0Nxgy2Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oUG6mLyj;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5A606A339
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E5A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oUG6mLyj
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so586551a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815148; x=1794419948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9OTNLiIqnUXo5KXOl56BbVvGFg7giq+An3nV/JQrijE=;
        b=oUG6mLyjg/yptE9UwSwW8GhN3WIHbFQi+vaLoRHcUTxrPQO1IKPagofcu5CpsHFOpO
         PaTtT4tM8QNkjQo6gTfOr00r12ejqj6glJ5msNnSXAQqEKyMGZ5mL3xLgn8d5X01iDlL
         aBKZw0cf7x1fV+TUIYoh61nx1E3pd9vCYcwyFjHobNaHAn1XMZUaAG13/l9NDDCovaje
         2umP5rFG2qZqQcr7ceEwmcs3aRnBPQmCDM9fy4rdzzr2p5gN2Utt8iVEdljh210+bL7t
         zrh3mnbhjCvq0jaFRrT8tXzANq6QodSK7oK52VPT5r4K4uMg81yiK/agj6udV9VKT497
         VUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815148; x=1794419948;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OTNLiIqnUXo5KXOl56BbVvGFg7giq+An3nV/JQrijE=;
        b=oQBL0G+FoD0o9PpkCehg0cDOKEk7h/IQrzvWmKVDDSJkPPSX8fUWiRPbsA4Sicvkd6
         0YoVsPuyvpEeVRiP+SnEt+kXex6A8cNWVTg/3TEYh8i0h5Y2bxzRne5bUG0pZLgWSlxn
         syWm3R1MoQTJt7kIrf2/S1dNwTiVP8wbTPj4zf/6o5S8RZ6r2EwejyLQIA/Akm9yZS04
         MKTyuSL1xEDYVBG+tv97OT4wubnhWyAZNH9bp/nbUGx37eTDkw0FFxQeR8NWCk4z7sRe
         SVrcmFLc6G3r8SyqxdUdFzTTkL7fDHWI0D1fFKAlPYg1OFhL6CqGl9cGiVzVdiwBJufq
         227A==
X-Gm-Message-State: APuU4Z8uSgucOxoA9Qq6uHvL/4XFdNZSLYhkfh9Tur+tgC9lW8kSGGNM
	yrk/w1pUyiHcj7UBYrCex/nEGE8Y4U87YMLtyKCDm6ov5cEOuOtjvP678++vQA==
X-Gm-Gg: AYBFou37oYlSIoZ8DJB6FRvAeBaDjTFv9IItzOEIfKCX/DSfXkDLioglthxs90SZGl4
	6Sr+l1vs+GukP+EhVzpWTU6Kl0nrdzOeYnRnod+fvLhqUem/Br+X93kDd1Lw2yJUEKRJPmw4MO5
	T0S2gNNRI4N3tpp57SVwPTyeUqSD/hFAEemvGizdLouO/UenQRNZ4m7MAyaq4zGgrDnoANDGrab
	o+fAhKY2NW36S3jQM8YgLKvFYOk+rjHw56Lek9xgc2DiyEpRUTFfC68JqGpfLsQLtNFepoGVerw
	xpwyOYtk28Zrulua+jAj1mvZPeea2Id9Fcx7YpFj84tRG6mbq73FxqdGKfZ/zEacNA36tC3+taE
	V/LgwMqSpstwbWlyfEkwfi3ydVFHiAoidKUSK0wUTlCQegY7rjU9/sun8Fek702FifbCUUAMzrv
	9x5L/j4ioiyJhtm+7MrWZCQPB3YX609R+OKpoegxmLaa9gLYKr2XpKf6bqVfEwEwZL+2snV7g60
	dSDQv1vqHVVsR4kdwI7OeV63MUyIZTEG+3uQMFHZ1MVDjibsGtRFqlPGNLLJXl7LcCadVSLizt4
	Xhwf6ihNffXwh2iZNaIAOPsuBPbinUT0Xcqw760LYZ7AprtYBFoZ7GdlrG8l8MNiL3+Rd/VTJi+
	JzsoANqGFjukJpwI6pcnM2tbUfy2mfZ0O33MIm9ph16gVPw==
X-Received: by 2002:a17:90b:570c:b0:3ab:e588:c288 with SMTP id 98e67ed59e1d1-3ae897ccb52mr14990622a91.11.1793815147672;
        Wed, 04 Nov 2026 09:59:07 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31d2b5esm34216a91.15.2026.11.04.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:07 -0800 (PST)
Subject: [net PATCH 1/5] fbnic: Take the instance lock to restore filters
 after a FW crash
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 04 Nov 2026 09:59:06 -0800
Message-ID: 
 <179381514591.9644.8634689197787321139.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_fw_config_after_crash function resets the MACDA and action
TCAM shadows and rewrites them through the __fbnic_set_rx_mode function
from the service task, holding RTNL only. fbnic is ops-locked, so since
the netdev workqueue moved from RTNL to the ops-compat lock the core
calls the fbnic_set_rx_mode function from it holding only the instance
lock. The two do not exclude each other.

Both sides can then allocate MACDA entries at the same time, one can
zero an entry the other is still filling in, and one can clear hardware
entries the other has just written. The crash path also syncs the live
address lists while the netif_rx_mode_run function works on a snapshot
of them, so the reconcile that follows can count the same delta twice
and leave an address that is never unsynced.

Hold the instance lock across the restore, as the fbnic_bmc_rpc_check
function does. The netif_rx_mode_run function holds it from snapshot
through reconcile, so the crash path now syncs either before the
snapshot or after the reconcile.

Fixes: 5a81c72ef9ad ("net: run netdev work under the ops-compat lock")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index ad234bb0f75d..09eeb4b4ded8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -181,10 +181,15 @@ static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
 		return -1;
 	}
 
+	/* The rx mode work rewrites the same shadow under the instance lock
+	 * alone, and this runs from the service task under RTNL only.
+	 */
+	netdev_lock(fbd->netdev);
 	fbnic_rpc_reset_valid_entries(fbd);
 	netif_addr_lock_bh(fbd->netdev);
 	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 	netif_addr_unlock_bh(fbd->netdev);
+	netdev_unlock(fbd->netdev);
 
 	return 0;
 }


