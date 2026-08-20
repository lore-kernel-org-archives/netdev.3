Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE5414A38
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224519; cv=none; b=LW+alHhwI+btxmYdLzBKWFOfF/jh+Ka3PXvHLjghdQn1Vpl9vNGmTQ05rTfqgYWAvw0YfQlvAVSJ+TZ+SVLVqB2SdsFmT8Bh0Tm6aB2bUYF/gz7Wz1o1QrsTvFe5CQ8pcl6XmLNQ6nxzJx9tkuXq2J8WW1bWS69jt9khVWO10Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224519; c=relaxed/simple;
	bh=tDOaMrFdQycGq4gE+wvlWrHRDJh4uLwsjNOPncdFApk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2Bv3jaqiAdEa1cu4UHkFG4siKHLktai+YUb97KYTQbNIoNAY9Tfb6268NvQeZqljc1ZZuiGn7OlMsSugtA1iNfrxlh8Ixb1BZVfIdqH3GwCbg3nrS1UwxD/tgkAB9uNYO/shBo85jNh0/lvzbzc9icWfQ86mnn07yWkPoom/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He+Z+9Dx; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He+Z+9Dx"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca80d708489so538909a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224516; x=1787829316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=urlQN4Jr9Sogk2+osjcgcQBKU653EuK+ku6So/bCSdM=;
        b=He+Z+9DxAiWMkl5z7Ww6tdGfJqyEoRN3dreT/2nmn8Pib1iggtlUvMHzsXtzoMrmGI
         Cue3C2hUzcEv9DsUK7l9WreChatmy6KRebxviKIZs9tDv54D+CdDV13BpN0HsHCbxcLN
         HDOuC+wHR9eRJjA52Ij8TRytlZokNvEXE3VM51dH/XwDpsimCq3cmq6uMz8scIxp3Sxd
         dgp5s20swtADV66L/HsxpyaGBJT6NBzzpnjBQvBn5iBqn0xNS2HFjhtorDDwx9/QIR7I
         8rmoWyYTQ9hoXxCMkxbuudRk25qhBKJv/IpXUonm9CCSKAi5kZ+8SSoX2AK9LGRPGwl6
         0kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224516; x=1787829316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urlQN4Jr9Sogk2+osjcgcQBKU653EuK+ku6So/bCSdM=;
        b=Lh6jjEjwD2qvfcFOylA/5iR0xn8oY+tCff0lnrPl4XgoItFKCWXYzIWwwl7KrefMxR
         FGQjycW7qIEfjmD1GPo1/UnMENbQqKA+NXw7KT/kBXH03BRr6h8sMPuXwkGtLf4Jkivp
         gm4C4jdhUwBWErvVnSnczmfCNCw4u2GqyWec6lESpO/gZ/OIC3VTWWHsce7xAoqbP7BB
         0p8CXBCSW7pS1ezC7j4KHkRtpIqyRLNiIZKMynvnIRvAtiMtjiJrHu2bW0oQ2ikxTM6U
         UPbuIHEgflvfAwEsyWkzo9ojiI8tb/9fTdvl/LAWrYnVChR7t1XgkQmrz72h+QRRSqBn
         SDSg==
X-Forwarded-Encrypted: i=1; AHgh+RqWSOH6SdkT5h02Dul+M+uk4iCGggB/4ZwYxalfsz51HZHT1JS6QcXALqmtWGrtGmOqW1A9fl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlrQ4VV/bvJMHKR1ymftKY249rOZUfALPwkFTpmb721MS0XK1
	lKuDg4zTUj9c3MPhw5m36nWEcIZp5rdE9SxzambhrSgfYU0wqHviVONT
X-Gm-Gg: AR+sD106EL0tSKBMrzXkeHsmlmShXMVMlasaPOk0isV4dBFh0Tay4f0u73EkJ2GG/oU
	DUDjvjnruQzMbLVR6ziPPiUeTtzaS+gSqgMYzo0NyaaPF9Z+y+N4RVt86YgKQH7xBUoTumrl5lb
	Gt/ocQCtOoAydtar/UMwrsrkyWjAlSXvVTB4oypDNxTijzIlIYsyidrKL+mYEEgHJoxxQ4Ol+zK
	86DZIPBr65A2+1yzMJR8jDVxl8Gcf6RkitsdNSPGg45BXVesy9GfZtxKHVxU49gXVOP4VjRZqVG
	bng2QQ28jsNi6DcPvFoZxiTOYdLd/4Xki0PMfd3jGz/f3SLky4EhFtOYgUt5JkJhqmrS5bbHPpi
	ViwGnn4PfV6/rwSCSpU6mfpx+hiq8cjqDFQ1SvVdsBheNGdM6mN6HwojyfMKt+AQVGEvLwqkl7s
	N6iu7pL1fkQDCxuyjB7o385u/Fn0i5Hi4ADiNe7EslDmMinlckPereaA1HUi5JKXr50hNTE6AEm
	CkkbBF6y7oKtbp1F5M+slRGbtbhvZ353Udn+XverHFtHmE4JKbzGHlakqPcLYO/dDd8laVF/lll
	h7VZ
X-Received: by 2002:a05:6a21:888a:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3cd14c6b2a1mr6258489637.4.1787224515872;
        Thu, 20 Aug 2026 04:15:15 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15568c722sm1676503a12.24.2026.08.20.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:15:15 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 0/4] net: broadcom: Improve IRQ error handling
Date: Thu, 20 Aug 2026 18:14:52 +0700
Message-ID: <20260820111456.97947-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series improves IRQ error handling in several Broadcom Ethernet
drivers by propagating IRQ lookup and request errors instead of
silently ignoring them.

The changes were found by manual code inspection and compile-tested
only.

Best regards,
Phuc

bui duc phuc (4):
  net: bcmasp: Use platform_get_irq() for IRQ lookup
  net: bcmasp: Propagate WoL IRQ errors from probe
  net: systemport: Propagate IRQ lookup errors
  net: bcmgenet: Propagate WoL IRQ errors

 drivers/net/ethernet/broadcom/asp2/bcmasp.c    | 17 +++++++++--------
 drivers/net/ethernet/broadcom/bcmsysport.c     | 12 ++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |  8 +++++---
 3 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.43.0

