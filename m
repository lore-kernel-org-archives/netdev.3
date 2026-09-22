Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67315559C99
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087335; cv=none; b=baOhKiZwNpL4UCoyt6xQ+mluM5ATz2c6WxQ0eipE5rWzXeiPTnBcq7D0Ikkbu9E22C2w2wxM3gdYT7Gv/3lj7zzAzBeZvqoEPXW4ZV1K1qji2yjZjmj+5WCPLutbMqwauPGIl3QHUVIfeBSZ+4+A/GL4zvh77+ms6JnMY/vnqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087335; c=relaxed/simple;
	bh=tJr42xaDAVSaWnaqwzCH0FtQxeXXRL2IL2eoB7zaOd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2+f0LIYXV9vw0TGqKM5oFzLBu+z4Tz3v8prON1+20xSNDVotSpyUtyr5WkBD90ZkL7EHw9zYFBclaknRE2Z73omFA6NQQPPvgW5LYFXpkCVCj1S1zEpXoTiVYp+G8Z1T5FAN+7YupasflxFK0XE9kFk1urr0YNY7b60vSQQUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeT9iphd; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeT9iphd"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso4229780e87.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087331; x=1790692131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Qq4F7XD5vHunZiMcFmCR76nTufbFhGNTmnh/jlQeSI=;
        b=QeT9iphdsGBTEjSRj6o38WonfURX+A85mBtAUf0ecaPDLPD3ZRw0mVrn/2VpCs6sRY
         Ag0h12weq+0t0lPb2ltP0z1xLum4L5pzK5lQhY+CnF1PS3z5yvU7gbxD46FU4hyj3D9a
         NP509ife4ghbv0J9BsMl6ar0v7U0TCGg8guzPXHgcau46DHeigIIEcUrbZJEDuoofQYD
         NIUgvy1qbrO862avQWH+a0flHl7lSd7TBjv7sk5DVEGyxOfJjrSCXjPE+X/sgaRUFCed
         pU7gjy9ykOlRoduhTXBFHaqFPiOm6HUCFPv6/4XArDzJ7j+Y3U2S0eebuDo/I/RPlcWc
         xodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087331; x=1790692131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Qq4F7XD5vHunZiMcFmCR76nTufbFhGNTmnh/jlQeSI=;
        b=2yg4vnuNOLJhLaau/IOJC2Yfs1z0ltJKDQex3+Y8RXFYGx1MD2Ra/PyJHNtKTx7DwJ
         pY8vEzXld6Qy1WUGxBKv7HgUSyUwx0hwIyhFk1qL3QZp74vfCXTIV1sQKelaIM6TTKof
         n8KMLZKd7oL1ERxKhvgDjBs4Tpld6apDmQmTRJpCiKAi0XB9XP7U3VFksDPuGs2REXUD
         6eijD4NeMmkQqlwM+jRrFUsUfppqnOBVURZ055MdpYx4ZzlwMbGa4MTebumeFIJWgfnm
         hkuwptzNrJs8/ukAdTe8Gdt15mCSZVLmypkA20uDTzuMVdbLzQ0vy37LoebgRLUYZk9u
         s7vQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXtgH1/wvAvpqS0+QdSJlqcUmMWFoqZvYkYhbA2KfDYvet+oPJdlySgurqdhdfp8Bv9tLHVu4=@vger.kernel.org
X-Gm-Message-State: AFuF++ncWpw9v+U/7QdaXZmJEceU4g0XzYClpcBRNhMAsr2+4flKJ72s
	WTCDezBHfwqdCW5Mb62VwYK1SsKd+w3HpdtId5wfLFrdxy4qHFykmYJ0
X-Gm-Gg: AYBFou3b8NOnBh1xxOzwwQNbJCVb4wKmYWK2rxxp+bBiT+iqJ/3cvyeTS+AmwYJDWYR
	0RO/30HPNyYvL+k1mWGgU6nqCZD2E/0rVCgLRQQOpUDRFtxiGr8T/72Vuc/ZSEbu5vOcaGD+eeR
	33lLfY5Ifx4KwMJk2NXmFuin5AXNLZhZTA8Mh3mI1R+IRXcss3RhS+RwkmcpMxCLjPTiJSa+RJV
	4WcucAAIHFY/G6M31ysoa1hWWyAOyESwcgwBrjI8YdKpQSvZVbvir8cFq3PirUZFtiO7AzkoYQP
	ijlfqtL9FstkqU+nvPaLC8Ip2Z+vvJrh2LZ6EFOnl8HkYMDPawJlAysB7F2okfU0NdhnY0htiBc
	lT/Layx9mo3oCPzRj2miRUHsNBv2HRZZPXDqN3WdpIgTACEjxW023AoKSEROjLUikPwWttakrqO
	RJsmZtSNVo7DYZJR73bvxxy4wxYH7nqiZ/S+IFHiVJJwWaQJoCH4OIE5YnuszPsgkw8s+thG2rj
	ysTJcCMnEEvMQ079CKEzS1HEMJpAbcDioWwc2lZqA==
X-Received: by 2002:a05:6512:b89:b0:5b4:a836:13fd with SMTP id 2adb3069b0e04-5b8c180b471mr4899616e87.22.1790087331133;
        Tue, 22 Sep 2026 07:28:51 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d2064sm589691e87.24.2026.09.22.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:28:50 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next 7/9] ptp: ocp: drop only the USERCODE when flashing, and drop it before erasing
Date: Tue, 22 Sep 2026 17:28:27 +0300
Message-ID: <20260922142829.57740-8-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260922142829.57740-1-maimon.sagi@gmail.com>
References: <20260922142829.57740-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two problems with where adva_x1_cpld_flash() invalidated the cached CPLD
identity.

It ran after the erase *wait* returned, so an ACKed ERASE whose wait then
failed skipped it: the erase is running in the part at that point, but
cpld.id and the fw.cpld USERCODE kept describing the image that is being
destroyed, and cpld_id_tried stayed set so nothing re-read them for the
rest of the binding.  Do it before the ERASE is issued instead.

It also cleared cpld_id, which is the Lattice IDCODE - a property of the
silicon that erasing the configuration flash cannot change.  Dropping it
on a failed update only hid information that was still correct, and made
recovery depend on a re-read that may not succeed.  Leave it alone.

The documentation said the identification is read "again after a
successful CPLD update", which was never what the code did; describe what
is actually dropped and restored.  While there, note the size check and
the state the part is left in when an update fails part-way.

Fixes: a4b7c15aa78f ("ptp: ocp: add TAP CPLD flashing via devlink")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Documentation/ABI/testing/sysfs-timecard     |  8 +++---
 Documentation/networking/devlink/ptp_ocp.rst | 28 +++++++++++++-------
 drivers/ptp/ptp_ocp.c                        | 25 ++++++++++-------
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 4ba45c6ee4a3..569ab668a225 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -31,10 +31,10 @@ Description:	(RO, root only) The flags set in the status register of the
 
 		A read arbitrates for the shared I2C bus and reprograms the
 		on-card mux, so it is restricted to root.  The Lattice device
-		ID of the CPLD is read by the driver shortly after probe,
-		and again after a successful CPLD update, and reported from
-		that cached value as the fixed "cpld.id" version by
-		devlink dev info.
+		ID of the CPLD is read by the driver shortly after probe and
+		reported from that cached value as the fixed "cpld.id"
+		version by devlink dev info.  It identifies the silicon, so a
+		CPLD update does not change it.
 
 		New CPLD firmware is programmed with devlink dev flash,
 		selecting the "fw.cpld" component; see
diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
index f94b759d9cd6..249ca63eebf6 100644
--- a/Documentation/networking/devlink/ptp_ocp.rst
+++ b/Documentation/networking/devlink/ptp_ocp.rst
@@ -32,14 +32,17 @@ The ``ptp_ocp`` driver reports the following versions
        carrying that CPLD.  Reading it claims the shared I2C bus and
        reprograms the on-card mux, so the driver does that from its own
        worker and reports the cached value here; the version is omitted
-       until that read has succeeded.  The read is made once per binding
-       and again after a successful CPLD update.
+       until that read has succeeded.  The IDCODE identifies the silicon,
+       so it is not affected by a CPLD update.
    * - ``fw.cpld``
      - running
      - USERCODE of the image programmed into the TAP CPLD, formatted as
        ``0x%08x``.  Read together with ``cpld.id`` and reported the same
-       way.  This is the component name to pass to ``devlink dev flash``
-       to update the CPLD.
+       way; it is dropped when an update erases the part and reported
+       again once the new image has been read back.  This is the
+       component name to pass to ``devlink dev flash`` to update the
+       CPLD, and the name is reported even while the value is not, so a
+       part left holding a bad image can still be reflashed.
 
 Flash update
 ============
@@ -59,12 +62,17 @@ selected with the component name.
      - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
        programmed over I2C with the MachXO3 in-system programming commands
        and activated with a REFRESH, so the new image runs immediately.
-       The image is the raw configuration bitstream.  The only check the
-       driver makes is that its length is a non-zero multiple of the
-       16-byte page size, so a container such as ``.jed`` has to be
-       converted first rather than passed through - one whose length
-       happens to be a multiple of 16 would be programmed as if it were
-       a bitstream.
+       The image is the raw configuration bitstream.  The driver checks
+       only that its length is a non-zero multiple of the 16-byte page
+       size and that it is not larger than the part takes, so a container
+       such as ``.jed`` has to be converted first rather than passed
+       through - one whose length happens to be a multiple of 16 would be
+       programmed as if it were a bitstream.
+
+       The erase clears the configuration flash before the first page is
+       written, so any failure from that point on - including an abort on
+       a fatal signal - leaves the CPLD unconfigured until a valid image
+       is written.  The component stays available for that.
 
 Programming the CPLD claims the shared I2C bus for the whole cycle, so
 reads of the card's EEPROM block until it completes.  Progress is reported
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4ce86df6e196..0d6d0c02882c 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5043,6 +5043,21 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
 		goto exit_config;
 	}
 
+	/* Once the erase is issued the image is gone whatever happens next -
+	 * an ACKed ERASE runs in the part even if the wait for it fails - so
+	 * stop reporting the USERCODE before sending it rather than after
+	 * the whole sequence has succeeded.
+	 *
+	 * cpld.id is left alone: it is the Lattice IDCODE, a property of the
+	 * silicon that erasing the configuration flash cannot change, so
+	 * dropping it on a failed update only hid information that was still
+	 * correct.  Written under cpld_lock, which adva_x1_cpld_read_id()
+	 * also holds across its own bookkeeping.
+	 */
+	WRITE_ONCE(bp->cpld_usercode_ok, false);
+	WRITE_ONCE(bp->cpld_id_tried, false);
+	bp->cpld_id_attempts = 0;
+
 	devlink_flash_update_status_notify(devlink, "Erasing",
 					   ADVA_CPLD_COMPONENT, 0, 0);
 	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
@@ -5051,16 +5066,6 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
 	if (err)
 		goto exit_config;
 
-	/* The old image is gone from here on, so stop reporting its
-	 * identity even if the rest of the sequence fails.  Written under
-	 * cpld_lock, which adva_x1_cpld_read_id() also holds across its own
-	 * bookkeeping, so the worker cannot resurrect any of it.
-	 */
-	WRITE_ONCE(bp->cpld_id, 0);
-	WRITE_ONCE(bp->cpld_usercode_ok, false);
-	WRITE_ONCE(bp->cpld_id_tried, false);
-	bp->cpld_id_attempts = 0;
-
 	err = adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR);
 	if (err)
 		goto exit_config;
-- 
2.47.0

