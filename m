Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADF38E8DB
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145723; cv=none; b=F/jW3qiE1HE3DOgF3CUWV3qj61jV439Z9HnwEar7F7ratWhLCvY4BEXEMo+xWHA24syDxaME9dAFURiX5uW3AHJSj1e747p4C7ICJgVGnMTef9quun4ldMrczhcsdMI83K8SmeJ1lSF0tm+DotVubFyLXjqqnBjfmQF96jUykYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145723; c=relaxed/simple;
	bh=t9a5ssxdpXDVyO9sUclJsBFNl0rY6QGQUgOZ+6cTNJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AlMS3NMYEjk7TTwwDFovVuLNNd22ZKhMY82kcchCY2EkU+5EIYILPQTkHh12RvcbxkP+37kXwt1HqyGwuDXeLCWPhlZRdAxSrLmDJIxvDOrAm9vUyc008KfcL3pkkm4RdZSAWN9uGph7D6oSmpy2EOR2I6C0SAnTv5fZi3bADmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRb8dT1i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRb8dT1i"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9d265355so917752a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783145720; x=1783750520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fx1WqksvuISZjKB8qjiAsted/XID7FOi3iV53rUECy4=;
        b=fRb8dT1isvDxRHNuLyjJl3Yw0Xfemr6i74eotmBAgki2dC9ug/++JpTmiDvkGYVZAm
         UZsszdc3e9acoZr8zK3sUXvMEiny3N0uPf9QF2ZSedZsvCbxM0l42+uLv3RqnVnqwc+2
         IDIKdJLVEJN2INwvjgSMI3THGfbVbvOl6SEuHfm1cHil7CRG1W4w+oh1je76pdZ+51zD
         eyJ6UCGZLyS4D7MVZ/WsuyiEpSIoY9AyACuwjPergHSJdtv9TjEs21pRyYm5viDFVxoa
         4YhLQ/W6OOoIilEVuWcAUPKu/DsxIRPYS9xg2j2xws2SrU7PCUMxYcJJ9wHfhVEzutDC
         6Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783145720; x=1783750520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fx1WqksvuISZjKB8qjiAsted/XID7FOi3iV53rUECy4=;
        b=ZCptDeIRhNxGH62zy/VWzqh7JziwYotndhf08/ohpT2KoUPM9rz6mTE9K8Wdgfnd6a
         IAt8k5ErHUvuZmykeXXk6mkFlT1g9KcCuCf7NJQpCHR/gGQfQ7gjCEM0dVhxqLzTwB9h
         e2r5/mYB9GXgkg7WhXZHqE/C2JycEQMJ5r8wuAYsDKagCbOTm4CSbwTduIychWc1NIC8
         /+MoVfaRoLeDWDHLEmwU2JS6OHfU+IjYL2ZPM86xK+6y5kmWqTvD6A9x2Ax4TQJZKBxX
         KN5SG07DvRk0+5tjXsIgMz2fQVJsWjUn/mkIlupAn3ReyAwCp5cNq4MgL+ZSTBzixsN3
         lESA==
X-Forwarded-Encrypted: i=1; AHgh+RqSaSgGfPVzqssP8x7OIxjA1e3rSd0faEXlqQ+cgLC1EaJAd82TJOTDQr8hUfYq7ikLlWXetxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvV0VGOM0BTqju3D2DYAsKYlyjWOzkiIJ/DystAmo+/Tmdx4i
	wqDoLZz3hr65IvEDeJhaH4m5kdHoLf99J612+xGF5FhoU32ozEHR48nB
X-Gm-Gg: AfdE7cl6iYerLfqGlWx44FiyGLEsgtkUtGNsw1s5G9IvzVHHtqeSOe7IlP+Jv3LSc1k
	l83dZsbfrfMNrk50i6akFGNMFkJaz+kbusVaSXlIUIEzpQmMlv6nNEq65Dktsd9QoxKUPtkpipJ
	rQ/25wPaxVit3Mc5GUviJ7DsQNu1ptqC3WR9zWXkakrGr2V9QxU2vhYRHklDm25ggEOQFAopbim
	CS0lMQaRTVyaUL8X2vUwTrxSpYJZHDxgabq9jvn18y5y1VgweX6AUlcoD5W4+vE60cWCQl3rMmF
	DQnccyPbFZbG8sryyLX9LVz/+GkFFYIUrkKp9Ee+rcfcThoPDoG8cN3UroctqSS27SE1BGQ9raP
	aDPyewZtaqMCAF/UAZ/qeeljUhAOJGCQHyGUQRR9xQZNXMkxs4lwTV3x4KZfBGOc075bXDnLgjY
	Pb0C18S0yJuBu+hnAX/vGFPiH7kKH1OcAjAVGoTg==
X-Received: by 2002:a17:90b:3a50:b0:381:149:cf91 with SMTP id 98e67ed59e1d1-3829f2f84b2mr2256768a91.26.1783145720262;
        Fri, 03 Jul 2026 23:15:20 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae6e2bsm1983825a91.2.2026.07.03.23.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:15:19 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] octeon_ep: fix skb frags overflow in the RX path
Date: Sat,  4 Jul 2026 14:15:10 +0800
Message-Id: <20260704061511.2350737-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
References: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
one fragment per buffer_size chunk:

	data_len = buff_info->len - oq->max_single_buffer_size;
	while (data_len) {
		...
		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
				buff_info->len, buff_info->len);
		...
	}

buff_info->len comes from the device response header
(be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
about 3776 on 4K pages, so a full packet yields about 18 fragments. That
is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
writes past shinfo->frags[].

The fragment count is now checked before build_skb(). A packet that needs
more fragments than the skb can hold is dropped. octep_oq_drop_rx()
consumes its descriptors like the build_skb failure path. The same class
was fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path").

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index e6ebc7e44a..bdbed58c7b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 
+		if (buff_info->len > oq->max_single_buffer_size) {
+			u16 data_len = buff_info->len - oq->max_single_buffer_size;
+
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
+				continue;
+			}
+		}
+
 		skb = build_skb((void *)resp_hw, PAGE_SIZE);
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
-- 
2.34.1

