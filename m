Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1A4AAC5F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685103; cv=none; b=OVSol92n2CAd/WQvEiNRUPm1MqXo8ilnEi3kuXCsSDfSbgYkGJZMb7yLh9a+Js+R5kPqCA8OXoR2R6EEX9tax4WfCJh5myyuYI8zP7p67jZ8AEhUMluQqNYq+7HtUsuDd3V3mmmQj1bICWS0TcSCZnz3AMVmwPWLz8QrhuUUipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685103; c=relaxed/simple;
	bh=MMGqhigaLhysW4BdQ5whTnIdZUXMgIYhziKytVKjvs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXMk/68BWtc6NJzVKlKkw6hJV7zpPXJ6ma8e7MH4wVBxWYDNS3jDgZpQhRWVdGOfLyF9NhSqsvwwuRd4VuLIzfA4eKqGouQXo8BNkOH4TrvaxV2w60iWcZsxz9MPT+L/pG85P1gpl1B9LTpcln0hlgu0/SPlakxBesSHOpdzA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bN5zKf5h; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bN5zKf5h"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9ab667so220727fac.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685100; x=1790289900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5eSXWAhWHEAnQkPHwG2jyhqQKorgUEuZqHe1HZGCdY=;
        b=bN5zKf5hQ12Gk7Y3XUPYusdJtaCVXF98K2M9NohPLyFgyQf0KfTT9HoT/o8biBiqoV
         ktxR4clhNK/5yaRdcRPhZMW40NYWQqQyC4YUlWYv8jJEOnShLKBRQyb6UdZ2iFEYsL2B
         mEG4t4pK2pqHxzRKax7acT4E1xkXhzeecxbhTlDrJpQ8r9VghT4PxFUJBN7mSn7np3AT
         WXQTUDoS+zZ90Q4AD4DrMjzX3LeUW++GdU1Zq1xEr0A8ZFyrMPS+t6q0NukRH4YuYHec
         lW4/ABz88Y27lx0XU18NZ82paMi2jP4eRSWHPE3GvkyJC08KesuK6tuOz8wl9X+pwmkh
         qCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685100; x=1790289900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5eSXWAhWHEAnQkPHwG2jyhqQKorgUEuZqHe1HZGCdY=;
        b=uvvwtGo8KQd7IsP/TXiLrtCUy2fAtTgsXxSEd2rVaBIl7J3Tv2lqXa59wQUu83zn8R
         iGClSqyQwF8XHrAM99SJycLmQ6ZQ0b1GXCQ2Cx/Ar2c3jKgKAIT/8JzlE4/R+wmumh71
         3+kyBwXatXC2SIowEFDzg1SPsOSGqQTNXF4mSBX5GacNs/Zmt9pv2fp8LZ+GONffER6K
         vGSvQ8ij1+aO65fCE1zwoFiKUl5nQVszAYFcb8h8DnPO6cNOCY+Js+9i3++ptCj0GZpc
         +4oWmLpDBOG3VTKV8RnMqTY7Po7iCy9UHFEvnRSWethSiUpGvS9H4yBtotlFr9CFDRVl
         VqpA==
X-Gm-Message-State: AFuF++nCCWJKnzhHyg2mFDiozBzzMCbcERNBxaryfiRYgbOf6HSMBt5E
	AbQGQCDmV0TwgQTUdCeuVj3nZrG62diEaY5A0UNjg/FCGVzTXw8e4Tw/hycGXlACzHDFordw8+/
	Xgi5A54k2pDbvJoMwMywrUpi2gIyKxB57kAifz5RS5NVGtqiq460S9NCe58KxJ52TJSwIMxb4Hy
	JeBWLA1jU+6wa4iJn1e+IvbFMv5M3qjollOWK3Do2Qf9y/SKs=
X-Gm-Gg: AYBFou0cQxq8tv5T10v3+EpdQg8Z7/Ty8KnHGNy/heGjRijyVIdwrqF71RXZK4NLPAR
	e3jSLvVTc9i8GyYbqWm05BBGKq6EO2rdV1PrhExQ/w924+r6CAzQGrXljvnj6QVbbVSmpVBAVSR
	wJ9eiVUd/gYCZzkM2TBVWF74xa6wIy9WyOCckDGySRW95Hntg5GKGXGWCROgs0+TLDyGrWgLux4
	KtiLsbs6MA1UY9BURnt+vwTfMvZBrzGzv0Sz3Jp7D0lHzwdDEdcs4DIATRM0vgZywNc4mZapuh2
	rNedf8znKNstKbdbl/pxKTKgrWIB1h9BKXz+b24r/sXstC0c8eQ4UsyjBlDTEhXoGUpDOsZxC1D
	qBt6U1ZhMV2rmLXF4j5GhT+XumFaZr+zySu0XddMyn3HumqnCxsSTTnbNmheTtOgDEzjpwu3K8B
	8pSyYHjh6qHgRSWgvvh2+ZNgQPtGc0PXfD+C1DK1vEKciLt2T4fRf5ElJKyssTk9caoUNXBkQkH
	VGQ2qRVcZwcZ4YjUwJ+ryG4S76GQogzmWCOvtByIcPjWYe8FCI75RYEMjhCKYyjiy6Nst7sOEQ2
	Hta2rt8WslT4x3fN8TPlITjgmrL+yspU1XVPBWbnd95V7fT6WYVz97p/QbligSLWy77B3ocX3xE
	pfoHVPdkfm5cL5JSm3Xo=
X-Received: by 2002:a05:6870:8309:b0:464:f373:b579 with SMTP id 586e51a60fabf-486e2a9a4a9mr700317fac.0.1789685099792;
        Thu, 17 Sep 2026 15:44:59 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:44:59 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v17 01/15] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Thu, 17 Sep 2026 16:35:12 -0600
Message-ID: <20260917224355.2288021-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers only support TLS 1.2. Return early when TLS 1.3
is requested to prevent unsupported hardware offload attempts.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 3 +++
 drivers/net/ethernet/netronome/nfp/crypto/tls.c                | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index f5acd4be1e69..29e108ce6764 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -431,6 +431,9 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	atomic64_inc(&port_stats->ktls_tx_connection_open);
 	u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		goto out;
+
 	if (direction == TLS_OFFLOAD_CTX_DIR_RX) {
 		pr_err("not expecting for RX direction\n");
 		goto out;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index 9983d7aa2b9c..13864c6a55dc 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -287,6 +287,9 @@ nfp_net_tls_add(struct net_device *netdev, struct sock *sk,
 	BUILD_BUG_ON(offsetof(struct nfp_net_tls_offload_ctx, rx_end) >
 		     TLS_DRIVER_STATE_SIZE_RX);
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		return -EOPNOTSUPP;
+
 	if (!nfp_net_cipher_supported(nn, crypto_info->cipher_type, direction))
 		return -EOPNOTSUPP;
 
-- 
2.50.1

