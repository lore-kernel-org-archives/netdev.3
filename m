Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF5383C93
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254810; cv=none; b=HTxYHLNhdQ5XqXjridcNO2L4jqlbFl2C0BWpEqtFTo3B4fZ0CT/kS3W+vBr+5JFe0nXEtIzNp6NTDknz8YCG2ottpwEoQjqpFyn1fdrmYA6DZrUPqMmDuC1Ln/rwrpesrqKETOfy+R/ru4YbRK3KKLrQ8998ej5IJPoMl8ucZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254810; c=relaxed/simple;
	bh=rGPF2wY1k3BAkSjSLw+YNJLWFe1bXipRPIKGXN0WZ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGmRkFl55rZ/hK9jH1JOQjOyR/KsGQOTEIVL7hPn7/1FSTFTvepxMl/qodkXGE7XUY6Ptf2mJXGjPOGiuzePk8yJlGjQegoeA3rIN04wA7eVY3dHnuMCg9yhIxL2Naq4+N50q4tGWx2tuOAW54ZJ7qva0tj7EWrATVi6+My+Eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeS4WZsP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeS4WZsP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f1d8902so428626b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254808; x=1781859608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/VmWPOMWT1TArRP1kFHQW8HKFH/Pq0Or4cO7drGpLY=;
        b=EeS4WZsPB+lcGaG/RfMQKAJBgXkkaBpP5Wv2uE7LKIhozcKzgQwgUQVB9spKtMwpY3
         LqlrFQ/MsPoysw1uHhJz+DkGV1Wb/QO5Y3N4L3Pt7KxrpDcNSDL1OWCU3zfTWe16OGiV
         uQIzZbendtF3MSdNXs4A2IE8U3S/tjbqKi1RP+LisZWNJwqyCnwc8P7+sJAPdiJOWTA8
         ycDjiyn3k4aQgLjPsP7Yj4IgypfJUgCxMXuwbB+H8FHa4GePnTNOmhzfy4XGyCphf62e
         2didOQ+GSiGGDvBn5olNDjUN7U03MzM/wdCY2m0/wDlKcmll/7OrtXwjmzuuIuodWTX6
         WSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254808; x=1781859608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/VmWPOMWT1TArRP1kFHQW8HKFH/Pq0Or4cO7drGpLY=;
        b=Kokj3GXJ6qDGTpPyQeSrWMh4rrAIqHAd86kW0GSbYBvCekWD0Ly0uRh8fcpmSqGGv7
         7B852yuk2Xnq26z887FN3BL3WAwKXNQ5Y8miMIGllQpDxO9FxDY/hkKMi+XF+I+hKPLe
         wnynAYSYuYGfTjJNsQ0QkI2q9cl2gMtu+utxgfRXCKmUKkPWfgCFMQF95tS8w/7FJujk
         JHb9sN0r3bhWA3CIruE8QKAWkAdkhjLZXTiNm0g++wdrJbP/CghUbdl8iCjdsaEYHM14
         vsvhITmm7TeaR5P/5Ws5U+rH9Wx31IcvZCtGiA4lidcUWv/2vrbuip9WTF0eVRe3IvzZ
         3mgw==
X-Forwarded-Encrypted: i=1; AFNElJ+lrsKQjMMggKdJmFiQ51xfp0W13y8f2BAd0k8qQaPPC742C6bk9UtOc+M/1hpBUVAl4gvFgYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMbPjHNbUfzgAGx8vCxtNKRUQbpM26H/c44oXmKxPB6AzBQbc
	RJU9CHpRv6YFv/0qebMHbEkeAXV5MpTnWnhhV7lsacpBBQEXYNN/PFaSKIoWng==
X-Gm-Gg: Acq92OFulnRlt+p7iMD87NR/pSJ7u/5uJg1Fljv8a96cH2wXWwLUcWFhHiv8aj1jaoW
	B+Nu3DJfMotcRsk+Jt/hT4NLCg2uunzcVpddExm0sOO8RsKpWRtnhFBWHrKyzptZzA6qBnEWsiQ
	xj/9lmedf1b54rQtKRuy66aBX2+/JwRIuXiBqLUMh3iqvWZletrasPstXecISKy0NUVvo9qcZ5r
	YE03obu+1n6O6a9f0U7gS78/IY6KhAVW/KFfuYrhrYbYgRnoaRzn5659zcGFIRKzDpQZX9otbEk
	8u4irwsTrc8IjTUtlq813rjnGVCTGxETJoGr+QDkyFuyKLMZ83MFLRZvrPUnmmkoXuwOH6GEmVA
	b9C27k7PiygqCKbBQlAEIauD95o1Xc0GLFNhyP//Vzcfr1ohHogHcxAnbiN21Nu2tsk/qI2pm/8
	SpTuxekppoHwJu20Q9TGL4OL7xARUFNHXIqfcrsXVCYGcl/GZ9
X-Received: by 2002:a05:6a00:84a:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-8434cadf0famr2119790b3a.1.1781254808571;
        Fri, 12 Jun 2026 02:00:08 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:08 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 6/7] net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:40 +0800
Message-Id: <20260612085941.3158249-7-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vti6_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate vti6_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index d871cab6938d..ab94b3a4ba9c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1046,6 +1046,9 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
-- 
2.34.1

