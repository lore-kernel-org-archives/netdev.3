Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223398;
	b=0pKHJ0/4LezyO4si+i0+Zs3Qq1+Iscutu0/MQRyywc7M7yOVZ9zK1VN65vpan5r7R2hE
	 YcR6TgCook5C/3FVGN9bc5a+UPfASxGrVsA7xM3cZQpkG5MTJvd5i+eXmHMj7sh39JbUU
	 PguweIAZaR5oGEdT7vuaImHKc2BO+8rHRvbv+OhyuMISeE3aChbUozbidwkZywSBYpA19
	 oYmCosjbPNhgMgpTGbjq4qySKz8xmCMqwY8F8epVmDzhiZXp5zxgc/vjxgQg5sucsYzNT
	 3Q6NEx18H7T1BvNovcWUmezG6+aVbKufdwigh+sW13mEI8kxrHWju+eLM2HU1olKiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9YsYewTnE8VEKeslSTsmNeaNk4e/tO3vB9Bto3LDSQY=;
	b=xSpu+eFd52XI73sz6qiVfOdvHQn/SzyQAQbFno/piOGZcZTWZj36M4mNAuNVkRKgM6Ab
	 MMtFmVmHxUeOCcLZoT6kasb8R0XLdE4A7fnI1dJ358AwYK+MDLLJc/bwk+UZ83najS7x0
	 mBEWFiJGgav/LmGSBnWmFDRRqCLylym4A5RNaREq8qrrmqYVg2CO5sYRj/YJ/+kGz+uyl
	 6ZIoFFkUxFGMF/PQGPSQ/psrd/LYvoA7dTcr1Usadnjlz0Pi0k+LDvL4vbV05uVE+e593
	 lnsIUn1b8CUGs2KDkiNPseWmY/ILZI7R2gay0DcbIeKAPMINSz59yzjvsaHL7g4BKfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmeTd+9r;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAF606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7FAF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmeTd+9r
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so731606a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223397; x=1793828197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9YsYewTnE8VEKeslSTsmNeaNk4e/tO3vB9Bto3LDSQY=;
        b=QmeTd+9rgSPcZ4OMUtGRLPtz5B0YR7OVOnAytT5KtGHWm1RiA0bUlkayjL6IHfdD4s
         7KJLAWZBZ+iw2G/Z3Yx7UPTxeY49xekq+59l2NWuYbORBd5rHu3tRtOIpEwFTxvydvBm
         TH1uNxLzDzUsmplcTB5zyRhIRiK8cN6/vfyWkWSvl46j+PipYZuSq5T2w0iomqIZ9RZV
         qiLx1ajgnWCc/Iegrw4gGe9UGGai7U0no7/mWwnOuRQNM65AdqBtBb+R+HsZNZo8SvT8
         I3Zx+iKohhdnL+HE2UqbdURvxQtoVDIAEnPnkEieu5DWEtT6rJY9kbMogM4+7ywFZ6My
         qUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223397; x=1793828197;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YsYewTnE8VEKeslSTsmNeaNk4e/tO3vB9Bto3LDSQY=;
        b=dTwS6RDymW5Uh3sTRWd6DmsjvBA8TYjVrOdNx6W6DQkKTX/i1SUqyzrjrLTB9ipx08
         BRiYQwOaK/y17iQFzQSDhXqYyyEUjfSn9cf8va2iSEai45LnLlFxSSNoVKANSZ+d0D3/
         t1ixt0hFbJ7bQXqIFyaqQS9J6V4DJd07v9ip+kBraHizhAOyeJVsogn2ZpVjVltJ0sW0
         HdZjdfTSttu5GwFWewDPYXYntWcrYCBTA2Eqt/POYSK3ZQ4ddtOrjO6zRqjCHEj/smbd
         AN4u28+uC7EerZfybUXwoRvhX4YoI1SG9cHluviNMmK3wAdrnClutiBbDV7ZXLojY9k5
         o0TA==
X-Gm-Message-State: AFq9FYJXn1jU2UqvSz6kQGtpqyNagkghOApe+afAaCxtVABPwGOTE6fX
	Fvl2CqsgOVaTyePxr6JZ7k48uwnniV2NF7imFt6J0lgA98rvKTfZX4kd
X-Gm-Gg: AYBFou0aQlpHjKbXXy8VwLd1JH0FRcoX5ausrWDReuWPqg+fRprsO+1rGfzrPPU9qmg
	0vQPU64mNWYgJiu6+o9LOw33A0joRr/taDfvM6dyjRBeCp0fgIY4dvNtHq3tG422U63rXkhdMTQ
	2dGwx+wf6jSGCD4SlDo/jQPosniNx7iqAddZwkaWn/mXXtSNScRFXrmjO77CwgMgn6ePa3WDI0e
	6KRmT2hlYU67W8EQynhWuHcLxj8aZ0vYhSoVFtBYmgX/WxM1kQXe3tuC04KyH+I4RgAUXYEeRFM
	xHIa9Y4ZWT2Rk6mYdcPR56QnPbmtBj/Zqav6WMKODSUOpsb7n1vQzQr6IuT1p7TaRuDDX0IiWVb
	+cOFyjHI641PGqNgPOn+fbQxkwR2cs9kE+7JSct23tcqq2PZB/BmgdFC6xkggEGNxa6G2BnA/lQ
	3GxzELrTb/on/0EJtJqfQzmVzGEvmrdhjdOxo3tgd16rJpzT7vXvI1kiZvgvXrTcUCo1TsgKDve
	c+9nG6ULOxi0x6McHARkGG/oHxpDHjz9o5gYd2Kae6X5txAVVg2Q/iwzE3IJWCCW4pFSnYG1mcl
	y10Uc5SP1Cdd5pQgtMgqM+6Y24Cu0S4zdz8Jv7sHHidcdes3SdZYfh7tuI7y6dCmfY+R6xEsSLu
	8Jj7wfBG9qHriKkR3uN3Dlj0YenqVuNV/v9DRbx0K2rFacQ==
X-Received: by 2002:a17:90b:4cd2:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3ae57f96d53mr2363894a91.9.1793223396676;
        Wed, 28 Oct 2026 14:36:36 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e874bebsm1089721a91.14.2026.10.28.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:36 -0700 (PDT)
Subject: [net PATCH 05/13] fbnic: Don't touch host filters from a service task
 pass after ndo_stop
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:35 -0700
Message-ID: 
 <179322339510.40667.1479012020546652264.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic_down_noidle function stops the service task by calling the
cancel_delayed_work function, which does not wait for a pass that is
already executing. It cannot use the cancel_delayed_work_sync function,
as ndo_stop holds RTNL and the task takes RTNL itself. A pass that is
blocked on RTNL while ndo_stop runs carries on once ndo_stop returns,
and only the re-arm at the end of it checks that the interface is still
up.

By then the fbnic_down function has demoted the host MACDA and action
entries to UPDATE and disabled the host queues, and ndo_stop has handed
ownership back to firmware. The fbnic_fw_xmit_ownership_msg function
clears fw_heartbeat_enabled when it does, so the fbnic_health_check
function reports a firmware crash that did not happen, and the
fbnic_fw_config_after_crash function reclaims ownership and writes the
host rules back to hardware. If the BMC raised
FBNIC_FW_CAP_F_BMC_TCAM_REINIT in that window, the fbnic_bmc_rpc_check
function does the same through the __fbnic_set_rx_mode function. In both
cases host traffic is steered at queues that are no longer running,
until the next open and close.

Move both calls to the end of the service task, into the netif_running
check that re-arms it. The __dev_close_many function clears
__LINK_STATE_START under RTNL before it calls ndo_stop, so the late pass
now skips them. The BMC flags stay raised for the first pass after the
next open, and the __fbnic_open function reclaims ownership, restarts
the heartbeat and rebuilds the BMC rules.

Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables channel")
Fixes: 6ae7da8e9e06 ("eth: fbnic: reprogram TCAMs after FW crash")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index ad234bb0f75d..e7744915d001 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -229,18 +229,23 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_fw_check_heartbeat(fbd);
 
-	fbnic_health_check(fbd);
-
-	fbnic_bmc_rpc_check(fbd);
-
 	if (netif_carrier_ok(fbd->netdev)) {
 		netdev_lock(fbd->netdev);
 		fbnic_napi_depletion_check(fbd->netdev);
 		netdev_unlock(fbd->netdev);
 	}
 
-	if (netif_running(netdev))
+	/* fbnic_service_task_stop() does not wait for a pass that is already
+	 * blocked on RTNL, so one can run after ndo_stop. Leave host state
+	 * alone in that case; __fbnic_open() reclaims and rebuilds it.
+	 */
+	if (netif_running(netdev)) {
+		fbnic_health_check(fbd);
+
+		fbnic_bmc_rpc_check(fbd);
+
 		schedule_delayed_work(&fbd->service_task, HZ);
+	}
 
 	rtnl_unlock();
 }


