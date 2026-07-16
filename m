Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817E41B8EA
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201906; cv=none; b=PD/yEwxK41bT8q+1qIq1+m8IAia7J7zqpHNt65GbbtmBu59fA1vMUboaSBrUrpeVr3bM8wibDzjG78Cbs0T/3nGsQtfQYhIM6KU2HCxZRBVSHuFUHJTSbIyBVtCs3uy00jtVGKwGd8Wtu6QcupISup3UIF/oIeKdDFwp448DjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201906; c=relaxed/simple;
	bh=3UMLJAI4zwX+xrknDoWcjeW5Fe2Hf6s9W7u8AIIupAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWqWVK7PYaxFG/llJG4zAeu8/+01P/NA91ajcxWtZsEuDwGXeg+YHuGTXvQ7MSHTdVErhzUfOHdhlgW2YY++YH0qadVSmLsBHBDhYLPJcz5p0gjWbFtJu+6aK8HmH0WSPS4yCGtgA0RqthvS9NG/PX4mxaHt+3aS/cp/AgTsC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2nCF+G1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2nCF+G1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so44442905e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784201900; x=1784806700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEa5P/HyCPNQnlgLKXJFWDQu1oUmRVxgO3uBuivoKGM=;
        b=Q2nCF+G1UldggFdau2wg2I9yNriVWi2ltdoE1qR9aBOwcxGYSVGKuqoEnHbM9gLfoR
         DM3/GbVVTIhOHT3zPREv+CFyRoeaSU8J+n1K/8IPFymlXeM4OCGj7oMB6rgaUoma7tOu
         /TimVI2C3vsO5dh99jrGrhQLuRf/yZ+0g3dBBI7R7nBeiEADxIbAViog5cmLjvMTb34h
         WofBMfRvd4WcqGraOECzBQeH3phJL4kwTfco+ZB6S5FXXP4ux5bsw1DImWdY42H70v8m
         45iSmcBrFi+5jsaZIEL+F5Iy5hy2gjn2H3vc83fWoE43CucWOrdvwrxXj6yCxgxVyquU
         Lz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784201900; x=1784806700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEa5P/HyCPNQnlgLKXJFWDQu1oUmRVxgO3uBuivoKGM=;
        b=PZa7lC3wNDjT/vEJebOcipWjIbmkpU9Ucs8RFPCqkCzHjFsV7JPXkOoz2fqTrjqzW/
         lsSXsppcKnzhju75AV5umbTXpSYKvF7qrPk3nsTEEp0wr0NOhHR7ZpbU4YzMMgsLt+4Y
         sa0sgfG3iVBps0QA3WwRZdiurbdU7FqR3leKZVEqLccT2tOzy9zsbY+p115czkSBbTi4
         /3ashieQx9y9vMEZZLHaQ8dPMF1iDwUJltxTb/pCjm3CrlcH4vb4UdOZxFJNjIru/2I/
         b3uVa/jX9RH2D0DTuc7jomTXSwfOSluli3EN5e2aUp5q/ELDIDRSC+U+BYbRyCmii2AQ
         fUkQ==
X-Gm-Message-State: AOJu0YxtSWYlDcAwJv+LkjNKD/44B2lSjuoV07TulNAMVobGdLEB3kj+
	7l73aGaEu2jaOF319BTQADUzISxSpAcaXxlrGJGSZ16uCCHZ6E5VInwYKR6TvQ==
X-Gm-Gg: AfdE7cmd11ZPfCy9qFrD9y8eI6oBSnPJ8nyJW8kXqJBd8hkSdM9DBSpB+bT7lJEEzaA
	7LRZ2dbztt4FjBmudN4uFCxxiN4qQaHUrGYVybThVavbd29CwUsrBGCVLnlnptj6q/Brw28vS1v
	ygEHNm/0KsmiLF2iRwmuYQy6PWNxFAhAwvtJnhjA+s7IgAxdsaGjhWvC4MKDg8z/l4DwTlOWugH
	3PHWo+CzqRxaVHvJtN68gjRmvjeYjunNjxNi2ui1mEKWJBG67ph1/2tHP9L6GqH8z/mQtt4lJLW
	OWLFJLpi0Cbu6rrN9EE4yFTInnjeA1gHmqxRDs4G95DtEHNq2M2pv39CQEA2/K5ENQr7WEuwDYR
	EYklVmPBOKBWpfqrzd8OUAUTJI1rHbwhutDDovfT2o5XxVaGnj6aTMyxODQZDJeg36mx+lBbtNX
	GxhbDEzfuBBXwPh7HNtl0=
X-Received: by 2002:a05:600c:5292:b0:495:40aa:d982 with SMTP id 5b1f17b1804b1-49540aad9a1mr36326985e9.6.1784201900203;
        Thu, 16 Jul 2026 04:38:20 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83bcbsm49217165e9.4.2026.07.16.04.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:38:19 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 0/2] Add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Thu, 16 Jul 2026 14:38:02 +0300
Message-ID: <20260716113805.593215-1-a.shimko.dev@gmail.com>
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
  v2:
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
  v1:
    - https://lore.kernel.org/all/20260713131223.279555-1-a.shimko.dev@gmail.com/T/#t

Artem Shimko (2):
  dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
  net: phy: add DAPU Telecom DAP8210R(I) Gigabit Ethernet PHY driver

 .../bindings/net/dapu,dap8211r.yaml           |  73 +++++
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/dap8211r.c                    | 281 ++++++++++++++++++
 4 files changed, 365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
 create mode 100644 drivers/net/phy/dap8211r.c

-- 
2.43.0

