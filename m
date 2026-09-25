Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC758199947
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367327; cv=none; b=I0vQRvwRJmL/lgbS03c8eqV9vLzf4vnOvQ9e4gpN+pgyvklz3LJPK7nUkC+L8mdHAX5vjWxC2c6+rxCOoQIXqVd7zzm056I8OzOK/Be9c/eZCU1d9utlLL8jmZ2ci5Q1ViwWBWB2BUxt8w1zXRUux6vTM4YkbakRHujtXXhAWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367327; c=relaxed/simple;
	bh=ALYl12gLhsiNhtcMZjfd5rX30wOKdu7pyFoh6zjE+UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDnUajmY1gvhc9VQulNX9zQId8BZsG+aHm1ICjKZ5AulYea3W937CGAGpI5DWiKqp61ZWQFH5jeVmL2kwJD2eEzy4LT3XNwXOg/N+fZDKkRdgZ9h52F8nHiIZzytvOKqhZthfXx2r+bHXx6AwryqlO8uMyHzDT1HYDM4ubxMJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD6rFeMT; arc=none smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD6rFeMT"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-53321db7e06so392011cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790367324; x=1790972124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i787Azbb9NshFsfx+SOyDOlWdaaHwqbmq28lZ4vZiLQ=;
        b=bD6rFeMTOm7H4g7X1sZak6NTwW8tqUTxU/WOtLdLTSKdJqdC/aWkoSDLunFHn50OKf
         Uc4IyTsfWqqcpco3d5spxsxLvZ1lxq5/zdbML160gYnFyBGxxzBFOPkVu9zVydygsAT6
         TabkvsYqTBS8dOLj/lUnsOazcVl493isQbDx+P1n95LcleFOAm7ZE/4k096Q39LmKSQH
         wgrj4upj6xeWYS3X2NGfnN6SFxxEbd2l5qm7nttUyyvMtY5u1SMOG0966hgwiDp4dCYl
         O+p7p3PIzE2hN7/5HVt4mqZc1lxqwjUXOdEh1fxWp/Y2YzRwdDWhDi/yfh73bMWfiLFc
         bQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367324; x=1790972124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i787Azbb9NshFsfx+SOyDOlWdaaHwqbmq28lZ4vZiLQ=;
        b=PE0QH1OhOXicoHH6iaFPvmSRD1T/yA+OWGUT1x5qpfVZlHxTH/EgYvnmWxWZVv9nJU
         mamjyDFkEr1QwHzEKYPXGSVfbUm3Y0dBe9A2vfuk8zP6IGF/j3WfOqKjXYUiUDV8v3JD
         ZxzmPOV7cE9+2hlz1FjjMLvhz0ib14nhsLdUZ8mIRldTHEEX957HV69afHpc/D+D8rRE
         mCpr9ClM9yzpIvgkqP3ke7esSmtXAPz5THq9pP0PUIpn7EfENuVJn+sNz5rIKHBsFAsz
         CDhUvndynF4QTLa2CIxJIAN7S85u6GzWu9RY9XKprEQmKppce9zC1d8YxH1Q7taNWjXl
         C0ZA==
X-Gm-Message-State: AFuF++n+oHEPkuBQTdy0a+m4WZWy9SHWSq7hafFE29zxEmDaWTMQcns4
	d68UvZOmYdodvCKQp1t9cfPGunqjA2SKQnfYmBI+Z9LsPIyUG+bDoyZnNW0ueat8
X-Gm-Gg: AYBFou0pRoK0KtnzH5ZuTxj0StjnPR/c1gn3MdbJkgr0DbWnIj9bAc3JMjfjEOT4yJh
	jYEnryZ3QtFmiTLqJm+Kqad9/Vx2nhzny2YF85oG2RpLDg1zj4H2a9aGbSLetQjtUCZhS9ulL9U
	9iLcsYncU9GmXP92xeeYY1224qxwPPNVR6RvxHMxh1SWydQ6YTnK+wSfqNshUwyUq3ElYZsN9Ct
	7+FDDueMFlcCYEExkIomC5qPpzKlFA69QPrvcTajF82VqMZlH8C2BjHjp2KFJvJF8n49nPYWrVU
	qmECIFH50RLlgJsQHjJNI/ko/0ErCHR3tdIdOlrk8N7q1vfQRHzntEPETGabV2MQ2NplJnUhCQ/
	UQMpIWAL5gFB/LXtSH+jnE6XjBuHBhc3im78HBBGffL2Zcx5oAlXmBofJ3zgWw7nydIP8lwh3bg
	9DEiXKEZzDD9w1uP+iYa5nOuLZR8NseCBRrqrFuoHFTsmXriA766Ua+R0Q714MVpvGJ57wZEWiR
	VA=
X-Received: by 2002:a05:622a:156:b0:532:9eb6:8498 with SMTP id d75a77b69052e-5330b5f1b5dmr63949371cf.22.1790367324268;
        Fri, 25 Sep 2026 13:15:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322132ef3sm1163031cf.10.2026.09.25.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:15:23 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: consolidate devmem net_iov freelist and DMA handling
Date: Fri, 25 Sep 2026 13:15:19 -0700
Message-ID: <20260925201522.254717-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up on the recently merged devmem gen_pool removal by consolidating
devmem's net_iov freelist and DMA-address handling.

- move devmem freelist to index-based approach with push/pop helpers
- switch devmem to public memory-provider helpers and reject DMA
  addresses that cannot be represented
- decode stored DMA addresses for TX on 32-bit systems with 64-bit
  dma_addr_t

v2:
- drop io_uring conversion (Pavel)

Stanislav Fomichev (3):
  net: netmem: move to index based freelist
  net: devmem: use memory provider helpers for net_iovs
  net: devmem: decode DMA addresses for TX

 include/linux/skbuff.h          |  7 ++-
 include/net/netmem.h            | 27 +++++++++++
 include/net/page_pool/helpers.h | 10 +---
 net/core/devmem.c               | 81 ++++++++++++++++++++-------------
 net/core/devmem.h               |  4 +-
 net/core/page_pool_priv.h       | 14 +-----
 6 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.53.0-Meta

