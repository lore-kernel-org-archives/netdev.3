Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685407;
	b=Z4yff7UGbTEtyG27CPV52P+WH9njT/XX5tPI6id8k+2MAOjURS2aEux/eXMdG3+mpzHq
	 /cPESORDRLsioqn9x/DVuo3sIRlek1Rr+f4qhhPKGow93VnHyrLHIbeBd8nIMKyBj0K7c
	 nLcGlySmZGr8HZl3/6RDd3euiFh9NdMq0M8oL1Gzo4bUyd03j3A5+OWjM9clidTHuJmHB
	 +W68FwPs9YZSaH8mgBZfuSWyxkeo0eX0r9Lm/2XbdwNJxY6Mo7xlKyYjeMc6VAKqYCoaf
	 rJBQ+NF4gvNc16GEMCrJPnM5Ru+iQ7RkfyksxSr/gKNhnK3q53jq0h3vxby93lhMotQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TKiZFeJUlLaF2cjWlbWxlK679IXDg+jtMCj4786GFco=;
	b=egJNH5syjLR64UaYVitS8a0nN+DtgO5fFTwjIDLetESoyj9JpVGDGUubgVRHtVBJLaiT
	 wzF+a5FVZJt4kSI8WHnDjiy+3HLqr8JrUerGytrdoKfuTdaEYmCWDk4IVxJaqfnf3FdVb
	 v8Wd/LVFaDAkRKDUGHMuyyik038/Ug43U2l/8ulUGvxhx4Pfbr6BgabXmcJ4iE4Mf6nBC
	 TtpkmUc30rR5NQvC5uU0Dia2X3DVgJSRJS+D0P4+HkSI/HdGqpUj7YhDRISYY88PruEsf
	 rNUKc2eKqBj558SeveVB8AnXjdz6kqbZOJCTAnR119SOKHmSn9bjdosFzlRmf4tYrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmzsW+R5;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C6606A329
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33C6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmzsW+R5
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so980651eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685405; x=1793290205; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKiZFeJUlLaF2cjWlbWxlK679IXDg+jtMCj4786GFco=;
        b=XmzsW+R5MOEIC3FBhEhT8nnIUXXiB3mcI0ENYvxy7O1Q8LQ1Pj+WxcuCTDqNcCHQ83
         IaUMrck7a5HM8rXIqEPHb7kN5to9RsNcA8FovdJ9abNnL6eHcWaocb22UYtEYvlClLVE
         1EqL2XYZDUUqyKR9zRJzcl6fKA0y7QUwcT617ZDsxb81VZ8rtuFCAKgVXDu3yUPeeLjc
         5ioPVsWm4GlolS4MrwxSssRt5mYp4AKIXyesOnOhYz4RKxd3ZDgKfhlFbjuNeLNY6XAv
         FmxXPR89luxqUrZ34f3LxHNV9Fn5ycypdfmUh6KMpiqJdYSk0DPLm4/fBQEQEMfsxyKj
         Kznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685405; x=1793290205;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKiZFeJUlLaF2cjWlbWxlK679IXDg+jtMCj4786GFco=;
        b=LS2ypSnWwO6GzKlNOS1/qSnh3jc2OUFadON5iHghcFC6gNssZZS8IJxFM116zULm89
         gT0j41N1FDx4oqw6EjvfeeOYT0D8/KrW7nw+YaAx3Waf40DueIK7nBfuHhKmIatA0rku
         YR9SFaXybTF0lMv0BvTv7GZdO5i1dLIxu7jwmU6Pf+hGdRaJuPBYAvsVH9YniDLNmDcY
         NQzbKUodqzOXH2g0ThDcbxFnKr3JTsSkV/oSEQfpib3llYo4KerzqnTraTTZFG5ILIQ0
         Z/dS2fdwHN8g2BGlQ/PIfccz93McuGtvogBBfhjRAhKY4tHXdF57dmGDomR6YxDtRa3A
         jqrA==
X-Forwarded-Encrypted: i=1; AKwUvByxfFswAZ4iftn0uc+HLxpYHI+cnOM1npitpusip6xil1FpqPI1lVFd8UKjHcl9e6NZLczpYcM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnYTdZAgmHzanl29x8HmWrLGqP7UbhpknprOopZyaiRTKJJv5J
	0jZgjCKKbGQASmUDPoOglWRKKsUsKmrjU1ZQaIRswVZ3bZYGgNtBQUtL
X-Gm-Gg: AYBFou3zdIzvaZJLyWui/uMedZnaWDszWM1Pph5tIvkF0JLjHEtuo1NecPPuCDnZ8Py
	rrSbDh/RXv1AfIaKBu5d3vrD8zh9f2tcvGPrIy9ceL5jtlsA0cwglQBdpM1P7rYXGTmlsAwz//S
	YS+JuBXfJTSWhprYbTJqgYUbZJElfCuAy8NXc9z7uaNNa9O8rWvUR3buj1k66bxRLff26ETWGDB
	2KBerWrFuvDaRikgdFgvELktv2WsXw/SbK0YKPPCaqdI18HSYBgjUIq/A3+QLmNzyUwWjQ87bA1
	6W7cXAnrif1+wy0waQSxJt1a4515bmOHjgOBhHapL+QSIg6htzTVao923Q9W3ENz+Kyp5OqmLy6
	9e0SwShiRdXkGmK5pF5UsCm3lCPbVt5wzqKL6+kAUhqTbGZzb3eo1Fwfe0GzoREcOmr9ZeV+JrL
	YNZBxRP++6SPbnG8C1/jL2KHowyeuDhvRVk095CX23mDzvFf0Fi83p2emX1r96TKxDPYeotAlLP
	KOcUOQ/QuZXG9xeKyHX5Dvj3jOECLMZYtDaRtZS7c7+Y9k96Ba1vTm0dIAw0fbukKS46FwtzL8K
	KCV/
X-Received: by 2002:a05:7022:b045:20b0:183:3c2a:ae8 with SMTP id a92af1059eb24-190a84c288fmr7338019c88.41.1792685404837;
        Thu, 22 Oct 2026 09:10:04 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:10:04 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH net] net: bridge: do not bypass port state for MST without
 VLAN filtering
Date: Thu, 22 Oct 2026 08:26:49 -0700
Message-ID: <179268538303.70821.3493915601694605045@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

br_mst_is_enabled() is true when the bridge MST option is set and the
port has a VLAN group, and nbp_vlan_init() installs a VLAN group on
every port even when VLAN filtering is disabled.  While it is true,
ingress treats the port as forwarding and egress skips the
BR_STATE_FORWARDING check, so that the per-VLAN MST state is enforced
instead.  That state is only checked when VLAN filtering is enabled,
though: br_allowed_ingress() returns early otherwise, and
br_allowed_egress() only checks frames that were VLAN-filtered on
ingress.

With MST enabled and VLAN filtering disabled, no port state is enforced
at all, and a port in BR_STATE_BLOCKING or BR_STATE_DISABLED still
forwards traffic, defeating STP and MRP loop protection.  MST can be
enabled in this configuration, since br_mst_set_enabled() only requires
that no port has a VLAN, for example with default_pvid 0.  In that setup
a BLOCKING port kept forwarding broadcast frames while MST was enabled,
and stopped when MST was disabled.

Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
state bypass") stopped this bypass during port deletion by also
requiring the port VLAN group; the bypass itself remained.

Also require VLAN filtering in br_mst_is_enabled(), so the normal port
state checks apply until VLAN filtering is enabled.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ff746f036f54..85065304597e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 	/* check the port's vlan group to avoid racing with port deletion */
 	return static_branch_unlikely(&br_mst_used) &&
 	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
+	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
 	       rcu_access_pointer(p->vlgrp);
 }
 

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

