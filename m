Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308607;
	b=f/l8MxLyck7c96OvHYT8UuP5fSHLYl5++DNmqEPsAj+x0om+e9of3VhOxzuD1AhlYEJJ
	 hK5vbIuMcPIK8Xy+OniMRlXpsOj47z7huOK124t327dbS3stVagx0Tn/tA2cgjOZxstRu
	 Xv2C16Z5YbOODz95xNwPujUafr+v55I+ezawZaOfxyAlSJY3QzVzr01s+1mi7hJrs22N9
	 XF3Z7k6y+LWqcd96o0sO68yiAl9DzGz5fD9aOBesInQqv66xoVwlbQXf9BSH/c0h7F3U0
	 yg3BKbEr4DrgXjJRnnSBu472/BT17WnldNNJ5C/1PMsam39tCvjWF/edbjlrFdMpGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308607;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=XcVbxki1OSdrt6E+6hFIYJvqQHCNUIOiEZn4LQ0BcbM=;
	b=4shV/e2IAZ6Vh4e1OeGTeqFaAhUWBeIvb4x5yPZIIvBXKALgUHldL756vkZ6zLs1Bd6x
	 u+pyOCRfrvD135CsDoonIFr60yAOmQKg6TQdc6HqTNwTEmUUUCVbKkq7e4GrvQOnPMnJH
	 9IfqIOnJI4scOx9GcEuFN1f8VnKULuX2iFCC3mY0aiUq0eC+EbK/wZ7whkk0PQUsvYZY5
	 zgikYRaBaOvS5tKxS2qiTC6VJ2I5RdZhJNFJIYM5BXDqP1Va6rTk6YILlB9S4zhsqGhgo
	 iy/MWpQzfTJbH0VZx9hQq3/pZOq0hd0Tfz6ez5lHb2G/meBPetJ5keDBDCBbZh62Z4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NPNKWNrG;
	arc=none smtp.remote-ip=209.85.210.227
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D360A3806
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1D360A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NPNKWNrG
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-8a01cac8733so2050526b3a.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308607; x=1793913407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XcVbxki1OSdrt6E+6hFIYJvqQHCNUIOiEZn4LQ0BcbM=;
        b=z3U30C6VntVoHVl48qOPMfPRVxr5PFmkYTNY64PTexysaplWv7qsCyF+BPGXUUWz18
         8O/MG9dhmO1Zw3ad+LmER3WRuFYTmSUJIE8NSY0Mn3QY/ncFjIt7NnBX4YuJeEqLs5Fo
         AF5KcK6twgbPbCGKAnIIAA2kGbMt+yitbIw87wHbf1r4RDt4RDazlivtJwH219Esqauk
         x326wOEvhhRSbptJMwRPsUMCGRvbZ6+JOvQ+r0Z+4wmKRbV9nIgTo24PnUVz37CCnCkp
         pEfQiHJe4lG5px1+2Wp3RW0b4EqF/Fic9E0nsFuZzvBWJeY/uCoeL3QxVNXFYH3XijA0
         81FA==
X-Gm-Message-State: AFq9FYJiQ6GMQR3LNt9hJM4Qr+F6OPPwlt4qAxs29iC/wfCn4dvZh6o5
	wtzZjY05Fzr6KS5LuHeMArckk0YaRET+9qMK6Q4i3bIdK+CdoSY796I1HfV35TMhlzmyprSZ1iW
	zpIdQAFDChOZsOTNNu4IAvKKcoiKeifhay9m1RpGtouJj9sxcNvNHY1vGsNmJqznhSO6diRVCRG
	js/PQ7QpMU80WZljZXYm03ioSOAmRIkjeL+dHwdRosG+ZuI/qQ3i5iRHqpmc0avWpW7RrikMxej
	vck5tZT8+4S0Xu9kc0=
X-Gm-Gg: AYBFou0IeaerDYViVyK3zKkCMKCT3dwtX9ZqiJvRJ8u4XH2t56MFMiPYJg4FiwX5Hpy
	asjV10F8LMVI/BWTSimi+TqBL/5lzO71imP1oKurxUk9MSlZQIcZdb77aiGRYAAQ67izj1gtcnQ
	jz/0sRvtqU/sUIa9KGSlDZYD2wHscrUuECteTWjbGjO/GGfSZRRUopkpuAZMK+NnnI45u1INW0U
	IETUxkSmukwoYjBoWuRenuCHLA++QkJwKQ7oMWgkHcrLvEHczqCdrwfnCSSprJO/QnczQlcR5TE
	1t66zy7CCNNyflw236sKpKbsBESwKB2UUsioOctIAy1ErQUmGppijsieQIN0qDbLhuiMviqZ9E9
	jotqbseLgK0XSSAvrs3GeWPhKEYmAYoC9y0A0Hm6siqmwgRPbNmJf2AkX8/xNxKli20uCdWwC5o
	6TW5ISNJfKDa1wG6+IvUBTRfC9Qt6pJOcODYzOJpXr
X-Received: by 2002:a05:6a00:288c:b0:89e:9c7e:fd5e with SMTP id d2e1a72fcca58-8a9bd1facdbmr267457b3a.9.1793308606580;
        Thu, 29 Oct 2026 14:16:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8a990954daesm30611b3a.19.2026.10.29.14.16.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:16:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b937ecbb4so1523636d6.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793308604; x=1793913404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcVbxki1OSdrt6E+6hFIYJvqQHCNUIOiEZn4LQ0BcbM=;
        b=NPNKWNrGzmTIkJnawvrQmx2RJp4gksjXTq42Es3+RCh8gTsfEHaRtsRsMu1JU8cp+M
         uoyWUoMzpnEVIhIYlFM+/Alfb//NZBRySEBYMUbHKB7sJFOLAHDNpTTHtDZ7BJXEZE5U
         uv7yO1NBBMbPZysKJfH+OhSY5qeBrPZnmX7ZA=
X-Received: by 2002:a05:6214:1bcb:b0:91c:7b6e:e3ca with SMTP id 6a1803df08f44-91ca4a14e08mr3938736d6.1.1793308604154;
        Thu, 29 Oct 2026 14:16:44 -0700 (PDT)
X-Received: by 2002:a05:6214:1bcb:b0:91c:7b6e:e3ca with SMTP id 6a1803df08f44-91ca4a14e08mr3938186d6.1.1793308603468;
        Thu, 29 Oct 2026 14:16:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314f888sm6326926d6.35.2026.10.29.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:16:42 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] Fix TCP retransmissions on NS/NSP SoCs
Date: Thu, 29 Oct 2026 14:15:38 -0700
Message-ID: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
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

Changes in v4:

- make the bgmac change scoped specifically to Northstar Plus,
  Hurricane2 also uses the compatible "brcm,nsp-amac" and so we need to
  determine the machine type instead

Changes in v3:

- correct commend in the second patch about what is being forced
  on the CPU port, it's not just flow control, it's also speed

Changes in v2:

- make it apply cleanly to net/main


Florian Fainelli (2):
  net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
  net: dsa: b53: restore the NSP IMP port 2 Gbps mode

 drivers/net/dsa/b53/b53_common.c               | 12 +++++++++---
 drivers/net/ethernet/broadcom/bgmac-platform.c |  3 ++-
 drivers/net/ethernet/broadcom/bgmac.c          |  8 ++++++--
 3 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.53.0

