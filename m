Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163555;
	b=kng2I8m65QvsbH1j4wOYWhjmIyaCEpiLV1cOVMi2sx3phGcuSvRF/NXQhSAfCMNEJqBQ
	 JJjZ+7V0rkfkI6QDkWQdMtNvyun/eFe1taS4yV94WLVRmgtRFe1YRtyei+9MhIF+yrBaA
	 Y4SQaKxKoxoPbobBWHU/q0SsBY3qiQsCtkmIaKZ1QmE5q2DzU/dzxSnJdMnBlVODvsnQ2
	 MnIeSYN3ihCC+eYbAUmnwoG+kmMsPG9U/O/+5SqUsHPuulN3CRf8wt3Uzq6db+h303/HI
	 zqM8QTooptxDMpLpTrljv5GpSfPFz5Sj/aMyJQIPz5IPfE6Cvt0SzrxDOU50DsJgFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163555;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=59PcqYceFmLmXAG+Y80JUvL8xmpcARc+z5WhilxBos0=;
	b=OtUr2OT5MQ6hUvlHVrshkg0LR2e012uTT5bq81n3we2sd/zzD5KjEkuIsizvFt3lrfmv
	 NiYgqZFdz4fytO5kJlulIPLFt4flcgWXUMyrkt1oPF5o6wanBhC9PsaWZzUbR7vWrJc89
	 /InO3VODbl8e8UMjc5XgtrQY9jRZWQzv+aNVCfi6jm7TkPspzj59gRfC1VyI4Aw8BTvVZ
	 ul/MoOOYKUUdQlgW9eCHs/SY194cnJq+C1dLWr5KBeVoFekdob/gDz21/PVLqvzCgS4By
	 OdqkqrjslQkP9+o5vlvRcySBWV16cpMWUPoj9s+tBJ3recsO8Im3ti24a8urOnwL0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=q8z3L7fD;
	arc=none smtp.remote-ip=203.205.221.235
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD658606A32A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD658606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=q8z3L7fD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794163545;
	bh=59PcqYceFmLmXAG+Y80JUvL8xmpcARc+z5WhilxBos0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q8z3L7fD4ElUoPUIgXZMlf7VnnuER16X05pJb5huyuZ7e2mx4FlWvCHk03DRerJAg
	 Ak3yyZOz/mqdNjZy29yBTpNz9JIf6F/iLJjcdMlBnnnJHQAHotsEzRXQ8uhCeFODI9
	 tYVX/A9nVPk+Z/+qwYabf3HasISRsQ9+9L2ow4Vk=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B6A9EADA; Mon, 09 Nov 2026 02:45:42 +0800
X-QQ-mid: xmsmtpt1794163544t5c1izdfj
Message-ID: <tencent_D3F64049D3E34AACEB2B5B11CB8D0C821408@qq.com>
X-QQ-XMAILINFO: OZMlMiGBv3y9rH/W5p8SI9zuVIBXrZEUbv/H5lSknsWOLJlwfyjW7wjQ99madB
	 uBcho6L+YRmD2Ps2IiXsqyQqJUQHEbaVrSjRUr5ZGz2B9/iS8iqAbLrzrtfKGZMxtf8bakZBFzcZ
	 Yb0BfY/ElmOX/2fMRvc/sbSQ1MPaErO3S4GHsr1J+FzEU/G3QwbTpDfrAqKrw4WFMBqBkxbXmgor
	 ztrPD+ezXorKjbuprmOm52UUmWUmia43MueOFJtc8mqMNJmQZpqWsRm9d0h7SH2NTf5bmdOf0Byk
	 2p+wJmnSARZmsSS9n7KP9JFn06IT9dV6/lovmdtVdQkjV8owHj/9kt3Wvxnrc6k61O0ocRFK27RF
	 hZfiq0A7iEPhARIAtudr9o2DLxCe/pOO6lJ2mcfFmEpGGRNW7MrYfoGtd7lxHHhBIlC1YWDhNJIN
	 8TVjbqVsOK+GbE7kyASdBZ8C5/COFcBHhQh/TtQ9WaV0hDb0uLQuX5iu9BGWVN/G8XJBjUp2NuTd
	 OWZAXWr8f7rVSFAaJx1aaeLzjZFG5cZeIuBpkIld5s2PZCPsFzJ15J52UG+svbVWcDXYSBwqYpQN
	 YiQ/uObaGDzAsVttPr3vc/7sHTs7LGhb4druDOS+CUvtWTUr6dHbx64Lvfrc1a0rzYeMDToFyKtu
	 BPMzMz21Wfd5wsLjTL2kSeWMK+Y3laHATjZ766J3JGXd5jA3KM/9oMfgJ1ULq0O8SAHfGeVxIdux
	 W32MH3zysvlPeFV4Rmj3ZtHElrKvCvmKAcAQhwd6UX5u/OKdV1Yfe1pyjkfWAT5KyjzTyzvq8e+i
	 PgSX6JGt0qJ7XGlSA9Q3TJQlU0J9JvzMoFQAu24G+nzDrVsgrH83hfLq+sgiXvoYkvIBptRTSrkf
	 zSSrOCIsDSs3ke8YKOo9nz2fFUYYGMq6rqN1rvIfTERswuC1aEfBDtIu2qxTWClYYvdDB+IEWxfj
	 9Zz93ijmX2pbjI5l0mR2Mfg/4pRIU1NFykHaP4l9OUom0uB8KbEHPgkrMJ3RGzlcruFzFA8pdrNx
	 EuiBkeKkyUm34+4vrf1Tw188tUT81doGtWaHQd3bUks00fTkp2
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	79190669+memoriaru@users.noreply.github.com
Subject: [PATCH net 1/2] net: sparx5: fix RX ring stall on frames from inactive ports
Date: Mon,  9 Nov 2026 02:45:40 +0800
X-OQ-MSGID: <20261108184541.74618-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261108184541.74618-1-memoriaru@foxmail.com>
References: <20261108184541.74618-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <79190669+memoriaru@users.noreply.github.com>

When the FDMA RX path receives a frame whose source port does not map
to an active netdev, sparx5_fdma_rx_get_frame() logs an error, flushes
the extraction FIFO and returns false - without advancing the FDMA
software cursor and without releasing the skb, which has already been
extended with skb_put().

The DCB for this frame still carries its hardware DONE bit, so the next
NAPI poll picks up the same DCB, takes the same inactive-port branch and
returns false again. The software cursor never moves past this DCB, so
RX traffic on all ports stalls until the module is reloaded. The
sparx5_xtr_flush() call only drains the QS_XTR hardware FIFO and does
not touch the DCB ring or the software cursor, so it does not clear the
stall.

Treat a bogus frame as consumed: free the skb, clear its slot in the
rx->skb[][] array and return true, so the NAPI loop advances past the
DB the same way it does for any other received frame. The slot is
refilled by sparx5_fdma_rx_dataptr_cb() when the DCB is recycled.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.

Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
Signed-off-by: Zhang Hewei <79190669+memoriaru@users.noreply.github.com>
---
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c

+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c

@@ -159,7 +159,14 @@

 	if (!port || !port->ndev) {

 		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);

 		sparx5_xtr_flush(sparx5, XTR_QUEUE);

-		return false;

+		/*

+		 * The frame is bogus: free it and let the caller advance

+		 * past this DB. Returning false here would stall the RX

+		 * ring, as this DCB is never consumed by the software.

+		 */

+		dev_kfree_skb_any(skb);

+		rx->skb[fdma->dcb_index][fdma->db_index] = NULL;

+		return true;

 	}

 	skb->dev = port->ndev;

 	skb_pull(skb, IFH_LEN * sizeof(u32));


-- 
2.39.5 (Apple Git-154)

