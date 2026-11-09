Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242477;
	b=N+NzR//EmEQ6XKff4NiKqTxxyNvJ7Fm4WbTT9pkn7VFSCKYvohPrQcwPfyU8YE4xPUPe
	 5r8JPz74Rttxw385MPpLazrNHh4zhnOExYF4hZEzEvnkwkiCTr8OCjNAFshHlqlDrqvKb
	 kgQLY+RlEF7+P1yTi4YFIktciSiCC4myG3lffl3Jf0qENWMmLGTDr8pFzyYGnkq2WPJ7k
	 cYVM04r0H9xpCIAc4fhycD8NtOzC2ncfvKIcpB+KfAzvyf974vRxDXKJDwA9MNwARHbuQ
	 9ooGie8JsOcJ6nhYrMiSWrGVuoT+TuxD04/tM8rahWXsWp1cO2hn7kq3GQXjMQ/W/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242477;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1/xGQFJzRlf+R2dUsEBhYB/5ASb9U6Kk4vCgR9M14zg=;
	b=ar+7wOaOeK2qNs692uRFIdTxj5bGOnorIruQoR2C/Mc6gDF18a8BpcFz3CH998XmfkyZ
	 Rg5Ao5xae8cxxO/0l9aWAy2hJ3AgQHb/2U8zdqz+F3nGphu8TXcpDCQGWaJV/Qk6Bd19+
	 w7uEgez4fQqYrbqsdQMvKWM0JlBMedEqTJrtUHiw3Yx+CXHcOsNJvDMMwVbaz2FPFAETD
	 BU9Eg5J7ZjRnJkZ3CozXrL0qQnfZHTo0PRT/KVGEJNYl8lhcH0YawAB2Mv2GPWPB+vUGD
	 kdxMEdiQR04XxWGLmfswEEuzDMgJtrcVphPqbksAH4gNFWRV97FZFJH7vw4Q8mrRi2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=QdcZMTon;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D676606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D676606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=QdcZMTon
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794242464;
	bh=1/xGQFJzRlf+R2dUsEBhYB/5ASb9U6Kk4vCgR9M14zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QdcZMTon7FEjAHIKtoMWNukl0TdjU5o11LhG2x1C6DWhJ4K25aNVGc4ARdBCdfhtl
	 biwaD0OYobZlqn/IEo2BFbmz/ErEjrEpKHk3gTFlwrPwZtXoYUcXfoK+hIkw6JEtkI
	 cYE4HW1l68LewDrftIvV1VBkFsk02KkvMUOML560=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A413CE3C; Tue, 10 Nov 2026 00:41:01 +0800
X-QQ-mid: xmsmtpt1794242462t8z6c8aen
Message-ID: <tencent_CD16EBF205C325851350EF748C92E37AD206@qq.com>
X-QQ-XMAILINFO: Nkqq4bFvvULWN/IsjO86NTpeO9ltnvjto85oTbF6z2uuLivzsn3Q2qlJNlVUJi
	 NvGZ/mo5XlVAyPl8KIp2AVB40fHzQzEI12iFw1AkYfTYp7ycZGGmoNbGupCqvWQ2d3YjDW1g9Cc3
	 J/BPRuuZRfrfZ5Lu3QSvD8Y09HLd6Z6FGkkVpOUocvv9CDjtVkjTRrFnQT981ryB3jXFFjbBhwhF
	 31kOmPgPc3qPrc00q2t5ZMZ2bq0Wkjr5+LYn2hbpHJ8bH3yaDAvMGq5M/HCLfUcNkbLzD0qZa1VA
	 9IUzmt66AbnWtYz88bcn9beOtjZwOPb1etXAEC8mMUsIgYcxle6LHGUR7UBKlir2zC0ecZf7CdB/
	 Mp7qhZiygrtH2SW3kGCPlsLl9i81WXpleTYI0Mjz2flK9q+bIaBuLieVFnAlYztQbb+A6HHpM6AW
	 jequhTBV4URqYFgeX7hvkHJTBYWECQ7CCeY65ePE4O3dhhdiSkog2UXlP7TCe6qN8MAGq1DmUxnN
	 IbxxgU2j786Nh/SuuGcZUL8RngmNfW5ZJuS6I8Ygm7gxLzdBugFkX7+JSxaIe1+dQOKksRBQt+Ih
	 EjPUZlvvHRKscwNB/uy9UZN0Hdhkd4kijm3WIiyichlQLmjb/mIKr7fqdShTEtAOzg2ReSpdao8h
	 X1uiWyPxxr8UhI0+cmN60Wf3iLEYL1jiF6eob2Ikujvpwu9ysXWnhg9CISz7/koLRwJbqqd6Xu3z
	 YprJol/ZRcx/BBkA9dA0ngRfh8Exw+VMtZiQZNrsgCBBCRNX5vAwLsudmpvXIsmqcv+u05Yh6FMg
	 md49bTeyM3PmGHZWXe8Pmfpqw6/TZELSjHQZCG85dEWrlNvbxfA1GLayZl2rYh2oQbhBtuB3yWiH
	 9+oCWy7RfbbaaHxlKH3FCvmgXKGbhootETGZeQRG5zZ6OaEKiLoO69nlTgiKoK3/8KfBfH8F6gPN
	 kUalRAOEjVv2CyNm7NWQXiMKutc/ongMGpzY/KEnMid6NS3xF69NUenJxL3uBdXXdT0g6xQzm+qC
	 de+7N4unraug1Hide9BSmT1orP9qhAqwJS3BkPwih3n2fAMgWfvFO1XRelctnitolQ9oxbwQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v3 1/2] net: sparx5: fix RX ring stall on frames from inactive ports
Date: Tue, 10 Nov 2026 00:40:59 +0800
X-OQ-MSGID: <20261109164100.8947-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261109164100.8947-1-memoriaru@foxmail.com>
References: <20261109164100.8947-1-memoriaru@foxmail.com>
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

When the FDMA RX path receives a frame whose source port does not map
to an active netdev, sparx5_fdma_rx_get_frame() logs an error, flushes
the extraction FIFO and returns false - without advancing the FDMA
software cursor and without releasing the skb, which has already been
extended with skb_put().

The DCB for this frame still carries its hardware DONE bit, so the next
NAPI poll picks up the same DCB, takes the same inactive-port branch and
returns false again. The software cursor never moves past this DCB, so
RX traffic on all ports stalls until the module is reloaded.

Treat a bogus frame as consumed: free the skb, clear its slot in the
rx->skb[][] array and return true, so the NAPI loop advances past the
DB the same way it does for any other received frame. The slot is
refilled by sparx5_fdma_rx_dataptr_cb() when the DCB is recycled. The
extraction FIFO flush is dropped since the frame is already consumed
into the DB, and the error is ratelimited.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.

Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 15ec9b0..e35ef0e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -157,9 +157,11 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 		       sparx5->ports[fi.src_port] :
 		       NULL;
 	if (!port || !port->ndev) {
-		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
-		sparx5_xtr_flush(sparx5, XTR_QUEUE);
-		return false;
+		dev_err_ratelimited(sparx5->dev, "Data on inactive port %d\n",
+				    fi.src_port);
+		dev_kfree_skb_any(skb);
+		rx->skb[fdma->dcb_index][fdma->db_index] = NULL;
+		return true;
 	}
 	skb->dev = port->ndev;
 	skb_pull(skb, IFH_LEN * sizeof(u32));
-- 
2.39.5 (Apple Git-154)

