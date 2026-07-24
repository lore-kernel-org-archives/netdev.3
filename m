Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5042BE8F
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905322; cv=none; b=dyVl5r7x6csupO1CsBP7Afur23y76IGSDfmdQeyELeyOsnmUod/amKiaL1tgnkx4TIHLFKhvpPWo1I4Zn58G/Ec235zsz0iXoAH7gPt9rFpyAsfm91/65cNpCnYS6HwYPf2ek4a/kyM2Z9XA4AA+omgV8zojYJ5ShZSfbmyArQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905322; c=relaxed/simple;
	bh=jZpVQiApvdoqvkyfzNh9Co7zgPfj9iF84tqhjQfwS8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/oQpVYXJ2l9yxqA6JHCIzn2OvPkF4rVVWUPoDBti5GfHfcKvoUHGABKxhvRmZ5vy5noueXUEzVd4bz1nmTxsP5Pol21FyM3Cnsmr5xXbfzxEWbQTiqCQDvkdNMr4BO2a/8rqp0Ix6fEOhdplqSauw/X1ZbWBo2PwwAr0s1cPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=B5tJocyJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="B5tJocyJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso4018815e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784905319; x=1785510119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u0loH1J+uUio9ZCxWuBC03S9xXhTz3T9vC/rVTNKMNg=;
        b=B5tJocyJgQDBYw+bSBtEA86+A9F4Ei36MUHySwtNJAz4lS4H4zaXTthL5CX9f6hRqI
         xDDEOlQH3VAVNROw9OoXJuQD+ael4xiXSXf1HZ/j4wdZqCJzBiYhTW9OzRYREkXrat/h
         qzuxjj8gwKUCX/j+YsSvXSWvnrR6PmLQPgKFTN2nT6wZKMyYsdulvvyi+9FpET/y5ju9
         p9HVNMonZvf4C3/B7ZbSrck1tFG2j/OBwR/aQAESUfmD0W6KE4ygMcZO8tzTzI3N+cSM
         fa6HDrP1nH+WkYnI5Dnoq/5HM9HWxaeLnKvEsmdoIHm3rjckSMRVMYlq2tNzLOxTSLqk
         Nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905319; x=1785510119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0loH1J+uUio9ZCxWuBC03S9xXhTz3T9vC/rVTNKMNg=;
        b=W4BOV5P3G4j3IntXjbQ9bU/hdFlcV0iUM2F1gjKPjfTgbAUb0LCy5yco31DGlpHBXm
         FrAFNo6a6uym96pL4D2NXulHf8SvNYyi8DP+BcYASkPOnBtqBus4C4wHREOkGQNfalvl
         V7hKKGOjV3+V9kpSCF5OymdCumIQ952BJWzDeqHKr0zniTbbHo5HNAK/MAu9fsDEpy1I
         fjdvpYzuzIrwYAqpRzQAqhfNL+x4iwI979glgaY00CDzt3cJq+fXO49z8gFJmZsjtnRm
         tGSQqNjVr5Iv/tSigGNCEx5SeUl5442XlYDP84GpVA6Y+7bX7xT2igq2uneQtOAzncvV
         VlsA==
X-Forwarded-Encrypted: i=1; AHgh+RpWOg4SeZz1KAYeTeJhk8W8WFjnChDOT4/IzwXL0FapP5eSpeE2YqS/oPvIQF5zGuJU0pSzDao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPqYRbLZHTeKLnVnE+CZK1Buo1KA9zgwbx5+x4mAytyX504df
	UORVqLI9zxQ1O8iWN9heSgGYmSmvQFO5uLWlLEA0b9ykw+GYj9UDrFrOIz/eoJDXP5kj
X-Gm-Gg: AR+sD10k2pzfzdJVSQDnQyy92+uLsGGVcYc2GrbDvEMwGbf7Ro1SOhqea+hrN9GOOIh
	TRu6vjMmQfzc2iaca9OvbIIPGabF8t7dniOlH7Oaf0a8SiSgMNXCtbiLrGVkg/MmNNqzFKp+zSl
	sNBT1zSsbgw2DliFt3evaYegFvRWNKBRDnJY6n6atazlIKIRdIJ2AUnejbtBeoWgwMaR4ZQOj61
	HVcx1mJQTeTU8NcXheAuiXPrc3aLhU8Zm0RxSBUU69QKHwSZ3H1v1Ho8HirUUuEadPOU33xLXyp
	/8U3Sai+JhMFRWMWa1+7k/1qXxs49/6oDYpNczEAE+e8XPq3Y/zToHR6+8S5Ob8RfmhUXe9gNvF
	9KYgak/zNC8Cu718XgVTEsRDwPDD+ctp6ZUlaSCQ7uPHo9yt0xoL/PN/aPmZpFPa8840+GaA333
	ampt7FmggBvJHDTbdq1mpelpBBO0B6LpPLag1RVehJgUcCvvhBNaeoUtak5fAK55os56XTD2338
	xfliW5P5Aw6V9Xlw2aiJ5uOTg==
X-Received: by 2002:a05:600c:a0a:b0:495:4dea:f7f5 with SMTP id 5b1f17b1804b1-49573ce968emr104411685e9.29.1784905318808;
        Fri, 24 Jul 2026 08:01:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5c4sm24123528f8f.8.2026.07.24.08.01.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 08:01:58 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] netdev: require admin permission for the bind-tx netlink operation
Date: Fri, 24 Jul 2026 17:01:56 +0200
Message-ID: <20260724150156.72816-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdev generic-netlink bind-rx operation (NETDEV_CMD_BIND_RX) is
flagged uns-admin-perm, so binding a dmabuf into a device RX datapath
requires CAP_NET_ADMIN. The symmetric bind-tx operation
(NETDEV_CMD_BIND_TX), added later, was given no permission flag. The
netdev family sets netnsok and has no pre_doit, and
netdev_nl_bind_tx_doit() performs no capability check, so any
unprivileged process can bind a dmabuf into a netmem-TX-capable device
TX datapath.

net_devmem_bind_dmabuf() attaches and DMA-maps the caller-supplied
dmabuf to the device and installs TX device-memory state, the same
class of privileged device operation that bind-rx restricts. Gate
bind-tx behind uns-admin-perm to match bind-rx.

Found by 0sec (https://0sec.ai).

Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 Documentation/netlink/specs/netdev.yaml | 1 +
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 5f143da7458c..6c374aca3d27 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -832,6 +832,7 @@ operations:
       name: bind-tx
       doc: Bind dmabuf to netdev for TX
       attribute-set: dmabuf
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index d18c89b5a6c7..07d87445eb22 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -234,7 +234,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.doit		= netdev_nl_bind_tx_doit,
 		.policy		= netdev_bind_tx_nl_policy,
 		.maxattr	= NETDEV_A_DMABUF_FD,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NETDEV_CMD_QUEUE_CREATE,
-- 
2.43.0

