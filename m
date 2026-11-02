Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634716;
	b=smOtqmn3xz1t1y+HAR/0G8R4ROjxfp+7atwKR6Q6f9Cvx5IIOig8TF343jHV7jUOZq5z
	 1tw61BQXx4EiHx7lwPEfYWcD8oiw/8P1bazlY+KJXmyrsCtgoWN1ddYi/y2hQqXTwDQcG
	 ZbGg27meUKYjYci0iP1zUVkAt5TGU1AavOEWXR3Ijo3+m586BJ+pvTEwLk6dflEbCF4c/
	 5ar3hlw78T5WqCVRyL+Dq4+r+ZSA4rVmHPjUcJ2yHGSW67QYUff6HmW7NpkDlTEtX43xV
	 7ftqqeL3WCRzYUMzizCq2jr/YLF37o6kJUKBKjmXFK40CzivJQRV33YF1LKctfsnzjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634716;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=937nX/PE+DRlwUCkxy3kWZwRIlE+7A+DNKEqcWb94TY=;
	b=bf4UjwvfdEMsHYdcrcWEbk/0rN/GRfKd605Q4eQL2OW0ChJe5xiaoSPbdyEvlecxunfx
	 QzACoeYxXr3J/z3me2uXagrIwJe41kXFFMrCGXrvwGBwvvn1TVwmYXXuvz1LNE8lq+adn
	 cPLaz6W0pmHORAmJPsxsQwm664gF72uI6UkFIagAjvuBkt+/PyQZi+DSGQLfI2TYZxnY8
	 agUTV3RzxV9XuKYx66zys9A6+6r+JFtXvB9UdJGu+ppzyaEtzj0AfjzZsV2JdJNIk9STP
	 IvO7ahxhqj4a9/5H1ltTERibohjjpwMxID/braqRVNZSarl16VGxz1nhcbHfC718sfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=foxmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3295607A885
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3295607A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso865336a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634715; x=1794239515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=937nX/PE+DRlwUCkxy3kWZwRIlE+7A+DNKEqcWb94TY=;
        b=PPUay9gcuv2sUyOnv5K4/O62TOTCGzeJ/RI02oxgjhJcv9AcRjt9Id3hjojaFvxkRq
         I1xgISmALNMcO/f6BrtUUlCnuHEQtaepoONNkqt4oZZNGLIoHsg/yTn7xBNaAi3t8ZF7
         G0P3UKlooQZBN50C5w3QoTOYHbx0TXgsrVcvJHzHs3GlMQlPz3GdwK8yyr6CWsiaRJyv
         YqKYRuTPOi9Z4sja4wBmAVToz6NbRTSoYNVNQRhfAuvQ+2ANBV/y8tR6dXRCa16Ci9Nd
         m3IQ5YFwQU+zmVy4yxfEkfY74iqnx0ukIJl/Ki3LbqfTZ2xi4xV322kM4yqWLaEhMDKF
         QFAA==
X-Gm-Message-State: APuU4Z+hRLuVmi+IASAhQ/xlLqxccQQDM2WEiH5pSMLqZpJ1STsiL2g3
	hxkX3Qkr9uR1MeO975XmY7A/8ZyEUyoW1mOYhdU4rE8kN3VU+ZoM4lkTK1qtXIcH1/E=
X-Gm-Gg: AYBFou3CELL+QxZ1fjPkeb+KFRqjKps7gfqn/ePxyZnpV6cog6a+AvZatixl+h91YNC
	pSMl0bVoCe+8WJQW39vxqCJx1hWNX53J4egMRJHTWWTK5p9CvHJ1vNa7HEU2pt+d6bJb1G31/qk
	9l2SBwkUMvHHxjH8Idi7O501v7KrNjWEGknYqHuEurrtiXtcekE3EKhKdzwSaWJqR0THLNqwsuw
	5AUYjk5Ftkes5N67nVBx8cazXSbx9hnu7R+eD9NnClCcCZtHZsl8VEcFt/WkqVwwdhgSIDx/aBg
	ReqxuGKbeb5bkyTaBfnJvVq/oAK0LBSPj9mlY0ppXlqog7UDy9nF88WDL3M/BUBEivnwnxe58Z2
	ns9gAzZtNT3M719KY+yornHcsp+iC4mzI8ZzL1GbWmgiPB/PjziJJjpSLB7zb0+pIHzDcEe3w9b
	qtw3jXeua/65dKl5YOPzbnutP37hPDrApoq2InnEKNFf7DST0A7dWV43kXlZjrdvAl+4UNaeoPR
	TfxTTo+pk8J14Iz2Q0Q6lnF3Qsn9jyN4WRG3p89CIdSU7qo+TwrMFe7UZSBAEw5QkFkWj9g2LiV
	2UTBaiI+noS93IHkqh0keEPXJJc+QAZzt4byXdeIvR6czQ==
X-Received: by 2002:a17:90b:4483:b0:3ac:9259:1234 with SMTP id 98e67ed59e1d1-3ae8979ba8emr8642033a91.39.1793634715031;
        Mon, 02 Nov 2026 07:51:55 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm14267953a91.11.2026.11.02.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:51:54 -0800 (PST)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH v2 0/2] virtio-net/dim: fix irq moderation init failure unwind
Date: Mon,  2 Nov 2026 23:51:43 +0800
Message-ID: <20261102155145.23144-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
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

net_dim_init_irq_moder() leaves dev->irq_moder dangling when
profile allocation fails.  virtio-net probe then skips the
virtqueue teardown if that init fails after init_vqs(), leaking
the virtqueues and their DMA mappings.

Patch 1 makes the dim init failure path clear dev->irq_moder, so
net_dim_free_irq_moder() is a no-op afterwards.  Patch 2 sends the
virtio-net failure through the existing free_irq_moder unwind
(reset + del_vqs), matching the page-pool failure path.  Patch 2
depends on patch 1.

Changes since v1 [1]:

- Patch 1's commit message now documents the call sequence the
  maintainer asked for: on current mainline the dangling pointer
  is never dereferenced by the only in-tree caller (virtio-net
  probe does "goto free", which only reaches free_netdev()).  It
  becomes reachable once the caller unwinds through
  free_irq_moder as patch 2 does, which makes patch 1 a hard
  prerequisite rather than a standalone bug fix.

- No functional changes; both patches are identical to v1.

[1] https://lore.kernel.org/netdev/cover.1790751008.git.shijianlin11@foxmail.com/

Jianlin Shi (2):
  dim: clear irq_moder on init failure
  virtio-net: unwind VQs when irq moderation init fails

 drivers/net/virtio_net.c | 2 +-
 lib/dim/net_dim.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>

--
2.43.0

