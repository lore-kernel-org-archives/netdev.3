Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604577;
	b=Ct37Te+z90FFTLaWWgAVOcXtiyS7RTeqHn+aJ4uPWuKzaxME5WzCZ3VB//mv68lNlRgC
	 wWrCc8+pcZkMEemhk/yNcVqSmX471vH1qrc+vax4JgOJ2LOkBVFny/Y5cWZllbIOhqNMM
	 Rc1ArTNO1CJL4XMuFuYaVLBwL4nulCEIno4hOnZGabayB3Egt+hPFTHbcabKaHl778c4I
	 NszBFEk67kaJ1KHFrWNlCcLjDYs4CW5NpcIsmcJztKhdAfim8hWcpG1NPhUnibuTvWU9X
	 W0kqxkAAfJsulS4T9pCAn77hj2aUzRse0QNdVor08wdYKKw6iogLbkguwb1DoVocdNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604577;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=C5wMPx9sA5zj9WmQET0KQcjgZNiCIfRUlXOZjuWLo7k=;
	b=R557X+luLW8Z1iHLzHBOqXHBHKKelmGApgIsRbuIYlSQjvz9rirSmZesuddRch4eZglB
	 1/kxCQg/+ujI522FO+oUdwTG9SS3+BGtnqitpsLXYupIMGGC1KJd7p14NOSsHim53j3ke
	 kjzD5iZW8QxhrtZvKeAt8lGqXu/Jp5uW8yFRMHVp1ejOAE/ibgXV7hyL8AHC/3Q5ObvXn
	 dbkaZ5WY0HWbUMxxRhO9JKofE6IVprhpBDYBnsYCv+COgysPXx1Ps+weVzT5DH0gslcqe
	 F50dnpsEajAD2HLxIIVFpkQdKFwYQx4+paWN0KRMYLcMti/hXvjEldXgGTlkn/3epIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DJ4iFce3;
	arc=none smtp.remote-ip=74.125.224.99
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283A606A335
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F283A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DJ4iFce3
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6798af41644so1101831d50.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604576; x=1795209376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C5wMPx9sA5zj9WmQET0KQcjgZNiCIfRUlXOZjuWLo7k=;
        b=Qj4AWgd5QsmZakG3tDBJQs6LrVh7v28PI0kntU/+p+mJO6fp1r2iiY7HOLGlR/klwC
         bP18QwVEgP25v3kgpMmzEz8T8PhXdQQ814eE6Yfs8cngDMlVLv0l3RKmCsYHDnLOk46o
         ESfviDFVTr4y758cywJRMMh3cJDEDAyCkqxoULrVKyv9A0NDgsIqxL1IhWrGqyWXsFLO
         KykF8hkpjCEcxNoKuiQjYnXfZzFG3tg1XhcYHw3XC61yn4FX9S+PYsC60Dm0pKyZwFSa
         gyxPFCL1GZpDHancXf+VzTvX4wQzNJzNMdqZR5M3NDbiiYulUbAI1pCIm8PDa4N38+h6
         4PvA==
X-Gm-Message-State: APuU4Z/G+rexS2AfUZzS2BSv5bZZG4/8THdqTOOGtEq+pxv4ZLVXRKwv
	S9nFJseqPfHLI6QgS+Qf6rZB2wCRIKoOKg+/YY/McgiQjQu7VeL6xlL1eMzM41nyb4sbwBstMgF
	xI/ff5sY7JKJ/h+HJMddW/PZzQdRbNJORWJ5Ir4VZkeDBRIWbcZvkFY9YQGT37oKQsvaaLOdDn0
	A1WwApl9CXUt9gWDhpM7K3D/q9suB+0L0vJJFkkGQA4ofQ1s71rDzRBlgmP9ZAKFyjI3pmd2jQI
	RoNkO34ULmKJnFR
X-Gm-Gg: AYBFou3IfoUcagsWAdjtaFXb0pnPXXrM2LEyST77ZexSpqA7lSIIVYwkcxA9LeMsktu
	mot8xXpwNqpSrxcfHZKOqnD5XIibsvc0AfGmJOIgiy7naJDP0ACxgRnorClFRAFsINct4rwpoJF
	HXD7wsvkDSxVPD2FJOnDTNmNynV9n+cGWp+7HNqGNy5bxqnD/WdTWbULQU4EwzCU9geeTbBBA8u
	lAa/Vty3i/Ew0XV1+ijbu9xcVL7i/P9eOKn/GLSBGNgJFVLzCF3IbM9fKk92+9Ldep02R7zs+Sl
	eEfKJGC/aRlHVgLbNJq8rZR011C4BCbIkj/ByEXFw8yADoqV2HX+FXj9M4Kavgw5uMj+ZXUutTP
	l71WJ68QoqrJQgsp5hqNyTVTpJTgAyLOSPwFO7uo0l5PcXoAHEMKoHdwPEwkgqQoHs1DdNND74G
	s7TBDvHd/aDbZZNxKWbBKD2qekr/aI6q6N/VHpHD7MJ9c=
X-Received: by 2002:a05:690e:419c:b0:671:26c4:3ac6 with SMTP id 956f58d0204a3-67d896b90c2mr2377059d50.37.1794604575868;
        Fri, 13 Nov 2026 13:16:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67d8a5f5779sm68384d50.17.2026.11.13.13.16.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:16:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91edde88d16so18624566d6.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604575; x=1795209375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5wMPx9sA5zj9WmQET0KQcjgZNiCIfRUlXOZjuWLo7k=;
        b=DJ4iFce3NEZZhAkSvtxAjtBGRbTgVsfwOUUNc6dkjFqtx6w+adxRsGr0iuMI4dIaDQ
         txeMO2pq6rdSDI/c7CbFw8DPJNZuRO0N3HflY2/tnBtTpVuZ93z5X7Di1KG9h6FwOvNq
         cBgcsuPSDziQiPKESTVU1nmgVrPsbWIshRJGw=
X-Received: by 2002:a05:620a:8398:b0:93c:ba88:cd65 with SMTP id af79cd13be357-9494b9e13damr645599985a.7.1794604575034;
        Fri, 13 Nov 2026 13:16:15 -0800 (PST)
X-Received: by 2002:a05:620a:8398:b0:93c:ba88:cd65 with SMTP id af79cd13be357-9494b9e13damr645592685a.7.1794604574387;
        Fri, 13 Nov 2026 13:16:14 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8f92bbsm273474385a.40.2026.11.13.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:16:13 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Mlody12 mlody12 <kudzo51@gmail.com>
Subject: [PATCH net-next 0/3] net: mdio: Clause 45 support for
Date: Fri, 13 Nov 2026 13:15:51 -0800
Message-Id: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
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

This patch series adds support for Clause 45 MDIO operations within the
mdio-bcm-unimac driver. The series breaks things up in this way:

- scope the existing defines to make it clear what is C22 vs. C45
  specific
- rework the polling completion loop to be a tigher loop
- add support for clause 45 operations

Florian Fainelli (3):
  net: mdio: mdio-bcm-unimac: Define MDIO_OP_SHIFT
  net: mdio: mdio-bcm-unimac: Poll for completion at 1us granularity
  net: mdio: mdio-bcm-unimac: Add Clause 45 support

 drivers/net/mdio/mdio-bcm-unimac.c | 130 +++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 15 deletions(-)

-- 
2.34.1

