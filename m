Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1243CEEB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836789; cv=none; b=QKbgIleawRzBq+x/h1ye44s3CDV6zgmvG+QkSobj4PMFdXTPx9Ec9Odw5rin9LEV7XbPN7r+KW0YcZLI8nXcmCZoYZY0ntnuErFfTSfwxOegY9Z9sPB5tWrhaMfDykQKtGU6zTfI5JWCfg6tk9Zp9nkaHY2Ek/J/kn26hPfl84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836789; c=relaxed/simple;
	bh=u+qbjI2fqtSCTOFyNyQRWFkV4nE+Vu0WsBZjZ+K0mu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HK1yrrwiLaUgzowCoQWALEeJ6UdsnbSgUcy/FyUQeqOIu+0AfCJ9TYPK6B4OwGqSZyjVKh0862Lws6djbF3OrUCIt3Id3jy+K/ULwwg4ok4ntng4Cs9EEVVT8na8rm6A7dgqU+ce9El0tFER645FDJaydA/P2Gnee+7glsMSVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HdNe3JDT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HdNe3JDT"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ed3993c1eso222971585a.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785836787; x=1786441587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fLurtcdfbPDrwrOYOKC2dt7gwIoJWjPU2DGRANldOg=;
        b=HdNe3JDTVeQcrLj8ql1YpZr9ab8rbMFbrMJTWcxQbtWjVjRDPA759/C6h5sp4ezt7/
         MNU6yshv3nmt1LDf4+vDQqg3pf/BaQSLuMkyih6Qla6wyCJN1HFTWS0HTqU1vr51xGXw
         NmXC5bL8CvQvKqosIMlq6A6IC4n14qFQ6RX3b/wA3mk5We+KCC6lz2tV1pb3vLGxYFDO
         ao984HgIs+OvkJGSLh8tcjrr41javEk27ZeQpzQyIS1UkX5ak2l6gxv1rCS6U56/GaXt
         gLk/Z7OhlmXZBNAnXf7NraTeFve9aAcWlQ2PmN+PJhAvKIGvh0uTPSRDApVVrYuSaDF7
         uCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836787; x=1786441587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fLurtcdfbPDrwrOYOKC2dt7gwIoJWjPU2DGRANldOg=;
        b=FK64aln9GEiyRJ51CPJ6f5Fa+MD+4Sv4vlhiOba3jy7RbqRVzb50g+8eZcn5X2joE+
         QJBoOUo5gePZPr2D1kG0BUt1IRA+cwxvmpuIe814rFad/1961lzPJv45l3klj8HDFLR+
         UiHPHA2aBUnM7HJO9wty9FxT6/p9LYYErXdMs0arIypdLInzZxXKcftqy3N/F9UrG0P+
         74z5Vv6Bm1pJIC4kILbj62Dg73m85qsPHSVc/bT7z3XVDMnu/veKgJkWFotUmqI24kFX
         tuBCOGxRNk+YX3g50uF3VHlkySm0tRZns3MYtpYHZq0PJsQTkBaOcgLK/85EHx1G+kAR
         nR1A==
X-Forwarded-Encrypted: i=1; AHgh+RrD4TNhHhayE0qqC13wlEYkEwBUyEcuqxO3DG6cJWcucPrFdGJTrWzsKEYqYoNOlvtLhEiFY6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5c271mEt6OXe41OYQEsqv3n4C7Ohx43HoCfovwwvLGUxlnSO
	Kxa20v6CXlgjSrv+pwqPJBl/snZx1C6p40gRpCLNJGaM3ixOhE4VW5f0GICOW7Ik304=
X-Gm-Gg: AR+sD13PBAYeZPbB2Qt3V3IIt1XM7UPEe+VKFEOPuTdKVAAzP2lPOM/Sre21mk4PU2l
	rR30cAtb5fUJou8ZGmTjXwxaosw49fG8wdHKgBxtZEUHsa1jOAaRlVp3JqEu+EISzgfET9KwD/6
	LvlW6tnvlJHZu1R+JQh2nmh4j9QZXoWi1byKoZjU1MFwB8CzYZ8Z7fDW1ebaVRDCisktNGNpvgF
	u8Wl+IZGlJ3WR7Cqr3SfYZqyYBe8d6fqGLR7/Pn7QQhOaRUWE04diqE5C6r6STyg/wDnWShADOn
	GqMMRR5aDE10GYpe3QUIjbJucUw5a6GFzRyO3u4oWj+Be55zROIZQTwlykWReo+V/WLtvmlhDjd
	ULF5OQDzNs6ssKToJcRgPKqsCAr+9PDpYVGx3F7kZ54JO0H0aUNhsccpHm5JcI7UswOhBtK7YoK
	jhnoMq5RSVM7VMQ+5CXQrOOjnRvSUSnTL54EYVwa8TJinxwo+nK+c+sGzcqDcuxGYsbw==
X-Received: by 2002:a05:620a:600a:b0:933:4b51:d348 with SMTP id af79cd13be357-934a0aa680emr2563257285a.39.1785836787018;
        Tue, 04 Aug 2026 02:46:27 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-936417483aesm37886785a.15.2026.08.04.02.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:46:26 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v2] ipv6: seg6: clear IPv4 control block in End.DT4
Date: Tue,  4 Aug 2026 09:46:25 +0000
Message-ID: <20260804094625.715305-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

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
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Restore Kyle Zeng as the patch author and correct the sign-off chain.

v1: https://lore.kernel.org/all/20260731140832.567669-1-david.lee@trailofbits.com/

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
-- 
2.53.0
