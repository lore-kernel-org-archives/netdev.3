Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A063CE4BE
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976329; cv=none; b=c2PUJsQUbAb+WACfI78PpwIeluOqGJBQiNUtshUqqavfT6gGdhQHKAixsxJHqvA6LXSOIQwuqSEHjHEW/Q6r6kocl3CtoEjfzgWsDYgxlwnIEbmXWQ7laI6ea5IRS82qaysXueEflCRx/HFQSZNbY1xynqm4J5bi+HTnKSRGAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976329; c=relaxed/simple;
	bh=9aWfK60Ckds4L/biCInfmc5Y+mPQ3yBYOZ7PLGxJJso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3u6eFoA7OmxQs9JZmJRiXFruGRyClkJXV3G7rD11Ev79iliUoubE1FL9CKiXUUR9z7DS7d0a6IId7BU4pp8Vk800JNRiViYZOau8Ru6TYG0w7ne8Px3cVpTmti4JgwH+ZzPj7IPnQkgkqiz1oWCSnaxBf1uGbfslIf5CM5lvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Isa/r3hK; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Isa/r3hK"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso1047655e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790976326; x=1791581126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wwz5V5DznazyEKiv4IPRIgKMZcVLA06YApkEuH5pcPQ=;
        b=Isa/r3hKxdf+jbnew8xlY8wzTq4bpyJoy0lAGFL2byOsYtHoFVznWAbfpmfweCTD9O
         +MGjMpzvFevkmghNTD8mlea4Bf69No7s/HOpwpQcTkcWXQlS7EJJhhAxpPwDppsk9tHF
         gYW0jWwCZRr9BM6zcUY677hcLoDd5ytoK07SBpb/0MskHEkr8n+WB/91paiFf8hffFaW
         Wid6tofro2snMaBm1Er09oaPji/lMgDRtQNaxgDlshVee3520wwFp260qAiSvbOdqqSf
         RiFE4GxQKf0CYNLK37lXDfItF9wZQVPA0TvpVOGcE41lkg/VQK7aF5nDnHbOe6G4eYbV
         XN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976326; x=1791581126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wwz5V5DznazyEKiv4IPRIgKMZcVLA06YApkEuH5pcPQ=;
        b=fU+vlx1pcr4WRwHapXDtIHj1HWElykZARAWcMKJgrlfhXSSBsyMfSvxnlECpAPlL5v
         6y5s4rkXZeJioylAmjrGVA1ooebm6S4tEYeWpxvbK3G1vQMUZm4s5LWuva5C7O9/w7ub
         8Ww0G5KIwVbFfy4Jym7aAZZImEM/zYklPggxJK32yVBocIRzyECe3eepkLcn04Stw/ul
         Tb+UB8ibQ97/Yw94McqyU3A9kMbSaUXc86pVZ/za+7O50xIawg4792mIpPhmyZ5vd561
         WjX0GvmAGv+rlr4chAYAn30NbGVhHx3TCsBQ0VrVe6GBUpFWdpovdgmO9UBOdiGzABni
         Y+ng==
X-Forwarded-Encrypted: i=1; AKwUvBzxQjbtQBRAlg3Y6XoEV+/9Ks/D7RAZ4DsYYVeNHn4kBM/bDkXh++ZNmuE3d4dwZY1/YoS2wic=@vger.kernel.org
X-Gm-Message-State: AFuF++lVNENVRUWl/T/5FCheTjvCljc69Jgq3bothKd7Fvov/X87Mce3
	SgsmAZ+jHSVUr7bAmfdNLjCQOZJtv4I9txhw034mMzVeaaoLQ5phrhuYCXsQI9CQ3Ts=
X-Gm-Gg: AYBFou04uEWdV5zVXirWUGUZvrhXuEZzSfp99Yl9SZEgGv+rDMX11mtZEPC1LE85FY+
	H4FSkLQ/mYiMyjdbt/4FhJC03UMrjvuCIYtbNp+q8z1YaEtuZ40GmkG6VZIKDLTF24/dvoPVf/q
	75Ozq9jNqE8QBE/aox7M5az8eJmI2+w9FlH1r3kLVOygqVq+pUsKubqmzansPCNQXpz17VE6WM9
	Ysw9MfuvdHc8I0mJ4wBa1l3ktnlcKYhMJ6jYj/3VRhznDRSFv/pmKTGlbQcYhe72E4zgMNCbQsZ
	V/X6ajq/7vaN6GLzjTdVC58dZMR4HLcP0S2ubFbNiNYZRcjLM/T4gbE4fxXOAOkfirNhAaE53MI
	l+OaSa2nacahv5TTISUC3l6IOPoOAB8gpOyGTwxWH6VtaTbIYaBsBWtq4IIMaeLoSgPtwa4D0Mg
	YEg9wYlTTLB1c6KPAd5vL23YMuKP8S0uqUxFaXINDVWP2me5EnCH+V+N0V2CH/bRITOj5RuRAoQ
	d4YtD/OOKRA64TCR3AfgGtqEBuJz95+UqegxnzJ8zGoWGjLM+8XxjIP2FYP6oCazUWibm7hF+PB
	HQ==
X-Received: by 2002:a05:600c:4f93:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a027eb058cmr61869705e9.30.1790976326117;
        Fri, 02 Oct 2026 14:25:26 -0700 (PDT)
Received: from localhost.localdomain ([197.51.72.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253ae9sm7183149f8f.2.2026.10.02.14.25.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 14:25:25 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] amt: mark relay data as a UDP tunnel packet, with a selftest
Date: Sat,  3 Oct 2026 00:24:56 +0300
Message-ID: <20261002212458.34247-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_send_multicast_data() never calls udp_tunnel_handle_offloads(),
unlike other UDP tunnels. With tx checksum offload on the amt device (off
by default), a UDP_SEGMENT burst through the relay is dropped before
patch 1 and delivered after it. Patch 2 adds the selftest.

This follows Eric Dumazet's suggestion on my withdrawn [PATCH net] "amt:
do not offer software GSO on the amt device":
https://lore.kernel.org/all/20260928181554.85766-1-omar@blockcast.net/

Not touched: amt advertises NETIF_F_GSO_FRAGLIST and skb_copy_expand()
refuses such skbs with a WARN_ON_ONCE(). I have not reproduced it, and
it would be a separate fix.

v2:
 - shorten the changelogs, add Suggested-by, and move the testing notes
   below the "---" (Eric); patch 1's code is unchanged, one comment is
   corrected
 - patch 2: fix the shellcheck and 80-column checkpatch findings reported
   by the netdev CI, skip when AF_PACKET is not available (v1 reported no
   result and exit 0), add CONFIG_PACKET to the config, drop dead options
   and code
v1: https://lore.kernel.org/all/20261001171016.88208-1-omar@blockcast.net/

Omar Ramadan (2):
  amt: mark relay data as a UDP tunnel packet before sending it
  selftests: net: add an amt test for UDP_SEGMENT through the relay

 drivers/net/amt.c                      |  10 +
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   2 +
 tools/testing/selftests/net/amt_gso.c  | 457 +++++++++++++++++++++++++
 tools/testing/selftests/net/amt_gso.sh | 269 +++++++++++++++
 tools/testing/selftests/net/config     |   1 +
 6 files changed, 740 insertions(+)
 create mode 100644 tools/testing/selftests/net/amt_gso.c
 create mode 100755 tools/testing/selftests/net/amt_gso.sh

-- 
2.50.1 (Apple Git-155)

