Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746478;
	b=yg17ZJN74rqnr4PKqhGZCX03yap0f5nS86ID0aI0XAH0FIcpF2xJtpuruzut7GSdK2rC
	 GUT4CFh1M3Tnxit8LA/nvd8Qh11O8QX8has5Jgea3A+ja0C90OIi0dVzMHs6uL4x2Hry9
	 leR8EJyNSzlBf0kwI56gQ6YExZTY+2R7UiOF38AEVxG2ihJjNh0/XpU8TjbslnswgfBIr
	 LaTtprA0GMXB5f6kNgdQcfsRZ6eL7gIb4LrVd9Tq7nV2FZ6B4uKpmd6VuwzLuYig5Gjxg
	 QFNjkL1PkJvWaiIs4/XfzXqIzlYA8/XEOvwZvbTFAZSyBLV0NoLpxv5Qc2t6CH6gX3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xbkQk7xEpPULe6XnGsruaXsaytLDEuTXeVWS47gy+VI=;
	b=b8AL5S4pjd2RyzmXl1tPkmQ/Hyet8wcUQMHUvbS0a1Y6QsTkCBGrATn5MIJgbXeATOsu
	 dDW9Xp8TW0eKR/hH8xg9wXjhzXmXPYd+828/Y3WEWK3PTnnCqffMUNawGE/FiDM8mkSJk
	 K57NUOkgu4woXMikTHsajIdzrS97LapHnQ2LpKLYzoJzlMpWYW1LxC8PirAb+NND3Lgk0
	 fZ6Dx6nRjbdVsa8b1O7OJX7F+Bx913DlbqrRLsaW+SNwnPtBQrHwuyf7grC3WfQZYa0zT
	 wj5E9tGJt8C6/374lLafkBjMFgagX+LheoWzQ3D4sbfyLcaJADC9+kqnVLjPtSXQL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z1PMi9ue;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5236606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5236606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z1PMi9ue
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so7709755e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746476; x=1794351276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbkQk7xEpPULe6XnGsruaXsaytLDEuTXeVWS47gy+VI=;
        b=z1PMi9uen9u+BceBTw1Bp4O0O7qibnTFDOvdW2V9nxpKU4T9mq+UORihIspufmyTuq
         +tKmHO8DN62tY6XJr8BmuYWcrsZjZgMF5xWwbyfa0I/1XTlSpKMqbZN/DuS/4+qWaYeU
         fycn+8p1uPLbG2ZDQqILoavc/uVH0hNirHD6zd2MJ1D8ywza/m/iKd0jOswE5oC1HDO/
         qknO+nhNoexLQ9b04mCwrGVYx3xiw28kX8W+MYhhPYMfovDHJT9SoHttev+WWPzIQ7Ur
         xttrjiiTXFx9zV8xcGs5+jbkodiZ4mNGMV3z2OoFT5ANiQUbXb/HvIcWtOQQ6Dm8Xw/5
         +J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746476; x=1794351276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbkQk7xEpPULe6XnGsruaXsaytLDEuTXeVWS47gy+VI=;
        b=bDOOI8oqE2bQgaxhqJg2N9E3ntc52JIgfYOM3l3lT4Toor4kddlzr67ECYJmsbm4nf
         aPgAiIBBEsGCulOn7KKMn/OaPG+r8hbjRBTA8ixCC36Cjc4/4pdRaJZBtni3ESAcI4an
         621NmDsj21IDjfL08gpQ/L14J8W++cUt3hFoVXjBQzE2z6+TtgH83cvTXlWNxys1iy4C
         HOjoo1CwV0oIiLyAvafKPzW2xJ3VFH2fR1+Vcd9QaYo1E9ukX5JUiuKa57RhDQHRFZ5/
         +CeFg3syr31+oSOLnmBTcMpm2M0wSq5oVRpDV2lvJLl7zWy6C+yFgOvh2NS+cO8trZ8+
         CoEQ==
X-Forwarded-Encrypted: i=1; AKwUvByBWyocpowM92otNWNKp62Ho3D8UyUuOU1atOvuw6PF0ZBej+OKG+yqDkMgLr+A/273uVQdgXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j0aDvvNvis05MQdb3q4gk9Ns+TqNitZsg2SyU/wb6qv+vtFNn
	zFdM9FeD6veJmA8wEx1EjkmGQ2gRYYEYZ+8ktgMQC+NAaCeTanDrGaA=
X-Gm-Gg: AYBFou2BJQsQSx74Q9qbYSQumwKR4h4XL6K2QHqucZf4KsGjINdntM+F5VHG77HN/Xn
	kSQnpUD/rdrAKPQ30D/7HVTJBB9Am0bzOXyOq1NB4DwxiHW+AmJQP4RsD6pw43gQZh2QiHRfs8R
	zbB4f6b6Pt6BbObX+0Vpmpbpu4swCtJrBE3jweq0T0Y0gZ6l9vrlIyDYrOhDrcmbrsjanVam0xu
	x58f/lZLr0gsf5lOOW5N0GwbgV1pSu/zII1i0s0lVA5/t/m4jXiiK9uE37Tu2iG2gkgSzE2g0uS
	ldWlgIb9tBpjk2+5LgOzp97h+nWxkJxufWF5s4TVfsYd/9ea+gQOgljLZtxxm6M21jhZQUn1QjI
	ZUtOkhINlidHAwLCjRi7TFVSF2KtV0kKkr5kmnqmKtQ81qI5u17v21iJkLbt7AXzGYhYdFKVExu
	UAMLT4uysc2xn47NYkMOmA4kwLj4U2i9LNqCZ75TqqB+sDagyJ9tpBnvvU6gliqQi3aq2tZWWQr
	Xr663PHAJIxvGdXtPSv/fgSw+OjlOaVJyqA+MbwxwobBkAkYgyJlus/o2PgOHZe9Ex/hZ/7RHT8
	+aN0s3YPgNFI/IhelGc=
X-Received: by 2002:a05:6000:3101:b0:48f:bbb5:61c2 with SMTP id ffacd0b85a97d-48fbbb563a3mr6323217f8f.4.1793746476097;
        Tue, 03 Nov 2026 14:54:36 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99b33sm413768f8f.23.2026.11.03.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:54:34 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Richard Alpe <richard.alpe@ericsson.com>,
	Ying Xue <ying.xue@windriver.com>,
	Erik Hugne <erik.hugne@ericsson.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] tipc: fix division by zero in perc()
Date: Tue,  3 Nov 2026 22:54:33 +0000
Message-ID: <20261103225433.2663943-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The perc() function divides count by total without checking whether
total is zero. When link statistics are queried on a freshly
established link that has not yet exchanged messages,
TIPC_NLA_STATS_MSG_PROF_TOT is zero, causing a division by zero
in tipc_nl_compat_link_stat_dump().

Add a zero check to return 0 when total is zero.

Fixes: f2b3b2d4ccbf ("tipc: convert legacy nl link stat to nl compat")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/tipc/netlink_compat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index d9a4f94ea2d43..75f3193a2a6cf 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -497,6 +497,9 @@ static int tipc_nl_compat_bearer_disable(struct tipc_nl_compat_cmd_doit *cmd,
 
 static inline u32 perc(u32 count, u32 total)
 {
+	if (!total)
+		return 0;
+
 	return (count * 100 + (total / 2)) / total;
 }
 
-- 
2.47.3

