Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A72C11DE;
	Sun, 29 Mar 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789718; cv=none; b=Qre6rI17d/Pux/uuAvIOomsFz3agR6H5Krntc3wievErz/akVl+aI8qNMHK3ZA5wRuMxaQAcy06W3fLLPlVPQTg89okeiwHxBqd+J2s6KvTwBhC+5L1hXbLKhSZeh/yjsBUmfzREgNPkDZTej2VsLn3d1+/Qq60MoRwcrkx8Mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789718; c=relaxed/simple;
	bh=NtIVnwf+1fgtgeX/jdcQtNcD6iSxFVArk3xsGmRPJrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkeY0prvv/zk/NGeFzVgoxDgcHlkYOBpQBRhrIFNzJjhVZ9YG/bUZDvVIBzLt3BqtjAp3s6vSkfY99QhvYSkgo1utImR+rqhRLXQNqbYujcClMXOG6gqXq6OVWLa3Gsz0xcUXc/3uNT8MJW/JoROthMXsoLcXvuM/1vyxRkPAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUr1td5z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUr1td5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE146C19423;
	Sun, 29 Mar 2026 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774789718;
	bh=NtIVnwf+1fgtgeX/jdcQtNcD6iSxFVArk3xsGmRPJrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lUr1td5zVcFVABKAHpPwbuSgT0Q5EXs0FY5tM0Xe72rJtrMpnJdVel69m0ukVJK5W
	 hIikSQWgRn1KU8aTCOQYSnhePPQNZtxWgGeHlk/JnxPzUibs+wkyGmqY92kDcJn+W0
	 H02TCwnIToQFncplcYvqNA0Adk/JkZpgGXJ5HRRlA/KF3L7dNbIOAnopZNpj+uFibh
	 GtUzbwwbNSt651xmMNTkPVTQktATmoGjKJnisDhXeyBmc0eZU9ks8oNQryHu+qp7oS
	 Whcbs5hU8u6jk1yRXCjxGkt9dL75lpJzNN503SQQbaAsYS1WIWvVimqnCzjdmBUu7R
	 L0GjRPu7JEBoA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 29 Mar 2026 15:07:59 +0200
Subject: [PATCH net-next 09/10] net: airoha: Do not stop GDM port if it is
 shared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-airoha-eth-multi-serdes-v1-9-00f52dc360ca@kernel.org>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2

Theoretically, in the current codebase, two independent net_devices can
be connected to the same GDM port so we need to check the GDM port is not
used by any other running net_device before setting the forward
configuration to FE_PSE_PORT_DROP.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 9 ++++++---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 11b6dbf3fa80c0c7620fc912b4db904eb5711b2c..3926866e711e51bb20665dfda464c5283b7616fa 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1662,6 +1662,7 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    pse_port);
+	atomic_inc(&port->users);
 
 	return 0;
 }
@@ -1681,9 +1682,6 @@ static int airoha_dev_stop(struct net_device *netdev)
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
-	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
-				    FE_PSE_PORT_DROP);
-
 	if (atomic_dec_and_test(&qdma->users)) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -1697,6 +1695,11 @@ static int airoha_dev_stop(struct net_device *netdev)
 		}
 	}
 
+	if (atomic_dec_and_test(&port->users))
+		airoha_set_gdm_port_fwd_cfg(qdma->eth,
+					    REG_GDM_FWD_CFG(port->id),
+					    FE_PSE_PORT_DROP);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 7549960fc37c68a5df73c49eace0aa57fda98030..c076e36b741ce691cf309850435c352fc1fd7986 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -546,6 +546,8 @@ struct airoha_gdm_port {
 	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
 	int id;
 
+	atomic_t users;
+
 	struct airoha_hw_stats stats;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);

-- 
2.53.0

