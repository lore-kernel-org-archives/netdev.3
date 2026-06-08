Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D9335BA7
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921334; cv=none; b=Axfd1Sm+Ew3TbrqWlTH27a6M41zETBgJLRVZ/PlLrmaMRku6Whs7CPNp94PjE1SzYyAGhCNHpdU6LimitMbIEynFRTO8iMoacnG5hTzYLvdMizNraQLfDInxGTSFq8svjmW39FPzaN9/kXcZ4u+1Ft/PnNYdLZG4l9Pc8USax3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921334; c=relaxed/simple;
	bh=ZNWWAVNfC9RmhryDBGopsCMLOBQ2uMLl+zRSZ1fBt4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnhSDfdkwI2UW71qL1NfwLEK50TrHAobfsrPd3XLtROutfBmYMS/ReMbNcHJwR6vQqN7u2dZe32ioVEzA9PxRp1XCJus+nYLHh+Kbx7bmMD2pINqsesPBHB9ydieZ8z4j9elSUfzaNxDFOcqKEcj1zPMF38JbjVHCU2EHAXNRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxZFyBSc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxZFyBSc"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51784eb2ba0so32150601cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921332; x=1781526132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPe7RROwML8YBDC9iBsnC3XTfs6XjaM8KgeZwP62gHY=;
        b=YxZFyBScln/mLqyJheMjmyadkd6svfhMaj+b9QqT3ZtoT6IuqJqpRGNDa8r/swzqus
         habZjfgrawnUZq3m1H2lAJlCC49mi5zJfitljqqSOSbpRjUvYRjY82A/FERrakd/oPrm
         CtvqjKIy6tWie9DFLtu/8qHprbvSEM6WE4jY+pNF8saqupI3TGypU9voYF9NY/nO8CUq
         hNyRQW0TciOuDGEGBLRkPyu3wgu1Eclq1ozR29OphJzwpg68ZpjguzoAE+s41vRk2T/7
         y4mKkqHQjJDyhrCiV2CsO9kSZ55HZVNMxAUrfYIDwuMfiQXBOcvxXSLXcS98sUi5XFIB
         w1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921332; x=1781526132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPe7RROwML8YBDC9iBsnC3XTfs6XjaM8KgeZwP62gHY=;
        b=llTbIoBrTirpM3UqubUpqgnkB6fKsNZhp0p6xUamBTyC2sp9X9q7szBu6K/PY4hb1i
         Wshe2xbdJNIBTuZYLNa+y8M9NeOgK3MJN0anWICJo4NzHREgz4d7JnTPsq2FPjFYVcUu
         VoeR+Ttk3MZxxh9Rg4ywpi1byp4EuUcT6dbwn958LqztLO4h11CB9xrS/n+gYd8mB18n
         HY1JxD1fSIgioz7rul6VKR6nwV8MV0NkfLBzBswG7oonYQa4Q0gZFOtX0mjgb9lmB8L7
         6TjH0DXCkIJY/my9UAU0qg1DgHNHq5ddD6EjwoYP/iqpYy5/1mnRkE/+jVOVepvN/p6F
         ki4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ZM5AcnILK/0w3NOtpL/bZohxDk090kQtHeGYP7Hyvc1W12+3zp5e2jJoX+y/J/YXrQzmocgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEc3fs0z1+/F8aEUJwwnk9PGOvG3t23e+yneIIrpQNnMj0pDPk
	NdLhrbeqWB6bGPHuORR5s4DGwwIFFXvDXStY1QLlE/J72UcsKVwVHMl4
X-Gm-Gg: Acq92OE0HPiljZgM2g7LkuDKapHSlQbJp2m5cgbqN3+r+iLu+q9KzJGVj0r1PN8pu3Q
	wS8uMdCduKmqFCb+jM0xS3QOIFyhuAkr/iUk0M0MQ732N/xfDCuNATqf3mEFeB65SQ1HtU/yBfa
	B7kZi/Vs2wJMJgJWDwaxVUE8tXR9XM3LZNvoQ1jEzZEa3zPx5i6jteNFOc0wGrCLx/h8VnRCaYw
	ky48FKai2csW5TzyiGCe8r0wQJrxTHmI5OougcI84A5ivLo4jgSdCXVlc0HtOEWxLo2gz8Jbezt
	VaX/kpVwd4Q6pgG68A+cSgsrmqlkFWBJWgF3WPLA9dMSQ7gglftaoQ6wUQg0l3ZM6mKV2CjWKZd
	uSCsoWg3ddCTOrvzM/EBOH+TdR+vpjsj+5w++EfWzntat0LdLoi22XZOJZGRuZ3IXoFwQ/yxeGa
	qN8HfAjrKbd3bOe1uqY/Wj7FlgClaZfGWMlOyMAP24sKErOFvf5ALeVAovlsTDnlLXXJ8TJ+w6Q
	Zo/nJjTwKjdXDfZIGvprCgeLw+TeiY=
X-Received: by 2002:a05:622a:a08:b0:516:d943:175f with SMTP id d75a77b69052e-51795c3dea1mr204571121cf.52.1780921331814;
        Mon, 08 Jun 2026 05:22:11 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517af149fa5sm46086911cf.3.2026.06.08.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:22:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/3] tipc: require net admin for TIPCv2 netlink mutators
Date: Mon,  8 Jun 2026 08:22:04 -0400
Message-ID: <20260608122206.458290-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608122206.458290-1-michael.bommarito@gmail.com>
References: <20260608122206.458290-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

TIPCv2 registers mutating generic-netlink operations without admin
permission flags. Generic netlink only checks CAP_NET_ADMIN when an
operation sets GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so a local
unprivileged process can currently change TIPC state through commands
such as TIPC_NL_NET_SET, TIPC_NL_KEY_SET, TIPC_NL_KEY_FLUSH, and
bearer enable/disable.

The legacy TIPC netlink API already checks netlink_net_capable(...,
CAP_NET_ADMIN) for administrative commands. Give the TIPCv2 mutators
the equivalent generic-netlink gate. Use GENL_UNS_ADMIN_PERM for
network-namespace scoped operations and GENL_ADMIN_PERM for
TIPC_NL_MEDIA_SET, which updates the shared media defaults rather than
state owned only by the target network namespace.

A QEMU/KASAN repro run as uid/gid 65534 with zero effective
capabilities previously succeeded in changing the network id and node
identity, setting and flushing key material, and enabling/disabling a
UDP bearer. With this patch applied the same operations fail with
-EPERM.

Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Link: https://lore.kernel.org/all/20260604163102.2658553-1-dominik.czarnota@trailofbits.com/
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Use GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET because it updates global
  media defaults, while keeping GENL_UNS_ADMIN_PERM for netns-scoped
  mutators.

 net/tipc/netlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 1a9a5bdaccf4f..5bbe134284acc 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -152,11 +152,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_BEARER_DISABLE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_disable,
 	},
 	{
 		.cmd	= TIPC_NL_BEARER_ENABLE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_enable,
 	},
 	{
@@ -168,11 +170,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_BEARER_ADD,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_add,
 	},
 	{
 		.cmd	= TIPC_NL_BEARER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_set,
 	},
 	{
@@ -197,11 +201,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_LINK_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_link,
 	},
 	{
 		.cmd	= TIPC_NL_LINK_RESET_STATS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit   = tipc_nl_node_reset_link_stats,
 	},
 	{
@@ -213,6 +219,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_MEDIA_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_ADMIN_PERM,
 		.doit	= tipc_nl_media_set,
 	},
 	{
@@ -228,6 +235,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_NET_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_net_set,
 	},
 	{
@@ -238,6 +246,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_MON_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_monitor,
 	},
 	{
@@ -255,6 +264,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_PEER_REMOVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_peer_rm,
 	},
 #ifdef CONFIG_TIPC_MEDIA_UDP
@@ -269,11 +279,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_KEY_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_key,
 	},
 	{
 		.cmd	= TIPC_NL_KEY_FLUSH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_flush_key,
 	},
 #endif
-- 
2.53.0

