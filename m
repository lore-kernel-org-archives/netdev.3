Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34571399CF5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735772; cv=none; b=MUQCtSkw7HJPAd2094UraIgvGJ0+T3XuYzTeH5uaeJ54SZA93mMTduFvrVx3cHQuRIuQ0ikhryEsZi32GrGRLAuJu0zwp7B/dH6+i00g6W2dVTz93+74eiVdcAZLiFW8xFdeij8/MTxP1RoNeC8jW4L4hVdd6R3ZXRyFYc9tr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735772; c=relaxed/simple;
	bh=DYUlMEbqUsURMwexmCD/xyIYznB1QWbXqfysKMihGio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dl5HCmHfI1VfRC/s2Of+eS1hSRqQWpuYGpVn5GXfmx/wxUhEV9uGRerzwNBTvBuJeeP5bSbDW+JJdcfrgaTOaHRMAvzFcH9QkYoy2qCJy8Rh6zhnl3SQTt5hwwalMdMfuzuyfOSGIcC6nuVhxUwFaQyH1B3f4ajHId4S6z+5wf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGDXX0wg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGDXX0wg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495502852d1so782515e9.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735764; x=1787340564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ij1m4fx/1NIyn8kVtLRSbyCjXHfqmQiafcPU+9XENi0=;
        b=MGDXX0wgAf//EJdXVzwlXyJqMxKnFX3cHS/XKU9uD7QtS+929IleUVoFpFKuBJMQ+B
         VejVuMpUSDtGkH8/qN+LNAsZTmNJYAoq33TYv5R5xbpuGQuFKJbQZT/Sc9YJhM5UsT5n
         lcZh3nK4KBrzyRBD5NIoNg/vdBjOuaic1M6ABakbHsCfAuVdMxUJzrptR0nuKHvW6FqT
         N5uqwA3sUmf58y/9htGo34scab1PGUs2C0LqP0amzKdlWzPlKqOkXkQh6sNYfcJm4nPh
         Xhkv5XvIJMc1Ic+eSlynyxm+51NxyswDOFLlw0tAfFfjBlKWN8G+3szwinHo+wp5FP2A
         Dv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735764; x=1787340564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ij1m4fx/1NIyn8kVtLRSbyCjXHfqmQiafcPU+9XENi0=;
        b=nR94zomqymDvNGNbRvywbweCWTfgwc3csu0lHn7dl3Gix942lsaCnxlibOr9t4RkEh
         DdIDmL0R/xKwJXFU4F9qmYH2t3QUD5994hNh1ASU8YCPGQY3KVgMwnDAe4DnPXvCEq/l
         NCw+1a345BkR4UJI6GPql4Zubs2eHSvgUjFFxJPItHKKeuS2sfBa0yj+aICQsN/WxX1n
         x1rk0ete/TPTWrOHhGpZaeI4lAFjvNXuVC5/1vhv2pk42GMATCJWJ0cUUcR0GAc0SQKf
         0nvPoFBatGV9W0GfpFRMBJhHN2qcH7I75qq7EI4AcvWp3JEEXh1jhA2vmOkIxdMClfeh
         ItfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKF3jcutLD3lYccyDHAtq9ptMbuAw2uL5rwRN95kFAiQOBYqZC0/Ca35QrmGsjCA81O2fm16k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyML0ulsQIw1R57AJDIXKgkAuIqslZ1LsmhAjwXD5RNFgnu6JMX
	zGcNBcolLq3an30FJLf4X7Uj108vaavH9S+o7Aa+ElbGnAI22PC0lzQz
X-Gm-Gg: AR+sD10dCpnC5nL0rObewEOZngFXfvRpURHNpAn+BOl+2aUTIOvIIPHOwBrewibEVFJ
	HKCVNS/c7AmnwRhZDcQfAUeLqMm9f7gqGhWOVc4HCR3rjfXqG03TB6AZx6iLvvPVf8+bd2sPMBV
	KYyxrLkdH6do1AlhldplM8FmiZ9V4EJ5dpTJ3nNQKRYbZQ2k7+UN1qQcrpeTjG4dqH/Toj624E4
	dpz2J3rI1fPtc4thrKXoWwYhKObfi4AcoUEd5/F+oKErmglUMom1Dk/rZGQ2p6M6KsC2flOcWJC
	otduXQVqtMal5sVaezjD9e+Bu1NQBeViSCB2Ff7H/BCpFiINX5bFuRZAO0eG4l9WquvZXmapgnN
	HTDOjnq2Ie91qtjsgyjWJomg66K0s9trC60q3CjExMLXslT5IMGrllE8Upzx3a5fnknAkbwsIcB
	5WmsQO2ugQR709GG20igKT+dFJshSvJaPHugFTGNmSs50=
X-Received: by 2002:a05:6000:2c06:b0:47f:dfc1:6907 with SMTP id ffacd0b85a97d-48160751b75mr4934421f8f.3.1786735764379;
        Fri, 14 Aug 2026 12:29:24 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:391e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005bcsm10625829f8f.6.2026.08.14.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:29:23 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 14 Aug 2026 20:28:54 +0100
Subject: [PATCH net-next v3 3/7] netconsole: reject enabling a target with
 no remote IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-netcons_ipv6-v3-3-bc0915e8c75f@gmail.com>
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

The command-line path already requires a remote address, but if a user
creates a dynamic target and enables it without setting a remote
address, we currently try sending netconsole traffic to "0.0.0.0".

Refuse to enable a target if the remote address is unset.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 351754d53cf9..4af4f3039d4c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -483,6 +483,11 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 	bool ip_overwritten = false;
 	int err;
 
+	if (nt->remote_ip.family == AF_UNSPEC) {
+		np_err(np, "remote IP address not configured, aborting\n");
+		return -EDESTADDRREQ;
+	}
+
 	rtnl_lock();
 	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);

-- 
2.55.0

