Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852460;
	b=P9oYw5Be4T7iaM9kyMSDPIpR64zaVM5DoBul00LJBMpEmHBqaHGqKrvXgHJxGHKsEule
	 8InAMw7uy+91Oqo0gD96gOoMZqYkKk8l++JjvLqxluun0JfBDrvzzKcC1/ABOhoT2kmn1
	 BsFY/lUPOL120KXQ/3E65zPYG69k8dqLOhTlymYhnWDpblHhWN48sqDnj2CA5/IeASlcC
	 0bmGVgPeNiOBlfnD7/JYbQft0IaYuSV2g/uhml3v8xBdX2CdwPd6IA1lArU3f4VsvPm8X
	 V2N/y8KOXwwP61yoDIZ6JUx8PTIHAd2V0bP0BzyDQshMyx9yfqcPSL9XA4MGzvCUjEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
	b=mMBoFUDSu4a0IBRJgSY2XTxSHuGtr2B1OrvY8T4IWDC7AufynamCkGX+K/YeBcudti5j
	 v2VfXkJuxiF2XDG9P7oDrjXVKLpi6QDlLxLjfWSfCkebgJJtXHfIGn+MVO9pirDbkmUR2
	 vhRY2ESoKnMReAS7guIhi5QmJ6YmDZAxJ91wP54kaRvHu0zydDgNLrrtGdhKYIWeWvq0M
	 OtYtZJEs2PpvySQZk6aEZ4Y+0kPqDj/k4tS0NQczhisl9nUV5PY2de/j0/Mv3Dy+zy1y5
	 P7I3DayuTEmtkgboHeavhwjdXCtoRshcm1wRgMmdhlHsDmabLLcM9xqVHsvvojdvqMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="hmwnA2/O";
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191A606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6191A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=hmwnA2/O
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91bb5795792so20346016d6.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852459; x=1793457259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
        b=hmwnA2/OJ9n/xncS/E3SJjMDVSDSH6oacFhDMtufChcxgndQrzMsi5sNCPTrsu5rRB
         IO4KLr+vFQBJmC6DvF9xoXxFGWLZzHko6ToSCXi0PbkrPUSwJwvRjL5rTtQxHR6JbW3V
         skNKXUbDDIO7e83+gtiqvAJSE+NW8VoQLs+cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852459; x=1793457259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
        b=TGWg3bL1Ef4H20QriuXiwdtamMrxJaghh2cMix0V7ktqJVolYS6mWdOEOPrKxQIpGO
         BjT6gKN+MVRX7RGXkuYqlBRuJunQVEVgMMHg1uy98rQ6jqAH9z2F1bfQ/nTVXUXCwBPJ
         9S9nmEtL8sA1RCwnUVjFZUwstSKlRe3JE0GiyfPuEtdMjvBfn9YHRzPsG1Qd6SkyJTtG
         94PnobA8G7xopZIYQlokvYvfXfjdxk3cV5fxVhCbvLWnqhOpgqkBgafWgMC/Ee4c0FH0
         tKRZCyqGW2LMsLkcHlw84pEiG3FBXVAJhhYC10tRWaPCb6BlKlbeRytuC5bTqs0ngqF5
         PJWA==
X-Gm-Message-State: AFq9FYK2ODG+qIHpQtWVrn3kutw/ouV99rBSGKKIzY6FxsgZCqh5X1L3
	cOYGtvovFEHlMhNkBZjShWWQ8247jf37SdII0qJb+4v2WGPak8ZF+bHPAUTl8h0APgReB1G1Jpy
	elJ4=
X-Gm-Gg: AYBFou3T8THPhh5RKnyEe2wMZGdhVaZlLs/yQb3yn4KMQKUaep1PQ8bA+BwpN2tsFsk
	/B+/Z8w/DQOZliX5XceaAh1wzfLUYKlqWwWvt2HQ/apOlEEoZ2jubO0l1phz9WSyI4DizRw26FM
	sh1GT+cM3dJLCLGORdOHxDPoxVdGtIpxKp++6uxN/PCu//EhilMlONvS4kQ52X73xPnbKgwGxw4
	aiUD40lzvr/iuM5RWYzumMbBt3m9vXJIUUz2MJpFHl0liO8sv+9ON3VeoI08PTCsNEFOHkjV57W
	Smik1E2mvzl+oy5LiYW36oRBdEoukSImDZhazWMuOGp+Ny3ycc+RxV8llVyo1xNkfOsWU4dKCDG
	xIyVNewydAAN54VOrxkzWj8s1QCPv6fyEYtMheVyYgaS77wUBd3rN/G3lcv2UBm/dli+r23S+Zt
	7w7mC+j5amtmNnhXyLU1zB1Wqu/KdBGrGssxxIuuvZUM2y0NTlhMw0MnBOLT6s+BRQbRp9a1Ft9
	ePVP9HL3FJDNyJnRk2sBuVLKkG+FyvnT79blitaFbOItwEUox2wF70aLcyDlGqTvXJMUIySofmk
	i2lI+n/VLgzWFbZm0f9clqj4kOZhz0ZePI1O9M2znTA=
X-Received: by 2002:a05:6214:da4:b0:91c:15a6:ead5 with SMTP id 6a1803df08f44-91c48e56e21mr32544566d6.36.1792852459348;
        Sat, 24 Oct 2026 07:34:19 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd5b65sm22397466d6.10.2026.10.24.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:34:18 -0700 (PDT)
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
	owen kwan <owen@verialabs.com>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Sat, 24 Oct 2026 10:34:13 -0400
Message-Id: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: resend of the two-patch series.

- Patch 1/2 is unchanged

- Patch 2/2 now fixes the drop accounting raised by the Sashiko
  review of v1 (both providers): only NETDEV_TX_OK and NET_XMIT_CN
  count as accepted transmits (CN can accompany acceptance of the
  current packet); any other consumed result, e.g. NET_XMIT_DROP,
  is charged to tx_dropped instead of being counted as a good
  transmit.  The skb-ownership fix is unchanged (Sashiko-gemini).

The v2 revision follows the review of patch 2/2
(https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/)
and Simon Horman's request for a response
(https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/).

Two independent sch_teql regressions on the transmit path.

Patch 1 makes slaves_lock safe for the hard-IRQ-disabled netpoll path and
for PREEMPT_RT by converting it to a raw spinlock taken with IRQs saved.

Patch 2 fixes a use-after-free when a lower virtual device consumes an skb
but returns NET_XMIT_DROP rather than NETDEV_TX_OK, and stops counting
those consumed drops as good transmits.

Jamal Hadi Salim (1):
  net/sched: sch_teql: fix slaves_lock IRQ deadlock

owen kwan (1):
  net/sched: sch_teql: fix use-after-free on lower qdisc drop

 net/sched/sch_teql.c | 60 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.43.0
