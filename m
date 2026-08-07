Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FA23B62B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063305; cv=none; b=BuAR0P3gmNzB6dQiQS4Yq1Ko2Mqzd8KheGmw3LFXDnOS4E5rmKmhVb6xVv7BlNO8wAVvNar5UyFltxRtLzIwITEuHC8Dx4cFn+z7/jWiLXTC5UkaYvHPfBNCNnuyj0PLSObyUasez9JQUhncOBToYa+kpM0V/MaDicnxZdZStLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063305; c=relaxed/simple;
	bh=ZL9+sQZHP4asdqRDP1EZKwR4QQUfjUwzOHzZncI0HUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdUOBW90A8fwOy5oqVJksV1snEk96MGYUWOLGbboxMLh+uk0QT9cBkPfiEwyZHHyyYCi4Adl6gbjfOOK8jWHjcVAkkao+GCvMyA6hoQ8OQ4rEaqtaC1hW/R7fntj5LeVKe7dE9KXOiJ4p0/MpKaHsP3zXrQm4Qag1qQpCL4T4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ape0tNYu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ape0tNYu"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so2268761e87.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786063302; x=1786668102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jg9t6USd7aCBm3DCerjF5PDOcPoho7Pj+WkMHzrBY40=;
        b=Ape0tNYuKCjFJKx+9LCTzZC54swhSWC02VWN44NKQTZWWSJcfp5h0/RkFtqgN5mNF+
         igfBpqMC8fEBWtfe4oEQvSHLT5TuV0163iO0JiREJIHfB+wu/mjJh3DpQFN9WUQEkyGH
         VSQdNPJEb8NPD5PC0qjihYUyu44BmCqWXHMNUV2QBNpZ4up0QzQbx4URKEL9PC+kJWsj
         VVHS2vwcFL11zPq3Hr6E5pVryWvdn2J3pjznnuvW/GyLjbB4mqE7UhK5gD3FE2JYLcrn
         LJcIi3zuMtMlhLU51bWM7gVN9mA3n/1dy6mIRsQE3IHgnzFAzlTBgTgm5NHEqERcyWqI
         3vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063302; x=1786668102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jg9t6USd7aCBm3DCerjF5PDOcPoho7Pj+WkMHzrBY40=;
        b=H4vbf+/39t1jQew8jrKeysGMFH9y4rPnnCsEOhwFSGGIVBhckizj35BBIUgw0jaX5C
         /9BmF0XOuIIh+XFMBKZGvi5rC4sGLi6Dylgu73u4mNl85kZbmoqM1esdlQM5SBetFfBa
         AsQeL/aBxwD1V8kTSPgXYa/gRk9JmRHC2eqyNy1TzmPElcjFt1eunSbCeDv6xhkcMyPs
         Ezy7mAp+QZfrvOFIPzwgn2m2BHiHFRD2qiKpT+thodNqpk4EDQbA0NhmljGXMJe4JEx8
         BCq4AJyS3YkBh/mtasah+yVhpE2VXt+0y0z5kiFnXyFQm1G3trwCNWoSzNfyHDwaZM5q
         MKmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrd2LZbBQdYQCpmkK21Ducvqpvsmw+Q+BT4cjtQbpOQc0MSRhBCz3wUJ8F6ih1LctpPEbmV7MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYj8OLOCQPP2Is9JLKQz8PzZzIuWPmjrJ897xz0VSm2mESn7Y
	4wEubG2YPEqnB3OAE/e8sm/ObB3jEU51jnVBFGeftnaY4GCVlt7o+9M=
X-Gm-Gg: AR+sD122YWX7vG7GuDw/fpoAesuV/PWDvr5RwBXQIQ3NSTKmnGb+DkQ/bld3ab01vvo
	Vm3s424hq2nfL9bcB/g59RYnIt0wxzYDhq9+FkXbXT3is5Mws8jXIioe0bi4lOwobnmXIM1//Dc
	OVaGTSJl6KvxIWbHvQ3dry7JVoz54c/rjSozSlZeF1/ILxmqeS6M7NbgysDlviJmlcVm3augtvH
	V1uh2PTSTDPpWf/paNpsJKtImETkWNMGuBDelAKkrOB7WvOwlgyvuqFwXyt8zeM1ItNIx+gHY/o
	fycr6da7PjdmcywpT0xEenPUfsA9xePB3oLMlG99EKNgTmk+HShbRYRBlVKRB9YzCiiT5C0nodw
	f0tP5RgzRSk8Phc/wDHE7m71ItRYtvjgc+vfad3MjEG5vteMs++5l/Aca5iEH1H/TqeXkqDm256
	vj+gpPVFuu8yEGpCnwtKHFSYt17zcBYDTkF082ZFUq0sK45BVCzd4=
X-Received: by 2002:ac2:5dcf:0:b0:5ae:bb19:1864 with SMTP id 2adb3069b0e04-5b2f4b90286mr1828052e87.21.1786063301532;
        Thu, 06 Aug 2026 17:41:41 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f2b86sm189232e87.66.2026.08.06.17.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:41:41 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated list:AIROHA ETHERNET DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:AIROHA ETHERNET DRIVER),
	netdev@vger.kernel.org (open list:AIROHA ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: airoha: npu: load the firmware without the sysfs fallback
Date: Fri,  7 Aug 2026 03:41:08 +0100
Message-ID: <20260807024125.434055-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

airoha_npu_load_firmware() maps a missing firmware file to -EPROBE_DEFER
so that the NPU can be brought up once the rootfs carrying /lib/firmware
has been mounted. That mapping holds only as long as request_firmware()
reports -ENOENT.

It does not when the sysfs fallback is in play. With
CONFIG_FW_LOADER_USER_HELPER_FALLBACK set, or with the fallback armed at
runtime through /proc/sys/kernel/firmware_config/force_sysfs_fallback,
request_firmware() hands the request to a userspace helper, waits out the
full loading_timeout and returns -ETIMEDOUT. The -ENOENT test no longer
matches, dev_err_probe() turns the result into a hard failure, and the
NPU is left unbound after stalling the boot for 60 seconds:

  airoha-npu 1e900000.npu: Direct firmware load for airoha/en7581_npu_rv32.bin failed with error -2
  airoha-npu 1e900000.npu: Falling back to sysfs fallback for: airoha/en7581_npu_rv32.bin
  airoha-npu 1e900000.npu: error -ETIMEDOUT: failed to run npu firmware
  airoha-npu 1e900000.npu: probe with driver airoha-npu failed with error -110

Clearing FW_LOADER_USER_HELPER in the configuration is not a dependable
guard against this, because unrelated drivers select it. On the affected
build the symbol was turned back on by LEDS_LP55XX_COMMON, even though
the platform had explicitly disabled it.

request_firmware_direct() sets FW_OPT_NOFALLBACK_SYSFS, so a missing file
is reported as -ENOENT whatever the firmware loader is configured to do,
and the deferred probe path works as it was meant to.

Measured on a Nokia XG-040G-MD with FW_LOADER_USER_HELPER=y and
FW_LOADER_USER_HELPER_FALLBACK=y, on two images from the same tree
differing only by this patch: without it the probe fails with
-ETIMEDOUT after 64.5s and the NPU stays unbound, with it the NPU
reports its firmware version at 3.7s. The fallback is compiled in and
forced in both cases; the patch does not disable it, it only keeps the
driver from falling into it.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Cc: stable@vger.kernel.org
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed95..ca33e615a 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -202,7 +202,7 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, fw_name, dev);
+	ret = request_firmware_direct(&fw, fw_name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
-- 
2.55.0

