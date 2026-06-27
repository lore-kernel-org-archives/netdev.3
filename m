Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BFC17B50F;
	Sat, 27 Jun 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552000; cv=none; b=CX7oSo/bo05xHhgVabvjRBKlGHf8Calq2FF/P0CkrH7sEr6mnt+ySoZuhjAyhoGgt3W53TnnKYyVGdVbyyEIA5XhMtsHTqWGKQROTvehjXmN2Cb8YBNTBbwZXQX+Z6gJNaIOUfFf6r/li5t+a3B0iH7AfMjMikpmVekc+4XJWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552000; c=relaxed/simple;
	bh=tR9LIJrkNhSMMGn3D8mQBonHeNu3FT+AcZtzgtdtwQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyAYEOtTMl9MMYDV53Jp3wiYzDkZuWTKvQxk5G1ButThxZ1mXPmWLV/51LX+d7PBPbzSK83FwGf3whlpOT55ueGtGtq8AAY/WP3+5/ZlJtkL8+rIwh7opv9m+rG4BC4mkpgo+RIyqm8fRrdBHPKURDBLHn7CY0xcFwUt3yzxOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Nfpzm/Eu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vzOhjkWv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nfpzm/Eu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vzOhjkWv"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gnRp60Spzz9trN;
	Sat, 27 Jun 2026 11:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782551998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QwieZNzbB1xPTt1ikPHi9VJDWtgRYqxWd5mD+A2G+L8=;
	b=Nfpzm/EuR0PMAaih8vxJ7Bum44QP3W0OMPFT7tc/1ATdcm0foDbLVuXxWijPVGnL0BYjCO
	fnsQIbbWfH2QBlDPZ8Az7NFo0OjIL9cDszpOXfESIuR5UJD6vlg3uBCLFUqSZD3RTc1Opk
	MqfigFiank63wad2X1SGN88nsuOtbMXInvgJ3VwZkfG8xUd/prDNJlpA+K9ZDUxrizavYb
	Lwn6f1/nutRhDvaG9DYYv0YHGYtcfZPwSJBYPZyFl7G0pK26o3l2ya67mrjUc8Ub0S11GY
	XJvBacrJ+IjhtRXCfwFml4yHTiTNsF71H0Wr4nAO34dXPbpgm6iNP88VDBwEhQ==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782551996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QwieZNzbB1xPTt1ikPHi9VJDWtgRYqxWd5mD+A2G+L8=;
	b=vzOhjkWvm3rBBO6KfvDSDxSdLszKcl1A07W0pay3nFXpVjSp3jf3E/0T8Dj3Z6jYCCQnQz
	aiYJHkbGzutiMVaTCIKH3qQ5wWgairyT6hGUUVFmn66PgYG6/CIeP2Dym2K2l5XYX7Srul
	/XWH6lUeDxXh5rN1/leca8NXmgKI4X5FG3GwLD7I/g3iiWHiK65Y6oON7NVy/987KRjgYH
	hXPKBLYkUjO3rupDV+ZbVw2Z12gDfluIEmBYeynpGCq/68CKefUT6kdCtSWLKgZ9jESq+T
	6hKDU6E7YOKqdORmcny/abS6juxhn5HDGzbI8ncWl0elxHjzP/McXHpzBfHm0Q==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] dt-bindings: Fix bracket
Date: Sat, 27 Jun 2026 11:19:36 +0200
Message-ID: <20260627091936.29809-1-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 63gb6egznrbshnejs9oa3xasgy6d3efg
X-MBO-RS-ID: f1f64c14bcd14920713

Add "(Alternate" to "ID)"

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index accff93d38f8..62bf982aff2b 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -33,7 +33,7 @@ properties:
           - usb424,9906   # SMSC9505A USB Ethernet Device (HAL)
           - usb424,9907   # SMSC9500 USB Ethernet Device (Alternate ID)
           - usb424,9908   # SMSC9500A USB Ethernet Device (Alternate ID)
-          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device  ID)
+          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device (Alternate ID)
           - usb424,9e00   # SMSC9500A USB Ethernet Device
           - usb424,9e01   # SMSC9505A USB Ethernet Device
           - usb424,9e08   # SMSC LAN89530 USB Ethernet Device
-- 
2.54.0

