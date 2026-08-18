Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0F47D44A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070107; cv=none; b=OhumOMBHaApJ/k3VL1e9EV1uRq/UkyLx2HzTcWgC+rRIEH10Xuhn5yu/xA0DGnnoqb4lH6AnQRrgLGDIVr6CUquh5NAXbpGqo48QlMvwp86LyKvQaI2ogNVQuftQT9JJZmf+aEBS04oBBXCuWnGVi1dvbfdqrld5KfdAt/jhKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070107; c=relaxed/simple;
	bh=GKNOuQa1Sm3JbGJeZo02m1rT3BkCPfOp2uMUvK69eIE=;
	h=From:To:Cc:Subject:Content-Type:MIME-Version; b=r6gPwdE1ew6FclAeKMDhUnayDYQqRfF6Spefy0qFcrXSACeMw6ZhN/3dB7m8L+H/6d9aNKlNpaYj9qY2t3mNHH0EFwoonR9ulYyd5IPTgeo2JII8NLQ5FQByxkbfG5vcxVuq/cILf/ZBssvsWkibV2eIiriLUvQ5jJWCGq9BXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VDSfKllh; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VDSfKllh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787070095; h=From:To:Subject:Content-Type:MIME-Version;
	bh=CnCN3W5rh868ZM+grgxpAtSOczWZ72ICUKU84evBfv8=;
	b=VDSfKllhtg6UZvy2NXnhSw27JwjE/i+qGHTrU/MUiZaYY+qPqZW5PR8sP0XNN1qh5GK7QQfNd+EBzZ2un618DVUeVAOiBOiGgDV0DHfkUC+rJFUS9YIc4k/ugB1mQY5APif0XtgAZ0wwtpJS/XHV4SAVuFRPyhireEbHMeJvwWU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X9E4oQI_1787070094;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9E4oQI_1787070094 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 00:21:35 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: Dmitry Kozlov <xeb@mail.ru>
Cc: netdev@vger.kernel.org
Subject: [PATCH] pptp: reject payloads shorter than the PPP protocol field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>

pptp_rcv_core() dereferences the first payload bytes after pulling the
GRE header: payload[0] and payload[1] when stripping the address/control
field, and up to payload[4] when checking for an LCP echo request in
the out-of-order case. Only headersize + payload_len bytes of the skb
are pulled, so a PPTP packet with a payload_len smaller than these
accesses makes the driver read past the end of the packet data.

The path is: a GRE packet for an established PPTP channel arrives
through the IP protocol 47 handler pptp_rcv(), which validates the GRE
flags, looks the channel up by call id and source address and queues
the skb to the pppox socket, where pptp_rcv_core() runs for sockets in
PPPOX_CONNECTED state. payload_len is taken from the GRE header without
any lower bound, so an attacker who can inject packets carrying the
channel's call id and peer address can make pskb_may_pull() pull as
little as the GRE header itself; payload then points at the end of the
pulled data and the dereferences above read up to five bytes past the
packet. The sequence number is likewise attacker controlled, so both
the out-of-order LCP echo check and the in-order address/control
stripping are reachable.

The read lands inside the skb data allocation (tailroom of the same
slab object), so KASAN does not report it and the access does not
fault, but the bytes read are undefined and steer the accept/drop
decision: garbage may let a short malformed frame through to
ppp_input(), and the LCP echo check is meaningless for payloads
shorter than a PPP protocol field.

A PPTP payload is a PPP frame and therefore always carries at least
the two-byte PPP protocol field, and the LCP echo check needs five
bytes to be meaningful. Drop packets shorter than two bytes and only
perform the LCP echo check when at least five bytes are present.
Valid packets are unaffected.

Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)=
")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 drivers/net/ppp/pptp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 3a10303eb756..ce1cd72baadf 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -317,10 +317,18 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buf=
f *skb)
 	if (!pskb_may_pull(skb, headersize + payload_len))
 		goto drop;
=20
+	/* The payload is a PPP frame, so it always carries at least the
+	 * two-byte PPP protocol field. The payload bytes are dereferenced
+	 * below, reject packets too short to hold them.
+	 */
+	if (payload_len < 2)
+		goto drop;
+
 	payload =3D skb->data + headersize;
 	/* check for expected sequence number */
 	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
-		if ((payload[0] =3D=3D PPP_ALLSTATIONS) && (payload[1] =3D=3D PPP_UI) &&
+		if (payload_len >=3D 5 &&
+				(payload[0] =3D=3D PPP_ALLSTATIONS) && (payload[1] =3D=3D PPP_UI) &&
 				(PPP_PROTOCOL(payload) =3D=3D PPP_LCP) &&
 				((payload[4] =3D=3D PPP_LCP_ECHOREQ) || (payload[4] =3D=3D PPP_LCP_ECHOR=
EP)))
 			goto allow_packet;
--=20
2.43.5
