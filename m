Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528864;
	b=KQSSESnkA3PM84NBendz7Xjrhh4XLNsNxIf6drINBF61cYiwaevc68sR1vK+KplTMfh+
	 Hj5+eSn9chnmMzjvbkAL8AFRca1K/2vk7PSKPAB0B8qUGHRP+nlZ8T43IZoQMmH6bjae6
	 kCrYEgcVyEbUtZXq8Q1alqXzwW07D7UR7VrNqD4gzv6IPH+iOJ01cdx85mPhPQbdbQhRI
	 yGqOZA5h6ttlrcbwLeTNVncLAqzKCIhbuhcx9VLEUANR/0qFA5leeBy5gE0s6ygbScmaH
	 ib30UVTTErh0o6kH7fZk7wptCUG34gY+By8kqWPrPx0i3K/wfX31IrizPJqpTSHQEyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GAbxTLtn8KLNWZOq5PdgC059WvyP0mvclyC7teVViSU=;
	b=jVUBin5lKllvFmK9ljE918d1+v1p71HDaPDrom36HszHGA/+bIrEsVqT03/lFNqZ2X3u
	 1pquooHi10gILbiY2MNWO4z1rms5QdCC4yPM0rqees0MOIbddwrqT2svsMiKNHeNYM2oR
	 kjzpXB9G7cV+/eMKL9xG4H8K08QKPeoZv9xQS27sq0e5wfGUCeX3KPiGdKqLeYlb98d9X
	 gBBRjXf4ySYRE92rCutXVs9fgz2fSNquX0QJaYHdTr/Xhg0hq/mKC6/LLgaYBN0ZUiQhg
	 KZ2rNLxLpPMgtM5Rrr0PsjWwFq9flM3bnXWjUDYVV4aKoMDmd78hoO/XAQmEi1w21BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=QwTr8sUv;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C384606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C384606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=QwTr8sUv
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e00eee27dso926680f8f.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 02:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1793528863; x=1794133663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAbxTLtn8KLNWZOq5PdgC059WvyP0mvclyC7teVViSU=;
        b=QwTr8sUv/KGodkbL1m2zWyQ3JuqhHoYSM4qSetyyOTxnNv2im5wD3XXg3GAg8BJz9s
         12ykLdCsjW/71rZYQTVdeCkwweBxODh9VoLAo4VSoKvm2BZ0xSo5i0NHP8gf3kguLn79
         AXoNVZHpJTbErtL1kC6iENjo2pqZXXW13IlW4gQKsrSkPSlkIT1xprLFPFMU1TLXYF3L
         8tTZNnAlfWkaix5mBzqDdKcuRRvx0VQ+V6abrAI+Tm/s5Eae7UjZx4HDhd92Oq8EIMNM
         bUUD9+76Tbi7oTN/6KbVsuIkzil6O6aoP5e435fWlnhSEc6avM6xEgR/uLV6pPpRXA7L
         tOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528863; x=1794133663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAbxTLtn8KLNWZOq5PdgC059WvyP0mvclyC7teVViSU=;
        b=zMvF4eFQmu0uwYha1FSmXm0lEXQbHyDBW3FYmph9Es8OtfTUT/4eLjCrtnIPGrymaj
         8LrfBU3g/FzjsdkImGLIEz6ImpoQcbMt1rO8KsttSZufR5JWAYy9y3dnr/CgZ4RVwO15
         YkgoppSpsei6tDOyanQzP0PkMxm2pEeR4JqAm+ArzQ17AyxG3WfctPRfeYMuyIsxXTYl
         jMigdoJfhZdF40K92spp4P9RXWKQF4maOQw1KeAoDDn/d9rMl7dhY1lb2LuFLN7lonnG
         NY07PKWadl9juqLoEf1mtMVcZmNK8fEScRhmCJhCXXBviquFJ5HTV/VavMlVIo+Jpak1
         RKUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlHmFfaqFfd/JcNASh782WPauX5UqFAO7E6DbJrBCqpootWMyJDBtBOkZGlbGRVkhF84a3NfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QCQCLrrRlUzOVZjtRg1jDaDXFnxfMHLFaY35kVJfQEjsZL/jN
	TFK9JXiudJWNcqd16kQboenf4R5QbhnSmbFtlhw6+2ZjAA0lknYZ3U/9WA3GNWpRcVQRjeedJlO
	XgSz6uEo=
X-Gm-Gg: AYBFou07vJxhC3/WtrslrSu5LdgIUbqHXNWHP8ycx0zEPAqW/dcTTvbI0jPfXoERdrt
	T62+MQ/bvpVFSXCsQqSol0Gqhk8dsKyYEEUE266RSRx9sq600jkqpVLpTgXlSOx/raxDHFVI1nI
	O7OshoZGBYt9NWgJk8RQPyDPbMCNiUf9jOQzIxczpNP4pvyZdKIbNee8RzmhGOveSCi9eXJ7t3J
	8VFqJmyY+WmZDiQOtP9TFvZthPcYDEhSiN4ClHG0mxECoNkf9VnST8QY41MQFE1RyBnAzYg9kXP
	t4I6CooBDxG8rl0qIdynaNYJF/oV+OCFMLiFESigtIbkFqzH/OD/TmJpLfWCssqkEgji5KZyNNr
	5DnGcK3UDpLsZbHBuj+3cBz/IUrcSZLdYMgWio93N9aejo+HGhZMkENMzSAv85M9gI12xHmlIN/
	VkdH+YYLp8XzkQXVSPmg+Zo01BxACra0zBkX8YBAVrUt4e3Wnc92WCgl/Q4YnEwcU1XJb97x+XQ
	LITkae0bq4dwGlHWQ6mk/vRHHIgBRY9GyhzBll7lX+tC5twPU2VkpGk20tWVhhVrec79NR0YZ0D
	0siiuW0jxUUZWzNkuHc1OSmDFCDBG/Qv48zzYW+QXDEdLdJz4VHNMtQwuBbeF3Mn/oLJ0fM=
X-Received: by 2002:a05:6000:4909:b0:48e:7eeb:4634 with SMTP id ffacd0b85a97d-48e7eeb466emr5258359f8f.49.1793528862631;
        Sun, 01 Nov 2026 02:27:42 -0800 (PST)
Received: from JureBuildPC (46-150-36-237.static.telemach.net. [46.150.36.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm14521191f8f.33.2026.11.01.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:27:42 -0800 (PST)
From: Jure Rebernik <jure.rebernik@luxonis.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jure Rebernik <jure.rebernik@luxonis.com>
Subject: [PATCH net] r8169: enable the RxOverflow interrupt again
Date: Sun,  1 Nov 2026 11:27:20 +0100
Message-ID: <20261101102720.702600-1-jure.rebernik@luxonis.com>
X-Mailer: git-send-email 2.56.0
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

Commit 6994520a3328 ("r8169: disable interrupt source RxOverflow")
removed RxOverflow (RxDescUnavail in the vendor driver) from the
interrupt mask on the grounds that NAPI is scheduled anyway when the
chip runs out of RX descriptors. On RTL8125B that does not hold.

When the RTL8125B runs out of RX descriptors it sets RxOverflow and
stops receiving. It does not start again when the driver returns
descriptors to it, only when RxOverflow is cleared in IntrStatus.
rtl8169_interrupt() clears only the bits it read on entry. If the ring
fills while NAPI runs with the interrupt mask cleared, RxOverflow is
set after that read and stays set: NAPI empties the ring, unmasks the
interrupts and completes, the stopped receiver raises no RxOK, and
RxOverflow is no longer an interrupt source. Reception stays stopped,
and every frame is counted in rx_missed, until another event such as
TxOK makes the handler clear all status bits.

This was observed on a machine in real use: an RTL8125B (XID 641) on
the PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6. With UDP
at 800 Mbit/s inbound and nothing sent by the host, reception stopped
for seconds in 13 of 20 30 s runs, losing 5% to 31% of the datagrams,
and a single transmitted packet restarted it. To confirm the cause,
a debugfs dump added to a test build of the driver showed, during each
stop, IntrMask 0x2f, IntrStatus 0x50, NAPI idle and all 256 RX
descriptors owned by the NIC. Writing only RxOverflow to IntrStatus
from user space, through the sysfs PCI resource mapping and with
nothing transmitted, restarted reception in 17 of 17 stops.
Reproducing the stall itself needs no kernel modification.

With this change backported to v7.2.6, 0 of 20 runs stopped and the
worst run lost 0.03%, on two RTL8125B boards. It was build-tested,
not run, on this tree, where the single-vector path RTL8125B uses
is the same as in v7.2. The multi-vector mapping used by RTL8127 is
not changed and was not tested.

Restore the mask of the chips that had RxOverflow before that commit.
Only RTL8125B was tested.

The investigation was done with an AI coding assistant (Claude Code):
it wrote the HIL test scripts, the debugfs instrumentation and the
register tools used above, proposed this change and drafted this
changelog. I reviewed the change and the evidence, and the test
results above come from runs on our hardware.

Fixes: 6994520a3328 ("r8169: disable interrupt source RxOverflow")
Cc: stable@vger.kernel.org
Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
---

Notes:
    This restores RxOverflow for every chip that had it before 6994520a3328,
    but I could only test RTL8125B. If you prefer, I can send a v2 that sets
    it for the RTL8125 family only (rtl_is_8125()).

 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cd4ebc654dd0..62709160d354 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6086,7 +6086,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
 
 		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-			tp->irq_mask |= SYSErr | RxFIFOOver;
+			tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
+		else
+			tp->irq_mask |= RxOverflow;
 	}
 }
 
-- 
2.39.5

