Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A371A9F87
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449640; cv=none; b=e2G8g6ps7xLuh6Xfai8JTb6ws05HsRsVR5p05CgzcjPukkwXO1HRuSJWU97yFixh7ZliqC9SfYSFuDAwq7PLu+kcrDSQrKpkTezFd27uI1y3Pox7pN6vykJEQ23eZrn1kVfieMDkJbIlzebk0Gno3i80yF6SuvC6wOWj+Btjrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449640; c=relaxed/simple;
	bh=1XA04OMasEvcQGTaU7JzGlnfaWDhh0n2i98axrtVDrA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ae7qDhMLOFYKcPk81jgSJPTiJ/Nl/LsC0d3wTvGeUrwVR/rZaNvbP8ZazT/xqAFBxgeR6ww7C+YdcaTwpe2O0jMlfSOwFf/xsP2Hok/guhu2beBRtifY/YwBbHMO8gG+mO2AuuIGJA2fzdocP2RpZQMSd7obs3JontnZJFXwRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpyvHnTz; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpyvHnTz"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50fba8d8c40so11673281cf.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777449638; x=1778054438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wC8AYkUXPDgGEFvJ2Vifue2AUVg0Os0iG7aeN5r8bwc=;
        b=mpyvHnTzLM2ECphc5yuHcuEVgS5kozOX/eQgoZLvWasirQaVyTC//F4x1x0FaW8IJN
         1eQmZDFBZj1OJ5mdtZj+TVEvCfbt0MUh8/I+KKtiM33Rd0QzIuaSR5fk7HLF37/EmvZV
         o5poAuB3ynbMqx0Rr0uzr2YoB5ygXHBsHPl5UO6SlrbZGi0hId2XBFgRx+jI2goo3m7k
         iiTQq7ZbSWvJqV79JaYb17MS2MYHoqc978TOBOyrQ4NakNZiMJnmx8Ksa5jtY+XO0XAC
         mh9Vl4PY1+QiFCgUcGm+0Fu3qR3BaQy7DAqv/JtXIZSoQLk8DEVoWWPG1Z31O/7ez55M
         bf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777449638; x=1778054438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC8AYkUXPDgGEFvJ2Vifue2AUVg0Os0iG7aeN5r8bwc=;
        b=rSA07bTARQvdaHRAkLwqiBz5ew7gYdV7VFBf+yCnY/h6FxU98ZWAV9DPqKaA5PKbtL
         DfiRGTmuhpzEhKkCfXM2HT8j7YXir533eIC+q+qCGhrGcIAclnSo94lQzIl2fAIXvMzY
         vs0P1Q38YCfS7XvrUYe/0DOrEGI7SSB5jL/2cXFoOhY/b5+/twrnVS9mzx55XGHqmm1H
         FCKdmdPW+XKFT68PiXSBpJt9GFGqYH8PD7Wm98Ea5VmolCdpQMRCNgQAJdoqNzwsy2hK
         ZdhykdCvjUObM5H18dtE9WaQ+9NkLISR7pmgag+MbQuyljDssGSH7K3IQpZi1lbAawGZ
         ZwQA==
X-Forwarded-Encrypted: i=1; AFNElJ/jYKio6FO0yoqvtoOUD6usQ6sSwECO1uSxz/igx8K2bof1Up3dodeKvlwXDDB2AyruNahKD9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIJQ6Yw6Nz4eaIfebnJN9Ui0sDvqYB/ieOv5gAALnmgsXrYlY
	QYZL9/GUDCBkldmciX6dIOILXmS+CPmpgok2sjge3gy8WK8dpQBtls47mFjYVpMhZI3qGTGbefZ
	uardalAeqcuhLyA==
X-Received: from qtuu7-n2.prod.google.com ([2002:a05:622a:aa47:20b0:50e:5a17:f022])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1355:b0:50d:9204:4652 with SMTP id d75a77b69052e-5100e1d0764mr94771131cf.41.1777449638251;
 Wed, 29 Apr 2026 01:00:38 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:00:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429080036.1528533-1-edumazet@google.com>
Subject: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This test checks syncookie mode is able to reconstruct some
client options when TCP TS are used:

- wscale option.
- sackOK.
- MSS (in a limited way).
- ECN (not tested, because of limited value).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/packetdrill/tcp_syncookies_ip6_9k.pkt | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..15d03992a99140ecc4241edae58693dc5098fece
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Check syncookies.
+//
+// Check we are able to rebuild client sack, wscale and mss options.
+// IPv6 msstab[4] = { 1280 - 60, 1480 - 60, 1500 - 60, 9000 - 60 }
+
+--ip_version=ipv6
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_syncookies=2
+ip link set dev tun0 mtu 9000
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 10) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 8940,sackOK,TS val 100 ecr 0,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 8940,sackOK,TS val 4000 ecr 100,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 1024 <nop,nop,TS val 110 ecr 4000>
+
+   +0 accept(3, ..., ...) = 4
+
+// Check we properly infer from the final packet the other peer wanted 8940 mss, wscale 10 and sackOK
+   +0 %{ assert tcpi_snd_mss == 8928, tcpi_snd_mss }%
+   +0 %{ assert tcpi_snd_wscale = 10, tcpi_snd_wscale }%
+   +0 %{ assert (tcpi_options & TCPI_OPT_WSCALE) != 0, tcpi_options }%
+
-- 
2.54.0.545.g6539524ca2-goog

