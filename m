Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222598;
	b=gTbGOmyEQpYbqJaSSExPA5mUQvAx/Iib5rsEZ7O/tymgLrvS10Kp4GCqcCqKz+UjubFs
	 /i+e5sHUBNS+W1B0eeJwttOtrSyZBqCj8ueE4XlKR7IH18q1QCJQ4o3xLhwUJQ/cEnOan
	 wrL+E3+rBBysJHHE+SMXgFKsz5XeEhqosL8gS2EqLecs74FUsJ4E7FA9WXvEG4wKMwMHb
	 84e0qYmJMxdCnWFe8o8m7Yx2sqULDH23Av9A+/NLzOdA+moJy4CbMELdR5brSxLuNYttU
	 H5oe+lrs5Nx+DrYyZ05I/8nOCki7M67Aagso1wk/4GTj6R5W6sxwf2Vp/XjAJTumWrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222598;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=H/q3/zf/nmcGLoN5H4ogmMMXauB6rTKmmZVIQA880V8=;
	b=JRg8RlVtbKfzFf0cbOzpM/VcdDmdccc3900Lb72kv1/XSbAw163Xn7+X6AVvbOaQXlif
	 o+uL1ifxikJJ1iF7sOTbXg5oNRfOU7ih1C0gEUvWI4pbAJaKrAfR9aMBNApuko4tAzmdw
	 vjOXp/FQ4ziupsojUhHnho6OLAl0hnrAXkYWXiZPBIC/yQBqsZ5SQ9tPQXm0hQGZhC5I5
	 Py2wgVyWHzThhs83rrhav28MX4QsHDQvZQ6y6RX4JvFcue1vhGjJIEkrlFdBxSTdHzMn1
	 jouezT9STzLQiN5x8YGpF5pRkDG4eFOPAwrF7zed8f/c84k6KL8dt5MtBR4DiUnHNRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YmtFMaeo;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433E606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A433E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YmtFMaeo
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so662117a91.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222597; x=1793827397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H/q3/zf/nmcGLoN5H4ogmMMXauB6rTKmmZVIQA880V8=;
        b=oc34On63fbU3K6GIaZ04+CNyG+NIDzrYP61AT+OSsVBUY7DsW+aAZ+yqk4C3fcrAlB
         APofqgThVrhfTMytxakwrmNg4Xf5rVxSOMw8i6mUOaml+RvoiWayRrSl1VtPajU67trZ
         xsRRdt/pk0/ObE1of4/ImwdTKkmbAATyVgleOLBugORawbknzAQshV81HC3ridxC31W3
         FW6P+1q1KB2H/WdVPoyTHXj03aannOmzQqsXfrPdLFlyJtRwlrpFfZNbnSaxqH2PF1cN
         6qL+F2C8rkQ34D/Gv4JdiE6O194//l7RwalrHjnOSnb+Mgz+XZRX1/069vdLhNzCjupX
         0Yhw==
X-Gm-Message-State: AFq9FYKK0CLfgBpEqun760QYv5fixM1AlGFYJ7vjLr+G1/+0AlXkx8WC
	hShbq6ZgG93dW3Tg90cJ9B7BH/F4MjJV5SjIL/5RCN4LMB3uCaRWZ5NDpEYbz00ZBDdJ0RXEIG9
	GxK9EYnFMiqbBNPPJL6JmCthXtLDAlYripl68jmGLZMPs6s9Msz93ZuqHiGK39kR2/aV2KynnpR
	4NQX3CdKS4tdkYkfz/NooWmqyDzY+3j+6JmNjT+8fZjwL2+ihGCvSJcxItwgIBztB9XptgLEd6G
	DUXpClC+2nkUDEp
X-Gm-Gg: AYBFou1WjhofSlA+eH1NU9Sl69C+4Qf5XxbJ25MtukVv2PFNMcn0yiV1hCN2TgFFSAE
	4nxE3pNxHU6YDMY8Y3sSB72rwkZD4w5X7RmhuIf2a4nVBBsOZUwsgArMRZ5lAXgvtrOgZAtUXH3
	xMZYVG3lZVKQfXeXuA7/b8nPkuiXetqxris86gW0q5qtNjUHKFO2QAgbavz6t6VyodJGAhmy4ut
	W11bHIGEfXSiEXL/GBJpKl7rvtGCN+IZXpZ9gZTohmqJVHUK0K2CNkdfFTQb87YLUPnBdqpoEEs
	rI4FPgCNrRXJaKr4UUMGu+0OSfcXKW1MQMLXxJakX9hm+tPeNkyfuLohLNEzBu7S3SejWZm8i+0
	NJh8syxpJRtMxYr1DLskc1Eij00Bq0laGMGGnWTv9ls20focQ+FEaHqEzbtpnhVJEQcSF3UPli+
	t7cbUirztRBKsL2rTq9v9k49lo15GkG3rG7BysjpPY
X-Received: by 2002:a17:90b:3911:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3ae581637bamr2799852a91.14.1793222596953;
        Wed, 28 Oct 2026 14:23:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57a1aabfsm1024365a91.3.2026.10.28.14.23.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:23:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so292876385a.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793222594; x=1793827394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/q3/zf/nmcGLoN5H4ogmMMXauB6rTKmmZVIQA880V8=;
        b=YmtFMaeoLqAwQia1pSttjnPgF3mscZpzhguZX46Gpk3eDCvS1xwoN8qjntCpWWiLsw
         IfUGuErNCTY2paypz5U8q0cfBrmZdMu5PdyMmekEoVFlW24BXAaJ/8rsXtTHTO56dEge
         nnagDA4LVbqOF6PxUfnH6e3G0M2u1iqlEwgA8=
X-Received: by 2002:a05:620a:4106:b0:93f:565f:e40 with SMTP id af79cd13be357-94408d9cd0cmr555385685a.65.1793222594536;
        Wed, 28 Oct 2026 14:23:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4106:b0:93f:565f:e40 with SMTP id af79cd13be357-94408d9cd0cmr555381685a.65.1793222593993;
        Wed, 28 Oct 2026 14:23:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1368755185a.10.2026.10.28.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:23:13 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 0/5] net: dsa: b53: Preliminary fixes
Date: Wed, 28 Oct 2026 14:23:05 -0700
Message-ID: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
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

This patch series contains fixes to issues reported by Sashiko on the
b53 PCS bug fixes being submitted, and then some more that came from
code review and testing.

Except for issue #2, all of the other issues did trigger in testing and
needed to be corrected.

Changes in v2:

- collected Jonas' R-b tags
- corrected logic in patch #3 to propagate -ENOENT, memset after the
  debug print, translate -ENOSPC to -ENOENT when deleting

Florian Fainelli (5):
  net: dsa: b53: initialize the jumbo frame size register offset
  net: dsa: b53: fix the SRAB grant timeout check
  net: dsa: b53: clear stale state when creating an ARL entry
  net: dsa: b53: reject conflicting mirror destinations
  net: dsa: b53: use the correct override register 2 Gbps bit

 drivers/net/dsa/b53/b53_common.c | 44 ++++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_srab.c   |  2 +-
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.53.0

