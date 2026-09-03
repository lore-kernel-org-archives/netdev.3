Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6144EE849
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452804; cv=none; b=bxQbivkw7UHnwy4XU0/z34+HxP15LpKpNePjAtcw1CeL7aD4lPvjp1jq+s5Jo6+85mRFD2NVkXIKFQGjtV+RFrsgDhzSq6+2EqKCN5O2gf0VyTK2Gw8dO369h2opd0d+tIP6kLdh5XAM9tsjmFgIkICLvBIRWcqw+vIIg0jEhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452804; c=relaxed/simple;
	bh=kBJzSyEmLjLakSZnZLouxVwEm6diqgBCu9rGJL6ISg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpS/rIJKaz44VU7gycY9JLRiQOX5/RaN1kXvh+EHqd2gs+Lv++n2g1X0nCk66QhoLXtF3ihAhqV1z3kgmMkISGJXAP+rfxyAjSNwvTDeypi45s1vxIeTcl8PJc1L3Rvb3eJ3xPLQ1cqxPbHGitAe3Da/WVq4u9YDWb/M70Sc9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oc7f/p4y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc7f/p4y"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956d1d9fb2so112945e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452801; x=1789057601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtsNoDHPNAuzZJbO+idLSbliILF62YDBTYT8M6gLpDM=;
        b=oc7f/p4ycYSeJZq/ApumBgE94t7ct3L0XjrCjVMppIHcm89knibG5pK0VWGDJ1a1WD
         MPshdCY++DaqNmWPA2EeizgXe4g+DGOeuTZovng2txpZbwNVtu0/sPkZjCr1c44wy5km
         dzuCR7U8+w87ioiFRromnGegYQZRFoLFTMA01loem4IGUh6RqI1UnhZ9+xl8P5f5i0jW
         nJ0AfUANKGm7tle/3Glct18N6uffOo03ZnIQG8SRsQFv4OVsVqn2kxOcg1WCyOGBMbwW
         a9xcAM9P+zKvYNNP0uk7kmalu/Z9lcmlXr6l/uUcbF4TIobO4n1TvEQU7Borev6drPAx
         LS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452801; x=1789057601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtsNoDHPNAuzZJbO+idLSbliILF62YDBTYT8M6gLpDM=;
        b=NAKjC3its1+OQSnhjdBqM9KDF2iYe0gx3CAyXDvM+jbF7G8kqBK6K+eB0LgFoW173b
         gG+enNIHG9d8C7qVo5eS+5qDrd0woldHqfqtgHxZi/6iD/NN3kqi/xmkp7024bAsQPlb
         66HFVDkXnw9+s5seE7NFn1fsG6qTEGVok67uf8MmUQCN8OckumHSwSZdt9QrsFSzoh9t
         izHkvsvkP+WiAR4cbMc06zu0ZSQCqFAIVdd9RraHSE4h6eu2DapNEMfYYZgH8kcSTfPl
         s0YFEOk6N+EugqOo8aNEy4+N0EsPH6cDTLpc24GsyQisFS4KF9jux30aYfI2F9mDrt/g
         aniQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4oPAQLmha0KVRsRhJHGHAUoAGczSvB0NouJZq+ZJZm6ELevf82wFNSfEYAtJVbTc4d9E2hdE=@vger.kernel.org
X-Gm-Message-State: AFuF++l5NszDeHJOo1B4giCygfMkdPj7H0rKrTti5KBfe40KdJRxaaMp
	iYlunlCLwEwxaaxgcoL/+CfiBdocOLLGdrKIDo+HSnzgMyeLZa9085a8TGl3mimzpnPVhg==
X-Gm-Gg: AYBFou30+hNM9JnjSVeTlz1/5ZQgFhqMz7qNJriX5quT3WyWm0Nqm79vzCciGq9ehmE
	l0MECjip7cRCby9rB+Yl3PUsfqJJBFSu6oXKvr4rbAeJF9XMezOZUJufXg+jdnkNZjaIU/O2ZiO
	Aqlc+aGXQUTCQqiiRm84E1zOCdI8JBNeWEhgs3p00GjBXw3F+mqX7EYAuQ3+NhNQBcBF9T/Cckl
	QMZkktaMKDb3FB5dQco9MJDx+rKu2GdYenBG9QNBH9t8L670kQFrC98i/ArU3joA9FjOL+gCX5L
	YXADpwOXXqeL22isPPO7sKNKEyqSyC613GN4v5M3zsJ/5b0ZHJHrb54nV9O8+XRzcDa8C5kyH8x
	q8StkwHuIkgjQkc78lcrD+hbZ/Si7BThtmyc4xl/eVbTCJaOAbN5V0JS+WRNC61kMf5Jr4hxkKs
	YuoJe/s34SzOFlrYaeMBSC4ZsNqWnBH0kscfkqq0szvdo=
X-Received: by 2002:a05:600c:83c4:b0:49c:e363:c66e with SMTP id 5b1f17b1804b1-49ce580365emr108669425e9.1.1788452800655;
        Thu, 03 Sep 2026 09:26:40 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:124b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf2531232sm57273715e9.7.2026.09.03.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:39 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 03 Sep 2026 17:26:03 +0100
Subject: [PATCH net-next v4 4/7] netconsole: reject a target mixing IPv4
 and IPv6 addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-netcons_ipv6-v4-4-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
In-Reply-To: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

The local_ip and remote_ip configfs attributes are written independently
and nothing stops a user from mixing ipv4 and ipv6. This leads to an
ipv4 address being zero-extended into an ipv6 header or an ipv6 address
being truncated to its first 4 bytes for an ipv4 header.

The command-line parser already refuses such a mismatch. This adds a
similar check when a dynamic target is being enabled.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4af4f3039d4c..abcc8515ddd2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -488,6 +488,12 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		return -EDESTADDRREQ;
 	}
 
+	if (nt->local_ip.family != AF_UNSPEC &&
+	    nt->local_ip.family != nt->remote_ip.family) {
+		np_err(np, "local and remote IP address families differ, aborting\n");
+		return -EINVAL;
+	}
+
 	rtnl_lock();
 	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);

-- 
2.55.0

