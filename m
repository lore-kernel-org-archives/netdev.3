Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4B44519AB;
	Thu,  3 Sep 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432708; cv=none; b=iuoXqITpxTgS+99KgXKBa1pwqfc68Auc4LVEZSH9/84+PSFyBbue3ZAmPdRXN5gdsLlfKQlKajnNNDTKaj7o2ssJYJlhFeA4A+JkDmaIgSMJSDO68pX9wyEI/KXvBboJGS1l7HVbbFw3rvw3j/yJaHEJvcNRrshAWfexSvcZyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432708; c=relaxed/simple;
	bh=Iog+0k0/VDghOU6GpXNBi1yn6ma85ywgOsiQOA5LJDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RmTJFTbTQrpdV1+5QiSAy9s7s9EBw1ah/Tu9mvtOBshJmezXttH68XAGpu6Ojjqpyq764N6/uSM7kDVctuMi6AO/aV4e9DyrmJWGRhFKZkUkegJoicEzKe8sQuVq+0VGe9kyL3OAU8t4G8G6S8+NhsvRa+aAT+qwEM/KQqMrUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j6Fs6Xs/; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j6Fs6Xs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788432673;
	bh=Aq7Yc9yLHAAzo2a1VLGYdmtVCdrsptbcUOw8CUCd9/0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=j6Fs6Xs/vhKA3rRvMU4zAvRb/bLL4TWjw1a/EjRtkcWq6c9QDrYOzeSuAL86uKwtW
	 1rLpt/bxVHYnIlPcVd8/dNHOVArKyeGtGkknSmrlaB5GR494IMpKOS4K27P+3XfxxI
	 wM7USYtJiqpSUNTOdGiHvs6lPMIivbG9Ersgy9dc=
X-QQ-mid: esmtpgz14t1788432668tb6cc9c0f
X-QQ-Originating-IP: tF6196t+vWc8kb7gFg0WDvqAQUR9MwK+wQ/rZGZNce8=
Received: from [10.10.7.69] ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 18:50:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12566516252046344313
EX-QQ-RecipientCnt: 16
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Thu, 03 Sep 2026 18:50:35 +0800
Subject: [PATCH] net: stmmac: clear dma_conf on MTU change failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-fix-stmmac-mtu-change-use-after-free-v1-1-c81dc7d6d18a@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAPpQmWoC/y2NQQrCMBBFr1Jm7UBsJFCvIi4m6cRmkSgzaRFK7
 +4oLh+8//4OylJY4TrsILwVLc9mcD4NkBZqD8YyG8PoxuAm5zGXN2qvlRLWvuJfWpWRcmfBLMw
 YJj9T4Hgh78BSL2Hb/W5ud+NI5kehlpZvvJLaFI7jA9jxgfmPAAAA
X-Change-ID: 20260903-fix-stmmac-mtu-change-use-after-free-693da6eb4a30
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Simon Horman <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MmYQsr5QbR36znz3yH/QoNEjWb6xecQxmO6Vj4Zx2DddGVgyklrIAlPO
	aq0d9Jb7Hz/c7niTRTabrIHEnMQCNsE5NeF5aaZarV7IuTBac3w5deX9XeKo3RWC2yGk0Dr
	fyPGgDYPrbF+9fvNSwMGTYXUd3/VRLRkJv4BiZAzhee07+wQqF1KJ+RLDtmIB/xTornF0+Q
	0QUMIbRVmkvO8R1VpjCVt23jc11hX+OaNhXnfuMcBZLBEPaVnGmWNZOpb/UNoGEiimFhOZf
	gCmfjnmHgolBNmtuX/rJAlDazrxew8/Jd2pyVLmooFTsYOYYv40v7EipmrKLF6+C6NPOGNy
	kP44Vgp24fpQ6fDBS48B/elXabGkMk7zgc8M8hdbNRJotiBixC+cZGIvSQjBN4IFSrBGof/
	8rszYPE7TRxb7AYeKZyFXwGHNuSHb4G+jDVV3Al+8eEHf34N1GllhUxnrYVkrOgQw4icHAY
	t506ZXQ6u+ES5ffCoVqbUeyAq3tTlWDxFT3a92d+AKczAMI11ZfnN5uKjqrL5rfH0B6HmoC
	XntKk50EallcSvyh8JQzp4i4hCUifzHUOYohbYbwr2m602366vuvVWvyTJ55E6lahoQfrQj
	lSVX1JjuFJLh5B3V84eyhOudd3I8HNXUVBI8A5cxoGjaWAIfD+t3zbhzr8iodWTJSTNbG/G
	6zA2VyaKSWspJGv7clXtHBK4OopZMsqIqYRzn8s7lKAyavNZl9G632/bcgAaExIA20HZFxJ
	OX73PtD2T/RFse2kSRIkP9IZS1veFaOUpL2HYaWe7fzbRfuIvCIrLEw6vGxbH4OqMWHFGYw
	UH91By4un8xzfvBHDjTUYaXbYn87tYxyCcdedh886bP5S321xKx6QMY8CGa3vkZKkhX7zVg
	/aZjsYXULSCYdtiVQsZYghUbRZHia0FpwjyXQZVX7yxKQmbVf4h05ip7HTQfQ/JlUMB9R7O
	dTAQxt8GnzBryWSXijKjaCLNn+RQHUw/T0ZrL2+TZIIAsXh2ixRaDDRtr47DPlYSR/SD18x
	U7uMaUL7uoZCWkb5H9
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

stmmac_change_mtu() releases the current DMA configuration and then
reopens the interface with a freshly allocated dma_conf.  __stmmac_open()
copies that dma_conf into priv->dma_conf via memcpy() before it can fail
(e.g. in stmmac_request_irq()).  When it does fail, the error path frees
the dma_conf descriptor resources and the struct itself, but priv->dma_conf
still holds pointers to those freed resources.  The interface remains
running, so a subsequent stmmac_release() or another MTU change releases
those resources a second time, a use-after-free.

Zero out priv->dma_conf after freeing the failed configuration so the
stale pointers are not released again.

Fixes: 30134b7c47bd2 ("net: ethernet: stmicro: stmmac: fix possible memory leak in __stmmac_open")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2fc89176654ed07dafc30ea1dd481d9f08fb120..9d4b93a64e32f375ef9ee4917f60c40ce2409f07 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6132,6 +6132,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		if (ret) {
 			free_dma_desc_resources(priv, dma_conf);
 			kfree(dma_conf);
+			memset(&priv->dma_conf, 0, sizeof(priv->dma_conf));
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
 		}

---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260903-fix-stmmac-mtu-change-use-after-free-693da6eb4a30

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>

