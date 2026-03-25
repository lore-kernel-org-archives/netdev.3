Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D373E023E;
	Wed, 25 Mar 2026 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451805; cv=none; b=XCmEfUabwKbq2sPoYZR2mf8U+Idejdb/GjRVef/c81jHzv/eKCE+OeDiH4Uwk0ZRbuJHGoM46C/OzTiOAW1rASFQV5/bMSfBiAKxXRhsIUreWy8My9pWx5OrCwIU8YibuzLDBCFY4A/vFxK//AedescpF4SoW2VrERCcqiXe6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451805; c=relaxed/simple;
	bh=Wlg44DqnfJaqyWBN6Op2t8hnzKVeLag5dyQfgjVI3tU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=OXAbK46n/vz+8FDxPsdz4qQLQ3hKKIi7aewzJDZW0BRieDPTkZ81hsQcAMnmL9ldx01tGqaJkfd0ax9voT7ly75jGd5mPSMssUqSkt2hW9iR5SXoxATHRfy6sSrByDyTCOz+KuB/2iuopCr02ih3yMKRJEI5zv+Gf7dm7WF6ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=jaFw6gAk; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="jaFw6gAk"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1774451801; h=from:subject:to:date:message-id;
	bh=Wlg44DqnfJaqyWBN6Op2t8hnzKVeLag5dyQfgjVI3tU=;
	b=jaFw6gAkRx5+HcHWMEsrrq7gqnPDy08whPC1GNH52qCB4NWMZ7YbX2OsrO80Znjd07XNaYQkFfT
	d7FE6cmXpRyX7yEPRRcYMDj5BW+oAIu94/9a2+rtPiMPcJ7ej0S2F9gE7vVnVnVuPE0ifPcROVqTj
	y17KYvecF6kJ3NPIo0R/MGtQE9jQl5v6tbVuguCnJ7GCChaxf78O1bpJIv9uY8wlDPRDr9opouJVp
	kRoHxS8qGEpgslGOYN2kNsSD6RA4FVLtJ6Pk2qGZo//AnN1U+DxjkwsLWMT9YsFKxNDT7eDXw0rCw
	MlyjsptYTWt+SI04SV5gfW3n+aWM3OcXttyg==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 25 Mar
 2026 18:16:40 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net-next v2 1/2] e1000: limit endianness conversion to boundary words
Date: Wed, 25 Mar 2026 18:16:03 +0300
Message-ID: <20260325151615.1407182-2-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325151615.1407182-1-ade@amicon.ru>
References: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
 <20260325151615.1407182-1-ade@amicon.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)

[Why]
In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
words. However, only the boundary words (the first and the last) are
populated from the EEPROM if the write request is not word-aligned.
The words in the middle of the buffer remain uninitialized because they
are intended to be completely overwritten by the new data via memcpy().

The previous implementation had a loop that performed le16_to_cpus()
on the entire buffer. This resulted in endianness conversion being
performed on uninitialized memory for all interior words.

Fix this by converting the endianness only for the boundary words
immediately after they are successfully read from the EEPROM.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
v2:
 - Split from the original bugfix series and targeted at 'net-text'.
 - Removed the Fixes: tag; limiting the conversion scope is an
   improvement to avoid unnecessary processing of uninitialized memory.
 - Improved commit description for clarity.

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index ab232b3fbbd0..38b1f91823ef 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -496,6 +496,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, first_word, 1,
 					    &eeprom_buff[0]);
+
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
 	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
@@ -504,11 +508,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, last_word, 1,
 					    &eeprom_buff[last_word - first_word]);
-	}
 
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	memcpy(ptr, bytes, eeprom->len);
 
-- 
2.51.0

