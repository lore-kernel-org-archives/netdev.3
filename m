Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3B521216
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804864; cv=none; b=JusXmYE31riDQ0eIl/dZAmMSzOLYGi60/ZRSVdxV/TO3sfaNG8UMtS9W0mSSGMaEIwnWByi0lXFDbN0iTGUp7FSWsF/HXR5z7CO7cNlmpRyKqybItWjVAss4eT5yL/J0DW1xnfMSayJluYOFZMmxiOyGioy/Uk0ddd3lNBoA6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804864; c=relaxed/simple;
	bh=3RSdV5bBhWRULyl6uKfnW1LG/ffeWbw+PgurKVAIkeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7CBMyUUcS4Yfs3vKNZpZ+tkKf1NYsLJ6IGpPaYG5RHMC7idLpgrq4DQWLd5jLYUEOO8ldF2KXzszkmp/DXXPVrziWXyVqvCA7jbRgLHfmZPn0/ZfhB1WCcCPBeIGibT1EHhOfB3/3ghP71Pdts5POp6mNFgvptD1hFnFn8QBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3IXNbi2; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3IXNbi2"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3d832827so64252315ad.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790804863; x=1791409663; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXsSMFeS4wLeCuWu6IbDBclh7ggI9zoXvgi6QeCApjg=;
        b=K3IXNbi22Chsfq9FHM/J0rx9cHrpfRflGM6gnXYeoGYGmfCYln5ZzG/NfBcFdXdyhZ
         hWDChGty6sfXCNwTPMqrrtmHRHDFTFPORK+NbvSgiyP7ZNQUtE+MTCEVdlfbiuUV3J3a
         6Qmrr0yB+2VdYDshFwDAafm26cic9znfEcSyHjGeBFR1UPKXt29zsxedUgjRaJYlDblF
         nDYxpOeX6B9WbAnFOX3646zl9uZbukQRWogNU6qZBc2vNrWq1v4gPPLwQST0yCHPzmX/
         ZMiggwTMqNdBAmfuX9kt5wthWJAkpkGKGW/wRoLgImz6ed6JtR3ynvl+6hvt4eGkIT5P
         VNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804863; x=1791409663;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXsSMFeS4wLeCuWu6IbDBclh7ggI9zoXvgi6QeCApjg=;
        b=KrUVdVigslir313u9CG/BXbh1o+/apsxeuM0OE8fWs22rA0DFIt4a91Y9hwHhFeqgM
         KXAlHXecE/lmAFHL1JZF6kEO0Rxf7irTW46LWtC4lWMVM6J21kcjmiLQv9Gw4vmPxSOl
         oerJel91m8fbRzkakmd/7aI367jd29/4UrtH+WreI02/4JL5rjWmFuBAwP9gOyPxn358
         +ktwDJauUtTOdGwyzp5VD2/2gEsmvCNAiasT9VHQE6P9bN9uqQVV/YqfEixIlogedY3b
         ++RT8Se7x1W5NqRDRzPDmTQ5Hj0Gh/Q936gHan4J5bECzrYTGF+0GTH9AivxdbvLUYF0
         GbEw==
X-Gm-Message-State: AFq9FYKg2tPhCn0AZ9y4QnDFX3ovimdcqhlfU7bwJqpa6xsNqzPpTXOC
	5wroa+qgBmuqA/NThV+gHkySY5Ol5Ju6BfIoHyH9EraXKAC3uyYi3buH6Ol2qpWDMN79SzX+vL6
	MsWgEi5vp5Ts19/8xkv0btHh0SkUjTTNWKIREazcvpE4hlWgYo+eGOoPMSarhYxe8PtqUzUTIm2
	3vmmqjSA7D0RmWqXd8zpvD6f+nM+2Yk59RSyj7EQ7rJR74Vuk=
X-Received: from plyt22.prod.google.com ([2002:a17:902:d216:b0:2e1:33de:ada4])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f684:b0:2e3:913:31a9 with SMTP id d9443c01a7336-2e30913f27emr449105ad.34.1790804861617;
 Wed, 30 Sep 2026 14:47:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:47:33 -0700
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930214735.3288780-2-joshwash@google.com>
Subject: [PATCH net v3 1/3] gve: fix XSK buffer leak when rings are stopped
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.

Free XSK buffers attached to an allocated buf_state when stopping rings.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5cf242b28557..a2c4a08ce68d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 				gve_free_to_page_pool(rx, bs, false);
 			else
 				gve_free_qpl_page_dqo(bs);
+
+			if (gve_buf_state_is_allocated(rx, bs) &&
+			    bs->xsk_buff) {
+				xsk_buff_free(bs->xsk_buff);
+				bs->xsk_buff = NULL;
+			}
 		}
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

