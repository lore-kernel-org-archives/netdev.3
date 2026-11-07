Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794044179;
	b=N+mCL4C8Q11Q72HSnUkMcye2/xsXGVI22p/z9zgeJNXIt5qf5ajOcolpYeoQzOhci1cs
	 yG55YEHNegrNo9XhMHRYGIXABKdRbj13BXAdf3Iz4B19Syx5A/W4KyQle15hQhGtfPLqa
	 J51qd6oTPqCmRyuNUqCZmA/1wyICXnAuHk3xkOw0pbFm0ifhpHR9pV1kZI+ZVZ/Hthbm9
	 hwHzQ6+qE5xASrc3SNUrKdcgJKPE7rLyw6PMYn+dC+NaGYHm2iKk+K1Rv8+62/YgTw7Ol
	 /OFBZssIPbTtg0eQsLUqNMJaJSoZxxG4Ms6odv84mnfQwZW9f1A4ag62EhJsCTTspMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044179;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t31VrqxX/6Kokqqwv2fdOX1UJc0aKrpkZnqQRqM3rf4=;
	b=a8fDy3BhxxqkyruNUSq7TQYPZEE5zVDd8Ti1C0SwgXUFMJq0CiSaIhBBIzfi1B1A90jO
	 ZPsY4QkMVYY0TPCV5VImChPLMwFeaNgh6VwHnA58yiaxgoAGWEzj8Go4ejd2qY/slaM4z
	 lrymKHq2WH1h4yGenYr1gSbwlQpgqsh+pzbTpFyqWnHclBh+eTAz1ucGETV1wnh9zc83c
	 vRwctz2uXvlngd1wBzV0Omee8GDxKxs1IDwo4Y4dpWUL8kxBpisbbHyuEhBe+14SQTDwX
	 Z+aP1rmNvCWMfZKlSwhNn+5/IyGom5G1fgBX25sQsQ3tRHgvAhbRjXkf1YNwkiuoGSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=naver.com;
	spf=pass smtp.mailfrom=naver.com;
	dkim=pass header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=YKCcT+Ls;
	arc=none smtp.remote-ip=114.111.35.159
Received: from cvsmtppost19.nm.naver.com (cvsmtppost19.nm.naver.com [114.111.35.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9161606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 09:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9161606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=YKCcT+Ls
Received: from nv1m-hmac-real-24 ([10.174.201.121])
  by cvsmtppost19.nm.naver.com with ESMTP id td6lIQxrStK1s-UyRYaxBA
  for <netdev@vger.kernel.org>;
  Sat, 07 Nov 2026 09:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1794044170; bh=v7B/P7rykYj0eZShFThZFg5hZuGefmyYt6GFzO+LfzA=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=YKCcT+LsFJXpLykqJQD70JgvlpSFX47SbzauM4FNzcyN4xAZ9No8pPHaVgW0llQdO
	 a4AI1me0qrboqW591f7qnuPaZYFEi5Qo4bMG7u2/Cv3fc377a1lw/VdDFQcvt9WCCw
	 HuVLTdX/X3oe34xfI7SGx905M3viAIDV3DTLD7/DhGfB1LpI0MbOgRE59zYZOb3Mpb
	 Ek/bibkZIU/ZRt3fzeabEVEfMw/lAbMO8qDFUt16OlX436C+EShoFfE01jKLF3fI+9
	 t3mOoCT+T3B/ahsIUy039iCW68TZwi+jcXoTM+HARy5d4G+btz82ODzjqHqvgKBgj8
	 N+qU01GUbMtBA==
X-Session-ID: Add5CrCTRhKPO3sBb-JiAw
X-Works-Send-Opt: OP+wpzGdjHmdKHFOMr39Ko3YKHm9jAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rdYwKAtlFqJZ+HmlFobw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp002.nm.naver.com with ESMTP id Add5CrCTRhKPO3sBb-JiAw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 07 Nov 2026 09:36:09 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] ieee802154: require CAP_NET_ADMIN for SIOCSIFADDR
Date: Sat,  7 Nov 2026 18:36:01 +0900
Message-ID: <20261107093601.619363-1-tjdqudcks0424@naver.com>
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


PF_IEEE802154 DGRAM sockets are available to ordinary init-net processes.
Their family-specific SIOCSIFADDR path calls the netdev ioctl directly and
does not pass through the generic network-device setter capability check.
An unprivileged process can therefore change the PAN ID and short address
of a separately administrator-owned down WPAN interface.

In a local fakelb fixture, uid 1000 changed both identifiers and the values
remained active through a later administrator interface open in three of
three fresh KASAN boots.

Require CAP_NET_ADMIN in the socket network namespace before processing
SIOCSIFADDR. Keep SIOCGIFADDR and all existing state and value checks
unchanged.

The fixed kernel rejected the same unprivileged request with -EPERM and
preserved the administrator identity in three of three matched boots.
Administrator SET, running-device, invalid-value, wrong-device, cleanup,
later-open and recovery controls passed in all baseline and fixed runs.

The demonstrated impact is local cross-principal WPAN identity and policy
modification after privileged device setup. Memory corruption, disclosure,
RCE and LPE were not demonstrated.

Fixes: 9ec767160357 ("net: add IEEE 802.15.4 socket family implementation")
Assisted-by: OpenAI Codex

Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 net/ieee802154/socket.c |    4 ++++
 1 file changed, 4 insertions(+)
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index be8ca1f053a2b..362457de8424c 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -128,6 +128,10 @@ static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
 	int ret = -ENOIOCTLCMD;
 	struct net_device *dev;
 
+	if (cmd == SIOCSIFADDR &&
+	    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (get_user_ifreq(&ifr, NULL, arg))
 		return -EFAULT;
 

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.43.0
