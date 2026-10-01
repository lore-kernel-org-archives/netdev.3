Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A7425872
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827979; cv=none; b=OlJvC9IvAIy4M5+20RhBVCdXZFPNdWRRAJMHed5rY9YnAZZT9vRSiYIW/k8/m/3vP1BYxWnU8l1g2HKPl8fJDE+am3nMwbWZB9zvGy6G3/pkU6Z4sstq35pw9O7m7jHgAXEQZJg/pfa8RhHLP28DB1Lwefj6dD2iDDSlIycRbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827979; c=relaxed/simple;
	bh=rBGE/FCoSCjO9lV2tK/O4lYyuLLddZ0q9YOj5Y57EBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tfHNI3Y6W0huEIavhUI2YUFVGADsmUdG5VJgEcTqq6lcXTUre60VBJ3d6B3QtCDwTg0WXeW/xA8+QZGF8Gzs0bWdFtQlhSjvCBN4VdCMd8CZIAi+rmNQlM+HPEZVyB7rcrAKvYX5tJ6VVn/CKWUFLbTtPDLi7kbkk3GUAsptBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn/ZDk7j; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn/ZDk7j"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-821a7bee9b2so110107a34.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790827976; x=1791432776; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OuQ+OGdko092Sls5gQ6DySh0BUOL7VR+MN7b9cMN+9g=;
        b=Mn/ZDk7jwSkaDvza8+9zEM6zp0j/J80j1oX/3gfGJS+bizDAcoMlYFm1j0l0UHIgZW
         nyDnel8je6mDHYANQOiTXMCpjHlMBQxFDe72NQ5GJAbdcYIYJVltiyUmi/KIMs3Ot1kR
         z3niYeKghQKuFnImDv747VNWVwFDSkhU5eC55r2qn/sF7wbm7NH+H72ewuallofvdKUk
         7RlSyhvl5LU661/ZPgoF2ICKJobPuuAKk3Y5OH56q3e4w0d5pwXgkihzJA5G0wcju2Oa
         n9/VJkXzI3KlVMYMZpkMm8aUSjghcdhb3H/MCamr4daNtGD3V/f6uyGtNgdFXQzsvSPW
         TvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827976; x=1791432776;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OuQ+OGdko092Sls5gQ6DySh0BUOL7VR+MN7b9cMN+9g=;
        b=jfs6OJsyk2K0TDndXsISnoN7CG5i/p6/W3SGluf9JOBBCW1XCdWi2ckKl36ikAH+rr
         z1OwZ7fMP7Ev3SRD9LBchWJ4HuhbAngtzOD40xq0ulf+gc3vXrGnnxGJNu23oQcS20e0
         nUqZqBtVHGbG/G6GisMwcS6mSopwjbwHhWcpEvUHyqDqaq3ysGVjeMZPDZwlJAMcdkTH
         KZ/6on+ZF33Cc/B5X29UlHV5s1vIwYfcqR1ExlFD86jE95o9XAyQW6j7J9AdXFbOwlik
         yuJVqm2JgWlB3k2KgOms4G7TLuQYyUIWKlxXSd08CxAkzlZYwU6XjFohOw5EYh8dyRnn
         9dTg==
X-Gm-Message-State: AFuF++mSVEeSCCnRuSlT7VsbBgtpjr4bM2ysvFhN8L0LoPSSrQaFWZeW
	IG8O+4fkP76OMC3t5ZyG4s95UYdSOCL/TT/gj/dDFY/VqvxSGlwTgjee
X-Gm-Gg: AYBFou2jcgKKxIw4qc28HGSwm5uaTk+DAi+N3VAol3rJctB7/hTRGeOAJ38UKqVYX50
	wJrh278yx2fNiGnF8nwnNHtNMY4gbNmSRZ78xc0hajNh3C79+4UIjJDgCSdNOJOntu49hAsV1dq
	3feAkF2JrZXx8Pq7pDo+kG5jOtjsH7WNwPB2VWzcNfC7hcswtSZ7S2Y/JjQc1YgNu1wOiW6u/oT
	1M+RpzwKfYfcUQICX/FMNdasmzWhGYkd7mAGrzn3Tf5wEz55/zVSk33FnBvDQ6TlmYXK4gc4/bx
	xVukzJTgcPri+SO8e8dw+IOcSGCunIQS0g1RHRfgTdSOXoY7L7LxU4XHt5qnLitL1zppfQzDiK4
	9HWfvCRQRF6Rqv8QBzvKkIus1SFdpYWdEO7HmZaDEEciRSrU8OoPnklNkNQesmo6X8g5c6koBur
	F2LQBcdcK6uZcTdlZdfpUuI1jGKeY6IFyCQpka08XoZxWYYK8r+nYbYRDrrK3nXj2rgRwNwT7V1
	TWVKP3jLdERIs4uO8MoNuwwJmT7IdJeIU1rBPtxcgdQQh5s6xGxDG83GuHJDhjxGdf6emO87NcL
	He4CUCPkqEijHc4X/JFdHloaXaXzEXUR3zELOap77E11ifuYbeuwmw2Uc8HtjBetYUxhROwGlD+
	Cmve7zK0qDkeH9j3zcaiv
X-Received: by 2002:a9d:664c:0:b0:81d:bac9:e5ac with SMTP id 46e09a7af769-8211fe51d49mr1338514a34.33.1790827976385;
        Wed, 30 Sep 2026 21:12:56 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3c1ecsm1708657a34.21.2026.09.30.21.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v4 0/4] net: stmmac: preserve and restore the
 installed EST schedule
Date: Wed, 30 Sep 2026 22:12:48 -0600
Message-Id: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/63RzWrDMAwH8FcpPk/FduLY6WnvMXZQbHk1NB+13
 dBS8u7zskJ32MhlF4EQ/PQXurNEMVBih92dRZpDCuNQmvplx+wRhw+C4ErPJJcNN7KGlPseLVD
 KEAmn6XQD9JkijBMNIIxwmqNQ1DWsGFMkH66r/8YGyjDQNbP370mk86UszI9xh4nAjn0f8mEnm
 qpILZLSzpK0yhuDTmpTcc2laSqDpqtdu1rHkPIYb+sRs1ixR161kXcWIMB5NFxXikrw1zGl/fm
 Cp68g+1LWBbP8ibZbqCyoImVtJ4yiVv6BVk+05XILrYADaYmN8wo1+V/Qpag+jj3kYxGef/sXf
 Vk+AaU9xMwtAgAA
X-Change-ID: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
X-Mailer: b4 0.15.2

Continue Lorenzo Bianconi's EST replay series with v4 of the unmerged work:
https://lore.kernel.org/r/20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com

The PTP initialization fix from that series is already in the base.
Carry the remaining embedded-state and explicit-enable preparations,
and restore the installed schedule after open and resume reset.

Build TAPRIO replacements separately so rejected updates cannot
corrupt the installed schedule. Rebase the previous schedule against
the current PHC when rolling back a failed hardware update, and keep
DMA stopped until replay succeeds. These changes do not depend on
the later datapath recovery series.

Changes in v4:
- Omit the merged PTP initialization patch and adapt the remaining
  changes to probe-time PTP locking and current TAPRIO error handling.
- Separate schedule validation/rollback from open and resume replay.
- Reuse the base-time helper for replacement, PHC adjustment and
  rollback; propagate errors while preserving the installed cache.
- Start DMA only after the installed schedule has been restored.
- Link to v3: https://lore.kernel.org/r/20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com

Changes in v3:
- Guard priv->est.enable update using est_lock mutex.
- Embed stmmac_est in stmmac_priv struct.
- Rework locking in tc_taprio_configure().
- Fix possible divided by zero crash in tc_taprio_configure().
- Add missing reconfiguration during stmmac_resume().
- Honor ptp error code in __stmmac_open() and stmmac_resume().
- Link to v2: https://lore.kernel.org/r/20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com

Changes in v2:
- Rename stmmac_est_reconfigure() in stmmac_setup_est().
- Rely on stmmac_setup_est() in tc_taprio_configure().
- Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
James Hilliard (1):
      net: stmmac: preserve the installed EST schedule on errors

Lorenzo Bianconi (3):
      net: stmmac: embed struct stmmac_est in stmmac_priv struct
      net: stmmac: pass the desired EST enable state to est_configure()
      net: stmmac: restore EST before starting DMA on open and resume

 drivers/net/ethernet/stmicro/stmmac/hwif.h        |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  |  47 ++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  13 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  38 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  59 ++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 142 +++++++++++-----------
 7 files changed, 176 insertions(+), 127 deletions(-)
---
base-commit: 1631d79ae57dce2c5f88ad278307028638a8b4d9
change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

