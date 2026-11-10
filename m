Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284654;
	b=oaoHvCyP46/Jd3kc4YTj7Ctqi04efWvlDih1gKBssceJjo8jSQ5byT6iShbIkv2aPxYN
	 rNR0uxMmLH8cgJm+i1a3NYqN5XlQ2x+q99C5xB3oXfQtFEwQ25LBnE5MziZyxycoTLIHY
	 kpgh8K6iQHZ5T7Pd8bYM+ZkC5JRfZfCIzws7iCOnglt/vEN250gcb6hBQh5g2SAK/Gzyo
	 EEwhSt4b3F9w62ZbwVFeoVgeSJ2oGhScmZC1gVWo/fNDBGOfCPHQQnso2fXjQfUVj+UMp
	 YLA9jcNcUo89n16priS7wP7xgSqi2tEaMrUaJcU3+BXB5B4NySgJtq50zOeNm9ZKaQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KtQ7MYeLVAuI+S3wrzryY9ksbyCrYV9o4wIQkIktrO4=;
	b=1t95CeaanszNeslLVQ2vnEPAg9PmJYfLSM5xkNKMV7ii4+ktNat+WQtswLfYjrXhceVw
	 hdjQSQ2wwycPGghoG/zaT6LsoifCXIhlKWTr7prGtV++B4aPURcE26MsEXPkCC0S2+aiY
	 CSb/SJP9ZmJuv/R2f6Lb9Forz7YX9ajIIJkj6UvWttiHocsRkwbhnuOuhoEK7NRTMhxmB
	 d4CECQ+KmgnvG3kV4UJs/1XtETn71i2touXNoNYAZZQkAiS++VxAod+tB5FK6Q9xGV4jS
	 mmfSwka6MPFyIMPoUbDWc1awe7BuCWygRj7MpMkQDu67uKHiqJpbJsYsd5M0quVVWMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h9I8bgys;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641E606A33E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6641E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h9I8bgys
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2680085eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1794284652; x=1794889452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtQ7MYeLVAuI+S3wrzryY9ksbyCrYV9o4wIQkIktrO4=;
        b=h9I8bgysoRZzEi6t8lGPtPIabGW/3UTAJ0n/QkNhXiqoivFsAFS1YplzBF1jBvdUyx
         zPoGIa+DiMCVE5K8EOZiy3O10CLCiKvZFZhrxoxfPRQcgTTsZG8zOn/miUQf3pDAYlYQ
         fWies2/r+vXax4gGGrS/rRRBouQNbMDe6ZoEKOXdUA4zZzUEUQ5xLlVh6F2f804fKzWW
         kuBQhi8+J6dxpzeqwuZ7CNZIZA0UPEJkcjoY08+vJy3PcL7ZVtJhtP3y5FDWgYWyPJh6
         566ZqNJQwshB2u35fhs3OiJBUhxK2YHgO6VcqlWyIbVwacOPNt1dNFw19ueLdS5cTQ7V
         sWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284652; x=1794889452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtQ7MYeLVAuI+S3wrzryY9ksbyCrYV9o4wIQkIktrO4=;
        b=d6G9bItQRTRbQVPhPSNHLtT6b7AfWBk8wgA6VHgF+j2ETs69uj5F++fjCI/cVEjxHI
         XSYLgiPMyBsxgoBVnKXr1wKmTR57pXPPbB8o4Pxs5j0PcWy6sDwP0RUbBpE68JSr906O
         /lhWoL2vz8bRPqhwcjXyzJccYieSUVfwA+e19Qj/ygdaH08WVC5jYTGq2dVdgZED4cL8
         RfjeN8McnfyZphsSnVxBD4ndKdyFfKhcb1ScoEhkEV0wU+VP2WaZmSGN1xc8YSGqDsOu
         1BKgNIxu8YO+c4fJ0jsWhyBr4xB3nCKNrT4mk+gZnmidWq5N+ipDyhr+lEUdasb5FOoa
         Du7A==
X-Forwarded-Encrypted: i=1; AL+hErE4/XaJ+3xFxINLP7S7RSSWeq/QqWcez4GbxJgt2fz1qTZBZS+PjAiqjKZXYo/1iBGHx9ejjKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Eo2voVUXysnYbk7rcxmJpeSShkogK9qk11s+VKHQFHt2gSv71
	6wRojvhYqjobBev+QhkyHr+GXjcWZPXdwqWcuinuQNQaFVvBIePpRUqJHtPKPtD7Tz94sVj3vpZ
	ettN5tNyR
X-Gm-Gg: AYBFou16uqAfGd1zFtEaBR0JcJZcwV6qWWpOV5m44OlQpoHICGhGDZLH3g9S4rWjwP8
	sslPWBvfHsY1fn4TVUu27XITOmF9UsdAzGxOuqoHMR5IPSjx8/zhOYbZn9q9gsxnfFT7E+cNQ8U
	Nwa01lZrvHNrbb8KTeQzbIlzqi8JQ3sw3/FXsQ9zIBSQQwIXoKNYcOZGs0fsKmHLoHYPbRLcR5t
	kY45EcMe8MDzz/jW1uYR/qRJxXoCbzTkN80PT3wpaJj3Cx0QIFlJJUA7JSnaGl/3r8DtKMS2EDL
	HH6xrNEuUXzWDor82uyoN/xREwz7CSUtsgwp25rFaBUDoC/K+uLlxYPoTYYUtnpblPZAbd1HZXn
	1evSVh1qtCYxzZPWwlOy+gNyD0+fZ2GR4ij4csiHUorI3gbRe29NWa9kpLS+FJbY7LpSLinYcav
	cigEUd7kjTdwcwsYKeEid37csbHKKpvaUYkq/aGfujPnDI11aSRbozMIfUZwrrVkleyfw1lDOpQ
	T/XmwaRM7te+MS7hKBcxMq2ohfnVLyx2lyDctCDyDNBn3W1IVjHyWA00HBFtKUGUi4nTrMGE6Bc
	omF6CleSRUfR8khCajhvSMcFajMo4tAhJE1fZNr0AAGXGp0M90vtZtUp8GB1bhFDF8JckZqGDCg
	FNV2qs6/aEZ3jR1UP
X-Received: by 2002:a05:7300:fe43:b0:360:d4c5:7243 with SMTP id 5a478bee46e88-3751ee7bee3mr1721070eec.11.1794284652163;
        Mon, 09 Nov 2026 20:24:12 -0800 (PST)
Received: from cantal.lan ([58.136.75.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe32276sm3116950eec.8.2026.11.09.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:24:11 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Rahul Sharma <r-sharma3@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chintan Vankar <c-vankar@ti.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 0/3] net: ethernet: ti: am65-cpts: add PTP_SYS_OFFSET_PRECISE support
Date: Tue, 10 Nov 2026 11:24:00 +0700
Message-ID: <cover.1794284248.git.jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
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

This series adds PTP_SYS_OFFSET_PRECISE to the CPTS driver for TI K3
SoCs. This brings a similar hardware-supported level of precision to the
transfer of time from the PHC to the system clock as already exists for
the transfer of time into the PHC, whether over the network using
hardware timestamping of packets, or from a GNSS receiver using hardware
timestamping of its PPS signal.

The system counter of these SoCs, the Global Timebase Counter (GTC), can
export one of its bits on a push event output. The Time Sync Router can
route that output to a CPTS hardware timestamp input. The CPTS then
timestamps edges that fall at known counter values, so each timestamp
gives an exact pair of PHC time and system counter value. This is
similar to the PCIe PTM integration on these SoCs, where a selected bit
of the PTM timer drives a push input of the PCIe CPTS.

Patch 1 adds a syscon compatible for the GTC register frame that selects
the bit. Patch 2 adds a ti,gtc-push property to the CPTS binding, which
names that syscon and the CPTS input. Patch 3 implements getcrosststamp.

The series does not set up the Time Sync Router. Mainline has no binding
for it on the J722S, so for now a board overlay sets the route, as it
does for ti,pps. With Rahul Sharma's proposed binding for the router
[1], the CPTS node could select the route itself. ti,gtc-push would stay
the same.

Tested on a BeagleY-AI (AM67A / J722S), a BeagleBone AI-64 (TDA4VM /
J721E) and a BeaglePlay (AM625).

With this series, phc2sys steering the system clock from a free-running
PHC sees an offset that never varies by more than 1ns, whether idle or
under memory load. Since the PHC and the system counter run from the
same oscillator, this is the noise of PTP_SYS_OFFSET_PRECISE itself.
Without this series, phc2sys falls back to PTP_SYS_OFFSET_EXTENDED and
the offset has a standard deviation of 2.5 to 10ns when idle and 22 to
31ns under load, with excursions of up to 200ns.

When the PHC is disciplined (by ptp4l or ts2phc, to within 4 to 7ns rms
of its reference), the offset seen by phc2sys with this series has a
standard deviation of 2 to 5ns, whether idle or under memory load.
Without this series, it has a standard deviation of 5 to 12ns when idle
and 22 to 29ns under load, again with excursions of up to 200ns.

PTP_SYS_OFFSET_PRECISE has a fixed bias, the capture delay of the push
event through the Time Sync Router and the CPTS input (about 11ns, plus
an undocumented delay in the GTC), which did not measurably change under
any load or CPU clock. This series does not correct for this bias. The
driver similarly does not correct for timestamping delay on extts
inputs, nor for ingress/egress latency in hardware timestamping of
packets. It turns out that the bias in PTP_SYS_OFFSET_PRECISE and the
delay in extts timestamping largely cancel each other out. The offset of
PTP_SYS_OFFSET_EXTENDED relative to PTP_SYS_OFFSET_PRECISE is about
-50ns when idle, and moves by up to 40ns with memory load and by up to
60ns with CPU clock frequency.

The implementation was also stress tested by using ntpperf to load the
CPTS (-D 0 -M at 15,000/s and -N 0 at 5,000/s). No errors or wrong pairs
were seen.

To try it on a BeagleY-AI, apply this overlay:

	// SPDX-License-Identifier: GPL-2.0-only OR MIT
	/dts-v1/;
	/plugin/;

	&{/} {
		#address-cells = <2>;
		#size-cells = <2>;

		wkup_gtc: syscon@a80000 {
			compatible = "ti,am654-gtc", "syscon";
			reg = <0x0 0xa80000 0x0 0x400>;
		};
	};

	&cbass_main {
		#address-cells = <2>;
		#size-cells = <2>;

		timesync_router: pinctrl@a40000 {
			compatible = "pinctrl-single";
			reg = <0x0 0xa40000 0x0 0x400>;
			#pinctrl-cells = <1>;
			pinctrl-single,register-width = <32>;
			pinctrl-single,function-mask = <0x000107ff>;
			pinctrl-names = "default";
			pinctrl-0 = <&gtc_push_route>;

			gtc_push_route: gtc-push-route {
				/* input 11 (GTC push event) -> output 14 (CPTS HW5_TS_PUSH) */
				pinctrl-single,pins = <0x3c 0x1000b>;
			};
		};
	};

	&{/bus@f0000/ethernet@8000000/cpts@3d000} {
		ti,gtc-push = <&wkup_gtc 4>;
	};

I used an LLM coding assistant to help prepare this series.

[1] https://lore.kernel.org/all/20260828100615.1700223-1-r-sharma3@ti.com/

James Clark (3):
  dt-bindings: mfd: syscon: add ti,am654-gtc
  dt-bindings: net: ti,k3-am654-cpts: add ti,gtc-push
  net: ethernet: ti: am65-cpts: implement PTP_SYS_OFFSET_PRECISE

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../bindings/net/ti,k3-am654-cpts.yaml        |  17 ++
 drivers/net/ethernet/ti/am65-cpts.c           | 289 ++++++++++++++++++
 3 files changed, 307 insertions(+)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.56.0

