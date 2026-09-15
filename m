Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40B3CFF72
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437856; cv=none; b=ALRce/DfBHqLleVPdtzQ6QkYGN0NhIIwKfO9n9vL/EJQqFyUMZFh0JMltxgcLlux67BDcfc2COA6y5UsJfbKo0nRrf2NlT8DkEobPa7tL3/N6OTMJAvk7E3wgu81L6kMNxKWdy2L1RfOjnL+DBQC7rL9amO0sGpcmRXMjKE0mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437856; c=relaxed/simple;
	bh=Fcw039KrkxGKVWLTft+Guz2bGKn9Me6A8sWpvgD3JoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HogV91w6ixz4OS0xtJ3CqRLLo4jm+m5ysEgl6MieF8wUQezJqn7iWExMbSS+yyWah6fILA4X8vP7gQAelZHtjU81z4gfQViSJW0YdVtEdDFwV52TIgU0CJgWX0/tP2FirYH3gkYA8bYQTMOmmV10onkABNbVeUdFj67sfZuTTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEnxM/jX; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEnxM/jX"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso32937686d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437853; x=1790042653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijUVaQx/mDvllGL84fcjqcGETQyV2GszfE4nAG9CvaQ=;
        b=hEnxM/jXNA5WFb3EwKhx1DF8S58K08nRHmbvT+4T041tstO6Uj2hS7lxCjVHd4fkz5
         p0xDJVskoLvnGj9E2B8ljjdtFVghsJO+63kUx61TX5i1IGjofURLyG9ROs+thRsyyHmk
         +h+vT0zjTaA/cMEmVkzJiP3I9jIARCq+IpCexgsVww6vOIdDn77OQPd9F81sMYe+9AiD
         NZSJqjxOYfQetMOvTwAQKLuXAVULDgTeOVAnKPdD6+naxrcazJYa28HADfjGMlMNokKi
         PJfdFUOhIOVZH/nsOPujZG5mozQ9suWzUvnrfNdSP8UDjm4K73LQJ2WAOq2LjZcVJEau
         Z3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437853; x=1790042653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijUVaQx/mDvllGL84fcjqcGETQyV2GszfE4nAG9CvaQ=;
        b=Gp90yL1isSuWrhlJc0zMf6Mkbcn+vNjNt6+fIr/Ow0jUglhBBJsD3EVbILAlnoiIup
         Hvzyl+Hg9HM/8ErLWbeRuNwo3VvdOQR2rSvD6mCBgxx9ZDgcHOjxkm63PCJd1qE5N7OD
         pf13ZcjZ97NW271ieUh17rCnpgWpj5qY9M0hZhSy077UOye3ysrkKd7y5bperujJUG60
         HacBAX0eA/AAV1vD/W++DfOz0stsLXtzqZOz0eZx6rKOP7ALMz213j7GccuPkLgMtc+y
         M2sCBOesdq4kJDVTEY6PJ8qpv20uS4yhmYwCOMFdGja0dvb59zQDqbhKDh2Ht1HbFFju
         JRnw==
X-Gm-Message-State: AFuF++lpKjctpskAKZAI2cin5V5SWXFwBZY5jpFnKSdWFLTq+Js9jhgH
	LHZpQ0MVRTbHPIaUcwEyihPWyGk2zf6cVwacX4oflyrBlrWblNN98hg99tyqpDg2NQ==
X-Gm-Gg: AYBFou2vse63Pui/Ols8UQP4oMilEgqrsa1yfWWG6SfKoD1c/RyiAbehJz6knWNEbS5
	ZDGOsFnUgJjBX6VBxNdOD9kFH9CK2bAOVhWkyTxeosCYRNatpJtUl2DgKuYYOc2bu2Mm/7TS7V1
	+14/yepcLchMGwVJJx0GQ8oABoX9CHvChYNHX+upX5FzJ5IEdQeB1DWjdBi/9iK36t+em3dRhnd
	0t1KstqN4cZRGDROYK8n933xcrd4VETA2YJNRAgLZLgWLn3ur4nfaa+0vESeWZgtoo2ffjGhKxn
	9o62uTbReKZG1KqZFxE+P7tnYYcF9dcxUVl7FWa/pvVnu1+c8SdJs+qFKdyhIACBeFtijCicGxV
	SCq76ez4F1LxCoZpYHltpxl/gX0DLXGuToQXRllWahpg426C2mUN4YvxpUhNKjdmGofcSfJSvxg
	mcyVuBiF9E5H8OgBZhxqy5OQ01Mwc3+KhONUoAGxDISFabs2eBgvTOhTApBqylu2yTQga1o/TAV
	vyPVHAgvydMwABT21IG3gsKE4LK+6TszD3jZlu2OLtt8DzEq4g3bZg+ChXi4FMDqAA+V/iG3y4o
	CyEQN+lkreIPuDZMcEhgziIAILLk/eIUGQrQfuaoD4rs0V/mE/fuOKzV0AsnrhMal6PQAg==
X-Received: by 2002:a05:620a:4888:b0:939:d762:e2d8 with SMTP id af79cd13be357-93a299943efmr847619485a.31.1789437848647;
        Mon, 14 Sep 2026 19:04:08 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f18628sm1138775685a.13.2026.09.14.19.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:04:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: tulip: dmfe: Disable PCI device on removal
Date: Mon, 14 Sep 2026 22:03:59 -0400
Message-ID: <20260915020359.89842-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmfe_init_one() enables the PCI device and balances that reference on
probe failures, but dmfe_remove_one() leaves the device enabled.
Disable it after unregistering the network device and releasing the
driver's mappings, DMA buffers and PCI regions.

This issue is already present in the initial Git import; its pre-Git
introduction is unknown.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/dec/tulip/dmfe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/dec/tulip/dmfe.c b/drivers/net/ethernet/dec/tulip/dmfe.c
index dabc091..dcf6848 100644
--- a/drivers/net/ethernet/dec/tulip/dmfe.c
+++ b/drivers/net/ethernet/dec/tulip/dmfe.c
@@ -528,6 +528,7 @@ static void dmfe_remove_one(struct pci_dev *pdev)
 				  TX_BUF_ALLOC * TX_DESC_CNT + 4,
 				  db->buf_pool_ptr, db->buf_pool_dma_ptr);
 		pci_release_regions(pdev);
+		pci_disable_device(pdev);
 		free_netdev(dev);	/* free board information */
 	}
 
