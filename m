Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419947206C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261019; cv=none; b=ugovk0M8oTTc8hmgxLDcKJVdp521YUYfhc9NQIW9gj24AEP+MtPy3hXnuUCzhyMIWphf6O8jah+BKurbBRmJwQSEgvHgvpRg3T6ZiiftDqoAqViO2uSyLz3ZNINudsGm7Bb46fU1NWEigs8Ryj44ySGwyJyzGWfOBDIFuBEJvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261019; c=relaxed/simple;
	bh=L8Hrqvz6GFMoSEhRyzIorG1PWvffPNsLFlZwtdXw7FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ax5f1XlWDBuq1EFaZaE5POQMeWGcCPDQ6U4khjpe7kDzJz/QgLeby20c48fM9XSqV0JMH/ow9Y/4tmkTHum16UFSsCGZHgKEIxlTZZqPdTWls4HVqXGsbYNcd8SvIYTQfG/x/RHJu4nMeyi6dZUaqvMUOA+iKQLUXHZv2xCVcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6vNaZuf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6vNaZuf"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so811222a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788261018; x=1788865818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IgO2ob95gg6fumjWiN+mfIqaFjC/9ud8+iboIR5TNwg=;
        b=Q6vNaZuf9iWDfxOuNNZVl/lZ9P5DuJDi8HR4nRMaGyutWmCKO+oiiEfJ+mHZT/ZAzA
         Xf+5AMiXbEIitwvjcH4ommzo4p63jCnXuySLMBsDSsIklqtV+EFAjee2oUN39neScvTe
         fNiZ1tyG+aiYTuNPbegKzvw8FX16RiTlvxd8R2Y4JyNNu7CsKIQdJD/oe6viYLIXi5Sv
         E3ohQZcdlrt22asYt95ApGLBKiGRHydTW3ibvD1+FtduNvdvu+BQ0SdKj0Wz3TM5ibBD
         +vpfTIyKU2eL3ZSfxO5WjTxC019WYetG6G8g2blOsRIObTEoX5Em4LZi7Ad2ref4YOXU
         VUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788261018; x=1788865818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IgO2ob95gg6fumjWiN+mfIqaFjC/9ud8+iboIR5TNwg=;
        b=swcrh+dVrfBLoA80akzxCbVpTARSuzAE3ZHgI8A3vbMeZzgMWtDRbcKdiz+qXIskLF
         3qvd/KL+C67LuIkyXv7JumUwjW/N6JY5tMLhTfQ5vFrGyxtn/GJzlJLOnzMGab4lHxiG
         t1VvJBVb+vvR0COqAGbdkjiV5OrFjUdAcBq4dZZ/hlN433sP/eNSOOnPQHCnfjk4263z
         a6ksscOaaSyU824ouC3qzgZCNktIpcLlck4sxw9avvzzMLhHAEkqV3tjbEKkJUsKGxDF
         us79DmzlhgeeAjxls580cb08GC1Fx3FLreRhmyvKCcD6mkzrfM/jpPlKUvWmX48oi+Fb
         zb+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYdbY42XuRC6t7n4EStkwhvW2ZfskXZ9KQFqk3CzJDSdDdzwbAmPF4c5NCM/NZi8BKtmqq5fA=@vger.kernel.org
X-Gm-Message-State: AFuF++laR5+82VPYgnTEX3E7MWo7c5jeee3/MdTVVYqiFsLlJBjVRmUD
	i83zgZXf+mUuj30EhXhvkCk9nhHRFaCZ8pNQJQI8hY/LHpM4mIfJgH2Z
X-Gm-Gg: AYBFou3j0FzmAh+B9ESjbfgxNuGisT1LjKHCeinI0dWaNAp3+rypQqM95INUuNgnf3s
	33KEboMCkqrZ2Euadzx0Dtkzt0Qtx/3YpaCJTw06283IuUe3P9JA40Z6MbMOspiCigus6ty9g75
	TmLa35LUvhupAo36BuzlAerDM7Gl2Zl6ZLyfJM4yZQwZCI2Sy1vl1l6iJW2DCa9RPxYYitBTtBc
	nbLEBKJ6Ms/v/COi2gVewxu/OZ45VGVIeJvYzPz3OhZnY5A1DDM/tTOLmVQ6NXhpCRgLp6ERERj
	IyDz5GMKrHI7RjXR8sV7s4PqLsQPwagVe9LClKxKLM3vzlbCDufLXnVmCbZnOM2FSsrdfnD1gz1
	QtEyUlwluL7pbX0r+H9/fT+puFpkGw6cwywFFku69S2b1aetBrqeNXhojX6kkNtVV+fgS/FfLKj
	tMtNOQgg7zI+kDwYUpJipYsRTTR/h0v+mRl0yDtIlVjCJI8CnBHqaQp6Fz
X-Received: by 2002:a17:90b:3c8a:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-396d10076e9mr49352310a91.13.1788261017551;
        Tue, 01 Sep 2026 04:10:17 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d777c329sm7452644a91.2.2026.09.01.04.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:10:16 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] octeon_ep: remove redundant memset in octep_setup_pfvf_mbox()
Date: Tue,  1 Sep 2026 20:09:11 +0900
Message-ID: <20260901110913.977745-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vzalloc() returns zeroed memory, so the memset after the allocation is
redundant.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index 0867fab61b19..e4175d5bdb3b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -274,7 +274,6 @@ int octep_setup_pfvf_mbox(struct octep_device *oct)
 		if (!oct->mbox[ring])
 			goto free_mbox;
 
-		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
 		memset(&oct->vf_info[i], 0, sizeof(struct octep_pfvf_info));
 		mutex_init(&oct->mbox[ring]->lock);
 		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
-- 
2.43.0

