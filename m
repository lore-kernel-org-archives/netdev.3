Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223406;
	b=zON0T4KBRndl7P5kTW2DBQirn5ySGL3tIMr7b97f7wHDapQsimpexHfDp6Hku2QGaVuQ
	 1DDKJvUdzD94N0AhBwFnBOFMSnu+XLQvvjg48wWTMRfoinlr6iHFpsfHaJFATeiRy55g6
	 FU3pa28LLlEXHVwPoCsTyu75S2pnNsdEhXMit9aaDzae0fzX4D0KjRqyUCGV9tQBwhvu4
	 K390UJK4cXE66BtlA519g2C2GBRaUwgTwQjTlyqXkc8LibTEwj8MVt5a3wGWrwoohdCyZ
	 Lj7eZstu7tFWrFQV1JD1YlN0Gu2BOFan1AXlXIGPXhLLmpcqYSSfCku79qRVvS6XXfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=2lpdg0BV6CS0xmi6iNHy0AYIBEVyUoCMfPADzWZ94s4=;
	b=csfu1FhsNQySNpmGLQiyJ+/I+Nd75qaPHWeve8v4dTKYSGraC9/01TONkvIkalWwRxpd
	 hFqFtcYpNKQ37f1b0i5EAjCDPHZuiPgEnRfy8l+lp7C9pG/PuY0yQZQ7ZFOTi2nuYrrks
	 p8YcY7JcL5CTtBXajoz0uan4eUNnGT1Vdhy+7Q6e/WD4xvqOYmNh0UIXczp1nJP8ifOl6
	 mCFFQ6lV9APiuhaCeV2+Rzk/IhJiSauXJZt/AkI2/wOIokhzY9bC/vgWYqClJk1L0GgPH
	 PUT+2OdwMD0tZO8QAI3rhWJHK1GZPTe9RoXrvWSvXAzzeWlZdK1SQO3pZYj3RADHVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V2ekrM0J;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B5606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 903B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V2ekrM0J
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070781f63so780230b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223405; x=1793828205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2lpdg0BV6CS0xmi6iNHy0AYIBEVyUoCMfPADzWZ94s4=;
        b=V2ekrM0JLbPNZURN2UUqorZuxQka1DUgd7QLvsCx3qwsU4dofWP5KQsQY/hHBxtpiy
         a+4N2mdyK0DHqb7mr0O3HcEj1tFtEjVaFimHHeNWkIN0hFDgkQUhQDiXOhWT9K5bndTp
         9EBS0KsN9gSiiyav46SwaUWtMxnzJOER+MBKk67r+bVJsP86UZr+7Bl+tVks2zcKLn/x
         0qUstEUqi9eWWGTek8TdNrK0/a6imj+P+z7D+pLteHC5lnaaA7yG3cQcfaRVY2sNbxmI
         ZGeuF1IaQDPbHwTpLi4kSBc1TTkrJXYC5P6tOnh1twNQfJz7Obgtpx/1xeFm3SS2Rjns
         /YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223405; x=1793828205;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lpdg0BV6CS0xmi6iNHy0AYIBEVyUoCMfPADzWZ94s4=;
        b=sms3GHOtLlmMYsLXbp9QlN5MvyRNUBSu2xKrrhMp3PBMF41v1RgyirgqVMIivjfHty
         WA1gTeoEKX7kVXQc4wyuQoOfcjVwTCYix/nVuia03pMeAG7B8UnnOhYkOHmjB/skPFaN
         AIXDYwwuhAyxScK960E3VPy5MzULV8suovCNzCj9D7Gt1+0/kqnxH2l4VRsN47qVARhe
         w6aYSWU/moDwOygq4Ecp39JFGS4izbeU1zXA7z3tDZo1fgkb/k5oUN4oDGocSTyfdGLW
         LDGOG0Sn2vx1dsqGxOa3IkNnoZR4QikGqLNntdfaWSKLCDuuTlhfaR7SmKfaERlj3jp4
         Sp2Q==
X-Gm-Message-State: AFq9FYK3a+GsdMBzeYNYxG2zh+orr5V+up43jXXK+Iok0AAC1zBZ7wWW
	GRZyp4XQ2BXrbd5Dc1ENc7RM9EXeTxdA5Ud3eIjAQU93bGXHR/5UljOh
X-Gm-Gg: AYBFou1WPRpS2wKZ5DQO4SkH6akgANyyrWMS/YaTXHS57e9yagryWD0jpHVdMmJ5obK
	4Y7yOkV4G7YWNqy/aEODnidk8ThQGm1uvNzK8YcZjRs9QQZhtHeflAhqEh+3u6huFx/Kc/OxtU+
	I85wmKKZkCw3J0OSXEwWLpmN1qI4UMhCX/Qa/9YvEsamIJpMJ6xgOOLTJhyLjh2AB2+skNN8O4t
	xkgE5tGab5XB2qhFPskO+039+gq5mzsznmuJ7D04slRxTQdTSGvFXEYEyJpGMp+EBpjl25y1hjc
	1sVlp6PDzTxs67jd8lK025JNdNcgqddDRPl9nXtr7MyKETajAKg/AxYSrnvWi7rcidtmdcGzn+3
	YheF4YEV+PdC/UGnjzp6mXd0VDMlu0Jm9thfhOirIGlaOzijKJ3431U9Z/GQesfCrcpBistur1d
	gP2FcmTt3eKXtTXxq/m+jE+r8Xf6XQmfTYrVmvNulnxPCpNN+rBjToiL5mbvZluEXjEF3kCuhy3
	BqCBGz22KzJaPwRqskeLTZL7Wcs+eKCjPr5Rr5sQJ+pW2PfNdoa1pdQbitfWm9XtPdnet+6X61r
	nujKTPuJ8c8GxdaXUqW9PYtuqLg7noTp3o1aCOqNJ4fnx6NPiI82EsdHgcAL0DOSYxcda2t/zLy
	PqrFU/ZG+uaTdiZ75GDbxOG7KldTZpAGmHtm2tfsDDlD+Nw==
X-Received: by 2002:a05:6a21:502:b0:3dd:f9ff:f5a with SMTP id adf61e73a8af0-3e9020d1a48mr3019230637.9.1793223405056;
        Wed, 28 Oct 2026 14:36:45 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a73c0e32sm1594229b3a.50.2026.10.28.14.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:44 -0700 (PDT)
Subject: [net PATCH 06/13] fbnic: Take the instance lock to restore filters
 after a FW crash
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:41 -0700
Message-ID: 
 <179322340181.40667.15147794773396816921.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
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
index e7744915d001..37cb3bedb0d7 100644
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


