Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DC37F306
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271769; cv=none; b=bQJN8IjcL7j/4xuG1+xL48450IOzRw7JBNn17DrgoXCm196IyfIhbxopuluwlanwxSUrczRF4ehQa47u2ySh0/BTdEmB7NYnHIYsy5FFMvK7cWWlyulfVn6ykzOUA1QpjSIokzJiWASrwdziB89A1opVSCt+3psQgYrEjYCwRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271769; c=relaxed/simple;
	bh=4RZC9qjirxurZ1cUokwzBczc7gFvUblpPKUywrm/9UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQFfzpxipc3NrxqF9J/6y4retCFYYu9Ns32M25XShQCVBPZ306o5cug6BVnbrgVMT3zO5MFJqGCET39eXWrttLRhuucAvxdjOjajduCEfEKHZkz8zMJmrn1krhBKpgf5PeZHahcKmHfB5pgZpj1N01rpMpsTStLKiVFEQKhtVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF3uheBJ; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF3uheBJ"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso91314885a.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271766; x=1789876566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/bUegMRiQaIBYVN9SOaB+81MDliAzdtzoIqgfMCTL0=;
        b=TF3uheBJffth6nkWnxKGIgbOal00ntogM+dv2n+lTos36qS/eToiMJDKcVu84yR0f5
         Wem1MaQ5RUb8pXLO2L4/gv1S5WW259DChCtGdmz7NdvQN2eEWMWALewi721BC9KhDKBS
         SYx7DDe6GZD2zHg/qf9HyQnBzv/6Yitc+9iTsaxP/KImx7k8JG5wmP+rfhK1v9PTnGuz
         VYlJaRaJtNJOaoDiyDFfrDvipgGMcbC9aAcRd/hRUIXYX+xGInRotAbYMG/1DLqQBaBe
         iRzTR3IBV/QzUroI4raSzPVwebFU6W3BAZRmLPo9EtYERQkBT2vlAVY3HfHv4G4sYkjU
         +/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271766; x=1789876566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/bUegMRiQaIBYVN9SOaB+81MDliAzdtzoIqgfMCTL0=;
        b=Oi+93WUKjvFE93iGZWsiJQjOAbbrh6bhBReKQLS+BdN51fQ0LdU65U/eY7KN4vtQMN
         Om/iVHZlcusxJVHvOUxfVrC05I4rUJHfYBXuvCfR1aGswoVy60JfFCCIuwIdyFQCv5U0
         /CV+xrsjGoyHzvXsLYIogZhNfFOKaIwh34rUuSEQIDz7SgHqyc9hmPWyDbXJDvgTR3i8
         ZkhHZLJDgOw3SOe6glRlOy6rW7b2u3Ol8poj8HE1HTcIogyjoXfjsrTMvLx7X96q7KyU
         VzhfPWDPaAuPSeZVF1ZbN1BGaxVzpltL/jv+B/pCytwgTVqKo+EYIrMwgpqZeRSYIOus
         +dHQ==
X-Gm-Message-State: AFuF++kb1qAt9rVaoNGRhgbDi2dtaQz1jEWiDiLwz/jcvz71ZGXVKK4C
	Zi5P2nSZnJC5r+fa3YZWuiUuXBqQp6TTiVX4JeqPD78VPU/VnZbAQMZhmZ45qIz2eA==
X-Gm-Gg: AYBFou2H2SpCB2eX0HoXHq8fHsmOgajotzdarNkxEZnUbiwpB9TUdaLWA6xFWB7m+HJ
	IhAWDw1ONixHb4+fm0bC9ye1Be13BRdJxhe9duxpIVbas6XfVbyIuos/zfdggIwsaRRySdSbqNp
	OQRsMAVkUU93k9mD4wKqV+576hqmnUuOZ1BuACM3ltBbB17EpJXLiXVbVzF0LwcSmIX9alm3lv/
	EszvwV7WXiYDaCKB2ccPmFWcbqm3n0LKHB3RQJBZrMpSKz2dudusZpM3eXnE29TsC2B94Rr4JtD
	Jujp43ew8k7uPf4lZZ00Skwg5EA5Fp6zUXIte+fn3KuSybQLz+epVCAgaogfv4DoG22eNH42Mjc
	oF2ArsVSI95Vj4Y1p6PtytPD8S1q74OlVcLkr7fX63o1K5Kc/HpRXD6+l7fq1uqGVLy9/79qIux
	gdUg983S+4xB8V8ON1MW5tyk81Gh/T1lS92LVu8e9BJkOAmhwYhR2wjlP+FPm4ln4XnkdsDLW9Q
	jr9aeGikB5oWHVPF0zSgJ1rfWxvydE/RY0HF5DQSrgpsLhjHPhXPnFU+rJJYi+8FZyqaxCtwtcA
	xv5+T0UbyZ2jDkLKHIWpOfrWT4KyDl6Wf/Y+eYQmi99B
X-Received: by 2002:a05:620a:1a22:b0:939:7f2f:b17e with SMTP id af79cd13be357-93a0370c52amr793597985a.30.1789271766503;
        Sat, 12 Sep 2026 20:56:06 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a1bf286dbsm17527285a.40.2026.09.12.20.56.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 20:56:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ben Dooks <ben-linux@fluff.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] dm9000: free the wake IRQ before releasing board resources
Date: Sat, 12 Sep 2026 23:55:57 -0400
Message-ID: <20260913035557.19347-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dm9000_probe() requests an optional wake IRQ with the net_device as its
cookie, but neither probe unwind nor removal frees it. The handler accesses
the private board data and its MMIO mappings, which are released by
dm9000_release_board() and free_netdev().

Track successful IRQ registration separately from wake_supported: the wake
capability test can fail after request_irq() succeeds. Free the registered
IRQ in the common board cleanup before unmapping registers, waiting for any
running handler before releasing its resources. This covers both later
probe failures and removal without freeing an IRQ whose request failed.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: c029f4440fd3 ("DM9000: Wake on LAN support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/davicom/dm9000.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index b87eaf0c2..c8ff07fe3 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -104,6 +104,7 @@ struct board_info {
 	unsigned int	in_timeout:1;
 	unsigned int	in_suspend:1;
 	unsigned int	wake_supported:1;
+	unsigned int	wake_irq_requested:1;
 
 	enum dm9000_type type;
 
@@ -802,6 +803,9 @@ dm9000_poll_work(struct work_struct *w)
 static void
 dm9000_release_board(struct platform_device *pdev, struct board_info *db)
 {
+	if (db->wake_irq_requested)
+		free_irq(db->irq_wake, db->ndev);
+
 	/* unmap our resources */
 
 	iounmap(db->io_addr);
@@ -1519,6 +1523,7 @@ dm9000_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(db->dev, "cannot get wakeup irq (%d)\n", ret);
 		} else {
+			db->wake_irq_requested = 1;
 
 			/* test to see if irq is really wakeup capable */
 			ret = irq_set_irq_wake(db->irq_wake, 1);
