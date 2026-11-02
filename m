Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635112;
	b=e6EKWSpj1m+QDQlMswJwduOmnwRxGzBVaLNdYFqSD3/IOp/RCwGo8GrYEz8K034rG1OR
	 UrEpZP26qXS/vJgzsVE62TASXvN++JcpygOaNqxm+gFGKEBHg8K/gY8XhaFJQtKmL9see
	 RPGe7nzbCKrSEaLpmFr9VMDDYjNhRyfdEjLpGb8ulSvCJusCvN+YGstq6BqmGEfHgv9v3
	 9VxJQcbhmCsLfj5JnItfdwygaapr+aR4qXMIlUgQqK/7chN72XXT2ahN0OHYAyy9kOyad
	 Be9yu/+q1aqE7d5VqISOdM/hDrhOTF2egrdRkT5PxRnfgoGg9SeXo8x/enLAZ3f2Ixg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FOJElCsJejkEPEZ90UqbExNeYAKPE4lqsiLwiXZew8Q=;
	b=X1ztFQZEG3WVdjuE0XW8zBxcGIaTg7T1OsZUFnBTNWwbvks4tvzx8FQlvThSaaYCHwCP
	 i14c9e5zKMlyJJivEcNScCOXBh/tlsdgvR8JcmSxULEgtWHK6qOFzosz1znKQ364UNdQa
	 ALgUSYHvT0yD0tSffmTdLAmzFyVxZU4rlmtdP/Mnn99NVD9hPwdbG7Oxoc6tu12EF1luz
	 iibsouBPys9uduiwKXL7AfufEcZzOXBMceu0q8Uh40AQ79M1jdyG2o4wIqIU8HD5/chd+
	 Nbxcs7AU1HyXhPCLe0EA8fcmHVYCl4QxP+hblBMRTRSW2xmTRMZyZWfv7C93nBZcdqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dAAQBVrc;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1B606EEBF
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC1B606EEBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dAAQBVrc
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso1029975a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635111; x=1794239911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOJElCsJejkEPEZ90UqbExNeYAKPE4lqsiLwiXZew8Q=;
        b=dAAQBVrcwBdaWSb01wI53Zv/Qb9haryq3CcTw0Bie8nY74OUuqnjwfZ/U3E3adNzI5
         C4JTOlruzFVAjFxGehsiTpJQOVO3iSayoFwiVlMDx1e17fjguMliNn5+rpKom2sxO0ys
         OHcxG61ZW2aOVD51Hxbl5KuE/xKbZ3x/X/zmpwwrD/z0t9TaqWYKCKU26XTK4Cn54N87
         eoReodtp3hspi51eNbMWFL5bDZzy3h7tcy7YBTZG4OnIsnc8RuqZVtGOw/oVuO4EtkQZ
         UuVuotkK77UuzKgEn4FlCqUZpyEovnDw4xjep5Z/NmxXivaIWB/LwkO4Kvn7aPPcChoP
         gPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635111; x=1794239911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOJElCsJejkEPEZ90UqbExNeYAKPE4lqsiLwiXZew8Q=;
        b=igNagsh4fwKge+tQqdnnnp/Cdq1GNNy/CX6EfLTkxWHqpiq9hW24S7nPtFZfywZDrm
         MqqU/GVlcCQI8VvNIVa1vSwJ6YjJI2DL6rTn3o6uvIQtRW77vnP+D8AZAyilnSlyp+UB
         zdxRjiY/tXgW0IfNCZaeERP56HgsIklox9L+BZ3T8J1GkWCGu2w1Ruyc8JcuOvINflWt
         yXZQnkWNixl4us0CyvgDNHi7QybGk3mcCBwktWWWJjHvJyYCBcNDCz5WZoYdWNprZ4XK
         bN3mYCzvmKCMHx0Np3JTybNuij/EZ6wkrTUT4/+k37w90E0APlSV96M9YBzRXxFOvsRs
         j94w==
X-Gm-Message-State: APuU4Z/0C5yhYNaUg24uQfDjrc/wbg2nVHi+7UoZeH17FHbhUgp3IvGF
	ZlPEekXmoLL9vosGQe69CtlHW2TNxDTHSza/9L6gZ1Z07fiT/TVzZWpzaHmGaQ==
X-Gm-Gg: AYBFou0Hti7pspPx0bbDyDV7nsdLJiZ7OuHV7oO5TwFJq+50QHbw4K6bH2iUGxRrXIW
	ndarE7O2eRasV+RdsvKgaxgPGtTZfTGZ4JAb//QDd8MDHSyjSeKqe19cbRYRlfPGabTnpmYMvzm
	0qc3kdF6BryH9gVbLB4Ssv7+2VfF+VmQTrgLp/Jc5tBWIBrWCKlvKDQvBF2vFV85ozkdjYUnHJk
	EO+p/lHqdFuDUtvkgMiv+mHA1Y+bz4jL46cLRV9vqMQZGSNFE1tocx86kX+5r8vDWyPjenJE5dW
	3A8undlyvfbGxAcim7/tyfT1ZeCp0Qi+h8LjLtLJcaHUswA5O7yMDTvkwQQj5rpT6sjN6VwJiVJ
	tabwNh2OgFY7P/iLk4dWROueiErrcq5BWVnQ3jInDi9H0XOZfRieRrj3Y0ki7VzCDuOlmVkimrY
	X9Y8GBDA6VUJBj0yGHISjb6mbj8ALDoIMuOIxnleV4YcBMsOuXA2/F6s6ou3R31oyCwueS25xBw
	7IJ5s2oKQ5CMDAyNXBpEEXV9sdCkq8YGaF8W8BloR8s9lIQQ6sHRzaOoYAzmrvCQCohhtIq2mJm
	4gFclVysIToBtE6XaQ2Ha6IiouiQhO/KazIp0GnU8DEm5s3DKEmM
X-Received: by 2002:a17:90b:1e42:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3ae896f8250mr9163738a91.22.1793635111035;
        Mon, 02 Nov 2026 07:58:31 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:30 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Mon,  2 Nov 2026 23:56:33 +0800
Message-ID: <20261102155641.3682626-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102155641.3682626-1-mmyangfl@gmail.com>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
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

Chip setup only blocks unknown unicast and unknown multicast frames,
leaving known multicast and broadcast open, though known multicast
cannot appear while the FDB is still empty.

Isolate every port right after the hardware reset, in preparation for
the isolation refactoring. Note that this only minimizes the window: a
reset always brings the hardware back to a dumb switch, so traffic can
leak before and during it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..e1fa82c6db95 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2221,6 +2221,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2258,6 +2259,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dumb switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

