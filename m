Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214B51589C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904329; cv=none; b=RCdojBNIPmUGAZNCUykZZeAsOlr0ADiRnNQ9I5XXp+OW6AiY+xwmmaHtn2XjBaNhSPPOtzOrBzxoFzJlFh45L1+H+0Qors8C5PdlnC8BU7TkLps06ukfS3AQ2AGPoa49543iSeFfmSbtqy0D+d7ZKI9KYtKm2SexUVYvGjnb3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904329; c=relaxed/simple;
	bh=gSOm36L1CHqnRz0JPKrhBdUrdEjUBGO7nLBNSp3JC8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLnchh7ZNvm25NyVvBtGd/OCO6M9GGZEsSpN2R27d7v+hw+B3JhpY3CyPSe89mp4l25k0ix6DGB/n8sVEgpqXfiUJ2GStX6X0ixylhupcgvrkE7p3+Lol4oxONjgH3/mB65/xQswIycQPOaQG6RabAg91FHsxvzQS78X08Zjy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=ZqCb3k/6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="ZqCb3k/6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a02718da81so24960505e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791904326; x=1792509126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G0ZQZcgaBQhdGA16m+uS3WRQtqkRbuVzIAwmdD7WLL4=;
        b=ZqCb3k/6jjdNrSnBrkrZEX4XMlZSEafrE+V7bfGGetlSExOqV9umzD/P8eIUJ1H9fV
         4PKG/uCM8WYaGD5GqhB2Y2vehhtFM8QgTBysglvv9fRXhnApNbim7Ejsc3tDiN9Ez+Ni
         McUX5McE/TF46T7IIEzuLMZeIHnaM3IgOf/MPtv/fEoO9+xMIz+kLT06flDoRVV9pLxL
         Re8uceGsad79k7E1zMsqsVlTPnuWF+x7jkYKb1/3LxoW7BTKBry3KguaSVFhcbIEs/Ht
         +7Sb4HdBPcxMn1wpAx+9NDhuTqbVeihrVn9jQ89hdkNtRQAVSm1njj0hMlaY7pGmMZSP
         M94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904326; x=1792509126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0ZQZcgaBQhdGA16m+uS3WRQtqkRbuVzIAwmdD7WLL4=;
        b=OCMm4qggvd5XiTtyygMbI3fQPZwkBGqlgU3HiT2co3ZVzP2lj0IBMoHfBXAtiNPsRw
         r0E1jjFFKn01OT2q8Pm3W2kngqSY27w/mYCxhVe4PbkYm/iJ2ZBmCNQsDRyOLRtDEbBL
         MuYNDrGQ836dPzhJ1gQfXk+0sZOImEm132pbVbFkUwS2CiYrbXfV4bJbUIUM04IH++Cn
         5ul3l5710WbvBiQsv/U6fz0faT1w53zogLa4v/rZNKBM0qr/6YGFSz192CEZ/37hf/in
         c7sF0sYpDlIkPUXrNXCNnMKQtp38ZjWjj+2ZzGN8fGGZ+6+LjDABmFL0OU28VB6srQZo
         P8yQ==
X-Forwarded-Encrypted: i=1; AKwUvBzS6vE6kwqxvd1UftEEGkOAZ56+7Tvi9fye4uJMMT3a5WcF/OHIGj6Qg5eLaQ7fHQbq/I/b7/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3EQh8wfUy6CEqHV8nmi15fGh8VXQlPW//GMTIfsp6CZRY5jy6
	8RVhgeXeXSV+pwC+RjyDIlw/OEGGz3+U7qc36SdY/3BKDAPReaaEf6t6c8TYxxXVmDE=
X-Gm-Gg: AYBFou2dAiajS6xIZ4Mg0JYvzGs8c5IuEcQprzWzUUJSs6ytaARH1yibOcVLSDQyFs/
	H8+qmpG3eiUyM3Sye9Es7ceehTRBS2a6qQ1rxAQ5NAxRQwu2gzsuowIuCrDaNq/qaQQVWzEXHZK
	Z8GtjJLhqxhximQKXPUfWgURVhauIP8AbtN+WGt0rFVesXHsK4EMDce3hqbKRMWz9BDT5KM7lmR
	4LWYrkuhPftofOzUK3vm0LejxOfMMHOT9si64hDwtAmBa8rjgQOfrTu7rd3f8TDKn/93IEc7VBT
	P6junL/UmcKKlaRNxiUa+pKkIQxKF5NML+g/Srvgnex+5l+hm7gqdZLAjgSmN0zmLfqLEXHOGV5
	qvDox5DMljJxPA8mWM4NqTu1O8KVtCD+bn/DYEmvKaynA4FF00VDRu0+KI/hV3jcK3ieehXXvt6
	IDcfYokPOYhPweXWy1bciwDPaDVwOhgnebj0kQ5RRp1B1K3gwhYA==
X-Received: by 2002:a05:600c:46c5:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a18e4d6b28mr259958835e9.33.1791904325959;
        Tue, 13 Oct 2026 08:12:05 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf31b83sm380812595e9.12.2026.10.13.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:12:05 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v6 0/2] net: phy: fix a second attach of an attached PHY and the module put on detach
Date: Tue, 13 Oct 2026 18:11:58 +0300
Message-ID: <20261013151200.2473464-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two phylib fixes found on a Keenetic KN-1012 (MT7981) while chasing a
PHY driver unbind race. A second attach of an attached PHY tears down
the first consumer, and a detach after a driver unbind leaks the module
reference.

1: refuse a second attach before the driver module is taken or the
   generic driver bound.
2: put the module the attach pinned, not whatever driver is bound at
   detach.

Patch 1 goes first: with patch 2 alone, the second attach error path
leaves the first consumer's module reference pinned.

Changes in v6 (since v5):
https://lore.kernel.org/netdev/20261009180551.1234107-1-f@lex.la/
- Dropped patches 3 and 4 (the bind_lock and the unbind wait), as
  Andrew suggested: unbinding a PHY driver is a development tool and
  not worth that complexity.
- Dropped the Fixes tags, the series targets net-next.
- Patch 2: added Andrew's Reviewed-by.

Aleksei Sviridkin (2):
  net: phy: refuse a second attach before touching the PHY
  net: phy: put the driver module the attach took

 drivers/net/phy/phy_device.c | 25 +++++++++++++++----------
 include/linux/phy.h          |  2 ++
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.53.0

