Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576513;
	b=U/yuhFyu2ndexdEd4Qbqpb5oOcolwbfsbfwpKFyRUMolt8lycP7TwLvX+msjNMQ1ccwc
	 pWZcJHO3Dubs+pQUdKq3qoszHEJ9nufgn7rBFoEp6NRr/P8FF2KcioUtgBnQnKU3m977i
	 2pei6UxpprRxqCfegSXFPBC2AW+ER36SuF34WKGRfv1ecIXQe1wrSPKB0Kk46DIVvNu/X
	 TVOUnALVqNTfn7fzkPq3dinyebz+O9ViVqxS8BXaGvh8IBZmqsglI1FbbCE0gNiPIv6MU
	 qoXd3jmBhYfUuYUlMMr/at8ABaZ0WPERGYbzAPk3CTXzg1CawfqyrlnZ2wAdjsX9pmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zMluFC78cIvBikYbcX1+ABfXuc1qd1361x5Cr08z8xQ=;
	b=TA4SxEgOW3F+7K8KXmolOm+5y6sKieSEnyRdfMozv7YjcqWt6Q0glqULYY20BHibIjFM
	 cKBR2vppA0PzKdc7JC/ZpFgqssFaWfZ/JIE1Cdj7CopFKiuykKEV74wIHbJzGkFu9LiPG
	 dHLxtAk+q0zCxZeF3xLPM4DjYWf0toKIBsbe81cNF5Tcf7q8nm9XdHjkYlTSNu0GzbJp9
	 RJs4sZe2fL+C8VEdRDfgf7ucjS6kECgjWjDyVeZKvHyoNsEO+lCCTKOfP2lJIEfAOpRU7
	 tssFD6Zb9c3xgfW/d56L7OLHtNbhQR2sCPU2UxxYVeMB5so+4OVrUFlM8GoOKI85ncg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsiZlsgi;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F04606E435
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F04606E435
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsiZlsgi
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so3721795e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576511; x=1795181311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zMluFC78cIvBikYbcX1+ABfXuc1qd1361x5Cr08z8xQ=;
        b=UsiZlsgi4djgwH6PPrZ1X68lT5Vjzz6Q3gxyfVJUsXIiOQZsLpsIr9+xIfUiaLZbSY
         nrRrJucUs4qGn11nRI2VWqFw6YLjn6YngeylkeS+LErX0ths/K958JsuKPgakJBSBJzq
         5Ft6463aw22L52qZAb6jvrGkZ0h8IMvXEDIPbGPSHXkqlTblE31FKZF7x/qJ1m1Fzgfr
         EpSrL/aUoOUedbuteH7hybEHvIP6paDyj6e3m0I+wRKWSXIo4BLUR4ksqKjU9NwE03dM
         fGilGVsqbdqs9GWpczccIJKuAP/hF7XDqLkG7QAMe9zxmSJG3UdTPuAW3iwrzqtFSBvC
         3YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576511; x=1795181311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zMluFC78cIvBikYbcX1+ABfXuc1qd1361x5Cr08z8xQ=;
        b=Yz7I3pL5eZGLwjwRW3Pov3Zj67jmQFdAkxAC8t6odj9CvQRUk04oa3iceuHG/sQgCm
         7t+iNtfHjQl8jH/Emy5p4QM5KMz0DRGkDfkvKtYC41YsaxtDBkCp5QwfTB57QinncGQO
         LR9lKZmQbSYphqlYpzYAdDKSa5oo8IybI995qBBLiu9uw1BPIm/nLoJNijP0Yo9e5+vq
         6XWRQZiK13BopwWJmlde79PpJ+9/rrfqN0c51BG1d783a2l/vhPbeWLejW/shJ/JAjTl
         yuzeFmDIscFPR2mR8LMZdHjLE3SONGGdoCpPt2lHelDpd+rXzH2DBuNbJZxaVykzcoa3
         SBZg==
X-Gm-Message-State: APuU4Z9zEE+DuqTsta8kwDeGCro46D7CtX4rUrj4OSk1NnkT9qZxTIR/
	kTIHud1nwws1dXF4GAuhUkzhEA2EmtzxT+yQSktjPxJPtao9q4YTOiuUC0Py3Pw1DDQ=
X-Gm-Gg: AYBFou1YZIj8SWg8/uJpTrSo7SWV/pQRZH0YYPUT2POLe0eBTxbRlRYd1MYyXNuSBRK
	pPILCi3ipG8ws5dKa0ETKOEeGwrIDb9oyy7n3XGGL9JU+kJVAxvFJVA800p0OIeXOg/ViXs2XC5
	9H8BQ0mbzT5MBFgvGBEdcjzweALw/A/v52hHIPpKztIYkVEFRcK6d4XN/p7XE/5gDxA/OqFIpMD
	/m73NwOg8a36pjGpQ3TubuWpEbDBfVOnZsuE0QNoIrvfX3qtGEuT2tDMQdPELFoRAQC0lOOM2Iw
	ea13qLt/SX1WWaMmhyrmFHZ3eIGMIv3qY/uEQiKoyIxs4Ha7NMblnTppWwz+17JoVZQS1Bmp1O8
	mRPgOv6j1cLkBRdnJpOMAr40WN0qa4AAzp8061gHgnHjB3V8cYQOcSgILElcsKhVPMR53misjSY
	AaS7qEo/vb49/UN43taVtkhPIlPvPaPu3dfwCpbk8sF50T080i1Z/QhEb5ZHrQR062WSP/0f37N
	5LLpZwpASCSDB0b6lzQ0XgUzUihS9CloqvQWSHA0cSTHsjh8vqGeF3LVbxkqVU4KYi7ecKCYkCI
	579RbZ4AZ6s6X4834A==
X-Received: by 2002:a05:600c:8905:b0:4ba:4395:5755 with SMTP id 5b1f17b1804b1-4bb55a6a5fbmr35028905e9.5.1794576510932;
        Fri, 13 Nov 2026 05:28:30 -0800 (PST)
Received: from workstation.. ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fe370f8sm4802673f8f.27.2026.11.13.05.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:28:29 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Ali Tariq <alitariq45892@gmail.com>,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH net v2 0/2] net: spacemit: Fix TX timeout work deadlock and RTNL in PM callbacks
Date: Fri, 13 Nov 2026 18:24:33 +0500
Message-Id: <20261113132435.434615-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes two locking problems in the SpacemiT K1 Ethernet
driver.

Patch 1 fixes the TX timeout work, which ends up waiting for itself
through cancel_work_sync() in emac_down(), so every TX timeout leaves
RTNL held forever.

Patch 2 takes RTNL in emac_suspend() and emac_resume(), which fixes the
"suspicious RCU usage" warning from phy_disconnect() on suspend. It
depends on patch 1: suspend disables the TX timeout work before taking
RTNL, so it never waits for the work while holding the lock.

Tested on Orange Pi RV2 (SpacemiT K1) with a lockdep kernel: 12
suspend/resume cycles without the warning. The board loses its network
after about a dozen cycles with or without this series; that is a
separate issue.

Changes in v2:
- New patch 1 to fix the TX timeout work deadlock (reported by Troy,
  approach suggested by Vivian)
- Patch 2: take RTNL before the netif_running() checks
- Patch 2: drop Breno's Reviewed-by, since the patch changed

v1: https://lore.kernel.org/netdev/20261105123441.2524171-1-alitariq45892@gmail.com/

Ali Tariq (2):
  net: spacemit: Fix TX timeout work deadlocking on itself
  net: spacemit: Hold RTNL lock in emac_resume() and emac_suspend()

 drivers/net/ethernet/spacemit/k1_emac.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.34.1

