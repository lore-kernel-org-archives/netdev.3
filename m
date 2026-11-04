Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759290;
	b=FkEQv8Q8mh79sMpI+sZuYowMfftAEHzTv8qIUyG0rClFr1C0oVnyUXXTtW4emAZ3Qoeg
	 8bBcUJjBerKpQo6vWWVXwsRCWQoqgBf7wVub1EfUkvETN+j6hEsjsYnnF0apJdK89GnHm
	 2OGM4//XkJSA5A8EDXv4WLKQ1ke3mAd6rvvrUzMJPnS+f/ThacLS/3kTMfT2/6b0qABwX
	 llmStisN6o4qlRj07cqhSa5wgieEZXDgoWytURLLKBOU37chIPVZH7I4Rk1dwshrH7Wap
	 Gb0CrhH9CnvLiAfNVIFf9haKZiTXaoDTXns0vTwFMwG3DW2RBHnc1V3YwFWPLjCPmJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759290;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ltqfsg/46bD10r6tESWSCXKnk6Dp0VyEEG9CEfn82QI=;
	b=0omxCGKzuEnNCTi/ZSmEb/hCKwTj/qF5y+4CbsFf8wtxXqJn6AqKEqtuecqxfJU4pXFx
	 Kob9N6FlVkg72b7eZ5x5jSVL+RTiu2lGAta9HAHBLaW2sExQqlF15id9RIJATKTdkC4vr
	 oaa/xJKPSlw/GgcpFZQEwX1yYHV/RCmD4ATEXj8Ryvi5bNFQHHLie1a24iLhWiwM7EW7j
	 iQvjDj2lI6VhV1Se3qG+p6fA30XI/SXYwsuTxZI9+NTRjVvwayJ2Dr0XQtJE8EWYlKTc5
	 XVTQQnlCt9PP7mQK1htufq3UzLHhem3Rqezt7OIKXjbLX/ULHY1SdPrOsR3fBxMNUXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87E606D808
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB87E606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3Zf8xmOpqp5s+AA--.9903S2;
	Wed, 04 Nov 2026 10:28:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] nfc: llcp: drop the socket reference for non-datagram UI frames
Date: Wed,  4 Nov 2026 02:28:10 +0000
Message-Id: <20261104022810.1484199-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:qwCowAB3Zf8xmOpqp5s+AA--.9903S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFykWryDKr47uryDury7Awb_yoW8GF1rpa
	nruw15Cry2qF4xZr1ftF47JFnYkrWIk3yxuF4UA3WIkrs5W3WfW3WjvF4jqr1jyF4kJFWx
	ZF15KF1ru34DCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07b7pBhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIBA2rqY4LLLAAAsA

nfc_llcp_recv_ui() looks the destination socket up with
nfc_llcp_sock_get(), which takes a socket reference.  Sockets of every
type are linked into local->sockets, so a bound SOCK_STREAM socket can
match the lookup.  When the socket is not a SOCK_DGRAM one the function
returns early without dropping the reference, leaking it for every
received UI frame sent to such a socket.

Split the check and put the reference on the non-datagram path as well.

Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/nfc/llcp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 92fd7e29ec8a..92dbba7d285a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -917,8 +917,12 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
 
 	/* We're looking for a bound socket, not a client one */
 	llcp_sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
-	if (llcp_sock == NULL || llcp_sock->sk.sk_type != SOCK_DGRAM)
+	if (llcp_sock == NULL)
 		return;
+	if (llcp_sock->sk.sk_type != SOCK_DGRAM) {
+		nfc_llcp_sock_put(llcp_sock);
+		return;
+	}
 
 	/* There is no sequence with UI frames */
 	skb_pull(skb, LLCP_HEADER_SIZE);
-- 
2.34.1

