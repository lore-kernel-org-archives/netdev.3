Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3F31E841
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539290; cv=none; b=Qz7ZgBLOJReLgQ5rcpISV2DJRSpIQh1LMTqKL68DS3xZi+rCh5cVhqXowqIUp4yC28I3dHgTUTPKhxcvuayWPbRWubg9e9jn2BRepMNplwZEclWTlNkNHgGQBeKUB0ZOJp5lpz0gzbL/UMpD1S9m0yF1HLhUcfjiTo+BfybihXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539290; c=relaxed/simple;
	bh=RVwJ1Io9H3U8ujWoP+xe28Ms9ikSbnj29g/Vn51OWIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhZcNj6IHPED2nMueh0pT8AFZa2BzaXuqvXzQIJ17EA1miVg8AAa7qZq8v8BFVKdzwsdX8l4Bojz5YFTf7YYWVJcazqF7rJFf17o5YaTkY+sbCNBjVaftPvsSdm78MCU9TUValGCOlq7ewkhyk/RhYYkJWoIz8//UqrsJSy77xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ofZjwWsN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ofZjwWsN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84867f07d63so1069079b3a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786539288; x=1787144088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TMFRYNHb4XICdoTgYC0zu9ME7OIqxup3sECQRBfI0w=;
        b=ofZjwWsN//XuJgyY6jhEeCo00IJQdyGGBxYSmo2AvVhEN8/cDYns3gKyZCD+jvMu5o
         DXI13r679IhRlFtauENXcCcMyHaTyWFkdEXXURFigxNSia+MEkuUXvaTPONRcyHYSKWn
         mwIPeO8eEFvGVNCbmDHs0nx4l07+A0Xbq1bVX9fF6zz9nmSnhOhXjfTTMAX28yy78hYG
         vId/b4LdgNZepagiqS+NIJMZV5TKiVLQvxSjBIRea1DbEIMthUDdymiwM1IX94bagAYo
         LbQqaSc7cKkUK61YsP4aF8XkSucGQ0WGrjb4C4TByaeJIXqDwOxNe8mUE6/7NN8MjDJI
         uqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786539288; x=1787144088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TMFRYNHb4XICdoTgYC0zu9ME7OIqxup3sECQRBfI0w=;
        b=LdPUl27c+s3tBjY6GDIUVUYDt4kPPX4Szf+6kWZSpy8zlQRvA327BcdTWID9bOiKLy
         iSrrlIafiKDyhFlRjD6alg7hsSpZcwTwGsCbp32/0ugh+/VHzhdPsFbZ2jRPX2tD8IOP
         0gPCCFJEFIl1Tpc9ZM6GNnIaL84C/B05m9wgDtHqWOcJvkdwxuonXXkpqwtBDLpDHbZs
         NSvOj9nt3deY/lpztfLKGeeXO+W84g1Ub+Z5D+f7eUJ/o2GhlhMWiYPItkASUVwV6ANY
         cxna/VqRFkbMDGrLGNN+7FIot2lSYt2Qbm1L4T1Ln0EQhLHyK7veKhaNf4RW+HqpSxK1
         IyFw==
X-Gm-Message-State: AOJu0YzWOghZIA+mcI6ISo4oaeN1VEczDYvJrFy9xBDVbYLNQ4Vx1I7n
	j0dTgSV9mEadUPRmOPcUBhy01jCz5Mqtu7kvWtAwugmUJbej/HZS7NbbFFRmsPjzyfZT2CNdZn9
	5ShwHg8ml
X-Gm-Gg: AR+sD11oZEZQ0DXAssjx2fJ4QyCCVCFR96t86YEb0n/bSb379sZPCshd3Heedn4P/4d
	EBRWPB+gzwdtwyQoIC4A9Dthc1/EhXz7LRFQZsjRDTQegZLHve61LNQkxVd5C89RYaAPKhWyOZb
	LZt8WkQt+wBdSiCDO2IkKtpJmLtwipVwQpphVE9blLSNolU9RU6784cFrRpmG0Q00rjNFEwXMtF
	tOQRcvT9n3LZOZQGallXLQUEnCJYVdFuHjo1sAmmjWZfvLPKgxIc2R153TY0kuLkXNN2kjaPm6m
	0Vl6WDogM3Q8BFajqESBpE/VRPVq+Ix5JvvSp8Gx2VyxTi9tYRMBv367vxslbe0zeCnPSHAIDib
	SiHuMN9RQmCkSGvoC68wFcJ74c8F18rioYhscBma3K50CkTQUFSac6mjLOWSAbVupYpmOVMXjKM
	jCcdRjXKbPSK4e9iLBwOX+XjUvr/cnWd74LnZhwe3yrPdrRg72ZFgJyQD7VEzJpWIvhAcr1g==
X-Received: by 2002:a05:6a00:1ca4:b0:842:6849:2180 with SMTP id d2e1a72fcca58-84fb559f53emr5355637b3a.37.1786539287784;
        Wed, 12 Aug 2026 05:54:47 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1f71ee5sm959037b3a.57.2026.08.12.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:54:47 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vasily.averin@linux.dev,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] ipv6: fix use-after-free in ip6_finish_output2()
Date: Wed, 12 Aug 2026 20:54:38 +0800
Message-ID: <4aa3f53bc44e79572c6dd2340ec7b68ef1a3d87d.1786516730.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786516730.git.rakukuip@gmail.com>
References: <cover.1786516730.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

ip6_finish_output2() caches a pointer to the IPv6 destination
address (daddr) before invoking lwtunnel_xmit().  The LWT-BPF
transmit path or other encapsulation operations within
lwtunnel_xmit() can reallocate the skb head, freeing the memory
that daddr points to.  When lwtunnel_xmit() returns
LWTUNNEL_XMIT_CONTINUE, the function continues to use the stale
daddr pointer to compute the nexthop and to look up or create the
neighbour entry.  This results in a use-after-free read, which can
leak sensitive kernel data, pollute the neighbour table with
arbitrary values, misdirect traffic, or crash the system.

Fix this by re-fetching the IPv6 header and the destination
address pointer after lwtunnel_xmit() returns
LWTUNNEL_XMIT_CONTINUE, ensuring that the subsequent nexthop
computation and neighbour lookup operate on valid memory.

Fixes: e415ed3a4b8b ("ipv6: use skb_expand_head in ip6_finish_output2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv6/ip6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43c..d893c3dacfd6 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -116,6 +116,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
+		hdr = ipv6_hdr(skb);
+		daddr = &hdr->daddr;
 	}
 
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
-- 
2.43.0
