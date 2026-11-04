Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759291;
	b=I9qJ57ko7ci7h9LFU1JJP5Ckr2T6dGKBm5AQbRFtmt24gTr3caUIfmws51w657RkVgFh
	 TFDOUSKMnVgziJbY+H/HJv6I20tJerKMCp5BM5Vya8KAe1QbIAZByTrwPrqNj+B0WFdoQ
	 +4NEmEtMR9ozHhM5bTn7osnaRGZWYVUWQ3A3etYMpBePoL57sqDnBnl8RbvhLtDXc9UCa
	 K8KPF0I6sh2b6UfGxabmUi+4wyrc9dYHCPZHoRAB+EEKlqy4rv0VvIZIIUImWni9Vvoc4
	 2l0JVcMCBBWwW3L6AJcwVGXRyaJMbXNWAysFSEmpqJoLNkPy837sDYCbbFnlpOoIzZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759291;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=OHOyST0K68BpqYUM7L2Y2DAO0AOJ5NknSjGQWburvEI=;
	b=XK592Oyfz7VZSX5yjcw1h5g/oy3XonAHq/vV2sxDmT/ke85CoRlunPWutUSREDVfVBxN
	 ynxPGx8bhK9vmrbJb8sYxA3i4nZsV12oPx5hyft4LKtGaymkF0KRRcvCXRcd+WpuzYxar
	 AZQWncGnm05nfFIHfffvV0JPpkP0yYE50NC3BbW3NF2ryBE2DqJQIkiUzJF8LiU2XmDVg
	 piIGhcKsWL7OlCFMFcqQYgEwV9FQzcP4UQwwIYYVuseecTsSWk+dqiYhtYA/cGietrvWd
	 su+c9Twhcc3+4fAnUwc+LUv5ks1vngZuL1ccvyus78lbNUKfB35DUJjSbruk5ruSx6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E097606A334
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E097606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAA3YPoymOpqtZs+AA--.30158S2;
	Wed, 04 Nov 2026 10:28:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] nfc: llcp: put the socket reference on a refused connection
Date: Wed,  4 Nov 2026 02:28:11 +0000
Message-Id: <20261104022811.1484216-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAA3YPoymOpqtZs+AA--.30158S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47CF1fGw1rtw1DKw1xZrb_yoW8Gryxpw
	nxt3W2k342qF17Ar13tF47Ja4DCanxArWxCFWUA3WIv395Wr4fG3WIq390qr1qyFZaqa47
	Ar9xKr1UW3s8A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMBA2rqY-nHVgAAsT

nfc_llcp_recv_connect() finds the listening socket with
nfc_llcp_sock_get(), which takes a socket reference.  A socket that has
been bound but not yet put into listen state is also linked into
local->sockets with dsap set to LLCP_SAP_SDP, so the lookup can return
it.  In that case the state check fails and the function jumps to fail,
which only sends a DM; the reference taken by the lookup is never
dropped.

Put the reference before jumping to fail on that path.

Fixes: a69f32af86e3 ("NFC: Socket linked list")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/nfc/llcp_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf..92fd7e29ec8a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -949,10 +949,15 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	if (dsap != LLCP_SAP_SDP) {
 		sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
-		if (sock == NULL || sock->sk.sk_state != LLCP_LISTEN) {
+		if (sock == NULL) {
 			reason = LLCP_DM_NOBOUND;
 			goto fail;
 		}
+		if (sock->sk.sk_state != LLCP_LISTEN) {
+			reason = LLCP_DM_NOBOUND;
+			sock_put(&sock->sk);
+			goto fail;
+		}
 	} else {
 		const u8 *sn;
 		size_t sn_len;
-- 
2.34.1

