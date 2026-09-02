Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A883A3835
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336322; cv=none; b=gSeXDbb4h4THKiJth4V2zL8d8Ftt4loRVKfL3PmRMI+oBNTInaFdnH85jwnznAzgiNGTYT1RWjNRMK/9HrS0RCHRvTum0X0rFbir9eiI3P/ndTQ0ziWgJ+HUAoWm/IR8u1v4RgCfnJlMgBg4o/JEkAUbn90vTEDIIO96VU4eJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336322; c=relaxed/simple;
	bh=pTobbf09dW0YnEwT3GH5xE2PUaNfea/NNfh9asJDIFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cnz5vOTDxR6UNDGmSMfZN4lFwNmYDrSjOmgV4PVmvsDFzdybaqQECC/4TPlNfEVwdQknOpem44ukMSc06Q3gohRe0mMzIhWP8im1a7lYEkzj/NHkuui/Ms8Z6s7dxTo/VJnZM2jpUKYLVjpotDiU195NV2YuCW7EHo4ShesfUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=GRquZwUo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="GRquZwUo"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c207cb16cf5so91605566b.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336317; x=1788941117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/66mrZ5nV/B1YsfNUsKPaO9BUQ5+9NombxKfcC/PLU=;
        b=GRquZwUoqDwBYiqiHoClW1Wzn+coWJ5l4+eGzi2hYsLA5oRAfuJObeiGfFONskBzqS
         UxUJe3sG2XT337XM/0M1O1VGQr6J5eU1Eiz8XX9K+Ri9twbDRlEHbKqde0XfhthDww6l
         Q8c1xVqQdgql2wF6uHoCQ4otpxxaHWxzESt4Ri/EjM4zhr0yqFTl+T2zd83jdy0/CppC
         Pq5PuDhx2Y6/tMFWuDNiURj7kSxh25wWbezg2GbBnQpRz2/WcNcrAOjVkpvgrQE8gT2L
         uK8v7Buq5AvezSButxeRpknw7RTLx1yRpDcyuUq18jLw5dg+HQMgRjt+xL24Gwy4AJTE
         mLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336317; x=1788941117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/66mrZ5nV/B1YsfNUsKPaO9BUQ5+9NombxKfcC/PLU=;
        b=OOF3qcKko2LCCMAZ1yksPbNTT7R0a9ernN7OjtOu+4bH+ul+FrI/H+fGkpkjaFzMg1
         OgGUe4WTsh0uo2YmZ0rZZ4KTvgGX4elRr0UP84jfXsahRCTxfLswer//KAa8cuJ179aA
         rAbChRNcm6nswxu2maQz/l8AsJu1tDFMB8qOgooRg3j4LE+MJMv1+jXgm/e3VZHYS0+f
         D4mpzN+HMQA9Hdy+J7r64GfloMp125mb53pcfDhD67e0wiEM4oJeSnwXfS5L0854LXK7
         3+vOUzt55fN39QfAPsVAju8y1YKWq4kufYifJmkdWTM/mSHbGR2bSEf3u26xP6Nzxjfr
         luXg==
X-Forwarded-Encrypted: i=1; AKwUvBw+ClB4nFamQJg0RITS/XM3WZOAsTLGaduitO6iQsoghr30c1vIsj1YR/+UNmntVCdMr6Y0jWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ0zkXniggZAJqYMWWJE1kTW05gI64Rm2jPccUsJH84uKT9Dve
	cWnlYIY1dBBlM0/MBobNsO0ddkCDyVQ0/OUzWncEih/JKYmSv9naCY/4WHSOvgZOctc=
X-Gm-Gg: AYBFou3BvD9RY4cZV0f2iPH+rRm9yGvfwvX0PZFoDPBjcOWwxrLoD5KjcwLaoCTbOPv
	v78DXFurBxALvXsHNJJ7oo5SpYrOOaib/fu2haFWBqgUnMsjVaabwz4PiyZdiNNjWQovd2GQyqx
	qNGzoOH4NAHnPWvbyZds2JbSaYq/UEeU16e1ZO/ydJMbxmsd4jlm16tt9R0nnTYqVImwRzPl0TF
	YGP8icdyO7MRXM6xJSUf9Q8nfrYl7ou9KTQXwQ8SpZ3uuDz6oBmWDINB5gqhU+9U6TprpvGWIyQ
	jbtcWpeAk25LLhIBrSlFRxrbcZrnAEV7RliFtxwr5mr12hPBJSh9MyZaA8qJghZigXH7fhA3Ehz
	enF3oNgSAjjLCV8KH+Jn0YMVmeGraZ1mQBVKX3NqyQUu0DU36meYWfioxADcUqQGuv8W1F+Xpo6
	BxChIsmLW/1AzQO/MSADC+hwhKCpfZ5mDmphmIpio=
X-Received: by 2002:a17:907:d8b:b0:c20:ff26:336e with SMTP id a640c23a62f3a-c25d54a44d7mr148285666b.14.1788336316675;
        Wed, 02 Sep 2026 01:05:16 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72df2sm5089494f8f.1.2026.09.02.01.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:16 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/2] net: fix a stale phylink PHY pointer and a lost PHY interrupt
Date: Wed,  2 Sep 2026 08:05:09 +0000
Message-ID: <20260902080511.2211261-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
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
Changes in v4:
 - patch 2: reword the phy_restore_genphy_irq() comment to drop the
   undefined "parking" wording (Andrew Lunn); the comment is the only
   change since v3, no code changed
 - v3: https://lore.kernel.org/netdev/20260827211638.63395-1-f@lex.la/

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

 drivers/net/phy/phy_device.c | 13 +++++++++++++
 drivers/net/phy/phylink.c    | 29 ++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.53.0

