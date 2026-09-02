Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C845518E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393256; cv=pass; b=RPfwmyCttNtu5RwDmoUr5bU+Vi8qkrQCsC2SKerlCML/bJPfBMul3mD3VS5dwD4pUQvY6UVpde0czqLz69WraEpfaQDNBRex6Bf0ANvX143594A6AVnAJuGOJ9tZzK+Vs9CnMmrdbGprtijB/a4ikS2M6rZkdXMXNE+6DlyM+ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393256; c=relaxed/simple;
	bh=wY5lJZFzaMcw6lGnaMo4ikBMYHZ0CfsHVCatbmTFMh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iC61FZIUXhFgtdCxfk0c9SVCOfLUzdvGJTfSNgeIbydzZQwGAQQW5cggAxTHA7EmTvO48Or2RsydEk25F1/IL2fH+KjTnJxf3o8s9K1Mf4OdShr9/UNtjHQQP8eP8jfPIw9vuM/rLCpnqmXPvihNkSGipZaqsUApxjDvPz6Qawg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skvi37mg; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skvi37mg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53016020b2fso25816221cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788393254; cv=none;
        d=google.com; s=arc-20260327;
        b=SF9HFne5aKVyIfmvh2klowYKptvMMvi1eABHmZCYmEKyhWrllkC/sGU1SjzsgBTKw3
         E17XHpkv0gYosRXh4DDYi/8WDRCKDma9oYSGg9/7Xh09Uy9gIKDHpIV/eWrGEb483s1N
         XmM+tDU6akxupR8kjPjP09gPtVWrVuxXkiiDgJkcYDV7AXoXJ/IJFHCAX3ZisOilrlLf
         N0RVb/ltrZcw90AZ5s8dd448+w9P4O7OutKGvaDt6siveGLxv06YfpcKM+1yo/n+jc1c
         IrQEp4ERet20kME1E8FfOCZi+9emISqJzqp/P3g06nP+zuKxgoxeMAwGw4tO24NBvlvG
         EGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QGffjQeMvyurGQHkRNi9cRzIRToYPu/kZD1UWhsH/5E=;
        fh=a2hlbhXtt1C0DRCNKiIRDxgMtksEf5MoMYmKhApxaAA=;
        b=KmcROkW5weab0mxMUwTvvZKVAl3EDSpIJXPJw7vc3iA7Au3rYnZV8ybzrB+VB/TW/+
         idE7v4ANBH+snKazJN2gBv6RXTNLHcBXuvmfuZQ9Ioq+0Ry13PJoxcWGsnqU5j4Dl3OW
         C/F8hA3dDBkP5GMYalQf4tLXB0egLWYCGppJU5Ddw8XfaA0mQrCuVmwJx1Xirt5ZQm6L
         vW/VR5A878lUE8b4Onrd/+nVWCySHhqpLqsiTU8CDonQFuyrj+qYSE17MhsPHOeTvKFx
         eUe52y4fiQgTS/iwtCF6YAVLGClPiW4+d7ZO5PEqhLYbTr7nlu02CDV0ynVx/YVa/yi9
         modw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788393254; x=1788998054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QGffjQeMvyurGQHkRNi9cRzIRToYPu/kZD1UWhsH/5E=;
        b=skvi37mg96Zvrp2Bgys5jYmA+v5ABjc2XDMBvZm8ZgeLJMJdHx0LRmHWpFilHy1N+P
         hrir2PJUzgXdZTfdxi3QK5M77xFOeTB+62LNrrqDoXCNocwBL6xEwkb0KTQQPmDrRapr
         TSWeF42cmy298xa78E7as1uG5dcrPwqHDV7ZwgI87MNUQBV6Kcq8asPVCSvmy4cP+uC8
         GmanVLWmxQ6isCJGo5wB4i+8gpHJbwLrWBAwUb18yXZeF7L3T4c99uew/WFSH38fHFhT
         FU1XauIks16x5mNa0oi2/d9RNM13h1qe+HgPS58V9qDkTHDakN55nm5IWq5nZeXe+8V4
         Xs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393254; x=1788998054;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QGffjQeMvyurGQHkRNi9cRzIRToYPu/kZD1UWhsH/5E=;
        b=TIQvgeCLXIcDtmhplMNNsNmCJ6lC4f2e5wg0sX1O30mS5fwVxDfnnhvqt4CnIhdS/H
         mJA9YhT80GB6hR2ZUXnfqYQ1gFDwp7wPSdhlpwCDd3vCAD8LQS2aKcEeIcUzkWOD7syS
         6WlVSWCUq5zWMnV6U3VlZ53DOv7sGD60xKmW3UHby+GjsryIrGWAxztJolN7pyPoFaEP
         uVtYjtLT/5uG36f74s1Eb4HdB0VNz68QZQKhlKFLWSa4A960BES3RiojI4VBsO0CJVSS
         9oy7tDZuUQF5GiLV7is3iqhIgir38g9MIjcGXyAMim+XsrR1HCnlFtfdmrMkpt8ernEw
         4mHw==
X-Forwarded-Encrypted: i=1; AKwUvBwGITxWZjiMya2nUrqdLzzWehtTykO+SqAgP+0d45OvySwu2Y3JK+QV5lKEHPMysTpS4zntSIY=@vger.kernel.org
X-Gm-Message-State: AFuF++kNoSTjdHn8L4nkNyB7jtGHO27oRAG0Qyrv6Mjju5rIo4/nRupo
	j2GQPp6oM5v2pEMJhWL4RB/Cu1chSr+ZH6I1mwxS5VVMNJBnCCq7QeSy2iGFgmGI+YGkPVr33lz
	DmXkb40SMYhvy6nS7taj03MCPfMWM08o=
X-Gm-Gg: AYBFou31nnfdk3ZsgzptyfJLAuB7vZPNYBlO86hbGXI3eQQ/Qk8WCvwO2XlonT1oemv
	Elj898dz6c28+utLbOJhpghJu8AQqJnXXaJN+iG5G66WrB1GgOZbHMSgkLbtw1YNs/CUg0XYb4M
	5WFbdSlWCeHW8ejXxhiKu7B1JWLKeX7AjuJzw/SVHOEY+IfRxLaz4PkfMi/L0d5VSPnjJjM4yWz
	ymOpqN6nuDN3isetIn5Z1OTciG72SRio/lyRLynmRDvultRVtUV8WVQl0+HY0LWpA+T4toYkeLI
	o+DwZdD8kGHIWG1ibjfCqq4odTS9ftmh5OLdEi6LeGA=
X-Received: by 2002:ac8:58c7:0:b0:52d:ce86:1393 with SMTP id
 d75a77b69052e-53036d2c206mr106348661cf.37.1788393253917; Wed, 02 Sep 2026
 16:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ville Poutiainen <villeaj.poutiainen@gmail.com>
Date: Thu, 3 Sep 2026 02:54:02 +0300
X-Gm-Features: AcwNN1VgxA8NMmM_IBkCVkoKeFvRLWGWd20bsg6PZZOw3hS4Z89zOr3rMaMTVUs
Message-ID: <CAKT_hvzXo14ER3NOc3pWhNmXbp0suVoQ8D+KmC2YzrfrBhWb+g@mail.gmail.com>
Subject: [BUG] tcp: NULL f_inode in listening_get_first() leaves listener
 spinlock held
To: edumazet@google.com, ncardwell@google.com
Cc: kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I encountered a kernel NULL-pointer dereference in the TCP proc iterator
on Fedora 44, followed by a persistent listener-bucket spinlock lockup
when another process later read /proc/net/tcp.

Fedora bug with sanitized logs, exact kernel configuration, and decoded
vmlinux analysis:

https://bugzilla.redhat.com/show_bug.cgi?id=2527805

Affected kernel:
  7.1.10-200.fc44.x86_64

Architecture:
  x86_64

Initial failure:

  BUG: kernel NULL pointer dereference, address: 0000000000000230
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP NOPTI
  CPU: 1 UID: 1000 PID: 1634 Comm: pasta.avx2
  RIP: listening_get_first+0xc0/0x120

Call path:

  listening_get_first
  tcp_get_idx
  tcp_seq_start
  seq_read_iter
  seq_read
  proc_reg_read
  vfs_read
  ksys_read

The userspace syscall was read(fd=16, ...). The process was pasta,
performing automatic port discovery by reading /proc/net/tcp.

I obtained the exact Fedora debuginfo/vmlinux matching the affected
kernel. Its Build ID is:

  4c9470ef910bac97b4554b740c84f337cada5950

GDB against that exact binary shows:

  struct seq_file.file     = 0x60
  struct file.f_inode      = 0x20
  struct inode.i_private   = 0x230

The relevant instructions in listening_get_first are:

  +0x8f: call _raw_spin_lock
  ...
  +0xb8: mov 0x60(%rbp),%rdx
  +0xbc: mov 0x20(%rdx),%rdx
  +0xc0: mov 0x230(%rdx),%rdx
  ...
  +0xff: call _raw_spin_unlock

At the fault:

  RDX = 0
  CR2 = 0x230

Thus, as far as I can tell from the exact binary and register state,
seq->file->f_inode was NULL while the active /proc/net/tcp read was in
progress. The fault occurred when the code then accessed
inode->i_private.

The listener hash-bucket spinlock had already been acquired and the
Oops occurred before the normal unlock path.

The kernel continued after the Oops and reported:

  note: pasta.avx2[1634] exited with irqs disabled
  note: pasta.avx2[1634] exited with preempt_count 1

A few minutes later, "ss" became permanently stuck at 100% system CPU:

  native_queued_spin_lock_slowpath
  _raw_spin_lock
  listening_get_first+0x94
  tcp_get_idx
  tcp_seq_next
  seq_read_iter

The listener-bucket lock address in the original pasta Oops was:

  ffff8f0d05894ec0

The later ss soft-lockup was attempting to acquire the same address:

  ffff8f0d05894ec0

The watchdog subsequently reported the task stuck for 26, 52, 85, 112,
138, 164, 190, 216, and at least 253 seconds, together with RCU stalls.
The machine ultimately became unusable and required a forced reboot.

Crash-time userspace configuration:

  passt/pasta:  0^20260728.gf8df3f1-2.fc44
  RootlessKit:  3.1.0-1.fc44
  moby-engine:  29.7.2-1.fc44

RootlessKit was running with:

  --net=pasta
  --port-driver=implicit

which caused pasta to use its automatic TCP/UDP port scanning path.

The first Oops was tainted G OE due to the NVIDIA out-of-tree/unsigned
modules which were loaded on the system. I have not reproduced this on
an untainted or vanilla upstream kernel.

This failure has occurred once. I have not deliberately reproduced it,
because once the Oops occurs the leaked spinlock can lead to a
system-wide lockup.

The machine is now running Fedora kernel 7.1.12-200.fc44.x86_64, but I
also changed RootlessKit to the pesto port driver. The current pasta
instance uses --tcp-ports=none --udp-ports=none, so the original scan
path is no longer being exercised. Therefore the absence of another
failure on 7.1.12 does not establish that the kernel issue is fixed.

I have not established whether the underlying cause of the NULL f_inode
is a struct file lifetime/reuse problem, other memory corruption, or
something else.

The Fedora bug linked above contains:

  kernel-crash-public.txt
  kernel-config.txt
  vmlinux-analysis-public.txt

The first file contains the complete initial Oops and subsequent
soft-lockup/RCU traces. The vmlinux analysis contains the exact
disassembly and structure layouts from the matching Fedora debuginfo.

I currently do not have enough spare compute resources to run a
controlled reproduction on current mainline, but I can provide
additional targeted information or perform a specific test later if it
would help identify the cause.

Regards,
Ville Poutiainen
