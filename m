Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670987;
	b=2HguVQ1t9TYB5mfKZPW/opWafGmkFFnghxgGGwW8M2/E94wt8+1u+n+/kKyh0JWH0577
	 CMtwRdHXlv69j1JDFPIGRYKxy4seslQbr+5ynrBLVT5jzTM9ySdao6jpAJVMDx3kODGmR
	 DWBaHrTyRMLF5dWrw9MIbHoWnVIk8V7xCwLE4zsXvq6qYQaT+jXrs3EPiQUqKjfhx2dC4
	 G23/Y8FM+QDf+mi7WC5a2hOD2sHxV0LLa/qS13dtdCP1YNf0SLOo/BiTDgLiwFJbXz62W
	 mFUlyoSYS2ttUTeZXnF2dymgo9r27Dy8TvF+cnJ4vZHgR+t+GTzMs2ggoZR8DnDPgpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670987;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NoO0HWo4LZs0Q3ckLlPLpSXyfQt0qkyp2YaQ5O6k914=;
	b=ryaBu3AbFjCjv+wyy1rls5IxW54NAE/ayOvo8LbLR5b5IyWF2nLfV/ZHf3M5CPLn44n3
	 G9fT/GqqCtWXmsG/kQhRLfXtqYLKkX+XxXIqsSI1MnCkliutzAGSEGzdqed3ZearNqULK
	 J9xTOxfNjKCP+QoAPveEwH/ZxAwb/F6i/yD+tz4C4R3oocxv90i7WRD0+puQ44bTvwv15
	 92rHoPMJSdUIQWQ6hljNJiWKQwZx9SjnYjmyeiss7Uq17E/lYaiI7s2wlwJsTgA4oC0DD
	 fuu91bwZyf3zbiis7bKE7gPNGom7uGCxaO4q7v/lNu1l4o6xhb9L2YiFGB9Pd75CDlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lPcVu4cg;
	arc=none smtp.remote-ip=95.215.58.120
Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A881606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A881606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lPcVu4cg
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NfMIebs9ZnUbX9PAhQnW4sE2QFVRE21axt/i+fy0ESQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793670984; v=1; x=1794275784;
 b=lPcVu4cgFN0jt/HM/3zkGU3eiW+5NRo9WpCBGcRKmlcuYQaCYqpZATF2JPR2TJc7gU7Bbkzo
 vf+lKFZQW+xi0eEEJg599BzxvI2QwEm3lyVTbtT32p7n9TNVT4dlB0Kb/k+xndQ9ka1vqQGBrtJ
 +2pMwl90nGIf0MJLwBZMf1GM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7179cfca96a2ef67;
	Tue, 03 Nov 2026 01:56:24 +0000
X-Mizu-Trace-ID: 7179cfca96a2ef67
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tristan Madani <tristan@talencesecurity.com>,
	Norbert Szetei <norbert@doyensec.com>,
	Andrew Morton <akpm@osdl.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ppp: remove SC_MUST_COMP
Date: Tue,  3 Nov 2026 09:56:11 +0800
Message-ID: <20261103015615.2704-1-qingfang.deng@linux.dev>
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

SC_MUST_COMP accidentally shares the same value with SC_DC_ERROR.
PPPIOCGFLAGS combines configuration flags with transmit and receive
state, so userspace cannot distinguish them, and a read-modify-write
sequence can promote a decompression error into SC_MUST_COMP.

With SC_MUST_COMP set, intentional or not, a fatal decompression error
(SC_DC_FERROR) causes the receive path to silently drop the failed
packet before delivering it to userspace. pppd therefore cannot detect
the error and reset the compressor's state. Subsequent incoming IP and
CCP packets hit the same check and are also dropped, preventing normal
recovery.

The flag entered Linux in 2005 with commit b3f9b92a6ec1 ("[PPP]: add PPP
MPPE encryption module"). The original patch submission [1] said pppd
would set it when CCP came up with MPPE enabled. That intended
integration [2] appears never to have landed upstream.

Remove the broken and unused SC_MUST_COMP from SC_MASK and SC_FLAG_BITS,
and remove its transmit and receive drop checks. Keep the uAPI macro and
mark it as obsolete. PPPIOCSFLAGS will discard this bit while
PPPIOCGFLAGS can still report it as SC_DC_ERROR.

[1] https://lore.kernel.org/netdev/20050814141046.GB20944@lists.us.dell.com/
[2] https://lore.kernel.org/netdev/20050814190529.GA26802@lists.us.dell.com/
Fixes: b3f9b92a6ec1 ("[PPP]: add PPP MPPE encryption module")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: keep the SC_MUST_COMP macro, as requested by Paolo.

v1: https://lore.kernel.org/netdev/20261029074935.40509-1-qingfang.deng@linux.dev/
---
Found and reproduced with LLM. Combined with the broken BSD-Compress on
64-bit, it results in a broken link:

1. First BSD failure: the kernel sets both SC_DC_FERROR and SC_DC_ERROR,
   then passes the failed packet to userspace. pppd closes CCP. Traffic
   falls back to uncompressed, but SC_MUST_COMP becomes accidentally
   latched.

2. Re-enable compression: send SIGUSR2 to pppd, to let BSD compression
   renegotiate. This is a documented pppd operation (man 8 pppd). The
   stale flag survives.

3. Second BSD failure: the kernel sets both error flags again. Now the
   receive check fires:

	if (ppp->flags & SC_MUST_COMP && ppp->rstate & SC_DC_FERROR)
	    goto err;

   The kernel drops the failed packet before delivering it to pppd.
   Consequently, pppd does not perform its normal CCP shutdown and
   cleanup.

4. Subsequent incoming IP and CCP packets hit the same drop check,
   preventing normal recovery.
---
 drivers/net/ppp/ppp_generic.c  | 15 ++-------------
 include/uapi/linux/ppp-ioctl.h |  4 ++--
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 29847dc4bb45..f7b59060450f 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -158,14 +158,13 @@ struct ppp {
 
 /*
  * Bits in flags: SC_NO_TCP_CCID, SC_CCP_OPEN, SC_CCP_UP, SC_LOOP_TRAFFIC,
- * SC_MULTILINK, SC_MP_SHORTSEQ, SC_MP_XSHORTSEQ, SC_COMP_TCP, SC_REJ_COMP_TCP,
- * SC_MUST_COMP
+ * SC_MULTILINK, SC_MP_SHORTSEQ, SC_MP_XSHORTSEQ, SC_COMP_TCP, SC_REJ_COMP_TCP.
  * Bits in rstate: SC_DECOMP_RUN, SC_DC_ERROR, SC_DC_FERROR.
  * Bits in xstate: SC_COMP_RUN
  */
 #define SC_FLAG_BITS	(SC_NO_TCP_CCID|SC_CCP_OPEN|SC_CCP_UP|SC_LOOP_TRAFFIC \
 			 |SC_MULTILINK|SC_MP_SHORTSEQ|SC_MP_XSHORTSEQ \
-			 |SC_COMP_TCP|SC_REJ_COMP_TCP|SC_MUST_COMP)
+			 |SC_COMP_TCP|SC_REJ_COMP_TCP)
 
 /*
  * Private data structure for each channel.
@@ -1863,13 +1862,6 @@ ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff **pskb)
 	/* try to do packet compression */
 	if ((ppp->xstate & SC_COMP_RUN) && ppp->xc_state &&
 	    proto != PPP_LCP && proto != PPP_CCP) {
-		if (!(ppp->flags & SC_CCP_UP) && (ppp->flags & SC_MUST_COMP)) {
-			if (net_ratelimit())
-				netdev_err(dev,
-					   "ppp: compression required but "
-					   "down - pkt dropped.\n");
-			goto drop;
-		}
 		new_skb = pad_compress_skb(ppp, skb);
 		if (!new_skb)
 			goto drop;
@@ -2507,9 +2499,6 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 	    (ppp->rstate & (SC_DC_FERROR | SC_DC_ERROR)) == 0)
 		skb = ppp_decompress_frame(ppp, skb);
 
-	if (ppp->flags & SC_MUST_COMP && ppp->rstate & SC_DC_FERROR)
-		goto err;
-
 	/* At this point the "Protocol" field MUST be decompressed, either in
 	 * ppp_input(), ppp_decompress_frame() or in ppp_receive_mp_frame().
 	 */
diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
index 1cc5ce0ae062..afa158d95390 100644
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -39,8 +39,8 @@
 #define SC_LOG_RAWIN	0x00080000	/* log all chars received */
 #define SC_LOG_FLUSH	0x00100000	/* log all chars flushed */
 #define	SC_SYNC		0x00200000	/* synchronous serial mode */
-#define	SC_MUST_COMP    0x00400000	/* no uncompressed packets may be sent or received */
-#define	SC_MASK		0x0f600fff	/* bits that user can change */
+#define	SC_MUST_COMP    0x00400000	/* Obsolete; ignored by PPPIOCSFLAGS */
+#define	SC_MASK		0x0f200fff	/* bits that user can change */
 
 /* state bits */
 #define SC_XMIT_BUSY	0x10000000	/* (used by isdn_ppp?) */
-- 
2.43.0

