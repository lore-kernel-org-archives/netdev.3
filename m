Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE33AE6F7
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065693; cv=none; b=TKBL2+8bqkoaCjr57ELYuOBOZUGgusKbqGccivdBy81jvTbbSPDdITHIwdA67Zqbx77xbLdIeY/oGICDBy849bVtW50BOIXvavkueCH9sHqlS88uuIaytBwZT4+Qha9NozeJjWZzEzryT14I8CG5oh7VTKyMw5wgwK3BVkubhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065693; c=relaxed/simple;
	bh=orYruE8rwkL+ojQp7lSc7D4f0zd5SSPB0JbO/i7kNVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgbktvygjh2ItaSdD2zW/FbcX5FdpES2uO9dotLgjlPkmunbCbF0SQf3LLiXTkXvVM7YarzjK5GY/W0gkKrcQvd1k3nD1fKW4XT+i3v0wBBqacKNt2ZQP1LIa34ARvYC5pvOfLWlpKQX1DbpfaKe9DXVP3oUgylu27KHn2UDmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dk0QDBXF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dk0QDBXF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956242332dso49896965e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787065689; x=1787670489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6pSy6zxul/pOC6qg9HR4Dtl8Ytd4LSgVsEi+aLWf9Y=;
        b=dk0QDBXFaOkoUpmgICD4WZQmc0JADpuNRjD+gJTsahbIcNHQ6Tn6rcXgu2p84oaPzS
         mj1p0c0kZof41AwdrsjdsFfftvf8LzkYJjiiKGvIBhds7gdQ7sNGgjNCHh78vhe8rx4d
         arvXUzM7/1O2NLOb0Up8RGfc9t90S44tESx7M7HgWD516hb5/9GWsm8VmnfAZSx3zPuU
         gsI7y8o6h66b53RjQxtXx+/x9YbJVlS8QVQiio7YNZJue2Ga+rMYXt+U82XcF7n5N4AE
         84rIptwZnSczIgqFlxPQFw50V/14b93UpUiLYplra7HlwWLSyJCDk8/I5e+koRMXrztA
         29bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065689; x=1787670489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6pSy6zxul/pOC6qg9HR4Dtl8Ytd4LSgVsEi+aLWf9Y=;
        b=cWnuDB1MJE4W2y3pf2GlmvPDczlYh5Te3UXF8rCp2mDY56aFBefbre80jmfTDD4pJS
         uyXTEyBJ2XIYGAOE9mLkfIWJ2I8+IuqYLVNmHuKbyfh1zw+ehXNszb/j3KFIyh69b7XY
         dBAir5T7n4r3KzgrnHVmnGhIkTviH6LweiOSNVzpYHdFbBJiZiq97sqnYElZp2VPSWon
         bjra2xaveb4aBiy6UFS/kWoOIrzXkc0xsy5vccw3lByJuyPDOUbMKFq+T3smbfamcIh8
         1uvdsTNmiiQJ743ejPbW5+oFwG541Lz0C5IHDJzpglWRq2QkCwuL2+CrAhuXy780cyHw
         N1uA==
X-Gm-Message-State: AOJu0YzJeHKdnxV2LMkNYenydBa/c9gC5y9wZpTlpDPPHCPpVcK3nEMD
	hO7gNLEWEe2G+ARMDP7tfW4qNvBYAjj/6jGobhvxMvCPJ4CWyLhPTJmcy79iE/+XGH2T7HVc8No
	QnMyD
X-Gm-Gg: AR+sD10s7LU80I12GV2ZGFups2fngTVBEK3cWzpNXsbUyEJ7TDBDGCte7uckFIQNPHg
	D9UCz861ftOewgC8ArzjZ2QFS8TX/0XU0KLG0vEfLG4hwiltJdgA02lvJ1+914AEDHn4hP7alm4
	B/0Aw2E/14K3yZNBbfhVriwstPpOl/XkHU/dHgNjcD1eIr1u575Btoy8Pbf5sNetYmL8Od0zBO+
	QGEhf5yhVVe+nxtnPNjawIVl6Ia7QrIkStp7IV8wDpeL5u2SMTpCbdusErYqtzakvpIRgZn7ttQ
	FhzoRbZb7MjaV8SstcION1s6NtHCcGYkczmcWTTP8nTUWUdpUt51RGBcd4v3zuCziNxP9BrrBfI
	sfhj9zamOua/PGwrPc8Zi6Nw6sR36+pGymGFgZ/55SHllTjH2IvHtym9gegmFmkrm2Me0YZtuvi
	AnMMrlAwxXciHHhssSLWifNdAZihP/dZMjDM0W7O7Y67dXN3KUmLYFjyKlP6Hv6KIxGpPGN6qdO
	FINPTm64X8=
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-49987995272mr433756325e9.13.1787065688567;
        Tue, 18 Aug 2026 08:08:08 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4999d0fb85csm183842525e9.11.2026.08.18.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:08:08 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 0/2] bridge/vxlan: fix reading neigh ha without synchronization
Date: Tue, 18 Aug 2026 18:07:54 +0300
Message-ID: <20260818150756.890025-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Neigh ha address must be read using the seqlock to get a stable snapshot.
Both the bridge and vxlan read it directly and can see partial updates.
I reproduced both issues with running neigh updates and exercising these
paths in parallel and saw partial addresses, e.g. updating between
neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
in the bridge, then checked vxlan and its arp/neigh_reduce functions have
the same bug, route_shortcircuit is doing the right thing already.

v1 link: https://lore.kernel.org/netdev/20260817143613.685769-1-razor@blackwall.org/
v2: - use ETH_ALEN instead of MAX_ADDR_LEN, the bridge devices all use
      ETH_ALEN and vxlan allows arp/nd reduce only when not in raw/gpe
      so it also always uses ETH_ALEN
    - align ha to 2 bytes because ether_addr_copy() expects it (Sashiko)

2-byte alignment is not strictly necessary everywhere (e.g. the ARP
suppress side can't reach ether_addr_copy) but it doesn't cost us anything
and is aligned with the rest of the code.

Cheers,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: arp/nd proxy: fix reading neigh ha
  vxlan: fix reading neigh ha

 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.47.3

