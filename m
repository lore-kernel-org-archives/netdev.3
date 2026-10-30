Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345471;
	b=gpsfw0lbegTSrdueirDmE12QVPzLwo8HBK7AdK03AMgb3CR6PYt4Y/tSerUbx+4myqUF
	 fsxu+Wwa6WB4RgCd4Tho7h9NuBZ38q4pJC6mG8vAnqYsaw0HRdRPrYOVMy7H2YRpa+8Fq
	 58hYI6fx1HPqXxcdUO2xcwwoZwr8wL6+plpCetuY48k7mY1XLmEKytWppaxrKCGASrtaF
	 EhnRe3DxNM0SjFRxQ2S90Y0jbtKcnbK8HYXA7J42cMu07LWEM8m1PG4w6ekxaQntv1eNr
	 hewt3Nd5B8ptrC7d9+f6CSLWgxg4KalbJY9pSX7+FGGsZ1zLqLJje6wBLkSId+8ZPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345471;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cXq4inWh1DUA10f/9+r+ZCv4fkXGQ1KhFeRxjGIa1dA=;
	b=GGfDeVI9UwwCZ5S5jynCEjdyVFInSvkdTirkM6AkKyK/vTip0G3HpF3BVhq2jZVbb4dq
	 KFneKidWySMmYz6z++CJN8u3So2yW7JntUwJUjhMwFnkcZWmnAS+GM8TRVSaqnYxY2DAh
	 Bsuc9uJm7CUSyNLZ5fMI693zeI/6S/S0XSQirsIS/cGoKqplooieMNzGdzFPAS4uoqPqo
	 G26A/h2v1q5YthVs/8vcD/37AcIh5WOr/6rfZu7rC3yykWza+WG3xksTbIfIUIZu36LNG
	 kLa3Vf5e7rjpLl+ZLSyXb6zlwmxMp6dc9YSAyuWDMNbRYNbN5BjPRorR7cuhpTS4yHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=i7bsE9sH;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589B606A31A;
	Fri, 30 Oct 2026 07:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2589B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=i7bsE9sH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793345459; bh=cXq4inWh1DUA10f/9+r+ZCv4fkXGQ1KhFeRxjGIa1dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7bsE9sHd9U5/yuusN6C89zS7jDMgBUy0F+i5c2Ol49ezRAQxMwlyWESpE1DPMXve
	 zrSakJanCOP6hmyglfXvwkS3gNlYiDNFBKwB+IHexXLCVXI09GbEIDdXooJPXja62b
	 FA8aqnUUKkezHDnHW7qQtFNWaq2t3aeMbCMgtZMw=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:5510:213f:594e:6216])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7B833275; Fri, 30 Oct 2026 15:30:56 +0800
X-QQ-mid: xmsmtpt1793345456t2arrjze2
Message-ID: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
X-QQ-XMAILINFO: NSABRmZchf6l7/ydpWP5/EKxyse1t7e/fO8250h+lopwEatCshrvnv+eHS290q
	 i1gah0LQOEfKzwF8x+EGRv5vjPANjazqKiUGSxqSI1luBAECgIJS3jDqKNnbScmDma1aAEUqsn97
	 tTKfPgAjhfbx76PQnoTQDmPHFaldtP08cRunkuoZr8by5+truxh3q5GIfWj8qpMUausiN5Vlvgm1
	 uLZj4N7b9C9YYtLmJ7+Huv769sM2CBSHpsgiV9mRkRuobGZ+vODipnKg+TBUAS95G0omarBd+SSI
	 S/mMHJPZCx5eP0Nx9OVh7X6/c4Z2morepbM6+9WHpnYkdBnvgy1QIIuLmGjIKUwuOv37VHJztyaS
	 gUcbdMnL7zpELY5sodthuLCbOUlXc/Qf3Vl+47e10DVjtQKkJPc548k+LwSk6B8gXghUojGRg8XL
	 6MzE+awDC6cXzi4mteh5GSE1xVu4PF1p7k9rs4XTOAateew4QHqL6G5C0jgoOp+axZJaa7ZC6ubZ
	 tDDhqwaOrsvpV9ljzBAP8hupHHtb42k7zw6xg+L7UbrItHckdqeiRbvAvlhc7ex4VfNshkvsr6GJ
	 195XOWgBepgDdbA1JJoyEt+LbK+ecnB8uxC+GIpYc6n7l3e+oAPnNh2bMG3SBFYFtNA8+XKb4Gln
	 IIlmBFojXOz9WF0MFF7Yn34NliKbD4SPKVDlPTbZuwypfgAHy07pP1cGnrgD2+MqsCdtW1X6WjFl
	 WA7eHuXzeGH3WPDaAPmx8vuEHJPeuihZc3Tfi1ej9a1rr4r7oDmXUekiZ7NfgKdFK26t3br/QA3W
	 XJDCMRMaGb+Xijbodt/7goT0LZsd9Gk5x4PZoQBUfHR1qtKZlbYk7XaxJBwwVA1m/CWBBn5DkyO5
	 bQbA0mkRCELkPK+Xx4p0jrnSdrPI+/TCLAjl3YOLcavw3QWaI2VoxI+YosvZc6hWB2e5mFTmBHIh
	 si3s3YPmy/6a7ldg+OsplU4kc/PubCj7guNqitYL6gjRfOOwBd4zSNOjHwNbXkyqAARK07ixIib2
	 5yKvY4sPDuL1BneMQ1gY8FkgIg9uKKbGBt4z4F8LXyy17V8iRpRrOUVbDYVauzqq2U2XPiTRR1xp
	 LekKMw7RGWG09yNkXSAaI0ifkGjg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yingjie Wang <1075151112@qq.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	alexhenrie24@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
Date: Fri, 30 Oct 2026 15:30:56 +0800
X-OQ-MSGID: <20261030073056.2453450-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
References: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_create_tempaddr() raises a temporary address's preferred lifetime to
regen_advance + age + 1 when the configured lifetime is too short. The
result is stored in a u32, while regen_advance and age are unsigned long.
If the sum wraps or is truncated, the stored lifetime can still be less
than or equal to regen_advance + age.

addrconf_verify_rtnl() then sees the new address as due for regeneration
and creates another one. Temporary addresses are not limited by
max_addresses since commit 4b08a8f1bd8c ("ipv6: remove max_addresses
check from ipv6_create_tempaddr"), so this can cause unbounded address
growth. With dad_transmits set to -1, a baseline kernel reached 2859
loopback addresses in two seconds.

After storing the adjusted lifetime, verify that it is still greater than
regen_advance + age. Reject the new address if the check fails.

On an x86-64 KASAN kernel, the normal configuration created three IPv6
addresses. The negative dad_transmits, positive multiplication overflow,
and large retransmission-time cases each left only the loopback and public
addresses. An i386 defconfig and an x86-64 allmodconfig both built
addrconf.o with W=1.

Fixes: f4bcbf360ac8 ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261029175827.GA1411453@shredder/
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
Changes in v3:
- Replace the broad input and arithmetic changes with the post-assignment
  check suggested by Ido Schimmel.
- Preserve the existing sysctl interface and leave the advance calculation,
  desynchronization handling and verification path unchanged.
- Rebase onto net/main at 5838f10563d5 and rerun the focused runtime and
  cross-architecture build checks.

 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d9..d9d13e78bf13b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1487,7 +1487,8 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
 	if (cfg.preferred_lft <= regen_advance + age) {
 		cfg.preferred_lft = regen_advance + age + 1;
-		if (cfg.preferred_lft > cfg.valid_lft ||
+		if (cfg.preferred_lft <= regen_advance + age ||
+		    cfg.preferred_lft > cfg.valid_lft ||
 		    cfg.preferred_lft > if_public_preferred_lft) {
 			in6_ifa_put(ifp);
 			in6_dev_put(idev);

base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9

