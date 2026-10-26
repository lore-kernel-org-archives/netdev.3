Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048832;
	b=aje8CViYz1mf9AD0ECpCAWjVaP9FvgamjKPJ2Zbxt1QMGrDIcDGL72+v0sX5yHBcKjTW
	 Cq73UuQh5ZiGSo58NTMB9kLoXVyzaLm0KQSTIsZswJHloKJF3F1lMGsGVxkBkipqa6MCg
	 rHu1EQiMjcLeLWo+LHODrp3SDGR4JeagE95okMli/Z8viqCYR36ZlzY25+mzURPquSZ+c
	 sf+u2sT+i3pf0pyCK2CPH5t4AcU9Kw94iPH8eS8RomfZs7Nv3A5c0LRk9A53//8Ah+FO6
	 AQbMe9Ro/IjzQaG0Qk7byGJV5uYfw6dQL9nG69VSDDe2VCcxxca5mfA937/zyJCbORg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048832;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=DC12OXR6B3T51NugMDFwf/bpu8Tt4YhOIMBqSWA+f5s=;
	b=UnXyNc5CD1RG1fIieStoWKNl831jtTKk0HbjWaRydq5Ua8vUm7+RThky2oNvBNVmThcE
	 IarKhynP0N1BD3gpMksr8G53QrYGfJc8LYO0qpXx52Axyr5mQnVeWeTssJoNWv+qiXyew
	 3oU/9H97yHXwYOA+Ng9sSAZDfpOB+ZyqgixZ9Fyxc9W/W3Jm9pwi0j1Y5lDp3TnSWX29K
	 TjMhlDpypI9KgJ4tFoUWDAwog7jB5KvQgx7EYmW6HnQnGtUDcyKNxsiItwgBdMXAPi+fV
	 yPfrZpgKg71yJwSM/9D0C2zwgWl7kZtbb/OhzQNfCmAv9DBAeNKA+ElHh71aXLXnXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Umw/h/ch";
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984D606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7984D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Umw/h/ch
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e8fe8e343fso20265705ad.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048832; x=1793653632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DC12OXR6B3T51NugMDFwf/bpu8Tt4YhOIMBqSWA+f5s=;
        b=GLV+VxFMJMJsLwmNi/TGOEeW5F3vcb1FzLE0ilDTn3NfGgJKeiFNWmfNwCmrTicWSC
         I9tqAIBgW0QaKmt7DEvMXYiN3lu2tndXQVVcI4j8tpNucX5il+v5xLZ6NRENHi7H1JrT
         NrLFoGwx2XemgudwxaPWqe5ajAdgCOsABy51gesQoEUyWLJw2/AIE0b9HQ3FFw0eq946
         dmn64mnj7sMZPlCAazOhLcNyuoVQImqDm1QHvdEDrlcfaKr0xP8yby/oKU4j7XHtQ5le
         OyJUkNSr0G79SHthdtAtdIpJI6mL4SjAeC9HEIma1sKpSHrgjlsOgczaacpvecYdow2F
         /jBA==
X-Gm-Message-State: AFq9FYIZ/7vL8eXFy5VtqOzB09SPDOza/daeCUA/Tam/L9WqpSXykoHc
	YzPIV83J+A71M8jCGnhWbQZJEcYo3qVT19xhtoxBOEaOiFg5TWsaJzgz1yw0QISkhNEu8ocwJrL
	w3OIRibf3B8GgmciDnkDqlkBCIG9uusE/zS2Ih1CtJwLhecs9e719ZTLj/Ps/E/93Cygfv5SPPw
	0Sm5aWihedjxiGctOWwOqFBw0P1WG95czkru1X865B6NY2WEXvb/E8teGA4gkf0QZJQe9q1XXnZ
	jX9dtQhkr4IOMd5KCU=
X-Gm-Gg: AYBFou175uWVtKjyN15hjmspRluOf38LJgXs20AZujr1QGwoYkDCn5GvRffPlXFA9ll
	SNmW0P7WfO/DNTcP/jEMcq+bXkgzVu075A1GMQQmNqL9HFei8iiPCvqalOdFI0jROh5yUMr4zCn
	TQM2Oig3CGPdlAsmZaLnTm0UfBkP7xC/pjQbRypkIx9E2zMlRB+Q4JD9nM3WGU8CykSIOVPEfoo
	jix75VK4HcYs/Y0nMOw/0kP3wPE8ZzzbBMJFngqA368f6ABr0kxAvUJIH+dHvxmaOYQ8igw4pTk
	ibXh8fmRqOP2i8fSQLkwGFBaWdFZt/gX1SHzaGHV3Ih80kDD1hJiBGHS9qOA0a1KGO3c/erlaXe
	HgtTpfMLtJDtg3zj7vbNRC/kh+isUmQ0WF53mtTHQCFIAesRI7nkvRjWjTN/5cFw5m/9LutWiJH
	ULk/jijUAY27hYGZDgvPhMiTLanyuP/7uexHGjus8B6+A=
X-Received: by 2002:a17:903:1a0f:b0:2dd:c0ff:e72b with SMTP id d9443c01a7336-2ea9c9197e2mr64295205ad.61.1793048831719;
        Mon, 26 Oct 2026 14:07:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eae6c3ff43sm136105ad.44.2026.10.26.14.07.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:07:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so24444805ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793048829; x=1793653629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DC12OXR6B3T51NugMDFwf/bpu8Tt4YhOIMBqSWA+f5s=;
        b=Umw/h/ch4ahM/7QdeTNI6Qj7VGq1vbCSRbUOp4x2wtlAT4X5a2Y2Aa7JkpJqrk4Apm
         v0/muilirFQZfzfwUDgee1Cr2SPLt26NLJpdeUcn5qUXWuYCU+h7znUMIwktn3zqrMho
         pQPLvZOBEGTS058D5O1j2tUFayUq0upNYunWc=
X-Received: by 2002:a17:903:1a0f:b0:2dd:c0ff:e72b with SMTP id d9443c01a7336-2ea9c9197e2mr64294245ad.61.1793048828895;
        Mon, 26 Oct 2026 14:07:08 -0700 (PDT)
X-Received: by 2002:a17:903:1a0f:b0:2dd:c0ff:e72b with SMTP id d9443c01a7336-2ea9c9197e2mr64293975ad.61.1793048828375;
        Mon, 26 Oct 2026 14:07:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce5d92sm808245ad.75.2026.10.26.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:07:06 -0700 (PDT)
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
	Jon Mason <jon.mason@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 0/2] Fix TCP retransmissions on NS/NSP SoCs
Date: Mon, 26 Oct 2026 13:37:40 -0700
Message-ID: <20261026203742.3198673-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v3:

- correct commend in the second patch about what is being forced
  on the CPU port, it's not just flow control, it's also speed

Changes in v2:

- make it apply cleanly to net/main

Florian Fainelli (2):
  net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
  net: dsa: b53: restore the NSP IMP port 2 Gbps mode

 drivers/net/dsa/b53/b53_common.c      | 12 +++++++++---
 drivers/net/ethernet/broadcom/bgmac.c |  8 ++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.53.0

