Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D435E94E
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643190; cv=none; b=uh7VrVQHeKiyWowRzRr83A0J66yvjM9QlIXT4LDE5HyCKoICc97153LDLdPe9+xGIlema6saioQbXbNUmZBSnNUxAM0HSxUazz+t036/RY3U5DdBotRW+885Y5v5D4754Ppg9UJYn1qA1anYd5aJjO2FPVzjy3hu6Gkn874ueJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643190; c=relaxed/simple;
	bh=WM8/7uQH7kGGSI2iUE7IIkFdMZ0Ah9RwIFPt+XlWcA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW/UCW4ysBIK+c8hFUba0wUQqkdxSUfRPWNA2kFPHqfxCTkj90ii4dZI/SiOQHPO6VW84mL68mAGi8pbqrCeeU8vFMG0NNi8ifbBVrIcbvq8U6X+/hOiWGlMsq+8eTAvEGlfMm1mZcotQ93H16eml9A290QqplUL7S+8y2ixNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ruXmmalM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2LW5CUg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ruXmmalM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2LW5CUg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 35CF91D00141;
	Thu, 13 Aug 2026 13:46:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 13 Aug 2026 13:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1786643187; x=
	1786729587; bh=Jl9KtGry6qthWjU6/o+GAD2xnJxgCR5Z3BWp3TaPVi8=; b=r
	uXmmalMHmS9qSPclC6SQJCw0VKLWrKBkFaYaBgjIDMk6kG1oYea5MAkWsqVlQag9
	Hn8N/YTEHqWmOgSTwadJ0a+ZAXcDGgU9u1TSTOzTe/RWgknhzhKhA8+e/QRTTsSC
	M6cRLHmBuypyS6UxWIrggKMU/i0/Dsp5NxiE+xS5y2AfzY/QUhgfToAzYFCvawia
	TQeENpasVRNnU9cbio+eLI5b9JPjFS1Sr0KATAxaqNKTsj282xK4Q8QF8nbLvmMZ
	CRUYjZDjkPGt753PLVFLS7L6ivLhOQx3+Z0xosx4dc0GsO4Aje5lITRyaF+f0MqC
	WX+lrt26WLirqs0ESmp4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786643187; x=1786729587; bh=J
	l9KtGry6qthWjU6/o+GAD2xnJxgCR5Z3BWp3TaPVi8=; b=W2LW5CUglfx65GLuv
	q0bsb53+7V/WbxSuj47O0wlCq74EDuD43rpeoFkwXS8GIjvMjs1mlkJo3GFdyFxf
	BDbfHLFEoB1aSEFj2jV/fa2RaIOkKs3naySeKgsGg3py/V4N7AUo6YOd14N1388U
	cnJZMo/UiXOwbnvQOQTCkm3l3lobvHzKVHFoCQ8RAEyWkW5PXhtn+nGX7V6o1zSP
	8Eapyo3HJXBkozq49YPCF3hRIM7kdLInknt/xcx1pi30FilzPQ0HxmvEfNq6hdhb
	QcFXTJ5Hwf0+C8pYfXyeiF0MKMAu73dL9iUaWjinwjQmGRtFkf45jwruVfgcf0nM
	NOUnw==
X-ME-Sender: <xms:8gJ-aiX_rQG4d4dC16bf_VktL3pajFySXD3hiP0JL0Bzm1I84MqAPg>
    <xme:8gJ-ao_1od0lHpg-Wb1_4xHs3Y1ZxfKIV4eSRjKqvBizXQoqwMfj9rR3pHwd64XM2
    wZcEQVujcNLwnVSNVMM7Ymry7ZuUip9k6AqqDQ6ZSs3Su_oBxpKIXg>
X-ME-Received: <xmr:8gJ-asinLu9aWzdBwv-0sLd3TH6rNrJOj9niMPGziaWHQ53V_vKK2CKf-vA>
X-ME-Proxy-Cause: dmFkZTFXctAct/qj/pWj57H0QMq77XwiOX5uPEMTQ0XsGVQzoCUvbPCvOJgbQOjbgOcx2s
    RFyY4tQx0ICSsm68Vhku925KF4Bv2oZ0+3DfN9mH+3QT2CdHmbJx8H9jq3YtHGjMjz1Eqe
    dG+JdFyU0T2HUcca0LFHWdQ/3FPmNcsrxmgZSNKZVWh5g4ZzD5nlzl38TxB5ch6cKl+Q3X
    /KgFOvTrvOCxH9XMck87HvTgKkRiQeiKFAvEGEfssBJEpQcgcSRX6XzTPVurgcMrXMa4Sw
    LvIqVjVyHtNQ3pCVeNQSwQjSCejtUAvRf8CP2VPFT8dUf88xemOoLvt8JCOKfx6nTzrnsn
    W4zyxWwI9gnbjQuAo3XIUvVyeJNCmeZcytBXVQhtujAL3JVDU4XvLfnH1o9al3q3REKn0D
    mdZqSLklGmKpDPxu5VApJioCjA2ss2cW2QEyc6MOGElFtQ0vWjwUr7k+3dBkBz+FmXqU++
    2qDtWTL8UTJdzviIZD6ltMxByTXP9dKb7sXExqkH2obXInIplaIz3xPdlHFWDUi6ULxCsN
    cBEaicdUnXDbqF8/pzi3cZhb0No7l1eaRelpvVdrzWiu+m7AxIF9LhIuRlqKZ47B2kTHOn
    IBPV3VE9g8Yc6im5kWCyDmvanCrEpjejl02l7rSTEwToeFBLvjoXZ8KeKGrA
X-ME-Proxy: <xmx:8gJ-akdEYvmYZNoC0cQgIw8fgGMUWe45yD2TzwVIjuVl-itzsN4ilg>
    <xmx:8gJ-alLhzY_YDFHLQfzlCztSpnYuLzPaxbRa5NBNacpAg1SKAwelZA>
    <xmx:8gJ-ahkPWzpKoM63SRO6swQISBX8pk7CM-LKi3i_vVEyZwB_xHorqw>
    <xmx:8gJ-atdTRaKHsB4XvB5ArSskj7m6igyQFWPqka9x4_iHGJMYO7-_Sw>
    <xmx:8wJ-au9T8qvpTDdyX6jI6PiR-mlguGGE3ZUT7V-NPVQGg4-PBVLwm2K9>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:46:25 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v2 1/2] net: Guard for gso_segs overflow in skb_segment
Date: Thu, 13 Aug 2026 20:46:12 +0300
Message-ID: <20260813174613.2920246-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813174613.2920246-1-alice.kernel@fastmail.im>
References: <20260813174613.2920246-1-alice.kernel@fastmail.im>
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
TCP_MIN_GSO_SIZE, an AF_PACKET PACKET_VNET_HDR socket can generate such
a malformed packet.

Blocking malformed virtio_net packets is implemented in the next patch,
but this patch clamps partial_segs in skb_segment itself for more
generic robustness. Should len / gso_size happen to be bigger than
65535 in partial GSO, skb_segment will now just produce more than two
output SKBs, all of which will be valid with gso_segs <= 65535.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c82a1472a5ea..439cbfeb02bd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4860,7 +4860,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len / mss, GSO_MAX_SEGS);
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
-- 
2.55.0

