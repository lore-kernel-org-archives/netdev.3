Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862116;
	b=i3OtpLNnto2DZiu/nkQG/JvytpNNO3NDWpiTjSu/HwuMAX9BQecQi8v2ASc+AugMaNdI
	 1ayLgc2Iyc/F4f+c4kLHAMS7X4eSvgYVlvs6O18JqjUUW4XmIalt4lYWjoo5t2z4GCig7
	 pl4yJAPHASmT3MjdROF/9YS+cI/Dyfd8v06VPlsuBtwGQLyWi/PJT71oiIYm0ovdQbQMm
	 ZRBqPEiOhGldSSW0INFDcsNr1SHBD+pJjLxcNbxWI20GofTLk2dkEsZ45B6yQvvWjUpxc
	 u6PUrTbR0pe4/2pSiAdyzKeUG3Cz85XPMI7hPsJ240ozDwaJmzPGpwrnDosXQXPj9Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862116;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vWSeRVd1Hj3KnpOxfomH6zAovsc8iFP4PdLt+lQB+yo=;
	b=4y374AiYXRp9Ithh1/dpsucOVMXwBTWL+D1yx0CwEQmIQaEfx1MgAm86/ChRrD6kL1B3
	 RWbEUtDWL6OtoeLaIuhPf7W1EnE1ZvrHz86XI8Npszn3T5c9GooDt/zpIl8c34VQlW0/7
	 T6+a3XJMUH0itBRN7MPli1W7zjeT2DzIw9Cz0Sd1LQu+YVtJK4SgtRoX621I84UOY5SH7
	 HpnqU4Km1PiM5jZaAm/exN8kCNNeg7a1hK7h5Ahu3G6HQtUCQkzrlcqH0qBuKhG9qgLri
	 un3d3C0OUOyqfVbqPUUHgFuHb5veeXyEdd6GARPrEHJCJrVGDmZwWdkX+EtWJyWG5qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DhYc1vI/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D08606A321
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhYc1vI/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792862115;
	b=VeentShz/wfli/7B853ekNli9eyIydibeBe1GSHyERH3F3z/m4NOA8/YyXQ8e41gE12v
	 UtE28KD+VLAmimnlDTykZCjHGL7+d9ujwR5LrKrzOnIUzPrLSxsqNPjEaq4SJgkKYPTEY
	 lgalC85ZFlIEYa4Pq+QLEIaLbsIcqMxJEs6k8ZXnogHXVYY3akZWkY8+9CyBaV3uHeSqG
	 Okq+jIf7LOQx5iztbT4ciQjl59NQDPZzf3vuTSTOwDWqWUDtITJ8B5GRmdOwc0yuE2mGw
	 NsdbyBjBfFoJKPB55R+PBmXPpwtqJQtkDocwWxOtTPvJ9jg0wViVLZ2A3LwgMsyW2sg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792862115;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vWSeRVd1Hj3KnpOxfomH6zAovsc8iFP4PdLt+lQB+yo=;
	b=BVd0PTeW0sVnh0Bw2cJ35c3UhOoIPGCyeAZlY4zkY3GFSxucO2vBzhT8LLQ7hAtW3NWR
	 tpafsMHF+p6AVJJ6SZHxRXexse2MfoSjR3CuAXnUKvb1SULqNfu7Eu8HtpwCijorq+YFj
	 men1bCB4Q14eTwIDZ3PeB80qlyaMOp111/G/diUc85H8DV5VDq0pRU9zqYcl5wBii6/sb
	 Njo8oV+BxmByfCBesV+GUfdl4fzBbdDRS42gPMUAUStJPWIChQEgaq4rzWrxiC3rJfsbd
	 z7/fanq06ccrlqEdhEJgmnsNTSgYJAsrSducM4ii9lTYfF6mkZCEQVDZ0gQy/H2DbyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C545F1F01828;
	Sat, 24 Oct 2026 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792862115;
	bh=vWSeRVd1Hj3KnpOxfomH6zAovsc8iFP4PdLt+lQB+yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DhYc1vI/4YYtSg3Kjx+6ViOljfFFS0evIPMmq2B8HuD3Vs/fYUo0xbULRE8c3PYvD
	 lvHPYs5hsI+JhxAiSCau0k4kbpNJpD1A3EArLpfExdjMjf8Ub5wuUUX7wqjjJ3F1j8
	 KYgFyG6U0tJqS42m/acfzzPSPNZ2t0CQCQbqpmrbY4JxGwiyOtQVMJ1KuzkiEIZLfr
	 5jA16DtC8yntRIUa0MUuhC5x7qWYiiF+jIvY4Xw3QNOO2mhscyQS6K6XV+bWDaWEAv
	 9l0rosQLPP5BNj3XmsVftXPZ/RuNv9onXqQ96IceF2k0tC/vbCupKVBPg53FNvKP3i
	 S4QDKr3u6C2iA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 33672447E4;
	Sat, 24 Oct 2026 17:15:14 +0000 (UTC)
From: Demos Ra via B4 Relay <devnull+demosthenes.ra.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 00:13:55 +0700
Subject: [PATCH net 1/2] tools: ynl-gen-c: handle classic notifications
 without a matching request
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
Message-Id: <20261025-ynl-ntf-bucket-v1-1-65aef308d62c@gmail.com>
References: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
In-Reply-To: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
 Demos Ra <demosthenes.ra@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792862112; l=1950;
 i=demosthenes.ra@gmail.com; s=20261019; h=from:subject:message-id;
 bh=QMYy/9g8848X9S1LCXRZkDwcKaSb1n2GG17LJZDrReg=;
 b=B7MGblZ4U2cEctXru7+Jc/y/mlJ+At6eZMUYUFfmht+6h6XQes+WI8ac3Wv3uE8boO7co+RfR
 Gy9d4TONzdmBNDKtNX377gQNXpbVNaodnxVkfP8/36ERFAU4h8qXaZ+
X-Developer-Key: i=demosthenes.ra@gmail.com; a=ed25519;
 pk=sDKS9AI9zxhWgOqkhc9EOIo6cky+anqccB3VGtDvzCc=
X-Endpoint-Received: by B4 Relay for demosthenes.ra@gmail.com/20261019 with
 auth_id=1235
X-Original-From: Demos Ra <demosthenes.ra@gmail.com>
Reply-To: demosthenes.ra@gmail.com
Content-Transfer-Encoding: 7bit

From: Demos Ra <demosthenes.ra@gmail.com>

For classic Netlink families the notification table in the generated
user code is indexed by the message type the kernel sends. Since
commit 49398830a4aa ("tools: ynl-gen: support CRUD-like notifications
for classic Netlink") ynl-gen writes each index as the name of the
request that has the same message type, and fails if no request has
it:

  $ ./tools/net/ynl/pyynl/ynl_gen_c.py --mode user --source \
        --spec Documentation/netlink/specs/rt-nexthop.yaml
  ...
      crud_op = ri.family.req_by_value[op.rsp_value]
  KeyError: 116

rt-nexthop's newnexthopbucket-ntf is the only such notification: the
kernel sends it as RTM_NEWNEXTHOPBUCKET (116), and no request uses
that message type.

When no request matches, write the message type as a number, as
put_op_name() already does for messages whose request and reply types
differ. The generated code for every spec in the tree is unchanged.

Signed-off-by: Demos Ra <demosthenes.ra@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 4aca51396a9e..a009a842fb36 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3409,9 +3409,11 @@ def render_scoped_consts(family, cw, scope):
 def _render_user_ntf_entry(ri, op):
     if not ri.family.is_classic():
         ri.cw.block_start(line=f"[{op.enum_name}] = ")
-    else:
+    elif op.rsp_value in ri.family.req_by_value:
         crud_op = ri.family.req_by_value[op.rsp_value]
         ri.cw.block_start(line=f"[{crud_op.enum_name}] = ")
+    else:
+        ri.cw.block_start(line=f"[{op.rsp_value}] = ")
     ri.cw.p(f".alloc_sz\t= sizeof({type_name(ri, 'event')}),")
     ri.cw.p(f".cb\t\t= {op_prefix(ri, 'reply', deref=True)}_parse,")
     ri.cw.p(f".policy\t\t= &{ri.struct['reply'].render_name}_nest,")

-- 
2.53.0


