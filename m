Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5038BF75
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735771; cv=none; b=r8VAfjg0YcJMcN6A4rEd1yItzmJCIXhfLm8SWk95UN0kZkhCFs7EoqIRFlFjSf1XeIDxkR9UMS4Z7fcN9Jh8CG0QY8dn+xHDw6WItMB/yFSlt2wtckoSFFwxXSRroOn64HjLK4rX4DnNgZqUNWAji+wTj/1KW4xNfpYXPu7oNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735771; c=relaxed/simple;
	bh=kBJzSyEmLjLakSZnZLouxVwEm6diqgBCu9rGJL6ISg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCtipfhu7EqSlLKkaJ9VfHdpCXs4Vt9gJLZtge6QkKJVW6BFrmg9s97F/AXps2nAxvzZHx5/ZuwUF5WyPEgDjh9tKfBe5Rj2XUnnyLqHZkxpiqhT9KZAjClhrY1Yp5vWjtUgSdZb4XKtXcFi4icam0f+4etoWi34Mb8HRjUiBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQhQxQAj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQhQxQAj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so1291985e9.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735765; x=1787340565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtsNoDHPNAuzZJbO+idLSbliILF62YDBTYT8M6gLpDM=;
        b=nQhQxQAj50QDlXwfugOusoaVSejLKu6fNoRQzRtgxmd5GBBAK0FsIVgRETaqN/zLWK
         7oqRAwe/gvQ4OkYBTTtykW0aLKWg0p/N7amG6BQ/nWfT8Zg7du0/5Jnw2P5HE9kW6HUQ
         O7VUnIdniG5AAF07J+sIUvBcFrCJzUUMDmGz6QgRKErtfPuoKb0cLqxzEtrtN5NBmcjV
         5MveECq/tFUyEqL9lvlr5xBcNPS1Wpy6b3u9ya3He8GfZu75E/pR1zcXuD0iWLz7OR7H
         maq2jbbbGdxdW5BW+AAsaSdswVk96kF5KDoHd8mOCXjjLVLjYogrnPxQXBYrtkzEiIvf
         uD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735765; x=1787340565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtsNoDHPNAuzZJbO+idLSbliILF62YDBTYT8M6gLpDM=;
        b=QEn2sa93HmVSuIh+lGWKxEXDIfVVETMN+95Ldbwr5EQTc2qp456DVMjYQStO8ALg7S
         RoWCYFApuhfmKpNzWI0PsCTOotYmGM1E4Qs4ew+L6Q2E0czvHFh5V3qiF3/k8mgL4eNc
         8R6w3/5n58VpSvYTwuHAbpDsTKN/ouBIJ2zwZpq0m8oUdWcERpuP5u4lBajl//cCWO18
         v5+11AIJqp7lHsl43jEx9/eiw3KMxCaE1iNT2GDR5wLz8eFPvpFSNusf4tju4zZAPsJA
         FegCXAiasfR6Soi5QT7vGWKsUDiMoUDays/OSGEhyaGaDNVlCbMXaxVEt9rDGu6pGRW3
         vJcA==
X-Forwarded-Encrypted: i=1; AHgh+Rrafh406CMkZxYbJJaXre3cl/spJvd0rD+WncxIacORbyjOPmrmYvLDwxxmY38ejFLKA/+wR5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXKpRX1+6N61LTP75cdJoWMGsMzascF5kzMKzv8ZATRSVrqy0
	C7cJdIbwcx+B5EgTA/lyTr1KnR9mZH7pgRYniYwZOdibf7tUDg5nr084Veui7uh5r8mtuw==
X-Gm-Gg: AR+sD11p/W1wwO/pJkZyBadDxfPFZQ1GJ+roel7Hxvx9o+mgeBK+bX5KnEpxNsx0gyr
	ZOXAFiuEKMx88oYC9x3wqXMbgfZQFLoAPGQ60Shu7WJ08TBlbfX/TZj6P5Vm9WQ8ADvB6TDZcfd
	qx7WKf+NlTiNVi2IIBLcy1KxFUBaC4NAKCrXnv2jzX6i4xwR1fEk2by7A/yBVuspcROwkbtsYcH
	FVznC/nJwsK4hIoNXeMclb0BCES0ROJT0WHs8AOXqL8k2h5PTa4nnEIQCTxGQ0F9+2oh3KOZd9n
	DelJlb91v9En67Ee7v94P2dJ6jDBZUR5ly22t6Eyaqi9CKBYc66rQokcJXX70dJK5hHc/aicszk
	U0hBQ+jEz7DbmFDITMT4zym+b51Rlrbdjqq7axAwyrcwdesGMNVLICULK7F7RQGMJnNxYe5Vv22
	7Ha46UebRRKKPVzyJz1J9ZCf3dWNuzarKkskJ6ssrZCcs=
X-Received: by 2002:a05:600c:6206:b0:495:4126:1e55 with SMTP id 5b1f17b1804b1-499879543c7mr54501795e9.2.1786735765464;
        Fri, 14 Aug 2026 12:29:25 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:391e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d9fasm81666015e9.9.2026.08.14.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:29:25 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 14 Aug 2026 20:28:55 +0100
Subject: [PATCH net-next v3 4/7] netconsole: reject a target mixing IPv4
 and IPv6 addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-netcons_ipv6-v3-4-bc0915e8c75f@gmail.com>
References: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
In-Reply-To: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
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

