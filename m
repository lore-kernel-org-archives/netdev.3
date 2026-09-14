Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2E4A0F10
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420210; cv=none; b=X94xWv/ieX+e96pB+YhKHjvyIBDpdv5/nYne1dhvWpHCwtbHdjFH9PwCjKvQoluLcF8JYHSR/nbMM7pwgWUdtaDNrgsIxY848ZVAEXPWuj4P82Q5enIMcZU7LEQVRMUEp5GFEuqZ854Gm7a2T0Q6TuUsB7H7S2WedM1IKiQz76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420210; c=relaxed/simple;
	bh=7eKit6+2Ppcc2s/MrNAIRcK5M4jZ13zk6xkUJCEuW+w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkIHpDiv6pFKkIlHCgytASi9gvajE4ajy64UhDM7MBx89kgdl4KN3+gZbq4TI1r/cDOkDZ+fdL3j7RlEd1BPoHv9/oeOpyEA87DXugrQjz+iqCobXmoBRmsj0WZW0pmotxOl0LK9Vxi7sk9VIhWU+y6xdBj/hhJB2r6WnulWA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY3hPLlZ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY3hPLlZ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c6920so2318236a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420206; x=1790025006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n3HXquBCEd6GGCIqkb3IFhVoN7YlJcvvY5I71y8AhkA=;
        b=WY3hPLlZicd+aJVmLmG0x8mengQalzx+cPcfjp1554BkvXZ4yLLnUQCEYs3boeNN0K
         oK2hexJg6ESc3ErQJfa1i49Bb8mp+UeHRbRtEs4iCvU8hF+JxQA0AHgsnhD2aLEkfkdQ
         rSAW9Ij49K3UoefXgMK5Sk3HW7wM1EngMpl2RAd/xK6KUjqAFrbr+eOCXyvSNMVaUBai
         fDbFekjM3+VGedetGpRJtUehwCMtf07xAToZZ1X8irRNZJfZTZx1s7UTx+TznxmGfwCK
         maPpWv6CIaLG5FkCJP1pNNGmIrFGP3KLSgjLZ7YGUjfFx0eNInV/utdUcFI2AtIvJhwg
         fLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420206; x=1790025006;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3HXquBCEd6GGCIqkb3IFhVoN7YlJcvvY5I71y8AhkA=;
        b=VL0aSC4njbVM6wGVxAEg4WNrgOup7d8ACpKHLhMj+RFJ+jUtSTI+lGh82glz08pHL9
         v5MWMuXCgJ/hS4CnXjgYU13TuXW3om3o74IbUrI3c8d38lFlx39ATFnoI1ykdvi3592O
         LRLQtmExzujMUTAKZEZlarUEp1A1h3W/TCl8drufWFPjAHVDDFs16hmAToMNcs5tMbE7
         N4LREKPc07jLwDPbihUPZejtjkqnlulD/VIKq+qUK6snzT3raxsTrc1sNuZOk9fMZPhx
         hsfKN5xHY0HCBUO88ASCWfhYMAj/J1u3rHINTMH3Q902K4JnNUHfA1ThxpGzlMkGzksO
         nogw==
X-Gm-Message-State: AFuF++k6TS+MSFlvjJjNdrcTNuqqbXFn15EsayDne/crXxyH7Ulrre09
	oYhVxCRL0QlX0QBqli4NHstgcOfZkL9d3VfMGlygc8I2s9EqvkBDxXuV
X-Gm-Gg: AYBFou381bmcOB3K9Yu5WQPEzXnsy+B3mBbTcCuQP3PmaPAf9InrV/wXql5G5d+TLNJ
	1jjwuthxV4Sc1ENFFGyJPkTqJEi1U32lKocpIEUCkm7QnALU4ScasvJ3FYOfNeY4T1PYT3zNANL
	GI5nmeYRlbzUBgG0S/xoOoPGrOirfm3v1wUjfZOw2h0YIqnHefg9nr3Nwcnz1rykIug/s3UIMPS
	+KLv5XF0daaLWrTVzY0imt+XOAT5/ti/eECPWY9+lN56mOFrfOwtL5/4Cyg4mgUR+nGEhi0CH+6
	QCLemVLL1lau+Rr6Hq6RF9WFItGpgGMeIRoSckaXKuLPG+XRTvdcGPnIUvPnAY7HDiHmhZ5fo+f
	xtPWbq2bg8CzeBWgpwd9gnDUVjIod4gnUGyQhhb3VwV+sgFnsAgq305fGh9d+9htihqmIY/Em4x
	X4z3Ango99SzHF3TJzTWFuLr7jGunbqQTFZaf7A4zA7r4WIMOwtu4kpa3Rxd2lTfcBSTSbLmf/O
	++5Dng+HcbMcUK7kMJk7ATd0MoQ3TEJkTrbqjV/QTVMCdkA+zOD3bGh8xE04dmPD34sllFPmU0s
	/gaBbskUvAVj/sDfnyc=
X-Received: by 2002:a17:90b:2f0d:b0:39d:f024:c7ee with SMTP id 98e67ed59e1d1-39df024cbbfmr7331532a91.25.1789420206215;
        Mon, 14 Sep 2026 14:10:06 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdacba6bsm1163329a91.14.2026.09.14.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:05 -0700 (PDT)
Subject: [net PATCH v2 2/6] eth: fbnic: Handle maximum standalone channels
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:10:04 -0700
Message-ID: 
 <178942020457.7700.13129750616387075931.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Björn Töpel' via fbnic <fbnic@meta.com>

Standalone channels use one NAPI vector for each Tx and Rx queue.
fbnic's allocation path excludes FBNIC_MAX_TXQS from that layout. A
64-Tx/64-Rx configuration therefore records 128 vectors but allocates
only 64, leaving NULL entries that resource setup dereferences.

Include the maximum vector count in standalone allocation.

Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 401f8b8ae1ca..81a30e2d449b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1768,7 +1768,7 @@ int fbnic_alloc_napi_vectors(struct fbnic_net *fbn)
 	int err;
 
 	/* Allocate 1 Tx queue per napi vector */
-	if (num_napi < FBNIC_MAX_TXQS && num_napi == num_tx + num_rx) {
+	if (num_napi <= FBNIC_MAX_TXQS && num_napi == num_tx + num_rx) {
 		while (num_tx) {
 			err = fbnic_alloc_napi_vector(fbd, fbn,
 						      num_napi, v_idx,


