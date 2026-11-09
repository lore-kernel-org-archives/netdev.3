Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188678;
	b=sQk4dhziRdDfWbOnYVkod2DfG8tEB/588wC3kHSjXYtwoileGfZY07orYjbWP5Od9sFV
	 a/LYlAUWK5urwvpvau2+V3xKWkyGgVe92PqwatTYGJuTLGvFoM54/PgBnVE+bPTH1OFiq
	 LIhSeMnTaE4qd5ob/Fd5/Xjp2eX6cQvjoNFOgjrcLzS4ZzH1fco7QpGk0gzumV/dhQIpT
	 +Sy5qjBw4qBurBdkwI80XzzF0YFKD0YOCWIcVpfpOES7UWd+6U7nZYrPlIl2yzb+g7iqR
	 y5Nh2KubL+u+niWHbX+IOUuPhhWiuokGE8Vr/PCv8QRNTBjSxHKD+ahoNo8nlc8FYAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Jv/87TDdACczKq9hFLvV7QZnq2Emc/Ycb5t1vAWaIw8=;
	b=Jkv9Gv/lSbc7gS110Y/oYDqxLoMQ0Zpx4FCpbsDAoMxDsLJFj0EjlHEOGkz3FN8pDkxU
	 w25ZO4Sf58EeufEPHJFK4s6mb2NugRLSDzToDM2sLrbykIxVGtFHNffAjm8NCR1/b9d+d
	 hHtPkbSwFjyPRetQl0zLtoLvgNlVVfLrzJPsabZ62OvuZDZUU3XM9gGPmER42osyt3L6e
	 KE5X88hOE8JdEbe4SZOifrp6X5w0wWPFUzxtnXjhdcK/upVSSY8hXSBjXQ58Fscd9hFn5
	 qh/w4yLKZV+NT1064lPHPB4gUZo3J2OlfdSoVBXufmUcd2Ob2MetmcUOHrcOdABsooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e2sP3xbr;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA2606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23EA2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e2sP3xbr
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd3310348d2so179980a12.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794188677; x=1794793477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jv/87TDdACczKq9hFLvV7QZnq2Emc/Ycb5t1vAWaIw8=;
        b=e2sP3xbrhztPvwx9LJsplnZXUCCLM9ygQESZ89Zq5zm3sGPiMs9VOI2oHahyLr9CJz
         2LNLeoVQWVHZYFqsWdRCfUygG1PXVVE9n7gbRRiBUSondBLbcwVC8hAunbzVYvGEiDFL
         A6TfJrBFRjER/kxJOTtckeU16l7P3CFgGUpA+6TxuVqBswEwqeWlCaj4eA1B7HFDmeCp
         UFpVofxT+XlLqk3kqxl0Z2AAsrXZHemSgiM8nxR18i4sATad5yvn//DpghxIm/VQCt95
         6KXx/DLGyGxfqtEDNa0NztfI3wW0ibKnNLXasXWRBYLkPG7BowrXQBg8WnsVom/zFZo+
         os/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188677; x=1794793477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jv/87TDdACczKq9hFLvV7QZnq2Emc/Ycb5t1vAWaIw8=;
        b=22yN2BETkXLxWJB5XIjeuQ5anKQKW73N6+fQMdE1ykEap/pSUi0m5teOnoeLKxs74A
         Tx2VrT+E5ugyZGDXRVU8lkjMYXGofshc+znfg1kbX0YRRLauw3LuB4TYQab0RtXqPd4E
         fBCo6VvmU2SSUZUDa1Y7BtM2nBy2Nwlu5IbRuep4VpUdLMjZBjqRaldY6l2k67uZ319B
         Wxi7wWR8IaVRvyukyV27P0789vFMjvnrizf/0mPzJopSaq6I4GififR7uZ0ncXfooIlc
         WoU+m96+R0oE8kZqr06YlE5AhTvfLjPs8Fb3dR9r0f9nY5pLClEC5rHw3t6RuSzokLio
         rg8Q==
X-Gm-Message-State: APuU4Z+9cy4w7jB/yZAZ798OuK7XOIrDz9BDOFy5IpiYouYCLwV5vOrU
	5h1cfvrkmUX5XbE6VLKKNKF/wCBcTM20uZXg/SZsdTZIySCdcvqStqjnJ/nXsEJW4ZD2MHvKLsU
	1VD4KCO8=
X-Gm-Gg: AYBFou1bwjk8sFsuOmv9Ve6tYBlYZLfWzWTNdf7b4EE81hQL0FBpuamoS4jr54RoOpR
	H347Pv1GotNKDTQlQ8PHmsL7J17oSEhuhdYeboEPf9lgBqBiofsY7QjQeRvKQKEJbks/y7YtIFj
	2gX7kQLLnLmTFQZ5sX+Ma8jELBPD8m02MomGgezKKPx53F70x5xT2AUho/R6ztedITzxB3wKk1X
	zCCvThXqlpU24XPebGyd7gYj1miZRkE2pMSFV34cFbn4q+McA4f5jJr9h/Af2ehajqc7woL7AKi
	RR+mO1kFwU705SqulZpeZKSYa+ywK9vaFItQYJRrAdDyd4BZp/i9bKhtYKH2OMRKT3pcj05Lb1z
	ofbFq4TLu6KYBGKuNZKF1tBdMkWaZP2sI19Rc+pg76nrEh+eii5KRz2/C9NULBnlf4KeJQkVAxp
	uYJRMkr2hXojLHqhandi79K6y7mLn53Wof0hNGemIeKRu18/YbTA0qBe0eMKe61uQeaAc/9CiIb
	S20m8clv7bxgO43IzzuMcSC4n8mag/TztwSJwWH5rhnmfIYQFVT2SmjRElQNcbqPPeg3XY6rIyC
	ezF8s+u1yw2WgCCxglMMcFFo8XJaZ7fvej+AVatCqXGidhn1G4rOzzw7WqIgbbviyE2FPZQ=
X-Received: by 2002:a17:90b:1e47:b0:3ac:a6a5:5757 with SMTP id 98e67ed59e1d1-3b12d3fc296mr1794518a91.11.1794188677417;
        Sun, 08 Nov 2026 17:44:37 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm5641735a91.0.2026.11.08.17.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:44:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/5] netlink receive path hardening
Date: Sun,  8 Nov 2026 17:43:57 -0800
Message-ID: <20261109014434.115922-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Six scanner reports all landed on the same code, so they are better
fixed together than one at a time. The time() seeding was parallel
discovery: Florian reported it on netdev independently of the two
scanner findings that flagged it.

The common thread is that iproute2 trusted whatever came back from its
own socket. The sender went unchecked until after the framing checks,
and in the ss -D case until after the datagram had been written to the
dump file. The framing walk assumed every message in a datagram is
padded. Any process with CAP_NET_ADMIN over the namespace could use
that to inject events into a monitor, or to keep a dump from ever
completing.

One behavior change: paths that used to exit(1) on a short or malformed
datagram now skip it and carry on, since a datagram from a non-kernel
sender is no reason to abort.

Note: rdma monitor is not fixed by these changes. It opens its socket with a
bare mnl_socket_open(), so the connect() does not reach it.

Worth exercising:

 - ip monitor all, ip -r monitor, devlink monitor, rdma monitor.
 - ss -D dump recording, and replay with ss -F.
 - ss -E, which sets local.nl_pid = 0 and dump = 0 to match multicast
   notifications. Should be unaffected: it relies on the
   nlmsg_pid/nlmsg_seq comparison, unchanged here, and the
   nladdr.nl_pid requirement it already met is now enforced earlier in
   rtnl_recvmsg().
 - rdma stat and rdma dev, now going through mnlu_socket_recvfrom()
   and mnlu_next_seq().

Stephen Hemminger (5):
  netlink: use a counter for sequence numbers
  netlink: ignore messages not sent by the kernel
  netlink: connect sockets to the kernel
  netlink: handle unpadded last message in receive loops
  libnetlink: do not read past datagram when recording dump

 include/mnl_utils.h |   2 +
 lib/libnetlink.c    | 131 +++++++++++++++++++++-----------------------
 lib/mnl_utils.c     |  54 +++++++++++++++++-
 rdma/stat.c         |   2 +-
 rdma/utils.c        |   2 +-
 5 files changed, 117 insertions(+), 74 deletions(-)

-- 
2.53.0

