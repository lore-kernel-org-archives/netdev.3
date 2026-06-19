Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B43803F9
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868742; cv=none; b=q4ywRYg7YIBZxOXytFrj+RVe9F4uApmmI9TK523Y6bisotqy4jpOZTrsp1anSVJan6aNSHGrUtgr5elWjAPDrrzbVnFq6Ok+M0F9g4IoBYMbBu30xMMfDFHDk9xkVH9G7mBZSkVgziVIkOwENZhcsXHsLr+IKubMhCOhuTu9NOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868742; c=relaxed/simple;
	bh=mR4XpEUGTf23eGYFRjCiLftiZYcV1WpK12hSNElmqvY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a12oq47Yhkyk9xX2Sj0CMS/wI6A4qTRmXhSmxHOn56Vf2oIgpfqBOcinYGJDKP6YKzlHKEqk0v4B03WSyYiMrK3rzBSqOJDWVUlvLKf19adbmaiyrsC9h23ayeFnZ9nZOdbESb7slFVKremy7mAb9gIUF4ERlng28d8FqUPHQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3oY4MlS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3oY4MlS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84540eb70b2so1086786b3a.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781868738; x=1782473538; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eKU8Y+9ab+6WdV4zAwXb4M8XYYzRqZEFKbE8cIdvB3I=;
        b=M3oY4MlS4caWFTlnc+d0TXoZNkAXaTapvJKfhCbrcxRHZBCIJYQJdSFza0sAARTwjy
         U2z3bmHIUHhHIQMINlHPiaFCPcC+uPZ48D09Ze8fYIQp7nm5PTNRY6bweozBAdJ3pehP
         sNb8ZjDEXdKYN9bCg3kwEyDzv6Q+fL60t+FhiwqG0qPZ++qpmZkyD1B2iZ+MDSYeOmYu
         GePCCBPqO2eriFmt2xhsnuEDBSxk1eanPqflK47tw9/NPLaQH8oiSwIfovKp9k58xWu7
         QMeLUWhIP89fnPidT213w9CM+K1xPyd1/zxmeQI8+GEJfk+TSxV01CG/nioJFHY8l20n
         +4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781868738; x=1782473538;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKU8Y+9ab+6WdV4zAwXb4M8XYYzRqZEFKbE8cIdvB3I=;
        b=KU3MYrEwCs8AcGRETRWnQP/ux2V1AA4WPZQSA+9Zvf+hAwKIBW0KjpCjJmvmyIe/yN
         3U/MQm9KpG3uFn5og3My1i8yuB73sU3KbgE/fYps1ih/IoVWFQNWcz3f0Rb69xCqhcEM
         7bs0zzZ/uQTZCSXg6ynQ/7iGLbwEZPVZU6x15mh6rloX/g2pYjmIAiHubIwi7D8gBamC
         /aO1Su/WJFwc4S1Y73kMVUN6aZ8f0mjcyzqiIZpCP3ky5xFzhBPVmxKviP+qdS6z96OM
         F5YKD7IGulrfk5ESiaD8ZSp/zmrPUMfaV5MiJ1UrgtlaH86rFoP4kPSTFEjgHQ2xNA7K
         oXtg==
X-Gm-Message-State: AOJu0YzgkUmUQW9ypKdaSs34SJ/HHyDNl3S/Pc4vN4Sk4Iqd934vInjv
	eNN47tyZTu4mtofzKWgesUOxo/qVrl5yqEiZRbEDgK1AZCUWqZm1tRLr
X-Gm-Gg: AfdE7cmZ2sOt3o/9wdrHuIjxiRRVJ4vCzoKEAO5f6/BpO1vrw0AVpAu7UmTMRe6SDUF
	r4aeRru/9fceWJaLin6r+q2I528nH04TkvJ+BHy0AYsm07MtyunXtfemryjKmtmZE6gX6TMCDFF
	wL2avWDRiD/omdMDoo8pM+2E9tIgzF5qG1NIjhO1tOfsi4QkO+jN0WZNa8F4MPZYmrtpTz3cg7D
	dfBKdZNc94hqpZ9nHXnGcO7ShWlDpJZ3dbxWL8nhDXEWujToEbSsWXbq2LPJc2v0/ID/Y4stlxD
	yVFDTyWGFrH50jkAtPYOwIFZrQrs2zJ7hsJbw2ZqPvRBHuRbaJ5oDxpp/nAo3XGxpc3THhXZx95
	mKp1k0P9+fudCJYwvvLMv1jtJsSxdP+FNX/NGupaybYcoMA3Ww5Mbz9k2mKIILcykrjyihQL7Si
	qdbU8Ye5+WNR8=
X-Received: by 2002:a05:6a00:2441:b0:842:4b88:20ee with SMTP id d2e1a72fcca58-845508d5d6dmr3512365b3a.44.1781868738292;
        Fri, 19 Jun 2026 04:32:18 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455364cbbasm2257160b3a.1.2026.06.19.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:32:17 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
X-Google-Original-From: Wayen Yan <wayen.yan@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: airoha_eth: PPE flow entries and EGRESS TRTCM shaping
Date: Fri, 19 Jun 2026 19:32:16 +0800
Message-ID: <178186873627.2394198.12931653355991624267@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Lorenzo,

While reviewing the airoha HTB offload code and your recent fix series,
I noticed that EGRESS TRTCM rate-limit buckets configured by
airoha_qdma_set_tx_rate_limit() do not appear to be referenced by
either the CPU xmit path or PPE-accelerated flows.

Specifically:

1) CPU xmit path always disables the meter:

   In airoha_dev_xmit(), TXMSG.METER is hardcoded to 0x7f:

     msg1 = FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);

   The register comment notes "0x7f no meters", so even though
   airoha_tc_htb_alloc_leaf_queue() configures TRTCM bucket[channel]
   with the requested rate, CPU-path packets never hit those buckets.

2) PPE flow entries never bind to a TRTCM bucket:

   In airoha_ppe_foe_entry_prepare(), the FOE 'data' field is
   initialized with:

     qdata = FIELD_PREP(AIROHA_FOE_SHAPER_ID, 0x7f);

   And neither CHANNEL[15:11] nor QID[10:8] are ever set — they
   remain zero in all PPE entry creation paths (tc offload,
   HW autolearn, L2 subflow commit). This means PPE-accelerated
   flows bypass TRTCM shaping entirely.

   The only QoS-related bit set is IB2.PSE_QOS for wired LAN ports,
   which is a flag rather than an index.

3) airoha_ppe_foe_flow_stats_update() does read CHANNEL|QID from
   the data field and moves them to ACTDP, but since they were
   never populated, this is effectively a no-op in practice.

I have a few questions:

- Does AIROHA_FOE_SHAPER_ID map to the same QDMA TRTCM meter index
  space used by airoha_qdma_set_tx_rate_limit()? If so, setting
  SHAPER_ID = channel for flows belonging to an HTB class would
  enable per-flow egress shaping via PPE.

- Is the current 0x7f / disabled behavior intentional — i.e., PPE
  flow shaping is simply not yet implemented, or is there a hardware
  constraint I'm missing?

- For the CPU xmit path, is there a reason TXMSG.METER cannot be
  set to the channel derived from skb_get_queue_mapping(), so that
  CPU-path packets also respect the TRTCM rate limits?

Thanks,
Wayen

