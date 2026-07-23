Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DB4BC00B
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817334; cv=none; b=J4kzIER244+pJolRdO81EFVI58ZgN8rrLFXGUNwj+qkkuw+rIaEI8SFeY9zsFtiwTJPyPCMGhJzNLQB5VphTbOfoAGixsSBf9JLXApYzskG4SCLJMsLHnCeH61Dk3qEhM93Bblk56q9Q7qkYIyAU398iF72uCmpyzhW1Aac9LXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817334; c=relaxed/simple;
	bh=qZpKHd/gEAhbhxl22p+rtXj3FAZ+fWVXX66t6gD/AEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBHpW7bbFWfj93O64fbOH2OjTOVdvvIpBIRS4sSpKNk0MoDGqWfA5gqcQiZBvlt3xOAZImQn9LYYkuhYUJyGA+V7Pq+0bCHplg8MMm56SnYergj7bVcA29E18nfDjpzU+CGQ0uIMgDDXit1Qp4x9uMqPrmcWakJeb/Job5ZO0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvi9A+Pd; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvi9A+Pd"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efb708b1a0so6329716d6.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784817326; x=1785422126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZpKHd/gEAhbhxl22p+rtXj3FAZ+fWVXX66t6gD/AEY=;
        b=Fvi9A+PdqqPUOHxMm9NrjsgUnV7yoeTDYTFraItksHL2QE1lw+Ytxblms5jEceAt9q
         Zm4ilzOFOYQ7MDvBXfGWItZ3HGrSyCbqEMELZf9wmKiIQRWMBdgS6gyNGB/Py2UsDnUV
         IjoSYefQ3iHk8HYKO7WZAE0mN6Vl9+yU9+uGT6I9PKRM5R0qwLVklXpgQbwr0Z/CBupg
         JAVcVFv4exz45ThLYTspjd73MvVLDBS3XTvSI3kbBGv9xL09RTN2PmQoact1eY1KmJh6
         x9OJ3thEcvFLDH12QC/gD12m8lrxE431GeEnD/36Q8JPOGwDi0V8RLtA/tLr2qCER9qx
         wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817327; x=1785422127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZpKHd/gEAhbhxl22p+rtXj3FAZ+fWVXX66t6gD/AEY=;
        b=bEKvx1ZhoCt+E731EGtKVsHlDfhOQt0q1ib4QUNIbXa9DAfd8Kmej9EMOCp0BHqNue
         mDTGT5y/tCmIY2BFI4BFqQcfOMtPB6+02oM+3xmx6G+3EbvKAm15g2rEF+mD/2gluIUk
         1TYnJzPG7drMhYfDB2W2NIcoq3nmB1K1YJhv0CwnJjz6mckIdw4Aip/OZxsIYEKZSqI8
         3zqBJZaXL1o7k4/XKppT8ZGysSAyPw06hwC2QGPeSSDqb01hGIqRgTdyOGAVwm/GqR0V
         FH5LpG//eTEPgXfy13LRzQQnzhcXgZgfcfwgnXiCFmQjWXu6TdTx6oDRlVCb0g8d02KD
         LKAw==
X-Forwarded-Encrypted: i=1; AHgh+RoFyvZZ3HIWvZWRrWlYqO8mv+rmNZI8RX50bTBE5EuN7aqDfHeLuMa9cS8TmW9DAVs5oC0B2XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmGU315ahnWnEJqtu/+KXRl2VSrmFYUHPTWs2b9Pz+dKU9pwz
	rmcglGoTkfLq7mABv2DMtAdYfxU1Hs21XqHnUkdyVx3PFUt6PstkEDny
X-Gm-Gg: AR+sD13vgP9I2XvXwlntZNcJRGL/9i3vLq7w90OBxO8wkSD5PvL/AQLoDb7b/5CGJm/
	eT+nSnjudRgU0a4EirHFG92RmMIyGTXNcJW/Pbq2I3kVcPr+Ex26GRxVXXYDOjBBazeIRN0DoUm
	Zl74nYzmohjgfPSv1F0BOIsPI2Vq6ONUY1/UASyrwJ6bpKcQxq7MVNXSdBrWLbeI7SXnYlUWBjv
	ksoJs56jyr7jYCBHCs64njotOjiM/7NkukbImVH0bMw6327Yg0WgfEl75qQpNfFVsfyfDBvIEKJ
	DnL2DTNIW62zTNCndHTT72Ksxen2UJVg5rFENnElxcrdAfX2btGU4BVWerFW7Mvooh+LmesDvDz
	hyt7xCYBUFbzmV5OLrmEg1eryNYRp1RYohQUKbPYTfHBnbZXujbT7ZuEbE8CmGYZ1ZPQOLGJCI/
	PByM1g
X-Received: by 2002:a05:6214:2aa6:b0:907:5e97:b1de with SMTP id 6a1803df08f44-907ca5e77aamr36754956d6.41.1784817326510;
        Thu, 23 Jul 2026 07:35:26 -0700 (PDT)
Received: from Inspiron5409 ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa2962csm46195786d6.48.2026.07.23.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:35:25 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] ax88179_178a: Add support for AX88179A-based chips
Date: Thu, 23 Jul 2026 22:34:19 +0800
Message-ID: <20260723143420.672680-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Birger,=0D
=0D
I tested this series on an ASIX AX88179B adapter (USB 0b95:1790,=0D
bcdDevice 0x0200, firmware 1.3.0.0).=0D
=0D
I applied v2 on top of net-next commit=0D
df13c1df8147675470213ffff29dd5762fa321f5 and tested the resulting=0D
7.2.0-rc3 kernel in a Debian KVM guest, with the adapter passed=0D
through via an emulated xHCI controller.=0D
=0D
The driver automatically switched the device to USB configuration 1=0D
and bound it to ax88179_178a. It reported 1000 Mb/s, full duplex,=0D
autonegotiation enabled, and link detected, matching the behavior of=0D
the working vendor driver.=0D
=0D
DHCP and sustained pings over the USB interface worked. Bidirectional=0D
iperf3 tests completed successfully, as did module unload/reload and=0D
recovery after QEMU USB detach/reattach. I observed no probe or=0D
register-read errors with the series applied.=0D
=0D
Tested-by: Jianhui Xu <neuromoments@gmail.com>=0D
=0D
Thanks,=0D
Jianhui=0D
