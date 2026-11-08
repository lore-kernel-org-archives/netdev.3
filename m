Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137724;
	b=TmQOPaDZGhVnlsyuWQ6a50xbrdnSbI7xJI39948v6JsGvUFYEcIAHw2JT8eR7g1szh2W
	 q9mbAv5drHKYBzIlpOP2st+G711nubEHtuxnd598uGzlwPHS1sdX4wvhA5qM9ToDYjm3C
	 stQZfjnmTnLvPk+QEyCSz7DBRR+fppEQ64XJzgrMA8GAWhSgoRkIScoB5QqmMWzzr8bK2
	 tMJSb0SdTHtn3D+HV64KSD1XwzJvArnGWHUy8MFnHK3O3xyICY1z0COWTCpSzB1DFoj+w
	 ZBc7AAb+dnekuLyGKPGydAU/67bXZTXouKy11EODoClHS39KoiQ4c96+F065s9BdAwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137724;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lwdAgCvtvRUcPybnp/UQAFDNlNUPBjMogcTxCraafKI=;
	b=tJsNyrYUJwwfLrg6iscHn7OIdRB9+QsdkUjtM0nY1yPhkqkGWORQKWGTmD0U8GwtF4dx
	 t2uXrCrNHUQkp0dLEoDRKzDnYFSbwHA5IY+b57euOAy3J0xcbPl3Jraw/RbfZY2GJgscX
	 Iik5BGn0rpu9IeeYheAEEsS6Je+3eWW8dnqah8+6fW1lOSHismhxHKr+YZguG4mrk1pAJ
	 2PJPR9LHAQpCWUVGzP5xa9PTT//lkjTvcTUcyjD0cNFuJhRrZz0uLVOcyL1GP2jd4WhPT
	 S9fVGNiIlXEKLiH6newT0VtAB+8XgWcVDQVHkJJ21n4g3Emggk0eJ07hoPJN97mIK9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SMJ8h3Vj;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F86606D808;
	Sun,  8 Nov 2026 11:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F86606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SMJ8h3Vj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=SMJ8h3VjycMU6b0a2OQw+Tud5XV5tepWOrndsjJutGvSp4zwkXsQw98nH7/7h485gbSHIsf9CO0Vm
	 gXzQ1dSxXpjlv9j/YAznLQcw6JEsjUuualB04NXLtngxNbYq0nekAni1lI0GpgEA/NVhELEgVeO4HA
	 GbaCOcWTHLMyC7n8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af05e68a11-b8e8a;
	Sun, 08 Nov 2026 19:35:18 +0800 (CST)
X-RM-TRANSID:2ee56af05e68a11-b8e8a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af05e6933f-66b79;
	Sun, 08 Nov 2026 19:35:18 +0800 (CST)
X-RM-TRANSID:2ee96af05e6933f-66b79
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <witu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] erspan: drop packets with an unknown ERSPAN version
Date: Mon,  9 Nov 2026 04:35:04 +0900
Message-ID: <20261108193504.73393-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

The ERSPAN type II and III receive paths take the length of the ERSPAN
header from the version field of the packet, with erspan_hdr_len(), but
never check that the version is one they know: 1 for type II or 2 for
type III.

For any other version, erspan_hdr_len() returns 0 or the type III
length. With version 0, the ERSPAN header is not pulled, so it is
passed up as the start of the inner Ethernet frame, and in collect_md
mode the metadata is filled from the wrong part of the header. The
ETH_HLEN pull in __iptunnel_pull_header() still covers the bytes that
are copied, so nothing is read past the pulled data.

Reject such packets, as a packet with a truncated ERSPAN header already
is.

On IPv4, a packet with a 4-byte GRE header is taken as type I without
looking at the protocol. gre_parse_header() treats an ETH_P_ERSPAN2
packet as carrying an ERSPAN header whatever the GRE header length,
but erspan_rcv() then skips that header's version and passes it up as
the inner frame. Type I only uses ETH_P_ERSPAN, so check the protocol
too. Such a packet now goes through the type III path and its version
check.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
Tested on net-next fa5196392691 (x86_64 KVM guest), with hand-built
GRE/ERSPAN packets sent over a veth into erspan and ip6erspan devices,
in plain and collect_md mode: version 0 packets and ERSPAN2 packets
with a 4-byte GRE header and version 0 or 3 are now dropped, version 1
and 2 packets are unchanged, and erspan v1/v2 ping over IPv4 and IPv6
still works.

v3:
- Also check the protocol when classifying a packet as type I, so that
  an ETH_P_ERSPAN2 packet with a 4-byte GRE header gets the version
  check too (Sashiko).
v2: https://lore.kernel.org/netdev/20261107130030.35220-1-yanhaishuang@cmss.chinamobile.com/
- Drop the Fixes tags and correct the commit message: the ETH_HLEN pull
  of __iptunnel_pull_header() covers the metadata copy, so there is no
  out of bounds read (Ido, Sashiko).
- Drop the patch that skipped the type III sub-header, as no device is
  known to send it (Ido).
v1: https://lore.kernel.org/netdev/20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com/

 net/ipv4/ip_gre.c  | 12 +++++++-----
 net/ipv6/ip6_gre.c |  3 +++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5485586fa0e6..f8a7c4353502 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -255,13 +255,13 @@ static void gre_err(struct sk_buff *skb, u32 info)
 	ipgre_err(skb, info, &tpi);
 }
 
-static bool is_erspan_type1(int gre_hdr_len)
+static bool is_erspan_type1(const struct tnl_ptk_info *tpi, int gre_hdr_len)
 {
 	/* Both ERSPAN type I (version 0) and type II (version 1) use
 	 * protocol 0x88BE, but the type I has only 4-byte GRE header,
 	 * while type II has 8-byte.
 	 */
-	return gre_hdr_len == 4;
+	return tpi->proto == htons(ETH_P_ERSPAN) && gre_hdr_len == 4;
 }
 
 static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
@@ -282,7 +282,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 	itn = net_generic(net, erspan_net_id);
 	iph = ip_hdr(skb);
-	if (is_erspan_type1(gre_hdr_len)) {
+	if (is_erspan_type1(tpi, gre_hdr_len)) {
 		ver = 0;
 		__set_bit(IP_TUNNEL_NO_KEY_BIT, flags);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
@@ -301,10 +301,12 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	}
 
 	if (tunnel) {
-		if (is_erspan_type1(gre_hdr_len))
+		if (is_erspan_type1(tpi, gre_hdr_len))
 			len = gre_hdr_len;
-		else
+		else if (ver == ERSPAN_VERSION || ver == ERSPAN_VERSION2)
 			len = gre_hdr_len + erspan_hdr_len(ver);
+		else
+			return PACKET_REJECT;
 
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8f0c36..46fac89a0743 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -507,6 +507,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
 
+		if (unlikely(ver != ERSPAN_VERSION && ver != ERSPAN_VERSION2))
+			return PACKET_REJECT;
+
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 

base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.43.0



