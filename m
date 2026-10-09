Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AF4D4896
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548696; cv=none; b=ruEViHiGM4eWz76k9VTBrMU+5OKuUNWHLf4rzTsMKsyK0oCYOvXB1Z4WadpCCaKlkSQ3/QpMyZMtYZ643cH5w+yCgyc4C0ABQcWFV4uaMxK8eerdqgSgUlFi97eCpk3MvttlAUvPz+QHpY8wtnffLL83aV4CsVeDstjylvKVtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548696; c=relaxed/simple;
	bh=n7MpCPH17e7wY6IUArnPw62s+ANisPwHBebFME9OmXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0ayPsa0JM6OyldkST7mC2kmF8SY/mJkqhQAYOkRG1oNwFpi8ckS5lQIQ8/Sqa7loxoD2v5Km7ADcG13Gpl0qFhr3fOBqyEn5oAR2qFIFKdoEsUE8bng6mvLIQsnH6dkQMToQo2IkFc/CqGmVrfr96SJev5sEpHK8jgA89uYB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=m57Med6C; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="m57Med6C"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso3627445a91.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791548685; x=1792153485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=POYJ51NkgrO3sBtsdPMIbGyCJOMdUlaXqqvzzThqRzk=;
        b=m57Med6CFXGrl+N5iCIeEyVLwnt78sxw5P/uHI8B4EhxnkLPh+53zUMi2pL9jr9Cl6
         3PxLm2kMiFWDjQBM+IFu+0tND5R9BQuk6Xs2hFdSGwpjLo90G9ZnXdQOruYzxDKdE7LM
         tx8OzpDxuB6w1YK5lhgzDw3AIowDHb/ykqv3Fce8hDwAWX9Jh5/YqwFEd8zqw/ryYxRB
         CmusqG+9eq0OBcyadtzwPFMuGdVaubTSN8nirQ7iK6xADZXD/FsF3xu4n5ngQaq1ty9x
         yg/Zo3XS9Ia9hGN8ZNI1x7DUzuDBjXg6peD7+7GIK8j3vcQiPtAbBcLxxf3qG1KTzZhy
         Po9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548685; x=1792153485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=POYJ51NkgrO3sBtsdPMIbGyCJOMdUlaXqqvzzThqRzk=;
        b=of++fIpgvB4SYpCVJ85tQTjooNgKuyAz7dAGjzbYX/NRGmktF+jbtdkWU+xfgCRiB9
         ug+e0Alw6fdVasPSmbY2CszyhA8VXDODDZJWJx4F0nQbdxJbVqtGcjov0PE7c2KaHE9R
         eaQMk7atPOO8EmdhKb28Whzj/5rw/G58tWAqjUqwb6738OncqpFI4Dyjhb7C4b6EMeQV
         dHU4ZMZnHHvLlBwzmx8I6zz9I5/AtPrB8NLi54wujQhmTtVO6DQHXaXyG1BPOdHfAK5x
         avs3lHCQFvefBXoF3v0kfUT087+SgrlZULIVNs1srbdttsy5VL+eR9lLkiQPBydS2Qk7
         7cgA==
X-Forwarded-Encrypted: i=1; AKwUvByy8Xo2+KuW0tH1+xfdLqYeREqoh8FaKndv0NhYygOx4z0DOyUZ0cIn6ukrZQfL2lW5GbvojZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmgJBarj2b57F/1u1+WMx7h2/ilclq2+nBlBB/qEh2kqkCVzQD
	kxgmXRHILGzHYbtMpwQaqmGXpI0cbUx8zPbwqSbXcfM1ZxpPv2Di7tj0swlSPV8Nq9c=
X-Gm-Gg: AYBFou2rfzI95n5uN72BEB+eJndt2y5C2ASUb2qiPgh7n3NyD0TJMDmPOp345jMHt5E
	r6AvYyXHpnjFtZDc1jgHpSK8nEwpi+iVPuKAKnc7JTT1I4g6OvOBogtV8qpzCiUA+iGrTPb00N+
	L5QgEpPPTSay5SYyMC9KzlhghgtPvOzMb8NRiRDHMbPcP8t4uuZq1wwc6vbp3Q/SF9UndN2beNg
	iDlh5kClnGFaPMnyqZIUJnX3bn5kgyXvxNQ4goLfbMMDXqd5ZtuxRYKCBPut+GtnehR+O+OzDBX
	HtAUAR67QTNMkXTEXuxrATPMj3PTOBfj+BHdRFe2yht0XJc9qntM03cDRWpz/XwSc0fbakIIaz+
	mNYC9GGxsyvDXowZs/YC+ygzLN5W0taycgEkPFYtCTtjACrwXWL7YUuTxgZ5sFZvPZLsS5bbbvi
	j9dPXfRvItU9z8ls1d7OQxUND7ZGVR6kSMGBSPp94WihL7El6e4EZJq0PjwmQsFLxfMBcGf/fS5
	Ew92yT8n7vJOjMwgNT+GKF8yEM6bnHRoTQ+1SYX
X-Received: by 2002:a17:90b:2d0b:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3ab3a97a71dmr1728881a91.59.1791548685378;
        Fri, 09 Oct 2026 05:24:45 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm1660502a91.10.2026.10.09.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:24:44 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/13] amt: size the encapsulation headroom by the outer IP version
Date: Fri,  9 Oct 2026 12:24:20 +0000
Message-ID: <20261009122426.551178-8-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009122426.551178-1-omar@blockcast.net>
References: <20261009122426.551178-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amt device reserves AMT_RELAY_HLEN or AMT_GW_HLEN of headroom and
subtracts the same amount from the stream device's MTU. Both assume a
20-byte IPv4 outer header. An IPv6 outer header is 40 bytes, so an IPv6
relay's MTU admits Multicast Data up to 10 bytes too long for the stream
device once encapsulated, which the relay's tunnel MTU check then drops.

Compute the headroom in amt_hlen() from amt_ip_hlen() and the AMT
headers of the mode, and use it wherever the device sizes its headroom
and MTU: once for both modes at newlink, and on NETDEV_CHANGEMTU of the
stream device. AMT_RELAY_HLEN and AMT_GW_HLEN have no other user and
are removed.

No functional change: amt_v6() is still false for every device.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 31 +++++++++++++++----------------
 include/net/amt.h |  6 ------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 412d23c..969ecfe 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -93,6 +93,16 @@ static unsigned int amt_ip_hlen(const struct amt_dev *amt)
 	return amt_v6(amt) ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
 }
 
+/* Headroom the device reserves for its outer encapsulation. */
+static unsigned int amt_hlen(const struct amt_dev *amt)
+{
+	unsigned int hlen = amt_ip_hlen(amt) + sizeof(struct udphdr);
+
+	if (amt->mode == AMT_MODE_RELAY)
+		return hlen + sizeof(struct amt_relay_headers);
+	return hlen + sizeof(struct amt_gw_headers);
+}
+
 /* Copy the outer source address of a received message by value, so that
  * the caller may pull the skb afterwards.
  */
@@ -3513,11 +3523,6 @@ static int amt_newlink(struct net_device *dev,
 	if (amt->mode == AMT_MODE_RELAY) {
 		amt->qrv = READ_ONCE(amt->net->ipv4.sysctl_igmp_qrv);
 		amt->qri = 10;
-		dev->needed_headroom = amt->stream_dev->needed_headroom +
-				       AMT_RELAY_HLEN;
-		dev->mtu = amt->stream_dev->mtu - AMT_RELAY_HLEN;
-		dev->max_mtu = dev->mtu;
-		dev->min_mtu = ETH_MIN_MTU + AMT_RELAY_HLEN;
 	} else {
 		if (!data[IFLA_AMT_DISCOVERY_IP]) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_AMT_DISCOVERY_IP],
@@ -3538,13 +3543,11 @@ static int amt_newlink(struct net_device *dev,
 					    "discovery must be unicast");
 			goto err;
 		}
-
-		dev->needed_headroom = amt->stream_dev->needed_headroom +
-				       AMT_GW_HLEN;
-		dev->mtu = amt->stream_dev->mtu - AMT_GW_HLEN;
-		dev->max_mtu = dev->mtu;
-		dev->min_mtu = ETH_MIN_MTU + AMT_GW_HLEN;
 	}
+	dev->needed_headroom = amt->stream_dev->needed_headroom + amt_hlen(amt);
+	dev->mtu = amt->stream_dev->mtu - amt_hlen(amt);
+	dev->max_mtu = dev->mtu;
+	dev->min_mtu = ETH_MIN_MTU + amt_hlen(amt);
 	amt->qi = AMT_INIT_QUERY_INTERVAL;
 
 	err = register_netdevice(dev);
@@ -3676,11 +3679,7 @@ static int amt_device_event(struct notifier_block *unused,
 		unregister_netdevice_many(&list);
 		break;
 	case NETDEV_CHANGEMTU:
-		if (amt->mode == AMT_MODE_RELAY)
-			new_mtu = dev->mtu - AMT_RELAY_HLEN;
-		else
-			new_mtu = dev->mtu - AMT_GW_HLEN;
-
+		new_mtu = dev->mtu - amt_hlen(amt);
 		dev_set_mtu(amt->dev, new_mtu);
 		break;
 	}
diff --git a/include/net/amt.h b/include/net/amt.h
index 77d17fc..d8798a9 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -398,12 +398,6 @@ struct amt_dev {
 #define IANA_AMT_UDP_PORT	2268
 #define AMT_MAX_TUNNELS         128
 #define AMT_MAX_REQS		128
-#define AMT_GW_HLEN (sizeof(struct iphdr) + \
-		     sizeof(struct udphdr) + \
-		     sizeof(struct amt_gw_headers))
-#define AMT_RELAY_HLEN (sizeof(struct iphdr) + \
-		     sizeof(struct udphdr) + \
-		     sizeof(struct amt_relay_headers))
 
 static inline bool netif_is_amt(const struct net_device *dev)
 {
-- 
2.43.0

