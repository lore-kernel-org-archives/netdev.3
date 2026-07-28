Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C743CE5B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253335; cv=none; b=MOTDnksMITIrkmqj4K/1iogjiK71WTvUi+QUKS8knD5v5F6G5QVESMgBtilF/d7B9XZhscdqA9GcFvFbbjYzwUq6KIVfieam4AXrXKdPTvBYScioVAcNGwbVzQBnfhXqW8Favh0Er1i/JjEqYtrVJYf0UeTz7salBsh7xmlAEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253335; c=relaxed/simple;
	bh=beUyAfpWugPklFiRLCAqNDIxpvj7FW5qi/RKS8iFTHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FedGFrdSXGm7Rz7W5Kt5k3CppkjNQz7SEIO18ECUJvHzs6760xEz7NXLckLLI2PGTnuwPh7ESlZxJ6J3RkYguhppdtbZ5tzHMn4u7JW5UqAOR7OoLVXH2Ossljc267PHXFEr6XzHaQtAWkcXnPxwK3wam00CMwWhM0wVMhO4HfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCnrjrGc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCnrjrGc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84861fc51f5so3290154b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253334; x=1785858134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pyi9qy384Pfx2H8X9vk7izq7o5B0Xjrlx76ik+i+KsM=;
        b=JCnrjrGc9LjJbA9KsAG5VvQZdStJWTdKphKD32HFP3sTbUCuOH05UmQGz8VfeqfpJl
         Muo6IE7R7nzQzz1/e51cExXo/ceEJ0T3mv1SVRbl0q8A4wZEX2h8uz4Cz9xZNV8cHxNY
         Z0T6fCE/2GX0+p2wuIMCxdszaTRcJiy2LFYV39J35c40f0sg5JAP3pCN2vjF9/HQ7L9j
         lHcCHVhm1Woy3CZg89S94lNG/eGLd1FqddwJtyqH2lj6v5N5RTl+9zcaVvPHqr6kPxh4
         w843xyYz/v7NYxctB3+CZ9GZBko3XAyXYgW+mJarIWwl33T0YDMp/Wvroym2U471Lcjd
         cefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253334; x=1785858134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pyi9qy384Pfx2H8X9vk7izq7o5B0Xjrlx76ik+i+KsM=;
        b=fYRqRSUOMGzx8o+qHUXCDdRw9lI4cvvF2wJxO4t0Ana/IqsRxA8EEwfvSpKrusr6Wo
         hr34v4GhAFfrtycaPC56NywDXzlW7QBn1+SqcqqDORXUolkIA6t+WvgW/cM+UYgWmCYD
         IRKVcpOOEXBpvps76PveVpv/UxwXrip5zvon4h1P79Gc8tv9VFKRUZfTy+AplvJQTxSQ
         +7mKqmDHmxjuIig9qUn/9RQxyl7Ayv0XhmHmMqlxB6oad0XgVekIbqQ4rJ6z1NlRg8E7
         VHorYSaIvQ2bQk8HWCivdLM/Yz5+/TMFxziSfS16kFhc1CsCvYQs8u+tQ/JS73uTRFGe
         BzRA==
X-Gm-Message-State: AOJu0Yzwo2F41a5taJMVpUnkkpy9Dv2wTJTiUmDMMjM/TpzzNDUtP6W+
	9TAZY6kP0xRcWzPx6wSJ3IaCpv6BKbxeF4cguaLbHwpcCiFRC66cwrSH
X-Gm-Gg: AR+sD12Z99DwepBZxHIu4RUxUYB2/iyomQtqrJ4wLAaSrE0alykzsDbqA8jxgWkP8q7
	Na4MMUGVLqT7FzHXTD3gtA0x20PY3aJ5F0d1FR3uJixEVHsesrOQ4SDTaO/BsNJm7fVQ5SE6Nny
	zcxaE1JsVibq/naCRHrgfRw8jrDtP3qgTYcwicWhgb0hw4mB9mcCEXZ/+smLg+eRnJ/YEDw/dBc
	MV8mPfp4sJq0/M4iH8sfID60LGZGLlRIhx7aHRA3FmCQUFt9S3SmTU22kJORH+4vqSPi7LjklIq
	5TxjYKDU0YyiS6g/P9RiIL831bLojB/c67sG3qyG9ggWMoB2Y7ifUVU6asOrj6DOYql/8dVCm90
	4MTqb7rG/EFIUVBKvDlNQYQM+Fe17IfwLkB1v7IPX4u4UQnIqGULwmrAZuAfE+8IOnc+i392Tqq
	10l90qccI2Kzdk+MZQdLbSMhtj2tJoL5KF3VIXc9RBJQ==
X-Received: by 2002:a05:6a00:2e83:b0:847:9188:e492 with SMTP id d2e1a72fcca58-84e9322a32emr3294366b3a.22.1785253333620;
        Tue, 28 Jul 2026 08:42:13 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03ca2c0sm109201b3a.60.2026.07.28.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:42:13 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] netlink: specs: nl80211: fix TOOD -> TODO
Date: Tue, 28 Jul 2026 21:11:42 +0530
Message-ID: <20260728154142.12133-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling error reported by codespell in description strings:
TOOD -> TODO. Attribute names are untouched. No functional change.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 Documentation/netlink/specs/nl80211.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..d9fdd66b497e 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -1139,10 +1139,10 @@ attribute-sets:
         type: binary
       -
         name: fils-discovery
-        type: binary  # TOOD: nest
+        type: binary  # TODO: nest
       -
         name: unsol-bcast-probe-resp
-        type: binary  # TOOD: nest
+        type: binary  # TODO: nest
       -
         name: s1g-capability
         type: binary

base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
prerequisite-patch-id: 912014811782d33538ddb17f00b64c15b364425e
prerequisite-patch-id: ccd9499245f9528a029f13653f6a670c70796caa
-- 
2.43.0

