Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5638E5F9
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786823683; cv=none; b=ABN7uplak4A3ODKK1ulyMc1vD8P88xSyut+/iiM7gtyfS8h1nXkil36T2Q1aeDTOfpGnIsw+GJn5vb3G5xGSFpWWVp4R/jw3i0k92ILiTyHoa/rXAFVE5FVJzj+cEuISwNOmISp4YB/nmv4+rpIy4wbnhvvGk+eMafn46ZH3Ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786823683; c=relaxed/simple;
	bh=u46f1s8oVCiDUjL4xACrR87pxJyjxeRHplEpkJHKA64=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bUZaipKbCCbKgLZkBx4L0TpaASM3nrYlHYq+bugTsgCTXHZzcgEHcLm29eqf8Nv7yiXqtKtSHueg1sFgqlmhuYqmAZrAdYOXS1ZQT0kkbGfEJewVmXzE/6EH86bG3kbYfpCZOJHIl4TnmzuIwb3a/uZoBGqUybISMHku8GxFmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQh/80F2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQh/80F2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49987367394so1096605e9.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786823680; x=1787428480; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q58QYg1S2v4WK0xb4Moy3EhImu5h91AbAwacaZzaIHo=;
        b=YQh/80F2a+qZZIGp5psP4OtVPrb2dqcuiBXgThQD6DtXsOT9wjUAJXPRYfn6KBigfP
         w2rOFjyzjpq+f50Kt7XPE8YOViJC0oncTXVRUZ5A2KfTMBAtYe/NndAtFZXwpb6gsaJA
         XPSIW2cgfBHOlF2DfVdS8twwLAyH91DlZHwU8a9/SqcZUp818Knn3qCWDbTZd8UHthF5
         kiQdM83Sz4W/wYmLZ1+1O48unoovY+5YeCLSL8CBR9aAML0QQZrdR/yNcemE0FmCu6z4
         ME663GSU4ZYX+qiwm82mmDUTbbEtAnOky8PgqdqXhR1yf0Eas7CLe+mFswb6cT1Wi4b+
         Pdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786823680; x=1787428480;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q58QYg1S2v4WK0xb4Moy3EhImu5h91AbAwacaZzaIHo=;
        b=SeoBohu8nopucL8MuDnAlKDGweltycPECYA8ycCksIH4MWoil9HEnpG20xJAJGk9yO
         XxiieniXs1toonaGwYgdI6dGfRmNPzSO+cI3ooETOUeYA3mZE+wzMOV5tXJoPmqvBFl8
         LGtb4P/QPwO8YSccJD7Lcz1v9o1kKDzfYv/eqnmWwuGyUCd4HXYRQ2OsCWnnF5o2BWbN
         wja6B565VrLQndhOlpZ7WM9o353gGYCBlEiyoXOinlGW5uHw3xfNSulyK5bFK5b/GF4C
         euLDW9aTIGkCM9DsJWzhy7EwGFpN5LAcnr9UBiRBk9fr3rLiGQwdxMMKEWaa9MgF45Zj
         UlgQ==
X-Gm-Message-State: AOJu0Yz1FtoC/K+EOS6rpdfRCkS6QcgmmdVu1hn1JRg7fNeD2X0zdVGH
	RdWdjEjDVcLiV6Obn0WPaHui6VNK8h+AZzBcZHqRgWrHrZbGHQD/I2jdP7rZP3Xj
X-Gm-Gg: AR+sD11tfpCIixB7hKC/OuTzwt61YuTrfiQa03xPv1gOlyyY9VRf16uz9y8dNsWcxwW
	IVknTpnZfeMNNlFupUFexau4JHRzxbYOSKaKAz7wdLPYca2O7701iU19nlesj5WB6eqspzGNnkS
	42JUUllFc0FC7FMIp6Sr709pirqI8ndu+CZho58/z9Fc5aLaQemNnjhCQSLJA5oZgGTDyaP2Jlv
	WtoA7FhKJntEhnVPBxXsl4LdiYjwAv/xo8hpGhiRnx1ZZekTPIT5WqvxFRbXRiqT2OKzK8/v6fu
	CAUfeGD9dlocPE26m+cef3b+ghUGEo/L2np7XSnAuX0oU5UFd88MphNN+EWKjEkRKOPhcPqk7W3
	TAcKpIZGHqdtwrl2IhM575c1YM106SYuIFRfo0EHm6U56DhqDM5TWcVVb3lLPvcV1Zxb3JvNUIL
	shlZpfRmUmyq4VJqjQZgrAmGxzDKpbk8fWgAXC4v1uIbjQup70xJjZm9RqEOlsW1Zyy4Iy2gEbF
	YuaATDV+Ofn9tx3berm9cLQIntQxzLzVK/2MIKIk/2Dlk07Mpki
X-Received: by 2002:a05:600c:1c1a:b0:493:f42e:1b3f with SMTP id 5b1f17b1804b1-499879a41ebmr109636045e9.3.1786823680236;
        Sat, 15 Aug 2026 12:54:40 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c46besm18757609f8f.31.2026.08.15.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:54:39 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: netdev@vger.kernel.org
Cc: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tobias Diedrich <tobiasdiedrich@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] forcedeth: two register-window bounds fixes
Date: Sat, 15 Aug 2026 21:54:38 +0200
Message-ID: <178682367884.3748309.5288746298966501007@gmail.com>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Marek Czernohous <marek@czernohous.de>

Two bounds fixes in forcedeth, both in the same shape: a loop that walks
the register window one step too far. They are independent of each other
and touch different functions.

1/2 nv_suspend() and nv_resume() save and restore the non-PCI config
    space with i <= register_size/sizeof(u32). On a VER3 device that is
    exactly the length of saved_config_space[], so the last iteration
    reads and writes one element past the array, and on resume it
    writel()s that element one dword past the length the driver mapped.
    UBSAN catches it.

2/2 nv_tx_timeout() dumps the window in rows of eight dwords but only
    bounds the row's starting offset, so the final row reads between 12
    and 28 bytes past register_size, on every one of the three supported
    window sizes.

Neither is a regression. Both are long standing, and 1/2 in particular
is not new to the list:

  - The identical off-by-one in nv_get_regs() was fixed by commit
    ba9aa134287f ("forcedeth: fix buffer overflow") in 2012. The two
    loops in this patch were missed at the time.
  - The suspend and resume side was then reported on LKML in September
    2013 by Marc Weber, with the same analysis and the same
    one-character fix. Sergei Shtylyov replied asking for the patch
    inline rather than attached, and the thread ended there.

So this is not a new discovery. It is the same bug at the two sites the
2012 fix did not reach, finally sent in the form the list asks for.

How bad is it, stated plainly

  1/2 writes one u32 past the end of a declared array, on a suspend
  path, on every suspend of a VER3 device. That is an out-of-bounds
  store, it is what UBSAN reports, and with CONFIG_UBSAN_TRAP=y it is a
  trap that aborts the running kernel code. That is the stable case, and
  I think it stands on its own: memory safety, reproduced on hardware,
  one character to fix, no behavioural change for anyone else.

  What I will not claim is drama beyond that. The element it lands in is
  np->name_rx, a scratch string that nv_request_irq() rewrites with
  sprintf() before it is ever used, so on a kernel without UBSAN_TRAP
  nothing observable is corrupted. The patch says which member and why,
  so you can judge the severity yourself instead of taking my word.

  The MMIO side of both patches is milder still. ioremap() rounds the
  requested length up to page granularity, so these accesses stay inside
  the page the CPU has mapped and no fault is expected on any
  architecture with PAGE_SIZE >= 4K. What they leave is the window the
  driver asked for. 2/2 is only that, and carries no stable tag.

Behaviour change in 2/2, so it is not buried in the patch

  The partial trailing row of the debug dump is no longer printed: 16
  bytes for VER1, 20 for VER2, 4 for VER3. That is a deliberate trade
  against open-coding a second, narrower dump in a debug-only path. If
  you would rather keep those registers, a short remainder loop on top
  is the obvious follow-up.

Testing

  Reference hardware: Apple Macmini3,1 (MCP79 chipset), forcedeth
  driving the onboard NIC.

  1/2 is reproduced and fixed on that machine. One point of method
  first: UBSAN reports each source location only once per module load,
  so a quiet second suspend proves nothing. Both runs below are the
  first S3 cycle after a fresh load of the module in question.

    stock module,   first S3 after load:  2 splats, one per loop
    patched module, first S3 after load:  none

  The patched module was built, stripped, installed and reloaded, with
  the md5 of the running module checked against the installed one. The
  link came back, the DHCP lease was restored and ping showed no loss.
  That measurement was taken on 2026-08-04 on a 7.1.6 based kernel. The
  stock half has since been reproduced again on 7.1.8, most recently on
  2026-08-13, reporting line 6225 from pci_pm_suspend and line 6240
  from pci_pm_resume.

  I have not repeated the patched half on net/main itself. The runtime
  measurements come from a distro kernel on the reference hardware,
  which is the only machine I have with this NIC; the series itself is
  based on and built against net/main.

  2/2 has no runtime test. Its path sits behind the debug_tx_timeout
  module parameter and needs a genuine TX timeout, which I cannot force
  safely on this machine. It rests on the arithmetic in the patch and
  on the build below.

  Build: allmodconfig with W=1 on x86_64, whole tree, zero compiler
  warnings and zero errors; forcedeth.c specifically produces none.
  That took about 30 hours on the two cores I have, which is why I say
  it plainly rather than in passing.

  I have not run allyesconfig. If you want that too, say so and I will
  queue it before reposting rather than claim a build I did not do.

Two checkpatch notes on 1/2, both deliberate

  "Prefer a maximum 75 chars per line" fires on a line that is quoted
  UBSAN output. The splat is trimmed, and 1/2 says what was cut, but I
  did not rewrap the lines that remain: reflowing diagnostic output to
  satisfy a heuristic makes it harder to match against a real log.

  Two "spaces preferred around that '/'" CHECKs fire on
  register_size/sizeof(u32). That spacing is what the file already uses,
  including in nv_get_regs(), which is otherwise the same loop. Adding
  spaces would leave the two lines I touch inconsistent with their
  neighbourhood, so I kept the change to the one character that is
  wrong. Happy to do it the other way round if you prefer.

AI assistance

  Per Documentation/process/coding-assistants.rst: this work is AI
  assisted. I use Claude (claude-opus-5) as a coding and analysis
  assistant. Both patches carry an Assisted-by trailer accordingly, and
  no Signed-off-by is added by the tool.

  Nature of the assistance: the assistant did the code archaeology and
  most of the drafting. I described the symptom, asked for the mechanism
  to be traced in the source rather than guessed, and asked for each
  claim to be backed by a file and a line. The UBSAN output and the S3
  measurements are from the machine, not model output.

  It is also what found the 2012 fix and the 2013 report above, on a
  second pass over an earlier draft of this posting that claimed the bug
  had never been reported. That claim was wrong and would have wasted
  your time, so it seems worth saying that the checking pass is part of
  the process here and not a flourish. I reviewed the result, I
  understand the code, and I take responsibility for it.

Marek Czernohous (2):
  forcedeth: fix off-by-one when saving/restoring non-PCI config space
  forcedeth: stop the tx_timeout register dump past the requested window

 drivers/net/ethernet/nvidia/forcedeth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
-- 
2.54.0

