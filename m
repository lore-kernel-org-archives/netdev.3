Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F83B9D8B
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946581; cv=none; b=i6hQPl9SSYg7CQI2NILq0TLpzHkt4122gg8MU1+8mAAI4V4fIyz3M4tLRGGL69R4pE+8wbSTgyx9qvn1/oKcwPeVgA5o8JhlwbKKhd/eOo8kn35dLzpnEoN5pILwVulrS0wvV+naG5to0xhTBUKeWj92+iR4u3Q5i5Ajh4uj6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946581; c=relaxed/simple;
	bh=xlvNzdBEDkNjZ4017cocaTCfcKs9/ceIgmy0m9FwRY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMPxynu8aZEfpefhxWacqnO/tfPjBekpd2W+a2BeahW5qnmAgytUxoBDDSxvvM+BItb4Xk0ElgrdV3azVlZF76RUn6xZWQviOAD28ETWxSrtftxo8aUNHvWmmWkfGO4bmt1oePk6sgdktOinbXarOCMOrJgsD8w6KHQ55kNdRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=YAtnaBc3; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="YAtnaBc3"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15168a20b47so2349097c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946579; x=1792551379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eOt/1BdDYxiMzENqA6TOzLT/rpB6ssuySkd04haqJTY=;
        b=YAtnaBc3Vm3KfG/62r7tE+qpsXEnCF7hvvHeicYJh6Lx7ADnU9Z7sxScRtY3vsNR0Q
         Z9lTZFs+EhUcYo4EHeUMiCu55eBnZ+B3GDA1mWHhe9FpA4LBubsZvcaLneJi34TuBEdN
         f8c3upHfsyoqrebEAPZOb7388SYf3LoKsJQbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946579; x=1792551379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eOt/1BdDYxiMzENqA6TOzLT/rpB6ssuySkd04haqJTY=;
        b=iG1Yfz9a7dJpTxKkRKjwtCIn7+sEoQHnqQXBnwoXNz7PdXSPo9yLSyYW7jI+BwJ8TU
         nhlzoLuSO6Vtx2qy5TnXY1h/H5cneMXsV3f4ZCZR2WJD/f1HqfSa0aFoXum7QESgUHPp
         y5A41Ew4ZFvXVkG+TJj4AZlNzsBmbBdoYG77lMHrXVbv8WyVYz1PDPNbFMv6AzznRytg
         2aOiwTq43Q9eG73oLUF/2yfiL5yPAHt74vvCAbDWXxNIX86/o4KRx8M+4U3d0f595H2a
         HqMSJekTm6m8XsqE2X+yALr1C5LeEKClywL+KSFfJmr89iWKtkeXeo9XAyz4L+04re4H
         wKqA==
X-Forwarded-Encrypted: i=1; AKwUvBzaKMG9YnR7a2wTr8CYna3PvuPL2K1T02/ScRplMnq8UjnEI2EuK/X9NDXshokuZd5/In1xDtI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpfjn+/fOjD0s2JDZ6NWC4urz7I+3AzzR4hFY3ST6MrxFt8ZG+
	hgUx9IaHd3PWtcc4hA7vvAgMDUy+94nzCGTyuuXqqSUIXbKlErcKpZy2fghdxiFsNhk=
X-Gm-Gg: AYBFou2nXuNeMobqxdouSaIJ8IYqXHkR88l6wf5wZebq5wZv7illqsd2RbbgpVKV5Tz
	Hi8m1FbvXLyylMH1lhc3O/4CIVLMAjZE0fvYXIZV99X1SkIuoEtn94Lp/OWa3msFMh5U991DbNO
	ME4L/2Mqux5k6SHxbu4orbvOgXKZBz10Z1bACncvM2qwRTHbrUlOX9MOEINNXJ3mPIx1jG47QVI
	FFnn/haSn76hhtLHvIgDEHGsbWBu8a/KgTQuRpYKYwdwJ/RIvVipbOf8srov5wYRwHYdMZXgT/b
	5XQSpJVBdAkIbNJ3Swssx5Zf1CpT45aYv3WD0yHOMg4ZoUEoCMH+TwYmlCNJgJippHPVb/LwwUa
	o5usRaIGiCWTsdX19a5MHVt3GnD4m0ISlz8dRjmFmVzGdFG0DJG5Ur/q4aca3fbqMU55L2gWb0k
	TqnAk2sq+8gD8r61aevKK1c4RRhfBbdmuoM0djuyYxx10AU/zXZBYOhJjTDUOzqb7dZrSXcAc5c
	ouD6lE6AcgdAZyKkPowVMpB1Wsrjy5979CT9g==
X-Received: by 2002:a05:7022:7e0e:b0:143:72b1:9004 with SMTP id a92af1059eb24-16a61d5c336mr20362920c88.45.1791946578956;
        Tue, 13 Oct 2026 19:56:18 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-17dc865cbffsm2122640c88.6.2026.10.13.19.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:56:18 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: usb: lan78xx: reject short register and statistics reads
Date: Wed, 14 Oct 2026 10:56:02 +0800
Message-ID: <20261014025602.26334-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
References: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_read_reg() and lan78xx_read_stats() read from the device into
a freshly kmalloc()ed buffer, but only treat a negative return value
from usb_control_msg() as an error. A device that answers with fewer
bytes than requested leaves part or all of the buffer uninitialized,
and those bytes are then used as the register value or the counters.

With an emulated device on a kernel booted with init_on_alloc=0:

- A zero-length reply to the statistics request makes ethtool -S, which
  needs no privileges, report the stale contents of the kmalloc-192
  buffer. One counter pair read back as 0xffffffff8a427800, the
  address of usb_api_blocking_completion(), next to several direct
  map pointers.

- A zero-length reply to the RX_ADDRL/RX_ADDRH reads in
  lan78xx_init_mac_address() turns uninitialized heap memory into the
  MAC address (12:85:1f:dc:2e:bd and e6:93:44:41:9b:9f on two probes),
  which is then written back to the device in RX_ADDRL/RX_ADDRH and
  MAF_LO(0)/MAF_HI(0).

Treat a short transfer as -EIO in both helpers. With this change the
same device fails to probe with -EIO, and with only the statistics
reply cut short all counters stay zero.

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/lan78xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb8204371f5c..e6be066349de 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -612,6 +612,9 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 			      USB_VENDOR_REQUEST_READ_REGISTER,
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, index, buf, 4, USB_CTRL_GET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*buf))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		le32_to_cpus(buf);
 		*data = *buf;
@@ -695,6 +698,9 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      (void *)stats,
 			      sizeof(*stats),
 			      USB_CTRL_SET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*stats))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-- 
2.43.0

