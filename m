Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228587;
	b=UZWbcFGtN1Odp+IrrVUd+cm7eKCTLlCYzmfAUYid1HU/U9JUT6UbepqpAxd3ye2TA65B
	 P67/cvm4nSx6hTSI4RIvu32mXGJn6rN+QAO47B+6aYpTtDj0azeMl4bvy/9xr0hhyyDLn
	 XYRO+vgacfLoeyTxzOzZFhJjx9ZonBYsil6OazvEOhep7Lc7qHNrsVNTo2tplLUokQr9r
	 2byCfTVX2lgA54Hn4F++Yq8BPYUzec6yzP24ZOkm4jPiaOEOqdoYB5wcmsao7wHZQwnqp
	 7Ab/3X7THA9dIWyp2cHDvVKtzc6fnQWj6SQtMdqJc8MZGmsUTDFVdMOX8a6mSKcHMcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mG9Y8k2vnChqxaqg4HKskuIcpQ6X4WU53zywg6kGBHQ=;
	b=jqDLwxf5enTb+dItyk+YheS+DPXpoB1oqbySZWtk+nSsC3uZNkMcfj7Fqxye/7SfySwp
	 6Y4l+KzWjWgRa7jzV7K9iONef2rySxF25WOkMvUvm2X3rUOU0Km0weBiTZTvUvAODGGnJ
	 fKPFcUAx1R+PfJlyW47kiRh4faPl0+4dO5fu8vcj/x7vtHEQFF5LACGN0nPpCPw04s3sI
	 QddvbrTtGSIwlfe1ZdWb7/XpkMobTkuhonG/jHx0waAA82yQN+QBl2zqwpZqGJIn8OQXZ
	 TGN4eiV4jKLZcl5y9oBvIysLHPBvovE+oj/BozKhYLcE72jfnAMxnK2vOKCTy9nWUZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oof0SMWW;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC0606D80F
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03EC0606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oof0SMWW
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f84a55e31aso412975a34.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228586; x=1794833386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mG9Y8k2vnChqxaqg4HKskuIcpQ6X4WU53zywg6kGBHQ=;
        b=oof0SMWWrTw7FAV1sR7haIUYvt37AGp5bvoFIQrQqKl5y3EQHSNObrqGZoA43pTS6/
         vQ7kyrQns04frayvawgKvXrnk9MiPVvt92jHDHu9jcnmECI53hw4K1kVIzXNEhQLX6KQ
         szK/zf6NWtZOiGpPvIZlEdWYrgCNc7e/0oPsm9fnuurtXeL60+h7Jug7EoeLUoKxrLdT
         T1BTuZIVSA2vkrrBOvrJhpwQM3JonL3TONgmJu6ExAtrP//EsJb1M9piyWeHwn3yrWrh
         mevuVNdPNwX+c4Zlw6GIWl1au12qv6htBKq8z5z6DyvrsB9ZTlsRvQy0RlnTBSsJLQso
         mVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228586; x=1794833386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mG9Y8k2vnChqxaqg4HKskuIcpQ6X4WU53zywg6kGBHQ=;
        b=2dKw8p2RwzSwtP5XqduCeKWT33JgjiTlIYoHNaKG375xvfWR4/dTqP2Wf5S/KogV7L
         cQarT2YQ55bG6EnnUXd/c+SeZ5OeHsL4hktoPLBNLOXa347ihLBbCMLJlX4YkP6lMN5v
         2jQkzXFbSeGUrHtVaJmi9HWr+8x11slu+JOAiJahHcm9PgWiUgHm9o824UrM8PTV8vU4
         RpRZaGMcgd74p4Z99oK5E28U3/5L3hsu+DwidPhrURd/AiY51rpI23EfAFhoIp6tXvDl
         RFK4haXCRRo8bu0TXOmtyoULVEnbblA1YVA4iMmdeDxcTSbH0Jqjf+mW4nEDCdT9/DT5
         CMEA==
X-Forwarded-Encrypted: i=1; AL+hErFAWUJF/JnIeHr8vEaWdSqSdTtxB0A6yynuwMWd0dZdacNhhnBvvE0PvlxPa/dv/du/+Fc1ydg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F8HH+Rhf6BdWv93ySVDSbdM5tMM8Ka/i7ImJrkIb3R1U+5urJ
	2Lr9oX0fM5+RQ4uWIgXmAzt1a1GKcLXyvS5zFb6r2TZwHP6uwAImevXV
X-Gm-Gg: AYBFou0sN3HFQIWSeztJtX88Ur6hi4izdOWv7HpyKpgK3PbO0IeL6FwxaWn/ulZYmDP
	GHPTtXlF+fVaVQKvqwmj1Z2j162uMOoiffbrSvj0S7zYoGFwNHAr7OgyBQfji65sftLg+wd0NSH
	5gXrLDDV8gP8pDJ/+JRz6Qty1XESjI4G6sqLSKLpzktvjFfBm8hau1r1Kgt4MSXzZECaAJKb/s7
	aydiaZUVf1ohFKKUIH6nfHwAU8Yy6aKpUksxXdyBAW7Qu3bCR4AACIRlMKnzdNmIR3zaOWN+Y1J
	n5VZnMcrx5EYO37Ii4f6RIgRsurdhPOSIAX6OEAAyosVHOmNaV3X0tieNRMTEJsxSoE11cvk/Un
	c3TTUWOm4V6tknShofq19vY5jYIGBX2sBZySNvx+K3wZ1jkKjDFssXyIvlUvlLmdH5aWSf5Tfjz
	ihrdl/RKpV56PCid/8GDSxCR3xf6Ddn04vcDpthEPKiJWdXl/MkK09p/1xFd+d0c0n7srJrWdHl
	xoKzdJS5nO3DQwaFbVphrGU7wsf6L4KH/hkxR00b6UQTkH9ZASP3/suf22VTAOaeguuXnJS3oOe
	w7WZv77vccPA9eXamkKfOlHrIUqYd2GeRbdzjfXiGBuJgDdK
X-Received: by 2002:a05:6830:6810:b0:823:38f9:ea5d with SMTP id 46e09a7af769-85f5078a13cmr3054227a34.11.1794228585816;
        Mon, 09 Nov 2026 04:49:45 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fbce9cdsm3565509a34.20.2026.11.09.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:49:45 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH net] net: wwan: iosm: cancel adb_timer on cleanup to avoid use-after-free
Date: Mon,  9 Nov 2026 21:49:33 +0900
Message-ID: <20261109124933.1603575-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

ipc_imem holds five hrtimers.  ipc_imem_cleanup() cancels four of them
(td_alloc_timer, tdupdate_timer, fast_update_timer and startup_timer)
but not adb_timer.  adb_timer is armed at runtime from the MUX uplink
aggregation path (ipc_imem_adb_timer_start(), reached from the encode
path) whenever aggregation is active.

If the device is torn down (modem reset, PCIe unbind) while an
aggregation window is open, adb_timer can still be queued when
ipc_imem_cleanup() returns and ipc_imem is freed.  When it then expires,
ipc_imem_adb_timer_cb() runs container_of() on the freed ipc_imem and
queues a task against it, a use-after-free.

Cancel adb_timer alongside the other hrtimers in ipc_imem_cleanup().

Found by static analysis; not tested on real hardware (needs an Intel
M.2 7360 WWAN modem).

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/wwan/iosm/iosm_ipc_imem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 4405c85..20f8da5 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1239,6 +1239,7 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
 	hrtimer_cancel(&ipc_imem->tdupdate_timer);
 	hrtimer_cancel(&ipc_imem->fast_update_timer);
 	hrtimer_cancel(&ipc_imem->startup_timer);
+	hrtimer_cancel(&ipc_imem->adb_timer);
 
 	/* cancel the workqueue */
 	cancel_work_sync(&ipc_imem->run_state_worker);
-- 
2.43.0

