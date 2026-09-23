Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4F37DEB6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142667; cv=none; b=N0IZcKQUKJyksEcp4LvP/O/64ChV53korpaN3ADeGjcw7taPSRLOLbTxptv81y491VLTl1xK9VWgs3SBPAdFCvJW4ZfM8IlcFwPR666LccMi7vtRwkvwRKRxYh8cEIeGitxmoFERXHp9h1vFFIDKsP9bVDXxcHC1l69WZXAEKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142667; c=relaxed/simple;
	bh=eKemzwRXQdl3c4hY8Ex1hKISlYj52xm/oYZ+lmbpr1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nx/rA7rmUI6Scf3tHbKR4HZcSHirNQsuJOGDtFpcDG9Jcr8FyChYuTxpGhNXCrpWwlFSzOlQKx9ulE4f0DbpwMMJqVZx7Z1GJByPTfed31CITtO/L2E+PZMB4kNjQkozu5oRt1luixy48lekY3YTUcDlchmyMr/D0cH4j9apxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhJc/u5h; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhJc/u5h"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso327323b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790142665; x=1790747465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNcaMozgi7eMkdPXPYneu/L8vYje9h4xULACp8evALk=;
        b=fhJc/u5hOyhXhklkk7jsW7/glrZ+HjWqBtqKokh0MDgVt6SJIbPhh76SzJY062J8OT
         chkQPGpVsS4LiYa6cD5np1rM7vcFlJoHJkda2eCzuBI/uogYY2ugwjnogBAaNCxkcbOF
         xuJjro3cW7aMZsPArWBfLS52izqejd3mZJs5D7/VN620qtUcufxNB0rv/7svbJDp9+OD
         g+ZZZX/I8cPGVgy+Lj9iqluPShA3JncZIl2Y1jiXVMRKMmAWMJr1XhYZ3/cwHPlKmXjv
         /DIjL3wjuQhzB8wlI+LmdU1X2A5KkDb0CeY8ia437mlFiSU2snirphM866ub4Meu/Da7
         C0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790142665; x=1790747465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNcaMozgi7eMkdPXPYneu/L8vYje9h4xULACp8evALk=;
        b=jTU0v7fN5IBmVpdPz0AmSOce7mxkTWmrkC9IzG+3Xh4oEzKXX71jChSjY7xjEg8s0u
         xq4JsVRJV1VoTLvZxS5m1vkU/eYyHF+9CsszyLqi+q5VcNa1k8MpsZLiRPz5Tzkf2fne
         p8iIU84reLdqc83M+o4ZWuKluCKX+XnN62a/e+QDpEu60d8U3ZVHkUX7vVe531nsZYJJ
         CbV4HeY9nifZYCYfHI3XqQ8yY1bX9pp1sktGXoO58OE5P11fhnDDKUQo0ciFw71rpzvm
         SkwSjTnAqkrEq80Py4F1oR2AAJjZtHhu0qydz+JSAgs2rpkTRv5FQbQaUJHmAqu9l1P0
         yy1g==
X-Gm-Message-State: AFuF++mIYuVocaUpTyjc+H5/iJh9qhxcZCceNZOTzYf9j4zw+Laq7Wqa
	C9/Y4Ot05o7sAkw8D+g7EqOaMRclhVQXoZb4KjOv7zoV9qRGDr//6qPKeLWX2jpg
X-Gm-Gg: AYBFou0X++/oe00INy7oJ3+5tpA8DKB4wzc7xZnwZXEKcWsICnXwKC+4l2yVZzNklyF
	Ba3jOK/0qbWGogkkS+yYIjvXAVYPoNBVrBSHFFcLgo0lGBx9y6gjR+IG4znEgiMZlsqaJf+t+VG
	hHeuHBAQvy0tiooO+jaF4nkEjLE2XQPSAyA+Gi4VbqxqQtp3tkR4JHtJchMKPzfZo5kDPdxHDae
	JxDeaCymc1NYsX2t2WJS1NzaaJpjPU3rIh4bL/zyJIA7PtP0s9irNb6meuEb4UAzeV8+iivbvF8
	qw4dnYCOLOxOc5at3tSyrjQJD2MpHlrmOELNj5yfNv/kXVGX7y1d/0n4LMhTOryQtIbQfnxu3lR
	rDRPdwhEpCRWVLjYd+1dNgW16Dn7Ee2mC7ytrU8B+7f1u/l/6E9/tLoSrlCKx5XjjbuREbI9a/p
	ZvrlO8PR9hAsWg00QrGpwBoVFpKo3wz69IqRr6wlN3TbmvvjwopYT3Js8BgcQiWh0dyplW+krhJ
	Y3p6kTCDbFEoIjfiQjaBO2EsETS7LKo3A==
X-Received: by 2002:a05:6a00:3316:b0:86e:8deb:fbd4 with SMTP id d2e1a72fcca58-87d1a7af6fdmr1687497b3a.11.1790142665440;
        Tue, 22 Sep 2026 22:51:05 -0700 (PDT)
Received: from abs.sf.dndws.com ([50.35.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dffd6ddsm691486b3a.48.2026.09.22.22.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:51:04 -0700 (PDT)
From: Tao Gong <gongtao0607@gmail.com>
To: netdev@vger.kernel.org
Cc: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tao Gong <gongtao0607@gmail.com>
Subject: [PATCH net v2 0/2] net: dsa: mt7530: fix trapped frame forwarding and egress tagging
Date: Wed, 23 Sep 2026 05:51:01 +0000
Message-ID: <20260923055103.949540-1-gongtao0607@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series resolves two issues in the MT7530 DSA switch driver preventing
trapped link-local control frames (such as STP BPDUs) from reaching the CPU
host when bridge VLAN filtering is enabled:

1. Commit 3ac85bcfd404 ("net: dsa: mt7530: preserve VLAN tags on trapped
   link-local frames") set MT7530_VLAN_EG_DISABLED to preserve VLAN tags,
   but in hardware this disables the per-packet override and causes
   trapped frames to follow the CPU port's active VLAN table (VAWD2) rule.
   When bridge VLAN filtering is active, the CPU port is in stack mode,
   causing incoming untagged BPDUs (01:80:C2:00:00:00) to be egressed with
   a VLAN tag, which userspace STP daemons (such as ustpd) and the kernel
   bridge drop. MT7530_VLAN_EG_CONSISTENT correctly preserves wire state
   (untagged frames stay untagged, tagged frames stay tagged).

2. On Airoha EN7581 and AN7583 switch IP, setting MT7531_CFC (0x04)
   CPU_PMAP alone is insufficient; the switch MAC forwarding control
   (MT753X_MFC, 0x10) must also have CPU_EN and CPU_PORT configured for
   trapped frames to exit to the CPU conduit.

Changes in v2:
  - Rebased onto net/main
    (git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git) adapting
    to mt7530_rmw() instead of net-next's regmap helpers, resolving the
    patch application failure on net-0 noted by Jakub Kicinski.
  - Carried over Lorenzo Bianconi's Acked-by on patch 2 as the underlying
    logic is unchanged.

Tao Gong (2):
  net: dsa: mt7530: use consistent egress tag for trapped link-local
    frames
  net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583

 drivers/net/dsa/mt7530.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)


base-commit: 9c572a83037a7dcd653ba3a9cc468c16b857d0c9
-- 
2.55.0

