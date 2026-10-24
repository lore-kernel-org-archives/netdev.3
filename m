Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852137;
	b=qTCLH/u9kQxlZwwep4xWoJGNKLH/wnp30nnZeXE2GpNoEi2UDCZxxRBL/D6CmiSunqYb
	 AZ6+6QQvKlIUwm6yw1N1wFgqLdiSa1xCKAMOG2Ujqu/n4m+ITyTb+WIR8uCsBOllfP4KB
	 +//lgaUZ4KtOLHIROz6raBmttov6+lGfqp3/f12O3B2mWWm5muJkrB8h9fBQubhhU1738
	 HAB5QAJg61LMids2uIXEApw60oZJ+gJFHNjSFZEWZiC98wwmJGcX5Dn9s9d4KAD/PBWbK
	 Du8lao4IrRuQxC6e1g71SMoa9EYda+yVyijLE7jsVaTjeTUq1G4/bCsY1z8xt+4Qn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xuYAqvftjzynacCTLNgIg0wwHTh7boJUBn23V0yCGAQ=;
	b=vBcUZacC9iSWgUcBcR1JVdPszWd+IyjKLSbF0Xj1T6Eev4NSe4K2r4WIVpaKUGCRyp+k
	 WYK6dotQl+VS4w/w+s/141gHLjD5gpD7Ki8oO27ZheXXcXQ/pBUTpFutqUDEsR6LxHqSS
	 a+hOGPfau5Hz7rMM3tX23RyIo6xVUuitPJQopZiOhmWHfQ6o9CtQDtqUB0At6LrCmuNbI
	 4FbS/6rZGRgCSJ4SXiCByEOEkBtGsywPtiMt/KalA8iNBd6ldIcDtytsGCWRV1sLis0hU
	 NrYrsyOzOOpmeoZS+2jKoK/V+DRyLvhHj5ks3CXdm4iBK4GetTTE6L7gJhJegqeuJWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DGdsW4Br;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22960A2607
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B22960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DGdsW4Br
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53653e30353so6242771cf.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852136; x=1793456936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuYAqvftjzynacCTLNgIg0wwHTh7boJUBn23V0yCGAQ=;
        b=DGdsW4BrAohZiwSdkHIU4e/O/eFXLanlU31R4EZJe1h0+AhDNhmFObd7uFnFfj0+Cc
         N4jDUVpkemtiSJAsgbz7hUxSCg7uUHbb8NYbpXsWaDT6Es9tooivzcNjN4nNE9CnGBUX
         DPSijLLWJFX8ttsqJV/7oKsOTqfxcq8+ruMAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852136; x=1793456936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xuYAqvftjzynacCTLNgIg0wwHTh7boJUBn23V0yCGAQ=;
        b=miT48Jmrpo2wDlG0bgidPzxM67gK+XeUEKYyzppYwmnSkpCoYOxmjno10Qvk+LMxKj
         PLYkTqbrX/X5jXlCGxlfTlBQst3qanboZtjHKgvq20gDKGXu4oWfLwNntuQgIAsyc7xJ
         UzWXCuZsFOS70f2rupAtLcZ22sYe9cjf70Xo2n37d4bkX9FotWWBBkR9evvysjByp/G/
         yN10cag2KbrSWiSr+Hl0+Q4YTPxv7AuB3YBJjk3pmArLNJm1oXMkQAOtAPn4xWd+5UsS
         TRjfeyaje+T8VssHiWQqLOGL2cJtPZCIlAcLu6deaCpf5Evc2XQkBAei7cEr6+51IFzv
         kSlQ==
X-Gm-Message-State: AFq9FYKshc/JBHfCZxcPPyP34h0PR7BSHbVUFrfGZB30GeXhPBYiztGm
	MAyapZ7Fi6sa1oCJE9iNox+vsIjOTkrCLo3vpTRWZyQjQCjn8N3sZpQ4uIrUKajv/ik7jGfxYQ6
	EZQ0=
X-Gm-Gg: AYBFou28gDbSqx3bgcyLf/0aIang2zi9sK9Jj0x+peQTfZLK5LK9BsipNUrt6wLl6FR
	5rO+hXZqpCqTOWoZpIm37l8jwxSBPb6KR8Hku9e3chvvtBMMvXku7PP11/gjzQI417gJ/7YmwfK
	FadKO2LqwrrGCdpKvQbZF6cPeShlKvAQ8LkqAb0JzJ/YiiGLIk/iVAf7z/Rg00Dz0J0YbwXUVPA
	I1kNazUu/9hmgF0HskAEJ/D/6UFrJ8VY5VjgdY1NalkKUF7RByIYyM1nXJn9CmKzAzy6ftkBuEd
	u0pOfpfWTVFXDBW7oNj/mWeaffu9wVBsB3SjzHc/UA5F9N5qKPEpOlhXmqwtDICzJCpuIdIpRkp
	tzgLtbh+L4YXxyOMMGXVbc3Rhtnuhd5KRcWAQj0ZCOBIh9OKTmroUd5RVreWK+gf2qXTmaBBSIx
	MizLp7p8jAKgeriVLieg5jcqpgRaXMCaz6zTlGJWNpzCtvQE8Skcv2tN6su5EUjygWP+5NiZFSh
	fxVmWCkwEy9Z8Sk31HRhnhBUw7aGlpehZy7VZM8Fdc//n2UyVe0bssci0fn4PgndH3gduWWi7gk
	10KzGwsl5p1/+LTG7hcSeSz1/jGMSmx+W13fRcF4BQ==
X-Received: by 2002:a05:622a:90b:b0:531:164:fa73 with SMTP id d75a77b69052e-5383b554080mr28941861cf.32.1792852136437;
        Sat, 24 Oct 2026 07:28:56 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:56 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 5/6] net: openvswitch: ensure a linear inner Ethernet header on TEB pop
Date: Sat, 24 Oct 2026 10:28:40 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath now claims an Ethernet header it cannot access
linearly.

Output to an OVS internal vport then calls eth_type_trans(), which
pulls ETH_HLEN from an empty linear area and triggers the BUG in
__skb_pull():

  kernel BUG at ./include/linux/skbuff.h:2830!
  RIP: 0010:eth_type_trans+0x335/0x500
  internal_dev_recv
  ovs_vport_send
  do_output
  do_execute_actions
  ovs_execute_actions
  ovs_dp_process_packet
  ovs_vport_receive
  internal_dev_xmit

Conditions to recreate the bug:
On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
packet with one bottom-of-stack label and actions pop_eth,
pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
label, inner Ethernet and 4096 payload bytes.  The two pops consume the
linear headers and expose the inner Ethernet header in page fragments.

The Fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.

Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Aaron Conole's Reviewed-by.
---
 net/openvswitch/actions.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 27152bca8a8c..03b31e33e880 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -153,8 +153,11 @@ static int pop_mpls(struct sk_buff *skb, struct sw_flow_key *key,
 	if (err)
 		return err;
 
-	if (ethertype == htons(ETH_P_TEB))
+	if (ethertype == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
+	}
 
 	invalidate_flow_key(key);
 	return 0;
-- 
2.43.0

