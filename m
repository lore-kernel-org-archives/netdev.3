Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934424E4C6
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865405; cv=none; b=TQpuPqlyNIPspYlyaxgQm7qmrsjIskJCdwoP6wlReSGjY0pCGYSG7TNSIu2iB+qPV9L2cj+yehPCkCG2w/2FosOTTi/r18SqtDtgUvjXcnxGBLBFKUR3x2BBm808ZDQfMItc+gVQHdKWLv4pl+PqSMPbNvwRN4W/wSuWIP354Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865405; c=relaxed/simple;
	bh=AR64SDuxnMpneMLXVmzP4quV6lxzlo+i3B6F+PmJfh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9Y9HtIMSeQxD80WW3Cm8kv7gLx/ioRsNARALwKWvZEaTeQo8uDJuIHDRjpLZbeKrxj1a/BQFD8N8pd567HXQHXUNkawbuYPyjW30FErv2HJp+bi2327Z2WblpQ+JWfcjOfsJ7gbONXvTUM8wiiynxVKMOpuonsnaL2qDACggk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=gzXZvmCs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="gzXZvmCs"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso57242f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787865401; x=1788470201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DPEMDKFtcxksuqGCh4W940+4YKssrwswGnRzpjY1qw=;
        b=gzXZvmCsmbwY+nKlgDFhu1E5mORkXNCkxcl8sOUvsdJdgdBUegMHC8Z8XrjJS3AVvG
         z/Mws923x1FruQDD8rQfR2x1rQY3MvpOjBjiohoPVQcg7YTGuN+sIp+LRs4PiIGkpY/I
         MKfkAJGtEPRqpplRnf5sUEVyUACUWwo7ttAWk3HFYpMMiNakZnDjEcr6K43bSFztW+n9
         bfA+jnh2PmH5EY72vd7Qg7nYmvkjShVKgj7mIbO/NNVrgelzr6ZkaYHCN5mPlF4B+RLE
         vIiunyEl8B+xHVXPXAuTL0NaQF4JPYQtwZ6Gw/QYxpFMQZiQ6H5ZGp1sWpagsfMqplO3
         bv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787865401; x=1788470201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DPEMDKFtcxksuqGCh4W940+4YKssrwswGnRzpjY1qw=;
        b=f0hFuaNRhGKenE06XBUvoTZ/dPZXGtZy6qrkKohwekGbTowuUkT4gD6yAPfv1tVeHr
         +voGY6fuc3nysRTC674QHSaS0ek59efHI1xpFYxF/hESOf8fpd91hv6EcB4wX8X2jmv8
         xT6YAp0tsdYIPi8+nGFBZcakSp7K+stebpORg6t2FwyQQnLpPNlmx+YCij1UP/Ak7XIa
         ry+v8MmGW4xZpMz5dSdM4Mhu0Dne9oXfKZnudv9N2wPVrOisNghQAH7R+nTYV387r5Ys
         2bY+qo0zhej46J3rdV811gWgAVnf0XS6oUwIUMsYijmr8/IwZKGrKkrpmB5dYMxUgDNe
         3XNg==
X-Forwarded-Encrypted: i=1; AHgh+RqiYzRIiEW3FTl6dBFA1T0+mS3zFZZGAfLLt6XSNYkAMpZQ8BMD3tVLyfEUwi575IPdXvjFJzA=@vger.kernel.org
X-Gm-Message-State: AFuF++mmtEbp5uUuqOxRf+lbWwLq3PWye4vVyA58ZlPK9UhQRBnEBeHf
	2D8whzusiBd+3ilLN5O9tGLn0FdBti7Ql2rdat3eIvy78JcGSAdfHX4QEG1WCIwP7+s=
X-Gm-Gg: AR+sD13yBkZvkPOeTDvzKG5sETl/m8Za1oeEcQ6FBi0d7rKQGJXKQLSCjlLdiuEp3pw
	3JrdHU38P/m67OWA5LbcMwpYLgvU9TfaNSVOoMfGy27vDL70Tcl5bWzl4vyNXVNlgcjKldoMLr7
	+A3H58DdvoQhdWQP2r5eEY7NQDgjgNtc2dobnZJYmMoW4dCx1Vp/gXZihN6rfOsDDusZze0dDCS
	dVDWxOInQsnhSVC9R4EduaRUMATsmkQvxr9BT1+Osk3lo9Td3+W2/6ws9AG0oS2niJysEDsioM0
	sJbjqr+esXiGVa+reZk/GRxf67y4qrr1FBax7euHNAcEclPInUC+pL4ZvDoJPSiprafxQkEiVrl
	SXVrYpTBcs1dflbQYcwEX8FXHnXO0C5r07vTH14kpEmRr/dOqQb/z7hwkNp7x+gRD4xynxfA4Pg
	+PpKRwGdt7bUmGueyToE9r0Z/IyTmuVmpDLbPU2ici35uTnVquM/I4v927IpOgeh+36Q==
X-Received: by 2002:a05:6000:4a1e:b0:482:e658:bb8e with SMTP id ffacd0b85a97d-482f79bf4f4mr2483593f8f.12.1787865401526;
        Thu, 27 Aug 2026 14:16:41 -0700 (PDT)
Received: from ownbook ([31.146.92.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e4f0c8f7sm11423442f8f.27.2026.08.27.14.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 14:16:41 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Aleksei Sviridkin <f@lex.la>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] net: fix a stale phylink PHY pointer and a lost PHY interrupt
Date: Fri, 28 Aug 2026 00:16:36 +0300
Message-ID: <20260827211638.63395-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent fixes, both found while chasing a PHY whose driver is a
module on a rootfs that is not mounted yet when a DSA switch probes.
Neither one depends on that setup, and neither depends on the other.

Patch 1: phylink_bringup_phy() records the PHY in pl->phydev before its
last fallible step, so a failure there leaves a pointer to a PHY the
caller has already detached. A later phylink_disconnect_phy() detaches
it a second time and drops references the first detach already
released.

Patch 2: a PHY that goes through a generic-driver bind cycle comes out
of it in polling mode for good. The specific driver that binds
afterwards never sees the interrupt the firmware node declared.

Tested on an MT7981B board: an Airoha EN8811H on an MT7531 switch port,
its interrupt declared in the device tree, its driver a module on the
rootfs. lan4 attaches with irq=15 rather than irq=POLL, the line is
claimed as mt-eint 0 in /proc/interrupts, and its counter goes 1 -> 3
-> 5 across two forced aneg restarts, matching the link dropping and
coming back each time, and holding steady in between. wan, whose
internal PHY has no interrupt in the device tree, still attaches with
irq=POLL: that is the observation which says the bus table cannot hand
back an interrupt the device never had. Patch 2's other exit, the one
in phy_attach_direct(), needs a generic probe to fail and is
compile-tested only.

---
Changes in v3:
 - retargeted at net (Andrew Lunn, Paolo Abeni)
 - patch 2: added a Fixes: tag naming the commit that introduced
   phylib, where both halves of the cycle arrived together; the commit
   message drops the phrase Andrew flagged and says what
   mdiobus_alloc() does to bus->irq[] instead, and answers why the
   restore is conditional; the analysis below the scissors is replaced
   by a link to v2 (Andrew Lunn, Paolo Abeni)
 - patch 2: reword the new helper's comment to the mdiobus_alloc()
   form (Andrew Lunn)
 - patch 1: carries Andrew's Reviewed-by, otherwise untouched
 - that comment is the only diff change since v2; no code flow
   changed, so the test results above still describe this code
 - v2: https://lore.kernel.org/netdev/20260824024029.41310-1-f@lex.la/
 - v1: https://lore.kernel.org/netdev/20260822155259.87146-1-f@lex.la/

Aleksei Sviridkin (2):
  net: phylink: unwind the PHY binding when bringup fails late
  net: phy: restore the interrupt after a generic-driver bind cycle

 drivers/net/phy/phy_device.c | 14 ++++++++++++++
 drivers/net/phy/phylink.c    | 29 ++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.55.0

