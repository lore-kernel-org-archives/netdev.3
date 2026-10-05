Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353F313E2C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175111; cv=none; b=PC2ET4ub6bZtTVziTPMvTUYWPm1Vw7qidhrB/K1+696Qmfganrv9WkWxFKEuyW6+YRNqwueE28k/L79jyX8yFCSYjNClw5w/lsnXb+8dY4/exZYsjH7boidHgyYNLLUstLT+6g80c2FtLmsXBB1U4YL8zSg0A02bxQnBhliD6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175111; c=relaxed/simple;
	bh=DVe/Uf9lRLG7TXnSdmrHU+KiaSzva7YYvHSdv24lx/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JC3enHtK1PTaAZl/OhUSnrJJ7RN2slg2t+V24cNFBF8tJmxp8Eh1NC15VagHpxS+gNMdMA4slpNjwqgXDBhXuzfTKSNsoslndGDW5SrNZkeBM67ALiIUkY4jch2CQy1gcTbtnEY2G2mI6/SGtDvgjWCquP0PRBFRzsFVMeuTT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8XM6jNx; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8XM6jNx"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso860234eec.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175109; x=1791779909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4UZFNv6HMjAlmXNHL/VJdByu8s7YE2QayAHEqne0TE=;
        b=M8XM6jNxmaSIfQzNsTHYKBlQ0p185Zit7Fdgb5h90oCVX59gvHFn2gt7jIq1YMuzN/
         KQAdu1dxblylVMmCb3NTrGGcTvz8plkFR+7A+mi7PnxsKFw718fUz+/pFrnAAy/RJDBr
         PlvnYr7/sj9fSO9NrqS4rgsJNhzNTz+cgbn6tirDbxTDr9Sh24fhHL1ZciKVzW3WZpsX
         ZbaUS/osG8iDZ6z2Mnb/lGYDRp0TSczg/t7J0dhfiOQpTQpaacT7AjjLWZl/E302Czs/
         tOdhb6vayKO2/JwKn4FiHhdAl4IXb+cM+EP6T0+W5iZkKoYf4cM9URA4tzg76V7mqVjv
         mj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175109; x=1791779909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4UZFNv6HMjAlmXNHL/VJdByu8s7YE2QayAHEqne0TE=;
        b=MRoJ2CcO4pG+XFma8DsB8NxyelyU43RnLOSrsOk88qQXMq3j85KLTq3Gtd0aEz5wMl
         moqh6unljIqXgDzOEnWolQvwVx8RPj3FN7HIzssJ1gTyDp/tXMJgh5l+tEBlhR0pB84T
         st+WzaV8qKJA6pmbKJ6DAKD27jDSuBp6WPqTHD1enVfDUHlpbFr1Ds1BXylEfm0AqL6z
         7kYaUmEINYuTxlW3CqpmgzjV5Emu8qClCgWFLCYRYc3u9/o8ErEkCDFmCJ55fExBrrJQ
         uL4skp6S8SsSrirHdNTJF4iyySjbRuYj8y+Yx/ib/JBmaBUAVbQrA6HncHOHr+96IsYi
         N4uQ==
X-Gm-Message-State: AFq9FYK1S8ZBwRlDMMHrlLkEaTv6LEO9y3YCzFTZEQJ7iq24jqgbCqhe
	alyxyV9eo7U3KPKyeWzDJYTtUf7SpqIIj/VmPAxv2Qh/oomd429liwfIw0JLtG1x
X-Gm-Gg: AYBFou0Va6+EMY2GvOXH37YZVTM3EWqvIm5mgExDYvCH6BiZ45/fD6gev2PqGD4lDjX
	FBkIl1EBV0gjSyFqvYmd8REr0rolla+jncuMXoBGsnLGYQhpXCZ3Ymm6hlFHAbGuXUOfJo8YmOa
	NF8wf35cfBhTkjYNTSR3XslKx2yME0gRxqa09vxjfkPKKcvVIYb6oBnhz+920UeF0aeOcZAjr+J
	Rj0ZFrBNBOAFtkhT6pjE93VQnOHbAAFW/VHTimFWd2eKRPP3xI5PTgm4iYP92i2mm2nfx8eOcGz
	QVtTSwLuWev9HfpQkBHpDbjfExnPmVDgH9D00soAA9kDCnGjnHhpZtemKlmf6GtKkeWnZABI91x
	k61wjV3cLKa1JmCFRauDuByyfvfWNa1CB82FJdKzi29+NbivkUTvw9/VTiogqkBW55zemVBKtRR
	loXTYdnc6kn4UveQBu/2llgyLNTBS+vUsw+wh5qP4RIbt65b0o2Z+I0CjwIXfLYJoMHZAZeKp5W
	caLT0I=
X-Received: by 2002:a05:7300:e5c2:b0:341:ec1b:5632 with SMTP id 5a478bee46e88-34f2199a7c6mr13011722eec.34.1791175108894;
        Sun, 04 Oct 2026 21:38:28 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm9518581eec.6.2026.10.04.21.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:28 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: bridge: cfm: notify userspace on CFM config changes
Date: Mon,  5 Oct 2026 04:38:19 +0000
Message-ID: <20261005043822.3106580-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CFM status changes are sent to userspace, config changes are not, so
the only way to see a MEP being created, a peer added or CCM
transmission started is to poll RTM_GETLINK. Patch 3 adds the
notification. Patches 1 and 2 fix the two problems the AI review found
in v1.

Patch 1 makes br_get_link_af_size_filtered() count the CFM config
attributes. Without it the notification overflows its skb once a MEP
has about 32 peers, and br_info_notify() hits its WARN_ON. Patch 2 puts
an empty IFLA_BRIDGE_CFM nest in the message when the bridge has no
MEPs, so deleting the last MEP is visible to a listener.

Tested with virtme-ng on net-next: 300 peer MEPs and config changes
give one notification each (6248 byte CFM payload) and no warning;
deleting the last MEP gives a notification with an empty
IFLA_BRIDGE_CFM; a request that fails before changing anything sends
nothing, one that fails half way still sends one. Also built with
CONFIG_BRIDGE_CFM off.

v2:
- new patch 1, count the config attributes in the message size
- new patch 2, empty CFM nest for a bridge with no MEPs
- patch 3: unchanged, rebased on current net-next

v1: https://lore.kernel.org/netdev/20261004041320.2684045-1-w453y.me@gmail.com/

Abdul Wasey (3):
  net: bridge: cfm: count CFM config attributes in the link message size
  net: bridge: cfm: send an empty CFM nest when a bridge has no MEPs
  net: bridge: cfm: notify userspace on CFM config changes

 net/bridge/br_cfm_netlink.c | 32 ++++++++++++++++++-------
 net/bridge/br_netlink.c     | 47 ++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 12 deletions(-)

-- 
2.53.0

