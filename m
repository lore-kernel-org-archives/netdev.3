Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B02DA759
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999343; cv=none; b=dckjSpo1MvjI4Lc9hB9xt3BQo+QaHYoC+2e103WMv+GzuGinezj3D0qj3Ut1Vz4sqf33kEWvWLmOCmYSQjq+kwlhnwp72pJ45ZPC6fPI7aDe8mau38n5nhvZkvSgqtzONkC0XzeJ5JhXxZCurOAV5bbsEMV/X63x+wpfggqMITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999343; c=relaxed/simple;
	bh=bmrYhg8GPmLNgo3OC03WDmuMfcBOKUh4DkpRoc+gZsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUT1q46knF2Af3APaUkJ6igzDUByy7vJJg2sjfenpvmjjd0WDc3T0fAvsnZDX1t+foPdfy7chgra1SBHDa+HYGVJh9L3QxITEE0GILWSN/l7cdVVU8Euc1xCmVepT0MpOzX0b1k7ffsPdTvhJQb1/FMmP4XHRB7MPzRahS6DA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=iCmgOkNn; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="iCmgOkNn"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so24530267b3.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789999341; x=1790604141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8wZJIn/YLIvaeMgy4QlEYYl+fSKkh+mCzNGRZOGqW8=;
        b=iCmgOkNns7XIkHQLyWN9VzPFLA79EGf4GsXcNkegnzzqonXhf6x/4iqPbp6+uH9s2J
         UhKc/Kbq8WTnZKeCU0JR4Eh4mHt9sVDi6fkaQNsBirjLBaHePaoqxmHTfw1D08IlyO/0
         lDoQfvCYr8bAnP0Nn/xDXK42V0MlWhZeU9OjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999341; x=1790604141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8wZJIn/YLIvaeMgy4QlEYYl+fSKkh+mCzNGRZOGqW8=;
        b=I46FiUFsUVBoiSzYUzqT6bfPEC0xtjKKZBgAPYE7S5XZ+mg9YFjeNTDPgX45C7thja
         hmFzLobfLkUvcWGyGgRM9EYj+wfM1+faB7xA7QE1Xs1uQKBIgCR5I6vLehMzLNl/Tvdq
         IYR98db7rnUFweWyTq/jWzwJcAc3KEEaj2fDcH9rQwUQCarcO0cBz4PhqP8YJkVJetLA
         JDX91hvSQFIlJbWt2Ny0vdBhyV+Y/uKOYQS4hCitzQetDjJpl+OwMG3vv8lYgH7dofAs
         mLyWZo8EfMRjoxjI19LVxx19Z1jq3wYBR8sfRiyvhqIHhPw/jvt4UCF5fH8BmimQTU1r
         Pm4A==
X-Gm-Message-State: AFuF++kBeQx21gRfd1jkZLagcGXOaL0uVDXkB+/CPUrcnSS+kUk623bT
	Wy2v2OFb9Rv4POwFTKLdQJIKhrTiioWQ1Mmk4MT19v9eJVvD3oDyl0hEmXN5U/w6BkSmxbKqY8z
	38Vjh4A==
X-Gm-Gg: AYBFou33yRDz/scHUKoajBDGrX1UtT4iQVn0ESIGIJDgCkq/pdpopW0KUBTmghDnKgv
	3mfNwXmw3/HLXFDvuMgTEgylfHHeeoI7se7h6pvFauN0smh93uzC/9dC24nLBKwPbWEpqJ5UuVs
	5bdNLev+FHoLdU/TabU9KB86f6JaCixWdVYyLXVmjeus0ec9jAEPdFj1vKj0jPnm616J9nkUvEp
	e1H4rsTzxCsNDKUxr1yuOXkZ0p25gpdl7lun0e+mQZYkRIIZa/iDgVq+wtZSXADxJ1l581Hlh3k
	F/LtSD+VGJedHYPsP2FYW++2D2MPo6h1UkuBrsQb/yUIkMzOjl6jYHMIQVpHaGmusYGj74jDFRf
	cpxCc7hnUfWQV3Et0yE1hNVJl6hrD3zLW/Xau57GEosGkihuvuP+ZU92gGhz9+3xL0k5Vfd3AGq
	s8ZSzl9TTU5E65yuL7A0yNYpFnVcm22cPoo1sypHkQMdyNosF7G0gL2elkIXwfo6YUJgMf47RDl
	BD6B3k9IGgrnFiAagqWbeesWvbcG8x1k0HxQQkIhtikIAdghC8x4DiTKB897R/grB11IINFTfDR
	qgTKgz6HYOnypK6+abUNiOU=
X-Received: by 2002:a05:690c:38b:b0:873:5c6b:a30f with SMTP id 00721157ae682-897381a79d3mr29832287b3.61.1789999340710;
        Mon, 21 Sep 2026 07:02:20 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae512550sm64806751cf.1.2026.09.21.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:02:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	"Victor Nogueira" <victor@mojatatu.com>,
	Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>,
	hybris <hybris@mojatatu.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
Date: Mon, 21 Sep 2026 10:02:17 -0400
Message-Id: <QDISC-9R8V.v1.20260921065103@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbedit can set skb->queue_mapping and __dev_queue_xmit() honors it
through the skip_txqueue flag; netdev_tx_queue_mapping() clamps the
index it uses to select the netdev_queue but leaves the out-of-range
value in skb->queue_mapping.

Every later consumer of skb_get_queue_mapping()/skb_get_tx_queue() on
that path then reads past the device's queues. Taprio's child array
q->qdiscs[] is sized to the device's queue count, so taprio_enqueue()
indexes past its allocation; qdisc_restart() likewise dereferences
dev->_tx[queue_mapping].

A local user in a network namespace can redirect a packet from a device
with more TX queues to one with fewer (mirred action) after setting a
mapping valid only on the larger device. That reaches these reads and,
under KASAN, faults with "slab-out-of-bounds in taprio_enqueue".

Store the clamped value back into skb->queue_mapping, as
netdev_core_pick_tx() already does for the mapping it picks, so the
whole egress path observes an in-range queue index.

I have looked at other alternative places to put this "fix", none
appealing: an out-of-range queue_mapping is read by every consumer
on the xmit path, not just by taprio. For example, upon testing
an approach that only bounds-checked taprio_enqueue() I observed
the fault relocated to sch_direct_xmit()/qdisc_restart() instead
(because dev->_tx[queue_mapping] is still indexed with the raw value).
Another approach was to cap it in skbedit;  cannot work: the
redirect target, whose queue count bounds the mapping, is not known
when the action runs, and act_mirred sets skb->dev afterwards.
So the decision is to cap the value where it is first trusted and
result is it fixes all downstream readers at once.

Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=y,
CONFIG_NET_ACT_SKBEDIT=y, CONFIG_NET_ACT_MIRRED=y and KASAN enabled,
create a 3-queue dummy qa and a 2-queue dummy qb, put a taprio root on
qb, then on qa's clsact add matchall with "action skbedit queue_mapping
2 pipe action mirred egress redirect dev qb" and send one packet out
qa. Mapping 2 is valid for qa but past qb's two-entry taprio child
array.

Reproduction: reproducer ran on a KASAN build with panic_on_warn=1:
the unfixed control faults with "BUG: KASAN: slab-out-of-bounds in
taprio_enqueue", a read 0 bytes past a 16-byte taprio_init allocation,
and panics.
The fixed kernel runs the same reproducer without a report, only the
expected ratelimited "qb selects TX queue 2, but real number of TX
queues is 2" notice.

Fixes: 2f1e85b1aee4 ("net: sched: use queue_mapping to pick tx queue")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c67900354fa6..736b3664b635 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
 static struct netdev_queue *
 netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
 {
-	int qm = skb_get_queue_mapping(skb);
+	int queue = skb_get_queue_mapping(skb);
+	int capped;
 
-	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
+	capped = netdev_cap_txqueue(dev, queue);
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return netdev_get_tx_queue(dev, capped);
 }
 
 #ifndef CONFIG_PREEMPT_RT
-- 
2.43.0

