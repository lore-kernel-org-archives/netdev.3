Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28794BB26B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812013; cv=none; b=UIz6tEupINCLlxYCn/NeABXW6gMj6vW3PB0CiVjvP8dpRrtOwTmNDb+Ozanm9RFaE3RZvCpd8HiZpJVFrKglCK0frlTULKRfEtq3t6Lk7XunkxiFiDr0t1UABTJz0G3qF4cg3GAaztDpTFUlUi4F7lkHCLm8+xfj8hjyqZWWh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812013; c=relaxed/simple;
	bh=lLXjXwxHMtrbCWdJPpOO3fzrxcILc2eoAEIijYWPvtc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RyEgV/R9RQyy0Yb2tSHcs7LCeejcLAZgTwyhBdbgDJNDT/gYyDvFOhCPZyEzehI6UZOFkmc0uZ5I7WjvIPf3EKt8/FnwriRteULZgsQtCruz6QAzlUo8BOmfgFG9tA8kuk/RmJKuIZ4Sxe56qOwYRyETLy/SkqK9CPo+KZmmz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivi+DTVm; arc=none smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivi+DTVm"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4f252fb8c7aso379200b6e.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790812010; x=1791416810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OLk3KH4DpFFvqjf9rs8CgETJ9QoCI212MG+sEX/sM/s=;
        b=ivi+DTVmQcZ/qIQjY0lkvqo4nCX3TF4NYh5d0Y/w8r72mCDgG1pEX2cQTjuZcZLqPe
         9td5kLAgQXj4n7trRQd1CIkWU0858HegCjynr3Szyu/XcTEIxUkYVJNlbSbtOBWSK+EF
         joTrYP8KPrzKOuRo2z1qmNktvjXhAe0/Ff8lCkkVpClKvqvX/LiXbeSOM5/LxlIrHF07
         Skq1TdCCmByOB9CbpfumZPnkpl9MgdwpCvpies0XDE0t4q9q8LgE9it/uEscmF63cRfk
         R0fqFKGFfuicEKOPgIskbqjL3Svf3ejN6mlmFzJBfvayXbhJippG6dfZp4R2gVsSAJ14
         MfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790812010; x=1791416810;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OLk3KH4DpFFvqjf9rs8CgETJ9QoCI212MG+sEX/sM/s=;
        b=j7BXeh7/zatAUuWQHjmVLOZ01jERZEM32pzXQF6t+VPYPZVAnIYvVx1nxD5U9HbQDX
         oy07Fh3cEK0uea38qPECQJOC930vI0hb1VJTdsddYHjwrH0Bhyh/nM1N+t7+9SowBccu
         X8pQJSH6vqfE/zP8u4k4eqV6Mn3YRCrfUdauUXltjpjzePcR9NtWT1uuBQKMLqsRjlFY
         mEYB/uqbTfmJN8TaDxSq4wIxG/xcTt5E2zRLoX3wpRqtq0K8cuolqtn9YND9GYANIqT5
         a4JqWyspAtAscbbd4DffYm98y5fudtdtNxsTuj6MD+m8YWfLCoT3H8IhvLkSMQQKV3u3
         WJ8w==
X-Gm-Message-State: AFuF++lS0fhrEgdoqBQc6PdFvnc4x8phQiLYHJFCylNJw7UevB1mMUnK
	Puw1ibafaN8XcDoPY//P6ExtXUTl5OgsBMCE9MI1CWKT/tauYgCCDBG6
X-Gm-Gg: AYBFou2mnPqVxcbV5Ky6aHuckPqi+HMQLoFMuxLvLv7gxb3LwSxQxasxgD+bmAzBq2y
	WTGfCtqn/MkQlubFV/6jXxqJhM7rti1JbxtytkskS9ueZ2mOJ+F6IU8WRyedZENMy+zcNoqOuqF
	4xooftunRVOxzWSrxSGRP7DfuSpDb0AKUpnna9nc1zIdFvf6IyKJFqtCcHqgqjz2cPsKncQ7EA/
	kH2EKesrOhWnUP4oTtsVH99UBHHvCL6hbFwmFhCgBWPA3JlnXU+toMWpvLfp/UYin4uv9zp0hfw
	A8k29xQ75KbUUxpRP7ZZlswpTRqfJWn4hv2XSv+VmeI3NGJ87CVUEOLTwpxlhl9cQK5UNvsibXO
	e98hn9hZlv3i0Mt0IvVs+yDCiZUy5jlubUx7/bpYkKPPi9saVP25hC5ZJCtnAxtM1K/nnziWxYA
	i2ml9utJjd3Ky4dlgOvs5uD8DCIg0x1xZx13XgtNmNXa/FBvTIEMyCQ+YPQwmffS4mKbA=
X-Received: by 2002:a05:6808:508f:b0:4e9:3412:14ac with SMTP id 5614622812f47-4f1b87b67cbmr4118217b6e.33.1790812010444;
        Wed, 30 Sep 2026 16:46:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f349a4d217sm796949b6e.4.2026.09.30.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:46:49 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next v2 0/4] net: psp: require an established
 connection for association setup
Date: Wed, 30 Sep 2026 16:46:45 -0700
Message-Id: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWfvWoC/02NQQqDMBBFryKz7pQktUq66j2KixhHHagxJEEsk
 rs32E2Xj8d//4BIgSnCozog0MaRV1dAXSqws3ETIQ+FQQnVCC0b9NHjQCOZhEa1sql1T3qwUAY
 +0Mj7GXuBo4SO9gRdMTPHtIbP+bLJ0/+C6v4f3CQK1KPo65uQojXmOS2G31e7LtDlnL/M2dIbr
 gAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13.0

This series removes support for using PSP's assoc uapi on TCP sockets
not in established state.

The PSP uapi and connection upgrade described in psp.rst is only fleshed
out for established TCP connections. Installing PSP assoc state on a
listen socket, or closed socket ahead of connect() is possible, but not
something that results in useful outcomes.

With commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
ehash and lhash2.") in place, this series makes it impossible to have
PSP assoc state on a listen socket. It is still possible to have a
closed socket with assoc state by terminating a connection with
shutdown(), but the series then adds code to prevent subsequent calls to
connect() from succeeding. Patch two updates psp.rst to discuss what
this means for users.

The first patch converts some tests that used TCP_CLOSE sockets for
basic uapi tests with connected sockets, so that the subsequent commit
doesn't break them.

The second patch introduces the actual checks on sk->sk_state during the
rx and tx assoc handlers, as well as preventing connect() attempts when
assoc state is already present. The commit message contains my argument
for why removing these "features" is appropriate and doesn't constitute
a fix.

The third patch unwinds commit 1d2929d0850f ("net: psp: do not inherit
the Rx association on clone"), which was introduced to workaround assoc
state not being handled correctly from listen sockets.

The fourth patch has some tests for the new checks introduced.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- net: psp: require an established connection for association setup
  - reject connect() on sockets with PSP assoc state
  - drop PSP MSS overhead handling from tcp_v{4,6}_connect()
  - update psp.rst disconnect paragraph
- selftests: drv-net: psp: test that assocs require an established socket
  - drop assoc_tx_non_established test
- Link to v1: https://lore.kernel.org/r/20260925-psp-defeat-v1-0-9f0b430107aa@gmail.com

---
Daniel Zahka (4):
      selftests: drv-net: psp: swap closed for connected sockets in assoc tests
      net: psp: require an established connection for association setup
      net: psp: drop psp assoc clear in sk_clone()
      selftests: drv-net: psp: test that rx-assoc fails on closed and listen socks

 Documentation/networking/psp.rst           |  8 +++++
 net/core/sock.c                            |  2 +-
 net/ipv4/tcp_ipv4.c                        |  7 ++--
 net/ipv6/tcp_ipv6.c                        |  9 +++--
 net/psp/psp_sock.c                         | 12 +++++++
 tools/testing/selftests/drivers/net/psp.py | 56 ++++++++++++++++++++++++------
 6 files changed, 77 insertions(+), 17 deletions(-)
---
base-commit: 1631d79ae57dce2c5f88ad278307028638a8b4d9
change-id: 20260916-psp-defeat-a271649be9dc

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

