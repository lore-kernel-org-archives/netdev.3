Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3236C9C1
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222919; cv=none; b=m3ButFOhQ3RmFmPuxtWqRFm563Uy1PAmfqRariEeEBghJZnd7LCIhFJS3JcRxilaQPq6HWjtExkm1Cw4xkafUn7mOnl2+dfTSdyqdoC6kKjHrL4ZgXuxFp+rWN3XmQ7YfXreyirw3iPiVUQCBzpf+IenihO7rxIlSFTjAUFx32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222919; c=relaxed/simple;
	bh=t3YWAFTGJfOXq166ei+fVp8S8uwUghjUXQoCv8h1vNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rjRdSCLbMRDmV42KmRz/aUVebrA5aSV8EEnVhw/QUHlPzp+wrHvtw/3Oz0IKwR97Bt2IjgHsxBN+vmdM9V2lmB5zYkw02wmszPPW6tBY+EyRKfMK5R4EpH9zu/e+yi3022Df3tik1qj5tkvJEI8wlcSPWBDDZLmv5w9Y4PKhsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2WwGH3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2WwGH3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C79C4CEF7;
	Wed, 11 Mar 2026 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773222919;
	bh=t3YWAFTGJfOXq166ei+fVp8S8uwUghjUXQoCv8h1vNQ=;
	h=From:Date:Subject:To:Cc:From;
	b=n2WwGH3Oubl+RCowhtf7QOox4ccYXoouIKknsp9xZq+3+xkBZdXAaVPo/L/W6X1KN
	 fqlk75bWVJ4DeOMQ46Zhx2NUZL4lfKoD+hseFsPo9r58cEGlhXnTQ/W9TY5ghmPZsO
	 lvGVap6Y9V8M9Rae4s7WWRLmttsf8cPuJZpD/cTN5UEde9uPM0B2C0CRMDwlVdyGmv
	 H+R3VBIFtcbEi1d+VFdXK+KjUXTAUG10C7050EoQiYwMoqapsat47H6zt9XKjGWL3Q
	 er+gUZTHTy2Eou6nArhNIcJWW30Rbu5OjuAXLZ13m3OdGAZD7DJ6hQHJVpRqcS2q1Z
	 LBSLuG9jowyYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 11 Mar 2026 10:54:57 +0100
Subject: [PATCH net-next] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQqEMAwAwK9IzhZsq674lUUkatQctpFURBD/b
 lnwOJe5IJIyRWizC5QOjiwhweYZjCuGhQxPyeAKVxfeWoOssqJR+slBJkzSx12217ZqHH7KAdF
 7SMemNPP5/7/dfT+/JnIIbwAAAA==
X-Change-ID: 20260311-airoha-remove-ndo_stop-remove-1582a74baa33
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Do not call airoha_dev_stop routine explicitly in airoha_remove()
since it is already executed by unregister_netdev() if necessary

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3e9ec5c178f86fdd055e079078a23461edf97951..de5089e7dcd85080188641ae4c976b3d731cc3b4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3095,7 +3095,6 @@ static void airoha_remove(struct platform_device *pdev)
 		if (!port)
 			continue;
 
-		airoha_dev_stop(port->dev);
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}

---
base-commit: 482aac8b56ca21d06c588517970579474d56736e
change-id: 20260311-airoha-remove-ndo_stop-remove-1582a74baa33

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

