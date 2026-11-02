Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634728;
	b=KrN3PB/yWGjOrjjk+Bb73c4lQQVabpMqdK3E0sO2PUlH4kxSzzlmfi6sSJ+RhUtLjseb
	 yHKobl69kWFr0aSWZI70pofzvA3ytOZRbsdqKIwGJ3qTNMxgv4DWtTWC9pJUnN3B40AoN
	 qOJMi9r4/4L43NtL66c7FjrbhYkmxTnGo+QaWQ0JgIhBIFLMUxb1bExRmg/iSNhP/9BPu
	 zl88qhEYTPhwHtQlPJGZdZqnjOx76qU3vsFJIOr9xLY2LofIzfAbmOl1GaaHRHVYSa6BE
	 RM5ZcPuE4fBmWHgh7S1Z/dUeQ1hIAyEN5/yi9PAZQE1wNkwKPr7d1GWtAG+HjEmyARw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634728;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=poLpXaD2cnjCIvUqVuMOp8pFOOer5fR1DGYJw/icaNI=;
	b=lme9gKZZjcQ+MZTwezEkftJtNKaFDmj1sQlLK7UoO9OaUcRRfpHQVwB+vVviVq9qvFLY
	 WQgjt5Rdt7V1aMMbeo3LcxQ3JvcqkXKNa/noIM11xYkVhBDuPWeLChhLiK+5m5e6Hl4/1
	 eC+pgU0k34iZbk2U9KXH5lAyephMa2EUUUvQm0dHO3k3GPtOvLZXRToEOjbP1oApbosdk
	 0wKyix4NbDa9JKwD2J06Emt8osF061zjjyQSDpVQvREP2TiT797pIVttzZ1+Er53+5mAX
	 V0iRzBdTeNswjU9ykgQgeAOkncXMSYi/HjtOOHMBtPVFv6btPjpPQGgTyCA1oTYJe1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=foxmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765696079040
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765696079040
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3aec0b1d816so559058a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634727; x=1794239527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=poLpXaD2cnjCIvUqVuMOp8pFOOer5fR1DGYJw/icaNI=;
        b=ONwje+EJP+lwg6JTBOOFV6GPFRxfLORGJ0tkoR3aCq+LGHL1xg623Wt6OnjgzMfW7D
         pymvN0SMRgEhE/M0LVqUuxwuzYjExOWZJTMaQd92zbaUlFyxyeKFRBTsRCiAdMCIO1f7
         lKWFjN6hKN2Nlu/eJcbXS1+h6qifD8KhiqveIbY84G+UjIUO6MzIcYlWPV+6TQ3Oypd3
         zSz3ds2x1uw6myZCw9ecnAEMGo6mhWCTPbdVZO+2JLFeOh/cG8GBuNHQM0+JSY4s7QFE
         90y3OZhDxVvZjc9poEdeFvPx2Ct/qTr/T0Qn8gjr0f4Q1sOJgvdvZEaB7eg8xpMupz98
         qbdQ==
X-Gm-Message-State: APuU4Z8K5AzLxHAWPWRyE0KOADjd+hMLwZakrA68/9KKMvW7YqkT4i0i
	yG6IZ0MHe1kA0eU61amQ+ndigWjLdAR/AbWTd8AAsBxp9Ee/QOZCkiFAzQbXBMKt
X-Gm-Gg: AYBFou0dxY5UL9M9BZ9jxXPumAW7raU4KNUEplV+GjX2oop42+7ijJ0x7hpcX1fI4T8
	am/aQvNByJxDEZqzoGRhnNn8bo27XU3SYrCPiLDiWueLvquAX8y6sRKrFY0PmyUJChTl78R7fMZ
	brj7aPoXIxqig6XFhNP/8Q7ZkekiukmccDh1ThllsMMy1sGgrf+sBp7Cqa3QoF/BeHjuDo5r/9A
	84smczQMJOG403dZrTjA92xA7KCRo3Jx6H2sy6MudcU04fyIhdJTodytTYibu8V7xz0WtcX1X7h
	KL/wCCLfmBRUEXnM8idWzptWwnDzwl+vSUKdLyStPcgwzyYXQC1jHHUGadOw/ZwlhaGtSh6rZUd
	8AZ8m8ftTNYuNPRaA4ixcTzziGQXL2peQ6BxaIaNEEQGiCYVsys8JIPvnksLftMKBuJFM8qz9/D
	hEOpniwBqsGQst8izWr1ftrUx8CH4TsoWQ8RY0P1J93ZgEoc1SO5edJqywmCN0JRDNy2H5E7whS
	cECbJURzcZSTAX8IEQ4LhC+/bvr8+nZBRA3xZk9asFWF1sTcT56E35q4TMqOlVLM2EzXUfpIwPL
	ujQ97zk6inB3J+TaH50Fo2OC3W0J/qFzDO6rYDb5ngFUcQ==
X-Received: by 2002:a17:90b:2246:b0:3ad:870b:b6d4 with SMTP id 98e67ed59e1d1-3ae895a561emr9105964a91.1.1793634726810;
        Mon, 02 Nov 2026 07:52:06 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm14267953a91.11.2026.11.02.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:52:06 -0800 (PST)
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
Subject: [PATCH v2 1/2] dim: clear irq_moder on init failure
Date: Mon,  2 Nov 2026 23:51:44 +0800
Message-ID: <20261102155145.23144-2-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102155145.23144-1-shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <20261102155145.23144-1-shijianlin11@foxmail.com>
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

net_dim_init_irq_moder() publishes the allocated struct via
dev->irq_moder before copying the moderation profiles.  If a
kmemdup() fails, the error path frees the object but leaves
dev->irq_moder dangling.  net_dim_free_irq_moder() treats a
non-NULL irq_moder as live: it dereferences
dev->irq_moder->rx_profile / tx_profile under RTNL and frees the
object a second time.

On current mainline the only in-tree caller of
net_dim_init_irq_moder() is virtnet_probe(), and its failure path
today does "goto free", which only reaches free_netdev(); nothing
calls net_dim_free_irq_moder() there, so the dangling pointer is
never dereferenced.  The bug becomes reachable once the caller
unwinds through the existing free_irq_moder label, as virtio-net
starts doing in the follow-up fix:

    virtnet_probe()
      virtnet_init_irq_moder()
        net_dim_init_irq_moder()    /* kmemdup fails:
                                       kfree(moder),
                                       dev->irq_moder stale */
      goto free_irq_moder
      virtnet_free_irq_moder()
        net_dim_free_irq_moder()    /* non-NULL irq_moder =>
                                       rtnl_dereference(
                                         dev->irq_moder->rx_profile)
                                       use-after-free,
                                       kfree() a second time */

This patch is the prerequisite that makes such an unwind safe;
without it the follow-up would trade the virtqueue leak for a
use-after-free and a double kfree on this error path.

NULL the pointer after freeing it, so a later
net_dim_free_irq_moder() is a no-op and the device is left as if
initialization never happened.

Fixes: f750dfe825b90 ("ethtool: provide customized dim profile management")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 lib/dim/net_dim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index d8d4f6553559..bf59deae6a29 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -141,6 +141,7 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
 	kfree(rxp);
 free_moder:
 	kfree(moder);
+	dev->irq_moder = NULL;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(net_dim_init_irq_moder);
-- 
2.43.0

