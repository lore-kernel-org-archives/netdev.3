Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91F473C60
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809990; cv=none; b=erOH3RALSk9ER4VGgVagnKfkfYGiBWoTpFzLc2UA9bXuF+FCYO8oOpzxkim1fX9h7ESBGiXwryrGwNd82MJPbuiPJX79FcvL2Es7NApDIL7yWN4BumPmPuYu0KBgOh7vxZESbxoxGCthknD960VQDIlcl82LX3gBnFGuyhlhMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809990; c=relaxed/simple;
	bh=Sjs/T35GDSK2mLpXvd+0a+mLJsbh1ZkWIn8eH7SnHG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQ4JmGDcA5N7A26sqLYZEsBkLJ3EKAZBsnT5mXdmHHCztzb+f1louYBvzAulUN5y7jWqtp/mvRkl5djPRWODX5ADiwrkcjNf6/+y+vSeqe8efYrTWaPiOlNkhslvsyJYQN/MLtNQljtH7YIoQbgEbNPEypEHJLDMA3VVNyOLa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Oq2JHkXJ; arc=none smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Oq2JHkXJ"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-33baa8eb238so1285686eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791809988; x=1792414788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q7B4DSPMgfSFvLLxNvbACWp9nlscmrDCD1XJDKGbIJ0=;
        b=Oq2JHkXJonoGb1cFMKdcCXJZvckBc7AzVdgC6A5mz+mh9rkobpCzOCZrz38nxxsY0A
         Cez/ZJdfUSwqwmAN+33dKKQ7AAwz2YhW8FIV4xg9oSk/9QujrWeajl3TPK8HB8/oU57t
         /m2L1ZpoueDKrCKsHMDQ6nSdwAzJRMn27t9noyGIsVC3dlPUGis7Z4R7AgSfPp9CsBxt
         EEQxBVcbWhe+agXFs4GRJdHDwVbvoc1if+1PGOnF1hTc3O8o8bQBlRcnVMyHstWfQCOH
         pded7fCxzUcLZHOh0Ldba2y3Pjd9AB4Kybxd+mHcR3VHNEhEgPkwsLr+v7QBJjt3aq/T
         Jgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809988; x=1792414788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7B4DSPMgfSFvLLxNvbACWp9nlscmrDCD1XJDKGbIJ0=;
        b=aj96HJSAFwQa6FD622suF/R5gj1n4bMmrcHB5Lu1sGDbj0me7E4mbMZBpwm0xlqNy7
         9DdwH/V/eMpFlYcq/gOYjhGMMU4ubOQ6XD/THZgn1oQvvcdgxtGCLZLRfDdOoM4xhPKZ
         FzLp/HKbQwKBrGZ1TThb5X34YK5XcS+Qm9T667zBt4k255CiSJDSduZwmdmGh4awb8EX
         iuWjUDYwe44CfCMVxk37plDplh1xKn2CO+b8zmKwKdgv32oQa/cqeuKZlD6p5Zo2X1M1
         b7HOatz8laOq6cS+qtPkafu2jy998/09yFAiSPYUFXLjeGm+TxS2u+8p4/N2a2HQVoYe
         +RbA==
X-Gm-Message-State: AFq9FYLJALZt7f3ji9JvBTeAuK6Wv6OpUFaVDnBCjPMDEtwmoVSJ291+
	btcFpq1CwbrTu3lIZNpEeY+xdfnXaio/iYG83pxJ502coQzYn/yizSKCqWMQiDpj7wQ=
X-Gm-Gg: AYBFou2VVuQDqNZjYbvDLhp3pphL4D5UuH+A1+/7QQwlMe/t8FV2ERmhOSLzQO+l+Wa
	TK5GQ/+dJGEzmhesVP6RbVpdlUwGKdx8MdIhpPR0fw0FWR2dQkf9SkKfsVkpp8yeUg5Av2pph9c
	qYVM6IRH9cekUbcxc2YY36KKrYX4E/yyxdjqNoaL0FlcXrPXH6+e0h9TQAp2AS+gXeH/uxqCY4F
	juEzeCIOvd7ecxB6+/slFgOGnImo7dvXV6HPO7tbNbjcThqC6lxIxZb5G719e9apReMmffGidGs
	IySzN1C/pBV1ozzhhYqgQECsSlOSNrkIoEEsX5EPo9nxycDdY6AYaVJlc0Q/DW2dwKm1eCXKaU6
	ksE0qqEL4XAT+BMkAHx+WmtPuERfHMU+GCPM3TuUMMpYu/nNHcQ8yMjtIyFuGy1wx7WmOoHF6EC
	pnWzlU8OBt8QqTmdEB3Iz7fonKwbCmU7zh9nQBiz4NpPMRl1PmJsn9jQR+GX11gQbVaLhtX2kkD
	7TN69xOjOvWEc5kQZnV/F1UoZBRq5CE54NYFbfh19cPlZfy7ZtlfxC8b66rBA6n
X-Received: by 2002:a05:7300:f0ca:b0:359:a6ed:41ab with SMTP id 5a478bee46e88-359a6ed547amr6459544eec.36.1791809988031;
        Mon, 12 Oct 2026 05:59:48 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm35348067eec.21.2026.10.12.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:59:47 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 0/6] amt: relay tunnel lifetime, validation and request-path hardening
Date: Mon, 12 Oct 2026 12:59:37 +0000
Message-ID: <20261012125943.558629-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Six fixes to the AMT relay data and control paths, found while adding an
IPv6 outer transport (that feature follows for net-next, rebased on this).
All are independent of the IPv6 work and belong in net with stable in mind.

1/6 is the most serious: a Membership Update can re-arm the gc timer of a
tunnel amt_tunnel_expire() is already freeing, firing a delayed_work in
freed memory.  2/6 and 3/6 close two input-validation holes (a gateway
Query/Data from 0.0.0.0 before a relay is learned; a 16-byte IPv6 literal
accepted into an IPv4 netlink attribute).  4/6-6/6 harden the relay's
tunnel table: key it on the (address, port) endpoint RFC 7450 defines,
surface silently-dropped pre-Query reports, and stop allocating tunnel
state for unauthenticated (spoofable) Requests, which closes a table-
exhaustion / ICMP-reflector / session-desync primitive and moves the
max_tunnels bound onto verified gateways.

Each patch carries a Fixes: tag.  Verified W=1 clean and with a
KASAN + lockdep + PROVE_RCU boot of the amt selftests, no splat, and
of amt.sh with max_tunnels 1, which keeps the tunnel table full while
the gateway keeps sending Requests.

v3:
- Add 1/6-3/6, found in review of v2 and of the net-next IPv6
  series [1]: the gc_wq re-arm use-after-free, and the IPv4 halves of
  two input-validation bugs.  The IPv6 series will be rebased on this.
- 4/6: do not count the invalid-MAC drop in rx_dropped; amt_rcv()
  already counts it.
- 5/6: commit message: the Query supplies the response MAC that the
  Update echoes, not the nonce.
- 6/6: keep three secrets so a response MAC outlives the advertised
  QQIC; cap the tunnels one source can hold in the locked re-check (a
  fixed limit, no new UAPI); when the table is full, answer a gateway
  that holds no tunnel with ICMP and no Query, so it rediscovers; seed
  the secret before the socket is created; refresh last_seen rather
  than re-arming gc_wq (see 1/6).
v2: https://lore.kernel.org/netdev/20261009201455.1904698-1-omar@blockcast.net/
v1: https://lore.kernel.org/netdev/20261008003606.3666617-1-omar@blockcast.net/

[1] https://lore.kernel.org/netdev/20261009122426.551178-1-omar@blockcast.net/

Omar Ramadan (6):
  amt: fix use-after-free when a Membership Update re-arms a freed tunnel
  amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
  amt: reject an IPv6 address passed in an IPv4 address attribute
  amt: key relay tunnel state on the (address, port) endpoint, not the address
  amt: make pre-query report drops visible
  amt: do not create tunnel state for unauthenticated Requests
