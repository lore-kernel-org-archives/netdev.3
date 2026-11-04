Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796639;
	b=weS50juzssVeit8/0HNNbHHWn0ZpWcngR2RRL1jTpNQuFjF5PrpB2X/u1+1pv6Uo/FgD
	 m8FNZme0UH1K7d8LbE7mRvtbwJjKbNXranQpK9ygLkRoMilg2ddh7s1RwRJPx+cMY/yZg
	 OkitgytTBTV6EvwkcGhatCwtEmy8Dm8cG6rdlffh4/t81MSrGlolkq14xoHxmGEbYpI3x
	 yTHFLgvA5dFdQjKPTMCm9JEPusUPZ26bGB3uv67E7ZDBF6eDQBor6XFphfPw8v2iSbB+E
	 f31ezr24Q6CLb+zLJFv8otNRN7BJAVx3IJprHMHObtWwrcXKCQkuzanX8xTcagnCapQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=95uUhBzkqd0S8bWXX7KO834Szjb+muDQfNOhhj7jIow=;
	b=eveI6gMGhdHoDCp+F7MM3MOnavPGkETitmDJtgcTAE1udn/NWsraeF8ZNpbV+xCE7uxA
	 omQOQX3eaBgd4mxstT2s8BgWg3fU+L2X03Inm2S3dVf0t+GeDSbNL3U0DinFUyLOJzYWG
	 pne6PaEbpTkYpIVg0A2Eb8OkRXDGEnqvDld3l9BpTUNMpqSsfTeudsYdVqmk+AkhXktaC
	 t7tGrIsIivoL3XyeAFY4d3y/wFYC7an8LcUzePgIEa5BrkcrdPS7VzQl6NrQZR9RRehZv
	 GMaceuEdmFWAQXLziFMD5s8fkbr5F7txO6An4o+p9HS2WnO7j+OnIk74F0BP1+cA7zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fAdKpRUx;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B7606EE93
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC4B7606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fAdKpRUx
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso525503a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793796638; x=1794401438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=95uUhBzkqd0S8bWXX7KO834Szjb+muDQfNOhhj7jIow=;
        b=fAdKpRUxKStysxPnpUIHCeyiig49fpzNwF7202kjPedgIcDM/n1Nof2uEJIKtXs7pk
         WDV4Vzao0Wqu+859UNCpCp6MYTE1pqqyu3mPwoxJHi2kidzRNmomU6iIY7pv+9sRipeQ
         KiVV+q+9AhKrxuAHDT4jjjt0IhyCz6N8cc+jPMzLzi78/I+dzCVz7l//1KvsVYcJkNMc
         JZ2nuhpFWpSwaiQ0uj2Dxh13SGN0e8AvisGku81LFg950nbaiutHnpqL1ZGar1Q7Fqdv
         v9kfNnmRO90+N/GY6UlwVUDxLT/LKKzqpGDtNcUbyqZk+/2SzCB1F9zsoHkaoRgbKDKB
         W1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796638; x=1794401438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95uUhBzkqd0S8bWXX7KO834Szjb+muDQfNOhhj7jIow=;
        b=bFXzSSSwu8UfqPAfcYuJJaf2f4ICzhqMoexBgIFNITh5txq+Q8UjRj1sc9zK/m6Moo
         flxKe5xGkM60P+gOpvVsF3NAr9/IG6NrNOTIkoS0jLBY8W7iyf2TJQIVX2XQK6jSpblI
         +4/z6Kb1haWdPm/pOLddU369qJlBf3CAS7Yy8KLsMgip6BZ6InQZZfI8nHas4O8ram6P
         KutE9loaq1pKUzpF0PMmx09GysplNml1vqlhlIEqLk8OV2qMU83aQE2iHUPBB+AZQUHr
         SIdpgeNNwhCj/adquIuhgF+ni3YGA/QSbcHHXCvSEAwTxipUt3OBE9kSBzIQAv3CQ+gy
         /MTA==
X-Forwarded-Encrypted: i=1; AKwUvBzrdfwfFTVsHyH7nntVPQRLTIYPPHYorDiPvqOymIjeD2CONukbIqykCsY9H4aFX7VwNgInb3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DNJAdDJ42jrlj7BidmBxGLNjzoxyG96+OG5Dm6UN0FWqTTjs9
	DzkJV5/4jz+oEQYNPpU8G7Y5XOrp4+FJ3sBaqZpnUNMQbv15QYuC4MzD
X-Gm-Gg: AYBFou2IkPGXyoLc8ZWiRWlNrbBFDvXOuBm3XEtMFHR4LMq9WiEgCNuP/DzFn7JzkXf
	3XSHm7TxL8oZnt0/zn5DTnNA73NCSSXVKDFGftcPVs5KFYuy7uDiAxy7V66s4/2wnb+Nii69VEr
	rtnfOaUea2ReAsR9rIhZalLdyrhjwCSVDVc3NUH+BpLxyKiKsYLUWJo11AFn8cUZDztwS3xgyXq
	03i66SUitLyQr9t6I8+WqqzNnssoqIW0ay7/1u1uymMizp4lLoOCvVVsI0z68cgyUFOobAEOHmx
	y1fCKkNSgQPZolP5BTq9nG1gmq26b0v+eoJAkY1XurnH74SS77AnsjgjgcYzPP80xyX4WCePrxt
	PtOXLk4+VzujLyV6BE57Pc85Q0OzrXZ3h7vsJYD+bamQnRjKXQcUGcohOIKvHdCZ2f6QXPv+B7i
	vTKwFApeyi/p1JSvBG6EexrtM/BWjERu7sdBbbeDfMm2MbX2moftfUazyl5g+tsH6lM+9othr6K
	zL12G0dddsA/cLmvEIOI1fCwj+s3PpQsKMmf0iwwkcvMFlBFV2yyfKuII7oADIczuMDgBK0aTqG
	mAe51S9XJgA/BUYcEo6snwkoKbdCMChBTDKNa/De0be84MSvwg==
X-Received: by 2002:a17:90b:4c52:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3ae897ccbfdmr13704451a91.11.1793796638093;
        Wed, 04 Nov 2026 04:50:38 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm3920799a91.9.2026.11.04.04.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:50:37 -0800 (PST)
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
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 0/3] net: stmmac: dwxgmac2: timestamp interrupt support + Agilex5 fix
Date: Wed,  4 Nov 2026 20:50:27 +0800
Message-Id: <20261104125030.1183146-1-zxyan0222@gmail.com>
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

---

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3: https://lore.kernel.org/netdev/20260818132722.1852876-1-zxyan0222@gmail.com/
v4: https://lore.kernel.org/netdev/20260902131441.322167-1-zxyan0222@gmail.com/
v5: https://lore.kernel.org/netdev/20260910081020.86227-1-zxyan0222@gmail.com/
v6: https://lore.kernel.org/netdev/20260929073553.4136336-1-zxyan0222@gmail.com/
v7: https://lore.kernel.org/netdev/20261004120526.2728564-1-zxyan0222@gmail.com/
v8: https://lore.kernel.org/netdev/20261013033207.1684328-1-zxyan0222@gmail.com/

v9:
- Check the already-enabled channel from the live PTP_ACR mask before
  programming it, so an enable for a channel other than the armed one
  is rejected with -EBUSY while a disable for a channel other than the
  armed one stays a no-op, and re-enabling the armed channel stays
  idempotent, disarming and draining the interrupt across the FIFO
  clear like a first enable.  Requests are also refused while an
  internal cross-timestamp owns the FIFO.
- Move the smtg_crosststamp() EXTTS check under aux_ts_lock so it
  cannot race a concurrent enable, and hold the lock across the SMTG
  register reads so a concurrent PTP_SYS_OFFSET_PRECISE cannot
  retrigger the snapshot while they run.
- Hold aux_ts_lock across the whole of intel_crosststamp() as well,
  refuse to run once the clock has been invalidated by unregister,
  handle an interrupted wait, and disarm the internal snapshot trigger
  in both cross-timestamp paths on the way out, including the error
  paths.  Drop the recorded EXTTS channel in the resume-failure
  teardown and at PTP clock unregister, on every core, disarming
  PTP_ACR or PTP_TCR as the core requires, so a leftover or re-armed
  trigger bit cannot reject later requests.

-- 
2.43.0

