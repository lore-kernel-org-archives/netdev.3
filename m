Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D85376A05
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812307; cv=none; b=dch/yplH+uH2bnzlgEkdMDHlY9KHn3o518Djs8WiWORV1OKPCCYdjA8etif16Vzw7EOEmqV9KxQOeUQhn9rZwNs/HgVNd0QLHg5x2pfmoJiepHAAS6r5Gu1wsQy0L160jlJGt0mp5vfJiyOps5gqzajuW7Q1OxNXzHjET7WkvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812307; c=relaxed/simple;
	bh=RyTbIUwgIhratEqKyhdKRhnC/iuNyNVHTYlEaVCfjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN6d+ndABPoYrQRF9hUqLfWfbFwHT9Ho7uJHFeVLmNkAnXsKiRzEDSgHlAJHW+HBpIzcmG4iY2Ak9a5MvqVyZWEI/JtF0+h9Kgj7TPeyHrOYQMpml2Ny1oy+ge7UKud5XykNZFAHkYp3m6NA3YKJtIRM+39ta5M40ZKTtd3sEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RX0jxI+O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RX0jxI+O"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so14789485e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812304; x=1792417104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=RX0jxI+Oq29G+y/mXpty3IxWXKeQ3zIEB3MscK6g7ZSZtflJxWm2KSvO/llYgDBA54
         n2RosFCk2aiMnUrxNgvyztus1f6F08oaL+1/M5mN2E9N8+VptzeK7mye1HpRxujzLncL
         Y0z9IpEZTGPD4ZWegBPorflODKlBYtaWx1btrjy8m0D2gF1WB5s2KYDJk+/uXrfxLB7g
         cAxjSeDCJqYVMIRFjQ7j7w+QuxTECQwWBXAnjAkN1/uVFQY1zFzr1+RBpeilfQYcd1Fn
         DkZpbLE27GMW9O7bpWw5WV6LGOsRHwRvuGPkouBqC/OSM7ygMAbv1uvwm6W6nrJ3PrMi
         20ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812304; x=1792417104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=r8YMEZ/dYIwGBNRC/0XymRjgMHSIK25xtd8laDvSD9qSq/zRhEtKJZf8dpINQtRGZ5
         XflxE5Ckylpw8r9Mlnwp18sSV92qd2INeYRNz00OJquhzVe34QzN1P1+M2yZcoQWESqV
         llqfVLqdH0CCvNrRrE+1t09AJgqre5q7F1CyZknfqlQ6nzPYNGB1PML65uxNDdPADKx4
         2Og5BhoBcOiULuLDVBDbqrtJuab8CJPhFXKO2K8d26IeUA7VsOViSccOi7rpSMEbsPTD
         wY/HLsMpx+vGcl7fceUwrKyUOz40UFhUyeaqlmtFVA9YLYgN8GtQfwX/rHPjNdneD1LY
         EwBg==
X-Gm-Message-State: AFq9FYLKauvqiRxuvnmFKNTBlfVuZg7fo73CMTpqwBxp1Pk82Bj/eGfV
	t7rOyP/Wy9t8hseYCfQoeFW5rpgAII/cwIqOYO9FSqI/ZVemvT1bLIW7Gj2Q1PPOCl1MfXrPED4
	IAx5Vzej2xta4v4oWeNX6rR89MJ4SPn2dmkUKePsd8Vo0INliP7FkLfBg2dIW2i1y8KE=
X-Gm-Gg: AYBFou0IUPIrGiepuotA+Erm9BYYlWu+1ruljfVX3x545jG4jE6e8CA2PWsX5uHraKn
	R1cx6WNuZFvvLpQOaBK8U8aF0BNAGhjSuVqGYnv1/QjRx/j3ISpVQ/r942PEfu1B0p+5+SavaF5
	jOItw93IGsBNkciVo+YGFd6AispjXqGB/yP7O50+UuEcHfNXhcNwT3qLcVga+8g5N7chm0I1bes
	fTuhikJXnXXIfLATZxzq4XXuu4tmKWHm/J7tDfPewAF9RfOOktMWMjVnKvBoHk2ZeIjGdTHjuuk
	zDQ+wB3cHPBCur5kQyyzwIzvDBkA5e+7gJGHSIHn3E9GGRe8t2qcGy2XHco+2CwGNGgoeIMEJgo
	KKVWVUWZYSX6OpZx2hXT8KPWbj90ZzAb+WuhX3bw62HQdB2DTpJ5pl2cO0/hIkzcaGxLM6Q4Hpp
	bGmDwDgemUFL/wWszi+hcqzsqikPvasX3LAoeqqeCxwc+f4QejTzA30CJ+Z69tZXatnS3nqZO12
	ow8cDqh0IA=
X-Received: by 2002:a05:600c:4689:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a18e4a9b31mr199942985e9.12.1791812303520;
        Mon, 12 Oct 2026 06:38:23 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:23 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 1/6] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
Date: Mon, 12 Oct 2026 15:37:58 +0200
Message-ID: <20261012133809.2477063-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012133809.2477063-1-antonio@openvpn.net>
References: <20261012133809.2477063-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

ovpn_bind_from_sockaddr() returns an ERR_PTR() on failure, never NULL,
but its kernel-doc says "NULL otherwise". Say ERR_PTR().

The wrong text came in with commit 80747caef33d ("ovpn: introduce the
ovpn_peer object").

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index e42b60cd04a9..62a5ccfd3502 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -18,7 +18,7 @@
  * ovpn_bind_from_sockaddr - retrieve binding matching sockaddr
  * @ss: the sockaddr to match
  *
- * Return: the bind matching the passed sockaddr if found, NULL otherwise
+ * Return: the new bind for the passed sockaddr, an ERR_PTR() on failure
  */
 struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
 {
-- 
2.55.0

