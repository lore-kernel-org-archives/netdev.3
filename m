Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EA4A8A18
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017067; cv=none; b=PDKZTpkP1rmVFbOHQGAH0hCbP21bogkiRWYOIJ8ZQRIB9WdciNjXFN7Lu/8fk6ny6XJLGHZCOU/5b9rU1QXIn/E9zV8kJ8SgpQLc+fGSrcWmooniovzW4oo2lhNW3cPwHpqZjgnM9njXi78ouR4va3yJdNkM0oZPjHZSU7ST0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017067; c=relaxed/simple;
	bh=lJ9fL4dvaDu8YJNJXqtBjhC9KAFVn7GltFAR71ifad4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuHaXasO/V9AfgEkSBUDljoj6XivdqwFafDto7dc6XYP4NQHvZnXO3c5W7f1+Y+fQgD8A6KAZxEo3timBOpM15WZCXpnHLp/1GkJuMwzgeTs9qHCvKBxYYv1wnHw/xGG0goO3CirjlDvymq89urzj7+yZNnUonNxK2gmsB4tIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=FjWy5Hdm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="FjWy5Hdm"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5351748222cso7702581cf.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792017064; x=1792621864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdSWkhIFW3k9LSDhQXw9Gu4uXo4armuoaIxm/22kOrU=;
        b=FjWy5Hdmhdzs2sapqcveuGzGzz2+SByiq/4Sks0FIzaeMWsZL/OPk8a9KaI34iDuY5
         N31krfx7Yd7ehqVGXr2bIAlo9Qz9Yf8kgt66jRDzJpgnZHdAoESQcLVBKhk30pcWqm27
         lpT11s2A1EKC1D7/xkw2gAG0wPoDmm4aD+RoinmKiDiGL4TBSEpU5z/DWHZneEzuFO44
         qzBLoc8NbJaNaFgHl91x5Ozgs4MCT37twyGJJTHaWdsfatPncigwOVY+S4iIuDnAuM1C
         a1/+Cm21aLLcTMBSELjrCZfDiMQnaorE436ywBJFsaFbCq72JDE7af+BqknTAiX4sWa4
         Jt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017064; x=1792621864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdSWkhIFW3k9LSDhQXw9Gu4uXo4armuoaIxm/22kOrU=;
        b=Lj9Lpcva68SCr362fDfcsRJjZKTnHJ4L/DY9DRbf34PNBIT+iclZ64J7UMwohLI7Ik
         2Yqtv9Os46Q3Yz+PbyCGA6/F73reOL7xxYtoYOEdcv0a/gAu2q3foJXAA8Y00KqjM5Tp
         7+tritWPtKcQLtgXTK0culx1OFq19wljXKfO3snwOSDzpG8TLBqyxhbjwqpToFkH0jOu
         k3DuE5fa6wI6nepxRaOVyzObJenMjMmXERmVLuDfky8Rrt77veGr24kYCKRgGV5g989G
         UKQCSwl7GXr6QydfgWIrwsVy++isZxx+gMCX5X9zQW1vO6d7/3ll+RJmOleB74BHcrTP
         S5yQ==
X-Gm-Message-State: AFq9FYLZ9IY6KOHRpyLRjzTtcL9BPe1dU4q4l5msDtzicXLglWMiWt+o
	aceJq+Gqz9b0rmMd1AIXFANJAXgxwn2HfqIzTFdzMeIw30YxS82WzOs7OxTqVscjLcM=
X-Gm-Gg: AYBFou25TFN7hMubvhjlbwcReXoVZDBKNTygePGhRAg2gqKEP6x6SSWEgL3DH5zvL1a
	F8WcEjcxAScUJ6IrJCGl7Kjoskl797sYYa97aiwuHGvz/wQwQglD+H7QWmEKuetL7SyuwX+Wi7W
	rcYA8rAlWqUxx9HoA/bw5+TNs7Zrix5jOP0vKyR31mWdywhtYHiC9KXOr7FShav6f6y4o/86snZ
	IOul4LRSO6rqWPhVBFq20GcReRrwxV2mkI+w91IL9bmQI94qZiqWT42xiGQi46+uTcqVybTSnDP
	SX10I+jpeHHUCOvHGRcXBvDz2876HdRln5pzWcnL9qcin4Rf/f6ZNChJzCt0K3QaCEa0B+n7lIe
	m8rA7Njt8dQ3aF43aL2juEJD7ybHZABGWjUtCgOFA4vPeH50sZAkzDybeEvXWH1h7ILaRFamchz
	C2ihT39xGpVd1uDxSMYvL3qVm2DlyTEBtNQGSPCC+2+BxKshP8MvH2xYI/bqKCQGm9cOw63s+mT
	1U=
X-Received: by 2002:ac8:5fd3:0:b0:535:2df:131e with SMTP id d75a77b69052e-5359faf44f9mr299085941cf.32.1792017064429;
        Wed, 14 Oct 2026 15:31:04 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bdfb89sm63708466d6.40.2026.10.14.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:31:04 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: pcs: xpcs: fix operating mode selection
Date: Wed, 14 Oct 2026 17:30:57 -0500
Message-ID: <20261014223100.304486-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XPCS found on Toshiba TC9564 is unable to operate at 2500base-X
and slower with a PHY connected using SGMII/2500base-X.  This XPCS
supports 10Gbase-R, which is the default operating mode, and this
causes mode selection to fail for slower interfaces (SGMII, 1000baseX,
and 2500baseX).  Writing a reserved value to the MDIO_CTRL2 register
avoids this failure.

Wangxun already addresses a similar scenario, but includes custom
quirk handling.

This series implements handling for slower rates for an XPCS that
supports 10Gbase-R.  The first patch rearranges code that performs
soft reset so that it is done *before* the interface mode is
switched.  The second adds code to xpcs_switch_interface_mode()
to update the MDIO_CTRL2 register for interfaces that support
10Gbase-R so that the desired rate change works as intended.

					-Alex

Daniel Thompson (2):
  net: pcs: xpcs: re-order xpcs_pre_config() to update after the reset
  net: pcs: xpcs: select operating mode for 10G-baseR capable PCS

 drivers/net/pcs/pcs-xpcs.c | 94 +++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 27 deletions(-)


base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
-- 
2.53.0

