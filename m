Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88823BBA1A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959242; cv=none; b=Bh8+x1UeHPlX7FjYMv3yo4rgvpEqAiwouqItYvgsglu+2shvtTEucxjnyJpRKn8u/lPzPFUNYp+/89BQ5ImWC/rM0rF5fxPSUjdCfME6t/OjELTD1vkUhqC0lfIi4AI1bDs+wz55UbNpvpwN4d223S0nuifJLT7NxIdLpxiFTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959242; c=relaxed/simple;
	bh=RFL89FGKefYovGeBgZ3CB4+xWGgb3vNqaJKhk5dNQjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYrvhnx98CoRsjYkSWGI9piWIWGMwjNZxWge4kwwPgvqwMssnScGcYKLly6koDTjislUu1mfQbGXqxAZt+tmrsF3n2dpvrj5yksHsoH7eiy8Qu2Y0MA8/64wts7qAsO+gh5trrNYiwknprOQ7JaTrXB4N5zd4t04aycYcdb4e/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqmQ2mq6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqmQ2mq6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so22400105e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959239; x=1792564039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOeaatzk9bhuYpSzqiCT8rOTWkQH4urpPw2fjdSr5Ec=;
        b=pqmQ2mq66RojAANIF5bwWk/pRlXcTIptjkcEvmoBYeri1kmR3iMW1AH8XGBZJe/ZHb
         uc3ks1PY2X6iC6x2Fg0Ej28dlF7aA1rPvObgoVTfoJIF87UpaFztHY4z8ZgdDbRnp+iu
         fD+SRLMgiHp/B6it15XHmTdxJlSv/JFTfkegiNH1dXEQu/i0RSjWbdWlyo2sUK7TaQn2
         nfm5CNoJw+7DGHojgOLmOQzWwQ23hthXvSkBJp44wBixD3fv8y9Jpe7S1jqao8CA17f8
         q5BmBE028Zj8YHaTJGOTZRnPhcILHAAZx0zmSXuUXf7wADcstaX0yu5OSrd1DEvKe0qn
         aVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959239; x=1792564039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOeaatzk9bhuYpSzqiCT8rOTWkQH4urpPw2fjdSr5Ec=;
        b=xsnzZjxW30NVGf6HkHrd01mC8whz0lMNilqTdiqBym4+164dmPXe8ObWpJo2HVefbw
         GizQOmhTqSIx2vjoaqhCuFasgbCRrLcVnPoOrogiVRKcULLpXxa3eNPuQTtu/rh4IsEM
         611VYM0lkSgJU3vr+J719TEEZ7jJ8D8tUWpx+/duavo8tpNWHnNZP9e33e7Zd9qLKklQ
         v4SLC5u4c1h6eDj/Cxv74JaJYX+T5POgtqhymXMoeeiZfi+cJTHNr0nsNVPLpGoUSIsJ
         NN9JV4c2oFYvpqKxBvghjvd7KSjKW9IE9HFcuPOmiFQqByK5vMMEOoxUIyt3LzURoAYa
         KarA==
X-Forwarded-Encrypted: i=1; AKwUvBwHer8gtdzN1scvh40oggiVl8lGmSOAn1UgrPLtF1cypLiFCKdJ2wtI4df73P12sQE2vr2rIOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL3xgq3nosH+hcs9MMplkHndNZxp5BRZ4+LEwrS9FX/F1TUCmr
	wEMk2pcgEvKBECVxJVuhfw4o5s6KXhHElakpHEJTaVOZw4PSNTCPqhAw
X-Gm-Gg: AYBFou3Yhdg0UAD0vDq565j6Rn1j9JcJfLu3vWc1hvv7YoSI9OZK3yAmLFGJ/rsXlmc
	BXHztYyg7GPHtiQ0IW9Io/QYx4Mvix8r6rP7AECYResoHGxrqbVjtngqGoNhhauCGC0vy4wP1hU
	PKvZ02eHgzdudmM4Xlmyt1MyGmZODqQIRddcMDRMBu3335COefuw4iotjwDLne/v4rbPWGWXUGc
	hb0TiS3b2/7jDgADyVz+oUQMC57BvyqP6F512D2Ds7hHkbQzkAJy9jt0WNlGGyyvj16ERau6THe
	awR1ueGAgLl+Zx/nfM/H60UiHI4r5EvW0DPiuPIWIH6hOOk0PA3lboaNhfp3SV9YvWC9zpRujuE
	NOw+1xDtIW8mOK7xwyTZPXLf/YvFoAxncBiS/rppOl9eysypA/tT4T3LsOYXJ3L88K0FhqdnDX4
	vEp0SJ2lp2hTTEWwvEypcH0Pk6RA2qEMqbPztW8bMS8vHTS1O8B4GoRD0D7AtqK5z1JiYKX09R/
	Iq5BoAPsqqn9mvra6pTXPFMU00DdMuqJ6p/VQbnSoovadqIV5blwIxB/dTTpQy0spNIR18oEdXo
	S9Zki1MFC5YKs7x7F8POgyESUqw+DM07u6IbgrnVLIHoL7UOwsjmIGanY03nAcYaPtJqSAQ+oxn
	rl86NPEfkhHxpHg==
X-Received: by 2002:a05:600c:1c1f:b0:4a1:a484:2c37 with SMTP id 5b1f17b1804b1-4a1a4842caemr152491245e9.25.1791959238943;
        Tue, 13 Oct 2026 23:27:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aed1-da01-ddff-863b-8308-ab16.310.pool.telefonica.de. [2a02:3100:aed1:da01:ddff:863b:8308:ab16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm528846745e9.4.2026.10.13.23.27.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 23:27:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: stmmac: free RX resources when TX allocation fails
Date: Wed, 14 Oct 2026 08:27:00 +0200
Message-Id: <e7a5380aabfbc03bd560ab08f37ea255d11d528a.1791958735.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791958735.git.kmehltretter@gmail.com>
References: <cover.1791958735.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_dma_desc_resources() allocates every RX queue before allocating
TX queues. If TX allocation fails, its error path only frees TX
resources and leaks all RX resources.

Free the RX resources after the TX allocator unwinds its queues.

Found by inspection. On a BeagleV Ahead (TH1520), forcing TX DMA
metadata allocation to fail left the RX cleanup event absent. With this
change, both TX and RX resources were released.

Fixes: 71fedb0198cb ("net: stmmac: break some functions into RX and TX scopes")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 495ff7aef..8fd7d2173 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2425,6 +2425,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

