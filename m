Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238507;
	b=qmwYg5apgGWj95K/WKSTgOFVRE97l9f6UQcqHKwqAZLhbHqgF0V7hBOEEvxutxObQuu7
	 YzhbWl9Iz0tQa8/bPXPPp2+XqPDJjNvwgFChauYH8qMbgwXNGeh+fXSqVZsfrYnocKBl4
	 ziVymNORtUG9oEN8E3/X9gB8EAFHyHGOVq7WoRrPxAxnDJEp+1jJkv0vD8II9vPfeFrlT
	 X2PTqBnZuzu4267p9ZzEyp6Zmq7FXo7cFFoEi/KIAdJjCDu/o8onM79renur3ZKPBiAMM
	 OgXxXn1SiTLDuDgL64sqyIT7iJase24urEhP8cDHNITvODNxYg80/FF1gu9IwzzAwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CizwUurk70X7nA6lsoO7aEQ60mrXQuJaTvlwdSJU5lg=;
	b=w65kQ24z62VWqB1MfAkLSpcRCT0OE5Y6lkCYNi0Qj4HU11w1jVomODVEF294HHZ8pI2C
	 qiBRy0EKEE/okDW1StdHYJw8Y1bwD+NPp6L20sXUVTJa03W/gvVNurRXVLO++2IsyLK+b
	 NnmHhgNIdeq62KZG/MCzJlo2vTjnhLthQBtVcQfRvMh3wucNNBjcLUvtWym9eWFaEyzCp
	 YjLapxdZ+67fBN4RpuydqESr7mXf3UKHNVmhkdf4ZQADkt9UR+uhOpOMS0GgReS4XZ3WL
	 SFqkbaSMDOleubxq+KMM9eDGHl6IbAWcwd0o51cbdIFRZVu1XeONSaFH68rkGctxBlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2nZmVXp;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8D606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 15:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F8D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2nZmVXp
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso496029a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238507; x=1794843307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CizwUurk70X7nA6lsoO7aEQ60mrXQuJaTvlwdSJU5lg=;
        b=M2nZmVXpfQEke+a6ivWmJK0LjYpReYErCtc6TwvFIZi3+Ul0BRW4SJquWnHe8RzcvK
         JKYQ5dG7hD3IhdXKYz21CEjPGH7uEk/LVAv5rk6g7TOr2JI5BAaiPXsX/YheFFJGDI51
         PdKuKcmSDyv9f2jCxxgGXDH2mjB5PGhtsqGyP9fK2GnxFSIkmYvte7VoX76eFavrIQ4e
         dh97gMal6pPNfVvU18SXm3Oq1ZeMflZ0QOVo00bxOC8CFjEI+lH0rG9OyHR/oFUdaYpK
         ajPMLFx2TlvdfOUfM12L1UPYDBHaX2FG0Gyp6ob1W7uPGfgRDs9V/3XNQrGjQ/3xPKEr
         vxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238507; x=1794843307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CizwUurk70X7nA6lsoO7aEQ60mrXQuJaTvlwdSJU5lg=;
        b=WNE5UBetQq48UWhK/QYmP99SuncxC7UQIbtwb7SutA5oWhp36ZvNdL/aPcDc/+uIJg
         sm4B1rhUeD9G+ELYEoGdtIUaxwHMe78OjtcIBS4Bx/9p6zFtjavOOAmTt9LycJomxJe+
         da1/TemyPLW9NaX1XNP/wqQmIutcnOkKa9YV67gU4H5pS5GXKVrq3RPwpPqi66NL6zVT
         8PHcgWY+aVIuedPhp2e3jh5aSm989BEUa22yJnOsU3CYDGeJZuJ0DMqbLAVfZIKHOvUq
         WnRlF07b6iTs3J4+xPX4d7/Uu1X0YznFyV1L6IiHibWu09ov9ZWEPoa5+eshlZkJ76pu
         GXdA==
X-Gm-Message-State: APuU4Z9j1s5u73voG/JteT446FZscjzN5vS/8GB9eyAUq85DSwuIKwya
	urj78cdEbJWAevL4sa2bDWDCDON4e9lrQZ3fo7oUC451zImw3UCNf3SeGjhTDbQh
X-Gm-Gg: AYBFou0ucIjlkvwUmjF1N8rVr23bsbA4J7fG0SUnlV6ngSLDeMSCvKkLGMj47MeZCUo
	MT7f45m/pTS1wCIuHbSSWTcs+bo4aUh1AJMdong3d15f2S+MdDlp+/atvy4sCqDsQNYOtJoo5P4
	bl2g8IpDzhRifH0GTLvdD4s3C+bMPYeD5r6GudGh5NhWC8777PRRDwNGqNnasjo82+PO+bVe9AG
	ivUlxHClxbEb6nSC8u8hO1I0iSZ9Ve/D/NMF8wEZo0ld2GB7oxDdHeeSmQYPXRxb38rSyfX6kZc
	W/6nFO16dfx5ZbMTlabLddwaFu+Lf4rqKdHG/pLPpHqG1KQhn3WvRr2Xx2B3DxQXx9VjB3RotzX
	mF9p+2Fv2+xi12SkkklE0C8rd/RVHbB529pU+iv3e0PrGfHc8oVcWdsgITCpCV1AjM/NXXe5i0d
	elm7ptEaiOTMhSwdY6TT81+2RbTKpRxTRaLB3MT0Z90KgNY5iKMKVRD0FoUYTtwrESpC83cpx1i
	Tyv0pLCd4ebPP51Ce6iiTD+NcYSbzF5iZN9o1umY/qBR2Q1W/iFAqRtv7huusDGvsq3eO3TGOIJ
	ir1xXFfNMQW7NsxPg2kotI66kSOosZwfjtmBQWy06li7DouOJlE4Wy7s0AIqejdmqCTj6NHuBIY
	=
X-Received: by 2002:a05:6a21:3e02:b0:3e0:f07d:a73 with SMTP id adf61e73a8af0-3eed3c68071mr3299886637.33.1794238506548;
        Mon, 09 Nov 2026 07:35:06 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd88e5fed3sm321246a12.8.2026.11.09.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:35:06 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: motorcomm: Do not inherit ports from dynamic FDB entries
Date: Mon,  9 Nov 2026 23:34:04 +0800
Message-ID: <20261109153407.1761032-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When adding an fdb/mdb entry that the hardware has already learned as
dynamic, the learned ports were silently converted into the static
entry, which DSA loses track of; the entry is silently expanded and can
never be deleted. Replace the port mask instead of merging when the
existing entry is not static.

Found by code inspection.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index a7a9a7439304..6efd74e7eac6 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -805,7 +805,10 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 
 	ctrl1 = val1 & ~YT921X_FDB_IO1_STATUS_M;
 	ctrl1 |= YT921X_FDB_IO1_STATUS_STATIC;
-	ctrl2 = val2 | YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	ctrl2 = val2;
+	if (ctrl1 != val1)
+		ctrl2 &= ~YT921X_FDB_IO2_EGR_PORTS_M;
+	ctrl2 |= YT921X_FDB_IO2_EGR_PORTS(ports_mask);
 	if (ctrl1 == val1 && ctrl2 == val2)
 		return 0;
 
-- 
2.53.0

