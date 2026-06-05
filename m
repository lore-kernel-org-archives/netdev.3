Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C63F0ABF
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671487; cv=none; b=TrP0NHoE/DF6siA3DLcXrDhWim6VawOxe1IwjNA2znCbmJNf27Ad/Y5SoYw51fj1i/8Ma6fCwN16cqIUfXlP5r1r5FwJjY8gZSBSwjyVaQ07w9wNztNa/pc7cbJEaQU656gEeXqtHRbx3s7qVIaKkP5SmsLtsOUu9Cim5P1fGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671487; c=relaxed/simple;
	bh=KQWRMeiV7RrWEe5YleX7ZCRBQqaLYDYgedOiAtQKTc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfyTFBMPrrsJueuY7FyKR+eQoAwjFAEd6o1/iT0koZo2Ms8gBGkZGGl1ZgCqgPm/9+2JtQmR9vs3Eh+8UiltjivlNru2R4Sk0GYyOUBnx3eQyH+SxPFgqW2LwWQ/I1VMOvIQd+ex0v84PG+YTvYwnujTBokcSAE+amxIntg2jL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4UadMJ6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4UadMJ6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so1357809a91.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671486; x=1781276286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SicgXXLmoBuCrAjmaaXUctssd7xnBYRX/u0SMUzZpkk=;
        b=G4UadMJ61EMVjz9GRIGqrp4qieA0DTwQ89nf26v82oa15lZ153r0J2EMbop4d+5wI8
         rN9IgAJawEt3tFFMk/7/hATupTvZpnBJqBPyr1ndYqBakcDEURgCCV0NHk5gMypZwx26
         /Dqta3ByC2ajaRwWymuXbvMHR5UHYI7EmF16HklFazX4sk/JwaN0td/FPTyR5zDHuz25
         VNIqPq43xZ5w4fNJ3shC9kWMjh0TrbqIo3PAz2/qRg7BCJKodNk93ymwqMbBCiG9rp3J
         rrmnAUF9Ftpxkhoqyrnxoj2AXpPs4QWGxRBpt6BMfXbqiWTFFZcO80sBJbRZrmFBkDLq
         X1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671486; x=1781276286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SicgXXLmoBuCrAjmaaXUctssd7xnBYRX/u0SMUzZpkk=;
        b=E/KdtDseDlnp6k1D0C3RIpj0JeNLp0D9J049BrxpfoENk7k1f8jAZX4CYG1UtDEesf
         9HyJMqGDcR3GKXAhsKKvCf89MdcFSnsK4hiLqlXOMs9BGB/+lp8DkwlzMML98FmqZ0iK
         Wi3WWU3PYlJvfJGYvXpSzESzvJIhon5XcZVSCr2lpd5S5BdqzEY+HNwUO29mDDVwLAnN
         Np2RW5dH1+2NCIimKnuy3pD8jRBJ2iq8g6ncFL9TtQQoVSiyp0NtDSucQ/9KmAQgkmLE
         g15mLgCPCdkEsoOqlcxvrdK2639mbh2b5ALoLFrZNITgS8gkWfQtRKm9eOpdADzVrZUv
         prTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ynEA2lVsWygQ9iGdwAXhn0gKp0xPMfZ9Xjhlq5eyTmaK521U0jsvhN38brSFoAd+3+EooZ8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybacju1Ca0GLBPLE2B/5y8tWUNZQeXUPGEfioOF6CYqPrhDqRy
	ra9tVBL/LY+gR381VHzpaviBHHk0bBpDIHNlflId2FdMvevWLfnPn12u
X-Gm-Gg: Acq92OFF3x4UxCwsvLpBPDLdcEEn64cu5/h1fcCOgkFyOUw6sforD37YnKA5xM5bBps
	dk+cqOUJCnF66owyh+Nbw4spyQrOa4lowxsy0NrxSAuy6UzWVhutCRsSUCECSUVprsWRvDqIYAn
	jCt+ybJBgb2wQubyeOGzRV0BkO2469aYhINfuNBXG3Jfbzmne9vKfz2sWlZ6clxJqMIlWEp03vj
	A4v4Gf7aXgpNTrVfygFwCA19Q3RywUW/KG+XrFVyh7jIrQ4OU9MNDb3ETWKW/6tNIc9Mbw3+TDP
	WmGC6W3tyWo/IURjNQAs8TCk6RFQ7tplP0Z/3OkbvlCbrXJHLrWB3juZCIUrJ0IOry0mGDGNcDt
	kaZhXi8uGiJSVtDHc+rzOnhYJd/KPZTS/oT6dHNIE++f9s7nKm9Eh+jX4NBC3G+fqFgFbnD7QOI
	2wNeAPIuJhKFe83AoPlLmCmLsgS73SPxa3QdXcx53DKzsIOhjf0p5CgG2v80vY6egw
X-Received: by 2002:a17:90b:1ccf:b0:36d:9ea4:d0b with SMTP id 98e67ed59e1d1-370f0e49762mr4468192a91.24.1780671485727;
        Fri, 05 Jun 2026 07:58:05 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:1cda:ba68:a654:c3cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a28c0esm7058231a91.12.2026.06.05.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:58:05 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] ipv6: mcast: annotate data races in /proc/net/igmp6
Date: Fri,  5 Jun 2026 23:57:57 +0900
Message-ID: <20260605145759.59639-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/net/igmp6 walks IPv6 multicast memberships under RCU without
holding idev->mc_lock, taking a lockless snapshot of two fields that
writers update under the lock: mca_flags and mca_work.timer.expires.

Patch 1 adds WRITE_ONCE() to all mca_flags update sites and READ_ONCE()
to the procfs reader.  Patch 2 does the same for the timer.expires read
in the procfs path.

Yuyang Huang (2):
  ipv6: mcast: annotate data-races around mca_flags
  ipv6: mcast: annotate igmp6 timer expiry race

 net/ipv6/mcast.c | 55 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

-- 
2.43.0

