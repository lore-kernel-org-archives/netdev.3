Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3C303A04
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289512; cv=none; b=KTA2edUDnQpY7bsNt9GxUSSp9FT3U0+1BcKXsCjqiZp1uy4MSr7OjKe6sZ4pc5CF25DabQPZCaISqzyCQEW1dgZ4ronPU5PwdsSl8HB/N+xgaB/7ITBnm/a0mdKesymGZCiHKNdE3ni7GCF06mIxrt4Mhof1d/NhbveCvMmgfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289512; c=relaxed/simple;
	bh=quR7zaG5HvFKkoAcyflM6P6NFsJA2yI0PSyMysQvzs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPljZHcZGU8dYUAt7utcMewQYMtJHGWqbH7BclyinzkK9KG7T+yhTIdg8uinIfbcYtPeawpUIa/TdrSelEKhXLf1LoP0gRAwIAi30fnenqj2wXuNSDrp81zj2VXSAZle41hUcfuL/x993HshG1S0mBZXHqJ4LZjFX3KuXM+oqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=QQIw8NTp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="QQIw8NTp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso1771729a12.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792289510; x=1792894310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quR7zaG5HvFKkoAcyflM6P6NFsJA2yI0PSyMysQvzs4=;
        b=QQIw8NTpx0NQVnPaElOZevzSeEGsEd1HNJUlehuDS2MEursrdpPIEapiL/nlrwPAE/
         vq1GtTOJLBBFzsy2D0eKUgVaMXkXNnlc9hM9pcp+OFhy1Qqea/tzUdKQb4PA1t6akFN/
         cHtMznWJFCw4lQ27SP+Fn0vLmmQnDzceYS703/4CVpDi+IOwlQpwy+l/6eu2+UseMIPO
         ag5rkYqKZqUJYwHjnvtlCMlqbB16c80fXFZqqfGFY+Fc8LCAzS1UAKU7KONBsC0sLibl
         4CEkkS5xkd1WiCOa1QExUiKXoKCDozL1d7rLPQHNqv3/HHW6ctYc2n7SAyJEMueDqmDm
         DxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289510; x=1792894310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quR7zaG5HvFKkoAcyflM6P6NFsJA2yI0PSyMysQvzs4=;
        b=OxYnE4/hA9hfSRHtJSafxr/NNSgd0komp8GGIhkhixSNyum/Td05K+m7Zru5QDcA4T
         pbLc6uso2pDAhm/r5HCmPFRfGmRA7JLw66ddbY4vYLxkERcMsbbaUm4eQveU7uNqRWn/
         LLXXqKXe0AGFHEAe5/andFcZUDS4lOJ+ESVws9olopaDUbgf1LpBT4h8LWO2zvbp1pON
         dZGoO4u8SecDHLxFKs7Cn/xgljIr73wE6p1Xf3U9zMAzWbvbLsc3pi1X3qp471rR6DYw
         8vFfjESIPTJPk6O+ckbsQmPyG849mkOUzApGWeH66NSN+nFBmaF+tDkcLSmg9NdmeY6y
         Jfbw==
X-Forwarded-Encrypted: i=1; AKwUvBx2kzbYvqHjiA8q2+iSjwXrk8h+C+ODyvlDJ+vICnYr4MGnPMVf2nc5AGntjKDpQLO1Dz6T01Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdKVwH1PMbCzbbACIDtI9ggdicZ5UcnEYJORmjnbhEYEWS18e/
	Bw68LShnmBctoypcQbGP5wxw9NwhNqz17XTP3/7+Sep1G80sFyLfs6O3IasLMF6vQg==
X-Gm-Gg: AYBFou1tRlPe3yJnIz3+vtjPsRGar2dNTozTQh2R18ITj48Ms9+kwui08lxBOG9gVuk
	RdEL9RQVFXDzywwzn91RaZwPnnLSPzaT8op8E7KBIpicQMsIOalbFhwd85u1gIkWggXE1zOZQVk
	H1Pv0kqdBqc73/qN8sI5R9A9pzY3u/ktDtbvw7K07nrJzTB8qgkrHw20ApJHaHHlT5YlPQFt/To
	YwdNVjG3qZLAiyTnn1yMu2pf/HRYzZ2Rp7+sBuuXA17hPlHIF3chM9UlPCaes+fX7SEogYzwow6
	CtVoZ6axQv3kLJJWkh4t1lu20DyE9+v1h/BnDhF4rcxkLo2f3ezi5OygJnpLI0OvN8Zn8YJrjg8
	X1UlTbk4OP8pQ6mDRFWYtaLMoGvGTsK8tVlWND48srLoLInakp+zt+HuFZz/Mnq1SaDj/OBV4+E
	qNzbPEG16Gi6FBDWk+ie0fii9bYFPUESzh7jXm7g/12McDMHiuVht2INqWNT9RJDkHltB5v81JZ
	ndnn4oYjKjYgD4aA70Za7HgChup42m7N21ENT+8NDhkHryimgOFtrxsnFXHUWIQSslD5gzqk3Y0
	LiAh7xlj7by1xrOE5SuW488sO8diCz0lfpoh69fmtEb2geFRtLDKVUrmucMu5RpM4vaVF3ICQd6
	rRVwOCKd5xdO/pebPpRBf9wGr46RSkJ5zemynS0usX3IXDCjf2h/Zk5lyPCuivcPBE3larX3SSo
	PkRvWpZbnBRPaAdVbz5gRARv/BrICJzaZMtva4yj41cZmesb4eG4vTxA7ZyrfVuMvUu/AzMjDIC
	T5MuA96
X-Received: by 2002:a17:907:c48b:b0:c35:d50a:1356 with SMTP id a640c23a62f3a-c41a08dc5fcmr283934966b.42.1792289509761;
        Sat, 17 Oct 2026 19:11:49 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f247424f103187cc9af620d661.dip0.t-ipconnect.de. [2003:f2:4742:4f10:3187:cc9a:f620:d661])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb1835sm224698366b.79.2026.10.17.19.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:11:48 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v3 2/3] netfilter: flowtable: carry a priority into the offload
Date: Sun, 18 Oct 2026 04:11:45 +0200
Message-ID: <20261018021145.3769432-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atQkUoH3aa-J5-vf@chamomile>
References: <atQkUoH3aa-J5-vf@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 03:43:46AM +0200, Pablo Neira Ayuso wrote:
> I think we already mentioned this only works for hardware, this is a
> no-go.

It works in software too. nf_flow_offload_forward() and
nf_flow_offload_ipv6_forward() set skb->priority from the flow, see the
nf_flow_table_ip.c hunks. The selftest checks it on veth, without
hardware offload.

Julius
