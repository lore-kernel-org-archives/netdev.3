Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93523F787F
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629871; cv=none; b=YsGPX+dqfqc4gJhUPCR7VkjDvogsBwrzeals5xLLmkcYLVd1npTdPyU0oO16YGL3f8LHlcGSTA0mdozvELsOa3DMOWHid+0l/y4VPS+uQn9UPC4QJ4JVEvJEJvYzHO6i2svf+wxKh2LxXMOEKj7rRvKUoamBWjWwCCSZnP6vEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629871; c=relaxed/simple;
	bh=7Yxz+ITQvs4gSufoddaaxMKTBtN2rFiFBlBd0ROOirQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cj3+6yHcgqpTq60fpm2/Ps54HJGAXHK3X/YgNP4WozL/wDwZ3TGNffxwFzSkQ/WdqMXhNd2Vo8bG96bLqoAuArHs8mcKI3nLRvCrKmQGn3xubyCvCoUuWfuuXDjR/0KxmfTzRg1byWYS6nkK6/cXOmTVWCft9cJNyvfxNgHzNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBKJH9DE; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBKJH9DE"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35834f72d94so763477eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791629869; x=1792234669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DEScPagcf5yzvrVh4E/CU31naOeEAlog7/cC2wN+nyA=;
        b=bBKJH9DEqsypIpS9vMHKWMyTEvncfcauZzq5yL+7PfPNFVGDhunpOSugVCBKb4E18h
         ljqD+fKsv/1+QWErDpXOyWq/BhPSKlwTm+MCIJsrCyFAP+XvboCyUJuPnivHVBS6LPsC
         Dki3+rEfbVgno1NHRijF3WXzRUlWS+yEMxdQ/l8frdkaqUc+aYt+a51eseVCksIDIUi0
         Lqc8yetYFzRharz4LVlLxovLCEqM1eHG8MLXcMU54kFrmplwds6i94MYcj5dqHEuVhRx
         8s6RoI1noStk4KJ59B2cZWP7f/L4pAYpaVUsBOBkRWcQOvJ4+8Pne0NMBDGtw3b7I6wJ
         Jy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629869; x=1792234669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DEScPagcf5yzvrVh4E/CU31naOeEAlog7/cC2wN+nyA=;
        b=uT0sQvEHdg82fkFCP6abZ07Lg1BbsjNCdsNiZSdub5RvNJbLUuQDtjPBnljPAAG/rF
         +S0/T+dHCrQlnT+1FPAyeAQDjIY05EO9ycLcwQwYMIAwD7bJJFl4sTIBU3NyJ747jQpy
         9OsBu1YdflFfbl4GYZsdNFztm7uwUcdaA0Hxo4xgzqG6EH1d6ixWU0wn/kiiNOG0iF6R
         l7jKjzJ24jcfJ/wn5Aqz8IlRiWdvaLM6hmhxzIWZcRpCVMuFlSeyNmi/PQAgp9IKwDHW
         zjn/1HpRzZ+9cGios6o65YRwHJLz8BdVxjp1nFa6BbVya5I7DDcvlSP9RGjV4U2utk25
         J44A==
X-Forwarded-Encrypted: i=1; AKwUvBx16c+0wMk3ZD1hdYktiGYwlZaOr4BjI5PI6gPp89B0f9ny8WH3ogupsCGWwMQuAd6+m+kEsMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq6PUZUNK/0pnnFsBmRPyYnTATaodv0LIxsyiwgUZw4BTf9trM
	hJiMN8A2vLbEecCl3PLfmI4M42DNm0LXJ0UObDTzUoLifsOeMrk68bH3JuCJsw==
X-Gm-Gg: AYBFou1tYf+QGfUEMY1rAe9p0oCiyXZ6Yvgti/tI7Qj/FkkpE5EILQXedpsI1+wWJxy
	8Y4TrJfbdxyEzYL4UWB9P2W+E/PeeTlaiWwdzN2Ywd+/VPHVWPnmH6o5oAOiUhqWvV5XA2hLf2D
	RDfCocmEvS/mS0XzEClBlUnbB2vwgZ1y1l747VEZgLZxTyGxu2dHP+0NAAPPXv7xJhIMWdzMQlE
	iv+DK8cmze5T/J3YBwpvzWSeBruISNj0/hvB2nBwFNSF25lzZeFWk8ILCi5KGv7N8C8H5iiOpXY
	0EgpCZkfr/JV7ZIj/Fe+0Id6db/F+Rhov1kjRrdvoK1xvR9vyd/1b4nZLZ5nSQEicDObemgb6it
	NyL+hliblRvl7+UhsWwagBBwvlDJtYRRGoFAIx9aiLqyRv4ZyuwwvHrMHOAEfdNPU2TSIlXDwXo
	uA7KPtQKUX533jax+I1lVj3+Z5JUF4gK/nF8IQ9SaComtPLdOy4LvWAwqAqh6wN/m+jgRkQW2nm
	Ch/GXTj2Ot1jKn3fThqJncHQSOQYyyx4xW/AUZYNPpdc/fIesD3iclUXSpaNx4TrTJRDj8UPCpG
	+L6ehxiZMC4Ftu2gxR+uhjmSPxvVRGiJ6W9ENmiV4/B+sU3tkPK4zg==
X-Received: by 2002:a05:693c:20c6:20b0:352:4ede:e6fb with SMTP id 5a478bee46e88-3537e0426e9mr5385953eec.37.1791629868567;
        Sat, 10 Oct 2026 03:57:48 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm13577784eec.2.2026.10.10.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:57:46 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v4 0/3] gtp: ynl spec for the GTP netlink family, a reply-command fix, and a selftest
Date: Sat, 10 Oct 2026 10:57:37 +0000
Message-Id: <20261010105740.223992-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a ynl spec for the gtp generic netlink family, a driver fix the
spec exposed, and a selftest that uses it.

While writing a ynl-based selftest for the existing gtp family I found
that the GET and dump replies put the genl family id in the command
field instead of a GTP_CMD_* value. libgtpnl ignores the command so it
never mattered, but ynl rejects the reply as an unknown command and
drops it. Patch 1 fixes the driver; patches 2 and 3 then describe and
test the family.

Patch 1 sets a valid command (GTP_CMD_GETPDP) in the get and dump
replies.

Patch 2 adds a genetlink-legacy ynl spec for the gtp family
(NEWPDP/DELPDP/GETPDP/ECHOREQ). Description only, no uapi change.

Patch 3 adds a selftest built on the spec: it creates a gtp device, adds
PDP contexts with newpdp, checks getpdp dumps them and delpdp removes
them, by TEI and by MS address, and that deleting an unknown context
fails with ENOENT. It skips when the kernel or iproute2 lack GTP
support.

Changes since v3 (thanks to the Sashiko review):
 - spec: echoreq request now matches gtp_genl_send_echo_req(): add
   ms-address (required by the handler) and net-ns-fd (read by
   gtp_find_dev()), drop peer-addr6 and family (never read).
 - spec: delpdp request now lists the attributes the lookup in
   gtp_find_pdp() reads, the same as the getpdp request, instead of
   all the newpdp ones.
 - spec: add link to the getpdp reply, gtp_genl_fill_info() always
   emits it.
 - spec: commit message reworded, the per-command attributes now
   follow the handlers.
 - selftest: create the gtp device, which loads gtp.ko, before the
   family handle: ynl resolves family ids once per process with a dump,
   which does not autoload modules, so with CONFIG_GTP=m the test
   aborted with a traceback. Without GTP support it now skips.
 - selftest: only consider contexts on the test's own gtp device.
 - selftest: delete by TEI only, so the GTPv1 TEI lookup is used, and
   delete by MS address in the two-contexts case.
 - selftest: check that deleting an unknown context fails with ENOENT,
   both by TEI and by MS address.
 - Patch 1 is unchanged from v3.

v3: https://lore.kernel.org/netdev/20261009060615.4177402-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/netdev/20261008181031.4129029-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  gtp: set a valid genl command in PDP context get and dump replies
  netlink: specs: add genetlink-legacy spec for GTP
  selftests: net: add a test for the gtp netlink family

 Documentation/netlink/specs/gtp.yaml          | 171 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 drivers/net/gtp.c                             |   4 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/gtp.py            | 115 ++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   8 +-
 8 files changed, 302 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/gtp.yaml
 create mode 100755 tools/testing/selftests/net/gtp.py

-- 
2.25.1

