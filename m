Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF93C585E
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166578; cv=none; b=IuH5Gcb0+HtXQxPHpvP6sTwHUZcR30iIJfrtX3+k7B1U/EiEPtlJHtTbRpQ2SbuJfc/tgvfk5ny77RNl8qfcaOmQvZu1H6WPunpPP6mfrphxU7seIK0S0ZJUXBUFFRP0fvb12DQUnEA5HLFT9ECM+nS9qcikt61i2ACShagMmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166578; c=relaxed/simple;
	bh=eeH1jPnINjHVHMbG9MoAFrXx/N+k2lCfRvyNTf2dvbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqcM1cEfnGvYnO2yZJOK27ssucRKaN7M4ibMndyac4qo87KvD/6URWF0vrGr4zbpiJPgZ/kBk5AXMMEFtfc4blqvvX85UaUjf+VbK6dzWbEksGBrIR0tqrBxg5iMu69QrxTDOPq4QhTGjqrenB6kGkcSCBTo1r66Vg8750l+Rz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0gFIT7i; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0gFIT7i"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398beb616f5so93808a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789166576; x=1789771376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBsqs4IGYYKTCC5Wl01mWLlYRMLLj/HTcQhSnUMd5io=;
        b=G0gFIT7iwYzQZw6mZhQyNLEJD433907H7p4DE6+9IKuH/ko/1ZvqPQqR8/sUUSUxYR
         yGxjW8sMPrXnEeI77y0pdA9vQ6l2Rgro2Q7e/KwMm/iuOIaxYWS/DWERxEb7G26VG1G5
         CcVdEJJyHms+fqE0B3g2Chm0+ywK/Kw0BCiJGDYSzJem0y7shZYMv1soeSWA6oAJFDYO
         IIKvO2qZes2saLSpVCBBPUO37a41PBvPk7tELvl3S2ao+SIATrIHajYSCH8bgVwQVbgm
         zqaNyjs0bess6GGcIFug9aDqGto784OiaefXwTF+EO1Nv/NFtTiQ1YiK1ttLtx4DN3XT
         eP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789166576; x=1789771376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBsqs4IGYYKTCC5Wl01mWLlYRMLLj/HTcQhSnUMd5io=;
        b=KBDajwHrdluthLazAQKiZoUfbmH2GYpzZrbpb8d8yis2XaDQPw1o53Flpz+Nl6zt1V
         RGI9/N1VJKYaulaaMP+QdtnmQ74AGRZfbF+mxgbTRwZAc4QGLgpd4mXo+4Zu6qCpAePX
         FmSAuB1UdysMoy8Uoux/HVGc1hmu585batfIDwGe4cAqlZ11/JJ7vuvBLPQDqA/cD62Z
         dCt1JO03hsuEIvyimxO8kej0hUwCSa7a2BQqNlyz/RwO+gcrWeEwkM5yereaBn3vEJuB
         9xDZYlhv/KSZgswgh2YeDYFbi01MJBpj3yNXyrx+NVt/GyNy7Hk1n8eclVY5vzMUvAtz
         lNkw==
X-Forwarded-Encrypted: i=1; AKwUvByVFZdbFUEI3CJfpB++6my8w4XRePD9b3t2J4QInkurDRZqe6nbZ1G68CaKkO4vRMkOOea/m2g=@vger.kernel.org
X-Gm-Message-State: AFuF++kTMVSl6wPLOcvzKCz5Le8JiMfCoDUtmkMclcv0qRDY6gNe4D9l
	xrsfgafG7tiw+JILGG3WtqbK75vjN8AvcVS2LBb6KJ+bHT/WbEI6TKcU
X-Gm-Gg: AYBFou1gtw1uFkc6XJbLiYFBpUaYwrE42AXK2OjEurxcWuMvWILmwvGEZwgCD3+kUVr
	s/XaAuHP0x2l8hBRCs6LkkBpQE0D8rj8QB/069jDRuW5lpYF0CafnsroZmLzWm5iAjykNJzBIs3
	+uxkEFoPLUJOFpoDwySR0E+6vkZ8mZUK2DChVVtRjsUUTKGczdmXUrDign9A35MBBKCkv+o/ES1
	Aq8HTOXAm+9ALwB+PiaTJOaRmwnv0dnmzFRUts9f7iLnNHdzEcZLXTW5+67bhkH7pNPlrUqRTi6
	1XrYm7OyJce2fwRIU6pdTjiMWx85MWMjc6GNQt3Cnt4A36gguqBLDmTJeXWHSc2KmUkFig21Z+E
	PfTlZwK3gKcdNLq7KFKcGjafNgu8gyPnj66AGfnEQYO6+303I1S49/TL62fVDV/53ns8RWtHmqK
	dC8+x3Sq4g9tiz4EW9LJcxZ51gH0pnuobMmr/DUygLL18yf1X9qDYjNVLbuo74Foien+Zd6H/67
	EXD
X-Received: by 2002:a17:90b:4d0d:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-39d97ea0248mr5492514a91.3.1789166576074;
        Fri, 11 Sep 2026 15:42:56 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b21sm6673425a91.13.2026.09.11.15.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:42:55 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Subject: [PATCH net-next] selftests: drv-net: remove duplicate functions in hds.py
Date: Fri, 11 Sep 2026 15:42:55 -0700
Message-ID: <20260911224255.3675903-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

There were duplicate definitions of the enabled_set_xdp and set_xdp
test methods. The two enabled_set_xdp copies were identical apart from
a comment and whitespace.

The set_xdp copies differed by a reset of the hds configuration.
commit ee3ae27721fb ("selftests: drv-net: hds: restore hds settings")
introduced the config reset, but this was shadowed by the copy.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 tools/testing/selftests/drivers/net/hds.py | 29 ----------------------
 1 file changed, 29 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index c4fe049e9baa..606e26d75951 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -240,35 +240,6 @@ def enabled_set_xdp(cfg, netnl) -> None:
         _xdp_onoff(cfg)
 
 
-def set_xdp(cfg, netnl) -> None:
-    """
-    Enable single-buffer XDP on the device.
-    When HDS is in "auto" / UNKNOWN mode, XDP installation should work.
-    """
-    mode = _get_hds_mode(cfg, netnl)
-    if mode == 'enabled':
-        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
-                         'tcp-data-split': 'unknown'})
-
-    _xdp_onoff(cfg)
-
-
-def enabled_set_xdp(cfg, netnl) -> None:
-    """
-    Enable single-buffer XDP on the device.
-    When HDS is in "enabled" mode, XDP installation should not work.
-    """
-    _get_hds_mode(cfg, netnl)  # Trigger skip if not supported
-
-    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
-                     'tcp-data-split': 'enabled'})
-    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
-                            'tcp-data-split': 'unknown'})
-
-    with ksft_raises(CmdExitFailure) as e:
-        _xdp_onoff(cfg)
-
-
 def ioctl(cfg, netnl) -> None:
     mode1 = _get_hds_mode(cfg, netnl)
     _ioctl_ringparam_modify(cfg, netnl)
-- 
2.52.0

