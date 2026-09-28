Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B784EE86B
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626999; cv=none; b=k4nqcFqrA+1aDfbcOp/zAmklqXyindA74LFpgOVZ/VvhwXCvSLYYjHSLMG5lrW0LKqW1MHptvSu4g0/aFTcqiP1tTeAhiuO+Sz1a47PCPx8JC/CYj/cdy+YXzHxxoKSQhBzUF6PUojz9yKjr2H+eiZPuAOJ0nxXLMXHjvNZdAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626999; c=relaxed/simple;
	bh=iLiBo0vYpod9vZLl9UBi8bgWGF2bDNR8qRFcnNTeCHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXTLWnUNSM47bMKZQKxbyeephUHLK6YjgZ3WgQrclm9Ai55j2BkOoB/YdJJAW1opztFOyBYIRUCwD5ZyJFOb8yk8dP7OKNUQxZLNtnRWtl+kJV0n1aaOiG0P1uKnqBIM3ZQdqhyy8xknUsC2EGZXlQIWbtnIcW008KcjymQ46bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=SOnF6IhM; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="SOnF6IhM"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887b799104so1384375f8f.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790626996; x=1791231796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zy3J2tytWwgmIV36YeTTMRjanXAuGoVq/tIKUKUhT7o=;
        b=SOnF6IhM67NUoMYEuW4Aw64sjECJ2uLqytTeLXM4FfhDSM683MKXm+KxOMN4hdjrFj
         WDhTDMeIE3MmJzqCNoInb1vL101zxSfGJwoxf2Yx+m9E6bIvRjpD6zZNHG7RhzM7Ne3Y
         6bxTLY1HeHQA93zW7ORRztmvmxm1EkNP4FtghaFYa4vyB8TZPqMA9qhUg1nc/BOFsBPw
         99n2SjibgNgx5b3wbtS9fPJw+0NbTLcBtagye6BDCE1pu+nr+Xd2SzNDyZmTJ3UZ93J3
         xHR3aJMUrbfC5VLfGTsa0wpnp1yDMaTL21JDW6xTz1rfoMr7AoaVKKy80/EmJvTOyvnt
         28QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626996; x=1791231796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zy3J2tytWwgmIV36YeTTMRjanXAuGoVq/tIKUKUhT7o=;
        b=KBmtbOVReCKmH/sNZVT2xoHLRUtOaUAOoQIlolnvsLSAd0ljynGiZZidSaLMb0eXVq
         NL4j4SWokwvR8aFXwUhhsZYFpnFXfajMhtoJo57yB4pDy6gh9CoitncoqsgGAfJRGJO/
         HWRZL9MeKXJy20jv1xc6jV+CRphrQwC/lUTHxjXwJ7JMWtvNkBnR9WVLgQ1dzlL9iJ05
         T3q9N8ScCR4HIoPRmqg3gQO8bJmGWhxIVEe8bTMfC6Osr8bg/0du3XbUnAh+6f4HLdL1
         HoEkZRajNNDKlyROWxYs4n4qxTDsaVS1TIG8GAFw/UhnBUHAC0bAe2tNj0XdzMibgBMq
         rEPg==
X-Forwarded-Encrypted: i=1; AKwUvByfIZvUocD9mfgQOqER+9S8UEWo/kJMjW0vKWmM3Xx7OZxODYvyYnQzpYvFyvSZRm/g1/Yb7v8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIZORB4hQ4pDY4j0djH2n0GoRMKL8r4teLYE+Pjf648piKm6C8
	Noqpk9YnE1gesBP05Gj2+R7cNmJZPViSl4DsO4mhhu2RA1e+69T3DlD4VpM9Ti2rGXE=
X-Gm-Gg: AYBFou1OK2xPFKXnQFbkV9XxG1uewi62cj9inP4xDoSC9GITYe2VBIKRsLtwCzyGu48
	kUKChKSJfbYke3TCHPTEv4Amc+ZT10eoW5FCLzgR+tGz6zJkHh6F9xx0lDztkK+C768SQwnYSeV
	fbGBbhaZS+nx2rkadwX1RUoKSFJpJ6UQ+iIKAqkErJi36kl/8J1XSHsEsuHEY78WyMTkwheBa2g
	peh9VVVxMIugMNkeQgduYwBtcmSDI4GxPCGbxAd/xwOOJubRFEUfg1+CBJpnqe+s5oEkf1IIlZf
	d6kOiUImr55DTbuxPpMdTP3mN+h3SEyHDwAc/nL/mi2Pnx+/ADqEgi3mMmasggmezDrwkdS/WMK
	axKQmaYGM+BiyEHQE40aCa41mfdwyuED3Tkf08AXmChWpoXQf2cvAIgQmCNscRKDlhqwyKqkc2W
	PbGTBkuzBBW+Z8Grx7ctcMMvG3IfgLiwAwb8g/JuESm8PjvjkTMUzs+0m2lqVu6NnoKdwwumSkW
	YFm1aMXSqV4oEYaaV//swhuHuFr4TEl2Afj0QE7yCXezxLSmom8aY54XR9fsk6GSGbIrltzT+ZN
	QQ==
X-Received: by 2002:a05:6000:2504:b0:487:1256:ab80 with SMTP id ffacd0b85a97d-48871878daemr25904268f8f.57.1790626996226;
        Mon, 28 Sep 2026 13:23:16 -0700 (PDT)
Received: from localhost.localdomain ([197.51.38.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm29620500f8f.2.2026.09.28.13.23.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 13:23:15 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net v4 0/2] amt: send the relay's General Query directly from the receive path
Date: Mon, 28 Sep 2026 23:23:10 +0300
Message-ID: <20260928202312.74574-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relay queues its General Query on the amt device with a raw tunnel
pointer in skb->cb, and a query that waits in a qdisc can outlive its
tunnel: a use-after-free in amt_dev_xmit(), reported by Microsoft with
a KASAN reproducer. Patch 1 sends the query directly from
amt_request_handler(), inside the RCU section that found or created
the tunnel, so it never waits in a qdisc and nothing is stored in
skb->cb.

Patch 2 adds the selftest Taehee asked for. It counts the queries that
leave the relay through its amt device and expects none. It fails
without patch 1 and passes with it.

v4: patch 1 is unchanged from v3; patch 2 is new.
v3: https://lore.kernel.org/netdev/20260928181601.85857-1-omar@blockcast.net/
v2: https://lore.kernel.org/netdev/20260922214150.13970-1-cenzhang@linux.microsoft.com/

Omar Ramadan (2):
  amt: send the relay's General Query directly from the receive path
  selftests: net: amt: check that the relay's queries bypass the amt
    device

 drivers/net/amt.c                  | 48 ++++++++++--------------------
 include/net/amt.h                  |  4 ---
 tools/testing/selftests/net/amt.sh | 29 ++++++++++++++++++
 3 files changed, 44 insertions(+), 37 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.47.3

