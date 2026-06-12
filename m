Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DA382392
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254804; cv=none; b=nDtwKDEHKHc6oHDUYftbWIXrIJukcJuAuZpvL0vnUsB7+F6TL9CC66FYNQJbXE1N/o+btktgDesvh4lqWyb3pCtuf3SY6XMZAVjGs9ERuDh/jkXXuLku4e6g1k6jCExFqtlhRJmonaAik6Drcg4FMQ/BOzRB31PGjwNAsCDiEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254804; c=relaxed/simple;
	bh=+MtzfQkD/z/fSBvbWuIvx0eWpg9+Pm7DJLCS3YtxuCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P90bhaG6VK8P6w9btNGjps1HA2w80PvFRaX/pMoQUr7HK9MPcaJGzIznzGKRUWcPPiguSNVCYHJDlHEq5w0Oiw9UdZ3IX7I6FLU8YCWxzR8kdEDalCayHGxkVy0Wdk1uNwWnO8lgDGg0do0QmxPF2f7mhIrOg7A3OJGaFDHUszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBtUL51l; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBtUL51l"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423b08b293so402719b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254801; x=1781859601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2qINeyPf10jAgXQZLfSqS4XHQzzQiX47+bouG75nmk=;
        b=GBtUL51lwgv3+9SBp68atBKcQittHZvjIPF/y2hp+l5ylzVcgS+Di5jhL/fRLIBmJk
         o0uyrHArXtl3FP3b3ZBbW2+/5+dEdyAiSdIe+suv6nRT7uAtt0mUGdCY8vxkfusv+nNe
         5qRIQFBGloZnq28xMh1CYesmZfhvMoJrBEPR3SwKFMjhVt75cE9ufwY3Q+mvqaWFth7y
         eU2o5q7BmpWhvCxrRsCkGFDO9TusOGCNYFKfGcFlG6VAK0pH/QEpB9eFIYtAshQvuwnx
         mzj6kHx1dJVUXQLn67lqTayNgOM0Mi6oM77arLUkVo63pvU7Ek6SF9KOqjFhF29Yt2Q1
         c87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254801; x=1781859601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2qINeyPf10jAgXQZLfSqS4XHQzzQiX47+bouG75nmk=;
        b=puWjH1Pe1D04yw2fpUeqN3eZvAiPOBM5HvdCGLgd1dcQ6tLeFmvukjikXcbb/eF49s
         PuXfbFZWENuxcoyu7XUDSdRHGjEtjofnGCvNb0hgmrXNTFQotX8V1gwr28QxmQvYBo+u
         g+wIn2bkkJebJmHT0BntxZZxXN3/oTRowmpg7AjnAUA3ssCrySjRCIxRGBu/gB+R9YIB
         uvn6xhrb83MWAQQTN1MXvLZemdjijz6ZU4REwLZjA1WhdM3PU8wFC0+LZXZsN9I60s93
         m1kgtX/8jFFaQskdz4YhqTeDBXf9NpNsTcyMBTo/+0xfwEEHahz3jjevpTdX/q8ZrBQf
         kcIw==
X-Forwarded-Encrypted: i=1; AFNElJ/PorUECIAfJ1r+HpXziTE7QLjMCZnYh9PKKgO7gyhc5ZkBNO+1KA1amaxPzdulAzGWUMUdlFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pXhaW/FMFaNurnVzl+Qu0JEnfhYUpVIQ3TaJXmPOTSgsFaiF
	dgPByBVOC0vam9CCvVVpuuj+QMNOgLrUcxZNnQ08Wa2UxuRaCgILcn4I
X-Gm-Gg: Acq92OHtLLdW9kBV6iHbqeDmOJ3RCv2lNT6TCKq/aovJrt8MjV5zUQdTkq7k3+UBthI
	jZPYA4YbrAtakf8PpRDs4usr+oDcWru9whYZyLep/o3LRNLBpENb1a/CndHkrD7s+znQAoPxFke
	WwXN3v7ZckS0f6j0BjyBLsB/RXwNaCGoqFXNIjq7BHcLhwGJ+K+HYjGhw1ATZZhRDqtIpp7PcWn
	pfQtX/nAzVQk9C6VH69vv/CL3EVGUHzTP+bvogveomO2ORZbycF69WMlMu6BJral+PY2pwcVaKR
	CYiIxGzWhtgU7Ys0Zs34mSPNgnvsirDB4sg3NpvMpfOovSaewnkCDUhznBgzkernNpG+Dxbuixa
	J8Byd32hDO8ol8ekwYIeQ0OcKBbM7HtAx1jXosrRo48/b1lDK9z8ZparVN/ZAkrt59sQ/HB4TbL
	7aLAEXh8nAYpw3x1PfKlwVyJPq26Lgzd7+w3XLaFQJaN5SP6vn9EDIGIakY9E=
X-Received: by 2002:a05:6a00:2191:b0:842:2f28:4e36 with SMTP id d2e1a72fcca58-8434cd4ae2amr2162681b3a.17.1781254801309;
        Fri, 12 Jun 2026 02:00:01 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:00 -0700 (PDT)
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
Subject: [PATCH net v6 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:38 +0800
Message-Id: <20260612085941.3158249-5-maoyixie.tju@gmail.com>
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

ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 0bd8762824e7 ("ip6tnl: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..922b0feaddf9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
-- 
2.34.1

