Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572689;
	b=bWdg/xWmGr4s0deoLb4b7p5rCygERTI60yEAxCuTaF7H156t/LwdNn5zOFPDQXfxWa45
	 AxhcKzeAY9HPU56aD7RfOluxAYETTPnr0/cuTyWuGNyoVQElDQPRtRI1c+bAWXQ5UXyy9
	 YQEpi7VAN/BJnOVFitqFrY8BUGXe35Rq283kLPNNFljq5GGT/LDbF4q/w7sxCCvvGT3Fq
	 KrjIWjmy/qltlq4C5g09TkQ7lGL+A2pOkru44qWbEEkQcNSyroAobrR9F6QKIzdgbgNWY
	 Hv4NxJ5nQFFJTMgkBaSmbneQVufRcptDIMWNins9lqfIIooUAGTgL9pt01Azh8RDMww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572689;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vUQoKJTRB64FqUDu+PSq1SdeEdNWmuZGiya1/1IMQxU=;
	b=kteikhhfvg2eSuUJo51vyrldNGXVr+QJNDQCFjHKvarp71CidaxldzrXknE7kEgr9wZK
	 icSl/7Zx3XlAAmOtGsbjXjR6WikISt4rMn0OYRZZ/eGvOcHtjFSgB7SdrkSVc4hNOSvDX
	 VaQrcYrUrfsIGSQGdVDznd5gIRVAVD9hs+iB5lLo3qR+ON+kZRDauClQxctJQIqjD9lE+
	 hpqvTHbGTzMlUVta+ynPC2ebS6HOFFFskySf6trxTsC0ujKHFz+o5ZQRRorm/sy3OjsLW
	 h5i1+LokKN3efqcjmTrlwOmwUX6Ghyb15IXDkWGx6K9yKQCJ/BAJHK3mTsXRJII3BwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=kcQhkSdW;
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA060A383A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DCA060A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=kcQhkSdW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794572685;
	bh=vUQoKJTRB64FqUDu+PSq1SdeEdNWmuZGiya1/1IMQxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kcQhkSdWR9bzOBC6lgiAjvroe677BOWbzs55cFc0YgeU3VqjAj8ZiWzPp1gwfDkT6
	 XUd95a1L8+jxjmU3gJgo2A6F24gbYzRrqp7MMPatwFHN9E8sP9dRqFrEtYfNruTO/x
	 HulRfKoMGDjFQH6MMtKRrtyl96D7GvLUxfqYK7Ik=
Received: from localhost.localdomain ([240e:3bb:3033:7d41:3d43:876a:14ed:84bb])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 6280BA3F; Fri, 13 Nov 2026 20:24:40 +0800
X-QQ-mid: xmsmtpt1794572684twlywm79q
Message-ID: <tencent_59DA758E2D9AE574063C0A0EA094E96AA507@qq.com>
X-QQ-XMAILINFO: M+5cKLn0wXDtx8ER4eIXHpu3ejEWSni9N08cPPf0elsIfQeAesimD8IgTw7hNk
	 xNxCbYNhLGSKZRF8NjqpUqZtyW+S7AOu7QTOD9p5UKV4tnAvx5d1U18tSIAl7jEAkSEcUWSCFuMy
	 CMxhA8OWUm11vG2L2IP2LLCUtYDuzLJvSPHmYbd8flcmI9ThJyW81XlSt396qqn/q7JtrYjNcZqw
	 Qbjv5W+UrNsD6kW+zCRzJYeQKZl9LVgJtNNP/9A+NX20j//eZy0erputUPoyLZ4rcOydkkswsNdQ
	 fblEdMHA2ZP74U98UQko7cnn/rMUk5krAuu65581J+9TX9nunN5GazXoK6lce173W3eq4jxv9xtA
	 kP7FWGoz9gLFwpwHar3FQqjGAk6wxgt4s/O/nHfy75ZdEBl9+LdGBq6H4ApfkrPIBpdbNJW3U5nj
	 7jU7sYtz2Uh54Qu5AXvdAeAoqU5Y4MNNrcQN2unXcEk1F+3fTMZdy7vslnjOajl78gBw95LXywVD
	 dRfJTVVqQLAN8nU/j7A/GJploxiaUKwzmrPlmC/csJLQZ+JS4Mcjm1971t9VsWya1SP08mmtDBl1
	 dHX2e8BbInAYh2chzIpU2Zok8i1Kbb9RaJrZLM2PbhkASFoWvWER5y9MwxkJWBBJzpRCiF1dmDNh
	 lb4Qh2sXud9jJriTTMLsr7/y+2jV7xs7WyZBaMi59ZiHEnlzfmzD2msMgvaVYBqNvka7qkaSp1Gh
	 KyhDKD01WwNuLHumoxrn8T7tY4H1aTypVdWRLgC4/6JK+4XqRBpd12HLEbyYf9lc9TmBVIbA1d//
	 37jdngk8mVCZVOzMvdyFZiRhOyyaSfuItIgCH55f0Qc1kIz71Uotu61zUeFDPqV++7aP5wp5V5rg
	 6Hw8/dOdTY1LbfjOBkgIkAwDyWCnKtmVFMneZ5qhFhO1D754oIEpSXjvjCQXozJox+4BMsKLWjrT
	 dA2rHuxLg/qL3w+NrZtmzInDABvvZWx9jfmF7LOpSLm6KqrxOgwvTC17Z9HxWffJCaRfeSWe9B+2
	 +ilawPH2J2Tug7iqJDJmUEvgW+U0gARIBCbOX5FdCAweT0wdrC5N7oIs2cRShajXYezPRPCG5RDS
	 bMFxEO
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org,
	daniel.machon@microchip.com
Cc: Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v4 2/2] net: lan969x: fix RX ring stall on frames from inactive ports
Date: Fri, 13 Nov 2026 20:24:39 +0800
X-OQ-MSGID: <20261113122439.26292-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261113122439.26292-1-memoriaru@foxmail.com>
References: <20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577>
 <20261113122439.26292-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <memoriaru@foxmail.com>

When a received frame's source port does not map to an active netdev,
lan969x_fdma_rx_get_frame() recycles the page via the page pool and
returns NULL, which makes lan969x_fdma_napi_poll() break out of the RX
loop without advancing the FDMA software cursor.

As on sparx5, the DCB still carries its hardware DONE bit, so every
following NAPI poll picks the same DCB, hits the same inactive-port
branch and breaks again: RX traffic stalls on all ports until the
module is reloaded.

Unify the NULL semantics: NULL always means "frame dropped, page
recycled", covering both the inactive-port case and a failed
build_skb(). The poll loop then advances past such a DB like it does
for any other frame, dropping only the bogus frame and keeping RX
alive. The WARN_ON() backtrace is also gone, which previously slowed
RX to a crawl on every bad frame.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without
hardware. The drop-and-advance form was tested on lan969x hardware.

Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125..4181a9d 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -113,8 +113,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	sparx5_ifh_parse(sparx5, page_address(page), &fi);
 	port = fi.src_port < consts->n_ports ? sparx5->ports[fi.src_port] :
 					       NULL;
-	if (WARN_ON(!port))
-		goto free_page;
+	if (!port) {
+		dev_err_ratelimited(sparx5->dev, "Data on inactive port %d\n",
+				    fi.src_port);
+		page_pool_recycle_direct(rx->page_pool, page);
+		return NULL;
+	}
 
 	skb = build_skb(page_address(page), fdma->db_size);
 	if (unlikely(!skb))
@@ -258,10 +262,8 @@ int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
 			break;
 
 		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
-		if (!skb)
-			break;
-
-		napi_gro_receive(&rx->napi, skb);
+		if (skb)
+			napi_gro_receive(&rx->napi, skb);
 
 		fdma_db_advance(fdma);
 		counter++;
-- 
2.39.5 (Apple Git-154)

