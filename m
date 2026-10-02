Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AC35E1BD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971268; cv=none; b=NfJAoVvPofLUQhz98QkyAU6HZuMGq8amxQe6bW01dOHTo0kSc7H8gMbcKNbIgoNCdAQeqgw0FYdOwVvel7bRSoflSPc/y1XGo5NhRHLPXW97fFkYND9QNpxmIcZyi2qOP3a3EXDJeYGjPV/ctVLRfFq9GBcfuxWV2KsKLBE1gS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971268; c=relaxed/simple;
	bh=2Lur0doSNoPwg7OANYfGC/ZInsmNdVgxB+r3ZxA0ANo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/kc2AJ6evIJlZtFv4/BH7SfFLoBSjGEJoTbuad+qwfCQ2Lt5Swst/5O3QSOtrvigZm4Nxygfzrdbqli/U8X7Q5tsrJN0bQxfgQPgTw8G/Z5BcAiCpSv0MVnxRs1aOxaEahk8N1X3i81zjqtsuqt3zHDCDjZ9PBtgpbIDFsvH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Ep+g7Btc; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Ep+g7Btc"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so1767984c88.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790971264; x=1791576064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8GWFjQgkDhj7guIlcMM08SobteqMdy0BTH8OwhzKqQ=;
        b=Ep+g7BtcrCBhhRhF38pA3FaUxvZlDWMe42rvGjqyFzOU4IZnFhlIiVq0cihwv9oweI
         fy8/CMS21PO08+A8bVDVnJ0vINMBmoBL8Iuid6cx/4oRoyZtcRNvA59AQlrk9rj4XXHw
         nXOrp5emwjEXC59g10X57uhHTlWO2zMeupIIXdGoRrtH8IXIufzJVf84Nb/O2g8jkwe7
         S3w5lP3hVctkNOzGwzf9b2IRAuZU07vPGDKF/jSvTX7uB3BP1nGZfzM/sCpGQWrdA73V
         cNH8QJ8dWqQTWrbcngfHIu8Ic9p+sWlgPmk5tBhimFFCq620N49kcfaZ0Vq/+ecmlXBO
         YB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971264; x=1791576064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8GWFjQgkDhj7guIlcMM08SobteqMdy0BTH8OwhzKqQ=;
        b=z+pXHYvzG3a7fxeSPbA1cGIHrEgyJ8p6g/mSkKmpGSdcaxNbcAHCduX9ouHNNvzVpo
         uDeElZpuOeHvz8qoGoIp35hoiCLODRDaVb09NjPcKxnD92gmjGDtQ/7jajy+EAa8utqa
         Z5XsXfQo7XsyEF771UPOR1lfWRIvTt88tr7IVULh4vo7oMJyFP3tRZLtO72WxqO8BHT+
         c3BE+GU2jrkb5h1hU3M9yz3KTIln41PMY/5UV29KKGFG1to5ce4kXH9qjul7Zxb62Kwg
         Q0zPRdNa7o55h2WOt3WGdKFblCgYLEsJqPO0T2qCuFVJMdf5X92JYsOGR9+sC/FM+9iL
         YaKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVyWKdOgWpEgJE31uUwKLd45wwcW8NpxjeFOWwjj4zTv3ovLzbIod/nba81CsTmJUTlqxDdoA=@vger.kernel.org
X-Gm-Message-State: AFuF++lKcb9VckubVXf4BSuW/rIGkLf0S6tVFGdUNAkPtJ4MXHxcZfKL
	uBKaB1DKmHQUhxd+Mgl7ic/QQRk2Tqdj+oKrU2MEhZoIINitLIuyJEZsoE9Hq3xDo8w=
X-Gm-Gg: AYBFou1jy9x0yD6Y8wEsgrvMIi3Y+Y8W/KA20soN6wjFhzranImu92ENVlrFkqn+tDd
	xb69zVLTE9RxK7nLKdZDFb6xu1pS0Z1SRBtL8WvohsVxDKNLpYrnBnJ8g29TWxj6A724iLGyfnE
	566r5h8/iOr3sO/k+3w07mk6yRF0JTBTlAtzmBcc/NEdNjJSOUBXz59KBY8eOjPBUM86K23GNOS
	EkWqulPJZMfp7oAQXxfH5ngElufa3rVL5Q81K259j/qrZxwXuEOUiBji6s2RUyHLds1PcBniDzV
	PDme0EZli9d36YON0G3yhLyABy70OGJ6Io/HsMKn4LBk7360pFNxvXN8Jyp02lek0DCmoCzlqz9
	4OONjkrVLoO8pyDhhoAKKSw1F/TyMpvG1y3s/KIZyRxJFqAyzeKFovk1aNKYHN4N7dRybqdCBEa
	3suiBOnuX3JCz56lOjE8GD0cGx+n2wFmu/8aQYZ6/FWpXLFzU+cCMyT5afE2hplhryd0ZnimBTo
	SzjMElMDxk7pD2Ej/x8qOVY5k3ppztPn4ulmkSweTLiH+zaUOhcvx7mqthVX82WVgddwPM=
X-Received: by 2002:a05:7022:fa1:b0:138:148:6a28 with SMTP id a92af1059eb24-14f5b710271mr5561089c88.18.1790971264078;
        Fri, 02 Oct 2026 13:01:04 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f4766f92fsm8116482c88.16.2026.10.02.13.01.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:01:03 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 6.1.y] ethtool: fail closed if we can't get max channel used in indirection tables
Date: Fri,  2 Oct 2026 16:00:58 -0400
Message-ID: <20261002200059.22598-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 2899d58462ba868287d6ff3acad3675e7adf934f ]

Commit 0d1b7d6c9274 ("bnxt: fix crashes when reducing ring count with
active RSS contexts") proves that allowing indirection table to contain
channels with out of bounds IDs may lead to crashes. Currently the
max channel check in the core gets skipped if driver can't fetch
the indirection table or when we can't allocate memory.

Both of those conditions should be extremely rare but if they do
happen we should try to be safe and fail the channel change.

[ Backport to 6.1.y: kept the older int-returning
  ethtool_get_max_rxfh_channel() and propagated its errors at both
  channel-change call sites instead of the upstream u32/U32_MAX
  conversion. A failure now returns the helper's errno (-ENOMEM or the
  driver's get_rxfh() error) rather than -EINVAL, and -EOPNOTSUPP also
  fails closed; on 6.1 IFF_RXFH_CONFIGURED can only be set via set_rxfh
  paths that require a non-zero indirection table size. ]

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20240710174043.754664-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and net maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-46834. It aborts a channel reduction when the
core cannot prove RSS table entries remain valid.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-46834
Upstream: 2899d58462ba868287d6ff3acad3675e7adf934f

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 net/ethtool/channels.c |  9 ++++++---
 net/ethtool/ioctl.c    | 11 +++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index 40315886201158..05f3068ec0fe35 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -191,9 +191,12 @@ int ethnl_set_channels(struct sk_buff *skb, struct genl_info *info)
 	/* ensure the new Rx count fits within the configured Rx flow
 	 * indirection table settings
 	 */
-	if (netif_is_rxfh_configured(dev) &&
-	    !ethtool_get_max_rxfh_channel(dev, &max_rx_in_use) &&
-	    (channels.combined_count + channels.rx_count) <= max_rx_in_use) {
+	if (netif_is_rxfh_configured(dev)) {
+		ret = ethtool_get_max_rxfh_channel(dev, &max_rx_in_use);
+		if (ret)
+			goto out_ops;
+	}
+	if (channels.combined_count + channels.rx_count <= max_rx_in_use) {
 		ret = -EINVAL;
 		GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing indirection table settings");
 		goto out_ops;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1f64ff5f3f21cb..439871dd1ca83b 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1832,10 +1832,13 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 
 	/* ensure the new Rx count fits within the configured Rx flow
 	 * indirection table settings */
-	if (netif_is_rxfh_configured(dev) &&
-	    !ethtool_get_max_rxfh_channel(dev, &max_rx_in_use) &&
-	    (channels.combined_count + channels.rx_count) <= max_rx_in_use)
-	    return -EINVAL;
+	if (netif_is_rxfh_configured(dev)) {
+		ret = ethtool_get_max_rxfh_channel(dev, &max_rx_in_use);
+		if (ret)
+			return ret;
+	}
+	if (channels.combined_count + channels.rx_count <= max_rx_in_use)
+		return -EINVAL;
 
 	/* Disabling channels, query zero-copy AF_XDP sockets */
 	from_channel = channels.combined_count +
-- 
2.39.5

