Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D4C2DB7B9
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258683; cv=none; b=FlOuP8zZR0v8wy4UXNy+2JsHQn+SSEa0zShBaig1uePCMotQ21fB4huuEuBCJ4RTPGBlyNJdzf/9NQXsodh2iOwth9eKn7iKUjHhTQQ8xHLsPpmeTDjK01TBlWR/uOSPeugZWQpx8Kn7OcS4/brKp5ATCUP93im9ZbBQ/NmbqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258683; c=relaxed/simple;
	bh=Ir+3VZ2zUPJJ2Bpgho/LS59fIOQGtDWwRnbNY1NTsgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gTcDrysmeTB8iZgp71CuBsqhdmKdw6Uf8aB1Qr/lGU2uwW/0VK+MX5hQyhXADr/NelY5Ij6l1jnI9Nm/M9iEAtgInAFWUJbTzxR4Jaw6xj5i44v+soaduQTKXqmu5/v1Fhdg3llWkn8P/W9AQpRaxuPQlAy1vqx4guppWV3RH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZawFPgLL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZawFPgLL"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so104661a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791258681; x=1791863481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRiw2Vgxh1YIHzRLkUmzeJDin7CCSX1G4+FoDmEDtqw=;
        b=ZawFPgLLNuVLd4DMGjFRg7yd/3mfW4gJA5gvqfbXL4gZBgv2dU1uom9Gr3Ee9Bw+WY
         m/NPiwzjjNDnA1PtqyyM6cwpbnwT7mABnMAsIYuPPmQRzwXvzXMnRwuj4YiL1Q0xlmvy
         9EsUvH1vQQ2T0wezF65oOH3XGIgcH1UdG/WO+sZhMZiSX6um25rXjot93keVNvoRLTwt
         vdgnpWImjY0vDL8ZuaD6MhL2DVnCexpOQahgf0e2ZbJIyPxYp/cEDbL3VWUI6zA4vGnO
         5a6jRw1xsV1UJJAWaMssz4Ukps80MBJQ3o/1EuF8WxpTCJ/2TB6ClrlN2kYneU8gokGs
         TFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791258681; x=1791863481;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fRiw2Vgxh1YIHzRLkUmzeJDin7CCSX1G4+FoDmEDtqw=;
        b=WM6u6kWWWpIxpU5Tsj+89HaZnA04ueO1qmdrP5nQAQXoYf518vmYCT2kacZSAaoxWD
         yZuTm2uZL64VhtF34iVw0ZqDCPTt4dnlddFqslAyS6WgWRBbQm1scb6WXDUJrKqryanU
         DySYUZpSSppSGQ+STHNbGL+qmn1NeWqSTT8YjPRqVcY2EvR2LYrH68F+NAbKhGd8Bxkp
         IvPf0NVXChUUTlPCR3ciAq4QAEIlYKk830dNUbm22yrylac5KPDA7tPE1Yz/qkIArrMw
         bysnC2O4Af5SS21z3AU1x2y2LP3aomCWuuWlhWcnm5mAJb4Iagqoa/8j1qSNOQV/hGo8
         jEKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP0ZZYIlMgnqvMF1tdCioNMHwd4li0JTn2d8hRzp87sJf0F3B1T12JIayXbHG3Y3U5b2eTv6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2eQT8E6b2uUT5pn9UXerv3wz8T5NsgH50fvW3t31J/88hs5MB
	6qe46VtTR32QSiOphQf9PqIHF5fjwlm8iMCCpBPKe6SxEMkowYgm7nwN
X-Gm-Gg: AYBFou3omsJU4PN+t/d9rGH3dZFmTPE+jAm36eqfaME0lAvfpiNm3FPagZ6rjNbeuJa
	wXhmWe7panHTfWyMcLcM37N4MMyS0vBzm+bKv686MUisRSxaM14OrovAx0bmT7RTvUtWBLaZBqj
	cV2qh6vSIzplSoHQ5N3MZ271ja0oZblyexO2dN62aBgMOp78iN/Imv8HEajbr91EGom6CYslvRB
	7IWM+0BbtzdHSLyzZi8N9Dskv4+9MiMt1HFHCpc7UKSxbP9hKiojE+c7OsLOeZXf40p5RYYG0pH
	6/W3qyUF4sN3ohOgPvB+24XWK2zrtq9BT4LWsL+DA7UDb7WWX7NF17lp6KKuYUxYcTeHfIxqgQ7
	RwgBEVKZ5ThKifmbPGeIiJXbjzU0KHrQuxIGvB3QBTLMJ0o33AwMc60TN4o6ANdTZOlbWWhN8hU
	SNNjBUrdiTALp+FpbEQd9xsFqRwwlUMzlEvPlSQPa0dhAL2ZpHopfP8c/VKyS6W6CyeedCESCYP
	gAe7nMutXU=
X-Received: by 2002:a17:90b:1c0c:b0:3a6:d30f:4658 with SMTP id 98e67ed59e1d1-3a8545cfef5mr981532a91.27.1791258680963;
        Mon, 05 Oct 2026 20:51:20 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5f001d9sm15634005ad.79.2026.10.05.20.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:51:20 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2] cipso: adjust cached option offsets when removing CIPSO
Date: Tue,  6 Oct 2026 12:51:08 +0900
Message-ID: <20261006035108.3101440-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cipso_v4_skbuff_delattr() removes the CIPSO bytes but does not adjust
cached offsets for options that follow them.

For example, with a valid 10-byte CIPSO option followed by a seven-byte
RR option, parsing records rr at offset 30.  Removing CIPSO moves RR to
offset 20, while the cached offset remains 30.  Consumers such as
ip_forward_options() and __ip_options_echo() then access the wrong bytes;
the latter may interpret packet data as the option length and copy it into
fixed-size option storage.

Mirror cipso_v4_delopt() and subtract cipso_len from the srr, rr, ts and
router_alert offsets when they follow CIPSO.  cipso_len is the distance
the first memmove() shifts those options.  The later header move and
network-header reset relocate the bytes and their offset base together.

Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options")
Cc: stable@vger.kernel.org
Reviewed-by: Ondrej Mosnáček <omosnacek@gmail.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Replace the parser-invalid 8-byte example with a valid 10-byte one.
- Move the offset updates beside the other option metadata updates.

Link: https://lore.kernel.org/netdev/20260930140400.2955466-1-4ncienth@gmail.com/

 net/ipv4/cipso_ipv4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index a05aa075de1a5b..1aacbbeffbc647 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2287,6 +2287,14 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	       new_hdr_len - new_hdr_len_actual);
 
 	opt->optlen -= hdr_len_delta;
+	if (opt->srr > opt->cipso)
+		opt->srr -= cipso_len;
+	if (opt->rr > opt->cipso)
+		opt->rr -= cipso_len;
+	if (opt->ts > opt->cipso)
+		opt->ts -= cipso_len;
+	if (opt->router_alert > opt->cipso)
+		opt->router_alert -= cipso_len;
 	opt->cipso = 0;
 	opt->is_changed = 1;
 	if (hdr_len_delta != 0) {

base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
-- 
2.55.0
