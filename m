Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DF43F4A7
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837074; cv=none; b=aVSRQ8BBdEirHuEEJK1xi3ttv58T7FU3wgLprKvP4YkoEqN90Oe8qAqd0cf+A95LUc7+BlDtOOaqAWYGuNOA4PXRcCkZpqGMReP+gEKxgb5udxdHxjlWaHrJqD8ofR75KLENesZ9Wk0KTLpkEBUZe0k5z8dzhS06n/ZtI+J+IKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837074; c=relaxed/simple;
	bh=lC/ducdV2H7jnVxT/7JAc5laSsEQNeSS4QDRVHC1kpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh32V254mxgRIlooYQGpV6SIaeb6t+/j9k77eNrd1wAsTFj0x+sA6qin8dOEWSjqGrg5rTdgjZdgHZA/b+oFz40uXwHRkv5YI90tcxZgt/53xyKPkw5vajtphb//DRp4kixQGEqUQQHYZUjhcW0c/9PqpRq5XSCstAvbt1MRInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=dVsE9+Ky; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="dVsE9+Ky"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930f618435cso242492185a.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785837068; x=1786441868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yj5OkcleFZPhIcxhaAKqjQ7zy2dYnyYbcjjyfgxvOKY=;
        b=dVsE9+Ky2pGjCOAWGNXUPhoYv4/xmYSr6SO6xKO5/UNED+i8cDsVc8075+1wktK77e
         LPxpMoHktevqqg8KZCzdvwDp3lyY2zieJqM0LLrfN8o2UvBeid6lcsi1TFJmXdz8H0du
         KOw3iHisuqEA6UgUxFtTk1Mzax2NMro/R+RnV5DKPyAXLh4QyxT37b2q9SOvblDkOMGZ
         I6yH1al4B03sXT5WmjxsJLzPdp+9cZeFTF5/E7pA7BmPr2KWNbpBB5ET/Qf3LnNLT1mF
         BtcV6taYiwwEqmKm2CYfYlGTQvI08qb0D9ZP96d2zRSQxUMY/jm8UcRFGrG83XyzpX8M
         8ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837068; x=1786441868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yj5OkcleFZPhIcxhaAKqjQ7zy2dYnyYbcjjyfgxvOKY=;
        b=FUiJlY56fcalnfc1YbpmE48D/JqpKB/uNQIR2bGdqbQ4VO+AbD5QM4SEn/C9sKzl9I
         Ftde/PpDqKnCvy6y4aX2r276a6Iy8mLub1nHhn1ct/TjZOZ9BYj1hvbMO9zTQl5Ss6mA
         EMwTn/L7d70wCWBHWINduk0OKKYPA0O/rV8TlTdp6RCZWAIzf92w0ri5bf+QQQzRCefY
         xrAHlg0mjlB9VAhA7sM2EPg0PQCDon4P6rUzIgBQXelsw65VczPXrOJ34d9gjgo/Xye0
         HIujZvAPqTKF4iXCP1oDIz4Mfl8Fl8tdkVSR1jSUVkkqfaAurZoWqkCOnnZzFQ+Qn9U0
         2n8A==
X-Forwarded-Encrypted: i=1; AHgh+Rrlpk9uj38KnxSsiEVa6u5nCaix8B53vtUJTEGYx5E9avOa/iM7sqsI1rUbmjki0DOuoRCT0SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhPmzeCm/JAU/IDIhyKPMffhcYWlMuMb9NHpTOPlkUoucAOXG
	OPIEiZwGXdfcUXBLvR3o10QmrlgscAl71+uwJpViRJuizv0hbRAtvD74grrzsfxg4NM=
X-Gm-Gg: AR+sD10uZay6qycT/rCfrOJ964z7pRlihRK0UnWB7196jUQAY6N/yJxP7Kn86CN/dMM
	1qSrX+3Ubx/B1eCdmhq9ebF1aK4x37h8wkkPk6fb2FuF+PdcyHkRebeqTJFV0TpOGxaVC54/CqE
	QX468/wV8dyJjsYUcLKhlpMJ3hdva34fknsrfdaerNw3mpUO5wVi1DD8phJPmbAn7A4Ybzr6U93
	QmJoZMkXqfByS/s3vpKWiK2NoW/mSBK3AdFU1NzUMzMoI5Cq6noZDG4z1tYXdycrzUyNTdBnKVR
	4FXVdSOgHvSlpl3EsMEpbwomNUP0teRhpRJwVhkEPb56N60DnX0XmEI6GjXivvECBfyN0xc/pRa
	174Ic1OKlqIzyoaRu6J3BDTgY5IVBBtdbnpRXLwZc/0vTrsvSwbk1ICDcRWgxzuayXCMlNkUJUu
	3vowqaP/N5QiIpA43K2mAkeaCLkdpvqGhIv3RgQQGJXduXHvwNHyFd+CNAEEUAybtC2w==
X-Received: by 2002:a05:620a:1003:b0:92e:9cc7:fa46 with SMTP id af79cd13be357-934a08b94e9mr2103243085a.21.1785837067707;
        Tue, 04 Aug 2026 02:51:07 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-93641756c67sm39269185a.19.2026.08.04.02.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:51:07 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: pablo@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	phil@nwl.cc,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH nf] netfilter: nf_reject_ipv4: initialize IPCB at inet ingress
Date: Tue,  4 Aug 2026 09:51:05 +0000
Message-ID: <20260804095105.715387-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

The inet ingress hook runs before ip_rcv_core(), so IPCB has not been
initialized when nft_reject_inet passes an IPv4 packet to
nf_send_unreach(). skb->cb can therefore retain data from an earlier
protocol layer.

icmp_send() treats IPCB(skb)->opt as parsed IPv4 options. Stale option
offsets can make __ip_options_echo() copy an attacker-controlled length
into its 40-byte reply option buffer and overflow the stack.

Clear IPCB for NF_INET_INGRESS and restore its input interface, matching
the initialization normally performed by ip_rcv_core().

Fixes: 117ca1f8920c ("netfilter: nft_reject_inet: allow to use reject from inet ingress")
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN stack-out-of-bounds write in __ip_options_echo() and can share
if needed.

 net/ipv4/netfilter/nf_reject_ipv4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 4626dc468..4933f6513 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -355,6 +355,12 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
+	/* Inet ingress runs before IPv4 initializes IPCB. */
+	if (hook == NF_INET_INGRESS) {
+		memset(IPCB(skb_in), 0, sizeof(*IPCB(skb_in)));
+		IPCB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (skb_csum_unnecessary(skb_in) ||
 	    !nf_reject_verify_csum(skb_in, dataoff, proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
-- 
2.53.0
