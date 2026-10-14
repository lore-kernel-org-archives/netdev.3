Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EA41440F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951321; cv=none; b=ZJNZajSIdS3n0q2p39sqrEHP6EcCg4gp6IvBcOxWDhZLa1HLXthZLlTUF4O7cZifJo0fb4F6QHo1GQ5Lc9nCxiiS4liLes5duJkxAHFv/f0vDdILg5Y55QTn1RcZcF0ka0ITX7O56MuwDefjjDnGfpiR5cCJW+J7MQ4rOQnaJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951321; c=relaxed/simple;
	bh=xYywkRsBSKjw8Axa27YEpGjbg1zDhSx4yyXEIskgcM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpzKXSkuuRjfRBo72na7spZNPgckKeDy206xdlOvSlW/StJCIRa6ZdAcyXYzdTRaZ+IlFKJSmYr1hixXla9iep3uYOUp1zTskA5p9FGjIqjI/OmpmvV6OUhMRSuhZcdPwFw9f1co8Y8fGZWAqol9DdvUaW/VotGYhumLDvgMao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoFq64Yv; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoFq64Yv"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so1521051eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791951319; x=1792556119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VyFJXztVLdc/Rg7vt5oGO3PCAQKi6BcjvQhwTuC+hUc=;
        b=KoFq64YvmdzxHhMl1Q3DX7bzK+wqvOgl474QleMapmgZvviyz9u8jO2bx5huxNH86t
         X4qNP7acdv9ZeiiPH8IUvW5aJ/IJczEe57vwF01j4tzBOYQaounLJAnuEdxjPPfHxqDB
         zK3a0aN5zjySohwsDF+LaNnDXncOm2NsyIJXtfxMLa/PwK70KBaiHvRoogBXgmNpKaUQ
         ew9TRSCk04vRx+edY53Z/PbQO0kteNLPY8SvxM876v3Lcsp3Yi0NCHiNvi2B9FTIl8LF
         tyiGwsFYpFd1/HwBAsKEYjmTo0EC6FKmtmcc60a55f8BOHDbBWfyLQq/kjZOtanxh0pq
         1CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951319; x=1792556119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VyFJXztVLdc/Rg7vt5oGO3PCAQKi6BcjvQhwTuC+hUc=;
        b=x1RG0M1nIeAfJpg/5x8LhpQI/Egx/AQxqkcfjbBngIj9TgQW7EgF0OD8OYaNB8mHGm
         WtWQAjb2WLgFDwl6/zN+R07Zb1YDSni1wphf+RuBsARdh2vB6B6oIakq7t2jCeOwUNWx
         cT01VEfFFdXbSQUQazNxiJiLLi4B3m2Dv2xdPZwWl+w0IlWzMiVEHyM9kTnA+EVtvCPA
         128gYZJFFN1FQleO60dBo2P49Z6wzuLaPYqrxLjTyNa7GaJ4H0GkW53gcW1VWGwsNA+d
         pHBmTblAAFyPea4gISR/t0M0ir2s+Rqwz+E8XjoU0xIQ4QaRUbO7XoBgFcnM5YpqfWDg
         yzeA==
X-Forwarded-Encrypted: i=1; AKwUvBykAmw08c/eQRPiCwJBigwrTsIspzHduPn4/5jLC9V4u9VvxUGFU7aAGJqNMzUHrM2zdONCmTw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOnTW3wy+SXULutQ0gBuRZkHqPuVmiLqex+U/EIVmOiHWkWw5V
	+xUhUCCMmUD9TmQogITDNMMvrR5uSrEV5M/KL7YU9kYvToxz+lYJZBbj
X-Gm-Gg: AYBFou23WeKsg418qTNaesv2LC+HbEguxMyC6MV4+mRoOOxTNBJkE8euQa3LBpV9mU+
	GYtAhMU+OzN0m9HYXRO9ppJQVx5oHmwmX2B7aRtt9tgvkMbecHR0Os+Dfxg4GEGqI+tzSXxiSZh
	8AupUsTzz8NsZ44BlZjk7lJaZwkkDneA7sRFFLkbmpZHpFnORnd7L4JJROAezkgSHKqNHW08pGb
	CF3+1bqGbRCKssRNDZE4ziSh6UQUqvsJe2/PlkC9eabQb/kSgz2/5Iq6jm4U/4Kh6frgGguf8D+
	CxZBK0UBY8tDvVWJa0RQMJvCOvnxTMEoJAYLUdXcrTnWCZ4W1cfXiv471PPLHJB+3wqOMUg5I+n
	H/T0z2GCBXtxj+bihRVRqtjjXv8PLd4IySODJm5vo10KNSPSXGsUBYxNNLEcbwMO5DygCvlepB4
	mUEdDLcDWrJvAtFKW5TVghlSjX3P/mtlyCEaozR539lODYp9hfBhULIZ1jdRDQDbgtc4x5+kTLX
	yk1El+tMd4Xqp8lOrAwb0oyuhXfBIN+DlzMMMA=
X-Received: by 2002:a05:7300:e9c5:10b0:359:f28:412d with SMTP id 5a478bee46e88-3590f28533cmr16964482eec.36.1791951317953;
        Tue, 13 Oct 2026 21:15:17 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-359789fde97sm33110980eec.20.2026.10.13.21.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 21:15:17 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests/net: test network sysctl extremes
Date: Wed, 14 Oct 2026 09:45:55 +0530
Message-ID: <20261014041555.2823108-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179190711505.434549.1991031349414256009@kernel.org>
References: <179190711505.434549.1991031349414256009@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review. All three findings are valid.

1. [Medium] nf_hooks_lwtunnel cannot be disabled once enabled, so
   restoring the original value after a probe failed in --all mode.
   v2 drops --all and the full /proc/sys/net scan, and documents that
   only per-netns, restorable sysctls belong in the list.

2. [Medium] The rounding problem applied to sysctls that only --all
   reached (ms/jiffies conversions). The four remaining sysctls do not
   round, so find_bound() is not affected for them.

3. [Low] check_kernel_log() now ignores /dev/kmsg records whose facility
   is not LOG_KERN.

v2: https://lore.kernel.org/r/20261014041446.2821085-1-sahaj123.sc@gmail.com

pw-bot: cr
