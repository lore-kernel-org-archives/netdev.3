Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769914;
	b=qjQqUM7HA2+RjIK50UHRTXpQCzRWFZb6nZpqJAdvK5MkA8u4qYJSpaAB9WTiLpKe3ksH
	 b5+O6zVGMOy2M++02s5rr48oZZ87ZQlIc6BRQzpNsmImirJ4eYlXT0mhKuRZcqeR/k4W/
	 +kq9KFc26gQGnEoBntzVDO4HSOYBzsoLJmyhWBFSW9i9XdFXqvgP860VtSO8FJJcyLm13
	 KMYpq2DVvc0CCtAeDjvXWmLhw162YHYLY/6lxTILvyq3h7nghhG5JX+oMGTIznx3j74nK
	 VNQu5X2qV2hT6ndiz+sqZtbiKLLBZf0TRYoZHgG4ybR7HhS30H3Bb0DLuoOhnhCVmPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LOG7AOmS6IRRfgPKSJTi33/lfhAOaV7O3VJZu3BP5NY=;
	b=R1X095QBzvL5qM1z7m2AHv13EFJU43EHwYJJU4rCB6uC0gaS7CJF398QjdFit88nJ+AJ
	 oc073h6Qey+KTJn6EAwS823tcgSy5goRbF+sJSLLR9XAq1vGu9sE/ayZnKmI3n5D3Lm88
	 AUFsdrKi7uJDRhTIJtt7iFziI+mJdyqZliWT5TtOm12/i9a1UFxKNEbfDJ2IxQ+IUrJ02
	 YSnvM/m6N4PZli2QO5OrsqXlSTP5rpRmvwVT8dppt5n9mV14ss0dPla0vM1IYShW8xaWl
	 BdaSlUEz7G+osmGi8kwDC60NzS4FgxmTetgyjoPZjl9Wec1ggR4hfGMIgxGU/vcEXSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nitJ5qF+;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53B606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 05:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F53B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nitJ5qF+
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so591506eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 21:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793769912; x=1794374712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOG7AOmS6IRRfgPKSJTi33/lfhAOaV7O3VJZu3BP5NY=;
        b=nitJ5qF+g9pmuZqnfV6g0OB2usPhDHrYEncfSFTxZEDjIH1OwBIA3zox7IJFPp06xQ
         K40SE3iJq/v5lK77yc3wmc/H2K16h3UBaGoBS/BQR8tzXfNIu6//GCQHf1EnYCbZ+ywt
         miFb3XK1cclhKOn9uTeLPEpbQZQVmJ+Fgf10SMwBwim3ydvAujDiNXmmRufW9mEm5XZW
         SloOfOTgz8ZM3sfAxIDFP8cxjHM8mWCme4zti/cz7dAjWhAsxuYVrh9GFTU67ZFy0FHI
         ef/0aXDV7erBBR5vnomigRcB9xehqpQUKofRsctxlcIdPI88tpOPOcWYgtA96F3U/iER
         ivFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793769912; x=1794374712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOG7AOmS6IRRfgPKSJTi33/lfhAOaV7O3VJZu3BP5NY=;
        b=E8myZ3FvPxkGdomY11KNCVyZw3ZYSZgIvhdDXe98aS9biZ2dv+YesNU4H2s/GOFIZ2
         buHj8tf5mHhwaDhmL+iIeSBaPbsCouVKZPdDT01fARt//yB0I9FA0EjHOnxTTEVI+qa6
         VOHHy4XGAr1qQ7NRwAHWbvcsxWN2xBHu7Ehr0cFsHbWVkgjU2yyni33RbZg5lFnSJS1q
         uMh9JCxuHrnioNN2tv/eJ0saXAuL1BYNyEkhUZPRrvUUpGDfLtEuYDWPHMHK9s7C5kqn
         nTgrsfVe2IaA9F3vWe5gJtc+pGX/yD/ltNTGWCrKXcCcmvRY5/Ga7SnF90VDmGmTfEdj
         Bjlw==
X-Forwarded-Encrypted: i=1; AKwUvBw3zjSsSTCkrM/632CuERgua8JWrCdQQbCZ2zBv7GLnoyLw33j8otus0EE/YO6VWM8Pw7U6d7E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XhGQ2L6bb7VfE3itUUktd8Twgw8XACyR6APukvmEuS6OPkWFs
	4gIiFw4JfZfUPbGZyOXeRKEvGhBBOETvg84dE3RrJTnbF8JJM1mNvVDTdl3MMeGFbw==
X-Gm-Gg: AYBFou0yof0tQjgeRFibMNS0GloPlHeo3T9fNX4axKqbCClOr7FwkMAJa6cJQaiOVdv
	7CCvJGw4KwNZHeAyXBOEZsUqC9GJFxx5dgQUX2ZhPghHWAknYpHVwfOD5oiGk38ZMfQ2U7oimRh
	0VVDOfmBtspb9mHwEB9Jd1KR/maLpAhpzUWMmC+OxAaKqhvmA6PeIRHgeZXc5OzGRrL7T1jMTb0
	JW9At7TXIEPMhePqxEQxIqpEkaDfuGPZWMj/MehWYXXDn9hNw3IF/EklD0+bJtoWA/B35If2Xrh
	5QsX+aKyiH/VOwPV+D4NKoOeuLFcsNfiQOJCzQBDorcBFXNUB68EMz70qoYh6+1MR2SdTGQzxKc
	mwxVoHAsyj3Poi2VjJ2Q0jPlxqBK8fGONhuuSdSzSlGMl2HhqOt8AKPcOpB/x9KtM5wEKsvV5aG
	jqLyJEtZ+MEaN0jZtmtyNAk/8dSMkhXixgMDX0FVtQpRl0oBRg1gq0ne8M5zjlbuJtMZjt1Q4Jv
	2rAXuh3oHJp+fiaMqPCl3g3zdfATIzWZDIMaxCnUY2oS5b51SnHW1EDUZOLENFg3lOy3kQawCpo
	fNDy/AxqXXVK6fKU4XWTvEjjeA3jDifTfL1eP8h/GKoLF5isrp8mgywkg61u8h0F7V6ydBDqhVD
	/eyXrVl7yPIUmrO3wSg==
X-Received: by 2002:a05:7301:4242:b0:358:dfed:d0fe with SMTP id 5a478bee46e88-36a42219d4fmr21775375eec.5.1793769912239;
        Tue, 03 Nov 2026 21:25:12 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm3405176eec.29.2026.11.03.21.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 21:25:10 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
Date: Wed,  4 Nov 2026 12:25:04 +0700
Message-ID: <20261104052504.1886335-1-jjc@jclark.com>
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

Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
ptp_clock_info") modified the PTP core to validate the supported flags
of external timestamp requests, rather than relying on each driver to
check them.

stmmac_enable() and dwmac1000_ptp_enable() ignore the flags, and
neither stmmac_ptp_clock_ops nor dwmac1000_ptp_clock_ops was given any
.supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for
this driver with -EOPNOTSUPP, where before that commit the same
requests succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.

Tests on an NXP i.MX 8M Plus (FRDM-IMX8MPLUS, GMAC 5.10a) show that the
auxiliary snapshot inputs timestamp just the rising edge. The reference
manuals for the STM32MP13 (GMAC 4.20a) and the Cyclone V HPS (GMAC
3.70a, which uses dwmac1000_ptp_clock_ops) say the same.

Encode this in .supported_extts_flags. A PTP_EXTTS_REQUEST2 for the
rising edge then succeeds, and one for the falling edge or for both
edges fails with -EOPNOTSUPP.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Cc: stable@vger.kernel.org
Signed-off-by: James Clark <jjc@jclark.com>
---
I used an LLM coding assistant to help prepare this patch.

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index a37405534beb..31a66e855d6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -277,6 +277,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.n_per_out = 0, /* will be overwritten in stmmac_ptp_register */
 	.n_pins = 0,
 	.pps = 0,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
 	.gettimex64 = stmmac_get_timex,
@@ -294,6 +295,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 	.n_per_out = 0,
 	.n_pins = 0,
 	.pps = 0,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
 	.gettimex64 = stmmac_get_timex,
-- 
2.56.0

