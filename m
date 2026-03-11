Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163B3D300E;
	Wed, 11 Mar 2026 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225981; cv=none; b=nI87EDQP2j74KhfiCXqJWYnldGQ6kNqYoJ7unppPfpIT73ONjlPhPfjQNuTzu8RVgPXgfIbL9nf37Q4WPKzCkwW7Nd4R30VqK8noZzmOeG4TnUhkvB7+rW5EW2Uq18tnlhGir4HUVVnNjpOBnejxD1zXf8cZa02UlwYlgSgwON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225981; c=relaxed/simple;
	bh=S4vp4JQ72s3eWuG8J9mcgxDfPnpnYZ+oZQ9woXEJC0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuGJbYKb+zBWCc6g/nfsl/BvDpOBUz6dWDsYZtNuUfpTZWWx6MedCBpC9ITw0u17KezLLIrSG0Y9Hx8dfhDPo9f2ivZnDt5hIFsFPORRX43zIcrxaTceu1fNM7FUfp6FlukJT/rcIf24YQdgPnW9oTc45niL7oP9gp49FIFYVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFI8zgRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFI8zgRe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8D9C2BC9E;
	Wed, 11 Mar 2026 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773225981;
	bh=S4vp4JQ72s3eWuG8J9mcgxDfPnpnYZ+oZQ9woXEJC0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WFI8zgReLTJN4ms/ySDgTxTe9EDJrmbFfD9ax3jsBKTyYYi0DRfL0O9jPL7eIbAM8
	 ub2AaFXhMV8ojr9+ZYB0psxVZiRf3PdV227qovuTgyk+KyEb6yOhFnl9a8B8E3Uofy
	 ZjCT/paqMAbdARzz93cgL5E99AXcAroDqTQSCFocD+3+llOcKVxvbW/MwUCpskuHil
	 ZAko0cOiaWNqHOl8Clsre7sx56HeyFHjiW+Y+lc7Aw+PMCmSlG5yeyLTkQ5O+LX7QE
	 IY3W3788Hqjej678LjpCtkjA+JyeBuqi8bXBc0qH9mP4hdVPXBRayPlWBZfh5njyUA
	 HWfkYYd130cXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F39E104C003;
	Wed, 11 Mar 2026 10:46:21 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Wed, 11 Mar 2026 11:46:18 +0100
Subject: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions from
 fl_flow_key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
In-Reply-To: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773225979; l=1808;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=XHxAavS3OSIr6KhDGV4nKk6jIBOKNR2K6BPZWurwweQ=;
 b=wH1zISXh7Ry363esXvi+pN2gsBRFcZGZboEw2AXtTTunHLYG2RdVol4+tky8X+kPOPfRVjxRj
 J76t90gItbYAB9BWhP6ggWYannW3PgclHPAZWqafwxP5EgarJ6GaHuZ
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be

From: Cedric Jehasse <cedric.jehasse@luminex.be>

When creating a flower classifier with an ipv4 address the
flow_dissector has both FLOW_DISSECTOR_KEY_IPV4_ADDRS and
FLOW_DISSECTOR_KEY_IPV6_ADDRS bits set in used_keys.
This happens because ipv4/ipv6 fields are a union and
FL_KEY_SET_IF_MASKED() will interpret either being set as both.

Removing the unions fixes this behavior without needing special handling
for union fields.

Example of a command that caused FLOW_DISSECTOR_KEY_IPV4_ADDRS and
FLOW_DISSECTOR_KEY_IPV6_ADDRS to be set:
tc filter add dev p1 ingress protocol ip flower skip_sw \
    dst_ip 224.0.1.129 action trap

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 net/sched/cls_flower.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 7669371c1354..b95dbe847dde 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -59,18 +59,14 @@ struct fl_flow_key {
 	struct flow_dissector_key_eth_addrs eth;
 	struct flow_dissector_key_vlan vlan;
 	struct flow_dissector_key_vlan cvlan;
-	union {
-		struct flow_dissector_key_ipv4_addrs ipv4;
-		struct flow_dissector_key_ipv6_addrs ipv6;
-	};
+	struct flow_dissector_key_ipv4_addrs ipv4;
+	struct flow_dissector_key_ipv6_addrs ipv6;
 	struct flow_dissector_key_ports tp;
 	struct flow_dissector_key_icmp icmp;
 	struct flow_dissector_key_arp arp;
 	struct flow_dissector_key_keyid enc_key_id;
-	union {
-		struct flow_dissector_key_ipv4_addrs enc_ipv4;
-		struct flow_dissector_key_ipv6_addrs enc_ipv6;
-	};
+	struct flow_dissector_key_ipv4_addrs enc_ipv4;
+	struct flow_dissector_key_ipv6_addrs enc_ipv6;
 	struct flow_dissector_key_ports enc_tp;
 	struct flow_dissector_key_mpls mpls;
 	struct flow_dissector_key_tcp tcp;

-- 
2.43.0


