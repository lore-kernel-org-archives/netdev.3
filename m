Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B83D3321
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405638; cv=none; b=kYmPKE19h3JTlDyNQN/A1Le1Y7WDO1HqTM9KzEAL151MDFEMPP11EuRLkqBJFkxwMIh14JPuBnrukdBjHUksc4WD/E7Un56p1+lv8mzay7RDrH8RdkFenMoLDYx+HW3AS65c6x/TjImOvIqSqg22RNTtFTO4hddXg7g2v4mIJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405638; c=relaxed/simple;
	bh=v2otgkqcGoPAxtDs9BIv0BddY44N60tS9V3/kzf1rVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IesWEJaStjuM6RHPZVg9Im79YWB3kYI7HS+ryjCpZETCH1TdJSlvOtvuFql5lNKvdWzO1OVBBAB8ONHKirtZLpsoXYClq/T01kmVLFqmQ6I5l1PLTQO+k5DVrBlH4Aw0fQgzciwyIfz38IJbD1SjXiNT0vrBDq+HVFF69s6LwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHyqn9ZF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHyqn9ZF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1763823f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405635; x=1786010435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPbuhEVbHecHzC1qayYU8wiK5gPmiPP8a157RrhfrjE=;
        b=sHyqn9ZFEY06m5SHFvzkLzgAr0InYknJQoZMQKQmpIEp/PPqDoncKpeiLPqfk+7YJ9
         oZgR832i35eIYbADjPN6XycyZV4i9RcxVUR9DNdTT3cakxcKSavXi0oOJc6iKItGOWgl
         L2jO7GaAnIgPTpe9rCD0NwyiaAA3W1YLTe3PDrksOiyr8fpVLuijL8MwXxD64899RFFT
         pNBm55xedsjE3uuosLxWAHgZHNmWHapRhZbn8+n4vsQYj5OKNtbv7jrWU0H395yYAV9C
         TMlRhWnfjs2zGZSbNBP2/5mtXdJklRBF8BrWeO2Ubaj/Pmt58g3NCSHL+PQUTwjdNh47
         mShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405635; x=1786010435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gPbuhEVbHecHzC1qayYU8wiK5gPmiPP8a157RrhfrjE=;
        b=sH6yiw33a2ivpJyjjCfAzO8nNJYy+Q3fpD3w5LoHbEeSGQDrUSU/DBgUdC9DxT45tw
         2XsqEG5hYX65AZe1PIgfvxReNZL5igtMongM8pYGEEtkjazwC6r8igfo2TXoCfm0nhzt
         5P7AlC9gwadZBnwDWZUuqt67twHWiPdexrOwg4glH/N5ddo3zkou9Py244RcWg3W+UrD
         r2rormu9CcIgedCXYFULeaxEeYcqu0IqPev//j2Duo/O0jCAoY/PxrBU3M7tTcE1a0HQ
         i4fd0ifsquwiv8W9O2QBoJ2o/U7It60+CouFDjkZHjaelCAat2jemzMRClZVEnbs2GPB
         EKDA==
X-Forwarded-Encrypted: i=1; AHgh+RpR6DJhX/a6m1IErlvzqikRtNRbVdOIht+4FaTAGV4gBmkM9ruuh9/GwrJwAbZzGxcu/4hJdXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5D9Lo7v+4UB67OgZ0b5bLEfBdMeUGJZxtVsNwjk465Cr0dYu
	s/VRxOnAhIcnsiefgRu8+AVEYrZvVNcUp3fGxxZtLLvWF2N7zReBL8au
X-Gm-Gg: AR+sD118vtTwtoTC/plsTpqJtP9cGAdzSzXHH27JR/4eKozMhG71WViBgk7qyiuWxwc
	HLG5ITKJOctfeODTiqpVnNXq0Tl4rFBrBAxo0deLJ3Rq/HBrNKiooeHuvDqvyfN4hqivWuHzMAG
	8m6zN3DMGyRVglVEI9hh3VjgW5nRv28ezpMmtHWjVOVlANxqr5ELP8j3Ko2AcSaaS1GYFDCSTIi
	Lw7fOaWxfx5VYGGkVJ2dJKQ+dUDIA6V7c/u7c4dHTUnJvOsO6RT/+7ur5Wsldgrr3pnEvaZ4Y3a
	VKIy111SYEp9CqWAbTbkophBWukXvw2076rgrlpIwvtiKPADmzzlXl5m9zKDi3hjQbg5Zrmvzp0
	U43N8nAdkAt5aZxuk+EfH3cg9mlmxeJRXXfLz6k7vvJx4JFSxsqFamunD9O9x4NbUFzAaUnR2YF
	4dPiJocL2GfFCVkA5tSl0xcLZRDpfWnbfgyYHmqDoth0jNkJvthYcewTjlCHZ+Fo8zlUhP/JGug
	xVmC/INnNoV
X-Received: by 2002:a05:6000:2010:b0:47f:4fa9:ae42 with SMTP id ffacd0b85a97d-47fc80c2fcbmr2863337f8f.11.1785405634990;
        Thu, 30 Jul 2026 03:00:34 -0700 (PDT)
Received: from pf-5j7x25.fkb.profitbricks.net ([2001:9e8:482:5000:a5d:311:98af:bd1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e4721sm3984728f8f.16.2026.07.30.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:00:34 -0700 (PDT)
From: Reshma Sreekumar <reshmaisat@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Reshma Sreekumar <reshmaisat@gmail.com>
Subject: [PATCH net 1/2] net/sched: flag inconsistent qdisc dumps
Date: Thu, 30 Jul 2026 12:00:05 +0200
Message-ID: <20260730100006.3547944-2-reshmaisat@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730100006.3547944-1-reshmaisat@gmail.com>
References: <20260730100006.3547944-1-reshmaisat@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc_dump_qdisc() walks every netdev in the netns and can span many netlink
batches.  RTNL is only held while a single batch is filled, so devices can
be registered or unregistered in between.  Since 748bbef5fc6a ("net/sched:
switch tc_dump_qdisc() to for_each_netdev_dump()") the walk resumes on an
ifindex rather than a list position, but ifindexes are reused: a device
created between two batches can be given an ifindex the dump has already
walked past, and is then missed entirely.  Before that commit the resume
used a position in the device list, so any unregister shifted every later
device and silently dropped a run of qdiscs from the reply.

Unlike rtnl_dump_ifinfo(), which pairs for_each_netdev_dump() with
cb->seq = dev_base_seq and nl_dump_check_consistent(), nothing under
net/sched sets cb->seq at all -- and never has.  NLM_F_DUMP_INTR is
therefore never raised for a qdisc dump, an incomplete reply is
indistinguishable from a complete one, and userspace has no way to tell it
is reconciling against a partial listing.  Callers already handle the flag
by redoing the dump (iproute2 warns, netlink libraries retry), so raising
it is enough to make this self-correcting.

Use the same idiom as the link dump.  Both return paths are covered, as
the -EMSGSIZE path is the normal one for every batch but the last.

Tested by dumping the qdiscs of 400 dummy devices (mq + 16 fq + clsact
each) while unregistering devices ahead of the dump: NLM_F_DUMP_INTR is
raised on 482 of 972 dumps with this patch and on 0 of 1089 without it.

Signed-off-by: Reshma Sreekumar <reshmaisat@gmail.com>
---
 net/sched/sch_api.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 668bcd60d..ab31a75fa 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1949,12 +1949,26 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 		netdev_unlock_ops(dev);
 		s_q_idx = 0;
 	}
-	return skb->len;
+	err = skb->len;
+	goto out;
 
 error_unlock:
 	netdev_unlock_ops(dev);
 	ctx->q_idx = q_idx;
 
+out:
+	/* RTNL is dropped between dump batches, so devices may have been
+	 * registered or unregistered while this dump was in flight.  Because
+	 * ifindexes get reused, a device created in that window can be given an
+	 * ifindex this dump has already walked past and be missed entirely.
+	 * Advertise that, as rtnl_dump_ifinfo() does for RTM_GETLINK, so that
+	 * userspace redoes the dump instead of acting on a listing that silently
+	 * omits entries.
+	 */
+	cb->seq = READ_ONCE(net->dev_base_seq);
+	if (skb->len)
+		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+
 	return err;
 }
 
-- 
2.43.0

