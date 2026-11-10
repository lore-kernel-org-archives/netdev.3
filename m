Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278926;
	b=XpgdP/uqOfAU8Gw9rp24lqm6gC53CKwPWprq/WwX8VDD7fkTOezmYM+5HjeGCn8lK59N
	 sOorOeiTmpAGsebp7OM2HeGQhhdDv0fbJGHCxkA7F0skWggCCpofxTl6pyOUfOtbNahOC
	 bCf2fAKRUf3BOTtvY7cmuCvPkAEsVmcYsvndPkA96+rDpNDp1rGD8nlW4R3SiMkllHQUR
	 7Yw3R1/xyMqydndDTmOrKLB0xZeLeRUHcnxtNZeMH8o0XuD1GudfWk2xI6DcGhUGP1/Mq
	 MsnohvsOlDsdmZNOBV6dV9TGZPCZzeB4Sr0Vgjjyq7kknBbXjvBYWQtN2CGFHKj3hWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=u1mRfjRp548mQrIu3BS48h/N53IKij7/e2kmO+NoODA=;
	b=UZgfRYp9obkIlNsqB//5fz2J5AYWb9e06WwaNz4EYNIqYOYCXLTddKC8W187JT9WN8kr
	 AkEjrR6fe+xJKnHEHnk7G+aP9IFrHX5V66NVl44nzURJzw7ADGoAdPmaqwKwpETTjQvmv
	 y8i7FEU2SY1NyrLtQdwUXUsFwISZTODsxvKSUDKBFB4WbIoRtTU3BlrnC3U3LusiBIjYC
	 Lj41xe57KPwFPtYWLq+Eg+1jzrqOWZ9eQuoMPAzMGLfArp6/81aYXFO8krt6LasmwR4s/
	 oS0EN6o35ugdbJKrdO8tEsMMoe+6K6e5PfrnPOP0212HwRl6ExPzAZUd4b0NdApfx/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KgRxhcdn;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC6606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KgRxhcdn
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-563a0462094so782961b6e.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278925; x=1794883725; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u1mRfjRp548mQrIu3BS48h/N53IKij7/e2kmO+NoODA=;
        b=KgRxhcdnXtkdCaGp5bqw8j0icuFvS05TJxM52gjAOMC875K5SlLmpxNATd7+krziLX
         CO4azcZgsAbU28WQKosvaeN6buAq2qOltVCGy7NAFdKUvKkoiViqmTfFQg+ddkoVpYw0
         BwBpqhEg6604V7zLHHvxq1YbGqmCBLHV13/ZzFgSYxsy2CF5ikOfNysUYXz/Wg9Xpgkn
         dL5uVHkhEqAbpyl8EVBzSDJWhMJu+benOkcpgEXyx0fZWNaDtJQQhNyOfswzhTR5Rw7c
         CMF1wIaF8qo7GoB2EYcIU3fCbmWCS5j6EgXpsAC6LgQTWABCTX3UJzdJmwtInMxA90XR
         7wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278925; x=1794883725;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u1mRfjRp548mQrIu3BS48h/N53IKij7/e2kmO+NoODA=;
        b=X7u4rhIQ3rkzSny2pVII+aBzB+I7Tr3RXBylPu3zQSrlScjcEM8iJPbapjyObKv1TM
         m0R6G7pqdtt+zF/hsB6f8Xmww0UnhsJlHxxMwQbZrfkvKKKU6EJ19kxDaH3ZceXvraNj
         WBbgt2SPg7NFcCGki5niZ0k1ML7sOck221cpks3q5H0XDUyl7vQgbh/8V2CdRt71ROtI
         uTGDLiE689ZCBTtT7fuyRZVH7Cdqu9hNOBl+rTXNtEVk9jwegi3jwOpNTGFENwSs1MLX
         WI7hC2rlSed6jv18swjc3hoVRTVEaXfj9bchxNlopykLOfR7VDBSu5DIyJL2JYGNX2i7
         +8QQ==
X-Forwarded-Encrypted: i=1; AL+hErEKOATxdsSFLH9j7RW3tN0fTwOsuNK6wLvhVIMlX+FI70kHU3/coNOt9w5p2htgeuuXSTvJqdw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tkXXGdzftUqDuNVUPnhvLxSEaUQGzV2wFhoFPPiurnRheDssi
	DyzOgQ4eDb15jPgLw5IGrjd2p+Lz7+9tLH3iXeCz8Xo/JHY795rBBdmIyAGb+pvj
X-Gm-Gg: AYBFou14a06Wv3zcOpd+8v+zFe0Jon55FxNjYWEda5Dvlp46Q1x1rFgGYZ2qJPsER35
	aVPEZifPebNEwqfTg3hi1C9dayapxrqu/c6VDrwZNStiK+gG809OqKWSrLBnezXvuTKshYyYWJR
	cBbxnu9tiIDVGNK70iBwhAdDjxWA54zS2bK0OV0G7alX3v1CxP5N2umT66AGntan8Q2XLG7BY3w
	vC8D08zz7NpPHuFaybTyQ821epOXVGtEw02kG4L8W98TJHroCgjBsTZstJCVhoC3ItnD18mtKfS
	OMv4+PlPz29JuLqknfDfnPY19tvCJeUxivQSw7lV2E1umNhHAiiSwBn9rBjrywHOH5Puc5nOW/Z
	Y6dHTbvDz2QfVThNlZ8qHFRlpGu54S+7jF9QhiEdSXtrwqKaB9n9Bk1UTG2fDKugXTlm5szttmm
	YuCbbVLNHvqAFeSVe9KnwE2uk+h/eSxt3UJSpu/MLtY+wNX8iptOXBQZ9IaWY8QIkQbmZXLTcKP
	hK7Ixh4WQdL8onw5+f4Y4Qom1pWoJJFAKNw5lKFD9CZiX1b7Hbz2bYmd01Wl6bYuRy2naZQpGfW
	gImPwMsLk2ioW8IeuqZz74noVNT1d1AIBIrTnHNkilycwBRn2kabNjlOqI1wsUv+8EFqjCR4nMp
	vdued5OG9GQYGiGIvW2v9erwUXnTmipNkJH4PYI+cfo1S49BefTBfDzEW5XrnATHhTc/ovSzOl6
	ArQxaJWoCHo39VVGAXwaqaJtcAvo4C4+FQBt9YghQhHnhb6sJT8ITA
X-Received: by 2002:a05:6808:1991:b0:4cb:f21b:6f91 with SMTP id 5614622812f47-5683cdec02amr1137185b6e.36.1794278924676;
        Mon, 09 Nov 2026 18:48:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f39c60sm943233b6e.14.2026.11.09.18.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:48:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v3 0/3] ethtool: expose PHY receive totals
Date: Mon, 09 Nov 2026 19:48:31 -0700
Message-Id: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OSw6CMBAG4KuYrh1tSy3ElfcwLkoZpEaKaSvBE
 O7ugBpdmcxmXl/+kUUMDiPbr0YWsHfRdZ6abL1itjH+jOAq6pnkUgsuFcR72boExg6cw615QEw
 mRegFVEVW1HmulMKC0f8tYO2GxT4yjwk8DomdXhtiLmjTTM+3pYkIZTDeNvPoc71tjfPzvnExd
 eGxxOzFIr4T7f4koqJYWaW0QKWrkh/OBF43tmuXHL38SkT9kyRJmS2M1krx3IpfaZqmJ/inzTN
 IAQAA
X-Change-ID: 20261024-submit-acx00-phy-stats-v1-d838f77444e8
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Some PHYs count received frames and bytes including errored traffic. Add
explicit receive-total counters to the generic PHY statistics interface
alongside its counters for successfully received traffic.

Use the new counters to expose ACx00 receive statistics through the phydev
group. Accumulate the hardware counters in 64-bit software totals, retain
them across reset and power transitions, and return cached snapshots to
ethtool.

Convert DP83TG720's existing RX packet statistic to the receive-total
counter, matching its documented inclusion of packets with errors.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Add generic PHY receive-total packet and byte counters in a preparatory
  patch, retaining the existing successful-traffic counters and their IDs.
- Report ACx00 packet and byte totals through the new fields, leaving
  successful-only counters unset.
- Convert DP83TG720's inclusive RX packet count to the new total field.
- Bound coherent-counter sampling to three attempts and skip unstable
  snapshots without making phylib take the link down.
- Reject out-of-range byte samples before updating the hardware baseline
  or accumulated totals, retaining MDIO and page-restoration errors.
- Rebase onto current net-next.
- Link to v2: https://patch.msgid.link/20261102-submit-acx00-phy-stats-v1-v2-1-3c8a664407c1@gmail.com

Changes in v2:
- Rebase onto current net-next and repost after the merge window.
- No functional changes.
- Link to v1: https://patch.msgid.link/20261025-submit-acx00-phy-stats-v1-v1-1-d3d461e46db0@gmail.com

---
James Hilliard (3):
      ethtool: add PHY receive frame and byte totals
      net: phy: acx00: report receive statistics
      net: phy: dp83tg720: report inclusive RX packet totals

 Documentation/networking/ethtool-netlink.rst |  16 ++-
 drivers/net/phy/dp83tg720.c                  |   2 +-
 drivers/net/phy/xpowers/acx00.c              | 168 ++++++++++++++++++++++++++-
 include/linux/ethtool.h                      |   6 +
 include/uapi/linux/ethtool_netlink.h         |   2 +
 net/ethtool/stats.c                          |   8 +-
 6 files changed, 196 insertions(+), 6 deletions(-)
---
base-commit: e281e85235cfc2acd080093d5deced427c4c9856
change-id: 20261024-submit-acx00-phy-stats-v1-d838f77444e8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

