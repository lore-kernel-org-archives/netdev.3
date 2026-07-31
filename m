Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9221427A03
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506918; cv=none; b=plb4i+PaZ8r76sE2QMJ/vr+XiIvgCE0tmdauUheaCej/k6fpXxKcAdpmdliTh40MY18TBF2p35dB7HrMoq1Z42kXry0fWYXopk0LU6wue0CU0JZnO6AHjRHwLlBJtGiUFTHmVywnJhSvJ/j2XQmKBMpfO+sygEMG7WRgeNMhZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506918; c=relaxed/simple;
	bh=TNAiRhb5EcxjzXOjZApnIdLZOKqLv0olTBWt6Lo9Edk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ts3cXsdmkTrRWh6YL/SHiw87k3LRbVPI0d/k2ANVM0OyRXEB+GhTXKnkayTEqfEFJ8UwkUYAddPJu0GObeIW/iWkzUzlQJfIYvJDBAzlV2ul4sFyKD3Y6d/iRYbYsB2H1sd0vAD6U0JJOXHSNrYY5G65RZkg68ZmxvOJbzMkOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=iLFP7Zsl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="iLFP7Zsl"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92f03daaa97so59596785a.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785506914; x=1786111714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9N5ruiliFC0RRzq0cPs5f4pBlnCCs4Mh2s6pulHCe0=;
        b=iLFP7ZsluxzwyxyK+5H3oVM1WNobdGls2YjW+AZMWQaTzWc1VqYQWt1Nz2kqSPdnEm
         KByoHUjB76hFITEkNrz9QPFm9UsUSZzk/915Dp+iSnc1fLcamLzQ6eNIHm4sKFHA93PG
         Mtq1oE7MV8DTjEXshFRfxFHaEg6k2yzlZRLwlKiTzhDdwylcGzu6i4+N8ecnGXfsuhp9
         8FnpRJKr9mula6lPgrPOB14c0NXIWFpCW3DRe/fno2KghGjUnf5nPxkImx1Zn4o8lcHy
         dZLKZWMl/B2BYHwBUs9NvoF3r39KHoWFdWbMUcdOG8DT+8wQWtlfqZiRDH1V6l6optm+
         ZYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506914; x=1786111714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9N5ruiliFC0RRzq0cPs5f4pBlnCCs4Mh2s6pulHCe0=;
        b=MJhUdWRuMhBq7VfoDpTZs6OqadgUkl2bkCSyMsOHok1ibdHneceqt1a7E2lrg9HUvn
         +0+1R/aMnsbZ80hPCu7f+wgOICz0Czd3YnMsIyjNtbZjwekGicSMBwbCSryOtqGTTj1l
         /DNgPHjHyxDTndVq0HuFmWDM7eUHc0d3yufJhHdlDHrUbhEwonufivNKN8SXi7aPbOhD
         2FvyIUT4dvoxqn6HjsmG4XpTW5Xp9vIepEQ/jBMUKbmdYm8HrFJdreSSxN8vo9vlbBrm
         RmIG2Qb+hyM2JP8TMGwhi73amJXjw1xWGBTEyRwK6e/T3ku07HDxscxNJ/71fxy902Oo
         yHUw==
X-Forwarded-Encrypted: i=1; AHgh+RpZAHYwUP1xb/yx43+y3wotNCospvdseDngSCvt2mG2Kzt+ZK+BsdLfbN1nLEP2LA3jFURMHq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDbjdsh4eIlxYSrHdkOGUNycr5E7FXCO30F0LjybjLOhaUVMR
	C997zd5zvO6E5/1UsJ5S2rTyEDc0sj2X1FA5nT4wswtmBnOrN7/HBwGBrAAnYp9mpgc=
X-Gm-Gg: AR+sD11tvqxdEFaphoFToxKQ2Wyq7LkbYKFYBzYdMMdS/ad2uTm5LMEDxA28U5opvTO
	x0HRdJzL32Ba3UYaiwA/4k0vYriph2WdKe3E863npXmFe2R03bT9MoD2Im8WThm5hzF0Gtk/jmx
	AFeJPE+TuBMSKPAjjIPdsWjkX89tFJTaeGVMiqIt3lyjCr427AFthw2y53RkmboTQZUyNnf1r4W
	pk8HWpqSS/EQl/Wf97ogKdvigo9aEvrZvpTIWBAw7sjLPKeaHJlC6ABYlppE1k+uB19tHS7b/5S
	FQeKUA5w2BC62v9bwkjJVsVr/rxVS/vO9j9KZzhFmEHVRWCdr3C+9bIgzEf6qrI39MNoLktY+uD
	tkT0J0zpSsm9+dcvzCX4p8U+ehPRHpeHajPArIUXfVcyt9g7IK2Ap4cH95St0GHSEfHp5RSm2p3
	1RDyuydo9W5Qnth3zp79Mlg0Y1tbRwO3ekZcgLa+xRkjO4NqnY6HJRh1ekjavO2vAJcw==
X-Received: by 2002:a05:620a:2792:b0:92e:e125:55bb with SMTP id af79cd13be357-934a0750096mr20709385a.4.1785506914065;
        Fri, 31 Jul 2026 07:08:34 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9349bb03912sm64752485a.0.2026.07.31.07.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:08:33 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: seg6: clear IPv4 control block in End.DT4
Date: Fri, 31 Jul 2026 14:08:32 +0000
Message-ID: <20260731140832.567669-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The End.DT4 input path decapsulates an IPv4 packet and sends it
directly to ip_route_input() and dst_input(). It therefore bypasses
ip_rcv_core(), which normally clears IPCB. The skb still contains
IP6CB data from the outer packet, and IPv6 extension-header offsets
overlap the IPv4 option fields. This can make __ip_options_echo()
copy beyond the allocation for saved options.

Clear IPCB after validating the inner IPv4 header and preserve the
ingress interface as ip_rcv_core() does. This prevents outer IPv6
metadata from being interpreted as inner IPv4 options.

Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a KASAN
slab-out-of-bounds write in __ip_options_echo() and can share if needed.

 net/ipv6/seg6_local.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0d..d03b377f5 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1186,6 +1186,9 @@ static int input_action_end_dt4(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
 		goto drop;
 
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+	IPCB(skb)->iif = skb->skb_iif;
+
 	skb = end_dt_vrf_core(skb, slwt, AF_INET);
 	if (!skb)
 		/* packet has been processed and consumed by the VRF */
