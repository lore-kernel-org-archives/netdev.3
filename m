Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27833C1D65
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488832; cv=none; b=gKUh/NvCGd8IbRgtKBquBND5NFWwId4DR/VgkYUbeGdMkUD/D/EZTTsmLplObhdgCccWki3rcPJi7L4elA6nvUotBgF1h6IlIvkRcgdyAnD27pzSzNlFfzN7re0fGY6YRBvEMhQULPqykd/Z+Ryq6GNp7BYGRvW8ggx5YMBOxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488832; c=relaxed/simple;
	bh=pqbrimpQZfLLk3uI4Td0ansPXwwoN8oF6kE0W06N2qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hM/vymzUEWOVetoB4/EcD/t2HrIcKyfIVYr+0XnefteOFPR4wCaVO22XenW6mKpK49XUVAe2TYnNmo5nRc/vaFU04XZaqEVgwSdrTefrhT2C8MzwyBUI/Omn6QkNpWJ6ZQA+6c0RSfG3hyIk0qSZTXZ09VI9XdEBqZZz8Uawags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebjZz/dI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebjZz/dI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401F61F000FF;
	Tue, 15 Sep 2026 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488830;
	bh=sdtJJNJUqFjB/Cfopu3BIWOXeqhHqXX3+qhJ/Ka0Q2w=;
	h=From:To:Cc:Subject:Date;
	b=ebjZz/dIxdl/xEdOWZ5J4wnQaJ5LyyluNrBFId4SDgPTZdYQk0zofiXf3G1OKhEMK
	 hTpL2qsjPBYISXk8mSi595v6EvaQDVTSlUvJX5bndgmqNpNYZvNwFv7Z5lBAa/1IQ/
	 tL11WEOdO3dKVj7HRw98oyztrVZ/h/tIN+kt2R/GN2h3Coay8jNfUFAhg1Ks/XzwH/
	 MqVmv6wdWBdNiJT3BTd2KjZYsPaXbPXvI7liGV9KOms3GFC5djWxNM8jgDgfkxoE+J
	 XsEJtbPMJPG97IzhCELTopamKHAWE7sBDQRXW6HvPaFgAJQO+fE+uvaLvwcI3G49ox
	 mpE25v+oVzYsQ==
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
Subject: [PATCH net-next v2 0/9] devlink: netlink spec fixes
Date: Tue, 15 Sep 2026 09:13:32 -0700
Message-ID: <20260915161341.1053476-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of spec fixes for the devlink family.

v2:
 - [patch 1] reword commit msg
 - [patch 6] also update the attr list in the spec for region get
 - [patch 7] include port-index in the subset attr list
 - [patch 9] new patch
v1: https://lore.kernel.org/20260910200312.2665792-1-kuba@kernel.org

Jakub Kicinski (9):
  devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS
  netlink: specs: devlink: drop the stale port dump reply value
  netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
  netlink: specs: devlink: complete the port function nest
  devlink: generate the port function policy from the spec
  netlink: specs: devlink: populate multi-attr attrs for region read and
    line card
  netlink: specs: devlink: describe the netns id in the parent-dev nest
  netlink: specs: devlink: add pad to the subsets carrying padded u64s
  devlink: validate the port index in the rate set request

 Documentation/netlink/specs/devlink.yaml | 168 +++++++++++++++++++++--
 net/devlink/netlink_gen.h                |   2 +-
 net/devlink/netlink_gen.c                |   9 +-
 net/devlink/port.c                       |  19 +--
 4 files changed, 163 insertions(+), 35 deletions(-)

-- 
2.55.0

