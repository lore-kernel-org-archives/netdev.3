Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805914F93C3
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417856; cv=none; b=glaAiihCpWZujUMb3q2waulYXRmMs70AUCH55nNTvB3H+KwWl3in4GNsEvWI40yvdiHuhKT9DE7yIamUthiR1fPls7gi9hJWpcTQ5IA84PQO+iRpzW0zYJrN4VjVGf6cSUxJtl90n7TIJDcsRwVC0VBOrPdxNtBB2j7Xszf8hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417856; c=relaxed/simple;
	bh=KIaS3RgzIflnJVbs1aR2xV1e37kN7pyP1TLRgrxxSDg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GnRTg5ZnpiISoPOZFd3z5H6zH2q/gPgce3tyir65UwTEJICWK0eODpaDPciC3dmyQuLy7nzsQeMXxdpJQ38dTG5saXeOZkssODB7DxkTxyLAbf0jrVv2cIBK58HW9QJ1Nx04kt919vJgIfTkTChxuFnXgVDvcxJDxk36n6qY9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=eHf6RBBU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="eHf6RBBU"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53639b8903bso30458261cf.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417853; x=1793022653; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YreDSl4vDqbNAVIITvhajgrdqUJ1n9sK10J0+0ZRYE=;
        b=eHf6RBBU+P5vzGCSeXNZu/gHRSYSKkiSa9YYFfZlM/jMxDQkoEMsTalGfp9g/Jl4A6
         A/VfxrNhFxgsI0/Y5FHrhDCUSIuPtSxKQ/0w2LOexS4KO3fjS9fADKeQtlF9VdNI2dY2
         6TzdtuTsX/dQtcUov/Wwwswz4LI+t4sjHcSNCiFS7bsqSrixwyq9qNuJ411MC3NzSzQS
         w/x8p6pG40Xy4ARFDxybseyQ1uMd39AfVjzBpGpgqkuO8Gs6Fub9L9VK9C9kuZJsALd6
         FiGmLO5RVa1sax3T8Wog9mlNPpgi7YIRJK918mDc/TGdxO61+J5tYQF/E5xIKt074uij
         136Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417853; x=1793022653;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5YreDSl4vDqbNAVIITvhajgrdqUJ1n9sK10J0+0ZRYE=;
        b=MOTiwYDGvGin9Te/DVX6ivCXKkr4QrxGwbKvVvKOI10KCPh36FPdmMF54qU9xtClMB
         kMWLH6DVZ5xYJQ54lUXcPsmWChqqBhaV7EjhE7YcgIZjFo+cHnr+nRADwht0181B416Z
         vLQKnLrrWCzMdrPoo4uFxnz6zLop4H43jEm7QWhD62982Ma/eieVnf3J8LF/gDHHg5Bb
         5IQh3R+/e4nWvaBHKjT7PL8iIDc7n6+V39CfDuFjcrJqh6xAOWLx6+Z0xfzqqcuOgFM/
         7Q9DohuvnPIMaVemOBWu2bS3pfSis2AQ0xIcKekaHVRiLfipjvJgD39RRV5HkA78TjSB
         WE/A==
X-Forwarded-Encrypted: i=1; AKwUvBzRHuH+Q/RzyOMShZKtjxs93PANvPGmpf4UF2xHiyHoy9IztLWOQNB8LYkRS7mn+/36zEe8ZCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZwl0I8nbj2mWAk6A/bNF8p+AzOX4z8EwfJxa41VDonla7SVWY
	S3Hf119bR5W1PhODaa8gywNkGuoxjirScFvyJ3dE8hRK8vSlUQzFILMY+clKIXRD6zE=
X-Gm-Gg: AYBFou3m5UdlQiGmXV6UDENeAxy0gvUt3u9f9J406PdxS1bLezt8xJZlXRYvWtGiNqW
	JYbLVFwmr1kH0Erow8R6GU0DRj/+gMV4wykayqEHhvMHmAD2BC6Kvjyg2PbAN8RqdrHuyntt2LC
	Rpj5LS3uy+CTWJxaU0wQvpN7Df+Sx53xA/lLqg8cLZ03o6dwjVB/F6pcAuCKohNmEVQMKMmOgC6
	6mr5/g8M19vIRJsv6pfA6bCVcBnXyt3LuI5FHu1HkY2cbY+kG0ARNl2oJugocGi/iLNZQDBuurG
	PiLrrO4kV+BZzwv/or+/MoX9/Eb72Fj5PM9H0P5CnXEaFRQU6FHSBXVzmYoKI5rsalX/4K/OEAy
	UEnSbLscqed7BGwq8BW3jLMrb12ud2EWkXYbqxK5GBJhVlh5dx5Yj1bYdxYf5ZIiLRTAOMIcsNI
	Z9RcwPTd/uidpclGcNlT29laf+kdlbLM+LAXuV/xk6O90KaV9tiqReKsHP1GhO0kaGgp8sDQG1h
	dhNwuLnzCzDaK4=
X-Received: by 2002:ac8:5d11:0:b0:51c:b98c:f772 with SMTP id d75a77b69052e-53645fedd9emr99044071cf.15.1792417853207;
        Mon, 19 Oct 2026 06:50:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a9dbdb5sm99677641cf.22.2026.10.19.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:50:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next 00/15] net: skbuff: follow-ups to the BUG_ON()
 removal
Date: Mon, 19 Oct 2026 13:50:34 +0000
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACwg1moC/3WNwQqDMBBEf0X23EUjqZT+SukhqxtNK4lkjRXEf
 6+x5x7nzfBmA+HoWOBebBB5ceKCP4K6FNAOxveMrjsy1FXdqEo1SBrlTclapNRj8GjDOIZPmgR
 Np5TpbH27Gg2HYIps3XrKH+B5Rs/rDM9fI4le3M7ZnbdkhJGi8e2Q0TiVpMsT/nmDff8CfBxvY
 70AAAA=
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=4198;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=KIaS3RgzIflnJVbs1aR2xV1e37kN7pyP1TLRgrxxSDg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG9I0MA4oB2pQusLHea7/1MDYYSfacfAuZk3/f5DoGX+4zhJuIDA85OltKcTqezTiJ7GjwQMaYR
 jFfuEgK6Q9Ag=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

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
Josef Bacik (15):
      net: skbuff: make skb_copy_and_csum_bits() report unreadable frags
      net: skbuff: add skb_checksum_full() that reports failure
      net: skbuff: fail checksum validation when the skb can't be checksummed
      net: skbuff: fail segmentation when a segment can't be checksummed
      net: skbuff: fail pskb_trim_rcsum() when it can't checksum the tail
      net: skbuff: add skb_crc32c_full() that reports failure
      net: skbuff: let skb_zerocopy() copy a short skb without head_frag
      net: skbuff: make skb_try_coalesce()'s len unsigned
      net: skbuff: check csum_start against len in skb_copy_and_csum_dev()
      net: skbuff: reject a negative length in skb_copy_and_csum_bits()
      net: skbuff: refuse to segment a nested frag_list
      net: test the frag_list layouts skb_segment() refuses
      xen-netfront: don't BUG() when skb_copy_bits() fails in bounce_skb()
      net/tls: don't BUG() on leftover length in __skb_nsg()
      net: update comments that still describe the skb BUG_ON()s

 drivers/net/ethernet/sun/sunvnet_common.c |  10 +-
 drivers/net/xen-netfront.c                |   7 +-
 include/linux/skbuff.h                    |   8 +-
 net/core/dev.c                            |   7 +-
 net/core/filter.c                         |   6 +-
 net/core/net_test.c                       |  52 +++++-
 net/core/skbuff.c                         | 274 +++++++++++++++++++++++-------
 net/ipv4/icmp.c                           |   9 +-
 net/ipv4/ip_output.c                      |  11 +-
 net/ipv6/icmp.c                           |   7 +-
 net/ipv6/ip6_output.c                     |  11 +-
 net/sunrpc/socklib.c                      |   9 +-
 net/tls/tls_sw.c                          |   5 +-
 13 files changed, 327 insertions(+), 89 deletions(-)
---
base-commit: 6b3e73774815910a39d8ca75b9ad7df963f61d50
change-id: 20261016-b4-skbuff-bug-on-followups-ad11adf285a4

