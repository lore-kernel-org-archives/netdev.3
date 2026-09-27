Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF833B7B7F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493066; cv=none; b=RZcpoP80vPSQ6gi/kjAebnEZd5RCZ1G9uOwue4/UOccDHB9cO4Kn3gwulBTNS19BZu/mREwPohuHD4Xz8z9sffC6/kMq3sLnZNFE14ecHRebWXWJ7wx05jP74cnVCD2Gw8WEBXDDmwQGgO+h/eAGD1rrqi99PcIceOJ8z1dJkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493066; c=relaxed/simple;
	bh=0RQ/z4AsypFufaAVkW1Ij7MYV02j0Bqz1PEMbVd8BqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lthyK09Z6LWwo4rTfgLFaR87WcWKpp9izalMGoSph/+07b/272ImgaNgw+FgEcQhrVP3ZuBzsw6msu1udjOfKxDKWvpVy6F8QJmOBTc40uEQf7cOINuj5lAuKMqGKjNnfCEnTp8ByECUp9dwXRgXtNxBL4B881pgBpi+T8Mg/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLImnVpB; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLImnVpB"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342d0acb224so7082eec.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790493064; x=1791097864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MoYf1WznKmzccMmbZmdq7UQiskOv2xS1v3NBQI1ZhMM=;
        b=XLImnVpBfKD3PnVFr7G0RORZnfsOwB4gxJNtHrbbAKgtuOmg6Se9a/y/3k2A2Ljgfo
         QGXOKb8MvdS5jweVDk6xHdYGra+fUGaQwylI9u4M5Bhl38mE+0AEmFGpfcIZcVdE+qmX
         IsnEe9kt0n8eXj+/4e903RTNVyKxh18mcsEUwElMOp/3XUiYV8X4zX5ReBiLEX5s6WHY
         brvfDWRiPfDMgca+dCWzF9CQCCbjB6p//RiHXYIkjWHFo2zqzCkULVy1ReVI6CLDHopI
         8Ei1g2nuR5V1E3qanIPiD6GnOaNGbWmMteK+1pE+koDVS//CMJT3TEsx7Eta0rHkRsUe
         blZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790493064; x=1791097864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoYf1WznKmzccMmbZmdq7UQiskOv2xS1v3NBQI1ZhMM=;
        b=DeBK3GRj8pPEQIv6+6sXr+TAM7rDtgzlFKYVbxWcK+ee5td1rtGFTIOpmdz+AW12+e
         Wgp4NtyJhdt0XlA6ARnRLck7ot2Pp332PalLcas2vViBHydgn4keopfd+Lhf4dgUEEjC
         I+stJ4SZBcfDc5PMPENVX6axRRMA082/8zrixhlE3On6aaXpBY8n7Gh9kJZd4XAdiHWV
         p/kmZp6r81nDizUSDZ6uZTeCLCVEGJ44Y4/xF4lANKb7HGKq7Jql+PR0uet+YopOLsGK
         F1NMjmpfvUNo/XqW107EzGtaFrEK0llyFiSZv/m1w+d8r87NQNWtu7CXSKhxv2OXj8Yj
         l8Gg==
X-Gm-Message-State: AFq9FYJ7Yz1HxCNwqrNmG2aRL4W6Lx9R5xTgwG+e1gKWT8wJkBsA+sCe
	WAz8VE9uSSrLmy1JM2lHWCzo5ueEf0/lg9VzyxCj/FzrH3HUzgRlcJBK
X-Gm-Gg: AYBFou3rHVwXJJq3EDdF15Mmwkunwb7XaCSOpdB94y7YVJ3DxmvAH51xKtakAMfEfIa
	34WGuKxUhzoPv/7U0pHWTIb9z2inp7dMz/LLGExUTa3/9MuIZhwmlWTmaTX1prmKQbg3XbYuXdE
	rUiBiS0WRxJkzeJJTtDmAZ577t+LdMv9q5+N+Nb3FK4ZRLR6Z1Oci95tHGn2i8lehNB5yPS3Fme
	0ZraqbrO2+I/76W6ivFM4jgJvDtM1lrg9XxtzOYSDE+Lr6nYb5nJRrdFZI3YYf9kKwtY2Ag2S+L
	cbo4LFaSqJ3i2vPPxZN+/NzbvppvHTJYfkq4NPjOxgdcxkdTX3B27+S9aHImzmEwgV2x6OtAtKI
	gM4wt1TVAD8UeNxp/7+IImIjPLewGH+DV43/0RodDJpq2v/FMowOfwu+TGlOJAlBKcJCnS+nHgc
	P6+427Ktju7FiyKtlMfcJjvSkkt0nwQ70m5bkYitV8ajj5S1N8p4WhO1Y3Lpcp/q8ZlI2pYdWYs
	j71wutRBO1N5Y1IvwlkTTp7m4F7R4qoIYetYFXKAt6YD2zCIrHVP3H6rARGTBFHC41jOk1KRSTj
	BQsq
X-Received: by 2002:a05:7300:de0b:b0:341:f4d6:d9a5 with SMTP id 5a478bee46e88-3427169be76mr8534610eec.1.1790493063552;
        Sun, 27 Sep 2026 00:11:03 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341447576b9sm22318886eec.15.2026.09.27.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:11:03 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Heffner <jheffner@psc.edu>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] ipv4: Fix device use-after-free in ip_skb_dst_mtu()
Date: Sun, 27 Sep 2026 15:10:51 +0800
Message-ID: <20260927071051.3693368-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a socket ignores the path MTU, ip_skb_dst_mtu() reads the device
MTU without RCU protection. The multicast and broadcast output path
through ip_mc_output() can reach this helper without an RCU read lock.
Netfilter releases its internal read lock before calling
ip_finish_output().

A sender can load dst->dev and then be preempted before reading dev->mtu.
Concurrent device unregistration replaces dst->dev with blackhole_netdev
and drops the old device reference. After the grace period and remaining
references drain, the device can be freed before the sender resumes and
reads its MTU, causing a use-after-free.

KASAN reported:

  BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
  Read of size 4 at addr ffff88810921c038 by task poc/98
  Call Trace:
   ip_skb_dst_mtu+0x634/0x740
   __ip_finish_output.part.0+0x22/0x2c0
   ip_mc_output+0x287/0x930
   ip_send_skb+0x11d/0x150
   udp_send_skb+0x63e/0xdf0
   udp_sendmsg+0x1235/0x1da0
   __sys_sendto+0x32c/0x3a0

  Allocated by task 97:
   __kvmalloc_node_noprof+0x1d4/0x620
   alloc_netdev_mqs+0x81/0x12c0
   rtnl_create_link+0xaa3/0xe30
   rtnl_newlink+0xabc/0x1f70

  Freed by task 99:
   kfree+0x131/0x3c0
   device_release+0xc8/0x240
   kobject_put+0x14d/0x280
   netdev_run_todo+0x4cb/0xc70
   rtnl_dellink+0x362/0xa90

Protect the device lookup and MTU read with RCU and use dst_dev_rcu() to
access the device pointer. Keep the MTU limit and headroom calculation
unchanged.

Fixes: 628a5c561890 ("[INET]: Add IP(V6)_PMTUDISC_RPOBE")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 include/net/ip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6f602df72ee6..14d6f77f3bb8 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -543,7 +543,9 @@ static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 		return ip_dst_mtu_maybe_forward(dst, forwarding);
 	}
 
-	mtu = min(READ_ONCE(dst_dev(dst)->mtu), IP_MAX_MTU);
+	rcu_read_lock();
+	mtu = min(READ_ONCE(dst_dev_rcu(dst)->mtu), IP_MAX_MTU);
+	rcu_read_unlock();
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
-- 
2.43.0

