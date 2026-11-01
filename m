Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550482;
	b=GVnLVxtFKL66TF5u0K+GdNJxEhSHhUziDF0qcD6pIBfezpNg5TtcFN+rZRL6IChRn9ro
	 6P8Kv2kzrfZOSFQy5EFpM8IMMGxfYI9oITmfsTOnR10srHuUvXTQHwYhGklGo4hkGJbR/
	 +2RVkraVRkl9X/gORUH8lojkgSLJ5CORNCK8OeWLKoZDEV1OBEOuTDk97BiwuD/4g4RYR
	 AoNMNE36Aug8YrfdE7RPc8lJpwDYi6u+AIoOkWB9Cg55GycLufYPxNK5ISbbmUKE4JyO/
	 UXhmkM9sPO9S/vZzfXgZFwjYveMx+4Y5bhFqynDWjIysA/4VoumCHTYJ74hFkupvafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4ATEqm11WHdDrquS0a1up5qn5OVlPNfvdSMdlSxlBoU=;
	b=BZfBywFYnbybCjlDTMUC0xbTXKBDrIEe7M//aMomJkIbbE/2UxdXpKGo8jgV6BSgO0wX
	 2/+yYM0JRJs2DPQxld+VY3QOkhEKaXCub7trklIpzYlYBsP1Wm5tG3t3YRrSSkwur1nis
	 BmMHDWioQIkeSUcFhUcVWwYe28fqrO6BKkC/ME9wlJVhcrAr7Ptyo5mxQ+i9uIBgi6hKp
	 j0G4r0M0U0JjEAq1o+HnrQSSNwTkgPKipWdciM2qxp4vnXhAkzJKjA8kOYwyg5G/7LfAU
	 TIod6yJ9EOAj1wdEnBLn0kf/7TJS8gQhzpVC+gI/O2JFQAnWlDTp83nsKlqhQO2z/Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=BM8MWJb8;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92003606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92003606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=BM8MWJb8
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f1e5d7450so214054985a.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793550480; x=1794155280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ATEqm11WHdDrquS0a1up5qn5OVlPNfvdSMdlSxlBoU=;
        b=BM8MWJb8yRjyOSFmqDyHfMEenCfct9zV1vZNmTrKqDDKSwsLz365hkyNP5/G9VZccd
         jlqwTb2pKaeCgEbV4liLAqWAr3eCJNSj3UML2BP6ZQDgqSIcgE0OV9dUqkrWORM2+UvN
         R7HFZngYxh5Juk+BlTWwcDTWI1BTX4wT35OWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550480; x=1794155280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ATEqm11WHdDrquS0a1up5qn5OVlPNfvdSMdlSxlBoU=;
        b=ORm5Kz21TCdWKuRC+xo1MH0zngCHYviz2VSldZlpHEy/FIYeiqc3mc2MCtGoEwRibf
         gNgGSc8sa1h57aMHiUqZGyd4PnckA2f3T/rLLGT91DnEmsKeu2CX80pMipt4YGBtiGF3
         5y8opLLTlLbqHF5n94fKtKY0WPBYAa0f+XyW5YU7WhM9oaJnHvjyv1mKQWjUIgB38/r3
         kL8YwexN3MmI8yWf3lPpxQDQrMca+TA8Rxwk76T6vdw9TxXBI2GWgZmOWFUxGBIH9nR+
         687OPpdXe/cZneD4XPxHEQy0DQs0WNWX44ARMnTksvPjpNKC4JFgD65xcFirKUc4WZV4
         6+5Q==
X-Gm-Message-State: AFq9FYJxU3Hnav+Cu6xTMKtnvp63uwMKohYW5KcqZ5HYu3GgLDe9Wzgj
	N86ExaJNAuZ84Kv+uqJTQzVBo2sfms7+DU/a9KSRMLy5NGxzA9W6Pgi9vov2i7/1qRjU6kAZN5V
	k7Ew=
X-Gm-Gg: AYBFou09i7LA2PnoZ7+n0JoEL75b97FczsfzSODClnWof8Cocj1p9GkmvXnAQRDTL6q
	3ctSh00TKsgjyfD7mmN8XgLMxD+jtaH398DntZycr1Ioa3PEnfzVgGiuv8cz44L+D4u6cpuEeMG
	5HupAcxOKSvN6hcYc/dmtaW98GjTj9fJNNKpi/COVJlOAzK5YC0dNEAaDU90PwTto+dmtZWnVqG
	1BszL1PnC6eN0bNLcZ0NSr6sBbSPXQb2y3mfqIlyr5eOf5PhKTNdPF6YM2FuUxMKMFM/K7URINf
	Mf+Qic5LJrrL0SRjD6o9YmXM5OgvXpVI0ZpIY7R5MEBkrbwYmMdiUPdWBo5k8n9fXp8KOO0FVzE
	eW3ymWABBZjUdfDWne728rxTInWK2jCNKCMREvZ2Oo0tTY6IaixVpdD1qWVrIOD57rojf2Syy5h
	qPFW0H6Mk4VJwbCIoblZ9forC4gYRWKaCd08i9Tgim/3iTylQEBvaqyDyikBZuoK/KZb5eIGmIQ
	mTtIfj34JnI1vNW4CO1EjPkesuhIOhnGvaC4pRiFnI/4eX32sZ5VzOukjwJXrpeq++hSWJEGVDp
	QHVmDyOBAeQAVOMDBhGX3ykRtX9eNSwDvSRK/yzYqgMTbh0IGSDBmd4Dygk5Lf8jMpffvNZOh4Y
	uLew/x5O42VjkXu4=
X-Received: by 2002:a05:620a:6019:b0:939:6dea:4f1b with SMTP id af79cd13be357-94421776a20mr1272077485a.49.1793550480416;
        Sun, 01 Nov 2026 08:28:00 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm627354885a.1.2026.11.01.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:27:59 -0800 (PST)
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
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v2 0/2] net/sched: sch_teql: fix header-cloned write and retry strip
Date: Sun,  1 Nov 2026 11:27:54 -0500
Message-Id: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
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

Two pre-existing defects on the teql transmit path, both around
teql_master_xmit() -> teql_resolve().

Patch 1 makes the headroom private before the slave's header write and
pulls back only the header that slave added, so a header-cloned skb is not
corrupted and a userspace-supplied link header survives a retry.

Patch 2 moves skb->dev = slave ahead of teql_resolve() so a skb parked on
a slave's neighbour arp_queue names the device whose neighbour took it, and
restores skb->dev at the arp-queue reinjection point so the parked skb goes
back through the master and leaves with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path") by Victor Nogueira.

The pre-existing teql issues reported alongside this series are fixed
separately, not here.  In particular, the lower-qdisc drop use-after-free
(`NETDEV_TX_OK` vs `dev_xmit_complete()`) is fixed by:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

Changes v1-> v2:
- patch1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour
whose device has no header_ops, the shaper/eql/sch_teql class.
Commit message also describes how a master is freed (sashikos)

Jamal Hadi Salim (2):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.43.0
