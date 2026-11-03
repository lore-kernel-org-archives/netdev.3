Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709561;
	b=ysMRbYDNJwc6NGLOUnClmuJmaj1F+8o0x+zPLvvNjX8cVwufc3wz20Vt4Ntpl65T0SR8
	 GlBNn2Hkk/CcZ4O1e2puLsr+uAgwvgktOP16eCy+ly5bvbdAvLPWujZlI2UQNhH5GxUSe
	 VzgnoSRpQkTth4H29Xvu8PgfSciyTDANYdVbcq9u0qHHGoq/MPpvXxDR9NRjVTZjBPOb4
	 SxTurmfH/7oCSPOSivSgcjdYp7ezkdYVhPG/gP06AAwY5FcWyWWDz8hWngg6aYgYeY5HS
	 HmszBi0mmW/XULOXHjWzCsORsGSMX7XGIGeRckHvtkUzJepc0HNMppCmFKn+gPTvwTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qfhgYc9ZnyDR0V+JU+Iip26bBIuO5bnj/fnxRw088+Y=;
	b=nUVbOJKtQ9M/lm/KaOkurYomqn1rsR5IAPVAhjSv3xL0dEhnZKG1wJWcI7O0we4PDdUw
	 VM3cQZohql7agTZMIuD/27tcPFv3a4RzreVjH9T6OofRtszF7qbJBOD8zwkgVOk01yoVT
	 sAiJZpCjJWqZLnJ1glAPJ+3ASZ4CZ202lqaysFqWAWad1awG+5QGMozET1ow+Ua267Y94
	 448is4UoCH0ZiJVof6oVZZALri4e8Qiq9KxXZHBvzj7kx3ZQri4AFZBlZmDAQYFbYSJWo
	 /tzjHteCPbGDdoCBDZxrOolizRT/urTPs+liAD3Yu8dc3iHEP0+nbJMIb4+2bc5Xq2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=A6+dP1o7;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF3606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCF3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=A6+dP1o7
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b300713befso2456387b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793709560; x=1794314360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qfhgYc9ZnyDR0V+JU+Iip26bBIuO5bnj/fnxRw088+Y=;
        b=A6+dP1o7LKHX53X7NYKDXsomqh+efBMs3YZTGz135RsYdqoktqOF1UJ71Yy511EOtZ
         VKjD9LYNPt2mpq0+eEnzPrORUfJaB3i1HDakOSM1HFdu3r2bagSYYjR+VlZa0VXBlPoj
         SWxazgzOYjXPCYnPPDVFqjstVySEoIrn1pXJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709560; x=1794314360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qfhgYc9ZnyDR0V+JU+Iip26bBIuO5bnj/fnxRw088+Y=;
        b=tyfM7O5UtHRDJiaRpJLq3bWmU2DYEf+zyhCyEbUEPH79lAVGB1AikelUcxkFV6nrd2
         h4FsLV3sarLa8RDCy7AxVcIqW9L/7GVddv+QlOQpDY+k5C3GxsHHoUcvM3rwngk1nUle
         GFHxj09OZhmVd1eiq2m4Bc6766MFHOUIcsW6IO7MxLnuRp9JAfFcRBmHV2pbcLOEo0ki
         Sv4I/phzGYtLU3rqHs09+019wdCRLeZDlUPMU+cAJyRXPwvuQvAicTzZYCIDjxgV/ZwT
         b1CfJONZwfIkr19TpuzLVd1oQnEuZ4LJBws63D54AkyQPDO8y2GSUChJv+uN9FcZm/nO
         LXAA==
X-Gm-Message-State: APuU4Z/naW+29yKCAhDiLucYlBRu4q3NofCMu5wJ//FmVMqEXT0fe+/c
	Hy/VcrhwUtsecRbqnUAVHCa21XmWrWdhzZ0ehxVH7b3qBcF0FjMqR0T0VkuEysaZqXEr3+Oexam
	g4PA=
X-Gm-Gg: AYBFou1gC5LcXlgl9O+fHkOHqnyDWN3Le2dRYSMJdKhrkM2EQfLVD3TFWMwy+B4Y+PJ
	ZEjwKuD3qgVwpNFvGhfcOAWqwv4x5a6ipcPLodwNAMwn4QH2U/zV9RTzE9a1ZXIWWsftSonrDPJ
	m7pbmsOuOfE7IThJoDEfIC+foBfNQnOAWmcwR3QlDFtcfxZwaw7VyydS18GzPErMTv805X6L6ej
	3gng/oPmn2T1Wi2JMBjS+8L99+bb4f2jfMl8IlPD9joZKBPLtgZT/CdoB7doLxjFO0wXHvvjZb8
	Z7qFQvPyUlJWAbF3xtv/qtrGfND2YOcbyAI1PpTDqVNESFDynMu3QFjGpsUsoAawGX8Zd20q4hP
	ufodYGZbV56ucvAxQezekV2pHQwHRYmMeaaE1sqQVU1j7aFVDPJONHqRATiTtQ/J9rNbxEowT/A
	w0PEPtKEmRJB0VUumEqXkveGfFMbEl76Wsad3ZI6k8Z/PI1K3MXxPMCiLQ8SvsonJe6hFkV+pZp
	5DbqNLo/SUyawvwMcONnybotYoZwk6klCI+viMZ5v4PJ6gKMGSdCsVZHobw2J4PMrz0/JfJzCmz
	mSeDHQ1O5RRAmEYrqz1N4s62zyYyUB8jMRyF9P2qP2UnHiI183+nP/gj7RRmHQMcXNysKQLGEK3
	JtB0SBtKd8eVFZG0=
X-Received: by 2002:a05:690c:60c1:b0:8ab:3918:33d9 with SMTP id 00721157ae682-8b2b67ae0a0mr95022047b3.61.1793709559759;
        Tue, 03 Nov 2026 04:39:19 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm72011827b3.33.2026.11.03.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:39:19 -0800 (PST)
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
Subject: [PATCH net v3 0/2] net/sched: sch_teql: fix header-cloned write and retry strip
Date: Tue,  3 Nov 2026 07:39:14 -0500
Message-Id: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
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
Link: https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

Changes v2 -> v3:
- patch 1, no code changes.
- patch 2 corrects the conditions to recreate the bug: reaching a freed
  master needs sch_teql built as a module, the slave qdisc removed and the
  module unloaded while the skb still waits.  The message now says which
  part of it reproduces without the unload, and names the neighbour failure
  path that drains the same parked skb.  Considered comments from
  Sashiko (nipa).

Changes v1 -> v2:
- patch 1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour whose
  device has no header_ops, the shaper/eql/sch_teql class.  Commit message
  also describes how a master is freed.  Considered comments from
  Sashiko (nipa) and Sashiko (gemini).

Jamal Hadi Salim (2):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.43.0
