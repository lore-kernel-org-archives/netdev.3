Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D14F0535
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975994; cv=none; b=TczkyLLahk0LxC3un+zVBOREjXySp+7WOQsGW6pFarEF9HqCP9Ri/onJ1GwXQMKu1Wp/3/8tNDMLQVI5viB9z/8Yhp7wpcdfh+jvHXsqb9UQsoMN4gZQ9I1X8aEeTXCg4Y/yzBEttNUgnCBZBrBX4TtLlsdNmXAG8nCRBclCW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975994; c=relaxed/simple;
	bh=1oNi6qtg0RYoEu/F+U0P5N6Ojkho/eIeeeYWKL1uRxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jw5pEe2iV6l3nLXgqPSKbLIqIz3MjqWnXxX/cFmiUrxNSHkrI55vZHhrknzKMcuny9edI0m/VLJaTMaYTZK7GtDnXDrdxsfq7Nx4XAZBBCJPnf8lKDAxEZlwPKmMjXgAVRf0XylXAvFADApIGk7BpAZgd2dFMbYQiCXHMlr4USY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwDiZxtf; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwDiZxtf"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so1199041eec.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975986; x=1792580786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
        b=KwDiZxtfZihMiEOYpaxGywBP5x/qcCYZN6Ip9jvkMyrB07iTCl+ZRfFNMKqE9CxpOp
         83tdL6i2XIeh5mxMIC7ZjVXlIsyI7xLswF+PTLhJmjOChOOPEhVoucyAS938OCye2bXS
         SNbyEvaDJIqPcaFlFtbYu+bFwLyLNbuh04a4B7UdLoqfVbi7Jot6+Ew357Aht8MRt3Eq
         LHxvQlTnB0uqvG9/WpcaGsLFMDxKg0rL2Z2UrC2mrLit3w2s3cmRhBvkp0KJZdkY1fL+
         v9RfoH5MN6/t6YCAdeAuSdYQaAaEnUzTp4Do9Aj9rHiLh41GC8emnCK5lek6be63+7TZ
         7luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975986; x=1792580786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
        b=yLEvRD1x/4EL2blLbL3KZLzYe6zs/g5vXOoIXJFLQDw98kNROV9dakQyDCmmdz/RmP
         EPH0gBYRWvj9xvUCadXtD06eV7I8AznQswt8auuq5hSVKMRFjOOgsv2uBAgy++g0m8bE
         Frl6uGuymoRH66SDXEg61AxyXfeZb/jNXH4rCZeGoMCFONxKnFaJsbMNz4jLFlmss1S/
         gbiPObXYNRUSJgTc87IUFab7hxGHZIW323DE10a299HzcteKjBXAzpk52x76Hn+LRehH
         xhhWoSRx4MnQW/Sr4AfagQqRUWtYiE+uUMcKBXdrDf+GRUFohAxaB7KXmZwS2nl08rGt
         i5tA==
X-Forwarded-Encrypted: i=1; AKwUvBxhrjdl6DztxvBHxdZXIZKOGRFpey1OgCCJksJNSZhAe4avmjWeEI1cAsSB85BMky8ALj4cLzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzVzBKhf6hvDDYqtvF1WK+wD83eIyS3kLefPNZE3zrZf6BbRE8
	6//08OSNuDMOP9gqyVHhm59iR382T1e1KJQqykhodqJVMYJiX8QmXWEYHalN776p
X-Gm-Gg: AYBFou1OvtaMRwOgNJpHags1RcR9gKDWo5W/MWyhgpNVI0/k30KeSaJXA00yhZmYa74
	ycwqZgkHR3wDBo911ewS/l80KDn7YRWu39W7ox9w57LMIcHHejjK3Y37xhuMTfQOJzw9HAGSIj8
	7kFiEh+RngrY5B3TCfFmbQCfTWc/u8b1IjWmVVq1mQ1J5hOynbidfw2hUqLTWShtP9rEfiTSBxJ
	wGvXvbo7XYpOoqfDFvD/92yZtgfqoWFQs8/7GjgbAFi+kLXfd1lnxGnCMJ8frfLk9Ai57iuBiU3
	oIj6QooF9s5PWNFR1N5uKbaDldQZBy4XGz7trTQN0ljxtLM10UM20xElFO8JHdkU/pqFOwjv8ht
	wkFhtJrtLvkMe+rUaD6i4hUc+G4XW5Sg1RoWpZPvcU2Xnp8nAKc4/HPwV1igPsUTvAFQi3WDRs1
	iXq9MhobqxXyzcnzERZ8oVt3iQKZflEP2gNHDh8WtQrFvCkdI2dpvvsUKtH6ZO/h+o99zdzDM6n
	3vtM+CBnwNK
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id 5a478bee46e88-3537e0bdfe0mr22517361eec.23.1791975986061;
        Wed, 14 Oct 2026 04:06:26 -0700 (PDT)
Received: from evangelion-g ([103.196.213.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm38221116eec.31.2026.10.14.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:06:23 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH] net: intel: ice: Modernize ice_vsi_free() with scope-based guard(mutex)
Date: Wed, 14 Oct 2026 16:35:52 +0530
Message-ID: <20261014110552.56976-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..c695df442822 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
 		return;
 	}
 
-	mutex_lock(&pf->sw_mutex);
+	guard(mutex)(&pf->sw_mutex);
 	/* updates the PF for this cleared VSI */
 
 	pf->vsi[vsi->idx] = NULL;
@@ -466,7 +466,6 @@ void ice_vsi_free(struct ice_vsi *vsi)
 	ice_vsi_free_stats(vsi);
 	ice_vsi_free_arrays(vsi);
 	mutex_destroy(&vsi->xdp_state_lock);
-	mutex_unlock(&pf->sw_mutex);
 	devm_kfree(dev, vsi);
 }
 
-- 
2.53.0

