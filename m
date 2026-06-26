Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E133E5589
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464615; cv=none; b=KR4+cihbJRZzzbXFhMgknHtqCwnLrzQ7VeN4inqBN981G5goxsBufcLLro/+pXKaxrYE1q01zFXHRJ5GWXg/shwv/cHltbxLyQxBKYUwCkqzKLjdsJrqbM+MJSEE35bjYpZM23B6u4QvzJfcOA1BFSKQGE7V795SgeRAg0mMmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464615; c=relaxed/simple;
	bh=0M0mxNXpHFTkb8lNX2bKAWdZx27Ftz5ouO/m70GPZoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rslEW70yZAxR99MjR94CeEafym71sOHU416OP6eQ1Tuf3RvGFkaGgAm7v6HFrsKkTRtn4zrzaF0nx2qBOS1rSTAvk++ArOInT7dX7MxvrvkcxIyCtWftB6JDcaP7MmJKfTDUoO/1MEhx4jiMlP2VwAFzlWDZaUl/CpNsFapT02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Aol9WYie; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="Aol9WYie"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bebb72b845aso119365966b.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782464606; x=1783069406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NKt0Mt/SHh0nM9NlYpItPXQZdY1JVeNAiPrcQ3UdMg=;
        b=Aol9WYiefrjy088K1Bt00UB8GORivLX9aWW+dILVDntGQwhjV41mJBHefvKstm4Cyq
         wZvLt22PzMVZerpOFOU+qZTOMTsXi0m43i/zfzTfvgy/Mw/FufT2b1RDXs4swlfINkLB
         Eu/Nl5uhjh+lRWC2vqwceUHKp00LtPB4H94wGHGhdjS7S8BNJpX7etOKvuzXqpA7LyrP
         G+PZV1xl1ZGeNaj+cCdJN4ml9jM/QF9ib06ibAV/ApBpsuUOyzIuGmjEKbporcrRlLxG
         CNUuLNIlgtpiJQCNIhiZdxN/x2oOCdLCvMUlgz+ixuvYOS5UpnXKEOQCzFwtJc7BTU/o
         BWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464606; x=1783069406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NKt0Mt/SHh0nM9NlYpItPXQZdY1JVeNAiPrcQ3UdMg=;
        b=qp0qcuqlRL/wMfxLhX3z66uEx9qcTflFI8WgNr6v9Z9z+b8DQBlNv7fsHJBL1LQZzG
         f3Ob+sbXiE5QzlTvOGth1Qp/dTreWh3KbVenJBGmSDtFAodP+xCF3B7hst+p0PaNSpO9
         vq9XHm6xK+9d9hkE7/YO1gme7at9g2LtLi2mmwWn14OIrVv7Nv0xDTUWEvywPZPiQbx+
         Xq4C3YqrebZ3CdhKKSAsPimWbzaI/WhIRWpRPbdo9BkBqdqA6jnqkBcH8zeYkOVvavCH
         0uwb77JxvXK69WBwr/HwGQmQ9AX/dEIlHuNJ/SBuxZ+uY1uBUUVcIZUbehn7QO2/xxgN
         OxpQ==
X-Forwarded-Encrypted: i=1; AHgh+RprnPDlzRjwF+VnkcS8TFObXgKBha8U8n8DpV+CknX1JXATTwUFbiRv4dfzOJlXQ/ypZw+rgUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwwnynMIsxGvQBtmMXA0SvkWzBIb02jP4+36FYpKe6YbP8zuw
	s1PIfmH2Irn/nOuvFEbAD2KYdrfg4PQYRwTviqHJJCXg238ZDDiaP6qVqIBe1YVnbIxL
X-Gm-Gg: AfdE7ckPeTOOb2g9aJDm1QpdHjaPatgQ0MHIhv6pjHD+J0d5BBGy8OQiUrtHCyiYMqP
	DIXi0lHQxq6bLq6DvtVixV7vkY9i/LC92RCbCVDxoud0bJyUC1dSnJ3sfWhtrIT1CyGx2NqZg1K
	iqqvkWgFSbjgSp/TzGYXUmWF2YKdOBr9UkkwnPF/tPK9iIp+BXLiyFngO+2TJke8ZCLmfZ/vj8L
	guKCrWgifg90sBh/CGEvV4MUEAaz3tsd9aUvEcN1hfN22yecHI0X3jAEGQCZhwoYhr9gMtjcoRo
	YLD8bHdOANt7R1INXdxdq5fqvi8aGA1YhdI/oquWb/xMfWrFrwVQ0vTR06Pj7DKBzmXbRNntgYh
	Q0Zrs4pKIsifjFcy61VLt6nAWh2sNqlnjpu+G1/OrolJnTkoJ99tPvb9IGzJAsMRNZR4yWfM5XE
	Bw
X-Received: by 2002:a17:907:26c4:b0:c12:15b5:8773 with SMTP id a640c23a62f3a-c1215b5a71amr250832366b.6.1782464605602;
        Fri, 26 Jun 2026 02:03:25 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05b6dsm317589066b.37.2026.06.26.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:03:25 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
Date: Fri, 26 Jun 2026 10:03:01 +0100
Message-ID: <20260626090301.2139500-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_rf_discover_ntf_packet() and nci_rf_intf_activated_ntf_packet() each
parse a notification into an on-stack struct (nci_rf_discover_ntf /
nci_rf_intf_activated_ntf) that is not initialised. The RF
technology-specific parameters are only extracted when
rf_tech_specific_params_len is non-zero, so a notification that reports a
zero length leaves the rf_tech_specific_params union uninitialised - and
both handlers then pass it to nci_add_new_protocol(), which reads it:

 - discover:  nci_add_new_target() -> nci_add_new_protocol();
 - activated: nci_target_auto_activated() -> nci_add_new_protocol().

nci_add_new_protocol() uses nfca_poll->nfcid1_len as both a branch
condition and a memcpy() length and copies nfcid1/sens_res/sel_res into
ndev->targets, which is later exposed to user space via NFC_CMD_GET_TARGET.

  BUG: KMSAN: uninit-value in nci_add_new_protocol+0x624/0x6c0
   nci_add_new_protocol+0x624/0x6c0
   nci_ntf_packet+0x25b2/0x3c30
   nci_rx_work+0x318/0x5d0
   process_scheduled_works+0x84b/0x17a0
   worker_thread+0xc10/0x11b0
   kthread+0x376/0x500
  Local variable ntf.i created at:
   nci_ntf_packet+0xbc2/0x3c30

Zero-initialise both on-stack notifications so the union reads back as
zero when no technology-specific parameters are present.

Fixes: 019c4fbaa790 ("NFC: Add NCI multiple targets support")
Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
v2: Drop the inaccurate activation_params / NFC_ATTR_TARGET_ATS scenario
    from the commit message. No code change; the ntf = {} fix is unchanged.

 net/nfc/nci/ntf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..274d9a4202c9 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -440,7 +440,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	const __u8 *data;
 	bool add_target = true;
 
@@ -688,7 +688,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 

base-commit: 02f144fbb4c86c360495d33debe307cb46a57f95
-- 
2.54.0

