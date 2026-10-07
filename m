Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0EE3806AD
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348984; cv=none; b=TwoOM8JGtJCYyxl3uhB4lUyOQPrh2s2X0/pRu6xw5FJiqE98P2Wf6sbtg/OqSkmmaquJFq2s6y6nwcXFUJ35AxlQDr53OZeoNh/2VW/ptqQdhD4UWPF2FOu3JtGQmnDM7f+z8Jngk2Vlbxt2KK8fLvsIogLmVvk2cxJKre9sXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348984; c=relaxed/simple;
	bh=YTagIdj57CL+e7tWVBMZ7SdBEgUALkTRuRZewf5gHBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l376+5yJexJux97zEkNqgOdVt01PuVga8UxOKm0AC9ohQ3naGJxRiQUcLkApURcRxfDrZ4G0cDbnFzLfICMd43moH3WSqIKnsqM1XmRHoJ46pJ+gTpGV3b+HMSdt/M+kp3uNAe8xX473x0dq2Yjh3egshGMRykGQMX0H5TNTpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDD8xJW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDD8xJW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47361F0089B;
	Wed,  7 Oct 2026 04:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791348983;
	bh=mAbTuNvk8mupf6rlBIZU/8xZA92Zs8tRmAuD+dQdpO4=;
	h=From:To:Cc:Subject:Date;
	b=nDD8xJW1GWFAFWcy0kKgZwXiUOe5dg9SMEiSZJapUSn1sr8cFyT6CAhqMLO0619rJ
	 W+bi5iR/kCnrMh4j2kz9lihexwTZukxDxBrxl+YzFQt26uIbLUDc+4Z3d5nAmhJRmQ
	 RM7ACntDZ04dMef0k2T1XVIDEAv3AtNMO/YRqzHBRbtonwLs9dbHlDp5k3bslizlDk
	 F8VwJehs/JN//t+YmX58uBEv/uDYqHV6iQ9VHG/3+YH8vVYds9jQrAwlz1o4z+BANB
	 9FBsKUXmVbMqSrWCSCPGr+fbwTm8q8ZtfEDi+dSkjnQRwlHYatADksuX31DDYgS9/K
	 4Jv4MCwmuqx6w==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()
Date: Wed,  7 Oct 2026 06:56:15 +0200
Message-ID: <20261007045616.445596-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_flow_dissect() sanitizes the offsets returned by the BPF program
with clamp_t(u16, ..., hlen).

If hlen is bigger than 65535, the upper bound is truncated before
the comparison. For instance, with hlen == 65536, both nhoff and
thoff are forced to zero, even if the program returned sane values.

This is the same class of bug as the one fixed in commit 99bda1ecbd56
("flow_dissector: avoid u16 truncation of skb->len when computing
thoff"). That fix does not cover the BPF path, because
__skb_flow_dissect() returns early when a BPF flow dissector
handles the packet.

struct bpf_flow_keys stores nhoff and thoff as u16, so cap hlen
to U16_MAX before clamping.

Found by sashiko while reviewing the commit above.

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/core/flow_dissector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 27d8a01bc92306ff043389b4fde2d24af97d3106..1be6c739e3c718b4561195a20e49cc3911874af1 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1023,6 +1023,8 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 
 	result = bpf_prog_run_pin_on_cpu(prog, ctx);
 
+	/* bpf_flow_keys offsets are u16: do not let @hlen be truncated. */
+	hlen = min_t(int, hlen, U16_MAX);
 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
 				   flow_keys->nhoff, hlen);
-- 
2.53.0

