Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479437F738;
	Mon, 10 Aug 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351890; cv=none; b=FT+YHpci6VtT8+SWTG0E17PfboL02e/xVQZYUAqJwovwy+K9pyNyUBmuXGlAv3V6r0fcvH8Gt1cqgpLloJDavvDFF0oaRi4FOpz9KEKNlox3ljpc6CLGMydhwLUQ2W34yHhaAv9ubEFxLSvxQrFvGnYTOqm52Mais3htJgr89kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351890; c=relaxed/simple;
	bh=+QvBLcTsWdJDGth/D1G2rjCpwq8NAV4Ul14lCwZwNeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSl/qaHmOjGqnpy+ebyxXAujFsqmcOAxI4fN0XXt6O5f3D2UnPinjCQTHq5liGtnOFcpqmolK4/KEwz2paWDbcKZmrY7Q6CvYQVIymaZOYioH8UjOGG1JYB37MIDm4luKFXlBMNMPXw8Jdzch1c8SFOwtot5kIfIzdrx+FnPOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lKkPR41s; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lKkPR41s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786351738;
	bh=OCOwKw94fgSOdQYspsNUWeZVIx5c0/cYUk3FLEQK5ag=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lKkPR41sVyQMyoLxnLlpofEbgPB1jSw7iClH6MiiktaZSm41LaCUgAZmcSCSZldZs
	 tgzFleeS88JqMdow8S85uC5jlqT0uq7zgn0mKRmo5Ruq2MBhODM3pF3QoLzKzY+Zeg
	 bcnWXPMbIviXDqW5Cmwtm2K9ehvvaAqseSfXGulY=
X-QQ-mid: zesmtpgz4t1786351718t95a78694
X-QQ-Originating-IP: zhqPRlMwHhTN8QUWVDBhwZi6QrmwUXqFRAJeFXRP1Lw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Aug 2026 16:48:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10737897544031835885
EX-QQ-RecipientCnt: 10
From: raoxu <raoxu@uniontech.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	raoxu@uniontech.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: lg-vl600: fix Ethernet header on fragmented RX packets
Date: Mon, 10 Aug 2026 16:44:35 +0800
Message-ID: <30CC616506DE5BC4+20260810084435.2099229-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NRLj+a+1JRyJ83U0JHGUv/JaHmxBXKZ2NU6rXPqkpGLq81G9W3eWXnYX
	4U1xJenTI0q1/2bMrjeWc6x9mAqQzkIiRM3myhEYx+q67h5w+iWNdSJw8RBZYm/LMb8QKev
	cwNJ/FAP+ehNSEsxSpTxnX2bJGb+oV6xtuZYMkyE+JQiwWqkrH3gBqwuJfFWYvuWDc2z3tx
	AZ6O7VeMMx3p/EldN/kvKWXbDkExyG4QYRfW611h/SJy080YQ8rou9yVrKwemnH/ONxVriP
	T3bjgghJ34hrMTphb2HTKo+oex4DKoDjPrULaahM7kBIn8XuaA3c9/537M3Q6A5S7DRIKWB
	sRECCnohvLF+dho4PnzmrMqgg8VVgSItcW8Q6GFD5L04ayzhyZc0fmXoQk1E31VK+YrDDsH
	l5CqLF29UjvQVmUqyYUncps4TASNDQD/gDPsXBIU2p9PpZxKuQ3fuh0E2y+rFHcakSiQm7n
	NpGpE4dvd7Kj3ut+8/W4l9qLRSZH+DjF3YpxYq6NAUVPvkYB19oyGIEJzTCcDN5bmAGPLD7
	8+BP0hKfJDUUxAB2Bo9i7I7yy/vqc48Ju2l1k53qJ6dPLDbE3py3rqPyB+kDga9ywnqbs2o
	dL9xPO+j7AIwcIGmcVj8uVd0mbMhnxgoRfpdr/RIwv2Vsw6/vrqQ9Fi90DWwLDsEvk/PQuN
	RjYQHXU3OBkqY69ZJYvaF9b3CA1eQUmaTf/RJvGqtEP4btiHgkhTnLI7gF1GG30h1rkQW2e
	rNLTJ0j7LnUAWec0JMHWGdU3NRwj5DrrTqdSehx8+ZXeqxv7NJY1HBmc1ZWvHtDzAIZePVW
	YxFSCc35hYafzgGjTcT3XcxhJ1qUwPCu2HVimPpkjJ6zoDqWEYJPorlF+f+pWSy7Lot0CbF
	nGNSEN67c79xDVgjKcVvrs+tZ00ScttsMtnEFRPmKtIs6Jkf+KsXw8cFd4F/9EiilGM7Xav
	LI6cgRiIlGMigUqGoNhldtzzUIGLD85tn8lWVlidmxBzidfbn5wRkfetBf9TQPI6C4IHcVL
	R/IAQBx4YXlqWnHY6lARPGny4iwobqUSfeAmCAzMoct3b9BQej8gCKRHZ4Pps=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The LG VL600 RX path can assemble one device frame from multiple USB RX
URBs.  In the single-URB case, the input skb passed by usbnet is also the
buffer being parsed, so @skb and @buf point to the same skb.

When a frame is completed from current_rx_buf, however, @buf points to
the assembled skb while @skb still points to the last URB fragment.
vl600_rx_fixup() returns @buf to the network stack in that path, but it
currently obtains the Ethernet header from @skb.

As a result, the source/destination address fixups and the IPv6 ethertype
fixup can be applied to the final fragment instead of the assembled skb
that is actually delivered.  Use @buf for the Ethernet header so the
fixups are applied to the packet being parsed and returned.

This has likely gone unnoticed because the common single-URB path has
@skb == @buf and therefore behaves correctly.

Fixes: 7a635ea98999 ("net/usb: Ethernet quirks for the LG-VL600 4G modem")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/net/usb/lg-vl600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index c4ad2d9f6f4f..d6b2e3e3d950 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -172,7 +172,7 @@ static int vl600_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		 * the h_proto field is in the same place so we just leave it
 		 * alone and fill in the remaining fields.
 		 */
-		ethhdr = (struct ethhdr *) skb->data;
+		ethhdr = (struct ethhdr *)buf->data;
 		if (be16_to_cpup(&ethhdr->h_proto) == ETH_P_ARP &&
 				buf->len > 0x26) {
 			/* Copy the addresses from packet contents */
--
2.50.1

