Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590029;
	b=FkHeDefhRnnQwr3fVIp8wRIe9KjCs+/QKLg1kdDkSSp+gWCxlOzmu0nd0AlQPr/1JVm0
	 7KiRId2vEjD/Aw8kwj51mmZlIT+sp6s5KBku7l7+GglwHGxjYmDa90PsfNnW2/BRWJdoc
	 8ddl9pYDeHbItim2RtxyaoFDOa7UDBUdss+b1XWTtGqpmVC2f/lb5cqGW3idubpMQ69Me
	 T/tHyZa93NNX4f5QhgD3vEw6MAbrJgFibgZ/Q77z5iw/hbaoQjbUYMCJvbTpj9cMEuXlt
	 tE22hP/w4GgiVk58IsneHiZslAGDTeWa415txTvUJZ0bI40EOqdplEVXC6niRBIppxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=8AJ7AIbn7+UX8TIEt4C6umThZ4gAFF8olo/5cp650i8=;
	b=d0A9P9TjbX9sVCL5foie7O30Jj1DX/BH9zEP4bbaqeK95jvAA6f+vLIe6G9su4W2RN1k
	 MNhAczoUF74cFff6f6bUEdwf0MXqm3kI2UsLu89VfROAlHhQw5fA1XYy/8yREH5CZFH2H
	 Q/X3AJO1y8Kc2iafYdu5aGwXr/KhGu54Ai1/EpOZ4yuIS3hEzt8mWK1l8L1m7ktSJETe5
	 ir+U9vFfEDHJ3c7SH6+ktIDWlg1voz4b325YhTjKnmcy0u+W6BnEqSm/xqGczQhOYh57l
	 LP2s20UkVzGzAfKQLnyvPrUEcT0XDIvBkpMfMMQ0q/3KLh6MWcSZ90gBwQPrlPdid3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J5fGvEqH;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25760A380A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D25760A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J5fGvEqH
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4877837890fso1239558fac.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590028; x=1795194828; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8AJ7AIbn7+UX8TIEt4C6umThZ4gAFF8olo/5cp650i8=;
        b=J5fGvEqHCeM3ThISXi2E6ikdnN8jyUfBcBJWUHw/UwenTJ77RX+M0VKWA7ej+7VCcC
         Z8CXWbchjrN/YQkbG+Ka1ukM+BzGWL+dCV825iv1KcOwCsp5DkG32Mw1C7OtvzzC8raV
         M8tBn+PNAdPv/5a9tv3PS4Ee+3eM22w2nM8mr2Cuyd2B+k1Ftkp8BM685RHpcJD5msWZ
         5SnnchAoZ06tOgo94UtE/+VR0LYqSONatG0waQgUxQ0/Zn8kyvkqK6jESmaUabFAueYT
         f/IJI0MFzaO1dI/ST4neS/CsbCxAnlwjcBJ9ZTcssa1orIMsMjmI0iplbZXPWUmePsNc
         9pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590028; x=1795194828;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8AJ7AIbn7+UX8TIEt4C6umThZ4gAFF8olo/5cp650i8=;
        b=Y/ghpBuCvu2+q6wjm3k6xGDotHY/Qjw06Ck0R9ncRrAqy9Sv3YNchY5DtgYWbd0uUQ
         wGqMl3mA9jhxsS1tOlxH8IEN4svmM5eG14MjBP6hIsI0BLEncpgAlIlyV2nSlXEI2Q0N
         AQqIpthSsprsJxaj8gPwFYxJgNWg+4igg6ex7cot4+5yylRIQgKbYEK0xqf1Ci6KNhIL
         VrG1jounRZGGvOYmCE1PcDruMGUjDbmYacKDmJmbblw+LzrWkP4UdN8GKbLzP2dRfwhu
         rLCcOzGGqlW59OSMfvOQD/cMUSr5R6emeGzhQwGr/ezybmtqORyyaJKe7ce5xVoGHrJZ
         OdRQ==
X-Forwarded-Encrypted: i=1; AL+hErHh1bOx3JTMVPYuLgT7Vq4B7QVlEnQYLRNaSW35PnLdLQgKTcYExMQHGnhIcShnTWT6XHXShUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eHgzZr+txY6/osqnvzdAzQWPmrUiuwVLRXyzF127o/c9iCcp5
	FioHCbMbpXrswlexp4GMm8yOwfzroBMPI3tQXtJkDsokkcM4l//mD0DzpK18G4QT
X-Gm-Gg: AYBFou15lnf2qQhN67ARgGp/tcRxTOajEWpRR110Ov/gDnruo9v559lcMJbzw8TWPLS
	iqIBvOsQbI03yO2CkUAbT6R92n4Y38ntcpJ4vmjyEDDFaw6kFfSIZgNapK1uz9R/9Xi+5prOhK4
	sPF6/0yNd891GqRLmX21dBSkt1EYmHhSlFjzpyNkfnGVKUl2/urE3UBxKQVyg+EmL65+MQYQ017
	GkHsDvKZpDw8F11yklD9YAKF8I3AF8M/qEGoiW5KIiO0NZ62OjImCYX8QL8ax+eHBbX/sEuPwTl
	Vo8oILVlZJrdMemxUGrFRb71xZDG1kBqH1fKm0WLtelPQKrcj9cJ2N+JnCGfq9kTvsZ5l/UJZIO
	XCMdJBIH4HejnQstt6Bc7a+SluwausZxC8CHMZxZGGLpJLXpHTminjMgBKq6FLqbNddia4eVJNZ
	d4AK/QfC00UwDkfJ7VF4/cu1gJf/4tDENxJ9pyhbpnz28oth21MGWqezR/EiJJfKDKQp92cJEpv
	ieUw6V/ZQFBUmLaxwnap2d490erg/o2kHB8fQWQVhyFoqkZbZgar05uqHdTsvdEh1DS8XZjjciy
	jjjZdPVUDqn6+/6rGJ80DQIuXnmmg+MWjdZVXVys1OMy5z0nq7DLNwPkGAd6K/RMw9MFtYVQgJd
	6ehzn0krMM6ZWOcm9ZRsWWLmRm6yucDCYSaKNMIve9XUWtmPFg+nvuB327y90ab2oI127ds9Djw
	28oxSYUNg8RPhfbn48nD2flDIp6VAEcKxUVuzBioWN2h5GlNjEFv/9
X-Received: by 2002:a05:6808:244d:b0:564:5fe0:dd76 with SMTP id 5614622812f47-56e63793a9fmr2595149b6e.18.1794590027740;
        Fri, 13 Nov 2026 09:13:47 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7044690dsm2565805b6e.9.2026.11.13.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:13:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v4 0/3] ethtool: expose PHY receive totals
Date: Fri, 13 Nov 2026 10:12:04 -0700
Message-Id: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OS26DMBAG4KtEXndSPyaGdNV7VFnYZgiuiolsF
 xFF3D2GtGrUBdJs5vXpv7FE0VNib7sbizT65IdQGnzZMdeZcCbwTemZ5FILLhHSt+19BuMmzuH
 SXSFlkxOMAppa1W1VISLVrPxfIrV+Wu0PFihDoCmz02NTmE9yeaGXW2sSgY0muG4Z/V6/9saHZ
 d/5lId4XWOOYhV/Eh02EpUqsVSDWhDqxvL3cwG/9m7o1xyj/JMKtSXJIilXG60ReeXEf0k9S8c
 tSQGH1jqtZOUOlvBZmuf5Dk7VdmuSAQAA
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
 James Hilliard <james.hilliard1@gmail.com>, stable+noautosel@kernel.org
X-Mailer: b4 0.15.2

Some PHYs count received frames and bytes including errored traffic. Add
explicit receive-total counters to the generic PHY statistics interface
alongside its counters for successfully received traffic.

Use the new counters to expose ACx00 receive statistics through the phydev
group. Accumulate sampled deltas in 64-bit software totals, retain those
totals across reset and power transitions, and return cached snapshots to
ethtool. Establish new baselines after reset, resume or sampling gaps that
could hide a complete counter cycle.

Convert DP83TG720's existing RX packet statistic to the receive-total
counter, matching its documented inclusion of packets with errors.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Invalidate the ACx00 baseline before accessing counters in soft_reset,
  since phylib may already have reset the hardware before the callback.
- Start a new collection interval on resume and after gaps of at least
  320 seconds, including system sleep, preserving collected totals without
  interpreting unobserved traffic modulo the hardware counter width.
- Clarify that the byte modulus and frame-byte boundaries were measured
  on both AC200 and AC300.
- Specify matching frame-byte boundaries for both PHY byte counters and
  explain that phydev corrects the documented name of the existing group.
- Mark the DP83TG720 conversion as unsuitable for automatic stable
  selection without the new receive-total API.
- Rebase onto current net-next.
- Link to v3: https://patch.msgid.link/20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com

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

To: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (3):
      ethtool: add PHY receive frame and byte totals
      net: phy: acx00: report receive statistics
      net: phy: dp83tg720: report inclusive RX packet totals

 Documentation/networking/ethtool-netlink.rst |  16 ++-
 drivers/net/phy/dp83tg720.c                  |   2 +-
 drivers/net/phy/xpowers/acx00.c              | 184 ++++++++++++++++++++++++++-
 include/linux/ethtool.h                      |  10 +-
 include/uapi/linux/ethtool_netlink.h         |   2 +
 net/ethtool/stats.c                          |   8 +-
 6 files changed, 215 insertions(+), 7 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20261024-submit-acx00-phy-stats-v1-d838f77444e8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

