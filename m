Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633003;
	b=2BshACc8bRzxfLOP4+c7ERXVOEsNXiMMa+QyxKpvcCk8ZirnLUtD7fCcexu5NC0vga42
	 poHe4OlpTyJyOlURR3lkXTyeu5UAKzXnhnyrEXTT4qrJLLA977t9Ach7CFxThA3vDiDST
	 jnePjUyhfmPHhj4CWRyNnhfi/tEUkVNHyeV4Qiq6Lwgwe+XHjEVLbXewx7JgPjI3Dsu+z
	 l2QV7ERp5IRbhDC9HaebalFPPomUqV+EY37Tsx0xg7hZkZXG77n1Acg8599c0kOQ2+EOv
	 41l3HMG53SBWVZ1aL97MIVzRR0FI/bzpTRbYZvb4XQNDna67/2lLwjyDSUiCKdG8+YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QNw1D5Dt32lz0/D4ctFxMFaPg94rUQWpcHEoRIYdiI0=;
	b=IOiw86RDtmaswMbJ8rIztSNhoXBvbm3jMteKCWld7FRliMpfoMQ+u9jTsk0AnRZuB80j
	 AR+9JKShEGGYGOe596La8G6rPdMm5LWLCZZFiVlmjZRxNlMwbUKI1ZFC+p5Zv0C5mN1OU
	 UDW5mv5huhE4eYsw9wKtYxpKEEffez79uWmCdjfnnFq0MWte9MoGAIluJCgmiMvUFvuyS
	 CUrDOz33flo4XCn1UZPdarufhydlRZHcWyMhgaTD+s0YtVFlxSSxgERGuT7mnHQaiAbmv
	 HncvkbeyGvD0V9ataIUpLolfYPObSUVk1kOZqRd2P6m5WP4JnM8BDUy5TIlkDsS5wUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PCv82Xos;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311B606A8A5
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 05:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D311B606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PCv82Xos
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso769707a91.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794632999; x=1795237799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNw1D5Dt32lz0/D4ctFxMFaPg94rUQWpcHEoRIYdiI0=;
        b=PCv82XosjaH7HTL3klmxO2Xv4wSrvHyC4HX67ixIo5QwRftFlnvVR7Cat3IRlWglQo
         PHie/GYajbcMEG63N0RcYRTLylGTAyliEwK75+OVkwl0NZ4dloOG838UR56/wMrACZpr
         I40sD0oei8fzqv8umjOrRJ1/+ml4hzshpbnjzKLBaMlq7YzkBv+PX92A4hSf3oSZwq1f
         R0VBUaEGYhlIlIr95OxgKRxb60SsNjTdcdNuidp8vVjEW2L1YIHfMSTgI+TbiT4lLjkG
         yqs3oam+esxoFvzt/YD9XhbrNTSU5qrkdjDkTl6IDlm6W8hq+rAuzhXRqX8aK23K+JmW
         k+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794632999; x=1795237799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QNw1D5Dt32lz0/D4ctFxMFaPg94rUQWpcHEoRIYdiI0=;
        b=wQYTNAk3pvCWdJenD7N+VnaDvx3nAWERSZkDrSYnciWcKMcOZtcA5WgTbRmAT8liWp
         3OAzTnrWBxijoPMxNAuqZn/fxx0RaIfajBB12xwxiCcV18cEKF9EqTIPYRD0pMhNtKZA
         JCNNjUKKJosCaiBKwjE5jcKXgCxgyXIpI4hGJx+9J7cTME7rFDdCCBAarFAIs0LNxF5U
         5bceyJHL0vyfxAMGwjz1gyxxOnLsmLuR/DFdeMAldeR/0xBTckT8isVUPeVqPsa9CBVS
         wt62/GoOi7Q7VON9OXwBHOA5R5adYihoyJd8jUvFfyT3p2vfc4qD+9eIgDnciqYe/Exs
         8M4w==
X-Forwarded-Encrypted: i=1; AL+hErFUuFyi0aEkCVHYdVD6facZZu3rgD+44y2jKU7JHEDT1jb09w9Z3N4DVUlVSe42rklH6mRUSyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mJS6KMYM4qF9aHNAYgjDnV1aV2Yn/Txr9DhxACnH/s8+qx01r
	9P+kWw1xJhufXgWdoaCsqXZNqF+LqrZQsZCWr/mFrS/DbWOPvJiZbc4O
X-Gm-Gg: AYBFou1FQjzAroxkWUkWEpeb0DhTPIB7THZSeTMcNhhfRbMX2K7zx3NkmDkhnCnb4MV
	OO2PwMZmTngSSD2U/j1mwm447bK2eXANge8RIc+Srs3IUXr6OJXIxSoGE5Ebuyg4MM5xFEfbEdA
	jctlzPGE4yoOwfH41FQZbncuGGafLP2wh2avqRE/+2A4ruXounVoX0k1CxsnqTT4zX63hskhWWR
	Wqc/dVpbL/+5KhREviabuKlWk+H9l5I9q/rvbgmwipQ63uiRN5U25x7FZvo9wjBRXiHLQwF0SlL
	hBmVLwiy3t7R24Zkiyr0ePrIBYYpgIaznEGtHOWcj2NOGvcSWP+Zlk1KjTRnQs0qC1smzlzfth/
	W3piPE9mj2QkOvYfd+KGDYdwpKCrvPubKPB8LMYwvJp5/yRSQLe/a3iF7aMWt0nAiYd04YxO8IW
	eyniG2Y+goPZRZzDFxuEEeDvpksXZUWDt5fDVdNelaCOTzaWc32lqgDov9glfTVuFlwhqXlZTBo
	NLVIXC+uQagQkR3/61DGt8vAimanCzUCacLGU2w+Bw4/iGlAdME9m2qljHpo8OXqRmhPF7OC5Q+
	RAbFGYsqW6BZ4X2T8rL9Z9AAgAX8wdY=
X-Received: by 2002:a17:90b:1b06:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3b1b0a0e8d1mr4752210a91.13.1794632999243;
        Fri, 13 Nov 2026 21:09:59 -0800 (PST)
Received: from fedora.lan ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm12776577a91.11.2026.11.13.21.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:09:58 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Andre Edich <andre.edich@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH net 1/2] net: usb: smsc95xx: propagate MDIO reset errors
Date: Fri, 13 Nov 2026 23:09:53 -0600
Message-ID: <20261114050954.275495-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114050954.275495-1-artem122novak@gmail.com>
References: <20261114050954.275495-1-artem122novak@gmail.com>
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

The MDIO bus reset callback returns success even when reading or
writing the PHY reset control register fails.

Return the register access error so callers can detect a failed
PHY reset.

Fixes: 809ff97a677f ("net: usb: smsc95xx: fix external PHY reset")
Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 130a460c1f54..f85ee5f8a539 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -291,7 +291,7 @@ static int smsc95xx_mdiobus_reset(struct mii_bus *bus)
 reset_out:
 	mutex_unlock(&dev->phy_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int smsc95xx_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
-- 
2.56.0

