Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DD3CB91E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442480; cv=none; b=OJbPXQvAEgXKXBuauS+RpPnXjPRi29mu6FAedFuOcMBtgxZHh+pXLz4FKqQTwGS16sEKegQ2QIgVfxj3f0wyKCD93UVRjFoMhwOP4sdTcikyi7hLjnn59MOOLwn9NlJWRxnhxFznGI9FDfFAkr+fY6vHrpDAaExl5GScBj2dswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442480; c=relaxed/simple;
	bh=pqMCEK88vcgVmkFo1r9Mb2cL2aOFQp+yO4EJ1G40IU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjgnCtqwv1VLWcTRN1USO9zdwtA6TZcE0nI8S6NDyNAASa3CBixVBp+dz6Q62gbE7wwSm9ZTVTHC1epsxYo8sRmrJU9yzfKRVbrCnusP5ZrC7TegLKBU83zXNWw8bUce2aJ3cPJjueESOOhkvp5d8jKFFNN0MRZdktCv5CqPEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQZJYvaJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQZJYvaJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8917c712f32so1042120b3a.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791442479; x=1792047279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
        b=AQZJYvaJH3RQtiWwJ4RM37bovwi9Yvai2PyDoiONZr8qRnwltaUJ1UyetLfFyvmkHp
         3C/sfPq/cmexjkNXQQg/h651JdMQDUjUmhybKm7ywAnfLdpIVFJsmD7wz6vqdcQnEduw
         e/3Z34f+GenmwfBnfOFhXLBrKGV+mGk2au37gAYd3omyeNSGE9nvvF2Ao81WLWe90NJk
         BUiUfWmNOTuYzmxD3FgBAyfQNZWhZYnsaxHvEssB4QU0XsaMRc1PrHCi5Df0HnX86GIA
         A0aWa3FjpgfdsGHvZTgHefXjhZ+ymLMdYet4kmddQEetLCH2Bri1YNptfMBRSa5fkgVm
         I/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442479; x=1792047279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
        b=Lz45/iaae+i+jCn7AFSTjnNnPw/IFv5WzysyocagzpFr/Y2FpS1MFaYes7Rv0K+ai7
         QfHCT6TEaafxP0JZhv/+IVNQaRwtT7PPe4HcUrJr7qhaEOhHIKC/QrI4gDE47Mm8XK43
         ZtqjGvlTq/LBfjZmlCB8xfBoN3p0VPdMzAS195ejlEOriZUQPg4z4J5W1bDLHTwJlp0I
         QlxDASzmQMTP6s6t/Q/NZF0l5Hmw9spvVnM5A0s8Uc9htpW+j4lZtq1P6m9kP0cg2A4D
         IFcBkjWsfRhi4CTLBWWAtWNr3CgpOpWEMWoIfAUXgpDx3/BlyU8JVEYEWjOQIS2JA/hu
         pB/Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/CNURUn8QG3vQ+haH8TG0qb4/re5xmSv1ossWlDWQcaZxJQz4ctkcilLogYYahCP4CggxAIM=@vger.kernel.org
X-Gm-Message-State: AFuF++nT9HqbdNkYUBPcv8DcBx6pbH2wa+MCamlqjNWGTUPRzy4iIHLT
	oheJR64ZI19cQrpHmi88y3W+QHTh7Ug25by2vVPCsWBqULj1kehvzpB2
X-Gm-Gg: AYBFou0Lwuqjsw/uepzslbkPJFO/HO/Wx56t0y2K+tKfyaZt3E5qBzrUMwR/8V+nTrZ
	2wiCcp4UpleXtu9nqA4hysUDIQAZgOH2LjaNFui/YxXGZD3vuJW17fHXL+Kl9xyVACZXe84zlz+
	r4AfWtTLX4Ni1jh6h7yrHZ0rdj5/ItQLZ17xuWWZpDRqJuWUHm5Kh2BsXc3GSD3pWf2z2o3pdmK
	sDLAMmKwRbHvogA4cPDvFux4c71j7OlKRm/QCH6PmT4JCHc6cTpq9zscrYULqySWskca0uc61T7
	KY4cwqKlAoB6cbeOK1AABuiJtIrSG0OXDIxNns41LdJyXFVhHbmLALbZh/nrHnjI3YyvmKnmzV1
	DbroneRUcFFyB2wDymZiPuUwEho8GF0Z1I1iP31ICoe2uuVCp01TpcP6pTdFZDWDDvCeH/doPjJ
	cC6mxfP90yukkyf+Z/C40DqGJsxh6WtLnvqsAfrtMr9gALUxbZtp30U8BvpIgDI3jorKnn3w+V+
	d9UR8eAT8L/LsMfqBWgWXHay+JhQoRYhl/N89cQlvG//luEKPo52mqel/VPgO2I1zJJ/0Fi7Og7
	Kek=
X-Received: by 2002:a05:6a00:1da7:b0:88d:4241:9fa0 with SMTP id d2e1a72fcca58-891b54c6216mr3889423b3a.32.1791442478885;
        Wed, 07 Oct 2026 23:54:38 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bac8e8f3sm1176182b3a.15.2026.10.07.23.54.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 23:54:38 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Thu,  8 Oct 2026 14:54:26 +0800
Message-ID: <20261008065426.86267-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
References: <20261007055741.30629-1-luckilystar08@gmail.com> <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/7/2026 10:07 AM, Tantilov, Emil S wrote:
> I did a rough draft, keeping your logic and I think we
> should be able to avoid the new flags by introducing a global variable
> adapter->vc_xn_timeout_ms and set it based on the flow we're in

Thanks, that works well. v3 is ready along those lines: no new flags,
adapter->vc_xn_timeout_ms set to the default at probe and to 500 ms in
idpf_shutdown() right before IDPF_REMOVE_IN_PROG, and idpf_send_mb_msg()
caps each transaction with it and sets it to 0 after the first
shortened transaction times out, so the rest fail at once.

Backported to our 6.17 kernel (two arm64 servers, two PFs each, IOMMU
translating): no faults in 30 warm reboots. The slowest teardown
message is still DEALLOC_VECTORS at ~300 ms, sent after DESTROY_VPORT;
the queue-related ones took at most 158 ms. With the driver made to
skip sending the teardown messages, the first one timed out at ~500 ms,
the rest failed immediately, and every reboot faulted again.

Before I post it, two things it exposes that I would like your view on:

1. Setting IDPF_REMOVE_IN_PROG on shutdown also moves
   libie_ctlq_xn_shutdown() after idpf_ptp_release() and
   idpf_deinit_task(), as on remove. mbx_task keeps running in that
   window, so an async PTP Tx timestamp reply can reach
   idpf_ptp_get_tx_tstamp_async_handler() after
   idpf_ptp_release_vport_tstamp() has freed tx_tstamp_caps. Remove has
   the same window today; shutdown would now have it too. An unmatched
   VIRTCHNL2_OP_EVENT (link change) has a similar window against the
   vport being freed, which exists on shutdown already.

   One way to close it without new flags: once IDPF_REMOVE_IN_PROG is
   set, cancel_delayed_work_sync() and requeue mbx_task, and have the
   PTP callback and idpf_recv_event_msg() return early when the bit is
   set; matched replies are still consumed, so the teardown is not
   affected. I can send that as a prerequisite patch, but I cannot
   exercise the PTP part here (PTP init returns -EOPNOTSUPP on our
   parts). Would you prefer that, or to handle it separately?

2. A transaction that is already waiting when shutdown starts keeps its
   own timeout. For example a GET_STATS from stats_task, which is only
   cancelled in idpf_deinit_task(), can still hold shutdown for up to
   60 s with a dead control plane, where the early xn shutdown used to
   wake it. Fixing that would need a way in libie to expire waiting
   transactions, so I would note it in the commit message rather than
   claim a hard bound. Does that sound right?

Thanks,
Tian Xun
