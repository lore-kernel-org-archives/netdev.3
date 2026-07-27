Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B440377AA2
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138812; cv=none; b=d5kLF/NLXYKvq0MnNHkf+ggOOHpWMCIBZTjUG2YfSFpnkyfMNsKaTbM28dzUhrZkuUPTp8voUFeJM9HBzTdcxoLuuGm4JNskwZlGWhBRmdM1mtuQUPB93G7Gh1Bz9pgAXRCyB0bdva6HTOEfoR6uoUIR4cy2oSCFKUh/0810qag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138812; c=relaxed/simple;
	bh=RwaSeM2o8U7Yz8AgPwYV2ZMuhpugkxYXZJ/7zGmXh2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szwGHFK+LJB+GqvAyy8UHSNNUFYir4wP4FCE00PFRxYD3HwJNYUlQr/bHIZw4QmNyM57kIbOv2H/7TLEwbLnzLzSTSLUzGkAniLdv8HXvze7Cur0zXsu0AHCndytHgybJe+pnmWinF/1ME/FYuJFSo0B0N9uSQqmSenT2QEKpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rbbrg+QQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbbrg+QQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1740c36c5cso321109566b.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785138808; x=1785743608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ex9WK7cMQbcLGyCbuvoOK8Ni/e4QYuUFvHwa+Upbhlk=;
        b=Rbbrg+QQBYZdPr7CUJYmZCdUKu6Q3xfGmY/f7zFSzbvyEcgQHwxaJZtM0Nidf/N2iy
         aQBOMkSEpLE5E3pGTIY5+uG6kBOI9mVosPv9U7Fetpho+YV2ABiyPvw5ibe8WdQ6/0f0
         h3MV+r3awp0EIqQnSFWSfESCT/waBr5wvm5RBAU5cIxMCVY6zNYUWEfl4cRWLVSt0yZ3
         l10PFg08v64HkmRJ04um+PLNhASJqczyruLhwUWHCB/tszHtn94dei1PuMc0lGaP75l8
         SCqLPxN5LJpQ+OY0bXedM0SVjCcCCPDppdZwKEO4Y+eDbiwrfldkHSMrt/o5oXQkaf17
         uV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138808; x=1785743608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ex9WK7cMQbcLGyCbuvoOK8Ni/e4QYuUFvHwa+Upbhlk=;
        b=JRkvCJmZed/PMG1aTTQywm/Js/kbwca91JHb8ctF6pkPGAVj+LrWxqChrKfd2R00IU
         z0b7mjRmyr73pXdcUhKqKvyZVmw29cA3fSg6JJpAYORJm94iRkq8HKjCjN4ZvFuqhw77
         HnWx1aZRkCpWfxJmcHusQigq1Q2CvdGjipam2bFlOObKtLGc1g83Gq2p4OWfhzlaW/3j
         oXwS0MtsqgU3uhGxj/yZSO+cpYJrXHOzJELiLOXoStMQg9NhsDeyDTStCCjxmqKLVdgp
         Mxn3l6JuutbkxL8/9Cb6vpCnb0aIGjH5qADNgcDx+zqO1nIEh4BkTLejH2YcL5Pz6uQS
         Ra9Q==
X-Gm-Message-State: AOJu0YzC6FMfskByRnhJJpminMer7Kkymokb6ne8P2c+SZ1of++ajo+h
	yoNIQTHH1s4+Fou6RCCVuS/xI+cNLWIP7Y4oi3RjCpxsvp0KtIBdvHvWWtJfcw==
X-Gm-Gg: AR+sD12UXo058zzGcFJZlF4lCaS42KtHIRFI8BQ/nLBiPbs/eE3YsjnX7RWXzb7Pd+T
	nJbQJLwXmK4V2mpSJ32zVPuKdyxghWm/lypeSrVwz4KhXChihr1TjWB/XSR2MEMHZan5JodWCCC
	T50u7IbS5oLC8JtQ8pfkNwKcfCnnYAqYs4QceB8Ab4y33/jkujbNyyh2HjlQd40N2M3OBU9WFAc
	4VRSASuBtZcBObV8xRLnOIlHoBXyGUuk9Lo1rBsZj2VItiC08iiWMlY2MsW4F6zwjoVTwZcGk7d
	EdgY69f3dV8RS9DdFLr9Z7AQPyS76kh3/Gb4Vd1d9pMB4ikrC6m81c/4vaYA7lBV7Ti5fdhiic4
	xYqjXaQKLxrl4DW1RBKBzdHEl/2eAlP2qIDWe4bzkEp+GdruU5bQk8sarGhpD8BDwtNtYX1JdOI
	Of/nuNs6agbao/2g==
X-Received: by 2002:a17:907:724e:b0:c15:c638:d03c with SMTP id a640c23a62f3a-c1f1f06b45dmr319380866b.47.1785138808192;
        Mon, 27 Jul 2026 00:53:28 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac0fa4sm596226866b.20.2026.07.27.00.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:53:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/2] Add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Mon, 27 Jul 2026 10:53:22 +0300
Message-ID: <20260727075324.3555446-1-a.shimko.dev@gmail.com>
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
  DTEX    Documentation/devicetree/bindings/net/dapu,dap8211r.example.dts
  DTC [C] Documentation/devicetree/bindings/net/dapu,dap8211r.example.dt

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

Artem Shimko (2):
  dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
  net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver

 .../bindings/net/dapu,dap8211r.yaml           |  63 ++++++
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/dap8211r.c                    | 206 ++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
 create mode 100644 drivers/net/phy/dap8211r.c

-- 
2.43.0

