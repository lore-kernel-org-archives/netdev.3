Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6338D41A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496229; cv=none; b=Ictq0t5Np+UtF3u9KSl1SNb+DbgxvEFaFN+zjgAhO4sl1YHqsK2ZrV3r7ADS/p8P+/oXEMWn7m05+lo3OxMY8Yr3BPjBq1626p02v0p4+RTCdh6AVtjWMiDcH0qTOFzW/q15XSqmRZAwzxls9lwtDfiNLHyjGd51m1M9EVlG72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496229; c=relaxed/simple;
	bh=7wIchqJjqnZHU6zZklYjcC9749i2ckkkW5M5ZGAikUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuWbbWTMLdQFqexX3r1qsVvcZnR6YSYvjbRZQmzRADAD9AP56QpJFzRIEYJsmjxKeIMSKKy2wiudNqm6Lfgd9DojLuafRvcbM2xRo6LrbSDANRjTQOJnb+0WMLbTSxAKVrMd2qmnXB4L7bUpC7qZl/W+CM+/hw4Spy4tAbaBtq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lzkNmji5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lzkNmji5"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4D74F3F9AA
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785496223;
	bh=4xuZy+bD9YFEySP2zBIxC9MmUHpF2JB8x5I5Hqjd5x8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=lzkNmji5ivMaTBEiLV60/riGMmZpS0Q4lSCg5oHAz15nASnQZqpbcCJ/9TreaYPk0
	 5JxlJWixWIwu+M0A5hNycEt4BMxK9shf0wc8EQsKG49JZXylf1CDlleOPekwTXvWBh
	 B+Zx1Je7a5zF2+gExRSFlW04nCNgUZsMj051uqBZaKCISRlMUinlI9CE39IG3p+CU7
	 3te7WeqqPypUiUxgvmuooTIf6hrJTqnokd6FrG0h4fLCll4ki6yCW7lbM6/pFK88pE
	 DMstHzh4PsCgPS6EV/dRcPZEMJW/dmQHZD6PT7EhFPALuNuGoBkGtRt1DMynsPUS2m
	 8rXQkytXh22KmS03LJ1dP+zNeICnCafHfanuATvP4HBrbqMtFg38Xb9iUN+Y2yPG54
	 r8iY9dSdiLPM5eBhjmSN0hlTH2HZ8J61UTIGFWWLFMXgv0fnrAnNHuJDL42hSniVCG
	 Ujd0hsuTDpsFk6zK2obBWUmmS4h4xGdIvCjl/yrhSdZrWPsUU2tcUPQpgQQpCOv/0H
	 isMO/D0NStoPRi6Q7fQwggCTQomrfnTIT5pDAhDRt8N4PUs2S4cS6BwttzDET8IP6J
	 pwPZFm+EIvGNR2O7MmKPq3tcskucMWaO3NvHYTXiwaN7YZh9FLJ2NLq2y0Kz8yiyc6
	 fOFaUk51k/8qhEUjJA8SGUU0=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f8580ed9eso1008352f8f.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 04:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785496223; x=1786101023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4xuZy+bD9YFEySP2zBIxC9MmUHpF2JB8x5I5Hqjd5x8=;
        b=LsCjCz36zzYly9Trd2XkCFKGgGvRRJPqK0LziX9Jz7pD7dw+53+X10R59XjmG5bDkC
         LgAD2lk6qNKFGZKJ0Zuebojd2uCre5EaffekiM2evlDONcfj8NVFTSGh6XrLE8YjjqFF
         8rirgtG8gkLw8afRrGE+2SwPfN6qmCa5C/45FRrnu+MTq+sLQLq3s7gYrw6WfWHRPmeP
         MZ8IiXwx6UfOyBlZksPmQm5dFcjVwJ0dYTP4psRIfYzlJIIbXGTAmRgs0VLPzsiENB9T
         NSDRSIZa/vPWaBVVvi4MDrECfHdW4r2SqDuY80+7AFa3QNPaaUWEhHnn/VfnPuygXSL+
         Z4mQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq572IaZY2bN/r8Pas2mwF1oAX+eXivFD5OZtUNEmNXfrdWaJIx8k//LWeT3P7bGo5KnyCZyxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLn1I3IpFFUQYJHfJ82bfibSj6zXRikkb2MNhctVQFOYcktOV
	AZ3crKJLC/zpUn96VIGDtfevSl75V+krA+Oj5Kb8GoKXEIb3xp79vlTujqnmbYihrKGP8WA0wsu
	/WHxoJZa6MLO+GlP+UfLsFoTnGJpNJlXYMnFZ29+vseFHWK5bd8X+PPFfOw5F/akikDnMK4fhiH
	vWqPkEJIFG
X-Gm-Gg: AR+sD12ipadiLpSftrcazkaKby2NXESw/NH5MSodajs8e/ZWJkpSCaoLwmcEWEq7b4Z
	qe6VyveXBRDTUmDZuKrUZe8xbpQH1HXdg3s/Wb6bFgGty2sBxylaFkmu6fiYU/5YS1Z7A7tZxd6
	9zA7Pf3GW9v0XZmUb6DrGNtzlYn0SEIukt8/3B2fkCr+2/N0KkKNq+9KkqzOsps57QcwIkZJ3y5
	JTk/Qo5n5mmdASH5XDu5ewIoE5A7OX1Z4eSf0/jeydwseKoNvLr9FJPw8rJ7ftKzJqF5u5uRi4y
	K32ye7TF0e3Hi7/Ut2Ma0Qc7lw3NBqbGiDwoErFbccTNp2AaC7uYHrsX+aUrVVUB/kPO663LvHY
	KqnGaRK18R83kLmsYEOvCY7TowlkZk4cnpgg9ut7/lLmf2Q==
X-Received: by 2002:a05:6000:22c9:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-47fd2ac1d82mr3797755f8f.1.1785496222693;
        Fri, 31 Jul 2026 04:10:22 -0700 (PDT)
X-Received: by 2002:a05:6000:22c9:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-47fd2ac1d82mr3797666f8f.1.1785496222174;
        Fri, 31 Jul 2026 04:10:22 -0700 (PDT)
Received: from localhost.localdomain (77-236-28-43.static.play.pl. [77.236.28.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm3469836f8f.36.2026.07.31.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:10:20 -0700 (PDT)
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
Subject: [PATCH iwl v3] ice: acquire NVM lock around each flash read
Date: Fri, 31 Jul 2026 13:10:07 +0200
Message-Id: <20260731111008.1266444-1-robert.malz@canonical.com>
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
dropped.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
v3:
- Log the failure via ice_debug() when ice_acquire_nvm() fails inside
  ice_read_flat_nvm(), rather than silently aborting the read.
v2:
- Replace the save/restore of sq_last_status across ice_release_nvm(),
  which could race with a concurrent AdminQ command, with a new optional
  read_aq_err output parameter.
- Add missing "Return:" kdoc to ice_read_sr_word().
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 79 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
 4 files changed, 59 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 22b7d8e6bd9e..5a1ab9654fb8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_hw *hw = &pf->hw;
 	bool read_shadow_ram;
 	u8 *nvm_data, *tmp, i;
@@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 	for (i = 0; i < num_blks; i++) {
 		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
 
-		status = ice_acquire_nvm(hw, ICE_RES_READ);
-		if (status) {
-			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-				status, hw->adminq.sq_last_status);
-			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-			vfree(nvm_data);
-			return -EIO;
-		}
-
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
@@ -1945,6 +1936,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_hw *hw = &pf->hw;
 	bool read_shadow_ram;
 	u64 nvm_size;
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
index 49371b065845..ce5f5fbaea69 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -854,6 +854,7 @@ ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	       u8 *bytes)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	int ret;
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
index 7e187a804dfa..587fa2518e7e 100644
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
@@ -194,7 +222,7 @@ static int ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
 	 * Shadow RAM sector restrictions necessary when reading from the NVM.
 	 */
 	status = ice_read_flat_nvm(hw, offset * sizeof(u16), &bytes,
-				   (__force u8 *)&data_local, true);
+				   (__force u8 *)&data_local, true, NULL);
 	if (status)
 		return status;
 
@@ -330,13 +358,8 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
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
@@ -419,24 +442,21 @@ ice_read_netlist_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset
 }
 
 /**
- * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
+ * ice_read_sr_word - Reads Shadow RAM word
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
- * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
+ * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq.
+ *
+ * The NVM lock is acquired and released internally by ice_read_flat_nvm()
+ * around the FW read, so this function must be called without the lock held.
+ *
+ * Return: zero on success, or a negative error code on failure.
  */
 int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 {
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (!status) {
-		status = ice_read_sr_word_aq(hw, offset, data);
-		ice_release_nvm(hw);
-	}
-
-	return status;
+	return ice_read_sr_word_aq(hw, offset, data);
 }
 
 /**
@@ -856,20 +876,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
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
 		u32 offset = (max_size + min_size) / 2;
+		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;
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
@@ -880,7 +898,7 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 			min_size = offset;
 		} else {
 			/* an unexpected error occurred */
-			goto err_read_flat_nvm;
+			return status;
 		}
 	}
 
@@ -888,9 +906,6 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 
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

