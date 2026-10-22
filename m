Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703475;
	b=H18AjA6QFPKEJtJFbOByj0t0RdFutSSLHq4xIigDMrfQs350NyosVPV5Bhkt2EtLXvyO
	 edcP/qtFtI3WprBUhYbEnQWllvgIlYsjfNnggbNN5ZgdCk9UKGmIfrQm4Vo429N3cBt0K
	 1dhCbW+2/xbHIbR7S4k0yiTSyjIEe6vjpCVEmhsNM6IJznoD6z2KTo1kRfQ8a79gg9jpR
	 i+AyzfDvuVY2jEjSRExxLu3e6P2yODymHI+A1bLbG0dkKEM0uCcIMvFg8ThL0MR/mYmZI
	 oBubsKSlOC0L66FOw/EP7xpvLjTcbhM9sygxLC/xOSFmhZU2rCwE55CaJtIiUw4p0Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703475;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=BvPfE15rcDGb+/5gSevpWOZiRKwhynGG1M3ty0d/vIk=;
	b=ttrqJSmNgzLufow2FQLR5QRFINpgCqlrowRaoQ51gzmhtEhrMWtxqkGLjEgn85A7jAnJ
	 Q8QpLWYnVS4ZAtKbb1FNaEMerlpQHcbCBOnLrsrnTeTywNfua+RdMyhYDnnFBWfxNBnoM
	 jElRyTXN5D3NhB414xADlmAV1VcfLyPYCGb/USb6RzPIelbxO62sfUpTReo6/tYfgvLgW
	 UHfR0EEXqb8dZ9iYsE4q3BaiTYYX4qY4Zu7ZhvVtDst3irLGxqy0atnikDe2mvrNaZJ9G
	 b6wbTi9pUfvRqqrbYeKlHKWs0UODAPkunVIPytPP5t9xSJEjd4XTLZr6IEyf34nqeFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VDoF0zFd;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C646606A325
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C646606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VDoF0zFd
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93f2f2edb19so20916785a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703474; x=1793308274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BvPfE15rcDGb+/5gSevpWOZiRKwhynGG1M3ty0d/vIk=;
        b=X81IXLtMPd7k+xe42cJnjrSgnF/ZCNsCwSnBs/DJYG1CA0BdD/ImPsgcZ1rf01T4gK
         fICAhSicSU/GjnoRTuQmy5Gp1IstrWCiS2CHSyygqIH4wDygHwotsxXE/41dEgNk8hMT
         cWSyU1eNMfRSxEGEV2/5Q+QxDaoGi7UOukBdlKeRLL7eiffpnJjaAlhTDpeQ9VCgkZRt
         Z15DUue4TJyvf+hIM6hr6fslsXv6pInHxv+cc+H55j5AI2T3xflPNq0/kKJkEsI9ZqKS
         UHwFyArHHaaavSIksfNKWpI21rMW85O5xiCNSSQM7J9spIAwRXeNAHV3MZQBtKt5gpIe
         IArQ==
X-Gm-Message-State: AFq9FYJkLKTyqIrYco9HiZx4vj3BEFyyWDzFX4f7uvy7IW+3gminZ+fD
	5uXdERW+qvNQRQMx6QrGQ9Qg2igfHqXXIgN/j6APTvjH8w8RNGQrnHyoOBDIyOhG+c/5gSUAIT/
	MnvyHhpgiqjyKL9ykdAqWl/jEthPTwMFRbxjbDd6QsKQr1oSePMtPuU6W+MIb/6cuVqtE9mD2r8
	F7WORW4GBloWbfpYUtmb/w3kn+JjRYFMiBG2lNg/LRgvRIo3+e1gFw6bwT/8xZWPZr4ixy1tTyw
	fGNRhBt7YJRPE9d
X-Gm-Gg: AYBFou2hOBS/1okIm10n01+FDCybbygerR6WI9gLfKIL04MmosiT6AubSIHneVDtv0U
	yT3f2H2tLzVrBFPCEwZC2tkLtTJIfXgRyZ8wbSNNDn97W77srvuc5RqGZsV0yjUXTaKylQgbR6X
	GW1/7sKi1eIdmF14U0ICyBcYxrWcws5XEMZFtY4KyDoFgdTH3kexgyk2s++3PwgHlYjk1I2VZqT
	jhOVRkWtmMMLZJm5JBR6y41CDPDhV3s8qRypsAWuCDmdzCXgjIrvv7wTPU3h/lcx+yVbXKK0nPo
	/QUU3szz31TZEo21ASp8r28msT/5Wl0yjdPHlIlMBp55+VpPs3lF/Swd7xTmY6h++23LAVabcIX
	Mw0NcQbvA719ygeeiJciTs0/d2KEDrS1sqIDfoNnIOcomZaFwZ9AgfurqNBKflf62bh6UAVaQiV
	LOvK2BoUsn6MFPEFgGWkNeT9gw4T0ZxreWeSR929ec
X-Received: by 2002:a05:620a:4689:b0:93f:1d71:41d5 with SMTP id af79cd13be357-93f6f827a8fmr122156185a.52.1792703474199;
        Thu, 22 Oct 2026 14:11:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f70ece130sm2726785a.9.2026.10.22.14.11.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:11:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5337ed1ba44so3655241cf.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792703473; x=1793308273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BvPfE15rcDGb+/5gSevpWOZiRKwhynGG1M3ty0d/vIk=;
        b=VDoF0zFdmqPCE0mvbvziYeeqf46ghEsyCXY5xyAFs7Gks6lO+sZTRJ9n1s9q5pMF23
         NjbgH51xmyPEEL5EctyrvcRsQwKD57wnju4czqidQry221gBmlJBDHFiP9yuq+/j8e/3
         9b1Au5WPIQCaCe7y3OCRVlL2dznL3DXth3Mbs=
X-Received: by 2002:a05:622a:2307:b0:536:6572:58dc with SMTP id d75a77b69052e-536c284a964mr1645771cf.29.1792703472566;
        Thu, 22 Oct 2026 14:11:12 -0700 (PDT)
X-Received: by 2002:a05:622a:2307:b0:536:6572:58dc with SMTP id d75a77b69052e-536c284a964mr1645261cf.29.1792703472053;
        Thu, 22 Oct 2026 14:11:12 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396afa91sm2472036d6.11.2026.10.22.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:11:10 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 0/2] Fix TCP retransmissions on NS/NSP SoCs
Date: Thu, 22 Oct 2026 14:11:02 -0700
Message-Id: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Northstar and Northstar Plus SoCs we would see about 1000 TCP
retransmissions per second due to a rate mismatch between bgmac and b53,
make sure that we run at the same speed on both side to avoid dropping
packets on the floor.

This issue was found during testing on a Northstar Plus reference board
(BCM958625HR) while running iperf3 to a test machine and noticing
retranmsisions:

# iperf3 -c 192.168.3.1
Connecting to host 192.168.3.1, port 5201
[  4] local 192.168.3.204 port 49856 connected to 192.168.3.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec   111 MBytes   933 Mbits/sec  915   99.0 KBytes
[  4]   1.00-2.00   sec   111 MBytes   928 Mbits/sec  909    109 KBytes
[  4]   2.00-3.00   sec   110 MBytes   925 Mbits/sec  1097   99.0 KBytes
[  4]   3.00-4.00   sec   111 MBytes   928 Mbits/sec  814   58.0 KBytes
[  4]   4.00-5.00   sec   111 MBytes   930 Mbits/sec  1187    109 KBytes
[  4]   5.00-6.00   sec   110 MBytes   923 Mbits/sec  893   72.1 KBytes
[  4]   6.00-7.00   sec   111 MBytes   929 Mbits/sec  843   67.9 KBytes
[  4]   7.00-8.00   sec   111 MBytes   928 Mbits/sec  920   79.2 KBytes
[  4]   8.00-9.00   sec   111 MBytes   929 Mbits/sec  1109   66.5 KBytes
[  4]   9.00-10.00  sec   111 MBytes   930 Mbits/sec  1055   63.6 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.00  sec  1.09 GBytes   933 Mbits/sec  9742
sender
[  4]   0.00-10.01  sec  1.09 GBytes   933 Mbits/sec
receiver

Changes in v2:

- make it apply cleanly to net/main

Florian Fainelli (2):
  net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
  net: dsa: b53: restore the NSP IMP port 2 Gbps mode

 drivers/net/dsa/b53/b53_common.c      | 10 +++++++---
 drivers/net/ethernet/broadcom/bgmac.c |  8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1

