Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936091AAE17
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834068; cv=none; b=bYqFM05NtBI/IZc2NB8UMNYqa3pxMDuVZUZHb7jaKLSZctSGh/iuGvL1wKUajYjMpuzQ0AEE7/zyU3IiYe/7AGQ0ibptTZryiv9ugdic0tfzHgpjuTnDlfBZVmCEBqSpsmz3cKTEMtLYARBN6MHmWErdQy13M6ShpxiZL0giYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834068; c=relaxed/simple;
	bh=C0712y9v+3Cnwu+fzKHEe+5eb6C88dqmH0oQugUbpT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3Oz40cOVvVvUOS7k2Ibh8+Iiy7KrGLjL2+Mk6LRt6hCrSxLageduDtPZfQGz+IiLYs75T5pobRojhHTYkZhQr52iFtuZycqifUSgTKOAop68PuMSnKwFOo5l5TmXdM+DzLss0ln/hQGZSFfH0piwIYe5Bb0VlY5fNUZQuaCcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQZ+GzIi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQZ+GzIi"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84eb072307dso355251b3a.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785834067; x=1786438867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=nQZ+GzIiXL/jZF6WMNUPzVKlyAAEtNZN4Laj49AN6olWefgWC8fEV3f4AJOxpehBRj
         wBmQ8hvSp5LaIZzu7odBhxjS97zJMm5WbOtcqU2OEoezkbGucZ6QLPmeo4JCAq/jvZst
         XOK4I742F16is1I2bmzUpWTMcZz22/QiBIn3yZjmUB4zrEUsdp0lno/DQgy8IcHdRrvh
         AcM9avYZ+OEpjO71TfsHpTBlto+w5hwb1T4/dFf1G4zjOCf9C7NuzxoKdQXus2yu9kOW
         If1Ys6B+MxLug3HN5pUoM1XYAhZGXesAOjxAr3OeWVM3xEsRaQJ5qsRVabvlVv3lcL0+
         /Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834067; x=1786438867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=ZJMpoPIdWjnW4UbgBhyNArzRT+voaEBGnAOeEmVE2yhGSM7EQsVbNUQVsOZ4cQPBTR
         54OCKxiTw7I+qCGWbIdUZCvUk+5qEW3dpBfVPHbZRurU1J4da1x5j5nqBPZrEeiraLO0
         5bqu9NrM2Tmi/B99ahNvoDDFMQVkCIOTzvSDF43ZsPkbUakvsdcmbcul1V/3pzuqwL4I
         wjCaUETcayq43YEbV0hPUdOcVSf71dFfRmZAIqm59oKMYrn2UQ0y5zAk426L7NgOa8dm
         k2r2n23sBuiK+VumACaEkmYHr11blDFs3ahjLbyvKu8TY3PZWeHZus6X1PEh/Jn4NAxt
         sfzg==
X-Gm-Message-State: AOJu0YyaayIB8lG1w2J3wOzRIU+M7AoxHc8aucOzmmBk9lk0Pk1bWI3O
	5xPNkD0XAInZmR3l36a6WyNKwiF7IuH9210z2/a1m0Uutfb6QMLQe021pNVdUuJk
X-Gm-Gg: AR+sD12x93IDxRsgjoK6tBZUSJqHK2xM+RjppKH601s0j96SHXJlA13XFWjtxQWFXVo
	XrL0JdiJEG50TEPoFuleb73zyHHSRG+Dz5wfubmgHuDgBBqGtpBwmVfdSphnTOREoX0IHjeu7Pb
	jYKTMzTd4i2pLVMVbwrr7HR/tIKch5i33Qcby9D6CF/ARkWdX0dx47FY4G/4cKfDOqo1tgKudH5
	UBPTOM66PWa59O5ZGWBXqFLVusUv0icFt+1esBDfr7dFeWy7BP9Ste85tzJYXvV4JjVJSbd24vu
	Lp4YHWht+k3Hr4K2Vx/N+nr2fTD645DWpVZXS2ywZ7fYSMb6ounIZFJF0geasS6Vtrj2GsBtrEA
	4maRAbn4emxuU4LZhQ2LiYZG2DsIUs70ViP2DzzJwL4hijpxOoQqdN31/eT9n3G09x8rxqRVySo
	t94Se4SI+Y5OBEqsGwqzsOw/sNbAJMzbiRZEWyMYb9eOFvfS7Qu6GDk+OdzJlFTMhsweypzZ77R
	YqnqoBR5q3EfmqE1guI75Ve19N8QyMiI4PDMO6pkTBm1uwcTIY=
X-Received: by 2002:a05:6a00:bc7:b0:84e:b5a9:ca3b with SMTP id d2e1a72fcca58-84ee4587f4emr12275640b3a.0.1785834066642;
        Tue, 04 Aug 2026 02:01:06 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm4813032b3a.41.2026.08.04.02.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:01:06 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 0/3] net: fix hard_header_len races in packet send paths
Date: Tue,  4 Aug 2026 17:00:13 +0800
Message-ID: <20260804090016.33353-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

The packet socket TX paths read dev->hard_header_len independently for
skb allocation and header construction. Concurrent netdevice
reconfiguration (e.g. bonding device type changes) can change this value
in between, leading to mismatched headroom and copy length, and in the
SOCK_RAW case to out-of-bounds writes.

Patch 1 removes the CAP_SYS_RAWIO zero-padding branch in
dev_validate_header(). That branch sizes a memset against the live
dev->hard_header_len while operating on an skb whose headroom was
allocated from an earlier hard_header_len read, so a concurrent increase
can write past the reserved buffer. Removing it first keeps the later
snapshot fixes bisect-safe: they do not replace an earlier skb_under_panic
with a silent overwrite.

Patches 2 and 3 snapshot hard_header_len once per send and use it
consistently for allocation and construction, in the non-ring and TX_RING
paths respectively. The separate SOCK_DGRAM consistency problem between
hard_header_len and header_ops->create remains out of scope, as noted in
the commit messages.

v5 -> v6:
- Fix Signed-off-by to use full name (DCO).
- Add patch 1: remove CAP_SYS_RAWIO zero-padding in dev_validate_header,
  before the snapshot fixes for per-commit safety. Suggested by Willem de
  Bruijn.
- Add Reviewed-by from Willem de Bruijn to the TX_RING patch (given on v5).

v5: https://lore.kernel.org/netdev/20260730082925.93759-1-q.h.hack.winter@gmail.com/

Qihang Tang (3):
  net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h | 11 ++++------
 net/packet/af_packet.c    | 45 +++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.50.1 (Apple Git-155)
