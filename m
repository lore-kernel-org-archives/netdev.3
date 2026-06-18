Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12068134CCF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762454; cv=none; b=YyCRM84voiJT6RCH1RWf0hxs1RQX/WSipHXf+pHk/OjoRf5MytH9sOxHbpNQ3D6e5xQzfiOABNBaVlvAE23pbgfXP8xDVNG2KkbWHp+a9oVzPpzaKWd69hOJ8CrzFSfP7ykbBZJ6SKhA6kYsiZBt9N6PD5rjRgAm/YEPcCaLLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762454; c=relaxed/simple;
	bh=G71YogE+n/9jU8/V58GXMgQHYVqh5Q7XO9xf3nluCNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R3NXULebzZaoCEbcIft7YkGL89TSu5Pgdw2//diTE2mZmYY7wh7p/m8WxI7+XzUSFW7SD3cKcxgj59ZxRgZXU98ZEjcYOAYhrBvkN4ngdnzRmO4Pqw0gI7Ohxi1dmtpjxURKOHBy/jNPn0EXFaoIKJ6RsthA2giamJZLMQGZqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjxnLSiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjxnLSiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1597B1F000E9;
	Thu, 18 Jun 2026 06:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781762453;
	bh=GHyAIZOZzbxFz6Yqz8TdYynWjNFVnvZCYDit4EZpysA=;
	h=From:Subject:Date:To:Cc;
	b=bjxnLSiSSSGGUa6neya8uGz9ktAUxE3ZDHJcrZDm0GoVSlLaZMdSca698vzEP6Ibp
	 2AIvZr8lRTs/COauJY3RIdHzyLiYN01o5IrQaVPfAGcKjY64XZOXlfGE7Z59NEnC2J
	 m9e/32ZwsMyv3QK9YZDVUomajV3S7YciE1ZQXO5gTAYN9c/jZfbf8eg4H+U11JxAP6
	 wkyNA2EKLq6DP0gFHLBkMW0mGEZhCk9A4LsTRigOtr2KVCnXSHH4hSMG1WFLiSNU/8
	 mgdyDr+yD3bx9yCDipshP/FrFvh0A2CWEeMUxMIJuE/S41Kgovbzq48sab5M9q/hqA
	 EiySo4BpvXNGw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net 0/2] airoha: fixes for sched HTB offload support
Date: Thu, 18 Jun 2026 08:00:28 +0200
Message-Id: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LwQpAQBCA4VfRnE0NMW1eRQ6LwVx22ZGUvLvN8
 evvf8AkqRh0xQNJLjWNIaMqC5g2H1ZBnbOhppqJK4deU9w8HtFw0VsMR26YRnItO4K87Un+kK8
 egpwwvO8H9klWA2cAAAA=
X-Change-ID: 20260618-airoha-qos-fixes-b6460b085680
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3


---
Lorenzo Bianconi (2):
      net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
      net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels

 drivers/net/ethernet/airoha/airoha_eth.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823
change-id: 20260618-airoha-qos-fixes-b6460b085680

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

