Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D7338936
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456647; cv=none; b=ShkQl+51yyB557QzY6hBuzsfjndYDHP0ZSV5Xi0XmiD90akkKP6mhlfJhv2XSmuOckWgUNO06X6xAvVSgbFmQK6IatqNgfMiPJs557kKX8fHPLFmQAFpff9j4IA8fwDtb4SrmYD6L0/lFP80Znh4w1y5rOoeGVHRIuzsl6tjUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456647; c=relaxed/simple;
	bh=h6vWeDEGOjjGH3o0m1xIdoZGF0A/FBWD6mHvcTvOxwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLZ35aM1Nfr8W9qxlM/GLsq/gZOMSI5vAnI4SSSYTdSFQcVc84f6+f6mNz5in/J4YJmhiYypPygE20k18cDm14QQ2QrsNsScuxo4NPDdPJDHaaKQkBEkPhjv/ISuj6hn4ZtEssSxfAf712+RvXJnpCaK6rdXh+IRPprvmrlEQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsJS56E7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsJS56E7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495590dde14so12580055e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786456643; x=1787061443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59fOkSeentgYghePxXH4AyN2xsYGYkot1z1ezyk8r3w=;
        b=UsJS56E7jTSRwuhK59GR+Dyax+IVV+xzazNNxyjolN1OT+nVJa3ZTs7L7lvi3rvxI6
         CKTLUcAczYCmgaXGfF8000oYUghv5ek6e6hZar+gk0BOu4F8WFJkrOlq1O6K3gxT3j2F
         8LnsWuNIj8ncyvZPe2Kd9Hx6RT3eeVZq11pcypuYcVBjjy5yWkD9YueNs/hNCa1NfM7x
         p/ZPU6AXHbLHBq7qML2eyEyuA6PSkai9ZMwH+F+/WPWf1UwwzOFOIXeerjVmmzVQADYE
         pNukDb97wYjIhCT1ggN4LwfJ4/f3r+5axOY5Pzsvhcb1Z6hqF31ipmoAkHOmClF9s5U4
         322g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456643; x=1787061443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59fOkSeentgYghePxXH4AyN2xsYGYkot1z1ezyk8r3w=;
        b=VXQ9FxZeHfX3PSzI/fqBM3F5ORbi2Rto/9eu8wST7XVZLZSIbKRraomMCvCO/h9bWJ
         X/EY0yFrquJstPeMLZDVwm8D6X6uX6PbmqsQmwq0qzh0YWCk87KCyM3JpaqYRiZuaMpg
         rV6UWQgx6FvSQpYrtEpILk2Jht16mInIbtqYUygNyWTsGsP+Gfd+ZQHGZVDXHibpKhNF
         YAeY+Wy4EjJjkaLEhFRjWlM3At/QvGF8ADrjGzXuttEB7fEfPA1nrCZ6UCL7y04zw7AS
         l3elIFjeac5+7h4kuA7FabdCYUxt5wEhjTDpUo3K8Twxz2caXHTIwwua6OXkeqVkQwtO
         2syQ==
X-Gm-Message-State: AOJu0Ywvqz/szN/rW590fV6xCJwPDti9H6dRHlX3bKGgrQ7tWI3oxgVN
	Sf+dO6C9yQtD4QDNHfqQbVB0m3gq3v7Z0iedWdFtII2rL3qKNJ9J/uxkXkiCZzn/
X-Gm-Gg: AR+sD10+bSgIh+bjT9xgKt/nqiHMg7XVoVHt/mGIARBOxVcY9+5hj40uDNelia681y4
	3IEtd9CeVet5cc3nKR42Z0X198nmtqpo/yfq75ZgOR3J67e5te3Sjy3rLh2dO4HfnZTE71fG4Vd
	OZQaLH/nAapFywCogRepOCt9dj6OaPgdPI/R93FYAE90BPRBU6wmZrSSyBl96russU0klCYhn3H
	Hqgx1sn8h/piz2sLLEdQ6uvtKbS7virM3QtQW5a82AYxVdq7Vo9Ilv3JVyslNwndtkL1Od3yuwH
	9K2IjFZXcuPE0KHKvaAvd/2/3Wfdn9664UMW0GCnTEMgfL64m8/YC6FAWWOU5qh4TfJ4AncF9VC
	6BYHa8geodqzXaPeefjC9Tb5IG9I7n5AHFKu8mvT7Dn2dSFilLqhQNS4CaZhlxJB+rRmkgUP5rT
	ImrkEk5msHmpxomMsbWnwsiJ5ROV+wfTk/fqJRTGDmbCjOui3wnlW0vyobRbCtG1dgJVC/7ksPl
	wWvP2z6J/wH8NtRKFh7B8S+Yso29Z+9no0y
X-Received: by 2002:a05:600c:470d:b0:499:7a86:4145 with SMTP id 5b1f17b1804b1-4997a864166mr708845e9.13.1786456642791;
        Tue, 11 Aug 2026 06:57:22 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788a6cdfsm34095085e9.6.2026.08.11.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:57:22 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v11 0/2] ptp: ocp: add TAP CPLD support for ADVA TimeCard X1
Date: Tue, 11 Aug 2026 16:57:18 +0300
Message-ID: <20260811135720.109580-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X1 (PCI device 0x0410) carries a Lattice MachXO3 CPLD
on the TMC I2C bus.  This series adds access to it and an update path
through the kernel firmware-upload subsystem.

The card has two I2C controllers.  Linux registers only the one at
0x00150000, normally routed to the config EEPROMs; the one at 0x00120000
belongs to the on-card MicroBlaze and is routed to the TMC or M.2 bus as
its firmware selects.  A request/grant handshake re-routes the host
controller onto the TMC bus, where the PCA9548 and the CPLD behind its
channel 0 live.  Everything here is built on that handshake.

Patch 1 adds the arbitration and the read-only interfaces on top of it.
Patch 2 adds the flashing, as requested in review.

v10:    https://lore.kernel.org/all/20260805083154.3821-1-maimon.sagi@gmail.com/
Review: https://lore.kernel.org/all/20260810230735.955188-2-kuba@kernel.org/

One review point did not become a code change, so to answer it here: the
CPLD paths leaving the PCA9548 with all channels deselected is harmless.
The mux sits on the TMC bus, which the EEPROM paths never see - by the
time the grant is dropped and the host controller is back on the EEPROM
segment, the mux is not reachable from that adapter at all.  Deselect-all
is also the PCA9548 power-on state, so the MicroBlaze finds it exactly as
it would after a cold boot.  v11 documents this above the CPLD helpers
rather than leaving it to be re-derived.

Changes since v10:

 - Split into two patches, separating the firmware flashing from the
   bus access and the read-only interfaces (Jakub).
 - Report the Lattice device ID as the fixed devlink version "cpld.id"
   and drop the cpld_device_id sysfs attribute (Jakub).  The value is
   cached, so the bus arbitration is paid once per card.
 - Hold the i2c core adapter lock across the whole grant window and use
   __i2c_transfer(); while the host controller is routed onto the TMC
   bus the EEPROMs are not behind that adapter at all, so an unarbitrated
   transfer from ptp_ocp_read_eeprom(), the nvmem attributes or the at24
   sysfs files would be issued onto the wrong bus.
 - Register the firmware-upload node per card as adva-cpld.N; the fixed
   name made the second X1 board in a host fail with -EEXIST.
 - Unregister the upload first on detach, so an in-flight programming
   cycle is cancelled and flushed while the I2C controller is still up.
 - Restrict cpld_status to 0400 and take cpld_lock interruptibly, so a
   reader cannot sit unkillable for the length of an upload or stall
   device removal.
 - Fix adva_x1_cpld_wait_ready(): it polled floor(max_ms / 100) times and
   never re-read after the last sleep, so the 100 ms per-page budget
   allowed exactly one poll.  Use read_poll_timeout() with a wall-clock
   deadline that also accounts for the I2C transactions.
 - Cancellation: keep a request that arrives before prepare() runs,
   annotate the flag with READ_ONCE/WRITE_ONCE, honour it inside the long
   waits, and report it as CANCELED rather than HW_ERROR.
 - Set cpld_in_config_mode before EN_CFG_TP and clear it once REFRESH is
   accepted, so DIS_CFG is neither skipped after a failed wait nor sent
   to a device that already rebooted.
 - Retry the post-REFRESH mux reselect; its return was discarded, so a
   NAK failed an update whose image was already running.
 - Drop I2C_M_NOSTART: two messages in one transfer already give the
   repeated-START read the ISC protocol needs, and the flag asks for the
   opposite on adapters that honour it.
 - Withdraw the MicroBlaze request when the grant times out, and drop the
   -EBUSY check that only ever read back its own write.
 - select FW_LOADER and FW_UPLOAD; without them the documented update
   path does not exist.
 - Correct the IDCODE to 0x612bc043 and the part to LCMXO3LF-2100.
 - Add lockdep_assert_held() to the callbacks and context annotations for
   the lock handed from prepare() to cleanup().

Sagi Maimon (2):
  ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
  ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1

 Documentation/ABI/testing/sysfs-timecard |  24 +
 drivers/ptp/Kconfig                      |   2 +
 drivers/ptp/ptp_ocp.c                    | 655 ++++++++++++++++++++++-
 3 files changed, 677 insertions(+), 4 deletions(-)

-- 
2.47.0

