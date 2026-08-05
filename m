Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7A3F5BC3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965649; cv=none; b=aa52Vp+GnxaI3XFqK4Kbf5TOPMakpiVmoAo0B2DR4bZQcIPA/SpX9uCrJqNHOUqWkVo/S7Iz8Y9I5OuK5UJfQZj8jH9vf5wtIW+X4J6tBWO7dy1KPBgajAohjRBqrbTA/voh8+z3p4Im6j8B1SmTnIfJcgNw+TFlg9t1w1O3stA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965649; c=relaxed/simple;
	bh=FGgluiktpHdf3B4SPyK+DId9DH5gItlJ0mTuiRzLNSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBsVl9ip+ufZ3Rj560/k7zTOZ8QYiKGx16+8jLj0BIifXGkbhL9f4AqZBZhOOPyMzDulo1QfOtEoLnfhHPQna80nseQnaH3hUq6uU0LyjTEr2MVPbGE1uHXIX1Hu7z2BTCCi439aKxreY+POimikN8IDWA0kSUp8rVTDRFqQJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAgeCi0z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAgeCi0z"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a18e1499adso99389a12.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965641; x=1786570441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJHHerLHfpSc4Hf/fzZ5kWsOzDljmksdIXKZK1qFD5I=;
        b=QAgeCi0zykHYWkEDvFfWwGt2YXsXKI+SCXMGLlRjFPTTnGZe7OS+OhL5flID1gTW4D
         bJ0L6y5PruCTU5NJqV1UtikwkbBwMazT7RIM1G2oFTCVTGGH5S01wCkHCI9uUD7OuE62
         TSZtkjFgSlER0tmnlN2ZjiEtsm/0Jh6I9s4h+SwQjuh7PreFzJhS8XDsdk2Y9e8iSil8
         bBotn+4c6SA1orvH7N88+5I4Q/N15vrqBBkCOMgxRYQvZHGBnUs9hN1JCKv8k22/E20l
         Y8bEqKLJuiTQQp/mRhAlqThm4UmUinXQ4olD7IoZGzkKg6m3MVPkDM7ZztyXzLuY1oM6
         HKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965641; x=1786570441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJHHerLHfpSc4Hf/fzZ5kWsOzDljmksdIXKZK1qFD5I=;
        b=nutU9uLKQjKAMD68w4o7l2L0SBPtwNiIrAlCIGAgSZJOA5dCFypiVE+Aucue0rfqjT
         f69R9dqhw7ERYvOd6NmQczHQzeBE9w1Okq12ZxuJ0akTfOz0o5cxA+aeagcdUdafIY2r
         z7y/21xmCzsNnFRiAwekhnP0w8gTOUncn6y0XUD8FFV6A+XT3SjXpNZtRpi3SHRuilCw
         sqX987/WCnlHmJfUQVL9NEnIflTakhNivC/0JSVYPcUY+RLusI7q4NcxvWjTgZ1qr8x4
         0muL48aSKkOul6D+B6WLuoWeVyipyBDdT8rjrWNMQnZbTx6dNbUNX9ceo9RtglCfdIyd
         0New==
X-Gm-Message-State: AOJu0YwChdqiiCg+xLC5LX/h+BgieukWvv1cno3X3akbIT9zl3UBnVhX
	wZSsLXlqorFUQbtIgUMpHaSB/0+LdGKP2zyZHaMWA+iynGBv8P8KEcp9ggpgnV7MRBc=
X-Gm-Gg: AR+sD12HIulerz7rwZefpUR2EzoqhIFUW8P6ddBiUCJcuPk+H/rCyT/mAKtdabxs/+f
	II7MMdF92zZAmnd2WCs2yCbaJc71XQIFRc8qMXxNvui4BMVpS2vF0CxUTjVMGCGVz6hIn3QqR6p
	yF39I9LwIT7vghuKA+LJzDRH61rG71KiSPg+0uu0YhcT5Jmj1jtFOa2fcSk3S8yodCu3Nl1kO+T
	RKIWW4s/0sGJNOQuHs+/gG/Rtr1P+TDTWO81L4byiyI2Jm0ntaYB06zUKmDYuUK6aqeZ3PFPBAm
	UsXpOkVmTpR/5bc3eczY0LsqyQ55jeViFKC39deJa+4DxV2qOXBgrzmZKVQ2XOwxvvoeMoxikP3
	q0t3KpuEqavmzbmoz3Um3MY0jrJfy25RluR8yHYILxL66Glom19j2EoFOygoH5zuOq6zqztD5KF
	GXc6TNDUIbL2iIEzBytoAajQMwOnVdvgmwf6ZNZKzLtBo=
X-Received: by 2002:a17:907:60cd:b0:c15:e0d3:3fd8 with SMTP id a640c23a62f3a-c2039f1442cmr252854066b.3.1785965641011;
        Wed, 05 Aug 2026 14:34:01 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:f900])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036428e08sm179836366b.48.2026.08.05.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:33:59 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Aug 2026 22:33:04 +0100
Subject: [PATCH net-next 4/4] netconsole: reject a target mixing IPv4 and
 IPv6 addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-netcons_ipv6-v1-4-170a35b92da1@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
In-Reply-To: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

The local_ip and remote_ip configfs attributes are written independently
and nothing stops a user from mixing ipv4 and ipv6. This leads to an
ipv4 address being zero-extended into an ipv6 header or an ipv6 address
being truncated to its first 4 bytes for an ipv4 header.

The command-line parser already refuses such a mismatch. This adds a
similar check when a dynamic target is being enabled.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a41b0a5ce64f..69621705d68d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -477,6 +477,13 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		goto unlock;
 	}
 
+	if (nt->local_ip.family != AF_UNSPEC &&
+	    nt->local_ip.family != nt->remote_ip.family) {
+		np_err(np, "local and remote IP address families differ, aborting\n");
+		err = -EINVAL;
+		goto unlock;
+	}
+
 	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);
 	else if (is_valid_ether_addr(np->dev_mac))

-- 
2.55.0

