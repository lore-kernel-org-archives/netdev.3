Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571937C911
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474061; cv=none; b=Mji3cVyqycBwHMFtRTsmkpkbiOecQvWIR2mdbzIaj1UISJ7SIoP+V1pADcdzVPE14Q1uQqAGiNvw4dA6jsIqZhEwbwQHn+2xUqbEqyKIlLcKHnTGz6o26ecOJGSL9slhRmXSHma6nrrkr6kOVObVtpXK6rFc7nm6zA9HBCnp76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474061; c=relaxed/simple;
	bh=/JvXuBex0ZIBNcLxHoUAVVIfmaYEO6HfA9TY6iBxRaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHUcB4H9p91Y5V58b2N39eEAUjbSKjAODQN9u9itn9e9hu4D3dS3Ok5NC+DoMAi3uyeln1XMDw01/nQaRPaTQprTzg8HXpb4woJ7HGfyYrZeGzdlEIMDplIxMpmzZ3Wh2wsMFpd5xIIblz7Xh+Y2DYNEtmzZir5vA1IN1KOCuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=CVO9Cr6w; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="CVO9Cr6w"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso159886a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786474059; x=1787078859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hLA5ZodlddzhKEWtmu3jxQzarE3WFFxZF4tW+C08MQ=;
        b=CVO9Cr6wgg70tB10+vp8zikAfuQZ6+Jtrtty/lKJBr7yFrCtfyYYGhs8AckKzrlWao
         aY9pvfDWyh28vNfVw0uWdV6VCLX+0iEbk39OJZGtzL9gfuswf73KhIDrPR21i3t1afNm
         pIuuQKiw3+FALwkCchKOHWb08oGMp0eQnRI9WGGcEGHpVzaYwLG4d3bmo59r7VoAr9ih
         IxBszSVYqIM4slXhYNNYpjx6qs5uLLLjtyeZ9DXuqCGeVs6XL6TId0w57nWKGNbrO1Be
         zmOglRNkmlaKC9+XiPg9v7Nldp+BmUDXC3BORrWEcM8pC3pU8gVsiudHzV0CziVdaPwW
         7zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474059; x=1787078859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4hLA5ZodlddzhKEWtmu3jxQzarE3WFFxZF4tW+C08MQ=;
        b=rFL8Z9o641ZpA1Zk/cVuiLzu+qEgrQHsoOwnoLJZDIcUT9IgNZsYXX9PDPuOGdGCsP
         HP1pCC+RRnAfR1SCGkMzXUofspQvpgZ4KvWb+bSU87cgOHWmsa/xtspt/VShp3S8v3sB
         jX3hbslYH0bOH9a1iec3DQNAPWCVE+35odN9Eiz9cNQnOzBhQnaxz3ABymMKlqolJMsT
         hu7FzivdbWXyvX5r7nb2cGCGgzaGeyVu4s9t9/xG7UQTgnoFcbOVWZNsooN6vunXGngN
         1OJJPf53D9HMX/+iQFDBfuZP4yzPWQDapB0m9O3ANq/GfURdANQpo2OiYsDtHBzbaAfz
         w+QA==
X-Gm-Message-State: AOJu0Yy+IkGBYSTg/5MzfwYTuJh0VzHsU6IAXOaiwZiGJCfiafL6RRG0
	JqZNomQ91a9+TaRN49DTq98GShfIm/dhCEiFP7eRGqGNBfM0XH72EO6WYoYK8vlLeOi3n8cWLhq
	866se
X-Gm-Gg: AR+sD13StTW9kQuUchy5oZNpYPMI7zPa24RGZBq86RXyeuKMIMkFgJyB+XJVj/EnGbz
	rd1GsSu/r1PmiZHoH/v4g+KSWhRhZUS7CJWFiR4gITO7R4xOlR53XQVepgpAvlnwwg3jzkk4f6U
	wPxBfo8d/zoWDUaz3Cf1OQU6NVNlnzphlhJy/n16tKQUa6nIC7Me59bqH3IZeD83MwDts/brl9U
	Eyfwd3MCU2aePCZ0+81J3SsURqgPXXRsumaoiFvJtv6TQd8OhZT3g4K0SamvLn/3mqX+PdXh9c/
	cFsUb4fBChBHxkY2fc8/zS7fxnC8sxK2EDZ5vsBi7kNWmQMjCIIMnl8vLc7PP6id3xOcrsKF/Jw
	FrUAvzIMCQcwrtTQxmOC3lrXYsQ8MXhb68JEINupp/xBlFjq5b9xDBgQaE6V6l0H03kCOXfgKfx
	Lq07SOkHFyzmQm4707/Wit3H7rc7q9r+i+pGeEPo787A==
X-Received: by 2002:a17:90a:fc45:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-392ec609a17mr5419566a91.13.1786474059381;
        Tue, 11 Aug 2026 11:47:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94adf39sm524365a91.11.2026.08.11.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:47:38 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch,
	willemb@google.com,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net/packet: Use copy_safe_from_sockptr to dedupe code
Date: Tue, 11 Aug 2026 11:47:20 -0700
Message-ID: <20260811184722.2612345-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811184722.2612345-1-joe@dama.to>
References: <20260811184722.2612345-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce code duplication by using copy_safe_from_sockptr instead of
repeated length checks followed by a copy.

Signed-off-by: Joe Damato <joe@dama.to>
---
 net/packet/af_packet.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ee60dcc639ad..9d326c2b04b3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3961,10 +3961,9 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 	{
 		int val;
 
-		if (optlen < sizeof(val))
-			return -EINVAL;
-		if (copy_from_sockptr(&val, optval, sizeof(val)))
-			return -EFAULT;
+		ret = copy_safe_from_sockptr(&val, sizeof(val), optval, optlen);
+		if (ret)
+			return ret;
 
 		packet_sock_flag_set(po, PACKET_SOCK_AUXDATA, val);
 		return 0;
@@ -3973,10 +3972,9 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 	{
 		int val;
 
-		if (optlen < sizeof(val))
-			return -EINVAL;
-		if (copy_from_sockptr(&val, optval, sizeof(val)))
-			return -EFAULT;
+		ret = copy_safe_from_sockptr(&val, sizeof(val), optval, optlen);
+		if (ret)
+			return ret;
 
 		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
@@ -3988,10 +3986,9 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 
 		if (sock->type != SOCK_RAW)
 			return -EINVAL;
-		if (optlen < sizeof(val))
-			return -EINVAL;
-		if (copy_from_sockptr(&val, optval, sizeof(val)))
-			return -EFAULT;
+		ret = copy_safe_from_sockptr(&val, sizeof(val), optval, optlen);
+		if (ret)
+			return ret;
 
 		if (optname == PACKET_VNET_HDR_SZ) {
 			if (val && val != sizeof(struct virtio_net_hdr) &&
-- 
2.53.0-Meta

