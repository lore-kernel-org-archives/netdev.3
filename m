Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922337A85A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234110; cv=none; b=Nrnr5x71VNvniRk5EHAmftXGC/f7tMN95Zfqrkvw8umQbIxE+QGGb+1GNTwNObJIUr2H4VL2GDtTdLIH+FYbkL+JnC1klCp0Qgw0PMtHsEamNJZDl7qEIMNMpJTzv/tcbeNihtWYZNaJwqpr+3pVBJNv2X9qvi1PTLsCHoksjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234110; c=relaxed/simple;
	bh=/yKBv8dM3IO/k8ppxNy++w7jpfealC+yafsqdCvv8Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOrfkDT7IHy0t0gRfr+fsFVVbqIaRac+7WqNDE+sRb6nesB/bpnze2a6lUZg9meVaTcSfyvMBwc2ScVVgxz3b0rsWseAfsnUcoS7qyUubDLLMxeFx4Dx9P3pmUYYbWRx2kdlYxYtqR2P9n91CsFyM83VFHUideCMGzMOi6vvsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Y7SjOtZT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Y7SjOtZT"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47df6a5202bso4716249f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784234107; x=1784838907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gt+XqollboNjdwVY0zqegEHGGajybfgvTuk+LVVaP6M=;
        b=Y7SjOtZT9Dq1E+vZy2p5bwNaf/aI5KaLxDKVxkPjDzDQrwsbGq/32QOpOKgWRMrAgm
         W8XLJia6RM3u04PibTaHvjmDo9/XbB9CpWx4LZf+QLE2rbYKHOdMufEl4DIlxZeaqKgw
         +yVvvtj+4MCzPZnfFfeW/A39OSPHHB8Mkgbfr31x88UU3DlIyNOfv7Pn/2Uxy2IxecNT
         R4c8TJmXOU6Y7wrpRrg67zgY7x6r3d+46qZIiT/fNtaI+6mdtlLUilC/OWlYgiq4uwQW
         1T5DNnhVtKE6dJAZAUBH7qJjG3GAtM8UhAjNDmiN/v/vRBGnqKDMG5gt4+jpjgS93z1m
         jWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784234107; x=1784838907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gt+XqollboNjdwVY0zqegEHGGajybfgvTuk+LVVaP6M=;
        b=JpaXcwtZpik8TR6MbIVmUrr934FETVzniTEyXqsZ8T9PH4J0um2mGClZ1Osni+SZF5
         jlA4sDa8bzwGdrcFt5d4eUB/TLmQEGbcNBKn6c7ZUzGxyL3T2JfCt6pQg8f3kTXlFQDU
         SLgbjsndmVRmgftBn5LT4xLCtHRo8HxC4erbY1HyFSZfIhrt6mpVNJJbyCjnQxMd1I1t
         3K/vbgbTxPK/RuLeuRGebRijhEbKHh50PbmfkW/k1BOdA/obJSZCCcVXTYxOOvNThEi6
         v/xXc2VYnTe8jgoTH6OKLk3At7DTO6G/NnvaYT/1iZyhLxC9mUlTa/6cUcM7IHiRZcHS
         XasA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+4MhNrGNvr0o1Pyu2r4iK2mloezncf267oeT9lBT9in8Hqy2GcdyfyZolnRTp56iQM18mGSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SPPRJA1o++iGHDaHqj1ilJz/xH31AvWjOlznRs5OL5bCiwxp
	6dWX9m4WW8fIB1ZNB3M4d7IVoB4ezQwCU34yhLj8l1kX/F8Zx5zD4SuOiMX0BkE5/w3a
X-Gm-Gg: AfdE7clQ8gG2HfjippPqw52UKT+qEHYAsU3mJvNZbVgMkMwTxjQECrr+JoUSUBkrA7+
	8tNGv73zfXVQGN6pC7+JT0o642VtZ7pjRe7FLuEzRBOofX7IE1IAQk6ksTfq6rstgBWed2tlCsU
	bxMhyW3bXalrMGh1wyW9mDcRjezwB3iyiG9B+JlAnMByrzXSZOWhqRcGsSNVBu5u+oXuprrhMOr
	26BOTtztQzpE3TGrDP9hxxLFNjFbRZ3InMZ3+VMTOyJaq1uZ8MRISendWGtXuX/YCu40EZuJJXH
	0DKCzeNhOJQKcKeVevzwvZxmyF6XFrGZFggCIIIsyBqHPZOWw/1K244o/nFu4FpMSP5VhvNeU9B
	sHvZyPgWWDL2P61vAtmHxEvAqBT2ssrcbcAOGLjdO9FyjkPHkhsKdY+7sQERsy/qWDaRwuRyMTV
	S1nW4FC+ov5dAi92sk1Lrk+io39LgoVIN5wDGaIqQB6bkrjQtZv/xXoFb3ouuJLlhglc+KU+Jt2
	/JvfpvqixV+9h9YAqiTl0BYc/NM/rJ2Qh0=
X-Received: by 2002:a05:600c:a47:b0:495:39aa:1359 with SMTP id 5b1f17b1804b1-4953c143b28mr95999535e9.3.1784234107463;
        Thu, 16 Jul 2026 13:35:07 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm4602835e9.1.2026.07.16.13.35.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 13:35:06 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: fmancera@suse.de,
	sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] geneve: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 16 Jul 2026 22:35:00 +0200
Message-ID: <20260716203500.70573-3-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716203500.70573-1-doruk@0sec.ai>
References: <20260716203500.70573-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the sticky underlay netns geneve->net. They differ once the device is
created in or moved to a netns other than the one the request runs in.
The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
so a caller privileged there but not in geneve->net can rewrite a geneve
device whose underlay lives in geneve->net.

geneve_changelink() applies the new configuration against geneve->net:
geneve_link_config() and the geneve_quiesce()/geneve_unquiesce() pair
reopen the underlay sockets in that netns (geneve_sock_add() uses
geneve->net), so the same reasoning as the tunnel changelink series
applies here.

Gate geneve_changelink() with rtnl_dev_link_net_capable(), at the top of
the op before any attribute is parsed, matching ipgre_changelink() and
the rest of the "require CAP_NET_ADMIN in the device netns for
changelink" series.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5b861f6baa3a ("geneve: add rtnl changelink support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: correct the Fixes: tag to the commit that added changelink (Fernando Mancera).

 drivers/net/geneve.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 396e1a113cd4..03c99a016298 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2376,6 +2376,9 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct geneve_config cfg;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, geneve->net))
+		return -EPERM;
+
 	/* If the geneve device is configured for metadata (or externally
 	 * controlled, for example, OVS), then nothing can be changed.
 	 */
-- 
2.43.0

