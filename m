Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAF4A5C45
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057343; cv=none; b=mJCYIhtDWXFRxMXVsjST5Z5G0cDCmU9HR+eAbNouyHhPqHP9e/MRFYonxqJKcNM+e0QtXBp2v4GgQ0jGROIcIVVvQcNea7s2Y/io0uXzNqD21hTfvNOK+6+/cchA+Vi+NJgz65BmGbUNfJ/0m4UHTj+i5rdxy9PP+XhzzUcxAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057343; c=relaxed/simple;
	bh=rWTCDK7Lu98+d3mkrV0MN4YOesMUBm1C1YFvlmoJwjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWq1cgMBFB647053h0ZGNWtM18iemSdvofGRARlbmcFNuNKXzRFcMtJU7EvQYn9HF6NhoOebrIwsDtUfqQ3kU2RDCVT2x/9FL+mYw6CFA0ZIYM0QB1AuFQR5HiBt7VVNgU4R9C5NX6fVQB9xaRRiuMZ44wKpup6ta5/e58S4ZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DtP/wcVA; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DtP/wcVA"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so21730255e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790057340; x=1790662140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=DtP/wcVAPzfupgMGCAVSLOqpKrccrIRzyO4sqjslSo1I+Nn9imKm0WGRcVnCPAHTr3
         Jqz1Z2HOTJdj0evHi7YB3l+lbZf18q40sw3+QFd4Wluyt57VWZf6b0wpcfI+2mYPTQEo
         0JPx9jGOvx04uLIzSHqyd4NPmcdqeyxlXNiQoCotZdigxIYt/XzCYzgcz9Xg5qwygg0P
         /TByFaXSt8/+3M4uQGN0l5KYEYFeofYW/kOuTRMtue1s5C3W8jzVYF9duJQMwtFlUXlR
         GsUWBq48D2YywS1eaI868KyBI1bWUlZVY/PJJa0LhaaRKF1P8wDiVtjbP+sZrNFTsVRY
         QNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057340; x=1790662140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=fMkM3kS/eFQusGbeh9nzlBj3oacJ3Rk3eMknEOfi57rGme1ZRubY2rColqV+GiEKvY
         MUUl27+PcuWgANXho73nujTLkh3ocAU+hahQDnzHou3yF9k7saE2x7bulA+Kv1YLo+Em
         DvFsa4yni33NNMjardGmq+98FrGBCEfSub/upvV3hb8PJvryzvNj0VLgLSXhHaodREFV
         opD3vMitHNX32u/znk0hXajH5MkQiqet9ObyZmXQds0T6CT38RZuBLFVnokTOn3nZLp5
         w3T+WdUK2oh0A8FLKoKp+1pdls+a+y0vBTj+AraM524+gy1euz0T/1I5jx1oi3EG6gIu
         wr5Q==
X-Gm-Message-State: AFuF++ksc9wmc/NI7LYDAUCuQk3Tk63K86SgWAQWxgsg7uosOtjufdSk
	AOHy7Pi/tDfxVpBaDoZmUGVwRuAx78jTxUc77+1z5KsrJrx7vvSyj51dkMN37Vb4gVuf9GZPcRA
	z9k3UZ7kK4buuM22BZr1W2us23fwM8bT/Fb115hcL7ZqpG59/VBpvt9g9H1augNftUUI=
X-Gm-Gg: AYBFou2+f9AbGH3e6wbiwXaoRWTQpkNfKHY+xmqY8r6p+EUm5B76rctiJaIFk91qNm5
	A/isSrFn0onQAnEwYFMgdkiUMmusZqWzOz4kDuWkK0vjhoVjfQN+vaTYYs4/MtdFdV+qhBbOCmp
	Lz9XHibwmvsxp/QXIgCg5NIXAYtW98a+CCKkgHJ2KtrwpLMihCSU0x3lSg+3YIdkFp/ywQdMPq2
	oS4f1YI+V2I+jYjQ8TYQCQSG6hazL23VWEAl0D3x+S20GXe9BOMsttB8Rpf1SESIRE4KQ4WQgOw
	9Z7R07zFN6FcGkmbGL8qHsVrSmhM1a4OPzm/4f60+luiAFxdllvjCSq2gvbWzva1z5TyESewzoo
	TD9CxKK9qKHiDGGLCKtpWpzUWOD5vpJtG3H6Av3HkX4Nh7BhcOgzcn80RnAjrWclCoZ5noyhxFi
	o0ZsvC+G+nbt1+/2Lingew03B44IL5LStBVnXsZP16l8dpJIP6N+YTulOZOq8dRV0iNYUiltARS
	aWL03hCKTSlM80tpZwV5A==
X-Received: by 2002:a05:600c:c490:b0:49d:2555:1a6d with SMTP id 5b1f17b1804b1-49fc573e8b8mr214910815e9.16.1790057339851;
        Mon, 21 Sep 2026 23:08:59 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad6306esm25814125e9.15.2026.09.21.23.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:08:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/5] ovpn: remove unused work field from struct ovpn_socket
Date: Tue, 22 Sep 2026 08:08:48 +0200
Message-ID: <20260922060852.2266148-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060852.2266148-1-antonio@openvpn.net>
References: <20260922060852.2266148-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

work in struct ovpn_socket was introduced but never used.

Remove it.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 4afcec71040d..5c87392ecd30 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -24,7 +24,6 @@ struct ovpn_peer;
  * @peer: unique peer transmitting over this socket (TCP only)
  * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
- * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
 struct ovpn_socket {
@@ -38,7 +37,6 @@ struct ovpn_socket {
 
 	struct sock *sk;
 	struct kref refcount;
-	struct work_struct work;
 	struct work_struct tcp_tx_work;
 };
 
-- 
2.55.0

