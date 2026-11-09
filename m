Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231921;
	b=l7wNvECZ+bDQSaU4/nBb5DcUToIfru/s68lLGIN4yL/zCMlwAOf3luoOLdVedDlv1ES4
	 DdHdpdeLnxWWFYyIskhSLTgZVxXF3e/mcWxJR43OfenvsZ52ZdoG9K7xd9mhKj1SoR2gz
	 ND9W2aTnJ42i94aQLb14pJ4RdA6HBQ49G4Hbi8lHV72wRD6dZCkZz1k9GX+t51+fiZDuA
	 tMqPowB/BXijqzPS3sLZLgm2VgodYjM8R0bMob3UAUIMFuMHZUdeVf257Y0dh4hv8XE/I
	 pVzwzECMwH0bLB2MPLlJAK0xDWsq68u9Dd+6kPLIw9ecY4OdgPdS00eMf7QGC0N/t3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZB33fDrAm2+MTpVzqHevrVjMtTfx0w/Sxjvwb8uQmek=;
	b=yKfMEu+Jmlc6xjy79fn6DjsTzS/RG6Iw5Q2Mw14bPkFqM9E8fiIhLq5dV73NaxlIE8wX
	 8TVJXMVCJG4estd1E983tBTvCW2kA/YLDouNTqnM8H98YhsOJCtOXRr51eHIrqN+0sHE2
	 KJu82Tcv5AifavTc/DwpYGHki3/MEEAA+5HlQj52in63e+37rTj2xALg2N1L0xmOU515o
	 w7VPgN5uo6VWc6F57iSTvHgNdc04jupo4Mp/m0+nrYr+2C2DCEZWuOcyeDPVtbrehCWHO
	 sQJQVorYM18KRrgFS2jNB0gm2UyBNzFVkQtwsyHEUpydPICJWG5LGyXhB2bmiXmjCCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vD5Yodr3;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79C606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F79C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vD5Yodr3
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso415578a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231921; x=1794836721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZB33fDrAm2+MTpVzqHevrVjMtTfx0w/Sxjvwb8uQmek=;
        b=vD5Yodr3X1C0rOWGiV4KYpByjyi5NN2U1kf/rt9jVtcRLs+Wh/OK/kef9yZI+La0H9
         mUkBg1N2VbAN85LyfTRZVjUUEhdGXYeMc90gN0QhtcvWozHmNPKdIbKmjPo233RqkNJl
         WQPg5mqCPM4ZBmKbZDiLSsFGcvftdrtoFFBOTXPFJRClb0fmwW5a3mCjUED8RTLZ/9gJ
         aP5DztaUutJ6VNxAResBO2W5MEG82FX3SMrWa5yqZF9N61gLogY5HjLIebxU3x/EV1P7
         v/0TTBGZ1vF7yOzeMzdYw39D3gTtnwkXksBNtYPa4dZWh/97nVW1rw7enctg3blDPY8e
         IaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231921; x=1794836721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZB33fDrAm2+MTpVzqHevrVjMtTfx0w/Sxjvwb8uQmek=;
        b=zRs6vphIyIRUvmkzH+Y/RrxRUXnhdGkCg5yEcOLUzkPt8aQp059SEOlg+U8N8iVXwJ
         w7GjdlsWH83HjS3Dw96X+DgCCD+VLC6D7epRmVfcx0gOr7osWtR94LaGAfWDxGv8cDWK
         z3ncWVpD0oLtKsFH+VDyprM/Th4C5icdu+2KQsrZZeGCh+JU1ksfgSSjgp6Y+v+G7nDA
         fG0cRYjDdpK3tbyqX4IfhucEdTTA2z7/SlUi3l3WvfIq47PmunanjlE7OAKHcYQmTpPf
         6bPh2Rj9VUMa+PRMxVy+MECsIOWnqDKfgDAWTJlK/Jau+aQ0HaK8JOYHqb2reR5kSRuZ
         079w==
X-Forwarded-Encrypted: i=1; AL+hErFnUjDFuN9rSpX/kdDKYcvN2eVHYkKRZIHodY6Dr8qYal5cewZaZ9lgqSdWlDooTHkMEZUnj+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z//0twxFqXuwkEC/VaS0kEwZno8r64VheHe3UmB7oUg9qZ/hmSN
	mRW4Ynu98KkSKlQmQKlspUzrd2Cqk9ygA3I8yjTk+djPn632v5fGZKh+
X-Gm-Gg: AYBFou3+ZAfAG3tNIBbR6Tuq9YAF3eITR/Yf8HwD2fQ48Fb6jhn0QNotUBnu3sGkeRk
	RnN034DAtyrIc4WFJWlXgttBFdG6fRKazlmyrRXwIwnLVx+XA1/Al0b3ipKExIXfJstKPZCxi/w
	rP4Bsa+SFsjnVDL6gvHEGp7H15uhUgMDDF8Xxbrz5zHUe0RhX38MzRpK4/1SqSprMeulR4C51eK
	oKxw19Mn3I6Z1p/RHuChKOsByYj1lBCo9cpcMXnBXD7MztPbd6Yst0AsYYBkO/voFtX+lREo91j
	JUmZSFjVR+g6fXwTJQjhd5rPva+Y0p/ivkerIppgXHKNpafpuR/E1AIb5+aR4S3lRpR6ebFL2w0
	+7avfszsyARUKxzDm71wCz6m5k5ufg/8x+rh8jik4Noyc7qf/LZWLfanMzWO/tbSIyDi7LH/dDK
	cZMWa4oC5SG4wf7V/RjiC6Rj78H0Z9pL/6zlVWi2olN2nHy3DTt/CZfQhwFn24zXCtu8gRiyXuB
	DukYSCiKYj+TyNwHFJJD9vli3ql3y0hw/XvI1MUVGqMMG6Yt2H8RtaWgITTtMJXdx0I8ND2j0zt
	iTOF9KBdE5cQscZ1dJ+I6nQpZjez
X-Received: by 2002:a17:902:f710:b0:2ed:1b02:f6f2 with SMTP id d9443c01a7336-2ed833ee3abmr40925505ad.6.1794231920747;
        Mon, 09 Nov 2026 05:45:20 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81727f9bsm11014285ad.57.2026.11.09.05.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:45:20 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	rmk+kernel@armlinux.org.uk,
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 0/3] net: stmmac: dwxgmac2: timestamp interrupt support + Agilex5 fix
Date: Mon,  9 Nov 2026 21:45:03 +0800
Message-Id: <20261109134506.2794160-1-zxyan0222@gmail.com>
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

This series adds auxiliary snapshot (EXTTS) interrupt support to
DWXGMAC2/DWXLGMAC2, fixes a stale TSIS race on the Agilex5
cross-timestamp path that the new handler would otherwise expose, and
guards the shared aux snapshot handler against a zero channel mask.

Patch 1 makes smtg_crosststamp() complete on the persistent ATSNS
count instead of the transient TSIS bit, waits for the FIFO clear to
complete, and holds aux_ts_lock across the whole trigger/poll/drain
sequence so a concurrent EXTTS request cannot flush the snapshot FIFO
mid-flight.

Patch 2 guards the shared aux snapshot handler against a zero channel
mask: ilog2() is applied to the mask without a zero check, and
ilog2(0) yields an out-of-range event index that ptp_clock_event()
feeds to test_bit() unchecked from hard IRQ context.

Patch 3 adds a dedicated DWXGMAC2 timestamp interrupt handler.  The
XGMAC hwif entries used the generic ops, whose callback read the wrong
register and whose enable mask omitted the timestamp interrupt, so the
clock advertised the aux snapshot channels but no event was ever
delivered.  XGMAC_TSIE is not enabled by default; it is armed on demand
from the EXTTS enable/disable path through a new callback, and the
handler only touches the FIFO while the interrupt is armed and while no
cross-timestamp owns it.  The interrupt is disarmed on suspend and
unregister and re-armed on resume.

The failure fixed by patch 3 was hit while bringing up auxiliary
snapshot interrupts on a local DWXGMAC2 board (not Agilex5-class):
enabling an EXTTS channel succeeded but no PTP_CLOCK_EXTTS event ever
arrived.  After the change the same board delivers EXTTS events on the
enabled channel.  The races fixed by patches 1 and 2 were found by
reviewing the code paths that this bring-up exposed; they are narrow
race windows and were not reproduced on hardware in isolation.

---

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3: https://lore.kernel.org/netdev/20260818132722.1852876-1-zxyan0222@gmail.com/
v4: https://lore.kernel.org/netdev/20260902131441.322167-1-zxyan0222@gmail.com/
v5: https://lore.kernel.org/netdev/20260910081020.86227-1-zxyan0222@gmail.com/
v6: https://lore.kernel.org/netdev/20260929073553.4136336-1-zxyan0222@gmail.com/
v7: https://lore.kernel.org/netdev/20261004120526.2728564-1-zxyan0222@gmail.com/
v8: https://lore.kernel.org/netdev/20261013033207.1684328-1-zxyan0222@gmail.com/
v9: https://lore.kernel.org/netdev/20261104125030.1183146-1-zxyan0222@gmail.com/

v10:
- Rebase on net-next from 2026-11-09 (containing 7.4-rc2, which moves
  the est_lock initialisation next to the aux_ts_lock one).
- Wrap two lines that exceeded 80 columns.

-- 
2.34.1

