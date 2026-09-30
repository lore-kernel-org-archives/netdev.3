Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0750AC16;
	Wed, 30 Sep 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781366; cv=none; b=S+6sIWxMS6oAn1i99HwesqWbN3Bp4wlVoISoDqKy+M74ikpvU8s1dL2N3JknnHTZy3MLq3Z7P7kWmaEWRpvx3rqRzqEsZQM0cbWQAH9YmDojpiH3QrkSToegUs6UpuOJluZH7t0tcEKZV2RqkXGM4L2IQzZWcFZ1PQncM3goam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781366; c=relaxed/simple;
	bh=+9YhUs4gd9WkwJ1XkkjNLrzfkJog6zSHDcF7kM7NVOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBI19EHv58BQh5fLB/XWBlLRLWeiLnMAJK1MxgF9G8J6V7DyfV9MjE3il8NJMes2xugZYAkce97+E+xl34goZMccQ8WMYWUdXD0PpyHRPa6NJemRkYyCiK9u8ISD1wQdVX9fJEFamEcIGnknjsAPjFqeOrxahDijO2mSRjRYPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=vqs2Njeg; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="vqs2Njeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vqs2NjegrNNppy1HDGmtzQ7Qo//Dfx3+TmaUF2x4KFTPqCJMsGKWnJjUXfN/M3T3BrJhDL7FX9zr3
	 oIr/eD2fPPkAXJBDQW3Q8KjDX4GA0nEhqBjR8etacGZMBoeHMNxSza/hyTKPQUyEVpIPEa9xXuOdtn
	 HAAfNqtGj7H+4Lno=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66abd2799321-5ae56;
	Wed, 30 Sep 2026 23:15:41 +0800 (CST)
X-RM-TRANSID:2ee66abd2799321-5ae56
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86abd2783ebf-02a5a;
	Wed, 30 Sep 2026 23:15:41 +0800 (CST)
X-RM-TRANSID:2ee86abd2783ebf-02a5a
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net 2/2] pfcp: make sure the SEID is linear before reading it
Date: Wed, 30 Sep 2026 20:48:18 +0800
Message-ID: <20260930124818.114224-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
References: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfcp_encap_recv() only makes sure that the UDP header and the 4 byte
PFCP header are in the linear area. When the S flag is set,
pfcp_session_recv() then reads the 8 byte SEID that follows, which is
not covered by the pskb_may_pull() check.

A short PFCP packet with the S flag set, or one whose session header
lies in a fragment, therefore makes pfcp_session_recv() read beyond the
end of the packet data, and whatever it finds there is stored in the
tunnel metadata that flower later classifies on.

Pull up to the end of the SEID before reading it, and drop packets
that are too short to contain it. Reload the header pointer afterwards
since pskb_may_pull() may reallocate the skb head.

Use offsetofend() rather than sizeof(struct pfcphdr_session): the
structure is not packed, so its size is 16 bytes because of the
alignment of the __be64 member, while the header on the wire is only 12
bytes, and valid session messages would be dropped.

Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/pfcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 1d14baf27c64..b5ebe6871cd9 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -65,6 +65,13 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	unparsed = pfcp_hdr(skb);
+	if (unparsed->flags & PFCP_SEID_FLAG) {
+		if (unlikely(!pskb_may_pull(skb, PFCP_HLEN +
+					    offsetofend(struct pfcphdr_session,
+							seid))))
+			goto drop;
+		unparsed = pfcp_hdr(skb);
+	}
 
 	ip_tunnel_flags_zero(flags);
 	tun_dst = udp_tun_rx_dst(skb, sk->sk_family, flags, 0,
-- 
2.43.0



