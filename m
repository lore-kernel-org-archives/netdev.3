Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211390;
	b=053rI3pJSUAFzQMmPxXKNaWLzWXF6A2YFr96IaicqDqdvVRAjZbk9xKG8COidHSoLe4Z
	 +vNYUdQjaWDj3vs/XGTQdLnO+SoUcKEFeOo7bd5sGzFU288aG4nezoAdMWsyX5vNWezFA
	 ZUF6Qi/RgCsf2f4G3wBfa6x99mykQIU6+XoSzufIQNVTZUlbSE/QetviH/jq3SDz+dtq4
	 FgYvEYoyq73p4RiyXWTBMwmgoMtHS+uPGcDBOBV8wh6UMhCVR197yYIAteWM6pvPwEGJo
	 gd21wnTr41r1I1S6Lw3DSLISkO/VcU6yOuRVMt2GMQznCpkEJq6pgPOxSgi06hC0eHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211390;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5LJgLw/thfvUww3ktQLNjWdHCmvCJJ0i42mOOj/PlNU=;
	b=dHvsS9744L6IiyR8c9MNb2wIyG9D8WHAhGVJKcLOjj/JrWRCcQP1i45Z1Bh3YfJDGtfp
	 Nrl/Oi6XMDrn4TCVbtYGDszUGPj3hY7mX+ncw6YLKxBqHRhC+3zOpEliQ9T3/U4hv2SH7
	 tOknhlyNILhEeqqzZ7l8tG7JrUG6QvnZNzf05MuYJe5al/t0eKG0t0QgI9qCWDdPYZ/sk
	 WvTQ5j08wDz4BjkuJORNufycKlr3zjAB+TaV/B1eJk1VnzoqWcJn556uQvgHuaKEoxz4k
	 /CrLIopGNNlrbcd8Y6z/5Ab1pUi1F4W0qrMbCN51g4KJcIk4T+yNpyZhFQJS6tsvZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=gfpe297V;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B315606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B315606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=gfpe297V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794211379;
	bh=5LJgLw/thfvUww3ktQLNjWdHCmvCJJ0i42mOOj/PlNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfpe297VhRB9TQFvp7iQq2D3BwsOPFZUuOryxhL7hmnZZcvFEsmu5+lD1oIJL3CM6
	 yFOFUYt9kOa/UY6WP++eU81GANI/NaEuK42QyzSkBlWrdO64YlP990I/w+hOwTv/Pj
	 XMsdYKrkfPdW+TtPEQbwlcgXo/dLOFUPGSyeihAs=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B79240B; Mon, 09 Nov 2026 16:02:55 +0800
X-QQ-mid: xmsmtpt1794211377tjc7miiro
Message-ID: <tencent_0F653806680A4CA083E923A5AFF5982DC307@qq.com>
X-QQ-XMAILINFO: NuGpsYW8pZ+Ar14pzAjXQED5eeSCxvZ/71jnOi0QSkmMxnUBEpnP+lEuP6poYO
	 CRNxq42UlwdG3RWUINtoRkQTRAA0F6l524wPhKfZSIlN4NpmrObgwRihkzAXVT6DwV42oXRv84ni
	 oNH6kCa3d9mC8vytAM48Axknj2Qq88qPiwFV3B0yEwOUUwdUewrxjuX1j+aVaZKK8g+ElTDTQIMW
	 E1412K9giduT/qMlEQn4vjXI8M/xPH2omCeRicKaJT2NTqyWASNyuyK+LRRolsTdoiVpfys/J7K9
	 FkTqsdOEEuFloQZsUyAxLT6qfqu3dG4djWBts/MFceSgeESSXhFbO7G5w1X4aCZNwgfHC721x3B3
	 8OdRWi1qYcNrGP6CzOW+S4KgHH8i7GnRfry4ZkfAjru/Eko0oeHnPNTb0o5LEukqAM2NWKzFXhze
	 xiKOM7Q9zVkA/HV5mwxecq5HTQR8Url+CuJgdQ92dOdhpEt1rTOfG1G0p4mFjh91QSvPX2hwd6Ll
	 n6rOMLne8GHRKmqrn4i5k9l202+1xKwDwQ02nZphnJWlxE3cMSDDcp8TyBAun24mrK9YJodUDbZE
	 w1yio8XWmk03pd9Oz1CfXrEl/lBCoW4O83wc3md+THjp6ULwbGG4cJko+SBwNACYL0MOiTV8euGL
	 lJw9PMq25DVK5DxT3Du6KpEhFR30Hjh/SLTHmDHuYjS3NiXLgSnQ+su0s2pXW74k4BlqLOKDt1Ra
	 5AKvPqFPc5g5trtwnH4e0GXYPfjCmDQ63MVkfJ04aEayH2JJfgBFgm/HsMSM9hB2FBrf5b4R6n7C
	 uf2uR9mo8eMvmOnu/54GCBGqGXigyngUeH2lzi/UgXMesiJlfSQg/u5l3YlCUmzcUEBMk6BAi0vW
	 QMtWkI0q1AKsB9s5owlSj81ueG9aHnXZIWR0CQtAPdz0qmEGtYPRx/opeQu/9YJvxISz0XpemI0r
	 +3viIBCMbzJi7/GpfL7hJJJdiPfRro+eAiRgDP4eV2A6Gqc5IhX1CMjLM+IfXPxAFkaR782NcypO
	 k4IQKcv4SQpxLXHCJYTI3kjyovKiIbhAiQeWJRdg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v2 1/2] net: sparx5: fix RX ring stall on frames from inactive ports
Date: Mon,  9 Nov 2026 16:02:53 +0800
X-OQ-MSGID: <20261109080254.92305-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261109080254.92305-1-memoriaru@foxmail.com>
References: <20261109080254.92305-1-memoriaru@foxmail.com>
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
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 15ec9b0..bd021df 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -159,7 +159,14 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
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

