Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E833939D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306639; cv=none; b=rLOtAjfPyMT+U5cuvLBMN2rrmUnPSwA70g0rbG3mCA3OwloQIT9rpz3cE1Ziuphw078jh0G0xWhsOEVfulnTffBSFSlLCHpEQuL2LeaZgEW6ZRqEsg+DgfY/TjudKTjSgb21jqtm7xRqXcjhLztchfbGxdNlmXMtgZBbs67Qd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306639; c=relaxed/simple;
	bh=aYGadbtqESaWN4JNrHN0aDg0jSJlyPStQz0QqjpmL6c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rSVljDltMau5aSGFC0RcTqRmDz5I+zdGUVLU0rvEDkxI4DYp6aoHkSGaJ4+DHw0th7zg3i1Qrq7z5HUMoCz3S6hyRBEro3UGe/tkI4ZrrdPqrUxHK+cgLDoLQcbeicgqXb+BdPezTdORnZQz2iRSiSt6SAsprKJW2QputSevw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=dPkHccQg; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="dPkHccQg"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917a2800e83so38481826d6.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306637; x=1791911437; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y9NiyobynJrGhli2ru3ZvHWRYLZ4SyUg0+a0p461rCs=;
        b=dPkHccQgSnkc9lyHgYKjaXPOjZRBFA2nLcLaKfuxZ+ujRaADFENY32ddvt5MW04lJo
         xDkZyodPnwriawOQ1T9rd9Tm7GwPydf/dENw5kDtKcYJQXlPg549rfuqqdQuub3iVmBr
         dencfK1SXezq8nHbrHmDrKGM7eFz+h/PjcQ8l/xQKU9lg3OvhEBchkBc/Eg334dI0aKU
         AnThIIyQiVdDXpjhKIhJPmrZuncma4apjIaRMWW/QHTeQVfwdScn8E+L2yO40LFeiVlm
         sXjC/F5V9pfNnP2dD8Mz5OmPu4TfHKrS+RLMudAFyvFYdnLahH7mTyu2pveJK1GFBXNb
         Vr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306637; x=1791911437;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y9NiyobynJrGhli2ru3ZvHWRYLZ4SyUg0+a0p461rCs=;
        b=AVsiH8OsYEKNidYFeR97YMw7V4wotPvG2/qrpdjHuNvIGIu1hMrCghn2MFsY3qW/Bk
         qH3Hfs/KONYhSd0Vv7T7XX9yAowP6T9zjsCiDxuLMU3Sdw3LL8fprICl3COoBtDunyBB
         3ao6Qn2QtjORj2AZPNQWpdYkTGNm0taaUAKKPSwcXqqKs0fwANd1l61vHv/8xlhX3IV6
         041yCXd0nc4nWac4Fd+9Ct3A+LfABgN3GBzB8jh9NrePhAQ/y58JbJehwrFh6mWruFQE
         ThHNdQRN0106kp8yms4awYyqsJh8gfJT72/FwSbmIlVFDt4NxqqzLesib+/Wc5Lzsksi
         bzzg==
X-Gm-Message-State: AFq9FYJ1HR7dbZBYDxg9O36lc2mgcQbGJ8bKf3EZAiRKVjG6Y29tqNa+
	uIaXkQwu9RM57/rP7gY/3lBK/bnXSPxkoDihMtvMlOIp9PzZvWCl9DYkjIaiwatXPjg=
X-Gm-Gg: AYBFou2hDZHEY0bEB1h1CLHUMIsOdVt8gdavWy3JOT4MKA1U2Nkjge+2FdZUpnJzBGJ
	cIyHmFyUV8setF7wbkccSm/KXmlajm8tZG+d3Wv0TiXOesDY9Z7KOW1nLxCdc/NrHYVCa6Hw8wB
	qKbHzsPpv1ibhxqS/woXQcvSO6qBc0X5Dkfky+OWOZtK+66bp2JnvW1xEv1qDtX3OsH4C5zWd4q
	OWlSPGOzlUBrBhC+TEdgJ5+OWkvdPXWR068gxY0828wn8jrMneE8C4tFX3FQtpotzbQbB/9zR+c
	x9f+q9TdpZ7fa/efmIZiAvtNYA6xXZXq4fZGaHULXahiFvT4B4WgACiRPVTPuz6vJCMKIp4gyES
	Q0sdLWsyXWqkabHfu0RgJejS7CNYbTtw4x70aeqLmRLytiEa5CjdPMfBTLB/RyQXvyeA5RbrQql
	g6jtekDBuvlWjut1xgP1qtxs6v4oWIp3DasswHKKxBEW2FBDDNHp04sBJqjlHl4yIsJUZlDEry8
	HtUkCj7SqB505g=
X-Received: by 2002:a05:6214:c27:b0:917:beb6:8114 with SMTP id 6a1803df08f44-9195d0f00b7mr215431006d6.19.1791306636647;
        Tue, 06 Oct 2026 10:10:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919860889b2sm26433986d6.30.2026.10.06.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next 0/9] net: skbuff: convert most BUG_ON()s to
 WARN_ON_ONCE() and an error
Date: Tue, 06 Oct 2026 17:10:15 +0000
Message-Id: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgrxWoC/1WNyw6CMBBFf4XM2gnQVER/hbjo1ClUTSF9GBLCv
 9viyuV9nbtBYG85wK3awPPHBju7LNpTBXpSbmS0j6xBNKJrm6ZDkhhelIxBSiPODkn0UirZX67
 iDHm2eDZ2PZADOI7oeI1w/yUh0ZN1LMTSJRUYySunp2K9l5pkfZh/H7DvX10TqvKpAAAA
X-Change-ID: 20261006-b4-skbuff-bug-on-b2844a487925
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=3705;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aYGadbtqESaWN4JNrHN0aDg0jSJlyPStQz0QqjpmL6c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHJHywC4QrO+PoVB+wbiVh5DQJUEYlspEenGrZ+15taqt/9sTCg45iz6/w8NUDX+YA7U+wQc8cB
 hKrPURPIeCgA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

I'm going through and reducing BUG_ON() usage in areas that have created
the most problems for us.  89 commits in the tree quote "kernel BUG at
net/core/skbuff.c", 31 of them since 2024, and some of those could be
triggered from inside a user namespace.

The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
in a buffer headed for the wire when it hits unreadable frags.  The
BUG_ON() conversion of the same function needs the same handling, so
it's here rather than sent separately.

The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
Each one becomes

	if (WARN_ON_ONCE(cond))
		<error path>;

where the error path is a failure return the function already has and
its callers already handle: -EINVAL from pskb_expand_head() and
skb_segment(), NULL from skb_copy(), 0 from skb_shift(), and so on.
Each patch says what its error path is and why it's safe.  Anybody who
wants the old behaviour, syzbot included, gets it with panic_on_warn.

A few don't have an obvious error return:

 - skb_copy_and_csum_bits() zeroes the part of the caller's buffer it
   couldn't fill instead of leaving stale bytes in it.
 - skb_copy_and_csum_dev() copies the frame without a checksum.  It
   also now catches a csum_start before the head and a csum_offset past
   the end of the frame, which the BUG_ON() missed.
 - skb_shift()'s second check ran after the shift had been committed.
   It moves up to just before the commit, where nothing has changed
   yet, and returns 0 there.

Two BUG_ON()s are left on purpose.  __pskb_pull_tail() and
skb_pull_rcsum() have callers that can't otherwise fail, so they don't
check the return.  Some of them would carry on and BUG() somewhere
else, or push back a pull that never happened.  Those need their
callers fixed first and will come as separate series.
skb_over_panic() and skb_under_panic() keep their BUG() as well; that's
overflow hardening and should stay fatal.

skbuff.o text on x86_64 defconfig grows by 114 bytes.  The fast path
takes the same branch it does today; the extra bytes are the error
paths that BUG() used to replace.

Testing: x86_64 defconfig with CONFIG_WERROR boots, and every patch
builds net/core/skbuff.o on its own with allmodconfig, W=1 and
CONFIG_DEBUG_NET.  A test module drives 12 of the 17 converted
BUG_ON()s with a bad argument or a malformed skb, skb_shift() through
a test-only export.  Each one warns once and returns its documented
error, and the skbs are left alone.  The same module covers the
unreadable-frags fix.  test_bpf's skb_segment tests pass.  The other
five were only reviewed: skb_crc32c() isn't built in defconfig, and
the four skb_segment() layout checks need a crafted frag_list. Thanks,

Josef

---
Josef Bacik (9):
      net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()
      net: skbuff: don't BUG() on bad arguments to pskb_expand_head()
      net: skbuff: don't BUG() on a bad frag_list layout in skb_segment()
      net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers
      net: skbuff: don't BUG() on leftover length in skb_checksum() and friends
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()
      net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()
      net: skbuff: remove the BUG_ON()s from skb_shift()

 net/core/skbuff.c | 98 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 77 insertions(+), 21 deletions(-)
---
base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
change-id: 20261006-b4-skbuff-bug-on-b2844a487925

