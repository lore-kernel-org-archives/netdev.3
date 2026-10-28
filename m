Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202958;
	b=D2p0t7XPnEhEGzJfOi7Sq/NcMhYNvrcHEqziU0NSrETia3dbeQ7GkPBuoLtZPJQqhePX
	 l8hVphUrcDolEIy0XQyAxZizchMwKuUkEIg/9sIKOH9iXuoYcKDWFPkOjmKi3+vRV96Bd
	 SasPIifax+Q+xZNsm+uCcqPWhLGsD1Pdny9mWl1p1jVPVwxYPd5avR97QcwklzoDCmO8c
	 SlN1lXAr80C8BdOirYgLECk50rhRJoFY8WAbAGWXpQRXZ8+kFRKDOr3QHrLEJqjxNGSfL
	 1uA8veEbW2owvIEXiD4I77K/TdAZ4QkTYWK9vFW67EuMspQigEZ8BIos0OJoZinnjWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
	b=q8Adn0ruYetThm/eSwXzmwy+ti8z8zHy83qt7CkTP/TMSQwRJmrMKnypIZ5XY/apW9L4
	 DIWukeq8oGLBdoeZIseD6R5Hr5qsGszIhtyA3FmXPmQvnSSSHbwDlaqHYtAZayfdw//FK
	 L3bA43qOAcCJDoqBeeYBlmdmdmfNHA4vkCyiUSZazXXK8ARjuhJaAmeVKh7EjudnUEcZq
	 CWqMAU5K5a2yJYGagW2WQd4Pu5iSXZj4Cli5uurhZcSaU0dRD1/R9au/4IIgdFTGUQQNx
	 Y1c0cRYh0WvpLZ2ootxh1UHpWfp4kC3JrauGt7muHSc34bVRygfW2C4JeYUI19qj6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="halrdo3/";
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CB606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=halrdo3/
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2e96b8bfb43so3827545ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202957; x=1793807757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
        b=halrdo3/n/6UlHBrM3qN3fciZKUoKF3rXjRzZCpuQz0IgnC0ke3WUITCU3zLXQD0k6
         VcWV/SvMk3WSY3GARWVABDTTh8UENPJ87jPojKjvHfN2JnCdDY8AK1XDZU5tYc+bn1/1
         U4xCZMBmxL2ZnTIlnr6S8zOZ24GXcuMR9SVnLr2EdKRUce/KKzZKmsbT78R508Xgmnup
         fQYTiiTGpkYaP7dlEv/BGg5+mD/Yv3/t8b21SEvfXwx3UqaO2bucwt7qA/l2hVDXILxp
         E03WprrGmeSxfCE7bHzrf5XcS4mzY3X5qew1mW2HBmp49Bl90wJ/RH0k3owYEUODLskc
         LpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202957; x=1793807757;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
        b=fYDWdwCS7SQEvsh37nbFr6ZcNFYKSjm8hA/DRtCCUWngTxipHneJxa84Sy1zI4kwYF
         ir71sySokGMYqFn7Rt0kBfXi27amv7qlzEfvD/1FFBupcwI0cEQUXOwb8yD7G0oxojsT
         O/Sz2Wppu4oEZOBqbN2W00vhEtj3s5TXK7c5h0O76dHPJYL2zJ7k7sJVvGNKnHs7xcGT
         Ik4/KB6NuX1OXNuCE0ZY+rXUYfTHVfCl4NuqdyfK5HZSisPCb3kHWts6755EDsvyT/og
         qQQedUrrhnYZBZS47c0ZAsATgwyHB4T5D+C1bE2NtUCaBOgePTLUnv7lekBmhb1UiMk+
         5+PQ==
X-Forwarded-Encrypted: i=1; AKwUvBzw0oJ9OcGl4T4Nax0w0ZT+s0ITgPYte8OqiCcgrT4V9qaeTTKHl5oGxHxGiwsp8qx093pcN1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzIMqDCE7mw2QROuwnKNVNNCnB90+TVUpHqyQybaJneYmouIY/
	6EXJzv07GbrNr7/rdR73e8V1CqDW3QNV148qwes9sMf/XfKSo6BNb7RQ
X-Gm-Gg: AYBFou3PejsJ0fDgbUg1hEdEJltKKqxCzdqEInt6vfzzJ95GS/H7ASoEZ9yRagvT/00
	5iI2H6SZdeE87U/HzeKE+89FYZ6RlYLCLPuv7h0zqmYkdFLsyxZ2UiYV9xkGtdy35Wb3oVA8Shv
	GhYTzL2RVf8qlitfZujhmcpPuWWZse9moujeHf9WklQgKoiN719cXqcV8HWJwv7fk0jtBXTC3pH
	lsM/RoiYn6v+I9PRopWN400XECg3t761NgNAJjkbnd4TkpnTA5ZoQRN4GmQSvOtjqAn9NX8uKxM
	gAxDSYCCZqGpjLGXwpAK980bL4k5mNEbzxnBTbE3s/uIuSxZ3aRQK1FpPBIeqXg05WBEJ4ytTNh
	zE/2+oAGHzLy9wqZioGSutPzhDe5ttrDPTUomKUlshUTe+EfZzBqkRALZOpkGikBQXm6AqkGGiT
	742pZiScY1lTequfEX4WoS7IGFRu0iPG4Mad6q8IhFZ3SRxUFzU1IY+z2cwNJ7ahp81KyPz955f
	C0Al0D3Aw6mAVgK/lFNNh6DDUww/Xa+EdmNEae5zklzEJEly8skWyt3pwJ7acSx0s8rCUEpD5oQ
	q39K8ZW6zXYCSJB7PjMaj/evE0qYTufnJCh1OsPLx1le3yrSd/Z6+fZIqVChsXngmqN84Xn8yA=
	=
X-Received: by 2002:a17:903:b06:b0:2e9:4175:307a with SMTP id d9443c01a7336-2eb003b2d19mr26567435ad.22.1793202956855;
        Wed, 28 Oct 2026 08:55:56 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:1490:f0fa:6df7:f234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b77e2csm23700275ad.19.2026.10.28.08.55.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 08:55:55 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 23:55:44 +0800
Message-Id: <20261028155544.12908-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auH2yISa8xouAx/3@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-3-testwrzwrz@gmail.com> <auH2yISa8xouAx/3@boxer>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thanks for the review and for the Reviewed-by on 1/2.

> nit: breaking RCT - I know it's test but Stan payed attention to keeping
> the order...

Fixed in v4. The declaration block now follows the width order used in this
file:

	struct xsk_tx_metadata *meta;
	struct xdp_desc *tx_desc;
	struct udphdr *udph;
	struct ethhdr *eth;
	struct iphdr *iph;
	u16 first_len;
	u16 pkt_len;
	u8 pkt[256];
	u32 offset;
	void *data;
	__u32 idx;
	u32 addr;
	int ret;
	u32 i;

> would it be worth exercising this up to MAX_SKB_FRAGS ?
> then instead of having this flat layout you would loop over the desc
> count.

Good point. I changed it to loop over the descriptor count and exercise 1,
2, and MAX_SKB_FRAGS + 1 (18) frames. The extra frame is the linear head;
the remaining MAX_SKB_FRAGS frames are skb frags, matching the copy-mode
limit documented in af_xdp.rst. The last descriptor takes the remaining
length so the fragments cannot overrun pkt_len. The updated selftest passes.

I'll send v4 as a new thread.

Thanks,
Rongzheng
