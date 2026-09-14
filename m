Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547B371067
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359145; cv=none; b=tx5lp4EIy/TsZC1yruUlyAyBu9gn3++J65vJXRyYeywSi2pHMtGOEYgZf5KgpZuIjy0I/ddlKnPzf1p/kxtMYpwrTuMRnJEoGwslvGk1jRIcFiajuiARfyinmAnjC3EAaG8ef3eOh+eETXOMEHJi2oabaXbzPPw+Y75qA3QKu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359145; c=relaxed/simple;
	bh=ESNZSr3AXK9HlMk/gFGcAXiW9NstBhL9DjBXliLakIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=he0tUgFlmPxWihY1+FkGS7QebQk1cbMaIsXrKvB7n/Utf9FMVD0JAPMeg7c/u1PfhhIgc0HhjfOw2hquANANhsTWZkPpuJETzgVUilqb3KP2IQsGrJD3ckRF/jRqH4uxmqhEarhEn8apEKQdjXj/uNpQw3KRmqIEgy6CL17Hhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB+tv/Kw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB+tv/Kw"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9120eda2195so30638486d6.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 21:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789359143; x=1789963943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JGnLBFbtVuYmY0fd2Ltr4LaVEVXK5J1EaYUMo1O47F0=;
        b=fB+tv/KwTmFXB/enKWm4S1sA4MTjcid0HueI/hQHFDh9lmyIoMAXQ9a31tTqNKUd9q
         DrZ9UhiqSzpMW09mcSjEg+3RqTJQeidqcbVnFQlh0iX59QOqw13+gSy5jge6F+pYW3sm
         eKxk1XW4aP6Ftf/xtKEWU3UwPK+9+1ZMSmHlwp56k71z49fPfYYOD1x/+oofxXsrXsC4
         3s/DcVNR2IUvT/6cbKgE/6i7g3VJhNRH8an+xPA9mPQZv1eyak2f7sSGSiZDdpy9xHsB
         zBZBtqB890rpDFPIyURatDG1rgCXvxtsSWhKSxK3EcsmynxD8GajbCLaMBmaWO9DiZS8
         MXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789359143; x=1789963943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGnLBFbtVuYmY0fd2Ltr4LaVEVXK5J1EaYUMo1O47F0=;
        b=J7H5irKSfV6JdPJ/9TGk8A5RJ5UG7/NPdJw6/TPdk/rcTnm8sqHhedEIl7FVIiODum
         9Lv11G1iJl7KItctpWP+Nkb92vi+OPW+EgNRjifJTgc4NIX9IP93cXwTEa78quWCxcdz
         HHlekd0f0BE5YBhTonVVXC9W3PNDM4TPitTrEgCWWad1+MU7BFSaYaoxEqb5goyuV5pV
         EvFfnQWZo2Fv1tO2tmc2fUi6v2NmjrmuqNAwL7movV+tMUIXFkA+HjUJtC5bt2af5rm3
         qi74SS90mWCXt+EiEDFI/t8dEidTGi0S4TS0wVUE0wgpS3pa2/tKMQsPmvE67xM7Hx9u
         p8BQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5CfGV1pASxfpENSUibY2rfSjwsG/G20Zfg4BzcNwqcwJvK54mMJE26k0qqzDfV4Sv0rgKV+o=@vger.kernel.org
X-Gm-Message-State: AFuF++mWjOepkvFKzyi7Q85TPS++H4dHg7A2GqCBVZCxtA//zMMiZGB+
	gUbhaOYXphB/QjduxO0ehJZ9VuCfMumR51gwi8rQQPiH5TrVn/U8zZY7
X-Gm-Gg: AYBFou2kd1sDT+UtoNaiM+WAXC6T1H7Tsqh1VVGQOBa4jev8DUac+muN8tJvXm79yFF
	aOeTKkPNXpf2uDAddECHjU+3P7TDr9o2Vp5RS8dgWTsV8nwLsGMm8tikUp8DLPFPGM1edJ4R/be
	XSQK42WNcBzq7Oe2cDjpcS0dHId6hlIEYmIrgXfhoUUJ4vM/fkwYK5loG3MmhPurhkilWDLyQjJ
	CXvu5/aT502Dh++7FqWN5fBG2fF3oATDJGKWBrM4gH1p+wQPxyX6LdMq2ZGMxSYXrAftMgcFJMD
	zbNxkjAcwzokIgeUjBp1JN944uHEMV+/KRR8Ik66MSSkvPQt5wRnwtQSk8qPpBkfQoASrLsZ5yz
	GlnJxczVkPdcCHCfkB61A0rZNkmHPw5GBUoOPOXut7fTnfluEjQwCWdHZbQ2KtK5eXskATWBBee
	gCzbXlRnqRUai6NXUxiVyOqh9jeUfQ5HVYHeQGph9InyTHHAFsycd/EvD8dTLV58mNukufvNkGd
	GKPzPCi+WMSFHTCuiNEv8OuSOAYs8CRhgoaaYWBVx1MujLZFraP11+HCb7hu7Q7QTrARhDeqT8W
	Y2147EIMiDamGFaXORlA5vxJdSnMvWWOwQ4LfJuW2kYWcph8sqwp8oFIspKxQNlk2DefgY55gp4
	djLIhRvaXddAfgPAgckDDnVQm/3hM7DX25Ms=
X-Received: by 2002:a05:6214:8613:b0:911:2a7c:65b9 with SMTP id 6a1803df08f44-91226be65b9mr53306246d6.30.1789359142637;
        Sun, 13 Sep 2026 21:12:22 -0700 (PDT)
Received: from edhar.longhair-great.ts.net (pool-173-48-206-252.bstnma.fios.verizon.net. [173.48.206.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d35a9sm85215836d6.41.2026.09.13.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:12:22 -0700 (PDT)
From: Zack Gomez <zack.gomez@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zack Gomez <zack.gomez@gmail.com>
Subject: [PATCH net] netpoll: bound the deferred transmit queue
Date: Mon, 14 Sep 2026 00:12:21 -0400
Message-ID: <20260914041221.1028092-1-zack.gomez@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__netpoll_send_skb() parks an skb on npinfo->txq whenever the device
cannot take it at once, and once the queue is non-empty every later skb
goes straight there to keep ordering. queue_process() drains it from a
workqueue and, unlike the direct path, never polls the device for
completions: when the ring is stopped it backs off HZ/10. Nothing limits
the queue length.

A producer that outruns that drain therefore grows the queue until the
host is out of memory. Observed with netconsole forwarding a GPU driver
that logged one line at ~1e5/s after a firmware hang. The NIC was
moving ~17k packets/s: completions for each burst surfaced tens of ms
later, outside the one-tick window, so queue_process() slept HZ/10 per
ring while ~1e5 lines/s kept arriving. The queue grew at ~170 MB/s,
unreclaimable slab reached 51 GiB in five minutes and the OOM killer
ran from kswapd with 341 MiB of anonymous memory on the whole box. What
the queue held was the flood itself; the OOM report never left the
host.

Reproduced on the same host (netconsole over a 10G ConnectX-4 Lx) under
the same slow-completion condition: 200k lines to /dev/kmsg in 0.12 s
left 188k skbs and 173 MiB of unreclaimable slab parked, draining at
~8-10k packets/s. With prompt completions the same burst drains at line
rate; any stall on the link reproduces the growth.

Until the 2006 netpoll rework [1] the deferred path drained through
dev_queue_xmit(), with the stack's own backpressure, and was capped at
16 skbs (MAX_QUEUE_DEPTH). That series moved it to a direct
hard_start_xmit() with the HZ/10 back-off and made the queue
per-device, dropping the cap on the way. Neither change was discussed
on the list.

Cap it at 1024 skbs and drop new skbs beyond that. netconsole already
counts NET_XMIT_DROP in its per-target xmit_drop_count, so the loss is
visible in configfs. Nothing is logged on the drop path because that
would recurse into the console being drained.

[1] https://lore.kernel.org/netdev/20061026225645.482978803@osdl.org/

Fixes: b6cd27ed3388 ("netpoll per device txq")
Signed-off-by: Zack Gomez <zack.gomez@gmail.com>
---
Tested on 7.2.5 with this patch applied: the 200k-line burst that parked
188k skbs / 173 MiB on the unpatched kernel parks at most ~2k skbs and
+4 MiB, with 182k drops counted in the target's transmit_errors; with
prompt completions the same burst drains at line rate with a peak
backlog of ~180 skbs and no drops. Built with LLVM=1 W=1, checkpatch
--strict clean.

Two choices I would take direction on: tail drop keeps the oldest
messages and loses the newest, which for a console are usually the
ones wanted, so dropping from the head is a few more lines; and 1024
is arbitrary, about 1 MiB of skbs.

queue_process()'s HZ/10 back-off is why slow completions turn into a
~10k packet/s trickle; a shorter retry is a separate change I have
not measured yet.

 net/core/netpoll.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index fe1e0cda5d6..8fd640955e4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -38,6 +38,14 @@
 
 #define USEC_PER_POLL	50
 
+/*
+ * Cap on skbs parked in npinfo->txq while the device is busy. The queue
+ * exists to ride out a transient stall; a producer that outruns the
+ * device for longer than that must lose packets, not grow it without
+ * bound.
+ */
+#define NETPOLL_TXQ_MAX	1024
+
 /*
  * carrier_timeout is netconsole-specific and only kept here to preserve the
  * netpoll.carrier_timeout module-parameter ABI. Its value is exposed to
@@ -314,6 +322,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 
 	if (!dev_xmit_complete(status)) {
+		if (skb_queue_len(&npinfo->txq) >= NETPOLL_TXQ_MAX) {
+			dev_kfree_skb_irq(skb);
+			goto out;
+		}
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.55.0

