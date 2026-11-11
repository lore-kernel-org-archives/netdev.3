Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415204;
	b=3mi1R6DY9XMZczugZQjVQEn72nCF8t3zSQTde1yaWHY5dCpOb7PJYbED4U5/ucMOlwD6
	 WaO2kba6F57Falup7/ODwr6sEW7u7JUI9+A+pTCZquhq+27c4XXG86AQ0zqPg2eyqZYd7
	 Uv+ePJIjVwXCcKiohoqy+VN798YI36TVUgtlDkXYbHPmmAWTPnwmgosPHVljFzN/lvdHp
	 7/a28QdbQAXO6nA9BiYHJnlTiu23LFPoe8ufnoV9rTzJ7L7wDPYSh4rN4RHlmryZC/eDE
	 OuSuTLDIsqZI60/lvSF3t8D0siRETOn0f2SY0HAtjo9tsewtmvo1hQbpLiuuf2T6OMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DK/NRwKqv4Idy7jO63RXwvPCac5VLHLN/HkLe32hFbM=;
	b=icfq7e4M2jcrtwHOsnUJyx2L/L8FELDnhXKjKMHbuDRh6xyTbwxukm6EBRRfLAqm9uVy
	 SjlftSXlllPgc9/VItXNDoIXMNkoKxMvH9nTdST7Qhig+dvGSALSs4gbfGXb3EhK5s0Qe
	 nBL7z66yz9u7w/GoyNMjR39ZCMah2x0VrQY+t9Pw37lIn4lOWloQ5sukMMf/IR7VpciUY
	 RqeErMKDi2dWW5/sjQDxG4z4fHJZveGXoG9mG/OzgHpa/ucSGwhB4QhSbVpDKhLzk2A9C
	 2Aj6uHqKc5Vfe3FCjJpy+rMt/9C4NzwIsceY00rEqplpC1iH3/hDda7TUkBKfwmlA/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LoqCc/MR";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC288606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC288606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LoqCc/MR
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2106849a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415203; x=1795020003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DK/NRwKqv4Idy7jO63RXwvPCac5VLHLN/HkLe32hFbM=;
        b=LoqCc/MR9jv+G8Zww1geKlz7y0ShcuVx4ANEhnDNDO5Wpqw/0M3guUgzKw4uExm46R
         kijMwzDjeMg2QOLxXJNe/kKuwiEEzsPkFK5zrlJGl3Z5GWjcxIoLN5NiwabfOzOchs3l
         Rp/hIbyzDCugP/LSDxLwqlnFHpxOrR5bjAJfR1gweclbPp6ITeH9RsKWgFjJbkZyWQjJ
         PhCCdy8KBiFiZOCGCdCj4AzkMx5Mwbl2Or2yNV1D9JdSwz0nj0dLnAmRM3tNvl99dZbb
         EUCJp46z+ceEbSz8j32opjf8VTJbItjgoyW35N0nk2KByWsmlIEu4ifUbR8IJIkUHlTd
         4W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415203; x=1795020003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DK/NRwKqv4Idy7jO63RXwvPCac5VLHLN/HkLe32hFbM=;
        b=W0JbLdMGxyVEWOM1U9ssSZ3BA0HbJ/U5vowSMXRY5f8fsspR/K6Qd+XL11VA64wObq
         E9au4aMO9DNT8nQSsJHWfUu41z6ZANXH5qrSRZQsPzOUe+ovYRMo9MAg4NQ3WSta86UG
         Z18r27YYTcHDS9KWEU6v3xyuIul/R7eqt8TGZ9QtMcFedZvimj+6Cl0abj8+Ohqv0sdi
         W9dxix/m6BDn6LfB8EiQK+dh2cB1uAZmDHgRBCAhGSpXVlB6k5SexWmt4e9kTH3g8mX2
         U96D0XiI7/IIjORpusbZY0C6JHo6hbQuyirzQ3w+c+BZaP2rVQBw2OQcAmWV8u/lH48n
         lyGg==
X-Gm-Message-State: APuU4Z/UDPNrW4LtgZZfL5zm3whef1+z/X/O3gNXWE+myJdfO9AEhiQ5
	apE6wSl8IH6u2TwavHEONjBzH0V10RotBWuKU/+g7r/fkwBOeiADOpkO6R5mzA==
X-Gm-Gg: AYBFou3TTMRiRYuI1BRTpAVkLC1+FTTAy7QXnuJCs389ujBxcxTxaIa6XI9Gkl4aBQ1
	I5sBoHphBPIUMhjVF8D8aXNmcKceWUy3cuSN8F057QVZqhvyU8a0j30CTqwiSq7Op1oCRA2Ib+A
	v/DnpmMwC2ukFugxkHUE7IdwhKzwSg5HtFs9ORddI08JQUcXUDa/NM2QBdn50Y+nkizV+1hhHRy
	B08L9OzalmO5iOpxulftGwcJB5Lsd4fwG6TAvWqm9ab/jDt6l+wCuomEbdUg+At9OwgXnLfl9pr
	vTzQOKTjAesA2Xt09kTqKSxQWVlFdTPJTsmlQtYymhy8lMvxElu8/Gs6ZOIAqrwd1iqE6/3L2ct
	Y+jy+BwtzfiEh70up8vDmJFZj2JSj7hYiNmQPdonGQ9NhQSRJknArYCIlPiEJdnhNYrQ+urQZYY
	KOE2WlEt8Tf2GIOXB4oWjjidghoTFaaqQT13MuTfSdES+fSd8bRnqyDRXRlwZ8YJs8N3TLrnKEP
	8Qj25kMs+lzRsRXUP4sU6JOGS3aa/QKdYs0o8FXr0CA3oXtkx0LJYBJlMHtHG0DCw+o67yhNRVg
	HdJvAiWrgLrFg2FaNfJwFKFjOFYsZEbqGM4XT7JX7+nXx4OV5N8PbOUEwiDC7nMQhGadnQiqW88
	=
X-Received: by 2002:a17:90b:54cc:b0:3b0:9162:948e with SMTP id 98e67ed59e1d1-3b182eda812mr2877851a91.27.1794415202712;
        Wed, 11 Nov 2026 08:40:02 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b2cdsm29035a91.16.2026.11.11.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:40:01 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: motorcomm: Resync SMI slave after interrupted MDIO access
Date: Thu, 12 Nov 2026 00:39:18 +0800
Message-ID: <20261111163954.1132921-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A register access over MDIO is 4 frames: 2 address writes followed by
2 data reads or writes. The SMI slave tracks the phase in a state
machine, so an access interrupted between frames, e.g. on an MDIO bus
error, leaves the machine in an unknown state, and every following
access fails or acts on a stale address until the machine is realigned.

The driver so far assumed every access succeeds, and relied on manual
resetting when the state machine wedged. However, without a dedicated
reset line, the reset itself goes through the same SMI interface,
causing the chicken-and-egg problem.

Realign the machine before the next access does its own work. Also, the
initial value is unsynced, so any stale state is not inherited.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 106 +++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..8b6c9739b684 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -94,10 +94,98 @@ struct yt921x_reg_mdio {
 	 * Keep this because we need switchid to form MII regaddrs anyway.
 	 */
 	unsigned char switchid;
+
+	bool synced;
 };
 
 /* TODO: SPI/I2C */
 
+/* An SMI register access is 4 MDIO frames. An interrupted access leaves the
+ * machine in an unknown state, and every following access fails or acts on a
+ * stale address.
+ *
+ * The driver used to assume every access succeeds, and relied on manual
+ * resetting when the state machine wedged. However, without a dedicated reset
+ * line, the reset itself goes through the same SMI interface, causing the
+ * chicken-and-egg problem. Furthermore, our driver verifies chip id before
+ * firing the reset, so that can never be triggered reliably.
+ *
+ * (A/D: address/data, H/L: hi/lo byte, r/w: read/write)
+ *
+ * State Input Next Comment
+ * ----- ----- ---- -------
+ * AH    aw    AL
+ * AH    dr    AH   `0xdead` sentinel
+ * AL    aw    DH
+ * AL    dr    AL   `0xdead` sentinel
+ * DHr   aw    AH   abort, frame discarded
+ * DHr   dr    DLr
+ * DLr   aw    AH   abort, frame discarded
+ * DLr   dr    AH   the access is done
+ * DHw   aw    AH   abort, frame discarded
+ * DHw   dw    DLw
+ * DLw   aw    AL   abort, frame consumed as next access's addr-hi
+ * DLw   dr    ?    `0xdead` sentinel; stay or advance undetermined
+ * DLw   dw    AH   the access commits
+ *
+ * The table lists the whitelisted frames only; any other REGAD/op combination
+ * is not characterized and is never emitted here.
+ *
+ * The resync sequence is dr, dr, aw, aw, dr, dr, plus one more dr as a sanity
+ * check: the machine must be back at AH, which reads the `0xdead` sentinel.
+ */
+static int yt921x_reg_mdio_resync(struct yt921x_reg_mdio *mdio)
+{
+	struct mii_bus *bus = mdio->bus;
+	int addr = mdio->addr;
+	u32 reg_addr;
+	u32 reg_data;
+	int res;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+
+	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
+		   YT921X_SMI_READ;
+	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
+		   YT921X_SMI_READ;
+
+	/* dr */
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	/* dr */
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	/* aw */
+	res = __mdiobus_write(bus, addr, reg_addr, 0);
+	if (res)
+		goto end;
+	/* aw */
+	res = __mdiobus_write(bus, addr, reg_addr, 0);
+	if (res)
+		goto end;
+	/* dr */
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	/* dr */
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	/* AH --dr--> AH */
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		goto end;
+	res = res != 0xdead ? -EIO : 0;
+
+end:
+	mutex_unlock(&bus->mdio_lock);
+
+	mdio->synced = !res;
+	return res;
+}
+
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 {
 	struct yt921x_reg_mdio *mdio = context;
@@ -108,6 +196,12 @@ static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 	u32 val;
 	int res;
 
+	if (!mdio->synced) {
+		res = yt921x_reg_mdio_resync(mdio);
+		if (res)
+			return res;
+	}
+
 	/* Hold the mdio bus lock to avoid (un)locking for 4 times */
 	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
 
@@ -136,6 +230,9 @@ static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 
 end:
 	mutex_unlock(&bus->mdio_lock);
+
+	if (res)
+		mdio->synced = false;
 	return res;
 }
 
@@ -148,6 +245,12 @@ static int yt921x_reg_mdio_write(void *context, u32 reg, u32 val)
 	u32 reg_data;
 	int res;
 
+	if (!mdio->synced) {
+		res = yt921x_reg_mdio_resync(mdio);
+		if (res)
+			return res;
+	}
+
 	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
 
 	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
@@ -172,6 +275,9 @@ static int yt921x_reg_mdio_write(void *context, u32 reg, u32 val)
 
 end:
 	mutex_unlock(&bus->mdio_lock);
+
+	if (res)
+		mdio->synced = false;
 	return res;
 }
 
-- 
2.53.0

