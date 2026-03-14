Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71E40DFAB
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447468; cv=none; b=fHCtS3IDMKfOvBFcdKtRMz+rae6LJRT+pr1mkW6ZUJr2dMvGMyJcPqh5lF5vYvNmT9RSY2AoWZ52oFTonZ70yxa5Vjq0IB1nl3tRZJ+lAgRo1rKobHoXi44COsTlHCtXXA9/C6QZX8iUaReQIDx1KBw+02ItqdfQ+D+9xWnG6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447468; c=relaxed/simple;
	bh=b1ene8ONSs9C03X31//SB0AZrq505ttkACakvChHdHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTGd3NJE/rbC1zp70MsCkHM+3d91CCqmtrnufncoNAQ6Ihgk7ocdhU61nKZOz/BNkD8mYhR8KuNJGWLrPjMYLAoO20W8+EA2a9tgskqH2D+44ROopPniry6giKWf2G5xCOsUP1+HuSVBGq/yj7ArkkWpOu0aSK8Z7rx0ZnEZYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDLRJ531; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDLRJ531"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ffe7b6f751so1721668137.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773447466; x=1774052266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6b/QR4PvFEotKq40cJSYSZ7dgUtppDSZuAvZVJjYv4=;
        b=PDLRJ531fSQ9WwKGEcIOFL+yxAEY612ebxL23/j2SkFKEDKoyEV03Gt8ueAtQL1h2I
         b23kjJkyGnrQH2ENnSieXg9zsXUjVTBPX2h2k+uf8MeBLeZPXAMl3QmEi+qHr5dAvG2G
         op3JUCqmh7DGxQfDvY1iaN0GpXdaj1sm1u72X4+mxmphIXYaRNzEZnQ5ngi7kECkAvl3
         vjA7Gl71F557pKC2Yya4z9+svF7GDcvS8HChkA/FFkaY0swjgH7osbbsa3surS/p1VzB
         Sryaf6xUkxLdKQx8c7Kzl7/aq3k7OmMl1H0r9pG9Ad5AKKdpYGFswqfrSnqxxGP6dodR
         OLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773447466; x=1774052266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6b/QR4PvFEotKq40cJSYSZ7dgUtppDSZuAvZVJjYv4=;
        b=gv3JonVEigL3OuhBR8F9+TfcJ+DixWVwCeoHgjWiaTb4QiWsMp6hDvwPhegyd/+tt/
         BwZHEb6g94lMYgvXD0UTrYhozuB26SbaTHACyTf74AxHdxzpsQfxR7qxic/pEsmPb6l+
         dLhCmnRVNIbc2oqlEpWyJL9ruBwzvYWbWDLpERWzN0lkrj3QcznA0eN6K9GxU97MvxEr
         WugWiAzYNG/X1LZEXpPLafA/+B+nHS06HQAO6AevEiNus+fNElFXy2kiMGrIFcgS8VRH
         oOWLlqIaoNR8GYX/HbMG7DzOSz6IhIwfK8xiHbWF48xKYOIiUKxPNBorGtJ/TOsjtEA5
         DjrQ==
X-Gm-Message-State: AOJu0YwxeLf3p+KBl1GaRPmFmlxVlbVNBUJ9BiyrVZlJDyfeA7g+iF1D
	b0Fs+ljNodZ2YtP/V7QYrD7QU9NDQFOgUL9xnovK8+0ogHn9mQXpORF2i1RV+LBE
X-Gm-Gg: ATEYQzzsRYJ239euEhwAC0owtkIsO2j0pCIU9Qe2s9gcNrGfhmVpcMwKrhHl6S7UYLL
	b1R3s/30rMdq34BK5Nuwuv/RArxa4qBLwK5zF0OwigOvDXbwF8Rl+WF7hPBaZcMRhE18Mng0W6Z
	jcdSHrj+fRnpTlm+coJMzKozmao0ZcMJKNtOyeDTLzMYDqLiXCBRYSd8LtHnpurR1LdP21p28Z2
	ClTx+JEQ5c1iLIQj7LKkcNDNyT4tc0nOgLK4Iv2vgKMXTg7FYmpCXD60fdZ6p+qH4xJ6arZc3fy
	Zxhv9zR+GW6+vgMkxWDTBTIV2nm8SWOFmf1soVOe+Yeu4Qk1fEtWKVoJLUYgeW1dXbfUXFSanOE
	0QqzZuhAWJRLXo21LxgYzh6EJYst0AG09d1rcu3x67hrUuMoKVqLxxag40a7xdRHXENyqxbflgK
	HdA+NhMP/X7CFF7K4W1uuw
X-Received: by 2002:a05:6102:510f:b0:5ff:dcb9:9222 with SMTP id ada2fe7eead31-6020e6f1ebamr2407965137.7.1773447466232;
        Fri, 13 Mar 2026 17:17:46 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:20::])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601deb3e0absm3866263137.13.2026.03.13.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:17:45 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	alexander.duyck@gmail.com
Subject: [PATCH ethtool-next 0/2] Pause storm tracking
Date: Fri, 13 Mar 2026 17:17:35 -0700
Message-ID: <20260314001737.494082-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds TX pause storm event tracking support and updates the
documentation for the PFC storm prevention timeout tunable.

Mohsin Bashir (2):
  ethtool: Update pause stats struct
  ethtool: Update doc for tunable

 ethtool.8.in         | 19 +++++++++++++++++--
 netlink/pause.c      |  1 +
 uapi/linux/ethtool.h |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.52.0

