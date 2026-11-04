Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826490;
	b=5BZOjEqHuT/fiZuscx8Z4UIUQstxzmterG7YTggrwEWJDg6th9ZGCdbL8O9gwCTlO9AA
	 O7iWZbUckjzb/sZA4/tQQsWaeUINtiSBtwSS4TciXNaO97xZw5n2nVAEQnDkXJoV8Skmt
	 cUhcnPNSW9SVBVxz6XufMocyvK+hiOGVxLTJnvcMcPLH/YU18xeBT+3lqU0/9Kc08JcBC
	 zneLQsHXcqca8heUgHPiWIcRuSpD3fgOzAHC7td0FEJvv1iDaza5W/iyewgosPdO76ndP
	 8q0KZtS5M9+Tnz54fjbImUSTilw8NIBp0RQmjhEsQ30rzEsY5+Spj+ZrudFh8Puvm/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Y8qWnA/XmAlfjtprcp6tcR5z0T7mWT+PwVA00bdqP8=;
	b=wqKKwAN8G1rRMfQjW07B/PhK2No/PXpdkndm1aOrU/0mJEQ9ew1DnnPp3Gn3aY0oFMWy
	 ubhgbCnTQoJ0/mTrHNkHC8NnwEXzmuPsk9NEk7cgww+FhM2e1kmh9bn1hX5QYTnNr++mM
	 81Z2mowzGrG09I7o72XG2JfJ69Z8tSSVP+4GQds1XfTWhUbBZ6jaCUvicdwq9/UV3dHHs
	 4ZTQr8JwmW4HYnTik8xkRHoX/pCv1rQlOMngozlPmOC+Mwy1jyP03MLACOB6qkm0Fsqoc
	 dTqOGNzfnABLoTkgHV09mTvNO8EFwLMxqaCmRMrLvu2d+rXd4mYZ9t9bN3gjIMmGE4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4PPbsuB;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B216078C51
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B216078C51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4PPbsuB
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so11968195e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826488; x=1794431288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Y8qWnA/XmAlfjtprcp6tcR5z0T7mWT+PwVA00bdqP8=;
        b=L4PPbsuBhCFjHCDiUwis6U/wTp2fygq7mcsIfB2m6uI0ZpTPDnY60ypdhmtXA+YU8s
         074fr5TN4B1vw21UPfA4n9Rdrc1JxcnFgVohyK7aL2sz25s1CsYueaQX3X8mVn2jm7VA
         dOVb3GHJReS6+e6+ZxXqPMYHF53NfgmG4eWoVjECXceRA1tiWui8epSLaeFH7k/rdED8
         vLK7libtZCsBta4r2es3E8DYxtzFiLSzA6gj7xac8L7z/1mXtjRlY6eIrCwsiUxwJzgv
         sDxtgprtdqIzlsR/sE5CLDc39jHUY/Ybj0uIg4pzlUrbhBqphKEumrZnOOmZGWt28eva
         qigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826488; x=1794431288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Y8qWnA/XmAlfjtprcp6tcR5z0T7mWT+PwVA00bdqP8=;
        b=0nVeSBSYoVQZ4Lqf6d0n7SGUBYVCakSaNkXKfTTGTTHcqCPqLwO9IrhOQ/aDYYucZr
         tPag0j2r6j6iN27Mx3v/LIjZoESGqYhL3PVDjepBNUTt0u5NarDUUU8iNWRmcoLCuhbJ
         qGF8Rq6a3W6UsZFz6oyLMSQ7Cco1if+lRVl04Yki639jLeiwQyDM9+4lANBdJq5CbytQ
         wIL1sxgOwmkNIXYyMIR57RHRTj2wMwvkwJElboOEyd3gRrstuYYhOPyRTEsXURL8+Cy5
         06JNP3Ev8QU0AQ71BYVl1SqM8acgkDtipOOlL4nrmK4c716K5EZ9v7mLKCtgs/vxzGFu
         RGmg==
X-Forwarded-Encrypted: i=1; AKwUvBwR5aGGfV7JjxcABRIWGzyWsSlJbocHuPUAzz2pTLDbIPYw7Sv609+XGknoSJpPWWLbs3Qw5OU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+50vLGqmKahkfc62JI0CELEHYYCZC79UZIoT+l7ZfXCrw/wzQ
	qLRhpUpmKy+i0a2lvmzpCV6jdoCozT55QCYHO7dxXXtVUAnZzkbsyAr7
X-Gm-Gg: AYBFou3TsNlsZQkRV6sj8uyEXfPAstiX7GcYUJW7e1GI1Tz9rMPuq+Mc0bTzxiLrXcu
	iwMBgHgzeC2vgtKPl0cO5PWp2zbs+YZIdaGPEFfeFgxESZ1fsKUP7Bh7dieL10UE8qva4WgdSDW
	lZ4gqzHSX4CnIRizP98rRZ8rHSptb3LpmwuVrXLZ9gL6kXqdXhPseXuYZSCJzXRvHFUMcVAmmfL
	wTwvx/66VzWd1CQZFwhAvdscYl6r0WkFTESkM5u7Rrbds0+SmfxlI1jtQoRZvp0cVp9ut8H2Oiz
	+iGOi2okJ6SLCAr1kZpC/bLAWILhR1BaLQsebZxlprcWi/+NM5UrugBrAzZznSbcoKderZU0bC2
	sdBHDTLafSrmR81U7xqFyOxcZ8sZabTSRXsumSVu3fbPt6Bjn+Z6mjJRfdlOlpiHa2+E4N2hOHn
	hlkPQpKVaVOXzeVQ9yKgO5ySJcZU56K9OTPGFG12q8Q7FTs0wbxcU4gI7sB0nlGkUo2Keym364v
	rAU0l/Pe+VHTJb4pkSP77oE9o9W45LIFQF38IvktCMyg9WiTrS0gLJ9dZZ+vkNcNW3sQrNiGRcY
	HqP++8yvQOUSGPP6CD1b3dPItPF2LKwehGvEvC2W83H2KMFvB3emm3gmpD31Sj4rIkLNAlgr7Q=
	=
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id 5b1f17b1804b1-4ac1899378bmr367364305e9.17.1793826488399;
        Wed, 04 Nov 2026 13:08:08 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c23:788d:6769:d03c:c916:2aca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm11998855e9.1.2026.11.04.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:07 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: dsa: qca8k: check the length of MIB autocast frames
Date: Wed,  4 Nov 2026 22:07:56 +0100
Message-ID: <20261104210757.467964-4-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104210757.467964-1-kuncy7@gmail.com>
References: <20261104210757.467964-1-kuncy7@gmail.com>
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

qca_tag_rcv() makes only the 2 byte tag linear before it hands a MIB
frame to qca8k_mib_autocast_handler(). The handler then reads the
counters that follow the Ethernet header, up to 164 bytes on QCA833x,
straight from skb->data, without checking the frame length. A short or
non-linear frame makes it read past the packet data.

Pull the counters into the linear area before reading them. A frame
that is too short is left uncounted, so the request times out and
the caller reads the counters from the registers instead.

An LLM assistant (Claude, claude-fable-5-1) helped write the change
and this description; I reviewed both and built them with W=1 on
arm64.

Fixes: 5c957c7ca78c ("net: dsa: qca8k: add support for mib autocast in Ethernet packet")
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 86b20bbc43..bc77dd45b6 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1669,6 +1669,7 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 	struct qca8k_priv *priv = ds->priv;
 	const struct qca8k_mib_desc *mib;
 	struct mib_ethhdr *mib_ethhdr;
+	unsigned int len = 0;
 	__le32 *data2;
 	u8 port;
 	int i;
@@ -1691,6 +1692,16 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 	if (port != mib_eth_data->req_port)
 		goto exit;
 
+	/* Past the first 3, the counters follow the header. Leave a short
+	 * frame uncounted, so that the request times out and the caller
+	 * reads the registers instead.
+	 */
+	for (i = 3; i < priv->info->mib_count; i++)
+		len += ar8327_mib[i].size * sizeof(u32);
+	if (!pskb_may_pull(skb, len))
+		goto unlock;
+
+	mib_ethhdr = (struct mib_ethhdr *)skb_mac_header(skb);
 	data2 = (__le32 *)skb->data;
 
 	for (i = 0; i < priv->info->mib_count; i++) {
-- 
2.43.0

