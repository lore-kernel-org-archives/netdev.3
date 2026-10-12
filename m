Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6C48F00E
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809996; cv=none; b=gHuAp9ltK+AG/uO/2G0qaZJqPfwq/6wL5OEhf6jrTN5InLMwq45QK3HMEDAoBrCwnXF30E7OwVyzQ+VnDunO/vTM8pnpELEyXGYAARcQ17gP+QnOM8SDJjADjJr4OPPY2bNvk/+bMZR4GSmoq4d1/6zVenStJTVnkJkdApIKtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809996; c=relaxed/simple;
	bh=4YxlfpqouDUTd7pKJE+77n7XcSDshQKAyhhUUOVpyLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSgVcnEAyRR3fvDtKPwqF550mq1XGo/o/BjwT7End/g7SBOwxB0rXb5zylXRYKZzYMXf2Yy2BDRTrRzWGjsmpDEoGEqAuihPx6o77Bnb844mYN4z7A2wkETcpRnIsGZl1qN9ziQGQH62vhM8LmZAwNyjB1gZcVlPrqpbZRa1CkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=poEXWODT; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="poEXWODT"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so2597323eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791809993; x=1792414793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=22CBQ74hzoBRLA5eRugQI9KistKHZXGwVfxrCq6wnU8=;
        b=poEXWODTxejzH1139i66EPgljIfdgMSJ1HZVcja2lBXyc6w7yMQc6Pnj4BySZMICzk
         PFbBLYAYPnhxwu2Ait+pIb0ChMJPUPOL9RGj31KwqkEiDryD0A8xJum0KwbKoydhhRIe
         I4+ILj4PlqfYf8xuF/MmhgdkqxVa5c0v2/TWC6i8vXCBkTpbTaKYhPPEGOmxw8u30TUJ
         8C8iRu/7YE1T4eqbdG/A8L02hvwAUUibU5/HVVV2wA8KPQIM1jNyelRMQiSldetVKAy4
         ZeBQnSt1XS9brh9663Y7kErLwMYcM4QF2dRxzqiPEtlXzp1wrhCSDDDXV8y3/uo6Y1ss
         KaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809993; x=1792414793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=22CBQ74hzoBRLA5eRugQI9KistKHZXGwVfxrCq6wnU8=;
        b=SlP28knlzo7kRgHMoXi3fWZB5rgzJiSg9t8/YU8XlJ1K79cXoK4V9jyu6h83IYSbiF
         OHQMXNE+NHzQIwqcwbfLgxh3hfflAsp3VnG34irpTvHYT3oV4Twgqy9BL7oIZhMYk84U
         PwypxCb7V84VLntXJwms9P7jD7JH1H4ep+RMCK619fRfqBhzIQJkLhi6YPoaHwS4tPGW
         853hL5dc7tF/TuKgPrXDJS6/VAD1MKlZqo5ap6mzBetzJrifsDHio2fDGVR42S3FPyuv
         B3R6HGBmfbQiKdIRo83Z4ls+WYqX3C8xRgu5NFxKaq7ZgxWaPR+iZ/G+dAQ5qT2I18i4
         Fn0g==
X-Gm-Message-State: AFq9FYJ1217Tgw3WuPkbROwiZnLgZhhCAR/7aLP4fvrxrMHUd1LIFz8C
	p8Dl4NTCA/7Rrxt2Uw30RYN573U8nFaQUC69v8ssHWCuAjnxBMawAKcCkah9zArbnIU=
X-Gm-Gg: AYBFou0XLSqNjNKkIc6o4cam256IuuBMSl/CvYgMoINN4+ToX1je3u1Q3fQmCdYDv7P
	Z9vb4TY7FY2mbKyLl7Ysvp+NZ6KD57FPZmYUa5fNEBKvAXGFwQR+YS90MeT0CSAAixZ1HgmpCr1
	Myrv8jyJCYy33HA/ZdP1zHEDxYHYRDX5rZ3uzamRcRo27OPXXQTuHy+xqyM97i7c82fslos+hOy
	auU9AYxWelSmMZ8oSxXgcGelPSlx+qsK1YGeAAOhAFdaBTsQbIPkWjl3bvtd74oNptisoCbwiu+
	k5RydntNbD7Q31icrXraU2+khHYtaX31fkp0VvxMWyNGj9Uaj554viiRMcN75yvmq2naQvRmh5d
	6A/xOJRp2AkLppScNiL+G2jjKSSOBmqtLjiZqjri1KDl1SiCafujngF1ISqZj3o+4UjqtZcOEhY
	FEBax/r7mj0xtLwkK3SCOuRi8dfi7efTrmefyE70UxUIBZgwreRtHwtLSd6O1NmrY2onpEImLEN
	te+5PDenXB280NdYkhV+6/9H0K/h9lZ4g1Eifw9oEd7xCqVzstPeVZiQBeOFvg=
X-Received: by 2002:a05:7301:1a17:b0:34c:fb30:3e30 with SMTP id 5a478bee46e88-3537e0333e8mr12488904eec.7.1791809993276;
        Mon, 12 Oct 2026 05:59:53 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm35348067eec.21.2026.10.12.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:59:51 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 3/6] amt: reject an IPv6 address passed in an IPv4 address attribute
Date: Mon, 12 Oct 2026 12:59:40 +0000
Message-ID: <20261012125943.558629-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netlink policy for IFLA_AMT_LOCAL_IP and IFLA_AMT_DISCOVERY_IP sets
only a minimum length (the size of an IPv4 address), so an iproute2 that
puts a 16-byte IPv6 literal in one of these IPv4 attributes passes
validation.  nla_get_in_addr() then reads just the first four bytes, so
"2001:db8::" silently becomes 32.1.13.184 and the device is created with an
address the user never asked for.

Reject an attribute whose length is exactly an IPv6 address for the two
IPv4 attributes, so the mistake is refused with an extack instead of being
truncated.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index c3716ba..550b0a5 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3194,6 +3194,15 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
 };
 
+static bool amt_ip6_in_ip4_attr(const struct nlattr *attr,
+				struct netlink_ext_ack *extack)
+{
+	if (!attr || nla_len(attr) != sizeof(struct in6_addr))
+		return false;
+	NL_SET_ERR_MSG_ATTR(extack, attr, "IPv6 address in an IPv4 attribute");
+	return true;
+}
+
 static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -3224,6 +3233,9 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 		return -EINVAL;
 	}
 
+	if (amt_ip6_in_ip4_attr(data[IFLA_AMT_LOCAL_IP], extack))
+		return -EINVAL;
+
 	if (!data[IFLA_AMT_DISCOVERY_IP] &&
 	    nla_get_u32(data[IFLA_AMT_MODE]) == AMT_MODE_GATEWAY) {
 		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_AMT_LOCAL_IP],
@@ -3231,6 +3243,9 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 		return -EINVAL;
 	}
 
+	if (amt_ip6_in_ip4_attr(data[IFLA_AMT_DISCOVERY_IP], extack))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.43.0

