Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172648;
	b=nsJBQ6Topdt970G4laxLRulhYhrsM2bVjniCc9a7tZa8Z3wsLoXKKwwh9BDi3CrZLHGx
	 hqLxoFQsNr/KjZTYyzSw27w7r/5EtVUJszz+Ix/k7K9aOcUGg2AkZUmEWcO5HFI90vRCO
	 oa83EISIGrgE896HkKDZTUh6PIgjSqxC8HRayYqDWMZwC3fa30inhBIUKcclEjgoQO1ld
	 K5sFNDwEZJL1nLfO9FKVAYIUZXvZUKfqM+oNUGBytLUqOvInPEgUhorsSgeQ+A0UZG4NT
	 5iYg4oJjZOHfm0XO6lFqECBfo2Yf+fSdAoEq8UMevtLDJ40Z7zZBpuRWE/rcnj5eqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BxvbLiLB44gG/WoazELJQFuN0Xy0A4FvSD5C1wEHAm0=;
	b=zINglrwlWfMBWpwlscEzb4PCB+6RaBP728hmM29/Jq5EZn2lic93f55OCUBYjgzoKsjV
	 auWiM9LdfPQNGD68SmQgQJdAyk61fp4bNl3pNkyaJxyMCRydxvbj+fxGnSx/G+xIUFLJr
	 ttPYsUNKzXuao88LbXznuQsCAY5zlIe/b+5CKWu4xKVdTmfz0f7oRexViB1rI5/HRaTaW
	 oVTZ5XN+LHlKMphJeiq+jnzT/sALVwkOLuF+4M65wXGtFY4xg/hOqQ9kJeZSB8ii7X90y
	 s6rvhPk+LJolJU6c91c06FkbwIKgSg8aECEdBzpvwU4bR1yq2z5o0B+XQfK1akpEIpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mRLRWAGe;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70744606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70744606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mRLRWAGe
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1137318f8f.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793172647; x=1793777447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BxvbLiLB44gG/WoazELJQFuN0Xy0A4FvSD5C1wEHAm0=;
        b=mRLRWAGeA7H3IjzneNLFO9sbSmrbIQlbKaZtyErWv88mhO9sN6uLpVULpwazRH+dzS
         Jyk9hRegs7Yg8WYupnu5k67TNdXbdnITqZKk4ntICHBWqMuYji9MyBMANJU5KEg/ohb1
         eiMjy0uF/zXdM41aGKmg/dCn8uDLKBT91hHuy59LG7SD/Eir1YivjuMA57XBZ64iDKLJ
         OINJmKrzc1KzPb5S0BA5caIOC1oQOJ9LVDQNESXHUkVfkqwnhXy+/oejsbs9TDeWOyMG
         EBLtcymiTiUE14f1U0/pUWX05hk3ny4VkJDb91cyeU4D0nNJK3U94VmYU3adVmua7y1g
         BudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793172647; x=1793777447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BxvbLiLB44gG/WoazELJQFuN0Xy0A4FvSD5C1wEHAm0=;
        b=tdynkN9zMOJa5VI9DSWUBV+U0f8/iy7cmjSb4/XFSEOVVPuBqSuTRC+2puYk/C0Lzi
         H/TvzWXWeWvDP2OGxt3auqlMwuxbTWPVfk8G/Lsi7oyEdc6KwfLU1hYvE7PX7WQ4i6Ph
         spPtTQDLkU237zQpNZWcqyl4QwJfb/tnLEeOhfA4qH46g3GCqQL7qF7aAFwnfl1nhTHD
         fHsYJhVjeRqLaHs+pmR52hYVgqwqgrPqSxJF11aU/qzgJCXYG2I3QHISzDB9c6oz5cMI
         E2bc8vjqRIyB99vb4Z+qZxrgVOxaFmUA+9OJB43CEfZHL3wh3I5ID/Qicg4+O4o7K+m8
         uPlA==
X-Forwarded-Encrypted: i=1; AKwUvBwqeumHnPfQM2nBZjwu9NZXdA9UJzs0/dRHYaQNyusRXeJGbvW3ExuRCmP18ucEMS7in9NVlaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJt2eSIGXnpDkkih0OZHUrta+FDftD8+LthRHoSEME98cYuRjyT
	ED0GmgVVjKwFG5qNBbhimzpRCdO2vHBlmyXAOVSN/QDvNy0P1q0bvvsA
X-Gm-Gg: AYBFou0wM5ZK0ckZ8C10xAhDeIluHLvQ5TlKEMBrib8vmuUMkhEhpdFBxB0wcAjGKeJ
	2Pj3t49jPzyghB1pLPrHkoiqN8COqtHNtrvpsosss+/2HGgMJT4PYGPn8GwHOmJZDTE8wbA7S6l
	7HFr6aHcQRfayf0exhy8C2gSxl3CeBFBcpotAG2uS46Hucbb8z1ScM1Y8QRJX2M515KCg5BSLHn
	b9LiMJjRU23STF9WdlfhBWy0gGWQFHI5MM/gn/G8Rms1jCPpARB+iKfbh1jo7suGQfmpuQk23ET
	icmJeY81BJV1QQ0z8K/vU+AafP7yCXqJMg9JhMIxsGqZuyF1KtdeJlO3f6giMbOt7Wr1Sc5KUzk
	ECUpQ1GefhZzNZjn8vZoSnR+Zaev9deD1aAnCbQ6HbF+5BnbD7lWZEvY5aUTe8g8K985mWOBWI2
	eWmBS7iOa5cXA480MYfiQ01S4Qt1vd4+JbV3V1GHhn0G++k/kPN1g4QRiqpcZZ94FtaA+ZAoz+K
	sG1iskdfnpwNjMRKkoO9r5cyQKuv95ZPoBPpjRf0Zaegp1xuDjXHt+A+CKhavJ6wiVtfmF6wrn9
	TzTKCmAu/1R5QbpAPri09N4yRPS4jqVntSozDgATjcMRNtrvHiWPO2Ft9td5aYldXTlqV/AF5pT
	jCd+4ai/RR2K4DKxACDCqfq4cWX+QP1p9Pg==
X-Received: by 2002:a05:6000:50a:b0:48d:ed95:3823 with SMTP id ffacd0b85a97d-48e60209cfcmr1021843f8f.11.1793172646645;
        Wed, 28 Oct 2026 00:30:46 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm12083088f8f.13.2026.10.28.00.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:30:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/4] net: phy: as21xxx: simple series for trivial fixes
Date: Wed, 28 Oct 2026 08:30:18 +0100
Message-ID: <20261028073024.25175-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This is a simple series to account some fixes for some corner
case for as21xxx

Changes v3:
- Rework to address some comments from sashiko

Changes v2:
- Add review tag

Christian Marangi (4):
  net: phy: as21xxx: handle stale link status during autoneg
  net: phy: as21xxx: fix read_status speed handling
  net: phy: as21xxx: force C45 OPs for AUTONEG
  net: phy: as21xxx: handle odd firmware on loading

 drivers/net/phy/as21xxx.c | 180 ++++++++++++++++++++++++++++----------
 1 file changed, 136 insertions(+), 44 deletions(-)

-- 
2.55.0

