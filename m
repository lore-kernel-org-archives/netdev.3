Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030743ECBED
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920148; cv=none; b=jEY5zVxBomCGm+kf/fuO+oNqBF2da1yOSksrj3pHrobQxMaSizKTR3FhMQl3lAvbAhM2CC/g+MyTsgYKi6jtgKyaNiL6gZ9yq5Evpxqalk+YBRPIVxL5xzyQMYIjtSXku5ugmYVEksLFEkciX1gMyD3Mc6OW/fwE3h0/7RYHEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920148; c=relaxed/simple;
	bh=AxcKTep58zD42ThWIjeqxn3/2xUzVtRG8RNmD3PcLxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trLa+KWRHySTjLSYguuhOLgPV4usg7/zNeGBmFnjCmHzxud8VOBR7m3jX11VChxYwkTFEMCAtnQ8kBt2KsyJGtlve3SLHXV1eSmpZYjXPsSmRh/yFKn8so+0tih5LoKF/iOeZeKFt5UoATUuQ0q9eXKjjD+ZajDNy0130Xw3LVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gskVshpD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gskVshpD"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so5318571fa.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785920144; x=1786524944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zZi5geWwmUjwL4iM+G3RESSIvS9NP5v+JPOUVTxODL4=;
        b=gskVshpDLyI5tj9E4BNoCN4f5WWM2Pgy1pYZ3ntLSS74H2PvAncDqT9+7MDsfdO0su
         VWCas9ZSX5G8iilN/SrC5YXPK2lIKOdVCjnoZseFMouwCS1lhsn4eDEazrGymKUEWelQ
         rahBmN+Q8zgypT8/7UEQ5Sh+l1DlQLFvoK8Wia22XPupmsDI/QsFZSjWbR0r+hAVvBJT
         a+gcPsxzYB6u190iWkjthdjacfTAkYjN7rx8LRW3gSHz6MRzccXw6F7/pf2FKTNsfL9E
         tr64RNCFKtBNFtEGdod5IvGG51DwKiygOUgw+sPofgUhEHqWGe/SW2VVcDu8g7icu1Pd
         szxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920144; x=1786524944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZi5geWwmUjwL4iM+G3RESSIvS9NP5v+JPOUVTxODL4=;
        b=of/w4gnHSHrw+VE26FXvXSfAAeE4ufDtX5gonb1m8Qk4yCDMOICFL3/66IRbs04dpU
         9rBnc+QjS4oQYP7QC/o3tnMTwcVravZs+n/QknATCxK9dbqCiaRjiMUOYl2Yf/n41nQN
         ToYtDII7YyosHMwRvcAggZpurw22OaKKFpOaH+iiSODXoXmElIjYUC3ndh2Xi6SUWRbo
         85rD5z99WId4EWmgaurdOERQlARSdheLSPkSNXy8THyQ8O2hJ/FjJ21qYUehV/jqUuSZ
         0AhEkru3CFrIzw1DAdeZgWqjGSjN4KraLSaPa0px8I09SAbVpbtR2zg3D7tglvl+sf8l
         mVqQ==
X-Gm-Message-State: AOJu0Yy0pCUIZ056Smu8c0EcpX5mNurujcz3CZQrYz8K7l/AYfCRnrZD
	KlJEMq//VvkH7/D4pbyz3/Ubpm7QSB8FjzFmmNirfWuxvL6dIcZjBkTF4hbT/A==
X-Gm-Gg: AR+sD10yyfX70WHpIMTd1v1qCI5eIVVUOFc7yYB4e6EsUo9uOezLhrcPgEZgIPpIrmt
	KkDu3/VGOqhCXU3hKQRb1oTjwXizCYTbJaNrC+50GoJZhOwQv6bRSH2YQlR25qZaw8ltsF8rgYu
	klihhO0FkQCztupoF0sYtXs8J1W2CAmW4j42wdWGYIHnCjP+S/hu+aOwTeh5ZVOiUoPRXh307RZ
	jvxdjgQDckHjRet63LzldSnwh+2HzbDI5BLpl5+nHR4mtQTcdu2NKcCvE6xI68jZ66Ehzu3x5CK
	OOa3xQKtAeHzk1VD1fu7Jdzj8uJtj6DLChb7Z9qPG+Ju+JxvvF07ZjkshlGk7latmRs1uS5CCfj
	vbNS2wZZ860BLKCqKUIvM+rNDfDxvBH9PoukJ6tEz3wcOCmw2qGbppdx1MzpZoorOnApyrNkBbh
	Ila0XkPJaXeJ4HDfWT4iyNQkdMpccQEWw2kk8DxHbny3qb7vFHL5wvzKetoN6bbA==
X-Received: by 2002:a05:651c:551:b0:39e:b3b2:e947 with SMTP id 38308e7fff4ca-39fbb225458mr5782181fa.11.1785920143628;
        Wed, 05 Aug 2026 01:55:43 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fb9a152aasm7470471fa.21.2026.08.05.01.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:55:43 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v6 0/3] Add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Wed,  5 Aug 2026 11:55:37 +0300
Message-ID: <20260805085540.452260-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds support for the DAPU Telecom DAP8211R(I) Gigabit
Ethernet PHY, commonly used in enterprise and industrial networking
applications. The PHY supports 10/100/1000 Mbps operation with RGMII
interface and includes features such as IEEE 802.3az Energy Efficient
Ethernet, IEEE 1588 SyncE.

The driver implements extended register access via indirect addressing
(registers 0x1E/0x1F) and provides comprehensive device tree support
for RGMII delay configuration. The rx-internal-delay-ps and
tx-internal-delay-ps properties allow precise tuning of clock delays
in 150 ps steps from 0 to 2250 ps.

This PHY is used on the NDA platform with 1G Ethernet tile and has
been tested on that hardware with successful link establishment and
RGMII delay tuning.

$ make dt_binding_check DT_SCHEMA_FILES=dptel,dap8211r.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/dptel,dap8211r.example.dts
  DTC [C] Documentation/devicetree/bindings/net/dptel,dap8211r.example.dtb
$ yamllint Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
$ grep -i "dap8211r" Documentation/devicetree/bindings/processed-schema.json
    "http://devicetree.org/schemas/net/dptel,dap8211r.yaml": {
        "$filename": "/home/a-shimko/patchwork/linux/Documentation/devicetree/bindings/net/dptel,dap8211r.yaml",
        "$id": "http://devicetree.org/schemas/net/dptel,dap8211r.yaml#",
        "title": "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY",

Working with xgmac.

Board side:

$ arping -I eth0 192.168.5.100
ARPING 192.168.5.1 from 192.168.5.100 eth0
Unicast reply from 192.168.5.1 [board.mac.addr]  8.543ms
Unicast reply from 192.168.5.1 [board.mac.addr]  3.295ms
Unicast reply from 192.168.5.1 [board.mac.addr]  4.301ms
Unicast reply from 192.168.5.1 [board.mac.addr]  4.096ms
Unicast reply from 192.168.5.1 [board.mac.addr]  2.872ms
...

Unfortunately, there is a dependence on the axibus speed here
$ iperf3 -c 192.168.5.1
Connecting to host 192.168.5.1, port 5201
[  5] local 192.168.5.100 port 58936 connected to 192.168.5.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  7.88 MBytes  65.8 Mbits/sec    0    150 KBytes
[  5]   1.00-2.00   sec  8.50 MBytes  71.4 Mbits/sec    0    165 KBytes
[  5]   2.00-3.00   sec  8.25 MBytes  69.2 Mbits/sec    0    165 KBytes
[  5]   3.00-4.01   sec  8.50 MBytes  71.1 Mbits/sec    0    165 KBytes
[  5]   4.01-5.00   sec  8.38 MBytes  70.3 Mbits/sec    0    165 KBytes
[  5]   5.00-6.00   sec  8.50 MBytes  71.5 Mbits/sec    0    165 KBytes
[  5]   6.00-7.01   sec  8.62 MBytes  72.0 Mbits/sec    0    174 KBytes
[  5]   7.01-8.00   sec  8.62 MBytes  72.8 Mbits/sec    0    174 KBytes
[  5]   8.00-9.00   sec  8.62 MBytes  72.2 Mbits/sec    0    174 KBytes
[  5]   9.00-10.04  sec  8.62 MBytes  69.9 Mbits/sec    0    174 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.04  sec  84.6 MBytes  70.7 Mbits/sec    0 sender
[  5]   0.00-10.12  sec  84.8 MBytes  70.3 Mbits/sec receiveriperf Done.

$ ethtool -t eth0
...
The test extra info:
 1. MAC Loopback                 0
 2. MAC Loopback (diff. queues)  0
 3. PHY Loopback                 0
...

ELP side:
...
17:29:11.974973 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:12.975199 ARP, Request who-has ELP tell 192.168.5.100, length 46
17:29:12.975217 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:13.975022 ARP, Request who-has ELP tell 192.168.5.100, length 46
17:29:13.975035 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:14.974837 ARP, Request who-has ELP tell 192.168.5.100, length 46
17:29:14.974849 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:15.975026 ARP, Request who-has ELP tell 192.168.5.100, length 46
...

Accepted connection from 192.168.5.100, port 58932
[  5] local 192.168.5.1 port 5201 connected to 192.168.5.100 port 58936
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  7.12 MBytes  59.7 Mbits/sec
[  5]   1.00-2.00   sec  8.50 MBytes  71.3 Mbits/sec
[  5]   2.00-3.00   sec  8.50 MBytes  71.3 Mbits/sec
[  5]   3.00-4.00   sec  8.38 MBytes  70.3 Mbits/sec
[  5]   4.00-5.00   sec  8.50 MBytes  71.3 Mbits/sec
[  5]   5.00-6.00   sec  8.38 MBytes  70.3 Mbits/sec
[  5]   6.00-7.00   sec  8.62 MBytes  72.4 Mbits/sec
[  5]   7.00-8.00   sec  8.62 MBytes  72.3 Mbits/sec
[  5]   8.00-9.00   sec  8.62 MBytes  72.4 Mbits/sec
[  5]   9.00-10.00  sec  8.62 MBytes  72.4 Mbits/sec
[  5]  10.00-10.12  sec   896 KBytes  62.3 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.12  sec  84.8 MBytes  70.3 Mbits/sec receiver

DTS node example:
&ethernet_1g_tile {
  ...
  phy-mode = "rgmii-rxid";
  phy-handle = <&phy1>;
  ...

  mdio: mdio {
    phy1: ethernet-phy@1 {
      ...
      compatible = "ethernet-phy-id0008.011b";
      rx-internal-delay-ps = <1950>;
      ...
    };
  };
};

Thank you!

--
Best regards,
Artem Shimko

ChangeLog:
  v5 --> v6
    - Rename vendor prefix from dapu to dptel
    - Update DT binding filename to dptel,dap8211r.yaml
    - Add clarifying comments for hardware reset defaults in driver
    - Update rx-internal-delay-ps example in cover letter
  v4 --> v5
    - Add Guangdong Dapu to vendor-prefixes
    - Remov unimplemented features from Kconfig help text
    - Fix inconsistent handling of RGMII delay properties
    - Add hardware-specified initial delay values for RX (0) and TX (1)
  v3 --> v4
    - Drop dapu,tx-inverted-clk (vendor-specific property removed)
    - Fix driver behavior in relation to rgmii modes
    - Apply software reset before RGMII register writes
  v2 --> v3
    - Use phy_get_internal_delay() for delay validation and selection
    - Add poll timeout for reset using read_poll_timeout()
  v1 --> v2
    - Drop debugfs interface
    - Simplify RGMII delay reading logic using of_property_read_u32()
    - Fix missing newline at end of dapu,dap8211r.yaml (yamllint error)
    - Simplify delay property description in DT binding
    - Rename tx-inverted-clk to dapu,tx-inverted-clk (vendor prefix)
    - Replace enum with multipleOf + maximum for delay validation
    - Fix compatible string and tx-internal-delay-ps value in example
    - Remove rounding logic, return -EINVAL for unsupported delay values
    - Respect DT delay properties for all RGMII modes
    - Add polling for self-clearing reset bit instead of fixed sleep
    - Remove unused packet generator macros (DAP8211R_PKGC5 and related)


Artem Shimko (3):
  dt-bindings: vendor-prefixes: add Guangdong Dapu Telecom Co., Ltd.
  dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
  net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver

 .../bindings/net/dptel,dap8211r.yaml          |  62 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/net/phy/Kconfig                       |   9 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/dap8211r.c                    | 220 ++++++++++++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
 create mode 100644 drivers/net/phy/dap8211r.c

-- 
2.43.0

