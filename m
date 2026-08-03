Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8D35F5ED
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752262; cv=none; b=S8NHTDlLfRbe5nSRgOoM1FsmI/r8uMKmrBScba9U+GJ9KRgaWryaOBMGosMb4MHbuCdcohRbpNuXxdcNNe1Kg+QZa+HuYdWCGRaRlF3+NboussAFKqQiTJtAI1NmH70luaca1ZlJJHXkuDxlaT+uusrJy7LQ7KLOsj24EXd4fEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752262; c=relaxed/simple;
	bh=QqI+kY9NJduzINpwhK31HGnFtI3I3Saids1LBmH6kRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDitYeICUb+uDamuS5/TZamTrl0T3z9ulKpKf3A8mcA4wHOlizaUgsgxZEKA+xB8tD9ycXRaf9JNBqFgP8nefxMZegX04M7NjzTg7b4+YEbkH/zHvh4RaiZbTYRsjpLjRyz/3+btrHa3EEKjFHeeKS+2BGpzAENghXVODZt0Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds/ZcdE5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds/ZcdE5"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso4830469a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752258; x=1786357058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QdeGSvPwmqD9rgqqLStAVKBM/0iRIAZzVYz63yBB+LQ=;
        b=Ds/ZcdE5NGjtunMNaqI/9DsI0H92iYz30YHTibCoY8/R1l31x+QhQeJapkmZFQ74Tt
         yFH9K7jxwIc3HpV0C93vd1VNrlRMzjUYxBJJwRCccsp6qC2ti1hVP0fHQzTmpiRR9V+3
         tODfNfkbiUOBBCL1xJQb93ICTUQjKyBBoJVXKGSv03NXEx6FqntKtpFp0oQYm1vqDUh1
         7sjA+Xq8D6vzUL/U4Sh1vy3uL1M/ItD8wvtM6GZJDpAaIaVC/6IEl3kADgLNZWE8gbb7
         KkM3SDcKmUZ0AR2UjT0zhU/eNKRXEmtzKuZ1VF50bfYHH7HePTij3R3KDmFUlkufq4Fj
         UeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752258; x=1786357058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QdeGSvPwmqD9rgqqLStAVKBM/0iRIAZzVYz63yBB+LQ=;
        b=BqIMr8vDpW0M9/xJm4Exdv6H2IWW9m3y0UehlSTbuTJc3GLTTlD3UDprid1+iOoHAb
         keWsHVSXwTjvpxBbAK1lpP6iZCzdLwnzYQZhmuInxtvQfzPB+yrWRsySZ7iKsTS9K7nm
         jIjVI0isNLg4IPazBbgvQIzMt+7md+j1sVLGEgBxdBsI+bLzLD+VOL21+qXmnaNb95lD
         SsA+mgPbTOzcrZ+mxsCvca4pgY5spLgi5t1HIZN2RceNWfe0lySMHm8AzORwL5Tzc2ir
         tg7L1w0ZXwZbZ9u/5FOF8iCwmLBi+IIp1Sn4vVNpPJEh6xU791EgPGuBmnWFeKx2nraO
         23NA==
X-Gm-Message-State: AOJu0Yz1PWytFooHQBBOZj+DnKWi51lzNRTKMend5WKSZ3haUUwDPqgV
	9UWHrqaGOHpSaGtngqNdU6o6fi2G9vrKvgwfXMSuzEQz96atBnTvY4F2+WjXww==
X-Gm-Gg: AR+sD11mrfS0kN0rfDt5zU3yBYlmaNd2Wx+92ONcTFQTytp6So6KodSglwX7Dh2D4WT
	zTXGrzFI4XaAVr0qvnw7AHyLmUKYwAxOFlE8jZcyRvltOhiSP1cZVKt95VIn2dSlp4wimYYjPFe
	TAlTh1w6/DbUywa2U06UeXOPh5QhYKLgnoCfvjh3vMPf5FO3omRgVgCo+tIWrIYgUxW2pV9D5ej
	wEeCFSpSFboOaAMA1Z3fOcTpv/8XhMhgMB78hIGAv7bOcWB8rve4h9iF54B7gnbSNQEx1U0wjxK
	3MMsvYiPZZd4tcoGNLZc3Yt6IaGKdXYvXzw8EahoxzkGthpO6JLjZWRGRCyCCwz8FxwVD3+rqV8
	BN/rJOGBVjFkhozUtMavHYadgXemMGsuojn2qtlsD6gRnDKI6Cy5ygSIZbXRBpUgyhHALjfLWjc
	s0EP1l8BNawjexybPs+WQNwseJ9Jlpb9lQOKwDGkwSZI/qFqIxzRz/KgJMZ86Bsw==
X-Received: by 2002:a05:6402:5041:b0:69c:73ed:fe9b with SMTP id 4fb4d7f45d1cf-6a0a7c610e3mr6858314a12.1.1785752258005;
        Mon, 03 Aug 2026 03:17:38 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6566b3sm5355731a12.23.2026.08.03.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:17:37 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Mon,  3 Aug 2026 13:17:31 +0300
Message-ID: <20260803101734.270821-1-a.shimko.dev@gmail.com>
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

$ make dt_binding_check DT_SCHEMA_FILES=dapu,dap8211r.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/dapu,dap8211r.example.dts
  DTC [C] Documentation/devicetree/bindings/net/dapu,dap8211r.example.dtb
$ yamllint Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
$ grep -i "dap8211r" Documentation/devicetree/bindings/processed-schema.json
    "http://devicetree.org/schemas/net/dapu,dap8211r.yaml": {
        "$filename": "/home/a-shimko/patchwork/linux/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml",
        "$id": "http://devicetree.org/schemas/net/dapu,dap8211r.yaml#",
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
      rx-internal-delay-ps = <1050>;
      ...
    };
  };
};

--
Best regards,
Artem Shimko

ChangeLog:
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

 .../bindings/net/dapu,dap8211r.yaml           |  62 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/net/phy/Kconfig                       |   9 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/dap8211r.c                    | 206 ++++++++++++++++++
 5 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
 create mode 100644 drivers/net/phy/dap8211r.c

-- 
2.43.0

