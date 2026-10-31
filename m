Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454917;
	b=p96m+zF0BrZB1Rrxt+eie7zJgU8jpFdzBfr/DkU09AM9oSai44g2e/LXYqDn7uz2O3Xi
	 q9fPpvJcHaW+oN2wa34IijGA0exkwbIA7Ct/q8kA/JnMivJQMqNwtHtIkMqLwL1vIV6n1
	 QYBLNk3C0A3Yu7zb+1mtopLteUDEOEXnjzwWT35v3IkLHLosPqdHiO2Bpz5+BTS2WVRJu
	 cncfyIJC0h6R70ZR9cOiXKvSpvVrreljo+wzEFnl9NtBtxLTdGIGV7+qLq1gc+S5JTKYe
	 swnQo/v9qZlizmUbh8attXjbzrhsbFkAM/z9lYAehrz8ldGGxGcbI0wOUoJKBKweaiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I5rTYNBg93GkPQ/X9Ob6AKqCVrWqJmhPtELY2wGwpi4=;
	b=RV/6A5EfAq7mB2OFwT9mz0p/w344XC3YVe/wlT0+fEnkCtgEq3NNL05KBGsDcrd8PmhU
	 3VcX30v87LpvDEP4AkeBX5ekQSyZ6ZzSZAUEfoj6sykFt6LfF8eNN9rBjC4d7EJSqzay7
	 2vCvR3jxUW/xNUnOx0XppuXM/pevrdD9WVeq7JhsPIYydy9dc5MeDiafKU/jB+U9/WC8C
	 kOsgzbRT8W5YQlU1uyDz0AJ21KFWf7J9+VvuqyymKtXLipVCo4ih7NcFS1WNXQS66oGyi
	 r5FBhBGayTxiR0IzjMIgAkpa+hk+Lyx8xin0lScRMOrJHQcDc0Bgq/nWAOZdWQrSERg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9Svykr2;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25ED606A32F
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25ED606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9Svykr2
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1432881f8f.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793454915; x=1794059715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I5rTYNBg93GkPQ/X9Ob6AKqCVrWqJmhPtELY2wGwpi4=;
        b=k9Svykr2jKaa/sY+Wmyo0/e0TLiFsBBAf0wnERQDuEXikSnXkUNocG/0PZgd126awm
         ss/luS7fQeTtUXpuP54e5NpKQDjDXHWsKNCUiUyH3PNLZGfY2iQ2vn2hlNuT702mo94n
         HUvy3BAUVQ+ncT9uznSAiKEMLIBoUlDVyR3QusvavK/NELy70zYZ0Fkxbnqu1dyDbZj2
         I89I2xX6G1jM6pv4/X0RuI1kRg2tornRhrxDi1l4yljVPiinQZbCbJdLXXLuVOfxwgCv
         uMaIVeix1DN4ksquuq+tR6uIRU/or6glM2/ojbMBIaljm4ZSUfIQBuZ96PlxtB0mdmoL
         /SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793454915; x=1794059715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5rTYNBg93GkPQ/X9Ob6AKqCVrWqJmhPtELY2wGwpi4=;
        b=Lbb5/d/CRc+YLaENhvlk/ifSODTFPj3z5rQ4cxHkVgY6jhaaFIVr1KsfEhpJvs6xAE
         ByA3QOTJtmbi/lJt0ev00Ck2Ujt/tn8xSzP8C9+M7KnStU3HVB58RG3P93dKL63XODoI
         MH7ZBH6hoaYxq3MvF3n6xHFUzefH7C7aI181r5fDbZtaDpIES1LZbLOTD4pzL1Wzp6KI
         ujgew5So5rdrG7hmaNr7QDRtPKVC+vVXp3fqnu9iAz8Yf9Mn86p+6tBlmTF2oZ/SvlzT
         aJSmyHoTZ/hcfXDOuJVJsfeUROR4Wv5GAgf8ANaemOllH0RVRb5U6Sij8bt6Vy3Iuf+O
         m2Pw==
X-Gm-Message-State: AFq9FYJcaFA2Gb319cR5A9CAgKMWnidKXHlWDPSCxdLHEIo0peBDNt+m
	vYIh/rL3L8hG68FsyYtWU3B3Fl6TMf9zIJf6Mp/QTb9gHoWtA4xRWbvNXhjaG6HWOqqYbA==
X-Gm-Gg: AYBFou2m5Vjno9WWwuyq1OwrQpTTDJ5XmN3EDfGBnkfeMjUnIYiT2bcKs0SCYk05TeS
	ckITnTt8j0y4ziVk1f8Kg2HyU6RC3bXmMiIY/EzxcXK4otcLg6sjopPVFgmXkZrCSne9abOftBd
	H6BWIZguqiyLDo/2zInZUvhepryHTo1FBbQacsuXSo3V48JCCXDucnAVP6/m8vvlgitcIpHlrKQ
	Mf7z0jfsN490cGN/nOSRITXVrtkmboapj/psHeddyAqPn0rcu6KU4MY2wfv0DRf0oOTTby+YATK
	v+LwxBufsBFHV71vPRd95VmrO/C4U+FNXZDWim11UxQBuBO7YLzO6aF4LCYuUhd0Reh0zA43Jdv
	lH2hv9hP1OGL0n+CwexgVq2HjgD/JG/oEouHlVPx0OXJ2sNClMSGA3xlVVDgLWoV5QKi1UsBb83
	tqmQxygXbbEFUAxofm3RPwSOPB0wD8ttT1J9TbZ3CdHdgi78Ctu7AgJOZ52duT3vOzxxWTjTKiT
	uC+RCEQ9bdHxc7Vp+7jiOPqW1Dr3QF5NjeS3xSScXpGdlQon5UFu25jOMltLrS0DXPKKMrekzx+
	Sfnj67XM70yzwnV83xNx2BDCvKJV943c9i8Y0UR0kbKH
X-Received: by 2002:a05:600c:4687:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4ac16fa4dadmr119482965e9.7.1793454911802;
        Sat, 31 Oct 2026 06:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa820492cesm226304455e9.13.2026.10.31.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:55:11 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	almasrymina@google.com,
	josef@toxicpanda.com,
	jiayuan.chen@linux.dev,
	toke@toke.dk,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] net: parse the eighth nested VLAN tag
Date: Sat, 31 Oct 2026 15:55:08 +0200
Message-ID: <20261031135507.3970551-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

__vlan_get_protocol_offset() starts with VLAN_MAX_DEPTH (8) but
pre-decrements parse_depth before checking it. This rejects the eighth
VLAN header and returns protocol 0 instead of the encapsulated EtherType.

Check the counter before decrementing it, allowing eight nested tags
while continuing to reject a ninth. A compiled source-extracted test of
the helper and its public inline wrapper reproduces the incorrect result
for eight tags and verifies the corrected result. Seven-tag, nine-tag,
and truncated-header controls are unchanged.

Fixes: 469aceddfa3e ("vlan: consolidate VLAN parsing code and limit max parsing depth")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..b10ce1d46674 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7703,7 +7703,7 @@ struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
 
 		vh = skb_header_pointer(skb, mac_offset + vlan_depth,
 					sizeof(vhdr), &vhdr);
-		if (unlikely(!vh || !--parse_depth))
+		if (unlikely(!vh || !parse_depth--))
 			return (struct vlan_type_depth) { 0 };
 
 		type = vh->h_vlan_encapsulated_proto;

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.43.0

