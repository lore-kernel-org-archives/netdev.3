Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB163A7F4A
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785215310; cv=none; b=nSY/5cyV50/Zvne2yDn9gKe3CGjmkhyWBH4mbQ0fRnllikYIoJEyY6QL0KB7YbJE8qXPBaPUv3V5XkwPY+NNU5cN+b7DXaS5I8m0YdGxa0vu2SuTeTBGBxpncNZYEtx4D40sxm2kFfVqtZLiAgZzIQG8PkAmd9Xz620OtjQnT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785215310; c=relaxed/simple;
	bh=m6m/aS8lnFKGQbOw0k2M90okiFaG89ow5NO+rhiczuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClJI2CL6r5cBhqrRg3H6k4GSdTIPM8/zmXwKP5a4j1zZ9ZJuUgX+Jyp6toeajdq9lOTxOqkrnW8u1hwVeT82HyLIIUAAFtLZg8YAG0NH2kQhsEbc059IKSDOLOZuKfBs0QVa9EzTl8Xkm16i8h8EcKtU87txx7x/5d+vHK+TYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqO719bs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqO719bs"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1976546a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785215308; x=1785820108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZmGfcsuJjO250TUAKm9YYeyv0Wq7ea4OhDGpACv5FaI=;
        b=gqO719bsSGifHI5GAfebfIyn2yoGMOfyQh2mlXril4r4iulugs4/wQAVesmuwXqW08
         D1N53DbDr5EeErct4p/0g4IZB6Nea/JMKF3krILyQovylwJzSi0hvMzGPb++Z0StI5m8
         b8O6OI55xXSfrPEeD0kHhkFns8DIW0Hf9BjPNbdRMRgp9GDyX4TL/IqoIKVi4XOdpSJn
         EEzebE8F38OBKzcZW4s08ScYD7qCXkB5ckTXye00nS6EaNCKHMUhFHHTn2Gmk0GHy5Ru
         pABOLQY/W3xG9rATpjD7R8VwS09L6lkUpnvJQZG3VDCjPDtv28LPbW2vvUAjzk8SUkhl
         4UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785215308; x=1785820108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZmGfcsuJjO250TUAKm9YYeyv0Wq7ea4OhDGpACv5FaI=;
        b=Tvp//Ez042SGTIYb8uj0nbWN8AND5eZGy3Bf2d0AH1PHg+JN6cOQxbdQfWEtiuCySo
         YLQgtPO+yewlWshIGh+eMQugWj2biKDA1Wz9jagCViqM/eGBe8Gv5fXNpytGEok898lc
         k2mlqjXmZvz5LissfsaH9mBzbHVmq6RYdJFTsrf7/Hr8XwEO/zceydnP3DBXzVmFM5jm
         w8lfQRO6EJaijVDHWrLjBYUJ4Ea18/bWsgQrQAreeeG8+HePHAVJU1X45QA1gpJ0Hp5m
         5I3Ipm8LIG3NIqrKdq5OxbyaPd4wwkTeharBPXxm0RW66HpePJ6/D1GFYhWJUJde4vQW
         LzHg==
X-Gm-Message-State: AOJu0YwG32aLXm6TLY7FCj2O9njdLJgcnvMAp0nDs49OzI2LQtC/uB7S
	tJQ/9J4LG7KYJTMaLWoRtu6fO/m1YjNWo/WMlV7a1usx5tr/V0lzuzRGOOZa+goEPamKTQ==
X-Gm-Gg: AR+sD12Eo5OPbprSwWmIFiDC10aos5IP607ZIz7ACWeMya8yPeN1g8UHIuhhdv+cQgt
	2WmNsSMeujKYLLOq3Vfxnd0xf90Q/KagATcT5v7WmuyGhNIZyo8GpVQyzH2rW0POniaAHonwwmB
	lUOeJPK8LEQSKseRkcwa/8Hes4PEyYyVYd58daL2kbR8SNbZREbFo5xygRawN5cj3ZsYi9qa433
	g23qyym4wSZxaXKKq/AbElACi8R+Pay/mXv7KkOyKKQXtKM/qF8k2nAEt/dTuDDvGGDIMBpPpVV
	JLOmbptwlzAyvHLXYKzrQxzyJkTbPMkQaDNm/5NUjlJOafGPWVn991icUc0JXypUxKzv8JX7g+s
	irPBSi0CIhBrEoEhcyHmsZaQX1zx+NP10W1tJs+uurOsjQu33jORxYu5HA5qr9O/qBHxHi6hnrd
	HgBTj7KfNSHqsKWjRVhigUhySsGOihApDcYJ+KadMk50oGpMnYyZO4KhrfZd7q0z7hmTMu8S/Tw
	DK7
X-Received: by 2002:a05:6a21:2e02:b0:3c6:3c5b:fe5f with SMTP id adf61e73a8af0-3c8aafb6e5emr1154677637.2.1785215308359;
        Mon, 27 Jul 2026 22:08:28 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b282asm4133533a12.18.2026.07.27.22.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:08:27 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS
Date: Tue, 28 Jul 2026 13:08:17 +0800
Message-ID: <a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784972917.git.edragain@163.com>
References: <cover.1784972917.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
still accepts undersized non-zero values from userspace.

A route installed with "advmss 12" can later reach the passive TCP
open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
tcp_select_initial_window(). This can reduce the effective MSS to
zero and trigger a divide-by-zero in the rounddown(space, mss) path.

Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
keeping the existing "0 means use default advmss" behavior intact.

This matches the existing TCP_MIN_MSS based validation used for
TCP_MAXSEG and fixes the bug at the route metric input point rather
than adding a redundant guard deeper in the TCP stack.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv4/metrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..b9b97a0a5126 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -44,6 +44,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			}
 			val = nla_get_u32(nla);
 		}
+		if (type == RTAX_ADVMSS && val && val < TCP_MIN_MSS) {
+			NL_SET_ERR_MSG_ATTR_FMT(extack, nla,
+						"Invalid advmss, must be 0 or >= %u",
+						TCP_MIN_MSS);
+			return -EINVAL;
+		}
 		if (type == RTAX_ADVMSS && val > 65535 - 40)
 			val = 65535 - 40;
 		if (type == RTAX_MTU && val > 65535 - 15)
-- 
2.53.0
