Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B052190462
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140447; cv=none; b=dv+dzVOYeao96rAIkcXR7fA9wNa17HsrL/Uqx8nL4HEni0ID4RKwNocxEzqZFbWyX6jHW1KQzgDNCMRVr7IXE2ranDa3TIMsjB442yUB/+JkdcfaeZBbzJAOsIY+itiQxRSUkF9CaqaQjVV3XlrAidrR1EgNIixxELIxUIlCUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140447; c=relaxed/simple;
	bh=lxJ9/R+nPocJAVyK7ncDpSazd9bCHXPMmaMpTjYhrIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhUKAeFbRzBFRiPG1qp9qFi5ajiPu5h3sS4++EJIPUmnfpE+LzLnae8JESLXEtJew3JBNT3w5cg15gABDhdP9mvuwSsv9j0cZDwcMerWkOe5D13ZEfsxpDZNwMkkz/T2w63JiZP3POfBFvV+JBV62o8v6ZLmGgM9SEM0u27pCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DSAwTYht; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DSAwTYht"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917866225aaso82513256d6.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792140444; x=1792745244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBhmuSMaG4Pa2MSUzOSH5FgUKD63s+LESTxgG06O3FE=;
        b=DSAwTYhtVkLiKZR4HzGQ8sEOxcdTU/lsY7UW7HzWEVpEdhi5EOa3LMZS6Hvcelez9o
         Lh/lsKgs0V2yAZmLY8Wc+AlHObKi1JSurbcujZlMK3gZooHmCqgIdEy3PgAgH7gTmpaB
         7fhEDrw7vChLbp/QnqyXhwwtp7Ce0ACC1lNJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140444; x=1792745244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBhmuSMaG4Pa2MSUzOSH5FgUKD63s+LESTxgG06O3FE=;
        b=misNSPPyY/Xzn6p+OF5msF1yKU4mZLhUnzkVnYSybP8FPA2Mjtp0MsixxibmGxY3Gr
         uGQ0UItWQ/caOQ3tGk/urnDzKRXM6iEzH5Jwmz+ced+CMbN036OIFj37QBucLgbNWD1H
         6DLfVn5T/BahsbO1UlAHyNtJxmnFadeLlV/qkuh9Erm0HJzi41MyBH4ZIJ4FX/P7VFEQ
         akA+C/Y2T/gBsOpWqdplQOy2ffyMQoIrXD5HKSPEmD2bn7vjEgVUc8JHWTre3vROr9re
         B6x4F8QydkFCbjaPk+Vk3PBmDNnDBNx0JOCsxdBuRTR130cz68W5VpKgCFZfBOZVY5ZW
         6UzQ==
X-Gm-Message-State: AFq9FYKFgQKumCE22ZaC8ZXUftYebsgive20OWrb2Ej+n1ojLMTD5hfh
	ofXnDz83SgvEhgFJDJDkWLbZZsNTYVKDo7Xv9FDmEPzLLH+2BBN8PcsumS5NjeIasahltzVRrLF
	yz7s=
X-Gm-Gg: AYBFou0lgpMsr2nI6zzmioykTcc8G8z8DDerBYTINpoxgh+2Z/s98p49yz2Jb/XqVEE
	OKE+vVC6fRSvR4k/Xo6RXw3OeOeDPiis+WAkKONVud1pH+FA2ATnCgVZuPZ9SlDD2j+UJKNqp7L
	0rLVQdWLzTJpHB8f/kOSigY7gA3nuu3tlUnzG90C9S95szXbEs4TRyhW2h8gWijD+BXpY3ka02x
	9EUuO8TKZvhXKMIdPs3+8YcicMOXdE9w2lTJr4YjWPBp7nwc+J3+GYCzqYc7v8UGYZLbLIsEiDH
	Xr5+t5THjRT0D9iDADw3p5++sK/Lf8rILp+mADJzAQPPCW91/SW9P4CglHs87J8AqX6L9WsE/dr
	j8laK6Alq7WI2rKWmf4mV+UmQPtKm3CB/4HKI4bQvfb6OFevJwOK1MTZ1hhSbQOH/ZHkyfgM9us
	6GIveuEAmRGsXaRzjR8MC5EWwzOWViKrNDw+bwelONBWqBMzGaG0/OaZ1vGBa1r4J6h537X7oX/
	0gSNqr0DRkIwhZ4KcXlKmxzsZGpPRSD/hjFNHpZcLOP
X-Received: by 2002:a05:6214:240d:b0:91b:9136:d303 with SMTP id 6a1803df08f44-91b9136d5c9mr213297676d6.10.1792140444130;
        Fri, 16 Oct 2026 01:47:24 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm17863946d6.1.2026.10.16.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:47:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Patrick McHardy <kaber@trash.net>,
	owen kwan <owen@verialabs.com>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Fri, 16 Oct 2026 04:47:17 -0400
Message-Id: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent sch_teql regressions on the transmit path.

Patch 1 makes slaves_lock safe for the hard-IRQ-disabled netpoll path and
for PREEMPT_RT by converting it to a raw spinlock taken with IRQs saved.

Patch 2 fixes a use-after-free when a lower virtual device consumes an skb
but returns NET_XMIT_DROP rather than NETDEV_TX_OK.

Jamal Hadi Salim (1):
  net/sched: sch_teql: fix slaves_lock IRQ deadlock

owen kwan (1):
  net/sched: sch_teql: fix use-after-free on lower qdisc drop

 net/sched/sch_teql.c | 49 +++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

-- 
2.43.0
