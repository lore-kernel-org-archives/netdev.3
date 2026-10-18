Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145537E5EA
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347578; cv=none; b=AJzfDYLYBu4cqyJB3M26DJ7aXLNx4b1zvWXevvXvU5sPaZ5vhkM90SiyKxyNZjeNpAr5aKpZrQ9xKw1bufRVRedy92s0S49334PFSONWCdcKwZVf9rjbm5r46wIXB3HInnMUYbmd/vR2TljocYdEfgV+kuIi+2eIq3+P4JHS2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347578; c=relaxed/simple;
	bh=Uo8TMxjJvt5YS2w64pGiSFluNzdkhT3z1EQzzHFiwTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqB3bbMKEo21vApZGTteN2ZD7Y1JCJdYncuLl9fzwcneQon90hFP7Oupn/drxkoTcoXJFmwPM8CS4o123IlckIlR8p/gRAW2oW+7MYBWusHOkbhOsMn1OvaEP3B2zC1q9LLT3vNKslIuLozSbPtYLRNS4eCWjRdLOW4St+lCVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvomS0I5; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvomS0I5"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso2590571eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792347576; x=1792952376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pOhZ8vlHa8GKi8WqoQn03LaJCmXILoUp0trSi9o2l0=;
        b=nvomS0I5h5vzYs3Jg472CotDLxWjume8l+xJZ6iG5chaatN1NBfioitGrMgzljSqvO
         ECgiVgr6vxmCIyzJ6/7f7BZQE6lBwiBng0L0o0DB/DaMOZKvU4XDDMHRmQ64eFfdcaFl
         mE38S9N3cs1jOfMmTUCn0NEPs0mT2OUEr3b+FzRPpOPX1H8XYeT89lFcceosiyhd6kpu
         Ymsi+uPN2Fd2IDAkVTN737w7IBl2bheavK5jwCpu6O+5v9MU58xne9KmM77zyvyQ/pwO
         i0GrRbzVUnbfUq4KBmmqxODc8oHpJyneBsJ2BtLrVNNU1k2h2QaIpXlWvOdF3r1F32hu
         c1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792347576; x=1792952376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pOhZ8vlHa8GKi8WqoQn03LaJCmXILoUp0trSi9o2l0=;
        b=WiJosEFtCJeKXoTtTa+qiz21vHxptR1xtLzVzXfGmS9/WlSBue84zvswjO2+Cyxw1J
         d3v15kS0t0DQU9ga9mxqmHyHohLzXPIwiFebT8phvAzT7YYavD75z2E84vyL+LaiSZOE
         p+zmvOuQ3haegApRHEM3kK4+mCINEFxkM5JJfRMbEe540SdOtAT8xpW5wqGpozVTftfZ
         in/Qc6HUIBuwZPQ61iMKGE0a1W+IXKNbd6Ixq9ff1MuCozDoNKNGEuaKw51DqkweAcH2
         N1JuoeB8+huuclbB80VP0/a1wh0P8YK5OfIjTB6GPzsFyGc0ZgsO4vaJIQhizacJiz1+
         tuDg==
X-Gm-Message-State: AFq9FYJnm34UVvpbP0XQf6sFF4NabZqDi4+UMQKdV10GcPCQMlVn/5kp
	JeHardRf3jlelosBzgLq1q/WU9yTNTXYQAhKzqxftpwLG06EHVS0umkG1fwAAQ==
X-Gm-Gg: AYBFou3cT614976sYTNa0RLDk7NjD749wo39rgRjFXBiErFzXLdW0vCvws0/lFbct5A
	nx7fIkAcbqCQWoSVWenqIuh3niHYnYc4+1kDm2IvJcXvF+cuO7TOQoS13guAd3B9wufKRopiGPj
	ysZK+APUf2ItnVp5j/UltS8Mk6U641RqEOcCoBH2riU7rVfjZBfo9qTCM9lGqunA5+e39n6d1y1
	4FRuuEQ0Zl2b12EVasCLJsJPCpSk2fDr3PdDa4U3bSNxUvgiWj4aKJHVpzbw5AdngEPIEzKeaYz
	IBKPZI2IfBfDquOksHfLS9RejRSiLe5ModQ4+FkiDwmMg+Cln+K4N68h3Jx2FfG5wlM+leQJq/o
	7LZGofl0k36U5luBZars/+DDo9QUoQQOZYMOHa/50tBpfSjWbfYQ/ATojoS6/m+6WqppmYm1Jo9
	BuRyCbhb6/KEkRe7+B5DEzf4EGm+JZGZW7/PIWltnEfvv9PueLF9ZgGMCH1EsEhhYtQGfovOBSG
	Ow5doz8rIqi+KBu0/FEVZINdSycUQ==
X-Received: by 2002:a05:701b:4587:b0:17d:961d:7db0 with SMTP id a92af1059eb24-18512e254fbmr8061379c88.28.1792347575910;
        Sun, 18 Oct 2026 11:19:35 -0700 (PDT)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([49.36.88.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm28723388c88.6.2026.10.18.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 11:19:35 -0700 (PDT)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] ss: document -K requirements in man page
Date: Sun, 18 Oct 2026 18:19:17 +0000
Message-ID: <20261018181917.2440-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -K/--kill option uses SOCK_DESTROY, which the kernel only provides
when built with CONFIG_INET_DIAG_DESTROY=y (default n). Closing a
socket also requires CAP_NET_ADMIN. The man page mentions neither.

Without CONFIG_INET_DIAG_DESTROY, the kernel answers every SOCK_DESTROY
request with EOPNOTSUPP. ss treats that the same as a single socket
that cannot be closed and skips it silently, so nothing is closed, no
error is printed and ss exits with status 0. For example, on a WSL2
kernel (6.6.114.1-microsoft-standard-WSL2), running as root:

  # ss -tan '( sport = :52616 or dport = :52616 )'
  State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
  FIN-WAIT-2 0      0          127.0.0.1:52616    127.0.0.1:58995
  CLOSE-WAIT 1      0          127.0.0.1:58995    127.0.0.1:52616
  # ss --kill -tan sport = :52616
  State Recv-Q Send-Q Local Address:Port Peer Address:Port
  # echo $?
  0
  # ss -tan '( sport = :52616 or dport = :52616 )'
  State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
  FIN-WAIT-2 0      0          127.0.0.1:52616    127.0.0.1:58995
  CLOSE-WAIT 1      0          127.0.0.1:58995    127.0.0.1:52616

With the same kernel rebuilt with CONFIG_INET_DIAG_DESTROY=y, the same
--kill command closes the matching socket when run as root, and fails
with "SOCK_DESTROY answers: Operation not permitted" without
CAP_NET_ADMIN.

Making ss report this was discussed in 2016 [1] without agreement,
since the kernel also returns EOPNOTSUPP for individual sockets that
cannot be closed (e.g. some UDP or TIME_WAIT sockets on older kernels),
and per-socket errors would be noisy on correctly configured systems.
This patch does not change behaviour; it only documents both
requirements and the silent case, so users can tell why -K had no
effect.

Link: https://lore.kernel.org/netdev/1463442791-2399-2-git-send-email-dsa@cumulusnetworks.com/ [1]
Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>
---
 man/man8/ss.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 3871612d..4be0a8e2 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -313,6 +313,11 @@ Show internal tipc socket information.
 Attempts to forcibly close sockets. This option displays sockets that are
 successfully closed and silently skips sockets that the kernel does not support
 closing. It supports IPv4 and IPv6 sockets only.
+Closing sockets requires the
+.B CAP_NET_ADMIN
+capability and a kernel built with CONFIG_INET_DIAG_DESTROY=y.
+If the kernel lacks this support, no sockets are closed and no error
+is reported.
 .TP
 .B \-s, \-\-summary
 Print summary statistics. This option does not parse socket lists obtaining
-- 
2.43.0

