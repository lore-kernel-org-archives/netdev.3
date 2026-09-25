Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48C45FFCF
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345493; cv=none; b=DWgOGCcpQdWMRSlq6Z+RW2uurDC8zNDVi4t40meoMdcy/sk4rQziUlJEuXcImqD1YxKGZc3WYErRMGEA6QhQUUOqcFIQ/x2AuR0YCG4zoARcvufgEYCVwZpoUrPDwc3j+AozfCjFzpg6h1vFq6/guWDI4t24nQAjQiYJp/ZlfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345493; c=relaxed/simple;
	bh=dndpdC1BFf2YzxpLiKezMO4GTZISkuWDrKJcbkUpd/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=es8ArCPCXa0qV7x0AHs08LMVn1fKl3fcVOgGxm1TUzQZKwNWHRpqRVJKM/MII79l2454XNIbLuE1DBzj3nXHWxG1q5n6R/iVfOYfiexImjxKZRcu9dDi9qzIJ8fNx2K62BM1RwA5UBQMd8I7li9zzwCOK0hE9kiwWCuVFWbfsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com; spf=pass smtp.mailfrom=agilebits.com; dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b=uE2R0+c1; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b="uE2R0+c1"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-9143d127a26so2945336d6.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1790345491; x=1790950291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3Lllhowz5xAm041vYg/0uhyYfJTfX7BTIf91ZP5MNU=;
        b=uE2R0+c1d0HLIki2Xoh4xJsjMAYRdFM9de9SkPZDS/HH10hgHz17ckVXxqPEsT7WpO
         TJENKPEVEBcJAilbP47sjLvNkL5TPZtyiKE+gjJF1hyE37bsx6EgFj80yGt0TifVUUmA
         pfPD4PXZ0F8a/NfcNoGjpY75+Yj7O/B62Us1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345491; x=1790950291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3Lllhowz5xAm041vYg/0uhyYfJTfX7BTIf91ZP5MNU=;
        b=qbld5JffP2rzv6tsaEwieGO1ZMdKlnlhHsAveuj1TsBWIbejl0/QXoTy6SJNenMb/y
         VUJNqike0fOOw1EJWcJPwi+GUFqBBwFKbL/RMjakXzM13k71DJg+fiH1vD0voezUSC1A
         w+Wb5J0+6qjrsWcnxrv8/plLyym0zxl9P9DWl9CP5e9girOj2rPIZBI+/RZp8u9zQH/m
         D/F7tbYSvxVYDPWcLszeUzHS6DtYNXrScmDS0p/X3pv9zg1sXHM2JGUzGrO8u+84D6wl
         HIMt0VzpZmGC9HjYhQ54cf/nxyqjH5iF+V9KzMleSI0A/xSM8mngp1gMcXLuMYkdvkXG
         1l+A==
X-Forwarded-Encrypted: i=1; AKwUvBzNF/pnSO3b7DcFq6ghulPtfuZLaUkXnI964/wXDB/IFpS+N/+SHkUoU8WH9j1rtgxPf1ofhWM=@vger.kernel.org
X-Gm-Message-State: AFuF++laWAnU8HQ4ThhWXr/Vmc8HvM7UNM1mNNoRPSha53hlUVIIjrl1
	vo8OVE+Y35p+IQzI/fn9A461kGZPWvpvhkmMyv0yrXvrGOfTDfOECTwvlK/tb74IOHY=
X-Gm-Gg: AYBFou1NpumP+lFZxpkVB3iv0gEnR6ivzK61Omr5sp1z574bktl5TBKOwQwtEyqp/Qk
	knWiq8w/7H3NZgWghLvKb9elJ+XNeOXXgis0SDvY8L9p/Ar3A5r+8NgODsrzr64DXSIpJZxJ0so
	k643prs+UELYH2r07h6CGyBuqmPcyUlIagsHBF5h0EcqgyyhzUyNc9vnMvbLgll1fXZF2SFSTvB
	Q11FQCq6H690LkYZC6P2CoNvBZMlsoNbdnzd6ewa2v6nGoeMVZ4EVKfLirZl1i41GsBgp4/wIg9
	4IN5344Mx9GLpZqaA2RiRIjmDkZ2hbWSh8/PY35KCeCgB/fMipkv5KAH/tGyyrE2j9jRFS9aLnN
	FsBDu6mZ6t7jaZjIw6vJoT1VBo0dbRqCQTIuaxxia5ndJzKRYdXeLOrunKWx3A019F/nSbX45HQ
	uQNl9+el/nQdOytENYchkXW9hfWKfgCbgc0QXejWRoLIwOa2Fy/0yCZgNZP/M2Jt5Xylj5jWwDB
	Crq7Slhch99nKNblkbIcLqtjEiOeQqAXBIxTqhl
X-Received: by 2002:a05:620a:3706:b0:939:6de8:43de with SMTP id af79cd13be357-93c475124cbmr376847185a.50.1790345490729;
        Fri, 25 Sep 2026 07:11:30 -0700 (PDT)
Received: from localhost ([2600:4041:59c3:300:7917:c7f6:28c6:182b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4493ec1csm187075685a.30.2026.09.25.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:11:30 -0700 (PDT)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Willy Tarreau <w@1wt.eu>,
	Keith Hoodlet <keith.hoodlet@1password.com>,
	Axel Mierczuk <axel.mierczuk@1password.com>
Subject: [PATCH nf 0/2] ipvs: keep templates and cport 0 conns away from packet lookups
Date: Fri, 25 Sep 2026 10:11:13 -0400
Message-ID: <20260925141115.16126-1-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A template received over the unauthenticated sync protocol with a
nonzero cport is matched by data packets in ip_vs_conn_in_get() and
the protocol state machine runs on it. Patch 1 rejects sync records
with inconsistent cport and IP_VS_CONN_F_NO_CPORT combinations on
the backup.

Patch 2 requires a nonzero cp->cport in ip_vs_conn_out_get() so that
templates and connections still waiting for their cport cannot be
matched through the out hook.

The companion patch "ipvs: filter some flags received in the backup
server" rejects template records carrying IP_VS_CONN_F_NO_CPORT.

Axel Mierczuk (2):
  ipvs: validate cport in received sync records
  ipvs: skip cport 0 connections in ip_vs_conn_out_get()

 net/netfilter/ipvs/ip_vs_conn.c |  3 ++-
 net/netfilter/ipvs/ip_vs_sync.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.43.0

