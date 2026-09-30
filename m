Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC94052A6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807154; cv=none; b=IydhRFLzjeW12q8qGpJY5QO8ibgoW6TfCYSfFnH3ZLKmJDg28/19UP8zGYg4HEWrNB/KL2xdABZnGb4k2Y0i3PFYbrY7l+lTTvz18GnP7yxc9Bmi+P7dQeJ47i9qwVLbLyNNj1mmAwMxPMRKP/io0gtp2Ogspr+dZHA96pK85/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807154; c=relaxed/simple;
	bh=RyTbIUwgIhratEqKyhdKRhnC/iuNyNVHTYlEaVCfjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc5fnHDhbpgC0LDm/X9csYo3yNAveB4ATq75O5ysAa03WNVowm077Bgl4rn6XXFyhlf57quxw522g9hc/fSZddBfzmhvmx21+UywT9hagJ5qKN8H5juJ8yznUMVLbUHfglVVBVWcUzel9bOgI+yh9V1f1SwdvKNKnJmzzIsCuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ww+k6kbK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ww+k6kbK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so32086705e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807150; x=1791411950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=Ww+k6kbK3lMUb/pkwNnApY3bdPNq+pYukTFqUf8h87JUi1BxxLGyJIBOnUGbipBlgD
         0dtWVE1Ner8wcSoZPTZZs7pj78jj89vmnIHgWlF2UYwV3fWS2Z5K/QyzTU6d7V/YBQ+J
         bkX9LbHtQj1FQI/GYKC27oyemy5y6DG51pP+XCJmGVzU44+6Yu6R9uNk7ynzJFD1DdPq
         XL6amELFgsHk7e9zeyg5D8py7MjAGZGmxq8PWn5jWToskfM3UOOyNfOgyfw/NlFCPDNa
         0o4OTzhOkQfbnivjBmRo3Vmus0Ps8YWPUblj62AZHe+6cK7ISc2unQhcbDoegV8FcAMr
         pMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807150; x=1791411950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=FXxK/ulajNV2L2K4PxX9F+MX2hYQEbbIw+IYxkbnk2BpXlIg5k9B4Bx8m4OUznQanO
         8wt5vBYFKbXmv/rKalSJPRImWZRJHuDLS6MWC5GJ0xqXJ8xasmtaD66WN9AKKLckJB+3
         BKGhFrW4XAOCN0VcMsyhx64c8Yttdh+C7Cjt8Ur8LHc/w3U/lOM5whdqrbnqMojgenEV
         9TlVAkzC1tUEDQNg4iMVFwkccmX7ZUUkSWhJvlSdgqqmZ19Yjxp+EsZp0u56jo9xeGYa
         g0LAQYkvbEY7VjkjMG5/5hOnOSO1oThpeMzF/FfIiEmzwtolFaQrpLfDIBKkgcLcxihQ
         TFcg==
X-Gm-Message-State: AFuF++niPyIXMcbp3ZPRRRCKPiRZLRBd8jNqEgIQx6I7xfjYst+ghal9
	/SncbrhmmT++BQ5/YWNa2uh6KijqsdtKEmeIDCOJrfBON7rszPVrVY3pTdVetSs7KPYSzFE/SW7
	3Ed3YZWzC0BJMzcnX5m6RTnwjOqbp9kpbFuPFSclWsEyHXwj+OahvRaNuf0ivziHptZI=
X-Gm-Gg: AYBFou0d0CWpGfy0NeDOnsk3mKMB6kMqy0bvYp/DluV9UdYcnDjKWAVD4PX7KzTsELh
	c9RVIF/uMUb3ZNhcruRLvl89PlXUNtLFppXdYi46sMK5oQXvv780azzYFyTePlm5+meQjidLxgk
	CiAjf0vV+MnvAuS3qshV6V4lObvgG6xNYwPlulhkLSJ53Mm4TuNWjs3YFCGXzJD0hcXI+g7Sv3c
	uFUMZMOfhJI+2qYqkFKaIegrBM1kAePGZh6vcKG34wXWa/6BxXXhLeT05xWEi+D/X9FL4+5Xszy
	irmLW/HuKPVpyL6QNYENh4UWSaS2TFchFxQeMUqIaPo9LXQDU9hezQLlprn7T2/j66gUpZmfeq8
	wvGgfDk0P9JSNy+lbX4Hr4kDeqTmiUmmm6dhDVCKIdnqVTmnjZK5FIuz8kppi/6aN04fQA4mLl/
	Lf/v6WHLMxIsqokAXXFB0dj7FSIaEyylDblfILrL0AUV8RydAf35bFewnP/vQ1DX0VsrPf9t36r
	9LHHNKLcS9CvVvpvTBB0w==
X-Received: by 2002:a05:600c:4fd5:b0:49f:fed0:fc47 with SMTP id 5b1f17b1804b1-4a01ad90a51mr45819795e9.1.1790807150188;
        Wed, 30 Sep 2026 15:25:50 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:25:49 -0700 (PDT)
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
Subject: [PATCH net-next 1/7] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
Date: Thu,  1 Oct 2026 00:25:35 +0200
Message-ID: <20260930222542.3839327-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930222542.3839327-1-antonio@openvpn.net>
References: <20260930222542.3839327-1-antonio@openvpn.net>
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

