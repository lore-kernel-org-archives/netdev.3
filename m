Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D399379C36
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642969; cv=none; b=GKKD5d/ok1lo6CApWcv2Aq2kyFJJfRAMtr9arh5En69aIM72HmXtyl34ndfJ7QzTlh7cwU4aPmt08Ss8JEv7JRs8i0SY0dEHxlYelv3xnApk8XmpcmC5X+Xu/TcyszoY0ALcY3ZPiOZx32N+9U3s6XcVG6cFnom4ga1v8Gr4cYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642969; c=relaxed/simple;
	bh=DtEzZV/8p1ax+Tms2T+d8b3c66vl40iyvkvQKRBD86g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tx1LI3dSTyqnjD+EuC86J+EIsU+Ow7L1+fmOKBO6H8I02F2pBMOXIGhHupESsfS8cTe44wdFGMdX3aAfi9OWrRwzjpMfoXQo14WmmT8mnfkmN060ZBD1kzXothWdQlaJ6T8VUH4LerB+LB2kWj6MVS24ljaXfYw0dNy2EgPB2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Nv7lUJ1c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Nv7lUJ1c"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so87350505e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784642966; x=1785247766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMgr/GyC0oliwpxvZ7bfPAMw7Bu99ta4H5Xc1BeDdt4=;
        b=Nv7lUJ1crMw2xYNjOkrNFet0YH+EJFJp8qybXogFeotJ6PDwlKuneks9qgV/r8A8TT
         9Qhj3SG6SxsrROQeCsxWaZSm7gNI0ZGHSUIFK6sAJT+1L/Rv3KI6e4mJw8GxRsMYSO34
         GM1aq5saywXvPtXN6NqtvmfG4o6Qdh5UMEzUYak8iLZ2PyhnMfB3So9WI5RmxFmgfeM8
         vXIGbIaB9qxT8napa69sQTsMiswZBTVD8PR3PLhRsTkv3ORFemppJYQPAwd9Lnw1mqHn
         Bj+cmOF3519nwmoar91KH2BMtpTEhGqHE+7z1cM2PY37KghtNz3Weebyp787BUve+dTG
         DrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642966; x=1785247766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMgr/GyC0oliwpxvZ7bfPAMw7Bu99ta4H5Xc1BeDdt4=;
        b=BUBU9vPA7VIFFJknybJaCzYZIaPbK6hmg5+742Y0N4V4SREKaNt67PgCPbfibKQIy4
         BK5jk23exefPcNxBlQtciCXI2OmuWNJIJfkU4JkKbZEhBuBClw7IVO+dP6rBRR11u1WU
         /0QRs9ffUyvaBZpdjA15JqfKxaa12yFPIrZoX22kCbJ4uwxjPjdYmi7JiWqWuM8V1ikb
         QH8sOIdK5eagoDcZx1oAFC6L9JDY3b7AETBw/3j4687IblXwYnQFIxeLFLH0Cv2RFJSt
         2b0AWb73wNC/sxzh4QcrA2EIlvhrCGMnGklngUYdRJRuOUIii63i4GFTMGP6KFMKFPQS
         GQxw==
X-Gm-Message-State: AOJu0Yy3B/5vfNz1yR5N+Wk4rGvqu/Na6mhd6VZqNHQ8jlUzy1vacAj1
	+39GnphE/QcWshAl6pFf0rNmMwXzEjyowh+sccoq9MBHRCIVTq1T6MhwF//Qhq9h0IrqDAZE5Ao
	uAkGTuKw=
X-Gm-Gg: AfdE7cnAP68qO+prtyielK5fj09GuS+6YGVMy01iyDB7KHEdQQjQOQHwnjhRC1PVQhz
	JEGPGYG8/9mgC+CMojKoJs6fiMSrGVUHioeQESaqrubixxlBoPCAL2NZleHmBglq5RyF2oFTtnY
	JueeikoPEcrKIqMBJOWjFM25WJs+VqIu6IsWGReXjqx5e/bkYhe1hZ9u1m39wLNiR08zQrhsyZ6
	ua3IV/psnLg7LlmpFyEWiKQgIoL/cukiSHksmdNtL6TUm/KEwQzofkzfYuo7aWUcj59hfvUjtaB
	qR2Jj53hoQ34bKOG7H/Ai4RT5bOE/rD/PykaJC7CKqFBYRIeA7C69103OYxjgRKI+1sip7Wm93k
	WSduKhcJACB0L6O3tYH5liYNqdDuHFkTwS62LaJvQXYhqS5tlLFwwOLLOb/nOisXxjltcXfeclK
	rparq8RyHsCTgAuM2MGoRR/tWD
X-Received: by 2002:a05:600c:4ed1:b0:495:4732:1eb9 with SMTP id 5b1f17b1804b1-4954a402df8mr166586545e9.21.1784642965806;
        Tue, 21 Jul 2026 07:09:25 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49565482c5asm107807535e9.10.2026.07.21.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:09:25 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: fix vlan range dumps starting with a PVID
Date: Tue, 21 Jul 2026 17:09:20 +0300
Message-ID: <20260721140922.682265-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes a bug that can skip dumping VLANs which a part of a range
starting with a PVID VLAN and share the same flags. PVID VLAN should be
always on its own. Patch 02 adds a selftest for this case. More information
can be found in the respective patches.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: vlan: fix vlan range dumps starting with pvid
  selftests: net: bridge: test ranges with PVID VLAN

 net/bridge/br_netlink_tunnel.c                |  3 ++-
 net/bridge/br_private.h                       |  6 +++--
 net/bridge/br_vlan.c                          | 10 ++++----
 net/bridge/br_vlan_options.c                  |  3 +--
 .../testing/selftests/net/bridge_vlan_dump.sh | 23 +++++++++++++++++++
 5 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.47.3

