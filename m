Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4A40B0F9
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134186; cv=none; b=ZZwkO4V4vyOmfTpGpUnBcUhI3zFpJ0RyXAt21Q9toR/SYReQCy9203AFYlCDzJ4guTbjl6Iyg14NUZEHTewRp5sPZfKio9AGZTK36qbwpFCcd3y21tE+0e5S8bHcKhMyqBN8sEWO9/t677HbYfiW2n/LYN+40Nhuxf6yiBCBzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134186; c=relaxed/simple;
	bh=ITxbZyy/8+4On80Giq8R9Rj7Fl1GPU/lQNDmPuwvfH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pq7NLqm/9AT01KOPP1RvqlTVyZKdrKSKsPBhdZKnbnj/E6QoUqlRaJSWBK/uVg6Uijms44cZeXTOG8dbERocRylQVwM6IwI8SwbX1gBwGOskj9+6tCBU6wlDIawen5RbDZ0ySgcwmDU3Ykzn6x9A6MiGLI5jfKDhaAnXjv8wKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=mfNJwzLN; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="mfNJwzLN"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e0b486d91so194211166b.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134180; x=1791738980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=REM+0eVSevhhqRi1ya4wokt6SQ21EvmCZ8tdDdEeLnE=;
        b=mfNJwzLNnGo1k+13OZt08ghMO+MTewabqrH3O8b3uR0wZv60U7jgUtjeTT9dAKsd1g
         HgRHrdJUVJV/7R/WnEePvFkqFgl6malSQiCETefJGVy2N/da4cai7v8re9eGX3LrAlwa
         lBBO6EnSwamA0dX2Hmwt7sxYHJUYPLiYL6J3fV7A332Z7zdc5oVMjfvqAPiTvemxcz15
         mevIllKwfabl1+UY2gp6BMhou50p9bo0Mvsn8BuzhgBSar/pogu1rxWo17eA5tQKPWNQ
         DVxJhGMnHtUZWfN0fc9QwnMcwZtVbcbZmQhZhv78362coqgJomul/K3SO7Dy/5tw7I5f
         4Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134180; x=1791738980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REM+0eVSevhhqRi1ya4wokt6SQ21EvmCZ8tdDdEeLnE=;
        b=EExaye0b4Y/Q5j0VjpktdYizKdcUC52Y3xNZonnyIqP5CNT/tEniBbKSFQGHkNX+XB
         cfQ4/1tJ1Q0B5iWK4hdWQb3qT8osKVTegk4EL9uczxoeoRPgeyOFCau7sTVjjwyB1RZr
         PIk+tUtNX+Rb20dHEHU6PAs7eKxOqH39egXACFNB3LMyDAKBdko3JPKVP1z8BmpIBSdd
         yjkWO58xH7Uyl/5Gz//Bl/a2jWTVnTMk9WL8k9aQiWzzLDqhRTLWdFkt+/fXpdyo+Jsr
         vrh6IoIlvDHhzVTm0kMuEslSe/BteH/fA5VeBw2mU4MSX6fgvB0kr7t88MM0WXVIU28P
         SZdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeVx+xqBxBL5Glq7OCue0dG1u+dTiWUjx2PxDi7D3ZJ1NVHIWLf0RH6EtfFWMAJYdMS4xbjiY=@vger.kernel.org
X-Gm-Message-State: AFuF++l16EfTxedX50V2lXmdDmEbxHVGCrfYKtzsjykOaOt9C9PPtH+y
	2dcGyknLGabA7YpcMFYlmw8xHQxQiPfvpirmVETrWFH//3pT0C8xoWXp7aRXxTEBVA==
X-Gm-Gg: AYBFou24t+Y5vKK884OMAA75mjsfum9fvYj6QTotWTJ3NSNsHLygkkm+/iA5UPEXU7B
	jlgXJ8r5+P/H4woAoCkMnIx81La8snHUnMeE913MtuaDRTAecvIEJ6IT8nuFyizdYKgugcCANuf
	CqF07inXLhqcPnODMqJkWP/gRsHIrTCuDbQwd2l947Yv/26/8H0kStDq91Gx6NFuZMmAuw6KovS
	9u2X7D1x32KPDxylHGLSaNrBNbNRRByN62RXzxHyGqKQVQyMmJ+TXtnYKZsQL7hR3/GSgUWrNBR
	q8aIVmAoCg3qgg6n2s5T43Luk2eFZ3tSYFN5lpOxZZjrgYQs+OSfC38eofUOV+NaJgo2Phdhf8j
	unINYK3UZVeIpNk1P/5Hlyig+2UWdVym6sb9u0F8lXkuXFPjUluu5TIpnQXSQldbomXNCWOGy1q
	eCipzvJObNStzuHNX/JitVaOmcw7RB2R2ZozAiAh3JxzhzrLQR+UhY5vimBs3fDlLAvsS2Sw0BT
	tOQQt/eZvWKILZZ3NgSL/A5bQgs5HtNBgdi3slXA0ymKnGASy/xsCrcdUMw8rVIaMEXumGvd131
	TdbwSAf9c2wgJEuW88pxhENQVHHeqM+rhXklEK/pTM6Mj2UM1JPRxZ6hndJGqDVPsZ7xSvx6cy4
	/3+yfKE6Rhhh9EO+yDeFgSVfC8oil90T9vMR6mNjKKACZFlMeEhV7DvhhG6iiqqUblRlWLKQEvo
	t1QJmBkwWHFELs0jTR0cJSGLo=
X-Received: by 2002:a17:907:cf86:b0:c26:19de:9ad3 with SMTP id a640c23a62f3a-c2e4af70e4emr698023766b.43.1791134180574;
        Sun, 04 Oct 2026 10:16:20 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd278cesm314885266b.37.2026.10.04.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:19 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@nbd.name
Subject: [PATCH nf-next 0/3] netfilter: flowtable: update upper device stats in the fast path
Date: Sun,  4 Oct 2026 19:16:13 +0200
Message-ID: <20261004171616.3544880-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the software flowtable, packets bypass the bridge, VLAN, PPPoE and
tunnel devices above the flowtable device, so their counters only see
the first packets of each connection. The classic forwarding path
always counts them, so this series does too, without a flag.

Patch 1 adds VLAN stats helpers; it touches include/linux/if_vlan.h, so
a netdev ack would let it go through nf-next. Patch 2 updates the
counters from the fast path with the lengths the classic path counts.
Patch 3 adds bridge, VLAN and tunnel counter checks to nft_flowtable.sh,
which fail without patches 1 and 2.

Hardware offloaded flows are not counted. A GSO packet sent through a
PPPoE device counts once, not once per segment.

Cost: struct flow_offload grows from 296 to 328 bytes (slab object 320
to 384). Forwarding from a bridge with a VLAN port to a veth in an x86
guest, mean of three interleaved runs without/with the series: TCP
55.7/55.0 Gbit/s, 64 byte UDP 177/173 kpps.

This series was written with the help of an AI coding assistant. I have
reviewed and tested it.

Julius Bairaktaris (3):
  8021q: add vlan_dev_sw_netstats_rx_add() and
    vlan_dev_sw_netstats_tx_add()
  netfilter: flowtable: update upper device stats in the fast path
  selftests: netfilter: nft_flowtable.sh: check upper device counters

 include/linux/if_vlan.h                       | 36 ++++++++++
 include/net/netfilter/nf_flow_table.h         |  8 ++-
 net/netfilter/nf_flow_table_core.c            |  3 +
 net/netfilter/nf_flow_table_ip.c              | 53 +++++++++++++++
 net/netfilter/nf_flow_table_path.c            |  9 +++
 .../selftests/net/netfilter/nft_flowtable.sh  | 67 +++++++++++++++++++
 6 files changed, 175 insertions(+), 1 deletion(-)


base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.53.0

