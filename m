Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E747ACC5
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022194; cv=none; b=lU2lq1Ogq+szx/F5blptK+ZD2m10u1f+hAoehOxy8+PSHfo5+aKK18jeLHQv/wnrvNE648CVh4ugL+zd4nk3MGR06ypqwzv6J2OgZFxOYQMmgKa+ZoZEgEqmp5hR1RzoTD2UFkHRHyZNcePryfZIG2o6rihV/hB6MfXZqfT4KGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022194; c=relaxed/simple;
	bh=nLu9+jS/Cn6oFT3DAy2pgKLYerUk78AHPFMk+9gkrY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2HqA0GZbcPgN1GQOYUR8MloJSswPKKCUuo+q9Qfpj0skB8CzCnrtLEbjwmR68Y4qr5NT0NUNPOaJIiseXb6pugFREHkXYWIhLo91yHGzj3QBlXQ90mSH4af4rh4kVE9NO7fQ1TZrD03udzreJvhKxjXW7qEsSiZbAtOIRlUKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=bJCCdWS3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="bJCCdWS3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e5e801487so712484566b.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792022191; x=1792626991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujWOXhajkBZtlCmsZmCoVumMM+X/QUn/djLaiVsONPE=;
        b=bJCCdWS3SAPVptxJycLn5yScFOncCfpXu+inchndA6M1vZCtSnwKPoxvEnuEhrLLHr
         F86HqEXS5wP1bKUC+C+MffUT9VA7+fLrXZDZibZz5Tf61HlVHt1Jh10Mx8WjykwBvVHx
         PWXTNj4DHwTNfgz+9nx+32yGY4Q/BCQGmsC4zK0EWkIocoTkU+QppCGu41JHJqoEKDFo
         ctpDdkJ8TO0L22nPejk4mF94+ND9ukR8xzhM9Qt6FTYQ2A+oNHIWmhwOUYx956uW3oS5
         wmLPx36n6syhNVOIFA+khBnb0lRUS9tKMbfr9/33VgB4P8oopaeBmMyrSaNE6iMN1r/a
         /FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792022191; x=1792626991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujWOXhajkBZtlCmsZmCoVumMM+X/QUn/djLaiVsONPE=;
        b=pxtomSsE3Xr963Hh8MVPYtH0IBzzVxwXTiQMAWf3zkSGx0G3gnZoGo+yR5Od/64tLu
         G2t1NWu1t//XHg4MStL/xezKHj+SyboqDWFQGkD2FQ938/Ozxcm8dVNE7dWBE+QIih6M
         fjEVvtB+Y4P6tmRPvq0SQKiCKbSyJ2b/jc87bF0r5zJiw4sjSSgHNPlFXsTB7Yx14GAs
         DIJ0yn8idPxOlkBM/qsXcBSKrTAu/URflV8I5Knn9bbfowP4YVXxMY7+hnPrfbH3mEV/
         vcF4x4lAr8fgYfLyxkch15JsLFEnfiCVh1vxsOFaUvjUFF7z0B/NsCEiB+Ywuh6CsMsC
         ClsA==
X-Forwarded-Encrypted: i=1; AKwUvBxX+80HJI2+wkCZnLC6VPZFHCxzUrghGtGhIqm5UI00RpUYqG5aT9bZOKGInInfXRimWHwt1XQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkNpoXLjBOgtFNIPW5JosqaHA5+IsfiPKiAl+NXIKfFCutJ9HF
	NPxXfVTL09IyGJR3v+NL3G1fFfd22jeThYglqNpBC8ZcWfb8BmjsJtzN6ICzh/tGjA==
X-Gm-Gg: AYBFou3AUl+liYUyi6yPLiNA+EsW+noRU/d8udHXqD+lE+NqhdVql719RJQ+xrdZGVH
	9Sciez62G+wLBlfXatH+roCmSofFwkNjAHo444BsUmWLyhssSRCTf/sww1bLmyjmJm1JrWoYKRQ
	TSTqveUIaODgNIFxiHlPYjjb2cupOi4tUk7QOovSEHpMLVjokSNiz12Me4cW5XhL1h2vJpqF0w4
	RACxr4fc4X25d+c45g66yLHW5GXtn8xOXxbBS1ayxJenUmGxA/I6van9offdHeElOJw3MroPmwe
	qPXvb//xGgOnXSPe//p0GLN02VA9wY6ctyuiqkaAyF5tj4s5is86aFbZABoV/VdIMd6v4ujnLcG
	fulNsCjpKSSIcFwUeLpQL5zlQJVtLTFjtY9HO6ETFLeX6ZwenBTf2q6bjakE249kzl0PHZjMsLW
	D60o19vf/6IG+BTtjjZldSlTGGwx08POUypjCkkxG4SfO1VqnIR8AY44S37Wn94xZNls4nTxHEN
	+9E7EAexqoZVHJCFCwj5A2Vla16iKmQCS7rckC1W3HppbvBEBqweneD+IegkYY7vzw36vlWdmu9
	sDTx1aS839w4rdTTJ3XRxwUGBbuHp79KB6TeUx2S47HESa+bzDV+4DbSyyGzhp5D6zaoRerAIZ1
	pudVBD54ZKMvpZdV9ykxpX8jpb4mrPhzKyVQFsh/Cpp+gLFZb9QrumCmw6goqdzIq7iz9+uvoGP
	37prw9ILLq5pJmYvKvO9DvxpY=
X-Received: by 2002:a17:907:3d52:b0:c26:1648:a076 with SMTP id a640c23a62f3a-c31aa0e93bdmr1626520966b.49.1792022191008;
        Wed, 14 Oct 2026 16:56:31 -0700 (PDT)
Received: from Desktop (p54affd5a.dip0.t-ipconnect.de. [84.175.253.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3edab12007sm46101666b.82.2026.10.14.16.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:56:30 -0700 (PDT)
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
	idosch@nvidia.com,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v7 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Thu, 15 Oct 2026 01:56:25 +0200
Message-ID: <20261014235628.197976-1-julius@bairaktaris.de>
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
Wi-Fi station roaming between access points.

Patch 1 makes the gc tear such a flow down, using the bridge fdb lookup
from Pablo's patch. Patch 2 adds selftest cases.

Tested on nf-next a5e7d8e446af in an x86 guest: nft_flowtable.sh passes,
including all seven roaming cases, and ftrace shows no
flow_offload_teardown during 10 s of steady traffic in any of them.
flow_offload grows by 16 bytes (296 to 312 on x86_64).

Changes in v7:
- look up the fdb entry through a bridge hook instead of walking the
  forward path again (from Pablo's patch)
- save the vid of the fdb lookup; the encap stack does not have it for
  untagged ports of a vlan_filtering bridge
- build br_nf_utils.o only with CONFIG_NF_FLOW_TABLE
- selftest: vlan_filtering case

v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (2):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

 include/linux/netfilter.h                     |   8 +
 include/net/netfilter/nf_flow_table.h         |   4 +
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_nf_utils.c                      |  40 ++++
 net/bridge/br_private.h                       |  13 ++
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  27 +++
 net/netfilter/nf_flow_table_path.c            |   9 +
 .../selftests/net/netfilter/nft_flowtable.sh  | 204 ++++++++++++++++++
 10 files changed, 312 insertions(+)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
-- 
2.53.0

