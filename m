Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833973;
	b=QKOpZ0NI21wLK501OR0+gvMLYyeH74s1V01QTbj+7HA017h+tD6tnxVzWb8/7KDF7THa
	 Q/cPzrpsC4MtWkKBlHO+R/ty8LQPXCqAar4+4CjqU7nRbizxXqtshAAE5hfooQOWN0zq4
	 o2LlbxNgdtbuy3Kk3nq8XFHsU3phKYbU8S0rQzK1iS1T7JEmgRgDsPB/A2n99kyJ0eJI0
	 +zCJvZ0ogL/aMzVwoRyVS2NYU7fmPRnUyQD9zejA8+JyUWY+x41U5qCxXU+UKTZnPyXbU
	 ZraVbXUisxl35ttkz9eNUuGKjIVG1Xp33S7+VRZzZm91FtB3+DKy71Uvhtc44LPC//A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833973;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=PfQbRiH7N5oOU7RTnzjOyhL076JRrhblCoGWOrnITl4=;
	b=JbMDAYqDqd4dBCBGPJEvw5lAdmHtsizQI+qjxxmfuXAiEt/HzL0zvqEB2aWS7BFXalXN
	 ZYX5Vl1BiCMKYgVMuTV6bps8J7o+L5taU5JScn+TEgvsvdC4DfMfkuBa8hZ0Bm0HtHSIJ
	 BEOrWyx3PKmS5/HXHceihQYge8pJVpnweomNgotBpStVHLWSyLbiJy92Lqn9yvcnpHief
	 ybqeH11XKawv9xDiZFjaS0CWbxPGf+leNyb1npntmfiwPWwQ7Uc0lVyKxEjwDzpSmOLY6
	 OFanoh8OxMtUfsypCXIP5T+ev+V81oZoBjUQVVLfxsaw6bXm7hasnD9dXL2NFHSQsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=M46WLbFm;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C718606A31B;
	Sat, 24 Oct 2026 09:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C718606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=M46WLbFm
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jBZJB5ZRzzFphR;
	Sat, 24 Oct 2026 11:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfQbRiH7N5oOU7RTnzjOyhL076JRrhblCoGWOrnITl4=;
	b=M46WLbFmpVyO2sWZ4TXizH0Rrs2VMuqL0DsgD1S0n2+EsieQFWu/ZBUdXacNzHN56aXno+
	uLXGonj45rJQeI5pUgp+DUDR3v6fSQdsG0OWlrf1guxc4F/i0DwkVtc+UX5KbUu0hFM2Yg
	mJ3s5XV2nVSt4fZg5Tdjgfnwg8xH2Ka6HrZAf31W6irDIXyi+2b+YnwZ5F+2J77lwSXaOU
	CDn70YWcoUYLgrbhEkOYvPNS2naqORvGfFlFWVq9updnF/CfR3gw/jf0IANKB6kKPU9E7N
	4WJzU3/MAbneCuWb74ZpB3cRBjpFw7tkRofXNM9RGPKTPhu/nv6RBtMYGCe4CA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 01/18] lwtunnel: track callback dispatch separately from return value
Date: Sat, 24 Oct 2026 11:25:11 +0200
Message-ID: <20261024092532.172005-2-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024092532.172005-1-ralf@mandelbit.com>
References: <20261024092532.172005-1-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJB5ZRzzFphR

LWT used -EOPNOTSUPP both as its missing-callback sentinel and as a
valid callback error. Track whether an operation was invoked separately
so callbacks can return meaningful errors without triggering the
no-operation skb cleanup path.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch in RFC v2.

 net/core/lwtunnel.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 8223c44f10c8..db21b9ff6f86 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -322,6 +322,7 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
+	bool called_cb = false;
 	struct dst_entry *dst;
 	int ret;
 
@@ -353,13 +354,14 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (likely(ops && ops->output)) {
 		/* Encap pushes outer headers over the metadata; drop it. */
 		skb_metadata_clear(skb);
+		called_cb = true;
 		dev_xmit_recursion_inc();
 		ret = ops->output(net, sk, skb);
 		dev_xmit_recursion_dec();
 	}
 	rcu_read_unlock();
 
-	if (ret == -EOPNOTSUPP)
+	if (unlikely(!called_cb))
 		goto drop;
 
 	goto out;
@@ -377,6 +379,7 @@ int lwtunnel_xmit(struct sk_buff *skb)
 {
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
+	bool called_cb = false;
 	struct dst_entry *dst;
 	int ret;
 
@@ -409,13 +412,14 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	if (likely(ops && ops->xmit)) {
 		/* Encap pushes outer headers over the metadata; drop it. */
 		skb_metadata_clear(skb);
+		called_cb = true;
 		dev_xmit_recursion_inc();
 		ret = ops->xmit(skb);
 		dev_xmit_recursion_dec();
 	}
 	rcu_read_unlock();
 
-	if (ret == -EOPNOTSUPP)
+	if (unlikely(!called_cb))
 		goto drop;
 
 	goto out;
@@ -433,6 +437,7 @@ int lwtunnel_input(struct sk_buff *skb)
 {
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
+	bool called_cb = false;
 	struct dst_entry *dst;
 	int ret;
 
@@ -462,13 +467,14 @@ int lwtunnel_input(struct sk_buff *skb)
 	if (likely(ops && ops->input)) {
 		/* Encap pushes outer headers over the metadata; drop it. */
 		skb_metadata_clear(skb);
+		called_cb = true;
 		dev_xmit_recursion_inc();
 		ret = ops->input(skb);
 		dev_xmit_recursion_dec();
 	}
 	rcu_read_unlock();
 
-	if (ret == -EOPNOTSUPP)
+	if (unlikely(!called_cb))
 		goto drop;
 
 	return ret;
-- 
2.55.0

