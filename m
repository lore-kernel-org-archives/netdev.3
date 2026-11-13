Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589173;
	b=MjOf18zhL7dEc8LQ360dWjYJVmKnA6oKh8PpEa3cQ/j+4Ctn5DPUWfTjmv8AFQbHL0SP
	 AinC/9DPYY/RnXuZ0c3mMHxSn5LzMJnS0YBPrWUb4W2IkwwLR0egOrB7TgtObIVejXOQZ
	 PUjdIsaPcWQq1JJpTNx5DVEkNv2wm6EKSchUyL0aLQchC0wwjGILioJTbIEvRRFXarK38
	 ObJ3mtcQJHJXOfButCHKAx1BnmtnsUki80DtepAfzW5+nwQ1DScd4m6PqE6DaXQZbgeuC
	 PESKhxM1yCouY9aPDmNCDJCFc2jrePo7RIgJi9ZcS5UOvRcwglorYwP8TcnjjHtsLXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589173;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rJvjfmEhSuqQTCnpv4nXJfbQRn21yTAaI+JW1VF1tvQ=;
	b=TqLW3OdFnTwid4PywK2M5LbELcrp5y45KX1tE16BGZ1mMiiLU/PBc3dOa9sQ4MyxNN7M
	 CojLTAG2gdJQivPBgTu8zaXJy/t/xFRPJIalrQIs2uRbcDa+y+Wb3YVMPHE70WzLhCoVU
	 rKWUtrHhGD6aDvQSNKnvHXUGOqQ3zeFkASzYxVzHx0pRPoKzupZxw0AVJ8LnI+rcZuneU
	 miHv1EI75coFYqZe8u2qYZNIq2vC5VkqIkgvCkKbw8EKUdi23+hjcz/mpqMkQo7CKV9H2
	 LzlRZT/rF9TPRPkF8JNZTvgIwUDitbtPcnuD1DHnfcM0qjRkXiKbZnajH1k2k0C2Trg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPUygwEW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A260A2612;
	Fri, 13 Nov 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPUygwEW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589172;
	b=jIsp9Zf3z34Yy6ZuoxVxpUuK6r6JUou0NRhDtDI9wsW2ynWDE0kICYvN0k8ZsKDoUIhT
	 aahzS4m1TUGLZKDKR4RnzpfzQIU3k1B1DhGXAK9gfPlZWkO9qUGj9ZKLFLamL8+0ENqG1
	 w8TO4wG9u3jNPEIcnMEggAowcM4y1IZvMW4mhhzplI3wcjsViloMRyzuGI9CVRkOd+2Pt
	 4cUyI9GXnJ2J34tBjVygbw7e6LP3EtHSo4YUO+i/ZIVYNE/ghTibVnSosNH9HaWJmDyWE
	 E/E8RzOsVBeDNE67qfFsx5tvoC3ZXkdWgzzAgDJXWufYsr/9gHLnKx/iqo/gqExqrog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589172;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rJvjfmEhSuqQTCnpv4nXJfbQRn21yTAaI+JW1VF1tvQ=;
	b=NbD+GQn61aSFxQr1Ap3107LerWuaIAaXZ1NummygyJJYMC19t6iFXCCaFuNGFwyicJMm
	 1x6GJ7bASZdis+x9ru4CeRw1mHS+4RaJzxK6DfVZi2VaehnI/98gO0AD6MjeO3PC9ANf7
	 YBsOM5vBieNGW0KbzxRK5bJbAnZ+z51ShCEMpRqdQUHSc/4fXpOlzZKQrHKsBGkFHpA8N
	 uaWyUEjGl48uVH7AuOEAwr8MAHS80WfAMRitv8W6vs2iqTKjOEe4+KF5MJXgH5Xce2SPK
	 pyuDRhyzOF90p7OWEVHeOPoJmOjIZ+6MFlPtboDwtvTDOOcII+ALOADSv2xT8O9KYxg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 387291F000D0;
	Fri, 13 Nov 2026 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589172;
	bh=rJvjfmEhSuqQTCnpv4nXJfbQRn21yTAaI+JW1VF1tvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nPUygwEWtF/+NXbyEq44JJLp7ZZJqRE5+ne17mDuPCK6GdyOwqRznu2pAoQ5JNbkx
	 YXzV9sBOr6YZbh3Hmv8RnTdJLjlB9uScxdGLbbpA22ATglQ9ZjwbcZZ1HWdaWLxqXi
	 mvj7IJ0A9hlFxlhCNqKkhOrvExkh3TfA8CWUm4J1aalIxyF/R8rS67WPCIV1H+H+VX
	 IGCmlzxVa6qkcb/Jme0wEZaeD8V2OPKav79ByVmitz5AaHjVjWF11eizOkJM04AsAN
	 KRjPUB+SxiOqumlgJbNmjEMAO14MHuG72grIBQhVH8t66oigBK7Wsh/wzmc0HV+ewq
	 efNvjFFJGfkSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9AC0E49A2B;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:27 -0800
Subject: [PATCH net-next v11 08/14] net: ethernet: oa_tc6: Drop frames if
 footer has FD bit set
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-8-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=2179;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=dkkj9Yvy8E8XVR9o8A4wOOf+5qrIVE9onT+oIT/7Bdw=;
 b=QdWV9vCthImkHEbA7LbkU3pP2WAhkBfeV0eQmeWxBTZvloGcgSCVfEima3UVrizhjxcswM4vv
 WoQdCIRBdnzCCUkJTIS/C4AS2SaBW/BW6RYqipi8IMQZV1/5H9o1ktJ
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Drop a receive frame when the data footer of its last chunk has
the Frame Drop (FD) bit set. Dropping the frame with FD bit set
is in OPEN Alliance specification.

Here is one scenario when FD bit will be set. With RX cut-through
enabled, the MAC-PHY can start forwarding a frame before it knows
the frame is bad, and uses FD to tell the host to discard it.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Act on FD bit on the footer in the received data chunk.
  - New patch in v11
---
 drivers/net/ethernet/oa_tc6/oa_tc6_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
index 2b31370da2d2..5d01ef5a13ad 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
@@ -1150,6 +1150,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 				       footer);
 	bool start_valid = FIELD_GET(OA_TC6_DATA_FOOTER_START_VALID, footer);
 	bool end_valid = FIELD_GET(OA_TC6_DATA_FOOTER_END_VALID, footer);
+	bool frame_drop = FIELD_GET(OA_TC6_DATA_FOOTER_FRAME_DROP, footer);
 	u16 size;
 
 	/* Restart the new rx frame after receiving rx buffer overflow error */
@@ -1159,6 +1160,25 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	if (tc6->wait_until_start_valid)
 		return 0;
 
+	/* Drop the frame, if footer sets FD bit. Checking FD bit
+	 * becomes important, when cut-through operation is enabled.
+	 */
+	if (end_valid && frame_drop) {
+		oa_tc6_cleanup_ongoing_rx_skb(tc6);
+
+		/* Full frame in this chunk. Nothing to free. Move on to
+		 * next chunk.
+		 */
+		if (start_valid && start_byte_offset < end_byte_offset) {
+			tc6->netdev->stats.rx_dropped++;
+			return 0;
+		}
+
+		/* The chunk carries only the end of the dropped frame. */
+		if (!start_valid)
+			return 0;
+	}
+
 	/* Process the chunk with complete rx frame */
 	if (start_valid && end_valid && start_byte_offset < end_byte_offset) {
 		size = end_byte_offset + 1 - start_byte_offset;

-- 
2.43.0


