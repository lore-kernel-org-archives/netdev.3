Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202369;
	b=YjyjJ2AHWF8oDY6iIuQ4NqQ89Hx89+KLveX05d40VtgsZKSpQFJqAjOWsgEob+OZiszN
	 24F5ZkkSSMnsZfGBQjHbzGrT+E0sMiE1Li/tuhyPVnDo887p7o/V+WGBgk+uKaVYR/L/s
	 nXPDXeVkqkC8Dr+JRVs7pbo5cFaT6xHl0GaB2Ru48FffAybZAuziqVermhXLt0aJYBfaG
	 lniNe6338r+Yb8/XBMklNElmVw+tdqnYLl4cuEtzQ9ES7nqqV7IihHvcEJDd48NrDQfVk
	 Hvz1dwbG8YQJ94jte/gBdf7Kanhd+AT6nnUoRn4gmQZQROnmd8bA7NAJ+9YYQixTiGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202369;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fSsd+Jru8TwrsZ00/xFyxEW8a4AeXr5gmncXZGNMYGw=;
	b=UlFW2/yGHaKnftwipsy4hOclbL0C35KarGJGj30a1jEO7BjUklbvtYlDloMdyQH6CIrf
	 ycwbAOxqLYSWaUc8GhViU01dbjAMAk/RNgwuwUs2tii3odZkclXgiHLe2MghdbCUwX5C5
	 kV4eBQTFeOR9408GdADqAyrkZ5NNgXfRvz+MEW61EzOl99KH5FG7O3aytxCWJKGNDQA8v
	 0RZvbda8LbUg1f235EhnnPaH/9gemgUPwEseAqdODjlLIjpC4Ehn9p4jt3xfdTlIdts/e
	 KCwVhdfyQS7Q4hTuLQJ6qL2IU77CMcSOKif8oSV8xYFhZ0QbM6+1Gn5upT1Q2h2p2xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JgdmZiKz;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B4606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 05:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008B4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JgdmZiKz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fS
	sd+Jru8TwrsZ00/xFyxEW8a4AeXr5gmncXZGNMYGw=; b=JgdmZiKzU20OyqLlS3
	ZVadvUdXHIIGGV7gP8PJghYtOdg1b7j2hm1YEpJaq2AfYt4R8lt+Y9rUKjflucFl
	TZSfXE+RpIEAit8PMiKrYxq24tcGGGMuoIOiihud4o/A4jCmc9O+SKkM6JpZ16E2
	LEU5MzS4g7Uj+xKUPAEnMGDlY=
Received: from device-ubuntu.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v47gWvFq37XTFw--.24970S2;
	Mon, 09 Nov 2026 13:32:33 +0800 (CST)
From: Fang Jiabao <kaquoin@163.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	Fang Jiabao <kaquoin@163.com>
Subject: [PATCH iproute2 v2 1/2] ip route: use the request size as the limit when adding encap
Date: Mon,  9 Nov 2026 13:32:08 +0800
Message-ID: <20261109053209.65753-1-kaquoin@163.com>
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
X-CM-TRANSID:_____wD3v47gWvFq37XTFw--.24970S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWxuFW5tF4fZF1DJrWxtFb_yoW5Gr17pF
	ZIga98KrZ5tF4Iyay7Ga1xZ34Yyws3JFWUJFykG3yqyFs8WFySyF9Yy34YqrW8ArZ7Jw4k
	trsrt34UWFWDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_HUhUUUUU=
X-CM-SenderInfo: 5ndt30llq6il2tof0z/xtbC9RLpXmrxWvLbpwAA3f

iproute_modify() passes a hardcoded 1024 as the size limit to
addraw_l() when it adds the encap attribute. The request buffer is
larger than that, and every other attribute in this function is bounded
by sizeof(req). With a seg6 encap of 60 segments the request still fits
in the buffer, but addraw_l() prints "addraw_l ERROR: message exceeded
bound of 1024" and returns -1. The return value is ignored, so ip sends
the request without the encap attribute and exits with status 0, and a
route without encap is installed silently.

Use sizeof(req) as the limit, like the other attributes, and return an
error if addraw_l() fails instead of sending an incomplete request.

Fixes: 1e5293056a02 ("lwtunnel: Add encapsulation support to ip route")
Assisted-by: Claude:claude-sonnet-5-5
Signed-off-by: Fang Jiabao <kaquoin@163.com>
---
Changes since v1:
  - use sizeof(req) as the limit instead of 1024, as suggested by
    Stephen Hemminger; keep the check of the return value
  - rewrite the commit message to describe the cause
  - add the same fix for ip nexthop as patch 2/2
v1: https://lore.kernel.org/netdev/20261102090535.226168-1-kaquoin@163.com/

Tested on current main (d95f6650, "man: ip-neighbour.8: document
protocol keyword"), in a network namespace with a dummy device, with:

  ip -6 route add fc00:ff::N/128 encap seg6 mode encap segs <N SIDs> dev d0

With 59, 60 and 62 segments the route is added with encap, exit status
0. Before, 60 segments printed an addraw_l() error and installed a route
without encap, exit status 0 (observed on e4cd9f1d, the only commit
since then changes a man page). With 63 segments the result is
unchanged: error from lwt_parse_encap(), exit status 255, no route
installed. I did not find a way to make addraw_l() fail from the command
line after this change, so that error path is not tested.

 ip/iproute.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 1ce71f78..067569c2 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1525,9 +1525,10 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 			lwt_parse_encap(rta, sizeof(buf), &argc, &argv,
 					RTA_ENCAP, RTA_ENCAP_TYPE);
 
-			if (rta->rta_len > RTA_LENGTH(0))
-				addraw_l(&req.n, 1024
-					 , RTA_DATA(rta), RTA_PAYLOAD(rta));
+			if (rta->rta_len > RTA_LENGTH(0) &&
+			    addraw_l(&req.n, sizeof(req), RTA_DATA(rta),
+				     RTA_PAYLOAD(rta)) < 0)
+				return -1;
 		} else if (strcmp(*argv, "ttl-propagate") == 0) {
 			__u8 ttl_prop;
 
-- 
2.43.0

