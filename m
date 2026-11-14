Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614407;
	b=GabNMr2rmMGx8ua6XLbi4n3KdSqo5SxpZTsKLmXw/2dhhTMGrZ8oeyEJPGwl1wegB25U
	 YGqRqajccN9OSWio6RBysqENZxTCEsOnFfoLtC7hLk2zFudgBFhYnn/Cy3XDuWhZHt9oD
	 UYjWFEGbbmpTyd9WvjP18Rw/oQHucetR9LBPMnsdxnN3PP20f7YRpWeVXj8Nl8k+JRlzY
	 Iylgf37TFXqky1TTAZl70pJ8YJiSZGzH8T/VdieooxVOiVSTFh9rqWIiShwcRzJF2/L6k
	 eJLyUWAG7g3UuPj6M/9lIUDIGrHhdBD/JbF0u5Kb+xQ7KE5CmJ4z65jRxwevR2bpHog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IGSul/JbY9ftJg8MsxdaD9RtU8ZYOBU8DTFoA5trNZ0=;
	b=arz3yqKqu6EQMtmt4tzjNDCPasb5yyu/TilcGv+JleReHWknfePNMwizzdeoaeJt19Kf
	 b6xvd+Ztc2Ql0/HM5Nf1xEAnyCyxcJmR6BUhHprRmiMFQOaPS9efeJawh1y7RzP66kJsz
	 tOOXUGeuMiiSaL3EDlxxGlxv0ci2CIhGxVmA1N8TFACx2v1FPrLc7BZPIx0psABv2TAWb
	 6AATS+lD7dVhX1cMuKWvHDi/rMChwInIeAA/AHzzDlrpyB5cVRI3iYCQ5wX7QtF27IaPN
	 eY75Ak3ScCAO8nIHmi4kS8Oa5Pg7Fd6i8XAN91zqwVVcOBjFBbYhB585nfCVgkYmv/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJaSdAdb;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6F606A333
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 00:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B6F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJaSdAdb
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50933bdf4bso379030766b.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 16:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614404; x=1795219204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGSul/JbY9ftJg8MsxdaD9RtU8ZYOBU8DTFoA5trNZ0=;
        b=mJaSdAdbEeAPm1sF7lZDu7kYW7qI/K86+q0BlhQ6GVJfL00ZxKXBSfPBY+UCO+P1c6
         NS4sQadt7gnuGaElD1jNGCrQ7JF0MiUvbizQMhVIiOfienwz4CZxOFh1E/7Q5PosDsEN
         J0xXgwQcWgkMXmR8su71qgTz77yB3xzVw3+GsJm7nURkFG9HFTz38QKL81RYAFVps5bA
         9Qsmo64v/hdGMk/b/pqPaWwcGzqtPBdrGY9LPcsbBnc9FNxNkLwDgwoWgFQioTNvDHn5
         gXip/HoXB3WgohdKsSxRNSj8bw7a5VbXBkmNog6XS//gY1/1BsaUnxbjjCjISsoDsG6N
         s4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614404; x=1795219204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGSul/JbY9ftJg8MsxdaD9RtU8ZYOBU8DTFoA5trNZ0=;
        b=ObYzqs9RxnwIbBNCRyrsLEmCDqT2+Uf2TOSl5Xe5fZixZsSql68KB7GyslHjJymZjr
         JoybcEjbTPIkZleCZJoDfvzu4uJbxmqPV7Qmr15YH9cWvQDzLKZC5lNNtpOIvlRYSXeH
         thZPxBg1s1fn0SYAffNATApAmTVueKqNqAsm6MIOOInuxvADWn3sU2wFOFzGzY2seB37
         /Q6X/pzOpCJWVFPIJ6ANZVyXbUf2vDwARUZMIEQdL3yG8CCL0SbW+wKDidfNnMCBndWq
         URL4ivcJHT7VBZz9UIfSI81raAKYw1+atFOcSvl+ShKsYEPGhpa0/8FgHJYWBt9z6Yji
         klgA==
X-Gm-Message-State: APuU4Z8TWI5+KPqLLxUYsY0OvFTKVieLAr7imBWwhhisxhuz9ovHRKgA
	+/CEuOToCKljLDMSncgUt/gR4VLb8CfL934MnohwlEaZdEirfwa9Ir2k
X-Gm-Gg: AYBFou3yKB28v0BFkdyKpXYRW/Sb/WlxfxT3WYqIIoZ4HFsPw+eVEQOZqdtIGEvR2HC
	wZxGrWDYNOd367S6cH+1KpnmmomYcSo3qXEoNPHt180Txld4/YRRKX1jDPx8wVnPwzS9pyQPDDe
	wzb/Y93XYkL/Af50NQ7AEtPTDIk/vWOgguic/WsFChHEX86Ck09LIt5GhTYN0INxq0j6q7Xl1Ww
	4edu8KlB8N+kOAuqYbMf4KdawBe8GxIsMRcnICUdxjrH41QgXkp93U+hNIlZEY02lGv5aNdk+Nc
	Bz87Ud4A9z4XqtiaCiqLFfVGxUchU1D1hEoPza5+/YuwC9Q70E0UROtaDPQVrqsJDkSky87lXe8
	u9y52F3s5MNwq11nIwqmGt02EGP3sYixz4ERp+TrpRr9RvTp9gsKqv3Cf2xmk7T5qlc0IsqYrdp
	XDyhv5swpKbkQ6T0qkTq9Uvmxtf2g4ZthtHC54WLPm/jRCxjMfQAjtxzuK33Sd0chj3CtOn9A1X
	4co2dEcGBtJIQoDUboGjbWOpZ2lxTK4tpRoxRtOdt1HvdvkCYVquAvgiTWxJOCtkT4XQXsId+7L
	YQnNky2Q8HEMLuFoP3DM/fT6IQGe6iM6WqLSIT67
X-Received: by 2002:a17:906:b1d9:b0:c4c:e91f:e1db with SMTP id a640c23a62f3a-c507c439449mr515074366b.25.1794614404071;
        Fri, 13 Nov 2026 16:00:04 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm156867766b.38.2026.11.13.16.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:00:03 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: mdio: Clause 45 support for
Date: Sat, 14 Nov 2026 01:00:01 +0100
Message-ID: <20261114000001.518424-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
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

On Fri, 13 Nov 2026 13:15:51 -0800, Florian Fainelli wrote:
> This patch series adds support for Clause 45 MDIO operations within the
> mdio-bcm-unimac driver.

Tested on a TP-Link Archer AX6000 (BCM4908) with OpenWrt and Linux
6.18.55, with this series in place of our own C45 support. The bus has
the switch's internal PHYs, which are C22, and the BCM54991E WAN PHY at
address 0x1d, which is C45.

The BCM54991E takes its firmware over C45 and links at 1000 Mbit/s,
ethtool -r brings the link back, and the WAN carries traffic. 8000
reads through SIOCGMIIREG gave no errors. Such a read, ioctl included,
takes 18 us on average for C45 and 10 us for C22, against 64 and 32 us
with the old polling, which starts with a fixed 30 us delay per frame
(our C45 code used the same wait).

The PHY's DT node has only its ID compatible; our PHY driver, which is
not upstream, switches it to C45 in probe. So the new check in
unimac_mdio_reset() never matched, and since the bus is registered
from DT, the C45 scan at registration did not run either.

Tested-by: Kordian Chmielewski <kudzo51@gmail.com>
