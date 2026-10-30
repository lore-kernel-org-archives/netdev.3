Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319302;
	b=gvdvI3mBapKSZ2ZcBBpTnWw3SJw4x3cCmfQF5pM4KPVrdDboggaEYgqo7sXwoKdkHl4k
	 uHCdGjTOID+BAsmOb1LyY7y1ao/ApmKJtD/29Paz8sKdfainDgBNT3XZ/io9GD0OhuIbv
	 oU27qjTh58hyrC/+NedDcb77F4lk+Y7igS6eNNTDDM8Gnk3oO+QXabm4Xa+VQly3iq1Mm
	 o7c2t0FifceOUK9PseeKqLennwSZVieMAVBgY4NTiUYJuHnKGLNVTDJYR/5eYSzI+BuBK
	 kx5sCnLey11tCdsSdBW3zyJytTz3QRiUaregI2GtL1HmBWM1DiGZh0kiTPLLzemdy7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=u0CLwVk3a8k/4O+bQ140RorSIVT9PYbg67sstG2f+Bo=;
	b=g7WwPPmloUWLNPsnweFPKqJr4eMR62L7Mg6sJuxg6Qkq6c1369j2YsFOUvkYNWfFiseV
	 +6ZZf150z2Btrri55B+pF8Ci1+3lWHkCqsHm9eMJRXPjfp8a+v/QhjGSlXiIz1exKtJ9k
	 Jki7qzhK+mkuoFXWrETzxX2HzF01ArZjpErZDA9OF/Dh0oUG3o0JFSCPkxgBF+tKQcRMG
	 tDCU/cYyPYimchYI1CV54Jk/L7fObxHBEbU7bfNzo8y///tpZloSRLg9ju3+W++mTcB1h
	 xa3+qAGknBJeCyzRXHmTtrPZ/uoiYWZkgSYcNii67ycp2NGU9bBG0VJQyWENcbrISFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZFXZrpe;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036AE606A323
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 036AE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZFXZrpe
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso74020f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793319300; x=1793924100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0CLwVk3a8k/4O+bQ140RorSIVT9PYbg67sstG2f+Bo=;
        b=NZFXZrpeClInr/QV4HMbvk1egVMR0LcWwDJBnnk/iAjd65Kpds/7cjQ1p4KD8Z8sAO
         k1dPLyM7BH36zWviF2EuhNnjHo7V1PVawky+iRECENfKzhNj39T0QPedj1BU469jjQf+
         +efC45V9bpO01zExU+EI9w4GrpZgsA2IYHOqPCQVHzD+Qi28oS2cbDqkhhSpjApTEt1D
         s6CL+lbWFXPpLI+8PW/dS0P5ydR8kmyc6bgnqMGPLyWHdRhCc35xspvSRTMOQB9WBkBm
         VyOSqen3Qq0OjC0TPYW/Ky5kg6xnj85/Z2CVE+o5mEe5DyS+SvQETGFabTVPRLWKOrFd
         1baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319300; x=1793924100;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0CLwVk3a8k/4O+bQ140RorSIVT9PYbg67sstG2f+Bo=;
        b=dzTNBTam9emBmt36j2LZFEU74VnJlSP0mojsk95uRhlu+nYbBJPP90ZC4HwgEaCJw3
         QMc9KS02e0NUSsjUEpTX88bfhq7CwKMH4ooUg7f/Fd8PYI4H2KTA4k0WfMSXSeupcuBk
         0Hs3PlgXGVgzMw0HBQehuE7S2/M5o3KCTJc48YkjgV6YfGaOapdhaOp38T8bSVK+d9ea
         1TuaY7ESVTtUtU2CAP9AnqIqRql19UbALmFUAwT/inB4DSMBATl/FsFleWKPajppECkB
         gEp+DyiRgUDgrmyw+X8Q9CNPSYLGnHguK3x8p+xN6BqwQAL/MbVJDq8O7NWhNiAgZE2M
         9oZg==
X-Forwarded-Encrypted: i=1; AKwUvBz0M50gW3arDUM3PUAwV5mZpNZKgq3hcWlPm9TlvXG490SeRGM2nxvJ7RDdEC9Wuf0My8whExw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6jJy8UWN13NsXVyfNq4TG72J4862Dfg0c5fJGdJ70fro8LMZC
	QrpGxliIFqewGPZjkXgVTaoqxto/lZvinqPbewqBQ8I0nHWK6uC2bvyI
X-Gm-Gg: AYBFou1PT9iaEBZMMF4PT2RMGTsoAP6PrDb2eoDgu07aXEYIHRQPlk/U2vWFAaSQ9+2
	t+4lpDOkutnmTKB9WaJQBz9yF2k/g8ioZGiWDXwpFNPgz9ICv0c7+84hYA81KCO4JhU4CQyUO0u
	vRmmqf5lOVYK0w87d5cHmrkuCXLvZm39X/8XZ+ivEhFI0N+Imzz5TsBmmZRDr10HRkCB9GOEwie
	IS7+5O6LN0UVlb0p9Ymf46JqctRy98WZ4ZuTfV3eSxzA457SbtEQUY18kKlUpSypXvNIe8JTAbE
	dPU1uTt+JDyCYOsAT5LamxgsChbcsWcWaDx03HSl73A65ph62+FXguPyPklz7KisKrsYgFcxuVe
	pbURTL2ytDy9CYYBO2tfpyR0h7vpSjFQrOkdl4WZVm4jdpjxwhNwcFQ1uSaf+rEUGIDsbJu6hdP
	DKMy0hJ5UwkuO3jEbg01yb4i2PgWLF6Ig7HbeZjj3QgNqaI3H1DWeA6a0BPlIBxBDRDn1Ha+tQK
	WEiRT+d25mG1yVkLFcDbmmRyRzcHDy5CSaTD3bm4gVFaqrKjm/U25bCUIrp+GAvQWDFN4Ctl1/j
	IieUC0FpwL//hbiTrzFwIehsHCSOivc43I3eoOb9ZmSzt/ya
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr1719562f8f.50.1793319300294;
        Thu, 29 Oct 2026 17:15:00 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm15085f8f.45.2026.10.29.17.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:14:59 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net-next v2] netdevsim: reject port addition and clean up ports after a failed reload
Date: Fri, 30 Oct 2026 03:13:20 +0300
Message-ID: <20261030001444.289973-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
can be added via new_port after a failed reload.  nsim_dev_reload_destroy()
returns early in that state, leaving them behind.  nsim_drv_remove() then
hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free.

Block port creation with -EIO when reload has failed, and delete any
leftover ports on the early-return path as a safety net.

Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Tested with syzbot C reproducer.
v2: drop Cc:stable and target net-next.

 drivers/net/netdevsim/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index feb88ccbbced..61f0824ce4d3 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
 {
 	struct devlink *devlink = priv_to_devlink(nsim_dev);

-	if (devlink_is_reload_failed(devlink))
+	if (devlink_is_reload_failed(devlink)) {
+		nsim_dev_port_del_all(nsim_dev);
 		return;
+	}
 	debugfs_remove(nsim_dev->take_snapshot);

 	if (nsim_dev_get_vfs(nsim_dev)) {
@@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type
 	int err;

 	devl_lock(priv_to_devlink(nsim_dev));
-	if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
+	if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
+		err = -EIO;
+	else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
 		err = -EEXIST;
 	else
 		err = __nsim_dev_port_add(nsim_dev, type, port_index, perm_addr);
--
2.56.0

