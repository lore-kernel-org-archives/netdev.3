Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483642;
	b=LuuwUjYE+/1F2NUDjr5Le2Obh2BaQHUWVAplT7QYU8X53dNA2CMoN+1+mSYvyv/wiNzu
	 GQy7SSPOvHaC/ZgwZWySBx75Zj0e362UAKyVdZnzc7soaVm63KGu7WfJ+tdGmqPUCD00X
	 U455ZGUGG0nfy/ST9ngKMBcMl4ElQB1Zy6srXqwnZ0vaCklVdlywKnQa1YBRVCYuQUeEI
	 72SN9rynOSNLw7OWFPiACIRo3uUEFc3iffOUAkv9jraofRuZ6rZZt1FWeUP5v/R53nJaZ
	 qZEzDI2UDp/0RDBi02SAeXz0s8ri6Aw9s2Ri1Io52wV7ZXLtj6USC0gACQbh65epATA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483642;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=Vp7uBehDsBoSgh8K5UFAlzz0iAriITFqbhRY3HJwCtM=;
	b=bertH9vDPqKQm79dxsJ+HVUy/Qa9kUlsH3hQdxRyzQAdPzp17IRF8siBtrhi/CMsKdbr
	 ToGDmYC7kAQybI5DXo48RjES+naLBlDT01UgrQ49BnqXNnVt1jOM5TfVjtKju+LX1d0Hm
	 tuFpJvpJjNg2TesE8le3vzbL7ynoaNe3MteWGdOPTB2r+6KALQBrOzpltQGtfC6sfd9rK
	 zCckBdfkiUIons8cgJkJVTe7mJTEipfP1WvTscjHL0/xWYg4ngA/5cLovHi7EzvX1fJDa
	 /vuzSPsnEt6rBmM7OQHpTMPNXRxdnqe0IcDzvtvTChahIckWE1n77AIR4+4nFce8tew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jmu.edu.cn;
	spf=pass smtp.mailfrom=jmu.edu.cn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63194606A32E;
	Thu, 12 Nov 2026 11:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63194606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.lan (unknown [14.220.232.40])
	by smtp.qiye.163.com (Hmail) with ESMTP id 547477c92;
	Thu, 12 Nov 2026 19:40:26 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: andrew@lunn.ch
Cc: Frank.Sae@motor-comm.com,
	amadeus@jmu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: phy: motorcomm: add led_brightness_set for YT8521
Date: Thu, 12 Nov 2026 19:40:20 +0800
Message-Id: <20261112114020.3344472-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <45f91901-bb11-45a7-a09c-db9ed4ef0117@lunn.ch>
References: <45f91901-bb11-45a7-a09c-db9ed4ef0117@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1cf8f239a03a2kunm074696c01cfe1f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkgdVkJOS0xOGEpITRpCT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVU9LWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG

Hi,

> You can enable it just like any other trigger.
>
> I find it useful to know when my bugs have caused a deadlock, etc.

Okay, I understand. I tested the heartbeat mode and no issues occurred.

mdio-bus:01:amber:lan# echo heartbeat > trigger
mdio-bus:01:green:lan# echo heartbeat > trigger

Thanks,
Chukun
