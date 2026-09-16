Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2954F7976
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564959; cv=none; b=ofc3lig4CX4QsxYMBUb8TqaG4sLsWPlB2w+D4CF7hFkbOr34KF0YnmOaoFZc6QoxwzT/6kPci+Z/u50OKqRCjAd/rmUQX66RA4DP6EnVdGGSzjXVG7fmlfp7OI+8Fwslz+en4OPAWKVC/fAeoPLTfJmeIToyS9iXPvaIJ6DhAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564959; c=relaxed/simple;
	bh=X3HLA9aa/x3C5LTC08RR+kvxXyFQE5ctJWY0ft69cPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rpQS6SbLY9+mVG7+IXL9zDFmanNMxPp3fKMFLYsHPgSDBYIA9DnW1IydzDIvisNs+aw8koGH0AZ9rh1W7KtGZTYMWzpPYMHQJCmPkHQmd85CPPzgsD7CIdWV8JrioUG3ZNp9dD268wJbhyGYITH2iHsE8SpCHsU9LLxhr96Hf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxyJov3v; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxyJov3v"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91245cf2b35so426936d6.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789564954; x=1790169754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vm6VFDum+JA+HS1SfWb7aiA9Q3WYS1GWvXnIe5n42U=;
        b=GxyJov3vUBOoIWnpCKoDenn843TB7tNP67dwlByHUg2lI2LOEs2D95tm1G6T/d/+8J
         FezLk53mNO1yKeO/3wUwov+nugJ1HHmrHSJ5ipL0iv5d+f9iiPbsjegh7RHiR9I9/GJB
         c9FidHtOhL36fjwMbCxpGdwIeu7sbUYAuG+afjPLz1JPh07wTN2lnzDMzvSTZg1AWPvp
         DATxfftyOtVC4QMl04HPLX7PWI7LwtC6+sB7+fZpPMDB/Yt1BHFRZM1wjtZiZg9QXpcQ
         CsSILtLYrl7AotboPqNw/67wgbTmpT9+WyhcMy5U2QFBuDGCLmH7Vgz3cuz7wHWkOZMi
         7Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564954; x=1790169754;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vm6VFDum+JA+HS1SfWb7aiA9Q3WYS1GWvXnIe5n42U=;
        b=kSyqS+QTRxDyGOqXE2O38v1Qti4kayjrFteV4VULqliRP8O5Rc4Gs9BI/exp3x7L7O
         XgBNrb4EsGork3ZoeLbkkEokD+CaQVwrcNDVDB3iPi16uiZfrlU4oVmhV75Q3RTEpzru
         DRKuO5t2AB5rAtx7JZg5mGtn3+/9A0UEx2YNyHGEoThEiPAC15zB5PQ+STVFhXeF6llm
         zjmf2MOgrD//RQXORf09lsUplZcv4n2cPbKWXg4yZuZKRG03E1Wfy7Yz2K9ueTOyoxz8
         djTnN/KquHl0VT43zad2Kwy8sPC7oswCqd+hAz34J+NNAvScKoxO6sAwnqeVyZiIxX12
         EicQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ+FY/czF2ysNur8PrenRoU+iMRHOtEjOEF7bqYiXtO9h8hjteLbvZ3twsg0BVFCwGqhXQYTo=@vger.kernel.org
X-Gm-Message-State: AFuF++mFKa6qzgCie9c5/Z3YcHmf0XvyfAa+QHe0m5vD/jTFYEe0rtpz
	sGN4S6hX22VXbXm4wxzd7f+H4wEKVHFo34F/1/fcZW1iddnwt08veR6dbPp+jKv/pceHE0DfKFj
	vb5KSOytpk68pwg==
X-Received: from qtbli26-n1.prod.google.com ([2002:a05:622a:845a:10b0:531:1750:ffd8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:164a:b0:530:f0c8:de23 with SMTP id d75a77b69052e-5327ef241camr41845231cf.29.1789564953730;
 Wed, 16 Sep 2026 06:22:33 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:22:29 +0000
In-Reply-To: <20260916132231.1780091-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132231.1780091-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132231.1780091-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: rmnet: annotate data-races around port->data_format
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

port->data_format is written under RTNL from rmnet_newlink() and
rmnet_changelink(), but it is read from the data path without any
lock, both from RX (rmnet_rx_handler() context) and TX
(rmnet_egress_handler() context).

Note that rmnet_newlink() can be called for a real_dev which is
already hooked to rmnet: the rx_handler is live and traffic can
already be flowing when port->data_format is overwritten.

Add the missing READ_ONCE()/WRITE_ONCE() annotations.

While at it, sample port->data_format only once per packet and pass
the value down, so that all the decisions taken for a given packet
are based on a single consistent value.

Otherwise the two ends of a packet transformation could disagree.
On TX, rmnet_map_egress_handler() sized the headroom from one read
while rmnet_map_add_map_header() decided on MAP_NEXT_HEADER_FLAG
from another one, so a concurrent rmnet_changelink() could produce
a MAP header announcing a v5 csum header that was neither reserved
nor written. On RX, rmnet_map_validate_packet_len() and
__rmnet_map_ingress_handler() could likewise disagree on the
expected layout, and rmnet_map_send_ack() could trim a dl csum
trailer that the ingress path never accounted for.

rmnet_map_add_map_header(), rmnet_map_command(),
rmnet_map_deaggregate(), rmnet_map_send_ack(),
rmnet_map_validate_packet_len() and __rmnet_map_ingress_handler()
therefore get the value from their caller instead of re-reading it.

rmnet_changelink() now computes the new value in a local variable
and publishes it with a single store, instead of letting the data
path observe the intermediate (old_data_format & ~flags->mask)
value.

rmnet_vnd_headroom() is left alone, all its callers hold RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 10 +++---
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 32 +++++++++++--------
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  9 +++---
 .../qualcomm/rmnet/rmnet_map_command.c        |  9 +++---
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 14 ++++----
 5 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf250bd1f8d07d09f7715918421a88d..59ef8b4ce5321ebbd1d416fd9da0a820e53ecf9e 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -176,7 +176,7 @@ static int rmnet_newlink(struct net_device *dev,
 	}
 
 	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
-	port->data_format = data_format;
+	WRITE_ONCE(port->data_format, data_format);
 
 	return 0;
 
@@ -342,14 +342,16 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (data[IFLA_RMNET_FLAGS]) {
 		struct ifla_rmnet_flags *flags;
 		u32 old_data_format;
+		u32 data_format;
 
 		old_data_format = port->data_format;
 		flags = nla_data(data[IFLA_RMNET_FLAGS]);
-		port->data_format &= ~flags->mask;
-		port->data_format |= flags->flags & flags->mask;
+		data_format = old_data_format & ~flags->mask;
+		data_format |= flags->flags & flags->mask;
+		WRITE_ONCE(port->data_format, data_format);
 
 		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
-			port->data_format = old_data_format;
+			WRITE_ONCE(port->data_format, old_data_format);
 			NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
 			return -EINVAL;
 		}
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index d055a2628d8c9d0b6e7e85eb98f6fa9b5a1bd531..d4fec2fff227cd93f14eb1802aff185e6d496786 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -54,7 +54,8 @@ rmnet_deliver_skb(struct sk_buff *skb)
 
 static void
 __rmnet_map_ingress_handler(struct sk_buff *skb,
-			    struct rmnet_port *port)
+			    struct rmnet_port *port,
+			    u32 data_format)
 {
 	struct rmnet_map_header *map_header = (void *)skb->data;
 	struct rmnet_endpoint *ep;
@@ -63,8 +64,8 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 
 	if (map_header->flags & MAP_CMD_FLAG) {
 		/* Packet contains a MAP command (not data) */
-		if (port->data_format & RMNET_FLAGS_INGRESS_MAP_COMMANDS)
-			return rmnet_map_command(skb, port);
+		if (data_format & RMNET_FLAGS_INGRESS_MAP_COMMANDS)
+			return rmnet_map_command(skb, port, data_format);
 
 		goto free_skb;
 	}
@@ -82,7 +83,7 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 
 	skb->dev = ep->egress_dev;
 
-	if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
+	if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
 	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
 		if (rmnet_map_process_next_hdr_packet(skb, len))
 			goto free_skb;
@@ -92,7 +93,7 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 		/* Subtract MAP header */
 		skb_pull(skb, sizeof(*map_header));
 		rmnet_set_skb_proto(skb);
-		if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4 &&
+		if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4 &&
 		    !rmnet_map_checksum_downlink_packet(skb, len + pad))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
@@ -110,6 +111,7 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
 			  struct rmnet_port *port)
 {
 	struct sk_buff *skbn;
+	u32 data_format;
 
 	if (skb->dev->type == ARPHRD_ETHER) {
 		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
@@ -120,14 +122,16 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
 		skb_push(skb, ETH_HLEN);
 	}
 
-	if (port->data_format & RMNET_FLAGS_INGRESS_DEAGGREGATION) {
-		while ((skbn = rmnet_map_deaggregate(skb, port)) != NULL)
-			__rmnet_map_ingress_handler(skbn, port);
+	data_format = READ_ONCE(port->data_format);
+
+	if (data_format & RMNET_FLAGS_INGRESS_DEAGGREGATION) {
+		while ((skbn = rmnet_map_deaggregate(skb, data_format)) != NULL)
+			__rmnet_map_ingress_handler(skbn, port, data_format);
 
 		consume_skb(skb);
 	} else {
-		if (rmnet_map_validate_packet_len(skb, port))
-			__rmnet_map_ingress_handler(skb, port);
+		if (rmnet_map_validate_packet_len(skb, data_format))
+			__rmnet_map_ingress_handler(skb, port, data_format);
 		else
 			kfree_skb(skb);
 	}
@@ -139,14 +143,16 @@ static int rmnet_map_egress_handler(struct sk_buff *skb,
 {
 	int required_headroom, additional_header_len, csum_type = 0;
 	struct rmnet_map_header *map_header;
+	u32 data_format;
 
 	additional_header_len = 0;
 	required_headroom = sizeof(struct rmnet_map_header);
 
-	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4) {
+	data_format = READ_ONCE(port->data_format);
+	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4) {
 		additional_header_len = sizeof(struct rmnet_map_ul_csum_header);
 		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
-	} else if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
+	} else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
 		additional_header_len = sizeof(struct rmnet_map_v5_csum_header);
 		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
 	}
@@ -161,7 +167,7 @@ static int rmnet_map_egress_handler(struct sk_buff *skb,
 						 csum_type);
 
 	map_header = rmnet_map_add_map_header(skb, additional_header_len,
-					      port, 0);
+					      data_format, 0);
 	if (!map_header)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index 60ca8b780c88ad7d9a6334370c0ff73a83e02d2d..0977e495f5915539fc1154bb592a2648aef43cda 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -41,12 +41,13 @@ enum rmnet_map_commands {
 #define RMNET_MAP_ADD_PAD_BYTES       1
 
 struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
-				      struct rmnet_port *port);
+				      u32 data_format);
 struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 						  int hdrlen,
-						  struct rmnet_port *port,
+						  u32 data_format,
 						  int pad);
-void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port);
+void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port,
+		       u32 data_format);
 int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len);
 void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
 				      struct rmnet_port *port,
@@ -59,6 +60,6 @@ void rmnet_map_tx_aggregate_init(struct rmnet_port *port);
 void rmnet_map_tx_aggregate_exit(struct rmnet_port *port);
 void rmnet_map_update_ul_agg_config(struct rmnet_port *port, u32 size,
 				    u32 count, u32 time);
-u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port);
+u32 rmnet_map_validate_packet_len(struct sk_buff *skb, u32 data_format);
 
 #endif /* _RMNET_MAP_H_ */
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
index add0f5ade2e6174427abff532d160f89122059f7..d334727e1f5256201996fc56c419ec05f04dde4e 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
@@ -48,13 +48,13 @@ static u8 rmnet_map_do_flow_control(struct sk_buff *skb,
 
 static void rmnet_map_send_ack(struct sk_buff *skb,
 			       unsigned char type,
-			       struct rmnet_port *port)
+			       u32 data_format)
 {
 	struct rmnet_map_header *map_header = (void *)skb->data;
 	struct rmnet_map_control_command *cmd;
 	struct net_device *dev = skb->dev;
 
-	if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4)
+	if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4)
 		skb_trim(skb,
 			 skb->len - sizeof(struct rmnet_map_dl_csum_trailer));
 
@@ -72,7 +72,8 @@ static void rmnet_map_send_ack(struct sk_buff *skb,
 /* Process MAP command frame and send N/ACK message as appropriate. Message cmd
  * name is decoded here and appropriate handler is called.
  */
-void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port)
+void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port,
+		       u32 data_format)
 {
 	struct rmnet_map_header *map_header = (void *)skb->data;
 	struct rmnet_map_control_command *cmd;
@@ -98,5 +99,5 @@ void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port)
 		break;
 	}
 	if (rc == RMNET_MAP_COMMAND_ACK)
-		rmnet_map_send_ack(skb, rc, port);
+		rmnet_map_send_ack(skb, rc, data_format);
 }
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index e6f48dc9fe64d7e563a0ba355c1ede35c73b4593..39d6d084e73f00f9fcd475ad98b16dde4cb266c6 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -294,7 +294,7 @@ static void rmnet_map_v5_checksum_uplink_packet(struct sk_buff *skb,
  */
 struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 						  int hdrlen,
-						  struct rmnet_port *port,
+						  u32 data_format,
 						  int pad)
 {
 	struct rmnet_map_header *map_header;
@@ -306,7 +306,7 @@ struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 	memset(map_header, 0, sizeof(struct rmnet_map_header));
 
 	/* Set next_hdr bit for csum offload packets */
-	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
+	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
 		map_header->flags |= MAP_NEXT_HEADER_FLAG;
 
 	if (pad == RMNET_MAP_NO_PAD_BYTES) {
@@ -333,7 +333,7 @@ struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 	return map_header;
 }
 
-u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port)
+u32 rmnet_map_validate_packet_len(struct sk_buff *skb, u32 data_format)
 {
 	struct rmnet_map_v5_csum_header *next_hdr = NULL;
 	struct rmnet_map_header *maph;
@@ -351,9 +351,9 @@ u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port)
 
 	packet_len = ntohs(maph->pkt_len) + sizeof(*maph);
 
-	if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
+	if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
 		packet_len += sizeof(struct rmnet_map_dl_csum_trailer);
-	} else if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
+	} else if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
 		   !(maph->flags & MAP_CMD_FLAG)) {
 		/* Mapv5 data pkt without csum hdr is invalid */
 		if (!(maph->flags & MAP_NEXT_HEADER_FLAG))
@@ -381,12 +381,12 @@ u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port)
  * is responsible for freeing the original skb.
  */
 struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
-				      struct rmnet_port *port)
+				      u32 data_format)
 {
 	struct sk_buff *skbn;
 	u32 packet_len;
 
-	packet_len = rmnet_map_validate_packet_len(skb, port);
+	packet_len = rmnet_map_validate_packet_len(skb, data_format);
 	if (!packet_len)
 		return NULL;
 
-- 
2.55.0.1032.g73a4cd73de-goog

