Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CED3612FE;
	Thu, 18 Jun 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768173; cv=none; b=oskYb8vjGqDFZdIuOmpdzCl3gJL+P6bTwQwBZ4OOW3RHGpxC0XrPAk6HX1kYAm9uZT0n7mNUQBtKcafJOD7jUZ3BaURab/JttNWxOtEpZhKWDNqnIneGPQJ3EzXpa/w9iqrelXbEuYItxopIIVzplm+1jEQ331bGIBh3yil7FMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768173; c=relaxed/simple;
	bh=sHB41GVX7qXOkmY/3+/r+iq81cKdiyrzEmMlJl8psEY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NV1LO0J8y9CI2T8WwZvks7sD0eBDVfK9d2p9TnolSUg4zrMp+RQDioMwcOy/v3AP5dQ8pPoL/YUDkFEZ72hgIeNaW1Cp/4DfUX3+9SCob65dKzOglrEHFWSxNhuF42NhrcFQSktK7jotIpinbNRbGWHGeLHRULz05gJ09qNhxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=SJwrpGYQ; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="SJwrpGYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:To:From:Subject:
	Content-Type; bh=CO+rCk3t3Yj2gC/Q8TQOyvQbyN2ohfjyv6cAINQX8+8=;
	b=SJwrpGYQHDRk5dTkCaYalDPMOxvP53rJb5pCOFMHs+FtgAQjsnpXxXl80rovR5
	8dfOTwMu9BfIPC2LWLoRgJS/Lp4EZn5EbiS2lBYEUjdh1W8DR/C7TCeeTzuGn59w
	YccxuKP3r+O5NKfabHcP2zGJk93qcL4vQZl+bcJyz3e+I=
Received: from [100.70.221.233] (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPA id M88vCgBHtxESnjNqjhhvAg--.26487S2;
	Thu, 18 Jun 2026 15:28:18 +0800 (CST)
Message-ID: <c953e09f-9bd5-43c8-b2e4-7305bb435229@yeah.net>
Date: Thu, 18 Jun 2026 15:28:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, kuniyu@google.com, willemb@google.com,
 linux-kernel@vger.kernel.org
From: xietangxin <xietangxin@yeah.net>
Subject: [BUG REPORT] KCSAN: data-race in __ip6_datagram_connect /
 udpv6_sendmsg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:M88vCgBHtxESnjNqjhhvAg--.26487S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4kWF47CFyDXrWrZw17Awb_yoW5Gr1xp3
	yYyrW5Cr48Jr93ZFyfAa17JFn5ZwsYy3ZxKan2qryYkr4jqr15tF15tr95CFn5trsrGrW7
	t3Z8Cay2yryDGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIhMTR2oznhPdfwAA3T

Hi all,

We detected a data-race with syzkaller on master branch (commit 95e56f0f293e).

The data-race occurs on `sk->sk_v6_daddr`. When a UDP socket is already in
the ESTABLISHED state, calling sendmsg() with read `sk->sk_v6_daddr`.
Concurrently, another thread call connect() on the same UDP socket to update
the remote address, which writes to `sk->sk_v6_daddr`.

Should we implement READ_ONCE/WRITE_ONCE helpers for `sk->sk_v6_daddr`
to prevent torn reads? Or acquire the socket lock inside udpv6_sendmsg()
to serialize with connect()?

# KCSAN Report
BUG: KCSAN: data-race in __ip6_datagram_connect / udpv6_sendmsg
read to 0xffff0000084dbc38 of 8 bytes by task 16916 on cpu 2:
 udpv6_sendmsg+0x1264/0x1a20 (/include/net/ipv6.h:593 net/ipv6/udp.c:1579)
 inet6_sendmsg+0x80/0xc0
 __sock_sendmsg+0xb0/0x138
 ____sys_sendmsg+0x41c/0x4f8
 ___sys_sendmsg+0xcc/0x150
 __sys_sendmsg+0xe8/0x190
 __arm64_sys_sendmsg+0x58/0x78
 invoke_syscall+0x84/0x218
 el0_svc_common.constprop.0+0x1a4/0x1f8
 do_el0_svc+0x3c/0x58
 el0_svc+0x38/0x100
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x190/0x198

write to 0xffff0000084dbc38 of 16 bytes by task 16901 on cpu 1:
 __ip6_datagram_connect+0x348/0x888 (/net/ipv6/datagram.c:247)
 udpv6_connect+0x48/0x178
 inet_dgram_connect+0xe0/0x1e0
 __sys_connect_file+0xd4/0x128
 __sys_connect+0xf0/0x130
 __arm64_sys_connect+0x54/0x78
 invoke_syscall+0x84/0x218
 el0_svc_common.constprop.0+0x1a4/0x1f8
 do_el0_svc+0x3c/0x58
 el0_svc+0x38/0x100
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x190/0x198

# Syzkaller Reproducer
r0 = bpf$PROG_LOAD(0x5, &(0x7f00000001c0)={0x6, 0x4, &(0x7f0000000100)=ANY=[@ANYBLOB="18000000000000000000000000000000070000000200000095"], &(0x7f0000000040)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x9, '\x00', 0x0, @xdp=0x25, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3}, 0x94)
bpf$BPF_PROG_TEST_RUN(0xa, &(0x7f00000002c0)={r0, 0x0, 0xe, 0x0, &(0x7f00000005c0)="d9d96e34a80e31f03a049a9e0000", 0x0, 0xb4, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x39}, 0x50) (async, rerun: 32)
r1 = socket$inet6(0xa, 0x2, 0x0) (rerun: 32)
connect$inet6(r1, &(0x7f0000000040)={0xa, 0x4e23, 0x100200a, @loopback, 0x7f}, 0x1c) (async, rerun: 32)
sendmsg$inet6(r1, &(0x7f00000002c0)={&(0x7f0000000140)={0xa, 0x4e22, 0x4, @remote, 0x2}, 0x1c, 0x0}, 0x4000001) (rerun: 32)
-- 
Best regards,
Tangxin Xie

