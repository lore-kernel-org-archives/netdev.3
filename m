Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47E3C1400
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062973; cv=none; b=GRZO/TMK/gZu6mpEAUqkxwqPUeiz3lCEr7lBCb0o6vd+/5m8auptnO12FNkqNrrTglRg1Sir8sgbwjcFkWK1Sml408hZGjtw6UzU6Uv5lFXPKcpdGvK2FYS2mRDkyG7eqCNkPr1MEavKbCoWd/BMCqMN1bdeCzpMORklb+YviH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062973; c=relaxed/simple;
	bh=6mIcN5UR5Jby1K67kSg7q6vCQLLiQj+bsnPcHyWPHXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqfkKH2ILed+fve5fZCG6PCDd5KKM5ORtp+q/wDKMIVcYyVQeDCl8vy1Zx4yEFPMUwkenm8e5YWQLnH/MN5N9+26BAJ1SZvIBg4+UJPNO2aTyqFe26l2EgRUqNPmuyU5rkT6X9zKIkLokXaJzBCW+6HbWBNG98SuYj/R9BL1zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=newp8E6P; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="newp8E6P"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0b25dso41109825ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790062972; x=1790667772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4bXv4ioTNcgEst1EUu0msleevfYTOmr0PXPd7ZaOJ4=;
        b=newp8E6PQSiBq7JbvDujX7GXrvi4EgGUlvyIx9af2uRw077RSCpH9XzOnxRRHsPfGx
         0R8VK+a6ZuxjvTIHJmapSDY+KAz3AMR15gNYjDEhHxp6Mq6BfMRUEK2eEn27ZpDx+5IO
         Ls7W6xessLJw1MSxxQb4u+qKxr+luopUJOOk5tSCCHO8DtB6yg6Cv+rbTpmAkJgrtG9K
         yvB55fMoOxOjBNE1ADMVK5MrWxB/ATQqvccOVX4DkUZrewOtdPMAmOuTWDYMZWHAx9fp
         MhEUbr/+1fA1u8Wiq0wady8H+j0cZV6AtX3bfDQ8syeda3qVCJNBzhcUVMB4uHa4ntVl
         GhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062972; x=1790667772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4bXv4ioTNcgEst1EUu0msleevfYTOmr0PXPd7ZaOJ4=;
        b=XbBnBspC/+hU3zAQrtDOMk2rPzZXqKnClrJwzCBRCV0reA+dPrTWxcQkg5WsVCPp4J
         GhGyKMv5w9/FvsRMXtispYt/W/J2fRQm7vWjZwfkZfyWnBxL7/m8tOf03c7qW9ToBuAx
         TxmTvoV/MHWyTlmRXaxYpdsYJBUPt4ZICLznK9UqeMLZsL32O7c9kXonu++MqL2lMFBZ
         LQUHrX6F0syCaFouS3tT/WitWJNwp7gyKcHsaHbWpIp65AMV0P78B7vRNf1SIKAJ7U0T
         qfOmd358b1ibThafG8ixnP2Hg+ExIdbvzccMKK11CmXAaz+t+QcV8h2fjPxfzlmVtTRJ
         WYWg==
X-Gm-Message-State: AFuF++kdTaCCmCXAvXKxfLl4Gy9BlFfrjKId2g2T96Ylcigh+QVY5Jqq
	X8aCOV85wWfezoIekMFdGzxdjHwLvkPe/h+F2nhNwAPuwEVMVnjjCeu2
X-Gm-Gg: AYBFou3YS+XfA8PWcuWFcyNes9eJGBp4krNDqPTVI6NluUpmTTBTxmodCigH1YE13Ks
	hO5i6BNTUUFdhccoPrQvnqsSOwJDRJUdiY4MnedhTGwCNByn/Y+Vn2i3wCUlBHyW9FsuQ4Et4qD
	YIf7vIs6u5BKtl7NiVblqAMsvHcHPb2Y6LKqJRV2td41No1FjOkxRzG+al+/4xRe88VK2JKHT7k
	Gv3vFrq9ieT8kCkwFd5gsho2xcJ1eo6spHmAJMFRhhatFwcFDn+B7O6P1HML4jefPVCW/KcYKKi
	YvDQxrgeIKqoEO9nU/8SAXtfb9SdZq3wFXzUuyvlY0jo9hNsyzw+e9dwnB+aGsjLEJwTbRqlTJw
	UJQFbGIDV+K3b1bsqbVp1flj7O5XDin0hgLIdW8Rka1ixi+OUIF1CJxUAXghUfmqMlq2yIZWBUV
	hhpDl6OPlJhailNTdqtwgI1Lln59VhABU7FS9ofw2AEPWvYF2vOq9Wil3BiKQP0c/Ldt1jF2YHU
	9J0p2h7RwAQBzN5ZErlC27uYwW0pzezOB8angxt0zO3xYGurR6bnUf9
X-Received: by 2002:a17:903:2f48:b0:2dd:c100:3131 with SMTP id d9443c01a7336-2df60b4cdc6mr3361165ad.45.1790062971717;
        Tue, 22 Sep 2026 00:42:51 -0700 (PDT)
Received: from localhost.localdomain (5.240.104.34.bc.googleusercontent.com. [34.104.240.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d05602csm5215005ad.65.2026.09.22.00.42.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 00:42:51 -0700 (PDT)
From: Ginger Li <ginger.jzllee@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/mlx5: HV VHCA: Fix the agent registration race
Date: Tue, 22 Sep 2026 15:42:46 +0800
Message-ID: <20260922074246.20411-1-ginger.jzllee@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5_hv_vhca_agent_create() drops agents_lock between checking whether an
agent is already registered for the type and publishing the new agent, so two
concurrent create calls for the same type can both pass the check.  The second
one then silently replaces the first one in hv_vhca->agents[], and the agent
allocated by the first call is leaked.

Hold agents_lock for the whole registration.  While at it, read
hv_vhca->agents[MLX5_HV_VHCA_AGENT_CONTROL] under the lock in
mlx5_hv_vhca_cleanup() as well, since that slot is written under the lock.

Fixes: 87175120defd ("net/mlx5: Add HV VHCA infrastructure")
Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
@@ -228,7 +228,10 @@ void mlx5_hv_vhca_cleanup(struct mlx5_hv_vhca *hv_vhca
 	if (!hv_vhca)
 		return;
 
+	mutex_lock(&hv_vhca->agents_lock);
 	agent = hv_vhca->agents[MLX5_HV_VHCA_AGENT_CONTROL];
+	mutex_unlock(&hv_vhca->agents_lock);
+
 	if (agent)
 		mlx5_hv_vhca_control_agent_destroy(agent);
 
@@ -270,11 +273,12 @@ mlx5_hv_vhca_agent_create(struct mlx5_hv_vhca *hv_vhca
 		mutex_unlock(&hv_vhca->agents_lock);
 		return ERR_PTR(-EINVAL);
 	}
-	mutex_unlock(&hv_vhca->agents_lock);
 
 	agent = kzalloc_obj(*agent);
-	if (!agent)
+	if (!agent) {
+		mutex_unlock(&hv_vhca->agents_lock);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	agent->type      = type;
 	agent->hv_vhca   = hv_vhca;
@@ -286,7 +290,6 @@ mlx5_hv_vhca_agent_create(struct mlx5_hv_vhca *hv_vhca
 	if (ctx_update)
 		WRITE_ONCE(*ctx_update, agent);
 
-	mutex_lock(&hv_vhca->agents_lock);
 	hv_vhca->agents[type] = agent;
 	mutex_unlock(&hv_vhca->agents_lock);
 
-- 
2.43.0
