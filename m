Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068844;
	b=Wb1d3ajDBjcQDg0l68RLmklpnBY4EZaicoRkvfBCWM8hNFHEhZt8rpJihzC7U+HZjol0
	 y1BoLVLxtZPdzyDQ9UgmnU+ca9gWCwop4Gk2QwELzFZXJREg+8maXGuJqR3dBz1NBzVul
	 EN65dAFx7PCssMdAGohRaLD86uJWZa2+zAzRAuEv/tjSUrxgouaq04DkQsGUs8SI3ZIPx
	 lpem7oOKfriFGwCDa+iLxLIEKfjIFmh9+VGCETUxl3yapeBtPcpYhpLyVI8DjWB9zRoUU
	 JPdy1oJ3CDAK4dVq3a9bkszRF4jI35c3n0SKL8p3b2XNDZ24fTFtYnd09AUGMys8h9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8iDgo6XjJcvB5XRw1w2M3oqlB25XsiQDubeqinQmBrM=;
	b=eXrLhw5u+fLrwX/v1qH8UID/L3JgcApuKYn8hU9HgLzXMu5SMFs0QedTQtyupbm0rlEV
	 i2XdBQfKcUM0bueXBfjRxHT1ZAlBhhbVZgL4jDS2PURjEDwrgK5ag3J7Bg0NSOpZfoBa7
	 k84NrmQCyeU5TFgizi1dJ6DZU3Sh0f7RahilUz/00OBRn5EzOsG8k/dumnjeNbs6tdo8y
	 5t83BLrqs1feDp95s59Fksoh8psFvy7dTnTgUvPRwKT2ME5GCV+UhT2RX6APl4K7wrIXv
	 Pszr40BdEe4QQnV0f4iRBCRN7TklwlhFDO6lUfMSsFRSQJJ6ebe7l28nRBoug92rEQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWDsj2Cw;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90BF606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 16:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C90BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWDsj2Cw
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1adbf62dd31so2079705c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068843; x=1794673643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iDgo6XjJcvB5XRw1w2M3oqlB25XsiQDubeqinQmBrM=;
        b=wWDsj2CwAZa7+glxJkIliQdsvFrzUPRaa+1MfUK/l/CTx/1bu8Qat8tT551GBRkT6V
         9uzHPdIZT2bVCs3gRP7FmiLWPavC25Ktm/6kv/N74t6mzjCHOzFbJIO9WpPrXpkjyyHH
         CzOPIJEQ6RITHqe2bp4t9SZD4+KuXhajqA6LLK0SEMbPQ3N9+LNmQwai9NfbYJ7rLK5G
         XWAzre+3+3ZoQ+nuvhW6bzT1BWtmQes4eigvar3t6cTk41KYmM0nA09LOcCuzKliR7ae
         3AlRjHCiJrNbFOj31v5TOoZqjnz0Ju4WJCc+VJuGhJznnZIY+LLRgXrHI7+D28Tgea5r
         rPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068843; x=1794673643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iDgo6XjJcvB5XRw1w2M3oqlB25XsiQDubeqinQmBrM=;
        b=RWdSec2NZLwuQuyZe+dD9+cUsnAlAVFj2hteTc5wSksHInBwv66rzhLfi0FG0nn6Qe
         xrsquUmJlAPbuNPyB+CMpzdjIpco330PuCn1RgU1rDDcpdzBG08TP9h61ckTdCGJ9ZJV
         hNIp0XRvr23xm9HcN6Kph+iIFXKNM1yHDXvGz/XX4b9mDBInq8W9YSMuDFBL3MrTIVLu
         KmzqEpsONH8rSmKUZwGQ+3VpM/hcCzveGFUyqHonlLrybg8kcCzihVThzMYuaA4eF2qk
         dyZZ0fsoV6RK7T93H6VAEFvzbei9qh6g2Sqyeo1uzT4bc2iIikkXmFnYeC8eLrqBjqnt
         /leg==
X-Forwarded-Encrypted: i=1; AKwUvBxnRuByR0Fk8zYO1ge+UTz71u8dIS5GFZlP4iyHd3g9smaU+NkQBENx+m7q9BENZqRVEAhl80s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Y+XewNg+JNX+W4URRWSJ6+d1JIaDQeRPncAwCAq5DE+sOBSR6
	V5lXjBG9s+uvLoisXXnlKFPZcE9D1IsQcicd6Vyu3sb6ximS2l5vvR8q
X-Gm-Gg: AYBFou0GK7sYZhBmYWB102ID3XQpz27fHJRmFIfpWOqvWQVuwFlrZ00RSmzyT6w5GBL
	VCaSYLLhx9W1JkxHc4xYGHhFniQ8mJv6DK3GMPf5jD0IvV8MFFZk4t/uu7kRG3FBwuuFWUo3hXh
	vJvnZ4Izm3KymFpYcdqHftxbCcj1QSdUE3VWkxvMyyezQ+EAU4G694AvmunnUk3e8ZpTsp6m9bJ
	XNL91yB8pOhnN+8wgvXjw36zCJtN2X+9i6c3gaLG84BugrAJ0tuhiHN6IC+uBqGASB46duI8Jg0
	5dbzPYRMwKxtwXZlxOdradsija5EmrJo/UYfD2qEwfp9ynWZOKxmHUPLpLFP1DD0WhzbeyxezMC
	ac4YLp3YrCsB6aS7bf+4tVztxJGGBZXL7TkR1Cj4ZG9sFLbG218ooOOgIZnPt8Uv0hrIWv1ONgy
	DEzQQQyXKg2GgtCL65qWXPpls6cQdPBoQ03bNeJzUxSwW8OIBBwPY6QRrMS1LeDAq1aEhPbDVpp
	7aAmIq18RLFiQarIdkJCkBy24fiEzfR7dciq0Gdu6bmo3gIp0u7xkOdgy0/7+zIioXVG0dm9+1U
	N8lAYvhp5POq+4M2vAkVJ68PnNq1CVr/k/6Rdko=
X-Received: by 2002:a05:7022:29b:b0:159:aa67:28c1 with SMTP id a92af1059eb24-1b25d3499f8mr6609198c88.20.1794068842773;
        Sat, 07 Nov 2026 08:27:22 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm29025370eec.15.2026.11.07.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:27:21 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH net v3] tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK
Date: Sat,  7 Nov 2026 21:56:49 +0530
Message-ID: <20261107162649.282982-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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
to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
recognized these types.

However, TUN devices cannot function as genuine IEEE 802.15.4 or 6LoWPAN
interfaces:

1. They lack wpan_phy, channels, PAN IDs, and MLME operations, and tun
   never initializes dev->ieee802154_ptr or dev->ml_priv. When an
   unprivileged user creates a TUN interface in a user+net namespace,
   changes its link type to ARPHRD_IEEE802154, and issues a netlink dump
   request (such as IEEE802154_LLSEC_LIST_KEY),
   ieee802154_llsec_dump_table() unconditionally dereferences
   dev->ieee802154_ptr / ieee802154_mlme_ops(dev), triggering a supervisor
   null-pointer dereference / general protection fault. Similar
   dereferences occur across net/ieee802154/nl-phy.c (ieee802154_del_iface)
   and net/ieee802154/socket.c.

2. Similarly, the 6LoWPAN subsystem assumes via lowpan_dev(dev) that
   netdev_priv(dev) is struct lowpan_dev. On a TUN device, netdev_priv(dev)
   is struct tun_struct. On netdev events (such as NETDEV_DOWN in
   net/6lowpan/core.c:lowpan_device_event), it clears bits in
   lowpan_dev(dev)->ctx.table flags, which corrupts private memory inside
   tun_struct.

Rather than scattering checks across subsystems, fix the issue at the
source: disallow setting ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and
ARPHRD_6LOWPAN via TUNSETLINK by returning -EINVAL.

Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
v2 -> v3:
- Include ARPHRD_6LOWPAN alongside ARPHRD_IEEE802154 as agreed with Willem
  de Bruijn, preventing Sashiko AI flags and addressing the underlying
  lowpan_dev(dev) memory corruption.
- Minimize code churn as advised by Willem de Bruijn: drop unrelated
  USHRT_MAX check and preserve tun_get_addr_len(), headers, and existing
  block indentation.
- Fresh standalone thread as advised by Jakub Kicinski.
- Link to v1 and v2 discussion:
  https://lore.kernel.org/all/20261101092219.1278751-1-skalpesh942@gmail.com/

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

 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e60..05eb28578b8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			netif_info(tun, drv, tun->dev,
 				   "Linktype set failed because interface is up\n");
 			ret = -EBUSY;
+		} else if (arg == ARPHRD_IEEE802154 ||
+			   arg == ARPHRD_IEEE802154_MONITOR ||
+			   arg == ARPHRD_6LOWPAN) {
+			ret = -EINVAL;
 		} else {
 			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
 						       tun->dev);
-- 
2.53.0

