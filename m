Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323984F55BE
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958318; cv=none; b=fJ0u5zUMPPewTjUA97yStt54qwnJaDzjDT5scajHoDV6mmfd/4o/rvZxUeoLLysT6r2fn6TObi+h3d4mDotrcS4q0qNCaogUkfZUn9w1/evbVgSfS2P1inagP6FNjLZwvxZ1UYrkgMoH9nApEdUvg4HP8Mfq+JQt3KO9gpellNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958318; c=relaxed/simple;
	bh=FvlInUFSB933UGSH+qJiu80GNE1NJDMTQVyOvfLz/W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNM4aqERM9esNaPDdg0b9ZcEFzUmMXP1U2KqxWOJIHf0QJY3E3G0bsYIMp76tr8u2jm5QkO2NelhyoZKtKVqqNrvYRlSDdI/wx/q4VRvBTa6nObR9mj1rq1PF+zR09jJKTxQKyOu8MJu4NKQhbmsK7QkdfjOe3lpvs6TMe+tcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa4ilDpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa4ilDpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A271F00893;
	Fri,  2 Oct 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958316;
	bh=Lqqd8wcSwRRuP94gGADU/EpOmzjhj5SmxHuLvL2VFwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qa4ilDpqUVz2kU6OnJCUhcd16e404PKDg7B1lYuG3jZI9xA/tFOSeWxxPdz8/yJnG
	 eRN1fKW2/6IKxpmTpnSj5xMK9gkIvjweUFgetSDgESHuTFolUu5//bQgLXOR9GPpAq
	 xO7h6GgD43cxzf48PKuRgMHxSOnC1ixvSj+7x5lzhQezZ4xMDHt+u63KbxeHoZgbcq
	 93nGrMdDXLXtr5jsfizJbmN4EC4HOC7Lh/VF510TjXMtFUAQ6lBkFI7TToPyhEISH5
	 glcAj8ofL03N0hDOo3ZjtG0vggMdBEibgNrjmtvD+9M8Cj2O5n74EuGfix5X1SjiEw
	 4NqlHnBDlP+dQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:50 +0200
Subject: [PATCH net-next v3 11/12] net: ethernet: cortina: Release partial
 RX frames on stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-11-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

A NAPI poll can retain a partially assembled frame across invocations. The
stop path clears that pointer without releasing its fragment references,
leaking every page already attached to the frame.

Free a pending fragment skb after disabling NAPI and before clearing the
saved RX state. Count the discarded frame as dropped under the RX
statistics sequence counter.

Fixes: 06937db21ee3 ("net: ethernet: cortina: Make RX SKB per-port")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 6b333eb81f9c..2ebfbbe84eba 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2173,6 +2173,12 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_disable_tx_rx(netdev);
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
+	if (port->rx_skb) {
+		napi_free_frags(&port->napi);
+		u64_stats_update_begin(&port->rx_stats_syncp);
+		port->stats.rx_dropped++;
+		u64_stats_update_end(&port->rx_stats_syncp);
+	}
 	port->rx_skb = NULL;
 	port->rx_frag_nr = 0;
 	port->rx_dropping = false;

-- 
2.55.0

