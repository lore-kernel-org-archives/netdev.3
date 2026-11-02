Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627487;
	b=ugLqP7RrZMac3DU/Koi3Ob30Yl/c7zlGVYqVvQTtm2iqWZcsEuqWl+PICqU7lAm3a92J
	 8zxxMnq7afYhRdmld/SIPH51RDeLs415BKvZCbbqIrTdRnwKOqQUNY6wPR6U56FP1TbEz
	 cwkHj5Q3z5veSyXNktFy03RfS0rGI7l15lGQDLAVWWC3Ru8RWbsMfTsjXGl4Vey9jxylp
	 nXXAWPZJT1AlaHnT+eBXj+BrgWchmCWUg0bQUpEsIzByQhMYT6OPZOC7oXLzKVOQI1JRs
	 fYJyirVRvQ31PVHW5wt7dvHS1pFvmdqiba9tpN4TZNL8F10S5bI24snrJRDL/DRDmew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V7IxO59ArXIiwcrOd75FJlIyl3lLgsqqiNSbmFCZcRk=;
	b=r3F5k3ndp8KxH3nzz1Tsl7glx6yL9sCU3FJHswbzisXKOSFyQkNaRK0iPghJQt8dmL5O
	 1Wq6L5IXNzElROf6+inbpbb+HwiH/4S7dmk8Ol5Z0q+0oFm664C+C2L0ILmArFgs2/IpB
	 S2dkBpdaoqyRDctCvYUWoViV99frC+ICNM8NpO3MLQtbZyTXQytMvaavHFHIF/DPH0bGg
	 alMROH476NG+IycveKhEsV9PzJxLWDlzCum7R1IN3FEBqRO7WlIk0ybNxsR0EbMHY+Snj
	 3edPJ7DzA+lkNvqvtgRScNhrgG0ZxeqpLENwpBUOrFcpAFXTziaDekY7nyl5q++0MVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=o2oofwhD;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5AE60A3802
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B5AE60A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=o2oofwhD
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2eb18f4da15so9866495ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793627485; x=1794232285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7IxO59ArXIiwcrOd75FJlIyl3lLgsqqiNSbmFCZcRk=;
        b=o2oofwhDazZcsQkohyy6kMltyJOm+xseWpmptwEVS5kWnk3e7ZWsDPU4lQvQiT9yQ7
         g5BoZu626nS6DpeiSTDIq/6Oaw3wjclQTYFKRcEiZPHcvwm0rJKTbzOv103e8NcRSi3d
         XoPtai2UsQLD/iS3fQfZXIjku4+Z2WLOm4M+juChFlq21jVdZMLjlyZGePpXzZ1kkDBr
         tHer4QDgALGIktFcBdm3xV6e4qllfKBXHmRQUnPBBk4gZ6g5vqWexRkUpC9/zyGtV+Mn
         EaG+whSOnTs2ZPZf5NMKEvkRjz+L1auN0YcmjIwEz71cJdp9n9bBDscdWfMN+yBfgs7f
         ZCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627485; x=1794232285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7IxO59ArXIiwcrOd75FJlIyl3lLgsqqiNSbmFCZcRk=;
        b=jeQ5yGlszSfUXaKHWZJfonQV4Fe4q5gLZzwXjm+HDjekVo5vw0Vj9jeXnzvuiid32B
         fMreGLQaKIJ/fBzPgyD1CsOzvngyUnOdtYhtVJsptxCMrIKUo9PTjbusPQ6ybOad6Cx6
         W2bIkeOoT2cGVolZRjj9I/zUlCAF0DA3G+FB/NDTx28tE/IkTPFzoVm1rTZpvrQ6DohT
         I2spOrKHCOvSYC3faK9YGq455FzckKlqqXSojK/jaGP+m387/hQ9vcHeDPiGAXHYtKrO
         SBEWE2iTAkC0KWxpVMXIg3O7+mT29jMt6jxueUayT7Nj+UtzyOzq32OV5t6TRCagsgC1
         o1nQ==
X-Forwarded-Encrypted: i=1; AKwUvByRPrbzgCZ3kgLoHenJaXDbeGZDfaiyUiqpuOu7XLme6U76njsfTvdDy/caP/S6P/8+H1f0qEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CCsTZfAlOkyPWuC7TcmfGWybj3RB9cOVDZbIOl7kklBVvFxvy
	T21Bu4KHhls0HUZlhaGoOOSKJHGArzV8YNzEeckI9E33+NoDer5WIjnuJf5Em4IUBw==
X-Gm-Gg: AYBFou1U4ADwEDQaD7XxGAzvANbAD2fYocoKHt383llYoId9Vxam5SNab/9VAWQ9VhU
	4QaRQAowOLESQDTe0O1GdIUcQBosvUWhauStxSbkJufwdHDspJhIvUYHjXZpLt0e8xUzyjpm65E
	2/aGYZzCknkZCNd/D5N4UVJumz3qdxfs8GMmz1RL6DwWY7ncSCUIJ0LxCQyP4EeKgV6ZO8drlzp
	Aee6EFt2KTu82TswSJv1PVT07XvaQlfBizNQpptiVc2YinGpnpf9/APTABoU/RQVxRXo/FueYwW
	VKLqMqWegHjvEMw8y5wQCpO7NhK+S+GustcfDlBJiWmIlnTIQ3eg4IfpNw6kHAKLsUMFCY2Xz/A
	5cgorLKSeAl74i63uWeE7EZVJL8xGgdcOEuQmj/9yYe1i4kiAlUXpRQ+sd+tfTx7jZtJ2Fhp83v
	Jd3s5HfaEu+wYlPw78nuuz8zWuJmhlIPLryUGNNuuEiJEe5FCOCQ6Fa3xVggW/dsvCGaeOJvKiR
	AdBs5jBBN5lsdknQ0dHnmqgWhOBtB0WpBktmPhlKVkXl3jDVzLYPCDfsMLz4NSjWciHR9rJjVNV
	FgRKdXfuoXORRiy9l4Rf+jmSKS1b5KyrTIRovQ+PanHO2l9pId6SULMX4XfvdPT5Vb28W/Npfd9
	FsQiT8ALxxS9c550nDw==
X-Received: by 2002:a17:903:2352:b0:2e9:4e83:1979 with SMTP id d9443c01a7336-2eb364b55d5mr86192615ad.32.1793627485430;
        Mon, 02 Nov 2026 05:51:25 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3928d821sm28049675ad.56.2026.11.02.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:51:24 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Chintan Vankar <c-vankar@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Vassilevski <oss@vassilevski.com>,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets
Date: Mon,  2 Nov 2026 20:51:17 +0700
Message-ID: <20261102135117.419539-1-jjc@jclark.com>
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

On a BeagleY-AI (J722S), ptp4l as a unicast master (unicast_listen) logs
"received DELAY_REQ without timestamp" for each unicast Delay_Req, and
its port goes to FAULTY after "timed out while polling for tx timestamp"
for the first unicast Sync.

am65_cpsw_nuss_hwtstamp_set() does not set the TS_UNI_EN bit (bit 24) of
the port's TS_CTL_LTYPE2 register. According to the TRM (J722S TRM
SPRUJB3D, 12.2.1.4.7.13.5.1 Ethernet Port Receive Event and
12.2.1.4.7.13.5.2 Ethernet Port Transmit Event), this bit must be set
for the port to timestamp PTP event messages over UDP sent to a unicast
address; without it, only messages sent to the PTP multicast addresses
selected by the TS_107 and TS_129 to TS_132 bits are timestamped. TI's
netcp_ethss driver for the Keystone 2 Ethernet switch, which has the
same timestamping registers, always sets TS_UNI_EN.

Set TS_UNI_EN along with the other bits. With this change, ptp4l in the
same setup gets timestamps for the unicast Delay_Req and Sync messages.

Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
Cc: stable@vger.kernel.org
Signed-off-by: James Clark <jjc@jclark.com>
---
This was discovered while using ntpperf -D/-N to evaluate PTP hardware
timestamping performance. The patch was generated by an LLM coding
assistant.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2551554add17..9ed6644fd0bd 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -128,6 +128,7 @@
 #define AM65_CPSW_PN_TS_CTL_LTYPE2_TS_319	BIT(21)
 #define AM65_CPSW_PN_TS_CTL_LTYPE2_TS_320	BIT(22)
 #define AM65_CPSW_PN_TS_CTL_LTYPE2_TS_TTL_NONZERO BIT(23)
+#define AM65_CPSW_PN_TS_CTL_LTYPE2_TS_UNI_EN	BIT(24)
 
 /* The PTP event messages - Sync, Delay_Req, Pdelay_Req, and Pdelay_Resp. */
 #define AM65_CPSW_TS_EVENT_MSG_TYPE_BITS (BIT(0) | BIT(1) | BIT(2) | BIT(3))
@@ -1857,7 +1858,8 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 			 AM65_CPSW_PN_TS_CTL_LTYPE2_TS_132 |
 			 AM65_CPSW_PN_TS_CTL_LTYPE2_TS_319 |
 			 AM65_CPSW_PN_TS_CTL_LTYPE2_TS_320 |
-			 AM65_CPSW_PN_TS_CTL_LTYPE2_TS_TTL_NONZERO;
+			 AM65_CPSW_PN_TS_CTL_LTYPE2_TS_TTL_NONZERO |
+			 AM65_CPSW_PN_TS_CTL_LTYPE2_TS_UNI_EN;
 
 	ts_ctrl = AM65_CPSW_TS_EVENT_MSG_TYPE_BITS <<
 		  AM65_CPSW_PN_TS_CTL_MSG_TYPE_EN_SHIFT;
-- 
2.56.0

