Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD424DCF6
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587674; cv=none; b=gdxzax7jFzzj6xRNeiHT8vPLroj1eDFAJXjlHE6l7LJMy4xQr/C+C2ntPAhPxhWN9hhk+FqYwx+EDuRyXfqy3vWa9hOmmEDjt8oo0sZGaWaAhoGu9j9o6Ri7CLGHO0h+UeoHYQM5PQxFvLFhmJxm0XAwYGQT+H/q8Q5OfCUU/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587674; c=relaxed/simple;
	bh=uS9sWbpqDY7qVtQkvy/PC8zLLElz8q6kaRjwUGfvU7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HX99okhDYvNsuxeog9t04JopjRQ5IQtaFtf38sPKC/qkp/lWtrX45WdeVY8nxg9WPFJEGVsPEyBAwMzHlfWkmUBr28hADgX/U7hGEc43T7+D/21urtP95dEMtCX4aXrt/5QJB+kPPwITouRu1+moATpnBKW1wggIzi0wJKrNBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0mbpK/j; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0mbpK/j"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6c4a867cso105826185a.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786587672; x=1787192472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OQ0mOHVrQqy6gW071BjekeyZkSroC7y2i96KZ+jhet4=;
        b=W0mbpK/jaV+KMTfBGpPRzEvB9DAoDlxyne+dQLwMj33MmMBTAktfw5ruGaizfyqutT
         uHWFya/TUNipk6g6YJK53b20CbKwSdPaqEhK/shsZ07W5/E+6PYzOesFNPQEwFvIgWRU
         9mwfV8w00rxf6v2W0i9xOo0ExB9MgUBoR7c3Yer3BWEBN2IP6ZQybui5aOoxmByiD0Wk
         ErgQtHKu/L58ufbLtWFr3Jedtts9t5UoZ6eJIzOiwzOV5bD8dqiXnjE7O2bwA7Yu2z4O
         vinWY5seT2zFj89XA58y91SIVmXPCXudJmQPj8uiRdtt6pI3axZ04CVay1QyUHBrMTTh
         E7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786587672; x=1787192472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQ0mOHVrQqy6gW071BjekeyZkSroC7y2i96KZ+jhet4=;
        b=I9CCQLmXL8llfaiC10JTORN85pXl4ssq3jC1OAqjavtZ76Fc4BLZ++R2jPBzy0mW5M
         WCeNmDlhiU72DDh97IzBwEbyr/khkhrz/rhgXNcWgEzhmtqYTgHOgnn5THCHDLVZaOgf
         Gjbp4YGNWYkl8wssoSEsSys22FTBMleTugMtYaG00TG/1/KzUVCQS7320SsNqoKXExIQ
         XWqzcBWNejKQ1CI0wVR8ZyoAjSOh5u/EbTNdslGGtj9/M3iKDWFJ0w1GthwmwvlMP3HU
         HYctIS2CgIzsVg6I6f64PhYbVAvY7QyeLnF2UonJeFAUydtmllVN5ZtLgLACv2sP5L2J
         MKlg==
X-Forwarded-Encrypted: i=1; AHgh+RodmwTtc9jRrFyPwmQQL7+SEtM4B9cbgS6bqxsWQn7q3J0bzDyMuVoMPAo897Rjc/KI2ae8uN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3NWJ1VuNHe5hXKUHYNU0IBUc1MIiI9k72Z1P8PaldUCh5xED
	dZFXcrH0x2hY+nG/1Zq04LQ8C/FtnCBAQLaYyC5btQ6MtK23vie4/z3E
X-Gm-Gg: AR+sD10JN7koMm+yGEejELPHILNJa4r9dJ3ONDuyT8pPNMBmSJL3sHKA1+UpwEtHXgI
	vkspKDMG0C1KCcboRNmg9/8mKZml/bsivl/5gI3EWz6iYiC9qHOlYNyB002SaWMb4HogfwnOpI9
	EYjURzAceaTFXYxuv7bEngU7IEnLUe52nW8uEI8tRlW3bsHIC8XEE4LSPuZqrwgjSkaXrGdphJ6
	8NN34HvhZd/5J6Y/05zvNQCf093yu7mZFPFsaLcgCrFV+DtsOEKqqhOKjZJPhmoGzG46Ulb+km8
	CPiBTibiRnKV6ssmAmMVvm6wwIpVJEw2fZE5EKEPTs5o67cD3g7aIESwyR6FZuBytzCTxm3yN51
	vCSVMjuNajor5WgimJ1pjcwMt4ywoSjbOzC2M08wWCy9gzAdGFnVaoRD4RHkIMJbpim0AGf2rwn
	Pbp1sFg1Lvqf7zXHgwtUpC5PUEbvRcdaAz/2gEcwyL0iO90D6lOvMC5kg=
X-Received: by 2002:a05:620a:479a:b0:936:587d:338c with SMTP id af79cd13be357-936bfb39800mr173250485a.37.1786587671878;
        Wed, 12 Aug 2026 19:21:11 -0700 (PDT)
Received: from beelink.. ([185.217.69.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b11d44sm45064185a.22.2026.08.12.19.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:21:10 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] net: mctp: hold a reference to the route device in mctp_route_lookup()
Date: Wed, 12 Aug 2026 23:21:02 -0300
Message-ID: <20260813022102.2792032-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mctp_route_lookup() uses rt->dev without holding a reference on it.
mctp_route_lookup_single() returns the route under RCU only, so the
route's device can be torn down concurrently: mctp_dev_put() drops the
last reference and synchronously kfree()s mdev->addrs.  mctp_dev_saddr()
then reads rt->dev->addrs[0], giving a use-after-free reachable by an
unprivileged local AF_MCTP user on the receive/forwarding path (no
CAP_NET_RAW required):

  BUG: KASAN: slab-use-after-free in mctp_route_lookup
  Read of size 1 at addr ... by task mctp_uaf/...
   mctp_route_lookup
   mctp_pkttype_receive
  Freed by task ...:
   kfree
   mctp_dev_put
   mctp_dev_notify

In the same window mctp_dst_from_route() -> mctp_dev_hold() also
increments a refcount that has already reached zero
("refcount_t: addition on 0 ... mctp_dev_hold").

This reintroduces the use-after-free class of CVE-2023-3439: the source
address lookup was moved ahead of the point where the destination takes
its device reference.

Take a reference with refcount_inc_not_zero() before touching rt->dev,
skip a device that is already dead, and drop the reference once the
destination has taken its own.

Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
A reproducer is available on request.

 net/mctp/route.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 1f3dccbb7a..b19c63a569 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -998,14 +998,29 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 			mtu = mtu ?: rt->mtu;
 
 		if (rt->dst_type == MCTP_ROUTE_DIRECT) {
-			mctp_eid_t saddr = mctp_dev_saddr(rt->dev);
+			mctp_eid_t saddr;
+
+			/* rt->dev may be going away concurrently: its last
+			 * reference is dropped in mctp_dev_put(), which frees
+			 * mdev->addrs that mctp_dev_saddr() reads, and
+			 * mctp_dst_from_route() takes a reference on it.  Pin
+			 * it before use, and skip a device that is already
+			 * dead rather than resurrecting it.
+			 */
+			if (!refcount_inc_not_zero(&rt->dev->refs))
+				break;
+
+			saddr = mctp_dev_saddr(rt->dev);
 
 			/* cannot do gateway-ed routes without a src  */
-			if (saddr == MCTP_ADDR_NULL && depth != 0)
+			if (saddr == MCTP_ADDR_NULL && depth != 0) {
+				mctp_dev_put(rt->dev);
 				break;
+			}
 
 			if (dst)
 				mctp_dst_from_route(dst, daddr, saddr, mtu, rt);
+			mctp_dev_put(rt->dev);
 			rc = 0;
 			break;
 
-- 
2.43.0

