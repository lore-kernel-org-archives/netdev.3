Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F532AABD;
	Wed, 25 Mar 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451520; cv=none; b=tdOYliaRZvzgTlF91x1PYEhodyklsULBXKjgC6caCKgoBN7IOPyxPpgi5CgSGe1FSq1SrDPUgGRiBkqLoAl/qVs3m4+EQ7wm3nG9FGreCGofK5QG8GR97zIdo7p4aFTcrX9AInzGs95akP1WmWOBBKRzYwVeVcnuVk1Gt8IkGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451520; c=relaxed/simple;
	bh=AE2guXMBp5DQPNbyJ1WdoFUb172juDOs9bZKDoSilTQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=DYW8gmd9tHuqS9NLpOi4MUVx5urBgpVokQa+Pdi4NfuFgkQPdXdHBi8I2agczaDU+0RIc3nyUhOzYAAVwMRW1XnNoptAeowllwow4O0NFqgrTqpQHNLi0QXT7lhrJrEspab+MARr5jxKZGk9YfxwViLUtTfNnNAAqQ+gFPfH17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=EXaqtQB8; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="EXaqtQB8"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1774451514; h=from:subject:to:date:message-id;
	bh=AE2guXMBp5DQPNbyJ1WdoFUb172juDOs9bZKDoSilTQ=;
	b=EXaqtQB8KUspwu79iQIwBlh7uPDjwVNXL27lIYm1NdEKxdsJNzPjIToBnw9JESsy7HSIAO5HumS
	FpYEIVrVHHuRKJ2dp5c6JHN0Zi4YzCo7XqfK8FbkN2JKx98VqId1tKgbV8WXNhuf9+U3EG4+LI1+i
	yNsfeym+UQYduB57J7lksJltmgV86fSXZ3ek8PLtZQ1LL8I2Z0Rs+pSq8FABwl09FMPoKy0RWUMOL
	n7ziIINxNWFSSHXGnCsqjG0iWnPzIqiUwpwds3EIf/vePzmlQwn4Rhoau0C5u9Bjh8goNdgLQjE8L
	3HN0Cyzm0aAwbKPuqHzG3eBNGJmJgwt5ZYPw==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 25 Mar
 2026 18:11:54 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net v2] e1000: check return value of e1000_read_eeprom
Date: Wed, 25 Mar 2026 18:02:20 +0300
Message-ID: <20260325151132.1399812-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
References: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)

[Why]
e1000_set_eeprom() performs a read-modify-write operation when the write
range is not word-aligned. This requires reading the first and last words
of the range from the EEPROM to preserve the unmodified bytes.

However, the code does not check the return value of e1000_read_eeprom().
If the read fails, the operation continues using uninitialized data from
eeprom_buff. This results in corrupted data being written back to the
EEPROM for the boundary words.

Add the missing error checks and abort the operation if reading fails.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
v2:
 - Split from original series.
 - Updated the error checking logic to be consistent with the
   implementation in the e1000e driver.

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index ab232b3fbbd0..a9c56505adcb 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -506,6 +506,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 					    &eeprom_buff[last_word - first_word]);
 	}
 
+	if (ret_val)
+		goto out;
+
+
 	/* Device's eeprom is always little-endian, word addressable */
 	for (i = 0; i < last_word - first_word + 1; i++)
 		le16_to_cpus(&eeprom_buff[i]);
@@ -522,6 +526,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	if ((ret_val == 0) && (first_word <= EEPROM_CHECKSUM_REG))
 		e1000_update_eeprom_checksum(hw);
 
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
-- 
2.51.0

