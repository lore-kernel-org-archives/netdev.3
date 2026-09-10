Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0C414405
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070602; cv=none; b=BWXuKyP9sDqIjcpGia+wQyeHxbabTv90Sqv+FIthvaej0zqfVZPhtKA2wJTrv+C5TmdJUII1hq2ue9McCGZWFU3EKoK7ykPYdqefCVm2TtPFXyu/8fFNnU7WZreZQBebS829wVX4m/T2WUG4dj/4iQYKRV06K7YLcvx7XQ8wESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070602; c=relaxed/simple;
	bh=WyOEXbp407YP5NVS/khpv7m+EREG1PATN8Ikco0UfmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxedzflKTHWl08P4c3RKHb2F65U56v9fJbkbb4+ghupbqMdqDj+TFi0qC8UfbIYhQhqt/UZp/7sMTdgXk3X1zDKiNTiBag7yrCqtDD8rTVAg2UImKufU++pOHOjsFEKeTz1ItgboCYo7DDHsczTiTdp1zxoyCg7UV9ju9V24Pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSNf353U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSNf353U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881681F000FF;
	Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070600;
	bh=5CERSJGXY0uq4yE6H6D6UL6kf+w+30yBZqwDiQHSgZo=;
	h=From:To:Cc:Subject:Date;
	b=KSNf353Uw8AUksUCJfhld5fF2WgE+dRA9gLLTozBgd7KRRHTQ48epCn/bFIkpfRI4
	 REKpNI4wWaKiRnD4hdFDXLWTlYPminhNuDqzbATb+LepvDn+iS1nKl0fTA5vlV8oMw
	 zHN2jmeZPeAT5i2ZuYhLsIl7H1S3u5baZ7axKeFwzQDKp8rQWGtw6nTISQeVm2WnLd
	 7C5RHspohkUWWzPkKr6YIaoRgu5y4hrhx1nMDzovOgtZZEZ6irsdOx2K167/ychGkw
	 OmPu0l+L7zhodnvPnnPp19ek4EsiuF6EmeIHdYaMe8ATKo8V3GHOSoHKP2N2ouBxE8
	 TZeG1714XYh2w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiri@resnulli.us,
	tariqt@nvidia.com,
	moshe@nvidia.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/8] devlink: netlink spec fixes
Date: Thu, 10 Sep 2026 13:03:04 -0700
Message-ID: <20260910200312.2665792-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of spec fixes for the devlink family.

Jakub Kicinski (8):
  devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS
  netlink: specs: devlink: drop the stale port dump reply value
  netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
  netlink: specs: devlink: complete the port function nest
  devlink: generate the port function policy from the spec
  netlink: specs: devlink: populate multi-attr attrs for region read and
    line card
  netlink: specs: devlink: describe the netns id in the parent-dev nest
  netlink: specs: devlink: add pad to the subsets carrying padded u64s

 Documentation/netlink/specs/devlink.yaml | 153 +++++++++++++++++++++--
 net/devlink/netlink_gen.h                |   2 +-
 net/devlink/netlink_gen.c                |   8 +-
 net/devlink/port.c                       |  19 +--
 4 files changed, 149 insertions(+), 33 deletions(-)

-- 
2.55.0

