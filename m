Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589172;
	b=xCmw3pdu+VEjpGaxfND/P1SQu6xwYejlZwbjLgy37wwZ2nu2Rzqvu0vmYKb2ELSXwtW3
	 i1QJ2Mc/xpIHVJT3lfCpCUydXB1lbfmmGhr8Rb3HvSxlDGuw9zk8QxlwDu9SlnNb3ct6s
	 1512Mzm3ikogQC6gh8rwJHGyct0Ys2wiOhvTJ9LPHqd9lO3j7ZBcTv/4kixewxjJLs75A
	 29xTai/1Ne8QAu88leKWHkqjvqqYWsJJV8TuAyISrKyNU3PZyBLf/ha9aFslyY9p5tMcO
	 CWxw5si1AGB8tUuDVWRVbWXZwfCaAF2Kc2N94yCyG3aCcubpIFxaAL3eeUH6b7K9pSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589172;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w9dg4AaaJaDRpTl41ChaxjBbqBnEhij/Tjfv4wRm3ss=;
	b=GBL9yVcQfGigyOzSZzUbeqGPNnDjEekLNvrFdy7ejCqXis+kgXS25JNahJtfHdCSeWn+
	 EJ4PmLM6O5zF8ioRvnDWT8D1KA9a0waiH62FVVszUTfpuaM+iAHtgCwyQE9ZVj6fsQPWi
	 Y8zXTJPqprsew92Ifshtn+AUlltFPN4yuVaFveINDAAuT9/l0+044fvGApzYDiArYlBcA
	 9DEIOSR9P3GNcQ3oGUZ2ytkkoJd6JDt4MRgQdCl6qzBauTjlitwfbnRfN8BTUWEsYrzGS
	 sRHCGclCKvEYk+9xBADoBHfiFrCAP0Z/kZLSXJfZtkB6xBfMGKDp9l9+cJogD8EP/dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDQfzj18;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FA60A260C;
	Fri, 13 Nov 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDQfzj18
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589172;
	b=ZzUXhtAinGxvLEuto/spAvM2krywTFUFKb2WknXhEkKma6z0EShr7Wbq/lzgQwu9eD/5
	 z4clNXJwAZaiSZDIFtkNuj/0LGJvQadtgk40f+l09F9Cf20nHIrP/DCkx6rkH0aU6btSy
	 cGPOzzdmXE19JgZRoSOk8x6F14stsJJ8A3Zti43ixRzASlJOoCsgm/01CD7fp/ufZlwlb
	 gNaY9fopPZJ02+Sbu4ZbkJJBVZxNjjv4tNrn0qbHKD+gl2RQ6wzFeT7ruG8/uX6iA2YRG
	 bAtgDy1pnd6eSFjXOIzw80BVeQeHayeKrXa3NbVgjFp9nMA6noynJt2Bh2S33aV3r3w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589172;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w9dg4AaaJaDRpTl41ChaxjBbqBnEhij/Tjfv4wRm3ss=;
	b=i0DudhsoAKvFsbirI33wFHM4js1BCQIMcb3xZ2t7NuXeEqSIS8DM286sGFDXQrQ//EAr
	 YhSX7xRrU3u+6R0hzfDnoiW43yBrv8Xsdz0nQM7el3YRrhkZh/Kzci7iepzsqp+V4i5Nn
	 SOX2NL4tfBZFrkzmsWCsw6ILn3Ze41IEVxQut9zCq4kIpai6Hsn+CSz7M+be1tZUEcLju
	 WjhouhYUYPeupMBb8vwzDRWvo+RT0P/h79ISRPj+wD7s+K4CUt3ld2/CAOm+BoHq37JnE
	 IEi7IFMjcGAjGPP0cIUi4VB0RFCOHmJPKokO9JBhT1DB5CpRO4ZfEFbXw8b7P8G48TA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D68B41F000CB;
	Fri, 13 Nov 2026 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589172;
	bh=w9dg4AaaJaDRpTl41ChaxjBbqBnEhij/Tjfv4wRm3ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UDQfzj18jXhWV65rLY+CEWQ+4I5YItix/dgLGWEy+Se3t5m5/RGhnLHemOkiKdork
	 wUbWj7xEXQcfDh292PRBvEQOHTubz/yMYzdIkjYqkwO7aT/xSv/uU/nzPblffdROgD
	 b3qru9ZgPVZ5ZAwYDm1ozB/Im/Owus8L2y7SzRfl+b/sYNRXZWYM1MRYebw6TvO5oi
	 aJNsD+3MI7PvymyO3KQiUkbY3BIIuF3+LDTVTKBBPMjmgv/x5UuXxo/oC22KedgG/Z
	 Vb45M8562hzXUr/L+NV9sgntpk8BjK9S8/jVcLm4Lj7TV6hUfrGpQ7GNm0655YBjMV
	 WYCX0mXzNYylA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A18B49A1F;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:24 -0800
Subject: [PATCH net-next v11 05/14] net: ethernet: microchip: lan865x:
 Depends on PTP_1588_CLOCK_OPTIONAL
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-5-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=995;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Wj4qNO+pltej/S7LvUHDWa6nEFAP4MrIYcLCWkuKPJc=;
 b=vJ2gca9H5Wtp6WO/1h7EIJ3ofko42ULtcL9bO0LF0GsD4vmRIvI6czmjmEBLzK7vKyCBER/EB
 zIojPN+nAFsBgNjCdvzI4v3O7pOy1S6NkBPl38MsZVSauHYZXIo7X3V
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add the PTP_1588_CLOCK_OPTIONAL dependency to LAN865X. A following
patch makes OA_TC6 depend on it, but "select" ignores that, so
LAN865X built in with PTP_1588_CLOCK=m would link-fail on
ptp_clock_register().

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Moved the vendor changes into its own patch.
  - New patch in v11.
---
 drivers/net/ethernet/microchip/lan865x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net/ethernet/microchip/lan865x/Kconfig
index 7f2a4e7e1915..342172cb8837 100644
--- a/drivers/net/ethernet/microchip/lan865x/Kconfig
+++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
@@ -8,6 +8,7 @@ if NET_VENDOR_MICROCHIP
 config LAN865X
 	tristate "LAN865x support"
 	depends on SPI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select OA_TC6
 	help
 	  Support for the Microchip LAN8650/1 Rev.B0/B1 MACPHY Ethernet chip. It

-- 
2.43.0


