Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEB358368
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755018; cv=none; b=HveuVItSuA9nXgk+QvmOPFI7AfKXzq4WH8v3QS5kCBKPJAX4U1kY454DA+Btih2RUi/7OMTXwfr/P5ostgS4ooV9t50gkE3dmPYo/zc8O4V5lgn/DYZQKMgH11kjo0MlbcxVRTSiLLUdds1+Lfy3opH2s3GhDdDQMrd7LYhjkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755018; c=relaxed/simple;
	bh=GXjcU39QWcSzGAd3hgO5Q4UtPpQ/TQXwXEGgMc1w11M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZ2RW/F6/YaNPPVdk/rvLZtgbIvL2m2TWiMZzedAW7hKNGDttjNDtOZ1VlicLAD5GFlyZl7LHpNlTCnvmQvn5IsnzKKFwJowe6ZcsTrZcqgglVuvUG3dBbydIrA+HsovdsN9+4jZdwE1OvcqAFYW0gNwHTOoq1gUmDKLCDZUlJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=wuOoxcAl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="wuOoxcAl"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so1212160f8f.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783755015; x=1784359815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XIBIITeNYjqyCVK5ZSVvlqGN7ycrHDwBqsn43mkLj4=;
        b=wuOoxcAl09quC24LTzY/PtdNcxDi7SW9yHX4Wn0HBtpyiU0mz9wVhLqpEADZfVioY+
         2dgUiGXm5uqoXJnUEo5MQ1/2Il9u9u3jBlPWFr4fpWFi1rCr4P4NOw2LX3RUJ8F7LPAl
         vDoqDAUBkDhsL0I7hE/ksXkqIUYEapd/MsRmvhye62g10SZ/MfqYIppkf7LccfiF1DRL
         eq02kvOa0Ta6wu4V8wjYmevZ8Zryi5uUx7KJkStyytCXAkujUTb38/FxVtwVkY77fY/d
         8fYk1Wo9yM+02xnV9EIAexhtA98jg3k8dDbf/Vch5WDgdQkwJRdy6I22UTEYRgbtmRB0
         RCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783755015; x=1784359815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XIBIITeNYjqyCVK5ZSVvlqGN7ycrHDwBqsn43mkLj4=;
        b=F7UW3EiI4Bk2094nQ1Ob4bfaUgECJdVzsKDSr5iK5cPa0f2X+2Kqlt5S9d4JAOeec3
         N5KdAiMP/NpdIeXEPfp9T4mpvCuJI82fBW0fzXop8+mfKR4+5wf4mf/ne2Z7aMegopso
         YLAvbS9e+TBqpKmboLP/NgwVwdYn3rhzujKQ6Owoz9Gi2t5RWH4wqT3CdDcIE72XWUIs
         NP5WBRenT/ava6jun6pzluxvHpvqqcySOC7t8rB4Q1T1/qPsS2iTbXNWb97olz4PjjRW
         ooUqaNjUxKEDuPzlSXbvmjoHYdzFb9sGDJpR6bylDwWBOjVgJ70TelEaUPwQgga7rC+r
         +XIw==
X-Forwarded-Encrypted: i=1; AHgh+RrVJH5DEI35Pfc5lbVo/I7o6TLQltNG3TGjmS1SyQbPFWoCNkwsxExDUoJEX2of8xuxeAicbs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5d9qsaDPW3Ng+1gqe9dSklDVD12xhPH5JxRuww30vkLBWXVp6
	uhoTyE0AokiBrdps701UdMfjz5QYho51ejAdzublMEXQqo4lTUQr5caXLeWXombUV8rT
X-Gm-Gg: AfdE7cm0XCNj4cotrcTMc5kZ7D0xK6vFeaMO+NFvLzmw87G5tDb+4tdmZ1xdWEyCDGv
	BIApZMpvA59WhOGs9/xFFHgGAlxZsAMaHzncqvmr4iMe/yesGj8LYODSrzZ5WUH/n0d4VpfD2Z0
	DptlSB9XXGf158eG7R5WlQpWIdMQb94wS18iQouQPP9fOYneV2DzoroxDjq+iW7O4N9SZ3QQryX
	F9agAECSJv6rdfIt+WF2Fl7LgUnvR1GR3Ihf9a4GEmIBgXdF0T+akJfWkvjmcCIgcSz5bObTz8i
	lxp2Lkl5K5NTUtoxBoTOd+ACnkMaB0iFCR2Lobe5PPtPdR+xlJqszs3tTHcOJhbSl/SkfDMD+6b
	r9T/tKhDZydFNX0m79fE4luh5Qkk0OqmGpxaEJ6OVXmMHkDw1Y/PEUou2ObqODOP0EU9xfQEBhh
	UcLM+pKiEzoHlpLJcl2CwR3iHJdCfFjb5g6wV2hqgiysr38+hnMevlPdnwZkfRMgRWpnQmX0WeU
	c2n2B2Jdsm5DmGA1EEet7k9UIEk1Ld6zJ8=
X-Received: by 2002:a05:6000:1885:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f2dce7c33mr1900118f8f.32.1783755014528;
        Sat, 11 Jul 2026 00:30:14 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm71148700f8f.37.2026.07.11.00.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:30:14 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] nfc: llcp: guard against short PDUs in nfc_llcp_rx_skb()
Date: Sat, 11 Jul 2026 09:30:12 +0200
Message-ID: <20260711073012.71066-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_recv_connect() and nfc_llcp_recv_cc() pass
skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv() as a
size_t. When skb->len < LLCP_HEADER_SIZE the subtraction wraps around
to a huge value and the TLV walk runs past the skb.

nfc_llcp_rx_skb() applied no minimum-length check before dispatching,
so a PDU shorter than the 2-byte LLCP header reached these call sites.
Drop such PDUs up front; every LLCP PDU carries the header, so no valid
frame is shorter (a SYMM PDU is exactly LLCP_HEADER_SIZE bytes).

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/nfc/llcp_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..e3b3077e0e83 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
 	u8 dsap, ssap, ptype;
 
+	if (skb->len < LLCP_HEADER_SIZE)
+		return;
+
 	ptype = nfc_llcp_ptype(skb);
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
-- 
2.43.0

