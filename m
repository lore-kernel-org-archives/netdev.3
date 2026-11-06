Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965586;
	b=VgMldWhTqwlPEzuY2Y65IApmmmk2Kv0VN87/aaZMhr3L6eeTqixF5irS1pRhP/9uDv3c
	 X+YtiMIKR4Ts7i3X2vp46K4w9ZfLm1zU8jaIS25oWEXoMH/mibZoaGrez9cG6RGRPVs4D
	 FUrfvE1uXww+0bmgitk33xQtTuo/Qq8wd9O5WLD5WzqpB1xzdqIeg4avTFlAZoIAWkLgr
	 +uTxLlzDXsVkNhdSpvFIbb2Ux4zPOh47DV3OBuVKn/4GKAE3nCUom4ppQcOTjsQxMZqNw
	 LCgTOUFFbBiD4OxlrrFjnoJPvl7TL08UQU+tqgM03rz/KS7onYoqKvTfDIS0e549rrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
	b=llcqOCAFR2g49tdKiaxPt+L/J8idkZF0H9gYhHx/eUtqVFbWPE0iAkN4siQaHMAn65ae
	 PbMYC/EVC/0W8ALXmAbyGyy7W5KH8nhtB3SvilDeyxQ0AUM/WqIjYOTlSPrSEOwON/6id
	 t/K4uhhiUgEbaREDeWvcPcPVEyXkUaKdS5de/vijW+bFTHDlFRHlFin4riRKBOazlUyWR
	 oeBIsISlAFTx9WoiYAbrKj10ccc4XcGdAKjhPrsJ3QyX8+cUZjpYVZOPpYCBMLi8snjmN
	 q8wzfejcFQhYknX3PpqQVBSfbPl3+679ZC0gF7+qc4Qb8EVJqG+pwCScAY1vlyBw1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mKG/AQ/S";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D7606A931
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77D7606A931
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKG/AQ/S
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e795af1d4so483445eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965585; x=1794570385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
        b=mKG/AQ/SA4Y2X8gh0hGyM4oubFdXoBqxMnh8G6XQzKaP0lPmU4nsMkWYHLmJ7XTPkl
         AX+JFGVxQ0NaRb95p9vzR3WUlvDZwSQzZgppzMG/kekQCPd+H17mg7rvpOXLLRodpzy3
         n0QkzjwOhxjvebmwM67xU7qvGWJ0YuYjgfYdDVBsthfsAxfXbN7Rx96QSCjNv5Px5aZQ
         eTIP4ej33VY0gmC2lD9Wk/E+CYxOjLrj3U7WXf96lZlHh2WQopOxMnRo+WRzZWYeBtpt
         2rc0uV+y0aKF3Gwk2G3Mb48I3UfLeG5bVn4Ijw2ASqMgm4Zvd28ccxxkWGET6rY5iMWl
         znCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965585; x=1794570385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
        b=T9vSTPKJLQPUqfpe2lUKj2Nz+u4eJ65Um+16oYp6I0PQ9DLNY2aL5fFkFvJBwyRBNM
         jccmmLC4I/GSooJzs+vUToPj1LimKtjwqlJRLqiHrepeS/KEKITjxNPuz1xxNK8qfJjk
         Gu4c7jaadG2aPbiJw0eY1uddgg/n9Gko8lyB+JyAtFRq+9txEUYLaiWhu1Fy7CpdCprl
         /F4Rf9VPEIcNe/xRw4tI5mo5gDE3TKsBz5k5w8xMUv1wMq0Z/EzqwCvUk9XAXscyeK1R
         4LkJnqA3knaSJey/O/lu2orOQEvp0/T9hWaelOiA1cXuI2VXbLB6tZKJ8own18d13E4V
         0BRw==
X-Gm-Message-State: APuU4Z/2BlMEo7KiWJWFpMKVk6zZzG9T7juaciqQzqXx8OYJ5Vs4TGwk
	wUQABC1x/ZVSEpPeD5l+EuFP3Oq1DZE3zECDQBlkiscRvnNN5EoT/n+ao0OGf8Zj
X-Gm-Gg: AYBFou29KF7FeM4Ni0RcNf1URP4HI+yTNevFRF+8eKHFHPWCOPA9rqE/5SO4ajFcpKz
	T73GjTXuTV9hpKvDWWPcUQmiMRUtzmUngf382tIc1oepIQgMDzXiAmh7YKUVyqaCrKyu+XfpvZT
	pFcTKBNJiclgH8HtC0NhtIlM4USI47kBLe72NLWKqJMAIur4ena18HCwO/5Z/ewPq2Pid20tD7L
	+a/NtKyMoGamDx0w6zW/bPBZJx/jmuze15Yl1wD2oWljuLyynXQn1wDbO0v8TUweB5tK4+RMia1
	xulAgiC2QUfzoqGvYhHhgW5YdIAZl7VeL7ZKGR8BN75RvdPjz33lbKfvecs7OwEzAUOiJ0fvobh
	3f4i1RFEvb5q+YnL6i194Q8FeUHep0YIaX0d0Q35geNTeCATh4c+iF0SezBm/RR50HOL2PGgpha
	Py4xv2TKdIfqTqOtM3usHDDDUSCJ58xAbWU5ktiyJE5tVHD20Vphpx9fzVt98oXgWrNR5rR3kaY
	woNurxsc1FmUvqJb634gkXMKLKxj01Br6AamS0bZg0HfEAhGELtl69Rtde816bntBbgAp6aOOIB
	MIBJzB+TFF8xZ46e2ssTd9nZirxPAalC8PqZfy9vF4jS
X-Received: by 2002:a05:7301:190c:b0:361:a195:c46e with SMTP id 5a478bee46e88-36de39af458mr6879740eec.1.1793965584700;
        Fri, 06 Nov 2026 03:46:24 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:1d31:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9be7077sm6167055eec.17.2026.11.06.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:46:24 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v4 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Fri,  6 Nov 2026 17:15:49 +0530
Message-ID: <20261106114551.212675-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
so a single get_page() from the stack, e.g. splice() of received data,
overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.

With the smaller bias the driver gives up its last reference on a page
once every USHRT_MAX handoffs instead of once every INT_MAX, which is
only safe while every consumer holds its reference until the buffer is
recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
AF_XDP socket in copy mode, a path the driver never meant to support:
commit d8a8ca14c937 dropped the queue_format check that used to refuse
it. Patch 1 restores that check for DQO-QPL, so patch 2 depends on it.
Trees before 6.17 still have the old check, so there patch 2 stands
alone.

Harshitha mentioned on v2 that Google would send a patch blocking XDP
on DQO-QPL; if one is already in flight I'm happy to drop patch 1 in
its favour.

v4:
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/


Amaan Cheval (2):
  gve: block XDP on the DQO-QPL queue format
  gve: fix RX page refcount overflow from the pagecnt bias

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c           |  6 ++++++
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

