Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204A4EC670
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452803; cv=none; b=Fy7G67n8OSbbYe8zjn2O/1TUH7ZSvmF7woye/SU4K8vuzjGrjOVvpDejk7xEFK+AN9hp0ot7+e0kHwaXghaZ34GfubZ7Y25wjl4uTCEiqNAycdXW5MFOb9t9TSUTgOlpu9XhQnRPF4rVs1j2kAuAC14C18YOWAfAMSe00Sq8MeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452803; c=relaxed/simple;
	bh=DYUlMEbqUsURMwexmCD/xyIYznB1QWbXqfysKMihGio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C89uIFqjVo7qIIewsM06u4nwHdbPFcIOVgOyGEU6L5p/IFCWxlIjK54RigNl1muP6wG5S3S+OPwIdLdciNnWzHHvIeV0U+T1JQfaf0cRmUDf0n83glYCDLGlM+4jlznGCyX6IIgfCo7Mh2Z5fhyY8SFkh2MVHpiavp5Sdo4/fKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1eDp+c9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1eDp+c9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-484369c7233so5962f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452799; x=1789057599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ij1m4fx/1NIyn8kVtLRSbyCjXHfqmQiafcPU+9XENi0=;
        b=X1eDp+c9LpDb+C4jG83P/0woUIRxrOoJ9wSMOy+kTPzIJu8/cXVJ84N1znE1xOs1ks
         WSMuA+YFAkcGI+jI8LXj/L44QLwE2cM5kHygRL6nS2VQLqA6k4zftwT54E5PAVUoFitU
         YGAt5YNIoUuS6Rd9zQN2BYMzN9pw+yyTfLGjae7xEN/hPMQRjxCbn9kq6mhwLhClU6lX
         qZMW1FHf1SJvfi1ZZwuLWXGmckXWLs1btW359NYOWnt72zxudytk8YeAhrJrwUf2A9H4
         W5HDE1D1bSIynoYTj5ftph2jxpetrTbl3p8NmX+iT+HP25YxS6MCmoSXDVc/FVrQQnMs
         GMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452799; x=1789057599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ij1m4fx/1NIyn8kVtLRSbyCjXHfqmQiafcPU+9XENi0=;
        b=f6+QAtZkdDeDJN/ifzf6hok2aG3DzRVyWy+VBfvUXy1m/eXArfsn0WTT5ADl4C2Fba
         kK06huzES/rW1Qvp1xKk1p9Pm76OVcRR8muZGbdCaP6IhfHbZmzAkKtcT78Puyfpy5eb
         0bIevSrfCN3BIlF4RI1O4Apt7xZ+XPR/HS2X8x5gN0sQYvQwoE5Kzo20E/rwuThH4Cu5
         vY5M1PjTQ1OG3P098zOBApweaus7WNqR1CiLPY1hiPgb7cQqUInpDL7QQD52bwl/jyu+
         smw7vbEF5CSHq60KdgjmcXGPdLEsPnW4ALVuq8odh1AvUKkD1EoUqOuhX2awq72GsFnQ
         k3gw==
X-Forwarded-Encrypted: i=1; AKwUvBwtUK+VQ3vSyCmgc4GYiTYB7kBArlIwPnAbU2u1h/tmhJwgbP2jxrlZwb9UXqw3NDmchE0v7AQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ4Cc2cagK5nI6j8qtDOMn6kCzt/WmZ2iAEzndRmwSpz+B4q7o
	DH3NHWqRYB3rTvp3/f+4yvmbQCb6AaJEf6guc91EjFDzJWfHy1NagfLtjMDEmfisAy9E6A==
X-Gm-Gg: AYBFou1IgMjGEm2EFG3i4GjKlypt9BKt71pwbYM2/2+30D8B2eq9A0gZT9dmuB3aX5L
	75ruDdZqa5X1ojiWE5RLs1DbHJYLINorLWV3uxDsg/xV6GxNQcaNpLB0qj/2hY8rhZsY47JmXNR
	GDFE3PWv6eQKm+xnYcE806gdo6J9BLMvBBK/5yVPK97Jao2jsFKtdjEuRrMb7wSRBLvCZ6vTR07
	zzS6ZYdx/0jV4rAxfhhUGQVZGEjYpOZsNbnosSMkliIsS/8NPGAE8KR/B4xO9OM/T1bif5Z4LLj
	yS573MtQ5Vonc6PegAixDAHPA74kOnglwgB0t2EWGR4JWTltC7gX+uL+jZmF2r3O/bOvt1OVSMo
	dBz5YeH+JCNCm+jFeVHkrARs76d2YrydEdj9WwxjTkjhX2cD9puaFpv8tOiLH4khj5UU4tyQemQ
	2qtl+XRHRwHT+BnBQShC2ueuPo9cBK7FTmYZEhnboyNeZQO5YYzhCuVw==
X-Received: by 2002:a05:6000:41c7:b0:46d:ff8a:c8e6 with SMTP id ffacd0b85a97d-4858707c531mr165606f8f.1.1788452798868;
        Thu, 03 Sep 2026 09:26:38 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:124b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e81718sm14672574f8f.16.2026.09.03.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:38 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 03 Sep 2026 17:26:02 +0100
Subject: [PATCH net-next v4 3/7] netconsole: reject enabling a target with
 no remote IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-netcons_ipv6-v4-3-bdd183c844d3@gmail.com>
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

