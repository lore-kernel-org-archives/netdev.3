Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610383;
	b=fxD/WJLeRZyQ7wwQfUDDnlK4GJFbV8Ap7dcD4u7Ddw1Ko/OAT2ZYRJE33f9xu4a1zUuy
	 sb+opVOhJZN0FsDMj8CzQZ1R/sU/I0tx2p0f0INfbXQq1uGNuKPpfkQbjF4ClKtxS/VUc
	 8AyariNk6f7FCKbUvoQfmqwS2vEk4nS+o8ElgHxEjtQq2YC8pdXScJqc0oy+WseTj4E6r
	 7gqoza5wxoJBe7XV9X/TbwwzM9vji6Dor/Jh5oDl1uf5c5VRpie7AAWq+bFO5gTlMSN+U
	 630rrmfaUdY5D4V+5GC4rGJo+7/ygdEynMSiE6qfpsSpqJpcgLFu9p7Py+LGPWFUG3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610383;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=LAGVP2b67YtKhGg8b829H5cq+XWr6wWQhutD+qrpuwI=;
	b=nLTi27RrvG/VERjYJ9tD+OngctncrKo2wFFSfQd1WmmMZoBTVSp8fHzHtyx+GaZFMNpb
	 gnAoBr4KWJ38XR3ApEmsARcHsaraNsmYD7l+/UYxiFLR4FW07F1jlWtLHlEPeJaYSlIlv
	 xRspdVfHDrY1zntGQCguRrgCJng6GzKi59jAeHdblsUwVT1fcW7+804YN5RHVVHzGSCQ+
	 g7s/54e4zDkxdqOZ0NZT189CLlljIznLUVvbXvo7xqCO+kS9ATaN6aRd32ab5/8cOPN/R
	 lxQpJq+3BAyxKEd6f+9I5YHSTgh5qoRbCZ/PuHyU7Q9Jl1Gp4uyUFSKC3YJNrN+RUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ahhHwTBt;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AF606A336
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 09:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A13AF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ahhHwTBt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LA
	GVP2b67YtKhGg8b829H5cq+XWr6wWQhutD+qrpuwI=; b=ahhHwTBtS1+aAGLCb9
	XBDl+ALjE39kEbg7lvn2H7vD2jTagLISb7+j/oYAu2yY3Bl3pfqrDjhkfpjNzDUM
	ovdgZlyo1McTXQibfFXmaBw5sNbpsZM82a/96zWYMAmEGHl2giumwLN0EPWqihUK
	EzpXNT9INXX7cMmmtcurrCNck=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnj25zUuhqA4AcDg--.47994S2;
	Mon, 02 Nov 2026 17:06:12 +0800 (CST)
From: Fang Jiabao <kaquoin@163.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	Fang Jiabao <kaquoin@163.com>
Subject: [PATCH iproute2] ip route: check return value of addraw_l() when adding encap
Date: Mon,  2 Nov 2026 17:05:34 +0800
Message-ID: <20261102090535.226168-1-kaquoin@163.com>
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
X-CM-TRANSID:PygvCgCnj25zUuhqA4AcDg--.47994S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1DZrWfAw1xtw45ArWrKrg_yoW8Zry3pF
	ZIgay5Kr90qrW0yayDJayIk34UK395GFW5tF4DC3yqkan8Wa4SvrySy3yY9rWUA397Jw4v
	qrsrtw4UWFZ7XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRijjgUUUUU=
X-CM-SenderInfo: 5ndt30llq6il2tof0z/xtbC1ASK-mroUoTvWQAA3G

iproute_modify() ignores the return value of addraw_l() when it adds
the encap attribute. If the attribute does not fit into the request,
for example a seg6 encap with 60 segments, addraw_l() prints
"addraw_l ERROR: message exceeded bound of 1024" and returns -1, but
ip sends the request without the encap attribute and exits with
status 0. A route without encap is then installed silently.

Return an error instead of sending the incomplete request.

Fixes: 1e5293056a02 ("lwtunnel: Add encapsulation support to ip route")
Assisted-by: Claude:claude-sonnet-5-5
Signed-off-by: Fang Jiabao <kaquoin@163.com>
---
Tested on current main (e4cd9f1d, "json_writer: fix pretty printing of
arrays"), in a network namespace with a dummy device:

  ip -6 route add fc00:ff::60/128 encap seg6 mode encap segs <60 SIDs> dev d0

Before: "addraw_l ERROR: message exceeded bound of 1024", exit status 0,
and a route without encap was installed.
After: same message, exit status 1, no route installed.
With 59 segments the route is still added with encap, exit status 0.

With 63 or more segments the failure happens earlier, in the encap
parsing, with a different error. That is not addressed here. The same
addraw_l() pattern exists in ip/ipnexthop.c and is not changed here.

 ip/iproute.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 1ce71f78..35c23801 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1525,9 +1525,10 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 			lwt_parse_encap(rta, sizeof(buf), &argc, &argv,
 					RTA_ENCAP, RTA_ENCAP_TYPE);
 
-			if (rta->rta_len > RTA_LENGTH(0))
-				addraw_l(&req.n, 1024
-					 , RTA_DATA(rta), RTA_PAYLOAD(rta));
+			if (rta->rta_len > RTA_LENGTH(0) &&
+			    addraw_l(&req.n, 1024, RTA_DATA(rta),
+				     RTA_PAYLOAD(rta)) < 0)
+				return -1;
 		} else if (strcmp(*argv, "ttl-propagate") == 0) {
 			__u8 ttl_prop;
 
-- 
2.43.0

