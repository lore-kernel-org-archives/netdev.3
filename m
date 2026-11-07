Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053838;
	b=s+cebMRoxDMsMPXN/TENBLIG4AyjGAZ+zobaxCr+NS3SZxyBYn/IGzfA1E0niSytmcYQ
	 /526zlpe/ocffuvihtUWo64FTlcs6YFUqkDYpx/j+EqkEPTMAeGAAHGZvyY++fndMR3y4
	 iUAYyrhARRT9unrytC3nboSmIufv0RLzuHmQ5YE61Y2/L8BmlWsKkr5YBR7/9Pu73C9vl
	 bw4hOyNHcYgrEI/rJ8jWM5Du/rLqUNhNWKii0IjWjUI3DbXIC0VKEZYTSocGmqMqK0PxJ
	 VvmSsbetUhIujNC+DOHDWkq5YmwJ2UKWuFhI+sjxy5Nns5Opa2whOYEkuyQnSGJgx2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xnQeGBiEH8XniaPdtXo6TRG8fMURfPvZnz3uNdKFs0A=;
	b=lZ14HdCcAVBQr6lSM3+yLiYZ4R3vugFlL7oBZQsydFnVi5NEOnR+RRST6DTiGMtzqFXi
	 yWV9z+17dEhXTGQ6rCN0pLETinXQEKh84Ps/f0uYTzHDKvqO/46g8Q26SiznJ8UeutFi8
	 DdALgTXl0IbeZzDQ4AFODi1IjlJwvpGLXSAKwLnG3Y6V24gVSdrRGyE7KP292Iax5RUPZ
	 Z+xzPtvymTqf/YP/jl9EXrcyPSEeWcurJG4I3arqwkN1a58rVoLA2Xy9P7WbIMOZHxrnZ
	 kJzvZOwfBRRXlUOU4Kiv/VwFw5mYY/oZ7En4PGjhTNNHK8SLDj1ul9RZvfKwSwHUMzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgdCrNB3;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A82606A334
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0A82606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgdCrNB3
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e98798cbddso6944405ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053837; x=1794658637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnQeGBiEH8XniaPdtXo6TRG8fMURfPvZnz3uNdKFs0A=;
        b=JgdCrNB3/otoY5WJ0YLLwCgWM2eif6xGaiMapl6vDpoRLa4+K8e/vYbzfYnz5N8WtD
         /+F/akOU8VYELp61ZorkIukkOxr+//fsQv2oUt5tuSigP4l4DwHD913E2/E4k2FF6Twr
         LUW+a6Df2HzyG9hYhRUPBb0z2RLOed7YPlvguAn2fMGAkgM6eed57mDdZt1imR9oaFsm
         SvrmPhWBT/hSpNAn9auzgNxsWXDWYiFuXWuLnbVjT6l87pqRzr55ZCp8QLVHvVgG9wug
         YWOSUtfxD3u1eS5NJgaN1tbURdbk27BIosEoJ9p9EFyo0O6JnMFwU4qDAvLgUz/Tw56u
         vCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053837; x=1794658637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xnQeGBiEH8XniaPdtXo6TRG8fMURfPvZnz3uNdKFs0A=;
        b=jc9RoeAYT5SO7zY9VQ9DC5sGJwT6UrIb5SYZeEfdECsJ80/YLxX2SgyGLUyVsMnODl
         POqRcyCknsAL3Jv3lZs4M6BcqMmSBG+qWilkDM4MuBW/SPpmp53NcrwTWADULK7SL+6o
         h56W5hSg8a40DjFu4hephQHnMY0X9mKcI9XBypNTqZYSu4oIJyxA/X6gBVTop/FCw6bJ
         LbvqIvtq8enxNV1OB12tWsuVqa+/yLBySR09m2wueaKhSxP9gvl6JvM4jTz8gsWm0iMB
         OlY4RFqZMSS8i10R1OUNDZzq++7P/iMpalobR2iKEbFLNOfL/aBlmObYfSa/70qessvz
         xJVA==
X-Gm-Message-State: APuU4Z8QRC5VgfavOew9n6yNp/vXJVcG/P5o9pWgL2xQ0Ps0O46L2xXk
	WJPJcQsQtPDpvt4TXg9aysuKTY1F/kdRKrUk6UKS+hZ7srXS6HPUg4UgQw++GvPTkRY=
X-Gm-Gg: AYBFou3DKLYA4LBusBmTs4iTResn/afLoUbsC7f39PSmAGgOJLHXXJRAe/V/fM3ho4I
	GbmccgCe8Atck20y+2Yh0MNBJyUjJLXRxBFSrf88iBwBTQgZJAV9f/Me9HFqtV1gUPodtca+CTM
	zFqqZWC0Zl4ZOZ/gEH8YHZjSCqMLZqQx/niL4fwys53BTC9tA93N89tCmOQLFhyW3ORslWNCDLk
	Uu+R3+AgJ1CbfSrTcHsGqPRX2DAH8q+OGZp01hkd5O8PXkbBFd64CJLPWEALmjfz6xuYDFngqyC
	taPcE9niMGBDKb43Wa4fqAv23oOMXBQmMB9riR7ZHHcLYZWYyaJd5iuucXBl0SiJLAtInF+TmMa
	85dxAfUF3TuEvgXn37twTPH0YPvHTTYTgVCavSXuni4tNI0tXbTUtTJJp1aV0fwfSnPduyBUP9Y
	fQTcILX7iK/9bYD8Uwit5r7EYDccIr/CwZzjzOJMGjAV5GTLS6q3bUnSOv1Tuycg/kQMs+5TSiD
	gOeV32eMTPgsopvsBcCZ265eCzBLiVaqQqDu+COtmlvCKQwfa472g6/JwbAZS7I/be2IvzGxee5
	3+m/jIVkCj14Tc8HtKUBiXDemaZy2QvNkjzU9+EajSnfky9Ezsu6BA==
X-Received: by 2002:a17:902:ef49:b0:2e9:5714:608b with SMTP id d9443c01a7336-2ed40c5f4f0mr66694635ad.34.1794053837099;
        Sat, 07 Nov 2026 04:17:17 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:16 -0800 (PST)
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
Subject: [PATCH net-next v4 2/8] net: dsa: motorcomm: Drop VID 0 VLAN table programming
Date: Sat,  7 Nov 2026 20:16:23 +0800
Message-ID: <20261107121631.1040612-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
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

The VID 0 VLAN table entry is unreachable for priority-tagged frames:
the hardware classifies them to the port's PVID before the VLAN table
lookup, just like untagged frames (measured on YT9215S), so the VID 0
entry is never looked up. Drop the dead programming.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 693564aeaec1..47f06945b8c4 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2263,7 +2263,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
-	u32 ctrls[2];
 	u32 ctrl;
 	int port;
 	int res;
@@ -2321,15 +2320,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	/* Tagged VID 0 should be treated as untagged, which confuses the
-	 * hardware a lot
-	 */
-	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
-	ctrls[1] = 0;
-	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
-	if (res)
-		return res;
-
 	return 0;
 }
 
-- 
2.53.0

