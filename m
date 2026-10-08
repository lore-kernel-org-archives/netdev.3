Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE5438034
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465537; cv=none; b=uRYdhFaCTRSeeUOvqpEg6SZrNySoOky8m87FNDBhoUf8gz9a0eGtDWoPyXG4OIU265jBwXZmnFmEMQzoWm0v3941Iqfp+Ish7yD/wsx5E8KY3k2l10bbtm6mpYiCAqwcCbsMyk46PSWZdDAfED/c7r481Mdm+pInN95IVINy8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465537; c=relaxed/simple;
	bh=LnSzBzXooCsCe5WXqqTunrRYQ3XjE1Rh+jAjJ8DETtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk9KhvNF3rKQZSRojfhsnB2gjslx3w6Yb9wo4frHV2UiJq01AXZuvceZ5iA/JKi23KJvPXwB1BdRkuT4YbX/QlQ9olkUQ8CBFD90IhCAUm6NuyMlCx39rkKIXERjIZZn4CXYN0w69OqgJdly1Xr1dCwi2nDzB8tsc3HV8XrIQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M83yVHtM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgaRPHX5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M83yVHtM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgaRPHX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791465534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
	b=M83yVHtMEqaKdUzoxths18B/mh/FuUErN2dwCr773WGukUS1YD+omCmLhPLj7l45W7GH98
	4DZ2/10rBRLGh5hN7N8a5LNmqECnP/rxGuO2maxPG1oRB9+eoIngOagGM14Ut7clw5h/dv
	WKra23DR0e1XSOEwThr6EOmOVtdjc34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-UkVdhcE_NKWfrmJqIhQ4Rg-1; Thu, 8 Oct 2026 13:18:53 +0000
X-MC-Unique: UkVdhcE_NKWfrmJqIhQ4Rg-1
X-Mimecast-MFC-AGG-ID: UkVdhcE_NKWfrmJqIhQ4Rg_1791465532
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso24317495e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791465532; x=1792070332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
        b=PgaRPHX5bXL63Ye02IMHQaAR4LVolwthW8YzfQvLkg6lwvo5H2tIMUCgiOem1jedOF
         ommxvvofYjHWpgXlnNyEF/oj68TIqO4l3e4OX3f4lszDsRspAJ7uXG84CjpoLAjaEMbZ
         kgfLmRyyyDb3rdtXS0ccN134BYwzwBI0kqyBRgwwNqj1w6V77l6VA1zx0dHGdYRUeQvt
         H3ver9oh7i+7gOM9izZjbbPJvBW++9uV/OGGNDzBwNyLZjVzRFC3zQYwEW/VntZnnaki
         5Psqp8WuaZxKXT9Xo3CXTwlebUzxdqWtWAqcMNTThbdOQ7mZmU/Kqzh0Bs3lWAE+/Pzd
         tN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465532; x=1792070332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
        b=DmPQ2nPJa4kn+6/nE/xen8dSzFszio/Na/pWZH0uv5AdSYd+AadlDr9rDXWvbzvMW4
         o7RbVbFASQXErPuyOqYa++aBa8q/07XFr0ruF+7mzEb6fDlIxFtI0Lqao4MkRdNsraeB
         ktHw9d+i5gv5raU6DiNvQvgnULTDX/ffo+OeF42RzgsB8F1PcffhXKRcGBhv+4vXGXzV
         ssQ9ZH1lhvvSZXeJGgc5I2AwqeGyj1hDRP9asUqBYfUbnpLx/3yjhXS1ZS3wWB1wOeOF
         15VS86/YlTFqAcvVe8f/gvi6nUtmvVZRjUK9W53pd8NmntJk/mAqbxbG7wHAFvPilWX3
         smTw==
X-Gm-Message-State: AFuF++lFcljfpdRVOTd2nrYdWecYToo22BzG7YCQM7Ukar962Uzc76ez
	BlzbD2N3Njjxgq4HwcpwwT5gsjnV2DmTTrvDmrLzVOJh8nASVHJ1QoIQ8ClWWPGW5qqF38Sf22G
	0TQ31aFcpTD2dDr4+hPXRjm1lYOzuETi0qqiBPRO0laUvRjMGe61yg93c+aPV6MiBx2wB
X-Gm-Gg: AYBFou1UGGCfmRoEl7vv2f899VW502OC8imIftrJ3tPqweycNG3bLAUd9DKQdOkxJk2
	zQsQXXZldpyI/BKAeLaCRf/2FQ81SQHDGCpfqUADqIIsn27zZJ0I+jU0JJa9TasIcfMB1PkfbCA
	RVfuf13BVwAhkVa9DRC+eK1BIsxMaN3U6UFsOINohGAYUDKGMVnqoFLVYMqE1YvihYTpHQxBVtg
	xj2ySGOrsOSAuH7O53Z/J2V/zTS54BcSTvosZrwlbcY4jSDIMZwOEcS4xNipugGilI4cHQMovyy
	RhZ3ee5NMG1SnLLHut1VdF/Spf+aArfafLZqrkqSjIxNncKOA8H8th5dcmcVWnG8is1zGIHRKmE
	0+ngzi+Ui22excWCDu13XyVTl51t4UMGr
X-Received: by 2002:a05:600c:6099:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4a18043be70mr99628725e9.14.1791465532216;
        Thu, 08 Oct 2026 06:18:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6099:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4a18043be70mr99628345e9.14.1791465531873;
        Thu, 08 Oct 2026 06:18:51 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843e3356sm62947465e9.14.2026.10.08.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:18:51 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v5 0/2] i40e: add runtime-tunable ATR sample rate
Date: Thu,  8 Oct 2026 16:18:22 +0300
Message-ID: <20261008131824.248508-1-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

This series makes the Flow Director ATR sample rate configurable at
runtime through a devlink parameter.

On systems with many queues and high-rate TCP workloads, the fixed
default sampling interval can cause frequent Flow Director
reprogramming and TCP packet reordering. The optimal interval depends
on the workload and system configuration.

Patch 1 moves atr_sample_rate from per-ring to PF level, since it is
a global policy. It also triggers a PF reset when re-enabling ATR via
ethtool private flags so that fd_ena is reprogrammed in the TX queue
HW context.

Patch 2 exposes atr_sample_rate as a devlink runtime parameter so
administrators can tune it without rebuilding the driver.

Testing with iperf3 -t 60 showed ~7k TCP reordering events at the
default sample rate (20). Setting atr_sample_rate to 10000 reduced
reordering to ~769 (~90% reduction).

Changes since v4:
- Folded the PF reset patch into patch 1 for bisect cleanliness
  (was patch 3/3 in v4)
- Skip PF reset when FD_SB (ntuple) already holds fd_ena high,
  avoiding unnecessary traffic disruption
- Fix LLDP EEXIST path to not drop unrelated reset requests
  (reset_needed &= ~REBUILD_FLAG instead of = 0)
- Flush existing ATR entries when setting atr_sample_rate to 0 via
  devlink, so stale filters do not persist on devices without HW
  ATR eviction
- Documentation: clarify that the sampling interval is per Tx queue
  and counts TCP packets only; fix formatting

Mohammad Heib (2):
  i40e: move ATR sample rate from ring to PF level
  i40e: add devlink parameter for Flow Director ATR sample rate

 Documentation/networking/devlink/i40e.rst     | 21 +++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 46 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 12 ++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +-
 7 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.56.0

