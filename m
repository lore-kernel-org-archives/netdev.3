Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975136;
	b=gGAdzBLJJ1AeHdB+TSMCi+d3Tt+9cydJyJ5hiDjrWWB/FWwloZCqmS4Tjjt4mffj+Bsd
	 BQTauGaLFPfwM4R73S3vlHKhi7KbCvQ/0gUmlreMjJtT20vw/hmLwsqeLHMGJRQriYyy2
	 Fuv2TzxdmiyiD7wgYyv94Le8544r/bP3Ivm8yeerrbyoOy8xXtZPQmS49cL3e65MfwyLK
	 CSdOa2olfpef0BKtLVG13BJCqer9y820HJxvn+MYatxqyEA9wN9eDavmzEjTRbfNTNeAx
	 mj8tu+QRiFE6itSWrwrlaZ9ok1rw6yi3sVTKV/zce9kEYflCGTlVej1qxUa9s9CEHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/vQq7/OUg3A7EulCfcTLyC9GSdMx/w1XZowxdVp3bKA=;
	b=kwiiKNUrTo7PAZtqfG7LR8PD1qVWEvl6FSfJJl1PB26SXAxW1g9K1cq+noK7vv4uQb7O
	 ZQZO43tc+1bqEc2ElkG1qUTxlikGxwt+icG2j4IBf8XS4YO1zgbkuxo8iom7cOLpxZqSR
	 C6A/RFxaZoCw7WDYkmbhFhN8Jdb6x0zPU+DmJLQtxCnh0SBDE+Pgu4+XetUCSd4tv8EY0
	 x9eyIEneJHHo27/8haxGmn7HU9B+kAKBkFsuBrpPi9UfjNoj+pQOybRKkJmqmD41IXyby
	 20X3K2agAlFzYOwlb1QZ2yNIogtiJGt0Xn5xF5kqbnKeM6vHCsJb9AnA+D4VVAAnFgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2eonC8s;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454D606D838
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6454D606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2eonC8s
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1146246eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975134; x=1794579934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vQq7/OUg3A7EulCfcTLyC9GSdMx/w1XZowxdVp3bKA=;
        b=W2eonC8s5BJoRJbGppqiM59YV2PN0mcjJtgshuRjRbHdVnNofp+7+PEYxNdpvBxpbF
         x5rYNo2JyVZ4V4R5Le102ZQNLVClJMW7MZuEySu52HnWSQZmSDOUkbP5vnxfuwlJpDfI
         OnuLXNgE0zwBeh84ZysOlJ+KbXUM98KIzUn6GaWW5s9kQaxxMgCuUGVLjfP12ZQXyr0d
         1bWAIW50p2F3lyLjDha6jY4ti7mYGfMqc0N+JVGJm6Uld2hLrwJUthgOUl+Jl5cj1L59
         io/hF4A70i+hbFY3leR89gt8TQE8zmV9Wlo86SCZk7x2SbAfkx9DkYhQoH3kfGlDKL+N
         qsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975134; x=1794579934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vQq7/OUg3A7EulCfcTLyC9GSdMx/w1XZowxdVp3bKA=;
        b=YAmecp33tdAH4F7Vv2NRucgwj/5f3FnyK9Q7GNoQt3r7JcKOZEcgAg3Th2qhwRhp62
         uYbo53hjYnxa2SRLZze0MeswpLuREK47Ov/bw1MpwiCn7axSeM0s36verlDMOzV6xqyq
         lHFlu/7/97+boAHhz60OvOOcMXrF7yqySrZPd5MjGdTIQ9sgyC1cTzM2qLSMci7QU1SJ
         SDFjn9tfQ/OVR95p7k4AWEWXblMEW9gH4GyIGrf9kPopLt+zIDHvrFpQo22eUb4xN3MC
         7Ls0eOt1LEzniqpJK5EgbxO/QjJv6zHMuxNydsPskFf2bWzYiP57q8YvC2kkANTPmEk/
         6c1g==
X-Forwarded-Encrypted: i=1; AL+hErE67e23d0NGcKSk2okF5HoeH9pZ9khmzXfyhj1MXkqk528Abvqn30viBq8H/ObOVJ/CzgXvF4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CkV9J3lLp1cv92oxAlnNLTpjPb79wn9G928HxOn5K+Y4js5Fl
	cX/I6xWJHaKpisPQRVckXrox+Ab+8VxJDRFaAl+1QWvrQrM+hw4apGCw
X-Gm-Gg: AYBFou1LZsuEdOtLCPvimG1S1VePWhZrOSvAjYluzbfJu5IO6eekooilnhGQ4K84Do6
	GOQlC9ooaNzhjvIB7GTGCGY6wo8A0VrSbI7HtT/8ZM4yoN3L/+W9j4jDXMtRTpITWNQZOik9zEs
	wXPi9ytnXXbzXbxXCgGPNAko5HyuQOlmX71Q254RcgrMpCddEEf7HeQnOceWhhcn1C/p5pqDMgX
	2EIx56rZ/pU2UcCKCKYZ/X8njZo1ppmjHWk3xqN5rsZrPLBcHZ/k50wOEciF1B/ZhH0zh71/Tlb
	2O50NLSYIMbeaSCT1TDB2CWAxoTvrkEsrsGersrsOur9K8QQlqLHSOAkB/gH8uo3lwrQ9H5KkdJ
	Z/d0ohpckwherZEUdqhVJL9/Qm3eiuuPWGEVtuDkwCUtHeA+uAXPYt1D66SZoqIguQYF/NpOa/2
	UG5yAcIQP0I4Brr1THUnFnxoFhFcGqhAT463QG0qGZxRE7SGoAOgY9qkp5C6SBhsXq8HeL8GHWr
	sgw/dqeU2kbmGO35fs1uJ8pKUVJENlp5Qb4aw8XYWd51nc7Gu5bSim/v13j/recjaZD6ebYXCnx
	HSpL1HMNq0L7z92nH7qXbhzKQ3l5TzVYUHRDB08=
X-Received: by 2002:a05:693c:881b:10b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36f76520e62mr3755759eec.28.1793975134156;
        Fri, 06 Nov 2026 06:25:34 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7101233eec.26.2026.11.06.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:25:33 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK
Date: Fri,  6 Nov 2026 19:54:20 +0530
Message-ID: <20261106142421.17793-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
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

A userspace application can set the link type of a TUN/TAP interface
to ARPHRD_IEEE802154 or ARPHRD_IEEE802154_MONITOR via ioctl(fd,
TUNSETLINK, arg) because tun_get_addr_len() explicitly recognized
these types.

However, TUN devices cannot function as IEEE 802.15.4 radios (they
lack wpan_phy, channels, PAN IDs, and MLME operations), and tun
never initializes dev->ieee802154_ptr or dev->ml_priv.

The IEEE 802.15.4 subsystem operates on the invariant that any
net_device with dev->type == ARPHRD_IEEE802154 is a genuine WPAN device
with a valid dev->ieee802154_ptr context. When an unprivileged user
creates a TUN interface in a user+net namespace, changes its link type
to ARPHRD_IEEE802154, and issues a netlink dump request (such as
IEEE802154_LLSEC_LIST_KEY), ieee802154_llsec_dump_table()
unconditionally dereferences dev->ieee802154_ptr /
ieee802154_mlme_ops(dev), triggering a supervisor null-pointer
dereference / general protection fault. Similar dereferences occur
across net/ieee802154/nl-phy.c (ieee802154_del_iface) and
net/ieee802154/socket.c.

Rather than scattering NULL checks across every site in net/ieee802154/,
fix the issue at the source: validate that arg fits within unsigned short
(rejecting arg > USHRT_MAX to prevent upper-bit truncation), disallow
setting ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLINK
by returning -EINVAL, and remove these unsupported types from
tun_get_addr_len() along with the unused <linux/ieee802154.h> include.

Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
v1 -> v2:
- Instead of adding NULL checks in net/ieee802154/nl-mac.c, disallow setting
  ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR link types via TUNSETLINK in
  drivers/net/tun.c, as discussed with Andrew Lunn and identified in Sashiko
  bot review. Virtual IEEE 802.15.4 interfaces are properly provided by
  mac802154_hwsim and fakelb; TUN devices cannot function as genuine 802.15.4
  radios and lack private 802.15.4 contexts.
- Add an explicit bounds check (arg > USHRT_MAX) to prevent integer truncation
  bypasses when casting 64-bit ioctl arg to 16-bit dev->type.
- Remove ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR from tun_get_addr_len()
  and drop unused <linux/ieee802154.h> header.

 drivers/net/tun.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e60..f2915e929e3 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -70,7 +70,6 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/mutex.h>
-#include <linux/ieee802154.h>
 #include <uapi/linux/if_ltalk.h>
 #include <uapi/linux/if_fddi.h>
 #include <uapi/linux/if_hippi.h>
@@ -3183,9 +3182,6 @@ static unsigned char tun_get_addr_len(unsigned short type)
 		return 4;
 	case ARPHRD_ETHER:
 		return ETH_ALEN;
-	case ARPHRD_IEEE802154:
-	case ARPHRD_IEEE802154_MONITOR:
-		return IEEE802154_EXTENDED_ADDR_LEN;
 	case ARPHRD_PHONET_PIPE:
 	case ARPHRD_PPP:
 	case ARPHRD_NONE:
@@ -3362,22 +3358,33 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			netif_info(tun, drv, tun->dev,
 				   "Linktype set failed because interface is up\n");
 			ret = -EBUSY;
-		} else {
-			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
-						       tun->dev);
-			ret = notifier_to_errno(ret);
-			if (ret) {
-				netif_info(tun, drv, tun->dev,
-					   "Refused to change device type\n");
-				break;
-			}
-			tun->dev->type = (int) arg;
-			tun->dev->addr_len = tun_get_addr_len(tun->dev->type);
-			netif_info(tun, drv, tun->dev, "linktype set to %d\n",
-				   tun->dev->type);
-			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
-						 tun->dev);
+			break;
+		}
+
+		if (arg > USHRT_MAX) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (arg == ARPHRD_IEEE802154 || arg == ARPHRD_IEEE802154_MONITOR) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
+					       tun->dev);
+		ret = notifier_to_errno(ret);
+		if (ret) {
+			netif_info(tun, drv, tun->dev,
+				   "Refused to change device type\n");
+			break;
 		}
+		tun->dev->type = (unsigned short)arg;
+		tun->dev->addr_len = tun_get_addr_len(tun->dev->type);
+		netif_info(tun, drv, tun->dev, "linktype set to %d\n",
+			   tun->dev->type);
+		call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
+					 tun->dev);
 		break;
 
 	case TUNSETDEBUG:
-- 
2.53.0

