Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F56A3B4E9E;
	Wed, 18 Mar 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836448; cv=none; b=aF/FNobbXNlKyrVJ4pfRyWxySKu/e2MXZhS0ABSKKD81NdJcodirKUGQOqwA/i/1HlR8gFyIs/PzsdgB9sD4yO/NDhzIfT1VO3kapS98MqeBBPzQM76BwpWnVFIN9Lo0cNnNzMJja6QLJe6Nn/akKyQS6xCvi0ckN/mRhc4OuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836448; c=relaxed/simple;
	bh=NCdVk5JWan7K37ZYtd4B8iDcavDP/jrJcBFFkGLlPxo=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=KFfPThQhjvvXIkE5IYw7XKVMJNMOxOR3H3Ar1vMwsPJTn3mtV7Qw7IwiNMmf8WniXCBM/NbxSIZtG0IuT90Ime1F66wVO/4OfC1ygCp60cvmhXyClACRnmjmd+5xc/z+lJvYKvkqdjJnHSMPzGwOpzSaR1YLRBsr+6CIj280K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=ZFMFN/hk; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="ZFMFN/hk"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1773835531; h=from:subject:to:date:message-id;
	bh=NCdVk5JWan7K37ZYtd4B8iDcavDP/jrJcBFFkGLlPxo=;
	b=ZFMFN/hkDIuh7B/avjZjAbP6GIxBh5sDQ57pwC/l97HXIxa9eRmYXOEymnyEcEApzSmIlGlNHqX
	iEM4FefnNMGYdf+CEPUFsSuZir1fRnrgxoyPuLC/y9O7pELteypUxTFcxfB/GolcGVDzbm71oPkRu
	iC4BxLLyBdQW3/IKhkv4ANv1QNVa3x9/YjTwJQ8h9Sm0aqnTLyQeqbrbFfsaZlJNxCR7PK1lR6b7W
	fZXsFqPUnlotTlW5PYKlybpM0TwAmQ3u0ocFRbyQtgaASP6LEF0xiWXEi0sfeY/JWcYIOZuUC5IrX
	ow1gC2yH/Jqei4A4ZiTWmafGiqHZm2zFfc2g==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Mar
 2026 15:05:31 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net 1/3] e1000: check return value of e1000_read_eeprom
Date: Wed, 18 Mar 2026 15:05:05 +0300
Message-ID: <20260318120512.687149-2-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318120512.687149-1-ade@amicon.ru>
References: <20260318120512.687149-1-ade@amicon.ru>
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
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index ab232b3fbbd0..4dcbeabb3ad2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -496,14 +496,19 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, first_word, 1,
 					    &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
+	if ((eeprom->offset + eeprom->len) & 1) {
 		/* need read/modify/write of last changed EEPROM word
 		 * only the first byte of the word is being modified
 		 */
 		ret_val = e1000_read_eeprom(hw, last_word, 1,
 					    &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 	}
 
 	/* Device's eeprom is always little-endian, word addressable */
@@ -522,6 +527,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	if ((ret_val == 0) && (first_word <= EEPROM_CHECKSUM_REG))
 		e1000_update_eeprom_checksum(hw);
 
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
-- 
2.51.0

