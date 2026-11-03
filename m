Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672927;
	b=sa1vJUVK3vgnGULsRJfXPKMcs4Bi3KExRpbHOMcCZAVjLGF+pKEhmAONrDYgN1+r2Wuq
	 eSAlI1SeNQETztllmJwUdeIztcd6bzfppcxotttz0utHY0eSkG5ABlT4397aIyJIqjCCI
	 JWD+cDXoWICk2FaCIdEQGHtC2cYrheXEBegzjxZiCi0XFHUDzuj9B6gNJaDUMhItRtVfV
	 aFTBXGVuDIvP6hQHfHemcBTL3oqbih6sb6acj4KIwKvdpu3rILBElrtHP2yaHiuW2LRNr
	 ATjE9l3KRBQFbCVOLTc2SdvlOUNypd99vbaznRF/1FZCAWwtMr2PmpD7CQ+dcjJCHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8yOxX1Bu6LKoUVi2ACTRn7d/0rP5glxXkcPct02PZno=;
	b=1F/thGaeYG359FB4euvAhxmGcU/lbVL/D390BxNSN+iUhUI5bVIeFVA3d8zghw3ZVf1h
	 NIOlyPwNBWDPPzxrhqnMSg0Ap7EyQ+R8lU0vViXypQQTEk38Q/SliKli3/08BBxYXO6eA
	 opUQW3MToR/fMUyEEc0sNDzfs0JMKjP/5bpJnDSPKrywE4y224ydIiQ4pK+aoDjnNScbV
	 XHh7m+guKdG8hKTC2y/kyrySjLxye5Cd1evRnwrrgOS58VMnehWDGK189j8xFwoelQ56L
	 ae5BMbrPGInm0uGJDpZ76xFJFsGSUCrunqFz2wzhvl9BAfUn08fkpbpYlWTaAV9HbxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=a63sIOfF;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB11606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB11606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=a63sIOfF
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso31352356d6.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672925; x=1794277725; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8yOxX1Bu6LKoUVi2ACTRn7d/0rP5glxXkcPct02PZno=;
        b=a63sIOfFl66+gR04+mBCWEcEJCegZUQuirrUvYF2w7Eqmaokzj2L8bdgJcNja4ubUJ
         VZa9ppLGKjF701FYY56koCLaPl0SI4479CK0t1RbugpgThBhIZhRt2fuspX4iyqBToFA
         ukQeMgGHSRWq7oqDLMOBDRGqNnlS97A0MQG5DqFdkq9zyqPWkxnd0bF3SJ51TXJdpg+V
         rEHJUAwgilNU+yTB3IuTbCliUbiNWwYQjOWtPaCC+qUL3Q9Pt0Ca7QA74DZgSEaTubne
         bgKR08JqYlJUpdbdd+4jHmSAJuiCkMmzQQps8TgfmOmvZ6ak14CsHiETi6CNDRrp6qtB
         x15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672925; x=1794277725;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8yOxX1Bu6LKoUVi2ACTRn7d/0rP5glxXkcPct02PZno=;
        b=noqtO+4D5qD8YJIXFHzC/SslVLuBCdqwAd/SiiOVnhoBuT2bu4Ip4o9FnlTvrxr6XG
         Ek1JKA7bBRi+P+SkDICZIKU1dh/gDlWAvepmQXlo2ao53g0yU+Xsp7+3fe8D30z/14hY
         gJhEaMg9XIHYei9C5mzz1v3BudFpr3K6HbV6uQ8DbkJSU7FxDlmRU7k9AF1rmF9s+XWa
         N3BIJsho/Zin+RdCqz3DFfmooLxQVBh2XwWy3SxAwEmbJCm5UUDIA31Cbwuwk6djYlac
         5k4umX4sRLe1HnnkICeX0qw2MfmYGlmupNIsYTkgFtpjExh/WvIazmT07HrEypOCZLs6
         o8/g==
X-Forwarded-Encrypted: i=1; AKwUvBwLGYyqIM4qCx45TKIc9wm1WPAsawq6LqcMJqyc/u6JTkr1alv1ZwUr3whk1TKyZzmu3XaXAr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uTqDajPF4hNaQXH9lJWd7r0TkWv23vBt/jC/nOYFtl0qgHFxM
	q1gp85f4R9Bh25GStn+zwi3zUvN+5x2Q55p/uLQdpGxL1HtdmmKwG6QcOlnaFjpbTAE=
X-Gm-Gg: AYBFou1hjG9n0TU7xNDkAVRtVZOp5P2rQICIH2HQQLRb+6wDz5/ewVyHnPcVZ3VwlUJ
	2hT9dFNnYwIGNwHTzwPxMBnZyCLAbRh1/DqINX9LD9I0dWqJ+xdQESRQohq+EH2lIgT9xfpBHwR
	WAi9bn1CgAQdi28f8vMvcryrbcgTyHmqmeEfV+GMF5hEgnHVgpfgQEoH+wtqFGsiIYzwxE6NSHV
	sHDH246y9Fck/eCXr+Kh4xV3BxLFOsybq3O18/vjnUu983KJbql7fvLC0UUuBYFk4/svAm6KCmp
	YiegV7E9zJALjnq0JXwfpQSe1luIG+HTfPOhL6Rl6dtiNO25FKdPrI8sGj5/GZsIOXWDf0AbB55
	+epxMggVxLzxU2DVsebkHn68xDeGgjjkGOSI6hOnpycqRsuRNH0D1Of6D/qFGP1nlrlzciOJvWs
	ISA9R3TYo8hKqhYculsB7TC6yyTewtXeKcJiO739nN2XWVoLozzotSdWBQ2242cmxg4QR+w0BPs
	kIdBkZqzcCtp+cV3iJ2BDBzFPVFGm+VhoJVAzCHfJJXVI+zydte9ITmLkE5DSjdSBbVeJ7eL3pW
	DxZK34t/wb8pjqpFVA0d5oc/nObA79Op8U7xAbpxDdjClA==
X-Received: by 2002:ad4:5947:0:b0:91c:6c27:d5ca with SMTP id 6a1803df08f44-91ca4b6f243mr194042456d6.41.1793672925486;
        Mon, 02 Nov 2026 18:28:45 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f25fc2sm106442246d6.10.2026.11.02.18.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next v3 00/15] net: skbuff: follow-ups to the BUG_ON()
 removal
Date: Tue, 03 Nov 2026 02:28:26 +0000
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxG6WoC/32Oy27DIBBFfyVi3WmA4Dy66n9EWQwwxLQOWIBdV
 5H/vTbtolLVLO+dmTPnzjIlT5m9bO4s0eizj2EJu6cNMy2GK4G3S2aSy73gYg9aQX7Xg3Oghyv
 EAC52XfwY+gxohUDr5LFBxRZAn8j5qcLPLFCBQFNhl+9JHvQbmbKy112NmUAnDKZdq67farWt5
 T/f1qPW5xLTZ5UfRX3z43l65DkK4KCE1eQark/u8Fri5E2PweKzibeqOMpfPCke8uTCk4iHI0e
 +a6T6w5vn+QtFRR05agEAAA==
X-Change-ID: 20261016-b4-skbuff-bug-on-followups-ad11adf285a4
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=9386;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=pSmkEfDauPbypTaoTh/3HpP3thH7q3OtOV4bGWRVhNs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDmMjtaHEFHTxNdI89Gi/a3RQRw+y5eNRW1DqtPDRlxYARtKzR1FB7fqVxkZgLKsdATt6GfX6w7
 vU/lKccmCcwU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com/
v2: https://lore.kernel.org/all/20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com/

v2->v3:
- 1, 2, 6: move the frag_list recursion into a noinline function, so
  that taking the address of a local there doesn't give the helpers a
  stack protector (Paolo).  On x86_64 defconfig plus CONFIG_IP_SCTP
  none of skb_copy_and_csum_bits(), skb_checksum_full(),
  skb_crc32c_full() or the two wrappers has one now, and
  __ip_append_data(), __ip6_append_data() and skb_segment() are
  unchanged.  The callers that pass a local do gain one.  Besides the
  seven I listed on v2, that's __skb_gro_checksum_complete() and
  skb_checksum_help(), which are converted in this version, and
  skb_crc32c_csum_help().
- 1: put the Fixes: tags back (Fernando, Sashiko).  csump in the
  prototype, and drop the "Both of above in one bottle" comment
  (Fernando).  skb_copy_and_csum_dev() zeroes the whole frame when the
  copy fails, since leaving the checksum alone doesn't guarantee a bad
  one (Sashiko).
- 2, 6: the kernel-doc describes the unreadable check as it is, the
  wrappers don't blame unreadable frags for -EINVAL, and the commit
  messages say what changes for a failing frag_list member (Fernando,
  Sashiko).
- 2: convert skb_checksum_help() too, as 6 does for its crc32c twin, and
  add Fixes: 20ddd0fd2fcd.
- 3: convert __skb_gro_checksum_complete() too (Fernando, Sashiko).
  Take the skb off CHECKSUM_COMPLETE on failure.  Otherwise conntrack,
  which doesn't drop on a bad checksum, leaves the pseudo-header sum in
  skb->csum and TCP's validation accepts the packet after all
  (Sashiko).  Update the comments, and add Fixes: 65249feb6b3d.
- 4: the commit message was wrong that devmem TX reaches this checksum.
  Its skbs carry SKBFL_SHARED_FRAG, so the segment fails to linearize
  first.  The patch is hardening, and the commit message says so now.
- 5: when the tail can't be checksummed but what's left can be read,
  set CHECKSUM_NONE instead of failing the trim, which dropped packets
  that used to be accepted (Sashiko).  Retitled, and add Fixes: tags.
- 7, 8: add the Fixes: tags for the original commits, and correct the
  history in 8's commit message (Sashiko).  8 also says what it takes
  to reach the memcpy().
- 7: reject a negative @len or @hlen on entry.  The reorder left nothing
  ahead of the skb_put(), which panics on one.
- 8: the truesize check refuses the coalesce instead of only warning,
  and runs before the head is stolen.  With len unsigned and nothing
  else, an skb with a len above INT_MAX went from refused to coalesced.
- 9: check data_len > len directly and zero the frame.  The old check
  missed CHECKSUM_PARTIAL (Sashiko).  Retitled.
- 10: drop both len > 0 tests, and correct what the commit message says
  they covered (Sashiko).
- 9, 10: drop the Fixes: tags.  Both problems are older than the commits
  the tags named, and neither has a known trigger.
- 11: Willem, this one changed again after you OK'd the walk up front.
  A nested frag_list is only one way for the walk to run out of members.
  A len that counts bytes the skb doesn't hold gets to the same NULL
  pointer dereference, and the walk up front doesn't catch that.  So the
  patch now checks for a NULL list_skb in the three places where the
  walk moves on to it, and that's all it does: no pass up front, which
  also takes care of the cost you pointed out for BIG TCP, and none of
  v2's skb_has_frag_list() tests.  You asked on v2 whether the first two
  checks were needed.  For a nested frag_list they weren't, for this
  they are.  12 has a case for each, and taking any one of the three
  checks out brings the oops back.  The path without SG is left alone
  again.  The commit message says that IP reassembly does nest
  frag_lists, just not on GSO skbs (Sashiko).  Retitled.
- 12: add four cases for a len that counts bytes the skb doesn't hold.
  Retitled.
- 13: correct what the commit message says about when bounce_skb() runs
  and when skb_copy_bits() fails.
- 14: update the comment above skb_nsg() (Sashiko).
- 15: one more stale comment, in net_test.c.
- Picked up Fernando's Reviewed-by on 4.  Dropped Mina's on 1 and
  Fernando's on 2, since the frag_list loop moved in both, and Willem's
  on 12, since it grew.
- Shortened the commit messages.
- Rebased onto current net-next.
v1->v2:
- skb_segment(): check each frag_list member as the walk takes it,
  instead of an extra pass over the frag_list up front (Willem).
- KUnit test: braces around the suppressed skb_segment() call (Willem),
  and the comment update for the non-uniform case moved into the same
  patch (Mina).
- Picked up Willem's Reviewed-by and Mina's Acked-bys.

--- Original email (v1) ---

Hello,

Jakub applied v2 of my skbuff BUG_ON() series[1] before I got v3 out, so
this is what v3 would have changed, as fixes on top of what landed, plus
the skb_copy_and_csum_bits() patch I'd been sending to net on its own.

Patch 1 is that patch[2], moved to net-next as Mina suggested, with his
Reviewed-by.  It makes skb_copy_and_csum_bits() report failure, and the
rest of the series builds on it.  Please drop the net version.

Patches 2 through 6 deal with skb_checksum() and skb_crc32c().  My v2
had them return 0 when they run out of skb, and that turned out not to
be safe: 0 is a valid checksum, and it can make a packet that was never
fully checksummed pass verification.  So they get versions that report
failure, skb_checksum_full() and skb_crc32c_full(), and the core users
switch to them: checksum validation now rejects a packet it can't
checksum, skb_segment() and pskb_trim_rcsum() fail instead of using a
bad sum, and skb_crc32c_csum_help() drops the packet.  skb_checksum()
and skb_crc32c() stay as wrappers that behave as before, and I'll
convert the rest of their callers per subsystem in later series.

Patches 7 through 10 fix problems Sashiko and an LLM review found in
what was applied.  skb_zerocopy() refuses a zero-length copy that Open
vSwitch can trigger from a user namespace, skb_try_coalesce() and
skb_copy_and_csum_bits() can be handed a negative length, and
skb_headlen() can underflow in skb_copy_and_csum_dev().

Patches 11 and 12 make skb_segment() refuse a nested frag_list, which
could still oops on a NULL list_skb, and add KUnit cases for the layouts
it refuses.  Patches 13 and 14 get rid of the same BUG_ON()s in
xen-netfront's bounce_skb() and tls's __skb_nsg(), and patch 15 updates
comments that still describe the old BUG_ON()s.

I tested this with the net_core KUnit tests, a test module that drives
each of these paths under KASAN and fault injection, an Open vSwitch
reproducer for patch 7, and a stress run over veth with netem.  Thanks,

Josef

[1] https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
[2] https://lore.kernel.org/all/20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com/

---
Changes in v3:
- Link to v2: https://patch.msgid.link/20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com

---
Josef Bacik (15):
      net: skbuff: make skb_copy_and_csum_bits() report unreadable frags
      net: skbuff: add skb_checksum_full() that reports failure
      net: skbuff: fail checksum validation when the skb can't be checksummed
      net: skbuff: fail segmentation when a segment can't be checksummed
      net: skbuff: drop hw csum if trim can't checksum tail
      net: skbuff: add skb_crc32c_full() that reports failure
      net: skbuff: let skb_zerocopy() copy a short skb without head_frag
      net: skbuff: make skb_try_coalesce()'s len unsigned
      net: skbuff: reject data_len > len in copy_and_csum_dev
      net: skbuff: reject a negative length in skb_copy_and_csum_bits()
      net: skbuff: don't run off frag_list in skb_segment()
      net: test the skb layouts skb_segment() refuses
      xen-netfront: don't BUG() when skb_copy_bits() fails in bounce_skb()
      net/tls: don't BUG() on leftover length in __skb_nsg()
      net: update comments that still describe the skb BUG_ON()s

 drivers/net/ethernet/sun/sunvnet_common.c |  10 +-
 drivers/net/xen-netfront.c                |   7 +-
 include/linux/skbuff.h                    |  12 +-
 net/core/dev.c                            |  14 +-
 net/core/filter.c                         |   6 +-
 net/core/gro.c                            |  11 +-
 net/core/net_test.c                       | 100 ++++++-
 net/core/skbuff.c                         | 447 +++++++++++++++++++++++-------
 net/ipv4/icmp.c                           |   9 +-
 net/ipv4/ip_output.c                      |  11 +-
 net/ipv6/icmp.c                           |   7 +-
 net/ipv6/ip6_output.c                     |  11 +-
 net/sunrpc/socklib.c                      |   9 +-
 net/tls/tls_sw.c                          |   8 +-
 14 files changed, 515 insertions(+), 147 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261016-b4-skbuff-bug-on-followups-ad11adf285a4

