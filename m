Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9B37F331
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206648; cv=none; b=OuiYxsFEMga76rYRQSbK5O55utrz+594qU9mYZN6dciknismF0/LgKq4o3AxlE4QIr79eOL8jIN9wcgTp9zD2coRs7aZ6RZ8ffxkAtOm1JSoy46/ltD1oKfUaZkB2W5aRe7AcTlUVLJKESXd7bG9n9XoJ9fQybzcS1cv4AxYF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206648; c=relaxed/simple;
	bh=I4/G3HmEXJ4OVElGeCZxuKwSWS6iAiOY/MRgSX2ruGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OnpoGkS4bbu41OC9I0CSmyyMgn+CiuBkoVTp0htzzkhWJiCYPJ0WzzeOjCCfQDLACUtaT3Yp6SWdjm3uu4beaJucayUffq3L+J8ZXum/rjFtnQFVpox2IUH46ARVfjbvHUWaL0VwEu8DfeHvW7VKecpTHrXIwmtldchvds7eAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgqzQ81z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgqzQ81z"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so140067f8f.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206645; x=1788811445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4/G3HmEXJ4OVElGeCZxuKwSWS6iAiOY/MRgSX2ruGk=;
        b=qgqzQ81zhEJh2GPyiNOuPMkOGskPfeeAq0aULF0UsXs8suNQq3ozMHqKtz/JhIsT+7
         g1UsvfbXT5zDCc+ykExEY304yR/LHc+X7kbNv+vGf9VN3ZnCV9XV2CClZ9SEXGuFPXyw
         Yw3OUP+9AR5NdY74J/1iEt/WfSCXv9Y8XN44NWkN8rG55rpNN8Cl8bjC9TIh489pf6kG
         N5dpOgy92t7+BS6Bc/KSyPEnGFbE088CEWbwueLYd/ixrVqneD98Raqp1GnrAofgQc71
         IZZdKhH0Y7MV/aqGO1GGCeR91G9NzsuoQNT1PgyCVSbPv/jq5gYdvErmdRc6nxy68WBF
         6Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206645; x=1788811445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4/G3HmEXJ4OVElGeCZxuKwSWS6iAiOY/MRgSX2ruGk=;
        b=RTKWTJZkxNTH9XP+4TuV9rBq8BOCGgM+PQLLl0LI95WdtVOvKrrR1cpueP4z9XeudU
         kr/BaUdFf4o/9n6F/vv4fkE+Nac8IoH4rHjJ8pJ0F+/qVTJmQkBfeTKhQiKbQgLxMLxc
         OZ1uJO11o2dlfuwxwl+cuUnyMiX3XkpO2vYxQFTp62UoSMZv/qNBRW5pa3+XkUA982G6
         R24H8EikePkWGDf/kEWxnuiIhfLHpuR3DrVpIx9fDQ3xjntWguAPwb3J2VFhmK0WwcoG
         6qnbV0CAhD+xL41kc8LAUvVibCeJyruqPgRHZ+//eKFw8Lve24kDxnSOvJa3D1ph4sEX
         SmRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJomPfbtVebPFEwk7BIs3Y7pj35jPzWd+KVWs9IhyHjF30PmoEklPVx+Gfsst3VsYlVc55SGE=@vger.kernel.org
X-Gm-Message-State: AFuF++nrIkyFVfNaap8oXYcxWFH3FX+r6j/d8vV9IuPn0OD93pJU4Eu8
	FjBTLnJW9MwoOfz2bWO1su60xdn2AHPIO1GTtTzZfX6VsPU04/69Hhdo
X-Gm-Gg: AYBFou1YDiT+rgTQiViln2I1Vhlm98ChejFiL1bgdreMwjjr+0BfDkhjkgUkV8EwiOa
	wlgnpJc8LgYnB6+ydIYDAwnB+O7YUlQwC+uZ/SWOsecd/4JaJ+U4sv5VGgAm+vyRplUdENgHu3J
	F2ohwvPURAFAiLWsgHHRNyYn92cAdX/z94DmHHmj4WDVwuNbkLHtLnLKcYyjCKPIzA9ccfsBHT1
	0JdV0pNyYt4CjtaVm7gzABgOA44BepW3VoTPz+KiO5C3IgHk3h5yK9fMNA1BLYdYF3snp/NTDkJ
	96IE4FO9/xp1IzuhX/tZ6YG/RW7NJIAQhBO51ohj+RmhwnaNMl9+aUejYs50WOffHqSuN5421my
	FBwP5/hA+lkmBy5ZL5NSQDLeF+q3mCcH3fvEeI8YvGv+FJ4DNzZNIpgDyMCAf3b2poPNyll/jYi
	rmMHiv+X0W0C7jm8m0qV4FKpm/568hL14K7uVDtSHmrB2VtMpaCKSqQug0GPArGIgx8otEVxiMw
	iuKg5XDNrHK/Lpc1as=
X-Received: by 2002:a5d:5d86:0:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-482f79bac52mr39529891f8f.16.1788206644929;
        Mon, 31 Aug 2026 13:04:04 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:b1a9:fd9c:45a3:43b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3d2eesm125783f8f.15.2026.08.31.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:04:04 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: netvsc.rst: is XDP_REDIRECT still actually unsupported?
Date: Mon, 31 Aug 2026 22:03:57 +0200
Message-Id: <20260831200357.45390-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Haiyang,

Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
still says "XDP_REDIRECT action is not yet supported," but
netvsc_run_xdp() in netvsc_bpf.c seems to handle it fully -- calls
xdp_do_redirect(), tracks stats, and netvsc_drv.c advertises
NETDEV_XDP_ACT_REDIRECT. This looks like it's been true since your
commit 1cb9d3b6185b.

Is the doc just stale, or is there a caveat I'm missing? Happy to
send a one-line fix, or feel free to just tweak it yourself if
that's quicker.

Thanks,
Christian
