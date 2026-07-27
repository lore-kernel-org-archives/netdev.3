Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44A38A71F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127022; cv=none; b=GJPZi0zb+Db4HzedMSqTORyEMrfWe2tYdybTNk9nyQKNt+MZVh49kHGBtZGXxjUSlG73L3rKpt1q92ysnjdGuc7gdooAkoBWHLl05eQ1sonFCo7Ne+FeHmv91u8njmmsxhVET98x03Rf+pm7QLBqR1kzMyHTU1ETe2E5tfsraXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127022; c=relaxed/simple;
	bh=x3CMmikYyScJCif71CpM74tv4qZCOikvVwnqpqw8/TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUVt/FNUpn+tjaK9k9aEY0PRbrKgjFuOOf5MZ2uBqAo7i7oQ9csyIhfa+mWAHICYyyaChhbDThZq/Qbd1ffVD7KPX78dhWmsV6u6hj1morIiVMq7Kl8M+fPZJEeVOXkjpcHLKRPYo7JYaYv41o+43AFIPeALLbyNN6G0TpTr0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsAjs16M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsAjs16M"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf52d15d88so21203355ad.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 21:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785127020; x=1785731820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D72PoV+31aRv0SZZwCv/46Mi1LQWMPnWSHyMaofDuXg=;
        b=CsAjs16MdpiOubyNc0VKgEqyjbP6WOLxWSYvUhefgU6tWAmdpHLpIDtGa8W0nE3erI
         qTOjbEckXZ1t0ybtYP8L/GsJeWUycP+NlKyJAe+xXqEsmVvdFwXcAYwP0yhKd816dwoo
         nROhoaBy44r3y33M+oC/v+f3REYP5MPhCGeK2FPF/8WL7zDMacLFCfKN0U2dReJf1Pt5
         6gUnHkw3KJ4avLTlgiNKw1srtFF7eaDVPJYMXL/v8i8furW7VpD2dIj0J1wyWG3Xd+aW
         5txCRZKcswJR+FfR23LnBcwsWMubOzdgoj+F+mvDquEPLARDTCIZ/WuuC7HirkutdtS7
         MqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785127020; x=1785731820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D72PoV+31aRv0SZZwCv/46Mi1LQWMPnWSHyMaofDuXg=;
        b=oKCT8rsUujGxhCf8nonqfT0RO9O9OKsxYR5rlVejXH3iufcSGncZkVm2iYGM3GM7mt
         5jVruMmrGDe8/c4CJ+j01//fuh1BWU2vlilMOsNSJ/gAbvBYsAso0XcgC/QVQ+EqMApi
         C+oFxPGr0A/kD8CEY5uTb0l0C0HF3RsqWz4p20Us1wazn/2rsMo/iv9+ULKus1K36dcR
         c9JFI3SREuazhTE/neyeL6gLSKR7OXWgSlLzl/ZwQjvv9zAW5+U1NQBv4aZP7Obg/IkN
         FZfZQFqRPNnVzjcLBgPxpJTTbssrrr/cU2trbbvGLbnbVeT1//5yTjFC9+iOeET/F3dh
         YTWQ==
X-Gm-Message-State: AOJu0YxY1T5avmESvmsd4Q60ld4R2jHy7y2IhSSTsCvtX+fxg4+NXU09
	FcKDDTNg7t82H1ukyOmLk39h9lsAJjGOtkRDOEYRMr2hlzEAR6+fDp/dC9Yijg==
X-Gm-Gg: AR+sD12w0NHF/TEKHqJQH1Xj1jEnHBEsV1FUJOv0Gn4Awp/p5jKtEsz95eOsP3CK0OO
	TQFyoyeNbfbPNDyUYsFpjn1iYl2B7u+zKvYxvvPZv/lK8HXAt0jVXz/NS+e7l00ZOQl2f9VYZnh
	paVFcRxLmRuENCd+qmy0BEAOPl6ZAm50xXrIsdmfPrqTRjSFesXBsOgXh+ZukYjoa4I+IxIP9fv
	dfnX8O7CHlUam9tQ8Sh7/993G1BEFJw10zIpu137asGI11pYlgEfKWYLBe/py929WBIp+dMrH16
	EVa1jfnS1REswicn6J98ca8PGpuv7iBDOpjSz8hZPa+86pv0SZR1fYq2bLAFQFiL6XUenIS2oYt
	EVS7qsSFB+Mdl7Tg1RCr/uKF2f+yCHhhC6tXwlMGP5LlezwlU16GazF1MfvB96pdEGc9IeZx6q4
	KRaIY=
X-Received: by 2002:a17:902:d2d2:b0:2c9:aae1:a61c with SMTP id d9443c01a7336-2cfde7af8b3mr63097895ad.20.1785127019581;
        Sun, 26 Jul 2026 21:36:59 -0700 (PDT)
Received: from marceloPC ([2804:1b3:a8c2:99cf:6381:2414:ebe3:a179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc4164ddsm26249985eec.9.2026.07.26.21.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:36:59 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
X-Google-Original-From: Marcelo Mendes Spessoto Junior <marcelospe@proton.me>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Marcelo Mendes Spessoto Junior <marcelospe@proton.me>
Subject: [PATCH net-next 0/4] net: selftests: adjustments to ipv6_flowlabel_mgr
Date: Mon, 27 Jul 2026 01:25:06 -0300
Message-ID: <20260727043516.93101-1-marcelospe@proton.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipv6_flowlabel_mgr test file was lacking coverage for the IPV6_FL_A_RENEW
action, and the IPV6_FL_F_REMOTE and IPV6_FL_F_REFLECT flags. The first
three patches from this set aim to add a proper test case for each.

The fourth patch proposes the adoption of "kselftest_harness.h" helpers,
improving code readability and conforming to the implementation of the most
recent selftests.

Marcelo Mendes Spessoto Junior (4):
  selftests: net: test IPV6_FL_A_RENEW
  selftests: net: test IPV6_FL_F_REMOTE
  selftests: net: test IPV6_FL_F_REFLECT
  selftests: net: adopt harness for flow label mgr

 .../selftests/net/ipv6_flowlabel_mgr.c        | 450 +++++++++++++-----
 1 file changed, 330 insertions(+), 120 deletions(-)

-- 
2.55.0

