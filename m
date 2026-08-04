Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DF3E715E
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832549; cv=none; b=gYJHi2B7WhxfSgYqlpH5vwY4Eo9sYbnGFL/KjSRMCQZ7BuwOEpHvehCaKQmN1J3N+YKtVZJP+6IglwmR3GIa3M6jAdK8REGCx5X8v46ENwGk5aSY90wW1G5oaYeiz9RiLOqOgqyOOEc53gFfFaEM/4kpzRlpJlqnJSoQ1wz+NFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832549; c=relaxed/simple;
	bh=Ef+6+ghJPfzjnygqfI736xG8JIentu2vWdpO6rH3VTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMLfiRgCQnrexoQSkO6fdr/2EdAxUBaCECcbdns3jtXD/Vnnd/O0mFdtxJcMS8whC2F5xWOdOJb5ycRCrSVju/uNW2cMPO2n5IdJ/xV6/rbBgCqmk/gi3XKmwS40LqdF8nWITuJMdg8AeECm+GSHtMv6p57hcTP4nLSYGDNDa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=RxnJN9gu; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="RxnJN9gu"
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 69D123FBBA
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785832542;
	bh=EwWoMFmkHrUBoojEnGvrGh+7TlMjWGGUnHH4vpXCfXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=RxnJN9gu4Gzypp3bcQFClKvwwVz8DX0o6qSl4RMrnl7udJ+DPyTAuhuj3oRdFT9rT
	 30TTlxfivk/CQpQBKlUpUMMB47/39zv0roaSlcfHQ+5Q94om6fn+Uu/p7IESIv1J+w
	 KSW2GOxsNnGc7Pvxzq5OVfH2UbsdzGzg3cVoc6KQNGGQPmTZ2ddNuOSHCwxv+P3Gt8
	 PPYRvbUDUpYXG3hHHzAy1FMQ2AyCXmF3gIJ1pCeKbYaglWpNTaWVJYraedA1KPFkRA
	 HAksoawRRS2Xoue6swiZ7l8PP8jyE0U8G+iebyaS/f7vUnKL8N+9PmNyiknXhZS9Jd
	 NYUwG/T3r58OVGabrRv7kCzrWoWhCxnROO/1jzxmZYvTGde5XhspRsauuCdOaG0PjG
	 WPCJvbBSuxp2iWLrsUUeK9P2MszxMTTPrtETKLPLoBxOE/eIPEHlIYXfJmXM3QPT8L
	 6wnPv4jbrNpyNHYsUYuttgSf29MoBNnOdVA2oGhb2sLNlfy7kBbRS6jpNi8jK2gMiW
	 na2hFBeL2HLjl87MoO4oAYOHKrhv3LcCiTPP6PwcqiI70w6+mf40dttsK00yK+aVOz
	 0GRZ3UKttTxGGPX3/SauOH3UTxc0I1vjgzvS+L+jrvC6tV7G7zXOdgMufusPFtDanb
	 tdcZ/XPLCNcKS4wKO2RDiFf4=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495529a93f9so31710345e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832542; x=1786437342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwWoMFmkHrUBoojEnGvrGh+7TlMjWGGUnHH4vpXCfXI=;
        b=KQ89CENUAuWXT6/74Qk1bSdYAQxDKcOymul2oJr2MUDqLlWFXIbNTjOM01wOrKkDlu
         n0RuvTN3p8RzbgOA0tg++XozRx6JU07/qO+qLfc9pNoCHL/SQBn2kBQkohSCS9Z/c1PU
         ImMfQlqfuBTpxvqRPoWFDBvA9LcMy8PVYHW3qdNGAKN3uQjmc0l6/WwVMakP3X9l3VOr
         dpraf7mnkjZ+DjD8K8Qarw7I2DYoD7iBop0QgAZq1l9H+LPgfNlOoL93Mjid7OEEAc9x
         TfvUuGkr1QLeI26j6FR08tLchoaWgaoAn9HoRk8vPLABYockIpGz6jB8W6jJ6ZVZfdcU
         sVKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4ep7j244qraz9YbZkW+9eG+UWpIF9JnqcMf0F4y3XMrj2X64A6KkGeMrT3WY5vArVV9BwsXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MYnS+YmE4p755PeaeA0ck2XAYcsx/4Pgbg2q20aYlOAwT95U
	wdHNt/ehGD+chcRPl4xF+4bLlrkvm2oPvFiFJvINoLuwLZhFnQ6zf/pY8zRSd+4NjoP8W+ouAC7
	x+IxfDQkZliOK0qnHR/n0Cf3fR9Gw7GZ7diAmqSZlDNmcHaq/x6gat16ls01445fyGVIUbYWB8Q
	==
X-Gm-Gg: AR+sD10EjyaBFwUNSCnoXPGEm2zjOZqptKlZUZw/x5GBYDYcI3EwV4QN7UdUdEuhXsO
	FXXae6sU6RG6oiuVJIGYGK+nBJSHQ/Xy58jik5roTD9nP4pGh1P5M8u5H11hNaJ6Q97OW8lbmQu
	SMcJ3xDjuyM/AG1Q8BSG/b4wrT2rSd4eNp3AhHtF4upoT9XkIy9EpFArl77vAu9/V0r9138dupV
	EvJW8m5nB47lOAoT008zdDBs5YcGN33bAwPDrOEwIosacAuWym7VoT06Sb3vkYUuS70gM52b0LQ
	L8rkZyJlBdaGlE9QHvMLs7iGWHQu2CvEzVCbvzFClN4WeK+wWXTzCoy0REO5nHYYUGd901hPNkM
	umYgJ3wUKilVyA9WuQI67Ss+0PTQ=
X-Received: by 2002:a05:600c:35c1:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499484a820emr119807895e9.9.1785832541778;
        Tue, 04 Aug 2026 01:35:41 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499484a820emr119806935e9.9.1785832541293;
        Tue, 04 Aug 2026 01:35:41 -0700 (PDT)
Received: from rmalz.. (77-236-28-43.static.play.pl. [77.236.28.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd4c33sm61377825e9.8.2026.08.04.01.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:35:40 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Robert Malz <robert.malz@canonical.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl v4] ice: acquire NVM lock around each flash read
Date: Tue,  4 Aug 2026 10:35:36 +0200
Message-Id: <20260804083537.3997889-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
single lock taken by the caller. Reading a large region can exceed 3000ms,
so FW reclaims the lock mid-read and the remaining commands might fail.

Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
individual ice_aq_read_nvm() command, ensuring the lock is never held
across more than one FW read.

ice_release_nvm() issues its own AQ command and overwrites
hw->adminq.sq_last_status, which some callers inspect after a failed read.
Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
capture the failing read's AQ error before the release; callers that need
it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
instead of sq_last_status, others pass NULL.

Callers that previously took the lock around ice_read_flat_nvm(),
ice_read_sr_word() or ice_read_flash_module() now call them without it.
The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
dropped. ice_read_sr_word() is now a thin wrapper, so ice_read_sr_word_aq()
is folded into it.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
v4:
- Fold ice_read_sr_word_aq() into ice_read_sr_word() now that the latter is
  only a wrapper.
- Reduce the scope of read_aq_err in ice_devlink_nvm_snapshot() to the read
  loop.
- Fix reverse christmas tree ordering of the added read_aq_err declarations.
v3:
- Log the failure via ice_debug() when ice_acquire_nvm() fails inside
  ice_read_flat_nvm(), rather than silently aborting the read.
v2:
- Replace the save/restore of sq_last_status across ice_release_nvm(),
  which could race with a concurrent AdminQ command, with a new optional
  read_aq_err output parameter.
- Add missing "Return:" kdoc to ice_read_sr_word().
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 90 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
 4 files changed, 58 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 22b7d8e6bd9e..8c2b63eef82b 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1890,27 +1890,18 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 	 */
 	for (i = 0; i < num_blks; i++) {
 		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
-
-		status = ice_acquire_nvm(hw, ICE_RES_READ);
-		if (status) {
-			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-				status, hw->adminq.sq_last_status);
-			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-			vfree(nvm_data);
-			return -EIO;
-		}
+		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 
 		status = ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK_SIZE,
-					   &read_sz, tmp, read_shadow_ram);
+					   &read_sz, tmp, read_shadow_ram,
+					   &read_aq_err);
 		if (status) {
 			dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
-				read_sz, status, hw->adminq.sq_last_status);
+				read_sz, status, read_aq_err);
 			NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
-			ice_release_nvm(hw);
 			vfree(nvm_data);
 			return -EIO;
 		}
-		ice_release_nvm(hw);
 
 		tmp += read_sz;
 		left -= read_sz;
@@ -1943,6 +1934,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 				struct netlink_ext_ack *extack,
 				u64 offset, u32 size, u8 *data)
 {
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
@@ -1966,24 +1958,14 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 		return -ERANGE;
 	}
 
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status) {
-		dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-			status, hw->adminq.sq_last_status);
-		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-		return -EIO;
-	}
-
 	status = ice_read_flat_nvm(hw, (u32)offset, &size, data,
-				   read_shadow_ram);
+				   read_shadow_ram, &read_aq_err);
 	if (status) {
 		dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
-			size, status, hw->adminq.sq_last_status);
+			size, status, read_aq_err);
 		NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
-		ice_release_nvm(hw);
 		return -EIO;
 	}
-	ice_release_nvm(hw);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49371b065845..d3cc6fef6a09 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -853,6 +853,7 @@ static int
 ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	       u8 *bytes)
 {
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
@@ -869,24 +870,15 @@ ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (ret) {
-		dev_err(dev, "ice_acquire_nvm failed, err %d aq_err %s\n",
-			ret, libie_aq_str(hw->adminq.sq_last_status));
-		goto out;
-	}
-
 	ret = ice_read_flat_nvm(hw, eeprom->offset, &eeprom->len, buf,
-				false);
+				false, &read_aq_err);
 	if (ret) {
 		dev_err(dev, "ice_read_flat_nvm failed, err %d aq_err %s\n",
-			ret, libie_aq_str(hw->adminq.sq_last_status));
-		goto release;
+			ret, libie_aq_str(read_aq_err));
+		goto out;
 	}
 
 	memcpy(bytes, buf, eeprom->len);
-release:
-	ice_release_nvm(hw);
 out:
 	kfree(buf);
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..21f3b615dbbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -53,17 +53,27 @@ int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
  * @length: (in) number of bytes to read; (out) number of bytes actually read
  * @data: buffer to return data in (sized to fit the specified length)
  * @read_shadow_ram: if true, read from shadow RAM instead of NVM
+ * @read_aq_err: if non-NULL, receives the AQ error status of the failing read
  *
  * Reads a portion of the NVM, as a flat memory space. This function correctly
  * breaks read requests across Shadow RAM sectors and ensures that no single
  * read request exceeds the maximum 4KB read for a single AdminQ command.
  *
+ * FW caps the read lock at a maximum of 3000ms, so a read spanning multiple
+ * 4KB sectors cannot be done under a single lock without FW reclaiming it
+ * mid-read. The NVM lock is therefore acquired and released around each AQ
+ * read, so this function must be called without the lock held.
+ *
+ * Since ice_release_nvm() issues an AQ command that overwrites
+ * hw->adminq.sq_last_status, callers that need the failing read's AQ error
+ * must use @read_aq_err rather than inspecting sq_last_status afterwards.
+ *
  * Returns a status code on failure. Note that the data pointer may be
  * partially updated if some reads succeed before a failure.
  */
 int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
-		  bool read_shadow_ram)
+		  bool read_shadow_ram, enum libie_aq_err *read_aq_err)
 {
 	u32 inlen = *length;
 	u32 bytes_read = 0;
@@ -92,12 +102,30 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 
 		last_cmd = !(bytes_read + read_size < inlen);
 
+		status = ice_acquire_nvm(hw, ICE_RES_READ);
+		if (status) {
+			ice_debug(hw, ICE_DBG_NVM, "Failed to acquire NVM lock, err %d aq_err %s\n",
+				  status, libie_aq_str(hw->adminq.sq_last_status));
+			break;
+		}
+
 		status = ice_aq_read_nvm(hw, ICE_AQC_NVM_START_POINT,
 					 offset, read_size,
 					 data + bytes_read, last_cmd,
 					 read_shadow_ram, NULL);
-		if (status)
+		if (status) {
+			/* Capture the read's AQ error before ice_release_nvm()
+			 * issues its own AQ command and overwrites
+			 * sq_last_status.
+			 */
+			if (read_aq_err)
+				*read_aq_err = hw->adminq.sq_last_status;
+
+			ice_release_nvm(hw);
 			break;
+		}
+
+		ice_release_nvm(hw);
 
 		bytes_read += read_size;
 		offset += read_size;
@@ -177,14 +205,19 @@ int ice_aq_erase_nvm(struct ice_hw *hw, u16 module_typeid, struct ice_sq_cd *cd)
 }
 
 /**
- * ice_read_sr_word_aq - Reads Shadow RAM via AQ
+ * ice_read_sr_word - Reads Shadow RAM word
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
  * Reads one 16 bit word from the Shadow RAM using ice_read_flat_nvm.
+ *
+ * The NVM lock is acquired and released internally by ice_read_flat_nvm()
+ * around the FW read, so this function must be called without the lock held.
+ *
+ * Return: zero on success, or a negative error code on failure.
  */
-static int ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
+int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 {
 	u32 bytes = sizeof(u16);
 	__le16 data_local;
@@ -194,7 +227,7 @@ static int ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
 	 * Shadow RAM sector restrictions necessary when reading from the NVM.
 	 */
 	status = ice_read_flat_nvm(hw, offset * sizeof(u16), &bytes,
-				   (__force u8 *)&data_local, true);
+				   (__force u8 *)&data_local, true, NULL);
 	if (status)
 		return status;
 
@@ -330,13 +363,8 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 		return -EINVAL;
 	}
 
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status)
-		return status;
-
-	status = ice_read_flat_nvm(hw, start + offset, &length, data, false);
-
-	ice_release_nvm(hw);
+	status = ice_read_flat_nvm(hw, start + offset, &length, data, false,
+				   NULL);
 
 	return status;
 }
@@ -418,27 +446,6 @@ ice_read_netlist_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset
 	return status;
 }
 
-/**
- * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
- * @hw: pointer to the HW structure
- * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
- * @data: word read from the Shadow RAM
- *
- * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
- */
-int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
-{
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (!status) {
-		status = ice_read_sr_word_aq(hw, offset, data);
-		ice_release_nvm(hw);
-	}
-
-	return status;
-}
-
 /**
  * ice_get_pfa_module_tlv - Reads sub module TLV from NVM PFA
  * @hw: pointer to hardware structure
@@ -856,20 +863,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
 static int ice_discover_flash_size(struct ice_hw *hw)
 {
 	u32 min_size = 0, max_size = ICE_AQC_NVM_MAX_OFFSET + 1;
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status)
-		return status;
+	int status = 0;
 
 	while ((max_size - min_size) > 1) {
+		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 		u32 offset = (max_size + min_size) / 2;
 		u32 len = 1;
 		u8 data;
 
-		status = ice_read_flat_nvm(hw, offset, &len, &data, false);
+		status = ice_read_flat_nvm(hw, offset, &len, &data, false,
+					   &read_aq_err);
 		if (status == -EIO &&
-		    hw->adminq.sq_last_status == LIBIE_AQ_RC_EINVAL) {
+		    read_aq_err == LIBIE_AQ_RC_EINVAL) {
 			ice_debug(hw, ICE_DBG_NVM, "%s: New upper bound of %u bytes\n",
 				  __func__, offset);
 			status = 0;
@@ -880,7 +885,7 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 			min_size = offset;
 		} else {
 			/* an unexpected error occurred */
-			goto err_read_flat_nvm;
+			return status;
 		}
 	}
 
@@ -888,9 +893,6 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 
 	hw->flash.flash_size = max_size;
 
-err_read_flat_nvm:
-	ice_release_nvm(hw);
-
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index 63cdc6bdac58..e1d1a11f5ca4 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -19,7 +19,7 @@ int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
 		    bool read_shadow_ram, struct ice_sq_cd *cd);
 int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
-		  bool read_shadow_ram);
+		  bool read_shadow_ram, enum libie_aq_err *read_aq_err);
 int
 ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		       u16 module_type);
-- 
2.34.1

