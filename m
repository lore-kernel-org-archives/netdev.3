Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E017A314
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787400107; cv=none; b=lXRaUwSXhTyeg8Etn7RSikteVCtLp0OGzEy/sgu/4XIBKwzljO8p2mcv2ckGOIrl5fyi7nEQLkPjv/y639KO9jR4VUakrshte+449jCPf5lB0FIqSLs5b3uZ0iP2jYlEhQRxB3jIABfa6JfV2gA+MfhWuQTd+0B69l7/7x01NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787400107; c=relaxed/simple;
	bh=tg1A0Vit7mKDNZtJZZKke768DSBVEI+360rKAgW2CkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY/1wu1iMe4MLp+D/+A8NDrS35FEHAFJru9UHJa9QnoIBgEHZoK6KcFBsl0ZspHrlA5BoGZC9opT1ZrmzlJ0ZSoZAxC7OAI46Ax7Gv3C6ImQ+57AqIVpwqJF5qiYjlSMRi5qZQLhtXn/BcfVX6nUl0byBpK5Qy7Pv9hG8u+DDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=S0SDXHZp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYInRHyD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="S0SDXHZp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYInRHyD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 782A17A0048;
	Sat, 22 Aug 2026 08:01:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 22 Aug 2026 08:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787400098; x=
	1787486498; bh=Efr18sjWjKItAotTwy3gK1jQQkgQnyUd4Dfxl4J0yIE=; b=S
	0SDXHZpi57n18jmIEtH8AKM5/kup3ARf8F7jhFjHSU/Pz9/sas36KoZGaO3+ISG1
	5xm2E4/W3j1wOGREG1Ekbb8ZwUECLv8AMiKtQd8N2KMfz00dJ2K8JLB8n9wM2Uot
	+OH0zmRiKnskfmbnPKzzwf7Vv+/Wntgcrc8zAJK/o8PyYIq31wqJdp2Nhkpus0v+
	wPOJ50k+WB5iIfMYxmkE4wwqlsnfDIBJKLhucIJ811L2idpnW6iD28gccAZIcqrc
	ysAq8MUsALTafgqvwzNcymVF1GbnZwqWI3ej2MxIIkQ3TuAmaL5Sqa30vyyxJh+q
	9UKHpKIwi6TSnkCSr1CYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787400098; x=1787486498; bh=E
	fr18sjWjKItAotTwy3gK1jQQkgQnyUd4Dfxl4J0yIE=; b=NYInRHyDcVBGF0gHQ
	P+c6mHIyJLnS3RFFl591SPvTZl22hDJkY4M5oVjv8kYEuLjBiOqaLIe8/3MNAA/+
	4moQJ83zMd0ih2GnlvDoJn1gcAfz/Cq5BrWk8xm7u7naymjtbrVxPkesUhZSaSvF
	bsvWny/TSI+FgOKzSGs0WCHPR6wCDVixlZXHae7V2ksg3hka25z1xvm3NA+0jUM1
	MTsZDs6L0uLGNv+Ix9bXeK/2uozdno36POI10Un/lZP3AUnJ2cJtjshXaw/dt/ea
	8ePwf9Nh6ExRvq7mH8b2TvXBlDS3LxWv6CzQnqyDFj+xcyV5pDFmeQBhnkpZbyLh
	NC0ZA==
X-ME-Sender: <xms:oo-JasUpZF07gnjTu2AjW4U83fVy5b9lCP6rABaBfuiPhEwY414YLQ>
    <xme:oo-JaoKWWm9ALoN5CRXAbosc_fXF3vnCP0hDw5bJ4sH8S8j1pYOVuihOqEFDnwjcl
    3s9Ngsw-cKSGcX4U6648gYvrHPaBsr3cdN4DZnkvvwOnbai3RjT5A>
X-ME-Received: <xmr:oo-JagDsTWNrlsRVOB7OjbgjGwDjJtz9D1RDNuiaGzEMch4MZkLJDCh6lkOZqw>
X-ME-Proxy-Cause: dmFkZTFPgAmQEyis45fEmVkGhQzSewoHRWe5HsZ8CjopN2sFnWAiVJIm3wyadXuzQeSRuU
    IAFlKTfUTPCdruH1uxkPfM/WjBwbc94TWUiQZJ8X1J02XhdTpKmD65oYyoZGsWOTJAVokD
    88NvM7kJMCeIupSY92G2At5iy1x0whvU252lFVNOA5u/GCjb/SntDJX5TAwl2ry+9ieV/P
    Ffls5R0Sf/HRVbn6+LqKO7Pe4dCRyiFo2r+qG7WddBRemJB0pMTlKeVgcioNqvE3HTcX9/
    Dtja3WAsZMcSWw9RvyebEF7K7jMVehQJBLvCFv5Dy1eC9hgf4GXk1kAGi3AtX54YyK8mA0
    SZ2mXw0i4oQETh8yYRGXBPDxuNLtNdXZ3ngIehLvKrQdvcfUfWHO5xuLjPJDJcxDbU0g5h
    LEKcrBbhMEUpaurloA0t14YNJ2HqBImR8CBDCJxXhjMTE+IT4Uypgb6XSYrDHmNuLszmcn
    B9zI6KdObauGs61twsv1GdhUq+v4QE2MMUTzvkPRiOKispZEDjW1cj7Yc7tu19g2llqlzD
    Mx0JOooRpt41tkUWBI5xEcA+ofPSo7bUeqgke+jTmKy2JNCYhtXd2711hmCJroFuJiReDD
    UK/Y5kLtuNA0S6jupv0YKcDfWpW/Gm+M8xuXuEYxw5f7wNWWSmVEdR2HhUww
X-ME-Proxy: <xmx:oo-JaoHb6I1AgsYiPwwximRArIi0NysXTXNLG5D4JaV2TFlz7SoUCQ>
    <xmx:oo-JatLjmO4jiYN-h7htLTAH1Nhq0Ylrq3vTTZuMgqImzv7Pq5zqXA>
    <xmx:oo-Janrq5fQzwkuaAj8cZD5L4jl0XHtouj3hqIhRKH3yfpo3klJoIw>
    <xmx:oo-JasiNAkF8T13DpSvXh595iokgMcCY85-4u4Rk5pmBxStiAtvieQ>
    <xmx:oo-JakTkjlO9bTPxEM9yEVRNgrBIQVTQuTKVTqdC1ZWvNq0-s-KWAkGA>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 08:01:37 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net v3 2/2] net: Guard for gso_segs overflow in skb_segment
Date: Sat, 22 Aug 2026 15:01:17 +0300
Message-ID: <20260822120117.1163423-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822120117.1163423-1-alice.kernel@fastmail.im>
References: <20260822120117.1163423-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

skb_segment calculates 32-bit partial_segs as len / gso_size, and then
assigns it to the 16-bit gso_segs field. The division might overflow in
some edge cases where the SKB is BIG TCP (65536 <= len <= 8*65535), and
gso_size < TCP_MIN_GSO_SIZE = 8. While normally this can't happen due to
TCP_MIN_GSO_SIZE, an AF_PACKET PACKET_VNET_HDR socket could generate
such a malformed packet until the previous patch.

Blocking malformed virtio_net packets was implemented in the previous
patch, but this patch clamps partial_segs in skb_segment itself for more
generic robustness. Should len / gso_size happen to be bigger than
65535 in partial GSO, skb_segment will now just produce more than two
output SKBs, all of which will be valid with gso_segs <= 65535.

In order to catch possible other cases of too many partial_segs, add a
DEBUG_NET_WARN_ON_ONCE when len / gso_size happens to be too big.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4382b68d56e..ceac295bb63d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4871,7 +4871,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
 		 */
-		partial_segs = len / mss;
+		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
+		partial_segs = min(len / mss, GSO_MAX_SEGS);
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
-- 
2.55.0

