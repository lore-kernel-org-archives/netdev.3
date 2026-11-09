Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242476;
	b=VY9s8Nsd6SpzORAz2EzW0g8K8RRBB11dNUO9zi7k5y+sbZFD1UeTZ+pQtjXCdUdlCtCT
	 N/P885LHkTXO4QemsZcJEu7Q/Z52A4sPsWKAxmFy2NOKDJdHWyc7Fq14NCq6pfzd9XIv3
	 /3972tOmdTMWnJJQU2CB1GzGtNp0Sd7nc5WNHk9bWKDxlHdP8keA1Ulzr9fXTG3G5Ol4D
	 D/Xjh7VU4b0Lg4/GElwTKAQT2JDtQlUcImmDF/WqloOytEKRFMwfgLeIoei56uD1Y3J6z
	 qG9SPvjp/flqJVV5aMiqsPWDSNkRsJf0F28z5M8puMz+e2zHvPycwSzsxEJFplo3dlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242476;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZR65Us3EwKoGha65hsMt3PgrTRCJTzM1r6GUbWjJFSc=;
	b=zkZC2J7hGWooejul1CwaSNfn7gV1wRLxN9XyFfXHdxrRrTaYxJGwqRnZ6CxugNJI2cg/
	 YOimNLJiUGsZMPoq3k3Qk78w9XD8hbydDf6awCXC+7tCRnHEyPinkZfwEdyT8DC4blu8j
	 HpAb3P1Zj+dw969bPnnOp8ar7f50kGG1/M/f/pEMoB5cSEVv09b23EyGaKyD2CRRSlObw
	 SY4nTztBSgF4RnO9TKTcbSGCq4bs1i+06m8tB8fFxVTU4WJXx8+dSI5tOsTXjJIBA1HKx
	 IdpkbKccoZG+am5pxjf1jbcnLR6annKMDgqvcxE00oTwVzl5Q5Q+31/oEEf+P0O3B2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="Y2o/LJ/M";
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440C606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A440C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Y2o/LJ/M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794242465;
	bh=ZR65Us3EwKoGha65hsMt3PgrTRCJTzM1r6GUbWjJFSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2o/LJ/MnEQ3cHEP5ro3hxPM42y+0gjjgWyuFvZxTxYYtOkEa60d1R2lY4YYYWmKC
	 YYMcvyckmAYh6HFZTfbQNYv3FzShWh2pbNJF9ZGEhvvwrCafgEnVf8lSbpmh/Ri/SB
	 UGZlI4w7+/X5bPLHbCirFkBNc9ymyImyvzUUHH3g=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A413CE3C; Tue, 10 Nov 2026 00:41:01 +0800
X-QQ-mid: xmsmtpt1794242463t42i41li8
Message-ID: <tencent_95DA7493D2DB7AFE16C0B22A431E45295006@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gp7BtJXUBkPxfg7t2YTH24XfxLZmOl9XPNyuDPvusFlEYLz1hK3
	 u81kM7r98t8IAt9a8A8RNDgTFOC7WYMFeYx0z6hKd2bs48F+hUnCackfWuH/EWP3gDhpIabogd+W
	 X1xLARuEyjx/Uu1LGMykaMHCNysNov9yjfQyZeFsYDDKZMNgdCyTqnEQEK8YDkLS6XJlX2Ya29aC
	 FTE5+CqvftapXqwi1kfil8PJS2s163wlgOHWGFgMRjFLIvQkiLQ/8anjXeewCVX3FR6+t5OzeOKy
	 oqmzG8gnOkl9TeByRnJdUBR6FIKwOHqlEkWFswe+Hrn3EgsaGBukapv/+6UiFUtjdvQhhr6FfgUa
	 xnAMxC4C0IKhBpM9my+0XDnTfX2eD/6GrD7L+DmMZqoJqqt3Kx3UtIqnGkudHvuPPxUW11hPEue7
	 9+YLmUFYrmTmAiD2CbD39DhgJg1zx5dQvBCPfV/rSf065mrMK1XouhSX5HTqkoKJ76Kr8ckqT1wr
	 Z7Te3c7hMBqLLH2OccvXDdog0njGH/8u3p8tvBa6EFGTXP/ANMFTrv4xIa4rDANZoZgEiNHGLo4F
	 N0fBIE4jF88e7a2wfXnxZfkAU0a8Hk/y+olGBuwBRcb9Aot5vpxCCmcb1kZBnw2rGuyg7O/rl+ZO
	 glsKCyFqrIG9/uhExFHCZ743/6nA50dLtwytT7JwAXFNQn07/62e+lO8ZbBANtxi2sy3wz7CLW8n
	 5lriTrvZkQzyfnbBYiXHqylJNEBsNmLw6vLeLeWMBAiaFoNR3OX2h7gkUSHfKxypYCQ0oPh7GcVV
	 3Sn3F6G83SQBy5B05AZPFYS+BKJaK84X8BQfVabiC285cYbZJAz/j57F0ZRq75mH0yUFakfll2ra
	 QLV8PSmOAgIY7Ahcw+Z77Pvs+bfWRA08QxLIMVhPl5yylqsuryWDQWRkyjZIlua50vLwBIjyTAjl
	 vSHK6kMjKscTW91YkLXsfr8pMCynCtA2phuuCyXVL0R7MBzO2Xil5vIDfZXbfgrl4jKnV30AMqni
	 iEc8ZeDnTPjA7BBoUevTr7CtTgaFw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v3 2/2] net: lan969x: fix RX ring stall on frames from inactive ports
Date: Tue, 10 Nov 2026 00:41:00 +0800
X-OQ-MSGID: <20261109164100.8947-3-memoriaru@foxmail.com>
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

When a received frame's source port does not map to an active netdev,
lan969x_fdma_rx_get_frame() recycles the page via the page pool and
returns NULL, which makes lan969x_fdma_napi_poll() break out of the RX
loop without advancing the FDMA software cursor.

As on sparx5, the DCB still carries its hardware DONE bit, so every
following NAPI poll picks the same DCB, hits the same inactive-port
branch and breaks again: RX traffic stalls on all ports until the
module is reloaded.

A NULL return currently covers two different situations: a failed
build_skb() (allocation failure - breaking out and retrying the same
DCB later is correct) and a bogus frame (which must be dropped and
skipped). Split the two: recycle the page, log a ratelimited error and
return ERR_PTR(-EINVAL) for a bogus frame, and advance past such a DB
in the poll loop. The WARN_ON() is also dropped as the backtrace slows
RX to a crawl on every bad frame.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.

Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c     | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125..5f5adb7 100644
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
+		return ERR_PTR(-EINVAL);
+	}
 
 	skb = build_skb(page_address(page), fdma->db_size);
 	if (unlikely(!skb))
@@ -258,6 +262,15 @@ int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
 			break;
 
 		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
+		if (IS_ERR(skb)) {
+			fdma_db_advance(fdma);
+			counter++;
+			if (fdma_dcb_is_reusable(fdma))
+				continue;
+			fdma_db_reset(fdma);
+			fdma_dcb_advance(fdma);
+			continue;
+		}
 		if (!skb)
 			break;
 
-- 
2.39.5 (Apple Git-154)

