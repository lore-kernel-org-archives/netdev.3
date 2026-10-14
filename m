Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34E4E01F0
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984630; cv=none; b=CCQZSXlXqgqMTHmwyS2D29FkPWjLjnDf9LSevnPPsxn2kzAYzunzY7nRWTyrEVcg/8+hNe8oLdkFQBCCgp6WBjtL98C9DODJeZysT89NwdRK3heW3y4ee5dp+nSbIUoEw90UPOuVFUbZ8DOtHGcgavhB7Ox6eNXQ4KSxu0kYVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984630; c=relaxed/simple;
	bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPWjaFRtpByRB4jUMzvRsh3RGfcS39AG6nB/wK7q1KIB/1ObFfm/Yq0KuypKPdXJlqTQoOOrdlmWEp6SLRbTzfPqLZiSSzkxxRmtkew0SdgqPcH9LrU6MNin8TFpKCPR6Apac7iOl/+MXAc2e0cbre1pFFZp9Zrc7Q2+729NdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWezEQf8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWezEQf8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so274245a91.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984613; x=1792589413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
        b=TWezEQf8ioUpGBMEI4SbG5FRuB5LUAcINUSjcRbQkjT/P7YXevwR3RIN+tS3T4IwSS
         RCLtrWo7HUSGrBk06n1OFhecgQDMXbDWhX7hlMIwPeF96B7Ca7MlCvFo5sbCtVGHDTsm
         a8Gaj3FMj/UPXLwfdhifUF9ajr4gTxqgtVByYArI324Vt1/dWtn9siHT1h1FQTfOKTEy
         tV245U52/MOyqpeSkq9WP/FVPDHLIPacen6A1CQuxxwCjJ89E16s3N01qgxxgWhoFBfk
         RNnLMiyauSLTDqb4QzgJ7tK36biLyt4Mz7fxBWriyl9p21y/HF3vFEf2BhGM6Kzv/lvi
         Z1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984613; x=1792589413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
        b=lkMpKZhssPVHY4bvj6Ord3PFJ7ZFOnKez48oZfZmjZt9u37GM1IWeM/uwlPgvjBCSx
         z4me0ZPFtbO0MuRLDMcCLBbKu5cSNC6ZCxW+G6+uGqQK7LVDASsPDz2QpSWkDFcDtc+n
         KnK6YeAZtaC4AsScy/KKAAnURvEm/ejXVVAmyp6tVzYT6Csgh/IEzUyKf/ri5+dIKoJT
         iLcjQshCPnw7oAPjq+vGOXbK8SQW0CRRc1LsMln+uRjFyia72+zxALmJBe93uJNnhhIT
         bWiU2iSBe03QBdL6fViPF6rXa3DqiTPXUgZ8SwpefbVN/HzJQ7iAyDxMuENLGmsozs0x
         L4OA==
X-Forwarded-Encrypted: i=1; AKwUvByj3I2DP0WO9Gf8bpKjuYgt4fyVKfRyNY7PtgmZ+i8BE268ZKRYKT47wneqWW/2cXJ1PgD/VoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhmZTAx+x+ex1CVW95De1oKUmDi9DA+qtq1KYlU9UM3R5j6/Rg
	UIehqiv+xGuLFoRxt7UMlac3/W9CxvM3XAcb5bGKOsBHWAk6/q8HMvmNVf4VSilPgfE=
X-Gm-Gg: AYBFou08UKLjpFQ0AJEM7vdrp8DPexkaxFkGjuLaYzeIgxzCEgsf6IKZmS1Ozw8yn1R
	VRot3EvKjSLlWSuLIKskw/lmmjceYUDVwJ9B4Sv/1iJ60sUe4ta3NjEq4e7/u2huFHzRNrSHlLQ
	3MQt0CQMoyJjx09nIu/RyX3qYl76Y14V7T5gWi+cx7fiDlfJP7rVz/iYQGoZdbNMf9bEiyZadGs
	rvNIhm2u+S8bvit7QkecDs5E+UoHsjdJtdOW0NsOeDiH7kj605ODgzTDsZUKY3A3/Qy5ZQkvslN
	mcnQihFlfCeNuFyRDgfcqTRN9205RfoDW+rm+fY/sJqnqApSkNZH6SSszhvtqS1JWQnByYSqmRB
	+V2sZ7sktM54R9vZKkicZY7JHm+NNEbQqq59TX6LFN/NxuABqUMxHJ+Xn1+CIi8e9It0CPUQQdD
	1wNHtfiHhYiai3fhqYK6graS0QIIghAw+4UptE/q3Qtdaa3syZn27RySeYkdAiJA3OGxertr1jU
	yerVK1TYSEBCCQqKHpLNlLB6FWHWnxM9bS/U2QnKz8dS+m+zbXp73AVLQhx
X-Received: by 2002:a17:90b:1d4f:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3ab3a91173cmr13060295a91.18.1791984613094;
        Wed, 14 Oct 2026 06:30:13 -0700 (PDT)
Received: from C9P9279WY4 (206.135.124.34.bc.googleusercontent.com. [34.124.135.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f202aeesm4800199a91.5.2026.10.14.06.30.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 06:30:11 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: sashiko-reviews@lists.linux.dev,
	netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	milena.olech@intel.com,
	joshua.a.hay@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Wed, 14 Oct 2026 21:30:02 +0800
Message-ID: <20261014133002.99917-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <sashiko-outbox-171247@kernel.org>
References: <20261013121224.84482-1-luckilystar08@gmail.com> <20261013121224.84482-4-luckilystar08@gmail.com> <sashiko-outbox-171247@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 12:13 UTC, sashiko-bot@kernel.org wrote:
> - [High] idpf: NULL pointer dereference in idpf_tx_start during shutdown

This path is not changed by the patch. idpf_vport_dealloc() skips
idpf_vport_stop() and idpf_decfg_netdev() while IDPF_HR_RESET_IN_PROG is
set with or without it, and idpf_shutdown() has lacked the stale netdev
cleanup that idpf_remove() does since 4c9106f4906a. It is a separate
issue; I can look at it in a follow-up.

> - [High] idpf: SW marker consumption race causes cascading timeouts

The set-then-wait order per Tx queue is the same as in the current
code. With the default split queue model each Tx queue has its own
completion queue (IDPF_DFLT_SPLITQ_TXQ_PER_GROUP is 1), so markers are
not shared. Where they are, this patch limits the effect on shutdown to
one 500 ms wait per queue set. Setting SW_MARKER on all queues before
waiting looks like a reasonable cleanup on its own.

> - [High] idpf: DMA memory corruption on slow CP during shutdown

This is the trade-off discussed on v3 and v4. Without the patch,
shutdown sends none of the teardown messages, so a control plane slower
than 500 ms is no worse off than today, and a responsive one gets the
full teardown. On the tested devices the queue-related messages took at
most 240 ms.

Thanks,
Tian Xun
