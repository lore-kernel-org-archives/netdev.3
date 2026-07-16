Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953037188A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234109; cv=none; b=qAOF4uSoDrKkbmwD5BS1NISAkIEAJdv3shMUxlP8dweNmH+0SQ/jQPMu6iCifygII3J1t3tT5LAGORcWbfIZwob2fs4k06fxKoWR4PNr4ARqb/XFxoodT9f6GSrmP5zz3l10E4XKszdtMtZ1LLD5kotLBCT1D5Mgr3UGgDW/beQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234109; c=relaxed/simple;
	bh=Q/XwJn3N7sbVhwP2i8d4DE4nh1H7M9Rkrz42kIVBVIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8nwkgVnhervk2zOzPQIZzHbo1UkGgnQJczJ6Wn60LV7UqdFc4GvyNxL0zrG1eKUcYOIyxFR3bChRLrYE20oIikCPPrHu9vGdY6riwOFz/i23AeCaN+p+z2soAE6UIGgl7RbHdVNpe56RK1xsqVDAj7pXRXWbUdc+eKM3pjffLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=jD6/UkwW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="jD6/UkwW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so29466595e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784234106; x=1784838906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QQAjFNHULURUxSmt1j/8JCkMYnUwWWzf2sKXPLOVu8=;
        b=jD6/UkwWShmjem3JZtOPdbsInHPv5UIkYyG1zh9K/ZdbVd8kLLQVzTAl/YbJEEHaX3
         t3SjWBQx1JOsja/oD9C8smf7PN/FgdDGVyDAX9Mq+xKcIJ+VC4ZFCwb0dTyP1qjk7EuP
         Oop7gU4ySNq94CT28y9+9/X/YSZ9HiNGqIHpOHjRYd62uYa2SwnhvRCf+Kn/czsBpEvi
         euG64O22kcMo0KsrmBJHS1SdEjqaYCEBkjFmW1pSiVSsxmhjutEq19xzQ/d0l2IcbkBo
         kCSh2YHiQKNnguiS4lOpyfqhiiUwVgV8wpPyflQJaQxkVbxM0yXXAIe4cCAB9ZbubQed
         J0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784234106; x=1784838906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4QQAjFNHULURUxSmt1j/8JCkMYnUwWWzf2sKXPLOVu8=;
        b=ES26AdHG9mX+23ydCZBKGKjWojd0sHN/6yTIKYWgsjhtYzVd/4zVenNusRJ8nbKuiG
         73z/AVqUdavP+iCoUOx6brdjQrdaaWvcMJvqsbmaWIDXDFbuAvRVcos5YSJfURY9LBOf
         /T62eU64kn6M66k25AqXhWzIJpxv7EiifVsbqxGhjOYCtcfdumSvIqVqHQahzjZUF7V6
         bRkT5MDZkjXmfUUmgkRkMo4MpPDiyqmbbHV3NlLIQpq0d3CGGVMjXdqkLJLprDmgJ4dl
         abR8TOCo9haKOPKUz/4sx0LpgSYqv/6o6s7hhGm461PbTuajUagtx/e66OXbCsSSZSui
         GSKg==
X-Forwarded-Encrypted: i=1; AHgh+RpoJycQ4EfKFt6VrrV7AzC0d9jQuMGj3ML4YsQHpIQDDjmGf3J12R9gUqJETMmozg1JivjZbVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5n8Btt5K8V0XoqoGrlSz2W/sH6iN2/cxN2vnvcB5xRJriRTZl
	OSxqO1gkyx1gBazK4oxMseoHxXi1KE23Y9qABFxJW7TrOwgxjc444Q7EnHL5U2ojBrUl
X-Gm-Gg: AfdE7clyDCwsvEAG/QuCtGQhisWtBhzQmZiA28vTpVKiXgxrfkikbaVt4FeRK9E7xkk
	A3ptSiWxhxJyW8ZNzaVPyi7qL04qaZ/Zi4+ysglIwDAmk9g9mnXTKq1tJXnpqqa4PzwQ0L2a41U
	ubd0HCp4zDn1WxhQrFNwdLDRJpDyWZvPmplLG7iNnk3uiY9erSRHgsrpgarqhdqc7Za0MamsqKG
	2EW+jQBC9iS6NXgmQITrDIni2cZj7kaqLWJEy0Cn+erRHPXoCVZ+8KY5LBR5ZeLAxWqJlCy/P+I
	HF3sQZ1fPpWIH3+0THPrRoJ8zAjtsVf11qOqUvn1SiUosNDTbjjGSKFZHBkKfBD0S3gtCC6DTMK
	buino4OgvBjYnGnlhSG6ERJBZCK4sLPI5FfeMNV9oadXdnLZvY1NC7iHJKfSmBQpnly3uQSVREt
	lPYAIebDPPveEOMN5Fu8TYtjkBVTLhNzLEE59/MQKsNwzBvgnoPwoGLx3PPcG+tOS0nJm9uguqQ
	dLuudLELn/VkWJ3lULLh53/
X-Received: by 2002:a05:600c:8b6d:b0:495:3fc4:81b4 with SMTP id 5b1f17b1804b1-495403fcaadmr67069805e9.30.1784234105873;
        Thu, 16 Jul 2026 13:35:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm4602835e9.1.2026.07.16.13.35.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 13:35:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: fmancera@suse.de,
	sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] vxlan: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 16 Jul 2026 22:34:59 +0200
Message-ID: <20260716203500.70573-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716203500.70573-1-doruk@0sec.ai>
References: <20260716203500.70573-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the sticky underlay netns vxlan->net. They differ once the device is
created in or moved to a netns other than the one the request runs in.
The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
so a caller privileged there but not in vxlan->net can rewrite a vxlan
device whose underlay lives in vxlan->net.

vxlan_changelink() validates and applies the new configuration against
vxlan->net (vxlan_config_validate(vxlan->net, ...)) and can reopen the
underlay socket in that netns, so the same reasoning as the tunnel
changelink series applies here.

Gate vxlan_changelink() with rtnl_dev_link_net_capable(), at the top of
the op before any attribute is parsed, matching ipgre_changelink() and
the rest of the "require CAP_NET_ADMIN in the device netns for
changelink" series.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: correct the Fixes: tag to the commit that added changelink (Fernando Mancera).

 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc5662..d834a4865aec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4421,6 +4421,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct vxlan_rdst *dst;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
+		return -EPERM;
+
 	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
-- 
2.43.0

