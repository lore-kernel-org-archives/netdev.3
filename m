Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54446468C3D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911122; cv=none; b=ddP2n6QHsnoUl0sS133eDGaoilun02Iq0gEX+Iv11CKTMCtuYfcV67h3oOhkFtvZIDhvCIqMajRsgGh+MJaWbbhro1oFFltiP40YpbhiqwYt0DJQtUezCW1U7xuhmkcgaAQJycClre4vrPiHsLkh4PNfIKfD4qymBuRenQ/CkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911122; c=relaxed/simple;
	bh=hotybtSbsQBNd1PJoAPelq/tgh52ZnwI56VfFV3i3eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0yMC8d5tS1KiSXiVfbYwtHdQeCEAp+uLm70oAKAFIk1kwpcC+ahXqrbl9+0KyPqA/02UdtjP4JyyMo3Iak+5P2qHvfu9p2X7GeztfHz7dNvMLlW6S6bV0ye8+auhFI+T+SfnSd4E5HlBlPUkr+hvoiacXJ4LE4KQQH7VkcfdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXMMAaWP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXMMAaWP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9399ec950caso258716285a.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911120; x=1789515920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGeRVFj68octQZ8KoKtzEyWU/+FN9IgTUp6CFSRRfvE=;
        b=dXMMAaWPSxsrB0W4YZWNAsbPKifiGEaTyq6tVadyG7Zr506kB0U+JL8cDRU88EmKzL
         etY61koEigrtNdh855uKCDlBi98J8fon11oKNfR4GuJn5DrtumuYFf8jrZMS6oiSc9jj
         gIa2vkC03BPT85AYgpmm7nNzv16CK6MaXARfeJDdNc4bqwjEDQRkbbe9sFp2xW1QC3i4
         zHiJXdUJ/02QYideB6KY3dyoDf5wwWBLOxug1cS9a3bkONu+/VnhWEhbEIO+PpzQe5Nl
         rrAaLw5fmgkQpmDhQCnI3AFqRpK16klJ1u/w557aJSnyZP2NrnKZJrIX0xrguGXB4bQY
         Tyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911120; x=1789515920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGeRVFj68octQZ8KoKtzEyWU/+FN9IgTUp6CFSRRfvE=;
        b=RF9ci+N9LsvUOYcTboy+M07/RfvsCpNg47XwdI7Fm8k1A1kGxVmm+2GVMaH29vKqAY
         1bfMoLBckGZ7e38UDfgHGYx9wSMn7pNIoPBgavXQPhNyxKMWT4bYhbgzeAXC8YcdCwSR
         NuaRdor48YVv5Cf6p7sQenoriDbdOqdLz0NgxKt4fTaXyTLWotg4855shjMwQ2anIkhH
         FUJZeutHOcBK2GC+qvWEZhdFs20Jr2buNNHA2//J2bQaXfR0qANA11pHt6DdhUTZGUIh
         lGsS7Uw2P5cXzlpu1LN48EARyH4ZwRL+9SCxHwwSxdY0sFdjbxTreUXm+1EnkVXMOdJn
         /k2Q==
X-Gm-Message-State: AFuF++nmxmBR9PB1x4VTLXZv1NfCNfkwGzuEOnnpFPgA5dutVLA0jpai
	1Kax3KCPr9u+RwqK98qiIOrRkkSt0Mi2ZEQHbGp7wRj+MqdUfb4jHnRt
X-Gm-Gg: AYBFou10YliWQRVN8YwsKwYomg4KjeCoEshPAFwy6ac3tWj9SzLFS1YsRtXhY665/L+
	Wk1cMlbhpvYBJPT080fSlrPbuXNJ5Wps7VUl9LuRJTkNqbjhDv33o19KRKJpJNTirA7ckhRab3b
	iFP5CsIGCkis/b1s1Y/NoRVQWWMBmZxrRIKIm95DC0vTCkqNMPZmgVdlXqQVyNm8XP3CEcIFAY1
	XGQGN42Z4xu66/RaBVbHUVOILPUREz32XXIAqbgKaad4xIog6Uv5bJdFQpJvSLKQDLAdxhiL9kZ
	ATqhP7ue6JoZHDiLLCUINlIn4JZsoNuAf39+iT35g56wKWM+S7v0CikMmArXmnbZn2AbkGYmWsV
	3c8n89ivjJ13Xp913+X8EOyNrTgel8OFdeREqVMlG/7gE/g2deFLK6ds3WB+nvpq4OXmbN7oGfs
	wxqXLi9rS0Jjul9EBkHZwaRSBhXfaYyIpZHGd5gRdMfQHbKN+RLvUQwV/qDZlN8lzk40wvgrnGu
	ctooyDrpZcfUsGe2qlA
X-Received: by 2002:a05:620a:2856:b0:92e:6c15:24cd with SMTP id af79cd13be357-9398037a018mr3290546985a.15.1788911120013;
        Tue, 08 Sep 2026 16:45:20 -0700 (PDT)
Received: from elster.cvl.swallow.glass ([2606:8e80:692f:3320:980c:c29f:b4b9:c06a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939aff54ae0sm551872585a.8.2026.09.08.16.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:45:19 -0700 (PDT)
From: Taylor Bates <tmbates12@gmail.com>
Date: Tue, 08 Sep 2026 19:45:08 -0400
Subject: [PATCH net-next 2/4] tools: ynl: reject zero-length attributes
 instead of looping forever
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ynl-robustness-v1-2-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
In-Reply-To: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Bates <tmbates12@gmail.com>
X-Mailer: b4 0.15.2

The following bug was found in the ynl tooling while parsing
MDBA_ROUTER_PORT entries on a real bridge device with IGMP snooping
enabled, not through fuzzing.

This occurs if the parser walks into a nested attribute containing a
headerless entry (such as MDBA_ROUTER_PORT) and reads the ifindex
parameter as a length, rather than data.

If the parser reads this now misaligned data and parses a field
containing a zero byte, it will run in an infinite loop. It will
continuously append empty attribute objects and consume 100% CPU until
it exhausts the system's memory.

The most straightforward way to trigger this systematically is as
follows:

  1. Create a bridge device with multicast_vlan_snooping enabled.
  2. Add a permanent multicast router port to the bridge that lands
     on ifindex 8. (The mcast_router 2 state ensures that its timer
     is zero.)
  3. Feed NlAttrs() from pyynl the MDBA_ROUTER_PORT netlink payload.

This example creates a bytes object that reproduces the same shape
as the payload:

  msg  = struct.pack('HH', 8, 1) + struct.pack('I', 0xdeadbeef)
  msg += struct.pack('HH', 0, 2)
  NlAttrs(msg)

Fixes: e4b48ed460d3 ("tools: ynl: add a completely generic client")
Signed-off-by: Taylor Bates <tmbates12@gmail.com>
---
Full reproducer, run under "unshare -Urn" so the namespace starts with
only lo and ifindex allocation restarts from 1:

  ip link add br0 type bridge vlan_filtering 1 mcast_snooping 1 \
      mcast_vlan_snooping 1
  ip link set br0 up
  n=0
  while :; do
      n=$((n + 1))
      ip link add d$n type dummy
      idx=$(ip -o link show d$n | cut -d: -f1 | tr -d ' ')
      [ $((idx & 0xffff)) = 8 ] && break
      [ $n -gt 200 ] && { echo "gave up"; exit 1; }
  done
  ip link set d$n master br0
  ip link set d$n up
  bridge vlan add dev d$n vid 10
  bridge vlan set dev d$n vid 10 mcast_router 2
  bridge vlan global set dev br0 vid 10 mcast_snooping 1

The BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS payload the kernel then sends:

  34 00 02 00   MDBA_ROUTER, len 52
  30 00 01 00   MDBA_ROUTER_PORT, len 48
  08 00 00 00   bare ifindex 8, written by nla_put_nohdr()
  08 00 01 00   MDBA_ROUTER_PATTR_TIMER, len 8
  00 00 00 00   timer value, 0 for a permanent router

Read as a header, the ifindex claims eight bytes and consumes the
MDBA_ROUTER_PATTR_TIMER header along with itself. The walk then lands on
the timer value, four zero bytes, and nla_len is 0. full_len is 0 too,
so the offset never advances.
---
 tools/net/ynl/pyynl/lib/ynl.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 8682bf588e1f..375a15d83a34 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -317,6 +317,10 @@ class NlAttrs:
 
         while offset < len(msg):
             attr = NlAttr(msg, offset)
+            if attr.full_len < 4:
+                raise YnlException(
+                    f'Malformed attribute at offset {offset}: '
+                    f'length {attr.payload_len} is shorter than the header')
             offset += attr.full_len
             self.attrs.append(attr)
 

-- 
2.55.0

