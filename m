Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567953;
	b=Vkbukmw349H6HwBTXtKCZVgzSd9XJ2WwAhJJK8ovokAbr8iXP0lUptJYlIoWd90uxMsQ
	 1h9fn2wQu29nCbMxB5bWlR4C+ZsKnAmn7fuSbhEhFmLzDyV2I7YoJ/BKQQUFaUZ4PTWMZ
	 GNyfjTqNjyE+Nv4yyaN8xDsjbdfT6MQCRkOmyho2DyDa9Ei6ksTuh34/nX3UWF4g53hxd
	 IyHttxuQEvyLORjOyIXWc7lS8rEOtqyeI/N3gWZIV8hsBhffjBxKa32jpA7Pua5fraEPs
	 x3LVxqbpZQ+v8Jiv3+MVJKTNAscnJ8CIRFi6lUyqoRJP7BqSb2oY70IBLuQwkijvy9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sIczx4EcJP0tNqiNCagmfdESXjTqKCY2sjQfBlgdqoY=;
	b=Dg9kUlidPG2gC2BEQkZp9o7kRFnpsuOsACLaGt8OY3ZubXDwoatKKz0H7mstN1z34+0t
	 BApkBdy+mGsmbep1pcZwa+mS5QXszxGsknmAOqBJh9+NcGpC4WBe/NDRzJoJEhGJJEnjO
	 GtZl4Tbt2u+GoglFMkCX3nOyuVz//PLxZydEoa9LIgvCpzqUpsksWDu/k9Pe4IMVAh/Zf
	 C7I42AVxA4uxaSMcPCU+QdKXLtsFMu8pvF+TZIwbOY1t5/tgwGzD37hi8v7lYTHZM7MdQ
	 5xzuJmto5KjAxPee+XBn67mp9hue3nwgUGzHehuvHQ5+VU4tjjaFET8Hx6gGSDNGdKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pTrJM5N5;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACF606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAACF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pTrJM5N5
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ae25dcbd81so10712931fa.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567951; x=1795172751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIczx4EcJP0tNqiNCagmfdESXjTqKCY2sjQfBlgdqoY=;
        b=pTrJM5N56JwLitY8jMA6aeAQED3ILcDksDAzVeMg7z+Pb40AzV+vriwY9m1oXzTIDg
         HNnq0dE5w0sV94AlLlGZeS5rvx7HDP/f0LVqvKamh98XrWMprTEwjX+FNwspkbByavRc
         VHNqX30dBy8VBpRBqCNrRrhomiwHGXmk21ItMlOhyqFAvs6h6JA3oGaCb2NUWj++a27I
         0JMty6SVln9aWctIzGZK0N2Iwlt0dx4U1x9y9pR6oI8+unczMJ6TLxZ+KsIdTTFwDElH
         j9Q/OYNf3v4Ga04FaKONKLv0jy8CY9tYUsp+hst2Eldnf370JJRGKTolOANfYza5osym
         UBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567951; x=1795172751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIczx4EcJP0tNqiNCagmfdESXjTqKCY2sjQfBlgdqoY=;
        b=x7TUg4vn3D+Qw2UA1qRJFr8XnjmUwrdPLf3H0jC+/fh+CVGcaD6gDOqa/8rA2QomXH
         ejSB7gjNs6myyDAAFOGQH/SpEbge2cYHsyMZ4ZpxmkUwgif5hTVH6jqjvgQlMhyB/lAr
         Z2oyBEedW9FOOL+xzZShY1V2/2QW6GbSGwWPv3JckNhKe5jThpQTmRhxqWbTxhLn4/hV
         9ccgEeYXKU5uzj9eJEJQCA96Gd30EO3cD9EbjGdMJpWJXbQk35/0dnRGQBKbVHtm6wjK
         E8JCV+Mm+mLLIcscSIEnEh3VtDA8IvdQMkzsOLi2PgVX0CinBM8y0Iqm6pDgUsINF/jB
         7tCw==
X-Forwarded-Encrypted: i=1; AL+hErEEzEYqE24Kep3NP/rnuh2ufhCd+07ENph6cGBTIEjsvIttqdrvS4YasX1+HhcbrQHQN4zJMoc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s9HPO5HLtyO2fDi6sq1YU3rY7IeBGC3wMcMS2Jhn9oqRzW3JF
	j+5hVTMozFCLlxsA8MuyKUDNDVkpDkfnxPGcTmqY6T0MjWIJt9voTpArm8m7cw==
X-Gm-Gg: AYBFou0l7p1PBbqotWMWKT1U/J0rGtUfWMIg7sE+3ohX73lsApw0k6e63c56sRO7x4r
	d7YrsuHrIUR9Mlyy7HpmiUKpNtQccaTAn1fWIR8PZBOwenqeSwal5YmMA2GovuspmM5EpD5DF0H
	zPg0pQk5bUSqfcV5rutQUTYJt7/hd/oeSNJTBA2/gjwE2fJR+ebe/OARyJDLv+EeZc4sk2yO6zk
	fzcTZPGpjItJ0ezSNqgXWvbDLe27vXsYzCtfSVCbEBos/8+sT4n4rUB12+R2pkMhlFfFfiZhjI/
	mJAJuoD4lX44WEyjvlk38q+7rKwSK8B5detnPt2QPo7/xsYh9OsBfeq9PeRI+wSwFlD8rCZicXv
	NXHIEVQbJsSj+dS0ndRxFjQQQRp0ddqvMpcllr4zMWfyv8iBZ3CkvQvZe7LceEAa+qy7pJJki7L
	d2owNgHGdCQb4j5a3DI2vGxPkz9wjkwb5UQleasZIRkBHAAFBU161XPzclhiuuUdoEGPYLqFLej
	eu/tR5mCMsJrf/kKAJ91QhlOOUTx+8xvBE19LNtpB1YYRQXKXuXrDaZpUSM5Kukn8zhUB7hdpCJ
	pZIAfAO4xSYj17ctiJM/l10ddWAJajmhE+dKiNdRPDDwSy8=
X-Received: by 2002:a05:6512:15a8:b0:5c0:ca1:46c3 with SMTP id 2adb3069b0e04-5c170b1c76fmr842803e87.22.1794567950691;
        Fri, 13 Nov 2026 03:05:50 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133371asm610997e87.21.2026.11.13.03.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:49 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	maxime.chevallier@bootlin.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] net: phy: dap8211r: add LED hardware control
Date: Fri, 13 Nov 2026 14:05:42 +0300
Message-ID: <20261113110546.173624-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hello,

This series adds support for hardware-controlled LEDs on the DAP8211R
Gigabit Ethernet PHY.

The first patch documents the optional "leds" node in the Device Tree
binding. The second patch introduces a small helper to write extended
registers, since the LED registers are accessed indirectly via
EXT_ADD/EXT_DATA. The third patch implements the three LED callbacks
required by the PHY library.

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/dptel,dap8211r.example.dts
  DTC [C] Documentation/devicetree/bindings/net/dptel,dap8211r.example.dtb

Required:
CONFIG_NEW_LEDS=y
    CONFIG_LEDS_CLASS=y
    CONFIG_LEDS_TRIGGERS=y
        CONFIG_LEDS_TRIGGER_NETDEV=y

Testing:
$ ip link set eth1 up
$ ls /sys/class/leds/
stmmac-1:01:amber:lan  stmmac-1:01:green:lan
$ echo eth1 > /sys/class/leds/stmmac-1:01:green:lan/device_name
$ echo 1 > /sys/class/leds/stmmac-1:01:green:lan/link_1000
$ cat /sys/class/leds/stmmac-1:01:green:lan/offloaded

$ echo eth1 > /sys/class/leds/stmmac-1:01:amber:lan/device_name
$ echo 1 > /sys/class/leds/stmmac-1:01:amber:lan/tx
$ echo 1 > /sys/class/leds/stmmac-1:01:amber:lan/rx
$ cat /sys/class/leds/stmmac-1:01:amber:lan/offloaded

$ ip addr add PEER_IP_ADDR dev eth1
$ ping -I eth1 ELP_ID_ADDR

--
Best regards,
artem shimko

Artem Shimko (3):
  dt-bindings: net: dptel,dap8211r: add led nodes
  net: phy: dap8211r: add extended register write helper
  net: phy: dap8211r: add led hardware control support

 .../bindings/net/dptel,dap8211r.yaml          |  38 ++++
 drivers/net/phy/dap8211r.c                    | 207 ++++++++++++++++++
 2 files changed, 245 insertions(+)

-- 
2.43.0

