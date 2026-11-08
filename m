Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174310;
	b=2vi1te0siX8uJFaOifNTo3UNl9jT+tXFfy0lb0oXmpWmLHTYQQhho9Ki1VUPHqYs59QE
	 lQsjy+66xyvGGQ9fgdPtUV5reWfQM5QYgFCQsV/UbeLswlEFlhLdz7rWJRH6hviv6jyVz
	 M0YkKhdZ/WMIemTlCZBlEVGbDN4Ol+UOl2gqems75pI9U4oBJsTBOdzlPjQ0y6apZabq4
	 imr8q3OWnLjTGHjxOwgqvK7m8EnP8cmI/Y+aOaRjY4D8QaUF71keoJOTrpH3xAiNWLbki
	 RZhxF55S0AOawKb4gNlCbGBfLBBXOgcDo/rodisHXbU6jiLiV1dq+1UQpl2FDuRz2DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bV6rF11efYV9YrKCAFoIXwnaGS419MER7+z7uQlw/1Y=;
	b=EoT/8jUzrgvnYY6oU3J0lSxGyFCy5Xk2YfyS3fO2goNW35oHQ1Gtud60tmcHOAOHjtPr
	 jyaber8ltwlM8r70MB4r1ctZgstda2yxsha1GENVZazu0VawD42y2WRft1itsHqhP2V+l
	 3xX3xfE1Kq7AWrfG3u+0rUzlREmdBF2/r1hIalZPqdiCx8nMkS3FWJKvt4ie5mu/elVIb
	 Z/1+GaP3U3UHO7IXgVS/e+uxUzjfGBpWEeq/NQT/C4eC/sfMzFpNyX7R2vV4fC/AZKnGB
	 /RhWD6QcTVv/yDaAWU0evZjC3itJEfPoUZGy8v2900mMb+0dqwijN1j6a+yTMqRdK5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PpHEkBPy;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCD606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CFCD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PpHEkBPy
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so194386a91.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174309; x=1794779109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bV6rF11efYV9YrKCAFoIXwnaGS419MER7+z7uQlw/1Y=;
        b=PpHEkBPyQp97hgnQ4C+qJhtOcjJmFtTDiVbYcmzg1chGPrwZqekj2visWsB2VPcOiq
         fxRJJeX+XnlEKJWE6Sic6KG9BkOzNqq3Fm/uSTE38nDGp3TpmjkVc/mu4Pl2B0vjsG4k
         sLTRxkH96WJhAWVegLSIuP3iicQzTEh+tBcBj/oa9VVjRZ0q4m1evSpZBvh1KFBVgzJL
         L6xOxTG570r00CurfRi2NmFpq/b++5Okcqj81ZX1QfPAoALxuI6tkYh6oueVRhkh6PH2
         pfVhGaWqrykM3NYzRojeaHqhhYAnNbGRgY/kjufyedLCdkgwnSUZDeJpu7lyugpwVeeS
         m97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174309; x=1794779109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bV6rF11efYV9YrKCAFoIXwnaGS419MER7+z7uQlw/1Y=;
        b=s0Pb8j/i4/JeNkr107PdJaDDFZ6lxOrrQTDZ7lYcjvJ2wPFusKqKs7SdrJ7rCCeT6O
         RPfatW26RqxBKJ7T7gjiiJx9nVnnZ5xwrYsCAhX92Rs9e9W4qHV9ZLz5NmByzYgzbXjh
         kXGVdR9TqyJmJ34TXpqFMtR6PiqnpBm+aKRRVnOLLMa5GH6AIP6oXWlEanPKepflvMTd
         LwSV3UOnGwMdfuLHbLUnzAjROL532J5KeLqkbVGhwK+HEYH3N7T/BZ03WJZlnMRiFB5w
         3+E/NvpAy+gzbDYhzwI6cKdIJbHepsBONYnDWtdD3H45BELgUzt5h7m2K84aaYUTI/l0
         3qHA==
X-Gm-Message-State: APuU4Z9XeVRxwYo3DR3o5mi5aGO0Py3c78DWc9T9V3uUcNvddoL8CyKc
	VTj13Xexovk5WHpSIiGwVtXO4ccT3ATbA7PXJAbcBxunQli2zN708sUwQlNpfg==
X-Gm-Gg: AYBFou0VtESI3Px8J7Nf0jp6WqW/yFFjBzosbJdtIhGVnw1nSNRRz/qfr4ZS3YD4TJS
	/4kOR2/Xvb2F1joKMZgHKG3nASY5x6/SE3pJMlXVGmzzBva5Z2/hZ9MkoDF/mgw6BYgA52OMlXc
	2vpAmRBTiJaJuA5+LGvIaJO8Mk0lu4hOr2Of/WfrCyU4gizOuRSEOvcBIs4vcuPA8R10iDmUeju
	6E22hBM0OwkEBLwN8JxW6/CcPIXhrskPGfJBH4YHF2V+K8kHogstvwIsNDoO7qANTm6KduSwOD0
	7jcRrClOggCaT/1IK40RC1xNgWGw/dgeeapA37fMLi+c7JMshx9FKSvGgfE6UagNpIlZh7SFXZw
	wcUk3Ve8j2ZUbMCoxDQhUM6qgWno4G4srWsuhafXB2Q+qGcrQvA32SZt3E0GufDILwkSNK2fWlt
	vpFNx39YucCzMX+kzI79VWOjYn8qrTWCzrg4S8I6u5wkx2wSXiXgPAYnC6RuFmbQllcvDB++thu
	yU6FCyzx5HsmEfGUxFT72w8k3UauKFO0+BCtS/bDHx11onYIGgAuicaCnGYAqCB4Phm9GrGUR4Q
	TPDtOz0wQ5jk8vKK6ZZ7wcZ1yqffI7JrEZeIOEGY9ZgGS52FcFm4Ww==
X-Received: by 2002:a17:90b:3d8b:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3b12d3556e8mr1972627a91.29.1794174308555;
        Sun, 08 Nov 2026 13:45:08 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:08 -0800 (PST)
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
Subject: [PATCH net-next v5 0/7] net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support
Date: Mon,  9 Nov 2026 05:44:40 +0800
Message-ID: <20261108214450.1662362-1-mmyangfl@gmail.com>
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

Offload BR_FLOOD / BR_MCAST_FLOOD to the hardware for bridges when
feasible.

v5:
  - drop patch 3 of preexisting issue
  - fix issues found by sashiko
  - program RMA registers
v4: https://lore.kernel.org/r/20261107121631.1040612-1-mmyangfl@gmail.com
  - fix VID 0 handling
  - reset port flags on bridge leaving
  - remove local cpu_ports_mask
  - translate FDB VID for VLAN-unaware bridges
  - limit offloading to exactly one bridge
v3: https://lore.kernel.org/r/20261103140109.874443-1-mmyangfl@gmail.com
  - refactor port isolation and filter action for standalone ports
  - recompute flags when a port leaves bridge
  - honor BR_HAIRPIN
v2: https://lore.kernel.org/r/20261011030228.2761810-1-mmyangfl@gmail.com
  - fix build error
v1: https://lore.kernel.org/r/20261009005542.72860-1-mmyangfl@gmail.com

David Yang (7):
  net: dsa: motorcomm: Fix VLAN SVL and learn limit definitions
  net: dsa: motorcomm: Drop VID 0 VLAN table programming
  net: dsa: motorcomm: Remove local cpu_ports_mask
  net: dsa: motorcomm: Isolate all ports during chip setup
  net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges
  net: dsa: motorcomm: Report inconsistency on bridge join failure
  net: dsa: motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading

 drivers/net/dsa/motorcomm/chip.c | 242 +++++++++++++++++++++++++------
 drivers/net/dsa/motorcomm/chip.h |  21 ++-
 2 files changed, 213 insertions(+), 50 deletions(-)

-- 
2.53.0

