Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EA35B632
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223212; cv=none; b=fM9w9rug7lyg8yBZpBf63DkHRpddQsIQisxNbZhr95nCGgtbDqFDWsLmJq1VFmvmIb9cwJLhARmfCUI91F0otepyGtihWmYQZ61SC6cXJV+5cYJSIhOyt4E6z1uzKx81j16xZz7lRZiPGZ1qTr9ArxBfqPoF6Ym3QdgepxMrjAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223212; c=relaxed/simple;
	bh=W3D0x1lfwDpQdeCF7MPZvqVSLMvd1HQezbnOejx3gZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YppoyF1DKTx1fFnXVsAvO3a6hB1r4dMHN6k4dSv5F95+inLs768dQajA7vc4OnH/UUUUFd9aqWqX9OsSCeZC6MLTTDUBnuNrefoS/F0KnbdAa0lQ8i5+EBW39Uuy398CqjzYIwA/FA2wKC5dU6MHfnmaGXr2tJZI41vBuAAHtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXKbREht; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXKbREht"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c19bad03so58046985e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223209; x=1784828009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XlCP9ujuR9NZBBVK1LgwxTqDNpIOuqus/+Z/8Qlhrtg=;
        b=XXKbREht0czqOO3SFl5vXlpQTdH2u41A/u3xZOsolM5dDUV3Vl7FMtdoS1cOmKSulo
         Xfl+OA47ktE2srsHynarPZkw/uQdcXJYvF/auoUYvfrFVSwAYW948gHuUAPGp2sdIa30
         GnAzZGz+GcGL3PliCXbrsFWkkW8OnhckNgQQSRSGRgzjrE4jMgLfsEFxbYDNb4aDhN7D
         dFGz26WNFgMQxeDo0hhzQyMCE2n02S0Sy8PlTtBJg4GSjFpZdfZzitWkSPnT2IBDIGQA
         DoNPpcsapm1rtebmVzF7FVFwqRRdjK+ppPYp5rzEkFX1kYL7lqALLKMI2SeM7ZVstKUY
         tLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223209; x=1784828009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XlCP9ujuR9NZBBVK1LgwxTqDNpIOuqus/+Z/8Qlhrtg=;
        b=Bca+q+HQv7jJQwmcTTu9W8mVr2PoG/PNPEBei558BCccdf7mS4yRYduJLiFZynrzwY
         8Sm+r3eonBQCVslrn3uNauOCDf5M3CnC/wCFLSSCngn0OkRQBHGFfpQR7jWGx7ZvDg9y
         5NdnzoX5cNPuCQzEbx902IHJ91WoeEXJH84XtE03DwSvrxhacGl/Kk7ZmFaq7Tgvqreg
         TvUYfHTn95IODFrT/6NBWJNYah2R/LoidmPZfQBUJUc7tQF/LQnMPWqUmGx5lwk4aR0c
         da/i9uq0Sf0Z8dwveJ0JMLs7M62fyaQvVHR+4dHIdJc7BhrThlMZzDxdzzakEq8IjOdT
         P5Dw==
X-Gm-Message-State: AOJu0YzEMj77JFH61yE/l+5rbnucu/6VXMFE06U9JK+qRGlmaTqUJtP8
	Bt+iRJp8yGCVhA+2FmA6dcvlu9rs8/ITn7c5dBIHQ1MKZcIT/MA+3z5mzmOXpw==
X-Gm-Gg: AfdE7cmSPYLiDXK+psd0sv7pxtTEDkWrKKZu4hVoOdEzxSbO3mvSdZZhRGD5NJFCZGD
	SmWsAgZkmD/Tk7qqLTN6GEuKXH5sDu4NiMasut0RkcdfCIJLhxpx0dv/ZSXwq/6GRS456rvG79m
	z3VN2hOFQMY9kJgGAxk49itdosMyuM1mD8dLEML+fXetTK+32uSRE+rSDC8eG0QfbvZC6A4IVyc
	YjcAf0pS1SVLZ6qDLrjuGVgpx7zQHBrRaYBzCyh0obD7X9UHDcMMw3XWlvl1yqhzrVFHWsE1h2T
	2+f14/MhTdLzt1IZi7x9Q+qqZTQ5HJ0/aM+B9YM0bftmMAm4QitQVevy48eIPsH1N3UmHwwhAQr
	ybLLwGpfJavGHP896Qzt22kCKlBsb7TafBfTtXUCX857x6kdpBJ+So/3bLNEi6ALHkVN3wUUieI
	v3NueePmmdFAh3+lHuJEjfu3TflfTIGg==
X-Received: by 2002:a05:600c:8b8c:b0:495:3f68:699b with SMTP id 5b1f17b1804b1-4953f6869f7mr74628045e9.9.1784223209162;
        Thu, 16 Jul 2026 10:33:29 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb0343sm71768905e9.10.2026.07.16.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:33:28 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] Add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Thu, 16 Jul 2026 20:33:23 +0300
Message-ID: <20260716173325.653164-1-a.shimko.dev@gmail.com>
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
Ethernet, IEEE 1588 SyncE, and an internal packet generator for
diagnostics.

The driver implements extended register access via indirect addressing
(registers 0x1E/0x1F) and provides comprehensive device tree support
for RGMII delay configuration. The rx-internal-delay-ps and
tx-internal-delay-ps properties allow precise tuning of clock delays
in 150 ps steps from 0 to 2250 ps. The optional dapu,tx-inverted-clk
flag enables 180-degree TX clock phase shift for boards where signal
integrity or MAC requirements necessitate clock inversion.

This PHY is used on the NDA platform with 1G Ethernet tile and has
been tested on that hardware with successful link establishment and
RGMII delay tuning.

Due to the specific PCB layout of the platform and FPGA configuration,
the default RGMII timing configuration was insufficient, causing packet
loss during normal operation. Tuning the TX/RX line delays and enabling
clock inversion restored proper signal timing, resulting in zero packet
loss and stable link performance.

$ make dt_binding_check DT_SCHEMA_FILES=dapu,dap8211r.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/dapu,dap8211r.example.dts
  DTC [C] Documentation/devicetree/bindings/net/dapu,dap8211r.example.dtb

grep -i "dap8211r" Documentation/devicetree/bindings/processed-schema.json
chema.json
    "http://devicetree.org/schemas/net/dapu,dap8211r.yaml": {
        "$filename": ".../devicetree/bindings/net/dapu,dap8211r.yaml",
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

$ Unfortunately, there is a dependence on the axibus speed here
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
      dapu,tx-inverted-clk;
      ...
    };
  };
};

--
Best regards,
Artem Shimko

ChangeLog:
  v3:
    - Use phy_get_internal_delay() for delay validation and selection
    - Add poll timeout for reset using read_poll_timeout()
  v2:
    - https://lore.kernel.org/all/20260716113805.593215-1-a.shimko.dev@gmail.com/T/#t
  v1:
    - https://lore.kernel.org/all/20260713131223.279555-1-a.shimko.dev@gmail.com/T/#t

Artem Shimko (2):
  dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
  net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver

 .../bindings/net/dapu,dap8211r.yaml           |  73 +++++++
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/dap8211r.c                    | 191 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
 create mode 100644 drivers/net/phy/dap8211r.c

-- 
2.43.0

