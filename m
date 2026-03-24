Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113C33B6DB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384887; cv=none; b=GDHOxaik+LiN8T3nLeSffW1ifmYihuvnV5D48aXbjT9AkUS4wCPVhxJdh54l65PumTkNwyH3J9iUPUbSBwlIyI0uCgI/vcPzaetuJJBsaLX55kuohhGNCI/9lfzhSnB5A6OfCmENaWg/YrbgRiPQavD7FKVoFmLMUQHATg+2sqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384887; c=relaxed/simple;
	bh=7rS4b1sOJwSZSDEH5NqgxYEH3TYqIFxgaRgu7FRsEtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwwlhCNDMcQp4WVxuZhGSmNQLMGSrkOcYevfhGUz+mWTq8hrp/BtwTWJ45V/gX1h//ac+Ugouomisik6JGy22Bf9i5XXmuhNVkffSXxvs1rknr0bjsh9ay4a2pX+zFbHn/kZf+g1FjNdzj12jEB4KSg75vrFsyf5AB1hHLIESDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEW6a62u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEW6a62u"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so38860865e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384885; x=1774989685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh2npv0O/elfFN32ItPoLhgPFIFAS6miRnp44yqFPqQ=;
        b=TEW6a62uRH3IhrFBWRmU7nER66jz2wluAMRAPR9daT4BGbIHgv2IWJ52qhuPAmPFc2
         EiRPW/LNPT6d+DES81SuPmhPT5KQXoVQnC3RF7TCtsH0hOLD/X6hI7gQSqInBG+XeYuW
         LWck936tSa2u63GTZbkV8uHpL+Mf+WenKI2C2wETz893ULyo0KMF/FUDsts4JFoxQr55
         YYoQzJQJw7rEJjfm7oTaG0Bw43sEUNjCARfsMgjuFEKUS/Usf4dzU3Ebd5nfagzRAKwW
         G1F8fPQOBMihL5bZ2YG04lyUGFf2bCB3IboTeGIsY3jF/6REKZyVyiqGwalZ94UIkARX
         0ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384885; x=1774989685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh2npv0O/elfFN32ItPoLhgPFIFAS6miRnp44yqFPqQ=;
        b=IFu7n1ZD705U9S71NxSbS0e+OqoxgyLr3P8VKvBwJlhm0B7HZvyF4lK126c++eegyF
         lANe+An1BQic1K4GaH0+h+EUP/EBcnmgY5I4p54h6knouZk+QEQuTX7idvOYGsgGpVuj
         yea+Afk1obePsw10ArUZIOi2pRnY4ruwOK8vMyPCMzI3ymZZbjxHzoqWJVHKLAo4sK9R
         nYtTvETtrBofrw/Z9/dL2qTkpjsuQR7zQIslBlmd9VaUpqsdAhioYBTfo4O8VxXc0w6B
         H/kXSMWjfIHLhC/BMw/0BFTo/hsu8U+zz2G021cS+depk08BkTQEsI7gBP3Rq9pN7E0U
         WuJg==
X-Forwarded-Encrypted: i=1; AJvYcCUb/+bHED0afrZv/sBmqaHy7R2q9fxVCPtZiO4CS9OVHM5goNuJag2fAyyOv5DwTfTc19Km2c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9h+XPK1DhMeyvpsoqG/Mq4VV1kQrfIXGC9vHG2TGH/OirK9on
	mB3cnbmNafFhVtiVG6lLWMsGMh2Oxm0qzDcfjVxr3odPfnafQUAmWB77tRZ7/wYRst3Wuw==
X-Gm-Gg: ATEYQzzXfucsohVLGirYevosGfSOf9cI5fAp9qraHJaxha2TMKDu33HL1BbpcRJBkqa
	jD3WSGfv+xxqWKFa5Oy/DHc1ie51MWPfLP2oJlZAXYy4caMNkY6r9WN05cycGyDTXCbTbOXp55v
	Dm4UpkT7aGVUaDDu+NATRQ4vqKqxCh3APDtDMiSEUGomIiBzbUe940MO4gzL1QZGD0Rr/wXStpO
	u5+yvc+ziXPzOXMozD6c9Y+E9LjOA8GtQ3o53xUeMSFvqUbX4BPl4or+5UbmPrus89zjjT2NlYj
	+hWBfuI1nk3vlRdCk7H3qEVknX7m+F/fexzb34spVeLUVJocMO5BGXoZ7qXyaUsxBpLCIzdAs3Y
	LHn8C7CuenfWpTA8CWb+BpJ8S6e2Gp1IPj0oWawZY6ASHeMB8Nmp6usuNbHBP4b8yNSDnhalY3v
	ZGq1DwCnDqvWUb1LkrSx7G
X-Received: by 2002:a05:600c:64c6:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-487160a681bmr14938245e9.33.1774384884561;
        Tue, 24 Mar 2026 13:41:24 -0700 (PDT)
Received: from azaki-desk1.. ([41.234.201.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716658352sm3686825e9.13.2026.03.24.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:41:23 -0700 (PDT)
From: Ahmed Zaki <anzaki@gmail.com>
To: netfilter-devel@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	pablo@netfilter.org,
	fw@strlen.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next v2 0/2] Update (DSA) netdev stats with offloaded flows
Date: Tue, 24 Mar 2026 14:40:14 -0600
Message-ID: <20260324204016.2089193-1-anzaki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices (notably DSA) delegate the nft flowtable HW offloaded flows
to a parent drivers. The delegating drivers cannot collect or report
the offloaded flows stats since they have no access to the underlying
hardware. This breaks SNMP-based network monitoring systems that rely on
netdev stats to report the network traffic.

Fix by moving the offloaded flow stat reporting to the nft flowtable
subsystem. The first patch adds a new stats field "fstats" to net_device
that is allocated and updated by the nft subsystem only if the new
flag "flow_offload_via_parent" is set by the driver. It also report these
stats back to the user in dev_get_stats().

Patch 2 sets the new flag "flow_offload_via_parent" for the DSA driver.
---
v2: - added the new "net_device->fstats" field since the existing
      tstats cannot be used since it would double-count on devices that
      already use tstats for hardware MIBs (P1).
    - fixed the outdev ifindex logic based. See new func
      "flow_offload_egress_ifidx()" in P1.

Ahmed Zaki (2):
  netfilter: flowtable: update netdev stats with HW_OFFLOAD flows
  net: dsa: update net_device stats with HW offloaded flows stats

 include/linux/netdevice.h             | 45 ++++++++++++
 net/core/dev.c                        |  8 +++
 net/dsa/user.c                        |  1 +
 net/netfilter/nf_flow_table_offload.c | 98 +++++++++++++++++++++++++--
 4 files changed, 146 insertions(+), 6 deletions(-)

-- 
2.43.0

