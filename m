Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132713C3F5B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134171; cv=none; b=OH59pgb2x6NHT/qQy3g7jGFZa4k86OgEtWwDkfGXXVx/1h6piLv8kF9Y0wYgAPC8+l2og/Fhqcz11aYv4TgiWZ+CY9YKhspP/PBviFPJ2JFfMFIrZKSRV5Sf76vAr7jfZj4RhFviGz/bRxeUvU3itRLYHFU4P38k4xvZ32ASYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134171; c=relaxed/simple;
	bh=rBHJvSFHLogmhqc8qfoepEplPJGPX9ErzSBr3vdnmXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8X80eFo9A7YvXq/G0HxIecrBQZ7ypweWW/O+00pk/NB4mWSDm3OXY2QxGolLLKTZbbzall2IOwnMffgiIaRapfWvqmisDzWXiUm2E8nHJ24Q7osQFJcKRsMswwRjK/6UqiB4OI1q6WP231Pl15VvT57VB5dXagnDaBIw3J4Q6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=c5LQ0Ngn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="c5LQ0Ngn"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1670dad7a8so197279066b.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134167; x=1791738967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYMVFKoytfLOZjDdNYvHmJsPemFRuNKvWdr0rA6Xpv0=;
        b=c5LQ0NgnxmgzgAX9APuwJeLA2LhejR+NZRo8avB1iEDHndr0IP9ah87SWkXn3UEIc4
         EZFpsIJhByekL7Ry4oalElnDHW2Bn8KXRbsEe6d4E/AGd/MLCGZcjac977RyLymzAp0C
         K+S5L+0LUvwiJVVFz5KjVU4GOyKWQiijuvkvmulkv1cnny1OWZGPKMNUb5Z2jtR/gn4r
         jv7N0Xshq316EC4o6u8UMvvGkBLN0ytqd9dw0j0WjO4n7K4M3GE+RGAPZKW+hnVUoqNf
         OEb5kmTZBWmdHUWDagr37MxGFQ0ZPQx9KbCkXp56dKNkZenLr2HRJRFaDe+Cy7ZpYV/D
         HeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134167; x=1791738967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYMVFKoytfLOZjDdNYvHmJsPemFRuNKvWdr0rA6Xpv0=;
        b=qsUveq/jqgi3gwuuSS8gtQ36g1qXL9y26fG5sTB5tcroHYUTjDCiQzwM5Wh1pcF2IU
         iW65DLcNTbliWswwQiPcaQYMHobbEWlMip4u5xiFFAFXOBktn0bJlOPq3FeFmbjR7uCG
         Nyxr69lG7Ufp+6apoIqWQuMaZZhP2mZIlHsCVcoupYluexu7Y1gz4r+Im//w/KuAQyDw
         DBCgTQoYE7+X+mCDu/68fg4B22zvFIgVAIKmSFB5vQr4zpW7in8dP+GOiG99v/y8StMe
         xX+xYy/7QHhfXrxO1bzfoOeHUUXshMsDt0hHdxUZuBkm90cMGZt0vhQaxSBUeIIH8fPl
         KKug==
X-Forwarded-Encrypted: i=1; AKwUvBy4/bx4mg8w5mjRGSDX8vu0HmnZu9Qmqff2HGcs//EBsjROVg4dLw9JpuahcIrSLBOdRjpd+ak=@vger.kernel.org
X-Gm-Message-State: AFuF++luccYchGVgIL4hEUDslEoIAxZwga1pagZGI+H9Wn8QKB/E3PJK
	lw8mAlv0nBMvlz+gc5w0HMRgMt9ZAQ8D0xzhfKVhXQ+3H2QG0IHtJCSwVgSeMD9jxw==
X-Gm-Gg: AYBFou1iLYK0ZdM2xXNs4ZWHwHMslbTnoBs+n4QG+RyUuDvVKyxzAZuoTK9uN4UuE/l
	Shyld3t2+4zQ0R2WQu8BFO2b/KDu1B7UrFYd9OJCTUQpFuSnZRXT1bMtNWF4lvA4ehtq1SmyAYZ
	2gf2zqBG0g19FPM86ta6cFp94nT2/zIRv7XqrajkOgxtPQAxb1KaP97KuPdSOpgZALnXLPpu4qZ
	dxeLiWyfYD3+VoPpTbctQELFU9/mouWyNAsYJQ/KTqPbbvoiIqpxjr4BxY+ma/8eyK8YSw2QMqo
	crGjz+v6ISdUH2oN/nZJQcfLFWPz53I02XbhGmBfNzdDhL/fmbGNC97T+h/fkja+QIBBTMDXf0j
	Jt8CLmD5Zh3Pog7UaD4m0ckwgcr8cXiHYP3Hvq6WAbJvUtifz9/K+zk1CCs8MTM0Mjfz4ybW4sC
	vuZvSEkXAt+OO9IllbmALueUY/bkvKaOvBqZ1yLLpLrZE9GIxBekcEjjg6xHv0mg78PQlo7+/tt
	PN1E1uiW3FBWrgamWj0DF53Jtcu7VsNg26ythhKNYFU7IzBha75VwmxdDYOAcwbOsncjaVO9OCQ
	u0IRUesBHj5unG/aS0dHcYAfO5JLfnSzDaFnhJ+ruzuxG48s+6aotJMMqAV9eIWRiZxaSQBl8wQ
	TDgDgDeYgnf85W1LiMhgb2xZJib/YRpQcwbk/wsal/kfLpIPI5j3e3Ma1kYMmXQjoMxhnHU+OEF
	0F1x7UNTK1EKq5i0sZR6hu1PRIPNqzvjQB8A==
X-Received: by 2002:a17:907:a648:b0:c26:19de:9138 with SMTP id a640c23a62f3a-c2e6ee5ffa4mr444266466b.43.1791134167223;
        Sun, 04 Oct 2026 10:16:07 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e878b0e05sm82284366b.5.2026.10.04.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:06 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	razor@blackwall.org,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v6 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sun,  4 Oct 2026 19:16:03 +0200
Message-ID: <20261004171605.3544792-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a
Wi-Fi station roaming between access points. Patch 1 makes the flowtable
gc tear such a flow down. Patch 2 adds selftest cases.

v5 tore flows down on the switchdev fdb delete notification, which the
bridge does not send for every move and not at all without
CONFIG_NET_SWITCHDEV. v6 checks the path in the gc, as for a stale dst,
after Florian's review of v4. Eric Woudstra wrote v1 to v4.

Tested on an ipq807x router (OpenWrt, 6.18 backport, out-of-tree PPE
driver), three runs: without patch 1 a roaming station's download did
not resume within the 29 s observed; with it the longest gap was 1.1 s.
Without patch 1 the four selftest cases where the host moves fail; all
six pass with it, also with CONFIG_NET_SWITCHDEV=n.

Changes in v6:
- check the path in the gc instead of using switchdev notifications
- leave the flow alone when its fdb entry ages out
- drop the v5 patch that stored the bridge vid; nothing reads it
- selftest: more cases, including fdb ageing and IPv6

v5: https://lore.kernel.org/netfilter-devel/20260914072541.897040-1-julius@bairaktaris.de/
v4: https://lore.kernel.org/netfilter-devel/20250925182623.114045-1-ericwouds@gmail.com/

Julius Bairaktaris (2):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

 include/net/netfilter/nf_flow_table.h         |   4 +
 net/netfilter/nf_flow_table_core.c            |  44 ++++
 net/netfilter/nf_flow_table_path.c            |   7 +
 .../selftests/net/netfilter/nft_flowtable.sh  | 201 ++++++++++++++++++
 4 files changed, 256 insertions(+)


base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.53.0

