Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0715665C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122446; cv=none; b=t9V9p1mwvKg+QPHVT/mMJPiVC7dVu2eMnBW6EAd1HfzIKk8PJzK9c95qx4x10wiqQP4U2Q76OViqR2oF91DH32VbUNRYCtjyfBzv5yNYochuwpgFWMlnqtAp/dc078Gf+ZNds9bb44phTTZx+OoSZEAQoLaaQsDxNtgrRcq+tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122446; c=relaxed/simple;
	bh=8VqQ9Du3LqnHGtRQsYNF94aQvLmnHwFPL1nPqmPdoXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3FPdf4fTVp55pEQ1RV8jwdl1VVXaPE5W88jaKYlMnr8rofwcboom4xy2jsTYpWwxByHzIyJDXsZ4vpy1D+NJKjo1pphFVTTsz6cOpXomA4jSGraPvnxhRgHwBiN3ognVnX3P4wkurePlpwHUbOmisIdPGgdHTXnExNHfBvoliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7GHJ7fR; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7GHJ7fR"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40427db1300so2277166fac.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122444; x=1779727244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1b6Q58fFnhqSu9xPB14Oq6kcncPjb9xmJOfwwnnAW4=;
        b=L7GHJ7fR1jaBhKB9qsCsYCMTZ5K4/V1lrVT0liJwr/kraOxNuahP4fQjaUt/JQcXfk
         SOAoY58eVRgYnBOpgr3v1nRAkAVtI5Jq0baDQ7zqi9kG/y+TiDWLM9ImtUzF+UTkSqEi
         igkHdbUELjtEAS6Jz0BzaH2n039PABij4PAzMv4qjNuVjBMZmNqNMzCA8ePwwHtRkUeS
         qEb3+uzxy9qm5DDEcQfUHPkTvY9zGKlQI7ZN22OOqAcTYPAQNOBmlXKLILyZ1NGyo1Md
         IxfYbPHZqMTwAHA+h1aWOhoD+BJB0MD7Skrdke0YAgTXGBvssrjR9xy/q2CVNkfga0rK
         WFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122444; x=1779727244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1b6Q58fFnhqSu9xPB14Oq6kcncPjb9xmJOfwwnnAW4=;
        b=Dym24T5cZTEhUC4d6/H64CLxEllARhKQUGF4+3IKJie+ttWU1fAycWek69Ct0eZzlK
         eLWsb0JbFvHKN7JJnfSw453H5k2dm/YmpmaTfHRGCNJy7nSeWbh3iU30uWbrN1oiqyHV
         uGVw7JNSOmDvPnAWP8Pw4gOXUba04ft1hX52pLlG0XOfwq2zGQNXohHuAuQMnLob+r/o
         LqiJrIZ2eQDXK/g4gpGyO1SlE+0maJGks5wh2oRbznLGhXZkk8zv1MIH9t9r4rMHoN3u
         v8RnHnIpj+T8PRpaCjVow8uZLpUzw2aIYxwTB8WLCO7o1JI3GyGbRzVKaK2/TWbCa8/O
         jCMw==
X-Gm-Message-State: AOJu0YyMKtxGIZMhsTuRUjs89LA4ayGquLq2DjBVBmvYNjaRhvoASbJF
	4RM/pqZJ2S0MVzEIbGtEAaof81t7WYp54ksRMksKwTTpgqn7nKWf7/MTaidg9SHN
X-Gm-Gg: Acq92OGgX42e1B1PZW126/eo4dyAWuIkFCdLk0YPAlO7VNlrBowAUE+v7Y1oHe9q+ZL
	DNI2yxOwIF+VAth5Ai8qF6gI4Zg+FfGhAsq/aaWRM4xIMBLpE2ph2R5JRyBZbGIEXLOw6AEi00f
	tkfcbuA698PpPOOqVF/Ck6WveswOLoZCXFUGI4JqDx3/zBKytOr0tN1yuiJhyMB+B7zfRpoNI9v
	eIiK06DKxinbEbvQg+pK6CtIz4t9YJ52NrvJJYX8mG7NGObuhsxUihHWE7tGrhdg5YgcbT9YrrW
	XQuZ+moKW+TRdr9pLQ7MLKNvEqPiZXtOgA1bmYfiZnMO0bO7rmXH6qWY4XZTWE91cM1X4Xv+Iky
	O6uga0gb51l8O3kEnU26L+omO3oWmvfu8Cd0LQYUjNgsWpfUBM2WN0un8wiKRy3WIGsK5YvP8t5
	hCdGCCT7+vW4eGI2c=
X-Received: by 2002:a05:6870:b492:b0:430:3591:26c4 with SMTP id 586e51a60fabf-43a2d9171b5mr10895417fac.7.1779122444172;
        Mon, 18 May 2026 09:40:44 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fc2cdbsm4593877fac.6.2026.05.18.09.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:40:43 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH v2 0/2] Add OVS packet family YNL spec and unicast notification support
Date: Tue, 19 May 2026 00:40:26 +0800
Message-ID: <20260518164029.439928-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
family and a bind-only ntf_listen() helper for receiving unicast
notifications.

Changes in v2:
- patch 1: use YAML anchor (&event-attrs / *event-attrs) to avoid
  repeating the same attribute list for miss and action events
  (suggested by Donald Hunter)
- patch 1: fix enum-name from ovs-packet-attrs to ovs-packet-attr
  to match the kernel enum name ovs_packet_attr
- patch 2: add ntf_listen() to the YnlFamily docstring under the
  "Notification API" heading (suggested by Donald Hunter)

Minxi Hou (2):
  netlink: specs: add OVS packet family specification
  tools: ynl: add unicast notification receive support

 Documentation/netlink/specs/ovs_packet.yaml | 130 ++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py              |   5 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

-- 
2.54.0

