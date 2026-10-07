Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368F49D5BD
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386736; cv=none; b=f7s76/DqFFaBRO4d6l7v5NbF9lyQ/WNpUK0mW7OEBVYMyHeeVLkjkkyNevNySgEO9c+2eMiYEDFEugNWEwswZiGZZH1qC4nhP11KgXZOueopButTlifLki8v4nGdPyKbKf9FFlsY7v8so32a6+/FpWMuZOQ0QcIWVY1axS1FMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386736; c=relaxed/simple;
	bh=0AXZLLdm2ohwknzhkA9ri9/N1AJi8Gxcob1bx4Ao6b0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rAhUPwAbhu3ggVoTeGnRva6rpl5Lg4Yaxp17cTLqHH+Oy3Cbm6R8pjOkJLraB3ypTxVZ4q/rS07pmMQn6jVHJnUSuAHa1uuHb9c0vjZVd3VIcNnX4ZQ+78PduHg4ktqxWRw4m7kF5sj1hus61ud4WQylVLGKwtEnc99SS4nCpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB2g6D/z; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB2g6D/z"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35115b52125so2426168eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791386728; x=1791991528; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SORwsxYnw8/qhwz5bddns+yWORRA8bOX7YyK5JS+Vw4=;
        b=QB2g6D/zrVmkVp/nSjZp6USnipgf5c+eYYiNyJJwScpJaOqTpNtqJlkkatojJyGpnd
         327Hhn/RASfaviUny2HSrsUd/W4jQh6fP26EqsEVKNq2kfdo2dqMxvU0+DPS4oWKMkHs
         bYk93UC14AmpW7bvmnbfPiOmiQDX2Ua9z2oEFlX4w6xn0RuFthhfh/q5HmCeJiAngc2X
         8/THZdIC4ptTpunddj27ZPOOdjHJr+A5V7jBoGO3mjf6cnHUO7eC9wPb2Y8JcDgroqmK
         XBVP5hO7qMjrnZ5jKU5swRuAV+YjU6ctGT5pMrJFKBRsfoUz5GQXabRNDU+iUTkyXnwa
         sirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791386728; x=1791991528;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SORwsxYnw8/qhwz5bddns+yWORRA8bOX7YyK5JS+Vw4=;
        b=eYteHycOav7x1luBFNpOHt6LG+0jO6gWpR7Sluj+FTj8wDovsaKRN4cYh5QWKq8Alt
         5Ila08H1rR7djIEDhUofC54Ubl0fXUS4XXXCh9q8qbgrbjJGHA81QaT/3QxettT27b0s
         tB1vxIVMnYd4N0hZyetqrjVC8XebqpHdXFxTu94k+dqsfiWF5m3wOyopQZuQo+eWLCCX
         SAwvScMTKoiSoWio/QDwLRY/hBwcwS2Xr1sFgjoZ/gG2lddSOCAVs3iQXBoM8eiRQyKj
         Tv8ya9QmIPkOzhYPeieyIDl2zvA73Jk2GyZtolYH8J+zHYK4WEEU/5Kv7N5Gtw4Mu91f
         mJHw==
X-Forwarded-Encrypted: i=1; AKwUvBzaFHgV+dzUfM4I/JbUVaw4u4jtwCoLdDv84/k/Xv2SDv9Av90/DdB/EOBC6Yp4waVMtD+djcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMw/MW5Bm5SlKPQE68EMhMnrZ/6C1a7aPKd4oC8oL3gm3DN72Z
	s7kht3RHcCWpbof5gZ64otWC3/Jk8/EhMvM5ZDOaGNHG1wyiCqlkFzam
X-Gm-Gg: AYBFou3WrE+rHZEBcdMknEKg00EpAYfH7aslJX4xWAsQjNBGggiUbberyjCQra1SBxa
	wg6YeICz2IVlPPDTMPs2MgM9ssuJCDz1l0s9arJU7J3DBC2foW1vNfRxlycGYeSBo99S/SG1eWV
	XOvneMM90TYg4Ou9Oi72vwyKAfZhHR+HkmPXghv1PK9qLiK6FuWAPpt4DP4QXXQTN5MCf9Uzsph
	qYyPeubFejqdXQx+bqIn0hB83C8UGZ+8IpywPL4zMCQ8UPVTUjiXbWi68cTUpdHues5m5jlwHqr
	/nS36euExY5+lZpErhzkKm8bSQ8f55NKYrJZnhOBNSduhVri54e/upIuWyIJdxHezUUNYXUebMl
	Hkmoa9FzNMlfvs56+TFJLw3nFeRLZtcwXaPiGb2660Af7E7UjtnCNkR/+rx5vOiSjYXJg6eeI50
	lHaZBNfKCA1YnLCp5aSN2qosUI4bNalCQ6xWGTB1TCDytyxVrtSZn17g2n+3R86Q53kku/3f5/k
	+ml6HD/8rlHXCcA6D0D42oYYCFLP0pgMJk0J0iNP25csCT43xD+ByLef5UPC01EXOS1sdpqBwLB
	3Ej/OR3TYOIMlG/ZYa4+59rBobdJXOG3K5qg5MC0JOCarrj23wWA
X-Received: by 2002:a05:693c:83dc:20b0:33b:b0c8:73d2 with SMTP id 5a478bee46e88-3515dc54535mr3042630eec.3.1791386727534;
        Wed, 07 Oct 2026 08:25:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([95.173.223.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af26f10sm9234416eec.13.2026.10.07.08.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:25:26 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_conntrack_sip: only honour Via: port in
 original direction
Date: Wed, 07 Oct 2026 12:25:00 -0300
Message-ID: <179138670045.80227.4002052840715926590@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The Cisco phone workaround in process_sip_request() records the port
from the topmost Via: header in ct_sip_info->forced_dport whenever the
Via address matches the sender of the current request and the port
differs from the sender's source port.  nf_nat_sip() then rewrites the
UDP destination port of every reply-direction packet to that value.

The check is performed for requests in both directions.  For a request
arriving in the reply direction, ct->tuplehash[dir].tuple.src is the
remote peer's own address and port, so the remote side can trivially
satisfy the condition with a Via: line of the form

  Via: SIP/2.0/UDP <own-address>:<any-port>

and force forced_dport to a port of its choosing.  From then on,
packets it sends on this flow are delivered to the NATed host at that
port instead of the port the NAT mapping was created for, which bypasses
the port restriction normally enforced by the NAT mapping.

The workaround is only meant for phones behind the NAT router, i.e.
requests in the original direction.  Restrict it accordingly.

Fixes: 7266507d8999 ("netfilter: nf_ct_sip: support Cisco 7941/7945 IP phones")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Tested on 602042bf29f6 (arm64, QEMU) with client -> router -> server
network namespaces; the router runs nft masquerade and a "sip" ct helper
on udp/5060.  The client sends an OPTIONS request from port 5060; the
server answers with a request carrying "Via: SIP/2.0/UDP <server>:4444"
and then a plain UDP payload on the same flow.

  before: client receives both datagrams on port 4444
  after:  client receives both datagrams on port 5060

 net/netfilter/nf_conntrack_sip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 64bc440b1..ef655a0bb 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1586,8 +1586,14 @@ static int process_sip_request(struct sk_buff *skb, unsigned int protoff,
 	 * router for one of these phones, save the port number from the
 	 * Via: header so that nf_nat_sip can redirect the responses to
 	 * the correct port.
+	 *
+	 * Only honour the Via: port for requests coming from the phone,
+	 * i.e. in the original direction.  The remote peer must not be
+	 * able to pick the destination port of packets delivered to the
+	 * NATed host.
 	 */
-	if (ct_sip_parse_header_uri(ct, *dptr, NULL, *datalen,
+	if (dir == IP_CT_DIR_ORIGINAL &&
+	    ct_sip_parse_header_uri(ct, *dptr, NULL, *datalen,
 				    SIP_HDR_VIA_UDP, NULL, &matchoff,
 				    &matchlen, &addr, &port) > 0 &&
 	    port != ct->tuplehash[dir].tuple.src.u.udp.port &&
