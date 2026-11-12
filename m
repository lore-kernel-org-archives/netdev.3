Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489801;
	b=k8+/t3Ua962f5ZacQsnmUoAtUedfv/V6jeHgpdSIqu0gNLtaGUjVthya1Y1tvDUU8sPV
	 jkHbrWeCu5xfb6V7nOdp+AXMdpGvMWc7ukgJ6cKw6oB6kGlTrHyuJrMsD4ab3jbS8AipU
	 Jm1SQ0R+tihJi/yt938XVdS07BydlWK8dzCR5l5P7YRvoHYV446hRT0auflltWLhl6AAr
	 GwHrP9bib+l6RUNJNeljsjkmEbyi6mqC0YXhL2Nt8ounUXEJy1rYiQa0tRUvWaQ6B+IFG
	 pvSSWa3KIonl52VXA0a73S41ILeXrQ7jvGQUr4+8yC6vA1lgBehVHNd8RBNv0eoID2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XyKog9AQppShEJliLLK1T6Sbi2JcYrMEsnM8YpdfsIk=;
	b=jn+/Y+Oa8avstOC3s3bLcFQKepyHFkWuDfXhmAWBEaWJFLOiy2eyN3KDd6rB+iZdr2SU
	 ULMYOE7uAsW9HN06H7Rsl6L4iqt4Z2LxNMc06TGJWFlOPHsnkvlnKvx5toDVjypw9Xws3
	 Tr259g3ehKqecmKStGL5016sd44+mRH2k5atjtBM5N3pKaZwtdGXShCc1g138RBaGkc6w
	 fHx5lyP12Iw49Vs53jO/k8+XDUeJq2Zgaxap66uBtrAUaDd6HpKRzEOfLw17AFwXkFx+g
	 t606HMIhvsN/9dPhCx5Tffy8fjPBfHNRRrlSjqHaQU40746P4joexbrstv/peu9tL1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ysm6lo8q;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB9606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEAB9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ysm6lo8q
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so155455166b.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489799; x=1795094599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyKog9AQppShEJliLLK1T6Sbi2JcYrMEsnM8YpdfsIk=;
        b=Ysm6lo8q9h75vv1rF+sVUxVRvFgBVwxt5CqCNS1R91Gp9s2vFYaS6q8TwsBcHWc+Qn
         QaqQ7w9+XQkui9QyAyJDNtHPbMbsS9J01/Kj9FJ2UrNVACBUeydBmfm1k3xF+zc/sgNF
         GMow4uorVLcomDAD5QEyDLy2TDw0MX4eU/NH+lxJyiFf/z/XP3mKzhFEueZn+yaWugxp
         A8IUrae6JAvgFNj3341Iz1LUhT92ONCA65t/NPLa/5q8DhHKyTq8KmUb1RVmy7dacK+S
         kQpMhRv5h1HAEz7qCQAIX0JZKPOT/dFaDfrq+LaPaS9RvLYCQUF02swwW7JYUip3uKs3
         TEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489799; x=1795094599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XyKog9AQppShEJliLLK1T6Sbi2JcYrMEsnM8YpdfsIk=;
        b=Rwp5UIB7igSBJdVEowE6qd3QvZBYBDDMbdLacm2gODEA1v24ysx/Ohmp1/NU17ExzV
         iEQRnwZA1e+2hELJjX1e8gtmmRmZsg1JCzTP0wS8l9bVlA9p8m9CuKKKsKNg09Xzoy6X
         dtgw7sNrHb9dsmELNbrAJdL1YpuVS6B+kqtM9zoBkwBnAktjOz3Rdr7jF8qpLYbDjU5+
         0sDQRiSw2TaBDZoWAFm7XaCyks4A104hjZwArg5uXNZO485gk6/WHv9nMaYs7A4qA43T
         duhP2knxmoqrO4A1+Bo6dESkSGuu20JQvCrIguIh7591ffLHXa5bwo+Nxbgb47nP8sW3
         bvLw==
X-Gm-Message-State: APuU4Z+eH1KSw3lgmjwIFpS6JPzPRfJQS/qGo8++H3UcfbZdnVjX/9lG
	KWJ5BosTNmSrWMkkBAgMbfGDJ+7sOqfXYcJMqHphMUmloAA0BA5PSaYXffoO9EFC
X-Gm-Gg: AYBFou2DEPtcrfXz0gL1kI9QJFYM7ZPqjaftsG+PFeEX+Ws/Ks6UPXqaiMFApoEUKVx
	UUasK6UZLGPcNUvh1iBz0x1cpRGvfFE47Sy1vqUq78+Ygijb3N8eW6yRvHrQ1boaYyy+2zOz4dG
	deCaso17wwjhSO3XCJ33eUqdEPbaJIZ0+mMACTvkISrMMdQHodgQ2+sa+z0UNAzTxydqAuCrLPd
	6qQ1i6KKsP5oooYSZ0HcfVdflMXQ2GjE8lrMiuoTa9ulX724nnS73iuGYRIi8dz9uWdOOf1yFgn
	0gPVkxJ85YNCMIQVA082+3PzqkO4y89UcsoAdQW8pg7Z6xGUd+gjXnj4/jjtkGXXElJgC7xtodX
	622Hzvq8gXtaWY1hAls+n6i0BzNPx1ZWeN4qk6wWtIi+iqP0nIVqItWK7lnZDwLdmgrjn3SpE1T
	G58l9Sqh1zvi9vMfJNFtpXBGoxetgvNywROagjZ84UI5UXkcDpm0QhaiGBw9Mu0swnGYSje/Aoh
	SXR78JiIn6sBfTT6uYfuha+YNprXJiPBfE4sVF7lzwusEIvw8bV/peyInir0W2KFVO8PWwtrCo3
	GmyvIkogpenDdtiu0vzfDI5kV8bf2uq0P3WATGyzEv+Ump9gpyv8z7yIescZEKT/H98xQOsDrRv
	w
X-Received: by 2002:a17:906:6205:b0:c40:9b35:ad91 with SMTP id a640c23a62f3a-c507b60db8dmr249279366b.13.1794489799362;
        Thu, 12 Nov 2026 05:23:19 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::31a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5704c3sm341545966b.26.2026.11.12.05.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:23:18 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] net: bcm4908_enet: TX ring and DMA fixes
Date: Thu, 12 Nov 2026 14:23:08 +0100
Message-ID: <20261112132308.340291-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109235700.2586821-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
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

A correction to the cover letter and to two changelogs: I mixed up what
I had seen fail on the hardware with what I had found reading the code.

Only patches 1 and 7 come from failures on the hardware. Patch 1 fixes
the TX stall under load (seen twice, none in 8 runs with the fix).
Patches 2 to 6 come from reading the code and have no reproducer.

Patch 7: the skb_over_panic was seen only after I raised the RX
channel's MAX_BURST to 32 by hand on a running channel. I tried that
again today on my 6.18 tree with the patch: within seconds one frame
was longer than the buffer, and it was dropped and counted in
rx_length_errors instead of a panic, but the DMA then stalled and the
board needed a reboot. With the driver's own value, 8, there were none
in about 18 million frames. So patch 7 is hardening and belongs in
net-next rather than net.

Two changelogs say too much. In patch 3, the TX skbs left on stop are
leaked, not freed: the stale descriptors could send buffers nobody
freed. In patch 6, I have no test of what the DMA does at a descriptor
being refilled. With the patch, a 16-entry RX ring under more traffic
than the CPU can take gave no RX or checksum errors in about 14 million
frames, but I have not run that without the patch. Also, the panic in
patch 7 passed 3388 to skb_put(), so the descriptor said 3392 with the
FCS.

In my earlier plan mail I wrote that RX buffers were not freed on stop
and that RX frames longer than the buffer were passed up. Both were
wrong: the RX buffers are freed, only unmapped with a size of 0, and
such frames end in skb_over_panic, seen only with the raised burst.

I will send a v2 with these fixed.

Kordian
