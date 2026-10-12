Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB730436377
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788164; cv=none; b=tBHtaHGK5bUI66tVeFAfn29xw3BG+UI/OMT1gW1IgcT2wHuCnYBn7ntDyMTN8OWjlC5e4BTrr9Yl8rSubQj/QWg6tFykxmZ8ia+xPP7Ic8EHGUTSjZBg07lxx+LTbEbzbCCCPPi4+TNEzM2fhxRGP76X9peWdG1KX760hZqsQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788164; c=relaxed/simple;
	bh=cnBaA28hXSyLsgofOwD7Juzgew81dNllgvIK5vbewz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2InRXe5z53X5k8Qcx6nW82dItPuBXU8MAGfwHBgJxWGhNTCSpwmZskJXfCD6gbmbI2uJslMDOsLLQIbfzrtTByr+A0sCbYjgBQaPyuu8L+ShaKqHWdyM9vCpGU8eHwUmvUBC21Dv2+SI2whqgs5IBesuoF2WTxzbAZBUxr/d/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/b5gF7Y; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/b5gF7Y"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ac525c1f05so10946207b3.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791788162; x=1792392962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qCwGa78/N4sSdyoVo9fyToY/maKg12PI7oc0ofkdRYA=;
        b=X/b5gF7YSMYO2XMeTFBegvbXttu/MzuByWzLw1xod6mkyuaZKRsvckFNkThGtxi+S9
         C/wds0UfHFAkrstysF0yA1L3HMJatZ2I3EitqJ/NBXc4w7pvdtXTR982xwREtXWaUPRM
         jG4r+GecQzE7VkRtarhB/VumV4K6ZFtDoAil+QQEQUW/F5ze3tViF6R5E159FP80s3X6
         dYSW3whI3iujXJESJcGutGl5XoBplE1/eruITUWBvp5hso3L+xWbKAxQFpx8PmVs56nq
         RlF6s5J/mWhgyGKLcHIfBX8+yLPkLg4kEq98ibsvDc0oCH/dRgzH5Sf7xCYCQH5vw+j0
         3S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791788162; x=1792392962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCwGa78/N4sSdyoVo9fyToY/maKg12PI7oc0ofkdRYA=;
        b=TwMeib3qCPOWlnURNPr57Ue69R8R+P1kBvJsLwgJNFyUCnDx7bU3YNuoaqMI8zpaLI
         xfwx4+QZscuFMRzKtOxGYnzUXexAFWGCKGuIYQGNZs+no562419vh0X01n0ROx++IbD0
         wj7yEOgyt6iOT/gr0LTbR4Q3+ErdOticvhj1w+0ODLUWMl/CcjkwZszRFweLqNhQ1yty
         jU5Qrby9635SP5x72h4A/N93PsbRiwTq1aPlZJbwOmqgCgFBJfrrUDAhPeqeo5Iw9Kik
         w5Y0CJBX4zl9tPeB3WbZmQM38MW38MjDsHVQiFb2rufaG9QKIqukIe+V/mEfs2DiChdA
         kmCw==
X-Gm-Message-State: AFq9FYIt7BXzdYaVU9x2zxGiLmWRHkXWFe7BjOS1NfBj61Wxb7aEu9LR
	rllMpQuGA4P5cPIcsGyl3q9bWuh8LRinoclkQyUdKhjpqYbV87xaPwa1PVVyRb8fmng79w==
X-Gm-Gg: AYBFou1xaZwCRTUOC46HXiNkgIATkSizCfCTDr5RFyN2jlu6Mc7BtMRzlHFH+A3brsy
	jQt+IMFRbyA6+hNOsYNdNHjNkAHCm22QXKZ2v5JTsfNeFYGHosEIHFZ+q/LxogqXBZTWlq7uVUj
	Mq4KZ0Y+qQmZMa6uIJl0WkbPiZELzb0aIPp7DI1d1Cvkf11kjpQf8YyxBxS+/di16dknOnbjgIW
	QN+qg7YnPPMTNFHGsP2hzoYB5BNmKLnkt7gI5jw7r2GcuLB17Tz1/TKPtckQeeZaGhHb8VB2AS0
	FTt3LQ1JLGSjFV0H7k91jFDudMnJusDyboo5PN3k4pXC18qJj4865xrVBiyhSvp1ELZXCtyTsUc
	J3gEtN2eUiw8WLOouHgm/QiS0DqREFEaZqqs5u9vOrYMY9pCQIoUAkTUId+ydx91uUZ1V52Mp0p
	kXpFY6R6Luw6TLG4OdnS6uSHzMEp+f76qJFOpCUXv4PRl8Gl5IhkNk89NJFF9PRR/O
X-Received: by 2002:a05:690c:6d82:b0:8b0:8c43:72d6 with SMTP id 00721157ae682-8b08c4375fbmr23738807b3.13.1791788161698;
        Sun, 11 Oct 2026 23:56:01 -0700 (PDT)
Received: from houminxi ([61.170.159.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f25ae62sm32256867b3.43.2026.10.11.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:56:01 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v2 0/2] netlink: specs: fill in the missing ovs operations
Date: Mon, 12 Oct 2026 02:55:50 -0400
Message-ID: <20261012065552.2426415-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovs_flow spec described get and new but not del or set, and the
ovs_datapath and ovs_vport specs had no set. The kernel has registered
all three since the families were added. This series names the
operations and the attributes each handler reads, and marks the write
operations uns-admin-perm.

No kernel code changes. I checked the new operations against a live
kernel with YnlFamily before posting v1.

v2:
  - ovs_flow: probe is a flag, matching the NLA_FLAG policy. It stayed
    binary in v1 because no request listed it.
  - ovs_flow: del lists probe. ovs_flow_cmd_del() reads it to decide
    whether to log.
  - ovs_flow: the set doc says that replacing actions needs a key even
    when a ufid is present. ovs_nla_init_match_and_action() returns
    -EINVAL otherwise.

  v1: https://lore.kernel.org/netdev/20261006130533.1620706-1-houminxi@gmail.com/

Minxi Hou (2):
  netlink: specs: add ovs_flow del and set operations
  netlink: specs: add ovs datapath and vport set operations

 Documentation/netlink/specs/ovs_datapath.yaml | 18 ++++++++++
 Documentation/netlink/specs/ovs_flow.yaml     | 35 ++++++++++++++++++-
 Documentation/netlink/specs/ovs_vport.yaml    | 15 ++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
Signed-off-by: Minxi Hou <houminxi@gmail.com>

-- 
2.55.0

