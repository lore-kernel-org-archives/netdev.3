Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4E474266
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933610; cv=pass; b=u/pNciBFe9CcnCa6xMaAcc4EYTGHIfrdDmigEFKZZBWKpczvYlGT+2flAfZlMkSpQvrDdk4veCfcv6QmLfTE5NaGVTD1YA0gCiYIpI6LDmckDn4VkxIznnGYWtIRDSbrRaQkGqIkfSA5ed2CihWqhH7Jta7rCT5WCZQ8VPNwF84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933610; c=relaxed/simple;
	bh=LjV1+sUCysW5KZDNQ7wARY7S78ZDQ872XQubCpql9Sk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BY/yOb1DTj3P4N05zRvpTqqYtbJ3N7wT28/57bgsSOB6KVL8Cf1zBAv0/qG54hm2NNVhMEBj1uGtAY0KNhzDTdzuyypIVwo5/4x/pbeQD60vfbT0IPDnbfM/Vt+T4MFqL9WYIS9CP00idUgnVgLQvlxmf6WCTvMvKdHxC/jJ/Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8n6IHXl; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8n6IHXl"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so336904466b.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789933607; cv=none;
        d=google.com; s=arc-20260327;
        b=aMcBsXokpRiSnWDMbWkALo0EoEggIsltqqmjNEnzWEMwbeGN1lUjZJ29wsHGfi8UJo
         UUIDa9cZ7ViX3eJ8rQK/pkLg4KLp6ASmju7uaCFheWOT0dWHF/WJKG96ClpTamfnCwZf
         fic7YrfvPAg8wKff9R+nqb2J8fsf26uWhBx/IR/6bo0QnkzZKXzjbQ+4XbVTJmmjHJZz
         r5KufAv6GsTKmGeq9EsgPYVLEQXdJScdfehVlUicWJLBgJ14E3312hWcRL6nFP1J3UZB
         2Fpgv3wiqCkV81H3M8liNtK/H0rgvxOJTcb/E9TcTZkE0dFfTT53SfO39ULc3XbCozwl
         sUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Soy0IrHpielF61W4DijilN3Jdy4uYm2kL31r3faOW6M=;
        fh=TzqvW5RkpuNpTkEr0TEty9d+y/tOC5h3ZiAlIMATCDo=;
        b=WFCd0s776K262XMtbO6wnkzDSIrKqJSEKLoanVNptmoUXtNjJhorXJseJbjbYPk/jX
         ejwv0xEdi/3IaWweMF4NHTFuxglxoNGharpS41c85AFd9eZAsDtWyUdb2DCPXbduFlZa
         QgLaylsQryCUAMxk54sXQRUFRNt7dg6qplZjukmLMw2DHmlI8glviF56/BvBKQxR4vmA
         k4k/LB4QwJekUVbf/UyjDAi+kceMsa1wgWDkfOf3/20IICIs5sxZ+aS2YZ7Gpzfqkh1d
         +ZwybC86ewdr8ggoamkIhiK9TeQ+gXbc/EmQC5KySVViMsHZqHNn5h8l4hv7XtAmw912
         FIGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933607; x=1790538407; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Soy0IrHpielF61W4DijilN3Jdy4uYm2kL31r3faOW6M=;
        b=S8n6IHXliN0lKqaJcAzFeZN2vu6C9XkxRfaoRWPSC4h+skvi190zyk0tBXddQs0iaT
         lZoBkLkqGY2TAVXcDc83JH7Bf3M9clkVolMOjMxgWgkKaWmZ1Q3e1XmMabrHNO0/TgUa
         DdwahezdJs3QRsWQAjgTLubIuDOxA+l/ERsDQ2si0E06bLoHQVbJ3IO/eeTYAB9QOnMb
         sc7ozAd4yUhDbIB1daSpbEMnwuDDNxbwUsmPGhd7jI9O4fmqQ8slB3RWaiZTQVWuFRYr
         j3KtQQyWpMkVRiFBK4IPClhSl1+B3y5sdKwUD9bV95qCHFvP77F0K9JMor9mAk13S426
         FY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933607; x=1790538407;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Soy0IrHpielF61W4DijilN3Jdy4uYm2kL31r3faOW6M=;
        b=LeGm1InrZTh+6vlyA2MgMlAx7V7HKM7dOm34Q+41Z2aH+Oiblv1Eb/B3y05PYgO2Pu
         Z9SGLaCrPHroQP48AtFNJoVUOFx9YVSJYy1VkFliKuvryqK6CPq0wdF70ybueQxaAtNG
         Zo6cbK6gU/+XG8XmIYLqV6jdT2SEPqvdBrZ4HUXkhNR3PtIR3fe7uBa/5EmohfmWn/DL
         DZg5evyG5CWdrf1+U74kTy2jiYwJ74C04GhY5tlUYl7aO9jGuop3yHfmmGYqp+GPxPvR
         fBLs4CrFwPzb2D5jYgAL8tUYTDyvX4ArhprgqeyIWfmEUHXFPtt0T2xwkSCEifNJ+yZy
         gKyg==
X-Gm-Message-State: AFuF++kK1I9T08jP3maDotLa3TrJ+SW+ao8xanovwWwNvy0vYWWKXvgA
	f/EYL/8Jh7eRcRbb28gEd/QxJUzaLqwc4in3UWsLMeWhr+yNikU/aSREGbDNv6hrHwgPXGvtQc8
	entaMRLwFt5iEl9MxWoJOB7F2570loupKFkiQZK5obQ==
X-Gm-Gg: AYBFou32mRm42fNHUH7hp20mbEuvrhwvTp6NGteHXQ9BTKdq2vwsDUtQ6YmoUF/na3M
	X8WTCj4s//gwYE3dXp3QVS3PxddR7E6oUJHPRnQPbXtVFkVn832PpyIyOQPuouceeI9vyZOPOYw
	jPZW11RX9UvR22YRnXvylu41gWw9pGX66Z1CD4U79nYgRB9riN5YVIMdl7bfJGZSprKPTnsVklv
	Cfi5oR5BXviTsLvs9y19l9EKqjCbUsQNYgNcV2tY7kg5Ty+U4C3X12b14Bp89QGG0K0io8+H9so
	B1DQVrSsG/19C4sAiFlkuqEAlVPR1zQj+mQo+XfmULnHN8yPTuxxTPmuhZhsLkVdtOJ6lPDOAON
	vSh/Z5tyfg4zBmESAPfEsnuRLCi/cEI1GyuauszjZYah7kyj2hI7CnHKC9nGMVqySt0epf//kay
	JUa5A1Iw==
X-Received: by 2002:a17:906:6a0d:b0:c26:19de:9ad5 with SMTP id
 a640c23a62f3a-c2a15e55434mr709121766b.45.1789933606927; Sun, 20 Sep 2026
 12:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Waseem Abbas Khan <wasimroxx9@gmail.com>
Date: Mon, 21 Sep 2026 00:46:36 +0500
X-Gm-Features: AcwNN1XyRr9gVz0bcTj8pwabzDo3BPclnOExx7xNhuSl0fuH6Ib-0-SXKKSZz7s
Message-ID: <CAFmi1-mjypvjHZDuc_d+o_doREMkTc6CNQd8176-MC+kRsZ0Fg@mail.gmail.com>
Subject: [BUG] net/unix: blocking AF_UNIX sendmsg can wedge permanently via
 send-buffer exhaustion while GC triggers stay unreachable
To: netdev@vger.kernel.org
Cc: namcao@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Subject: [BUG] af_unix: blocking sendmsg() can wedge permanently - GC
trigger starvation with pinned fd cycles

Hi,

I'd like to report a reproducible issue in net/unix/garbage.c that
affects all current
kernels including latest mainline (verified on 6.12.93, 6.12.104,
7.2-rc5, 7.2.6 and a
6.6-based kernel): a userspace process can permanently wedge its OWN blocking
sendmsg() by creating only "pinned" fd cycles, because no GC trigger
is ever reachable
before the sender's socket send-buffer fills with skbs that can never be freed.

Reproducer (userspace, unprivileged; no threads, no races, ~140 rounds):

  X = socket(AF_UNIX, SOCK_DGRAM, 0);
  loop {
      A, B = fresh AF_UNIX/SOCK_DGRAM sockets bound to abstract names;
      sendmsg(X -> A, SCM_RIGHTS carrying B); // blocking send
      sendmsg(X -> B, SCM_RIGHTS carrying A); // blocking send
      close(A); close(B);
  }

After ~139 rounds the third sendmsg blocks forever:

  task stack: unix_dgram_sendmsg -> sock_alloc_send_pskb+0x161
(schedule_timeout loop)

Observed state at the wedge (via QEMU monitor + symbols):
  - sender SO_MEMINFO: wmem_alloc=213504 >= sk_sndbuf=212992, wmem_queued=212992
  - /proc/net/unix: ~271 leftover sockets; process has only 9 fds
  - unix_tot_inflight = 278; gc_in_progress = 0; no unix_gc work queued
  - unix_graph_maybe_cyclic = 1

Analysis (why it can never recover on its own):
- close(A)/close(B) never fully release the sockets: the fpl in the
*other* socket's
  queue holds the only remaining file reference, so
unix_release_sock() - and with it
  the only reachable GC trigger (unix_gc() called on release when
unix_tot_inflight
  is non-zero) - is never reached. The cycles are fully "pinned".
- The send-path trigger requires unix_tot_inflight >
UNIX_INFLIGHT_TRIGGER_GC (16000).
- The send-buffer limit (sk_sndbuf, default 212992) is exhausted after
~278 unconsumed
  fd-skbs - i.e. roughly 60x earlier than the 16000 trigger - so a
blocking sender
  parks in sock_alloc_send_pskb() forever before any GC can be scheduled.
- The per-user Unix inflight sane threshold (SCM_MAX_FD*8 = 2024, used for the
  flush/wait penalty) is likewise unreachable: the wmem stall happens
~7x earlier.

Falsification / healing experiment:
A companion process that closes an *unpinned* socketpair every 500ms forces
release-path GCs; with it, the same loop completes 2,000,000 rounds
without wedging,
and the sender's wmem_alloc shows a clean leak/collect sawtooth. This
confirms the
issue is purely GC trigger starvation, not memory corruption (2M
rounds KASAN-clean).
The wedge persists across all four kernels above; nothing in mainline history
(garbage.c commits up to 4a4263dfeaba, 2026-09-12) addresses these triggers.

Impact:
- Any app doing blocking fd-passing cycles in a quiet system
(container, embedded,
  single-app) permanently hangs its send path; the pinned
file/skbs/sockets (bounded
  by RLIMIT_NOFILE per user) leak until some unrelated socket release
triggers a GC.
- Related in spirit to the historical 2008/2010 sendmsg-GC stall
reports; the current
  trigger set leaves an unreachable-trigger window that this
reproducer lands in.

Possible fix directions:
- Have the wmem wait in unix sendmsg paths schedule/flush the GC
before/while parking
  (e.g. unix_schedule_gc(user) when sock_alloc would block), or
- trigger on pinned-cycle conditions (e.g. consider graph state / cyclic_sccs at
  lower inflight thresholds), or
- align thresholds so the wmem cap cannot be reached while GC triggers
stay unreachable.

I can provide the exact reproducer source (gcracer9 mode 0) and the
healer companion
used for the experiments, plus monitor-derived state dumps.

Thanks,
[reporter]
