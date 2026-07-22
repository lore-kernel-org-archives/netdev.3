Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DA3E557D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711422; cv=none; b=ETfQgkPMAD9Ybe6NaF0D+vjcMnJ7lC/W3qgUyfUxNS+3LmKvzaWixvSADKs25zpIUH8KsHlvjwizc0Gg3+zgdOAu7FM5ClzKlw03yJDfJO+2SnxFdWGuYlk4runbaXzFkX72XnygQW+8t+HJqXQnlGK08BBmvIa9Oh/OeNstJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711422; c=relaxed/simple;
	bh=GCaSfTxYhIVhXVN/pYobjhk2blhEMEHesKJ+mWBsncU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdfUSonLn3N3TdpgK9Gp0e40u5kp8bjwXSrUsgnvDE2hCzkW/M42YgPJWYQzhFF0U/i/GruMDM2CKwTKRfwxuFymzYwhp6TdBO/NafX/+b8CPqd41v6Xgywx3TXvMwQgSninpyljjmMQoohCuP1u3OoeoYtTZaBJaPdJFw1bW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTexLXE2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTexLXE2"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2249319f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784711419; x=1785316219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obdd0SmjDbePrgaCTtUb1ov2QIwtkiLcmDHoVSpucnk=;
        b=iTexLXE2MlIcmbRqE/EyMo6kf3JnBJgmAV9d/K9DjnbcOQNuGhussqTdO8ONANWvQ1
         9BbmVM8BW120yhL6KQa0UE8M6p67eRsOJhOPOBs8FUspuZTTEaz2LXcGX0ubuCSu3wvg
         hFQF0f2oaNbvOt5rslDC8Sg9bNOmhoP5SI0Bwfq3YB5YMbSMzOIV8JWOWSAMRHBihnNz
         /v0Y25yS2ixDM0YW+kQkopzplw1y4RWzGKJ64X5Kp7SP8k1kC8F2lz4f3Ebrf3Jkoldd
         KFxFdZZW6YonVhL8RZHLy82PiGzMAENtPDaoiMhmbp31flC9XosF7q58bVBUo0RFFhyz
         YAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711419; x=1785316219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obdd0SmjDbePrgaCTtUb1ov2QIwtkiLcmDHoVSpucnk=;
        b=i9Fq1/mXQcq4GID0TSb5jB7RUWWGYRL+HRyUf+XAj4JtgtrDM4UHBCbbmMQOjckPxH
         GM0LAXu7YRsD5IZbqfa0PthVQ3rfSvVS4ezk2WYifIgkjQkFJC+kWQlR8XlNwmr+Gi6A
         FFsQKHvzOwjnCWUsdTrl8Y1PRQMAGH2gRxjXwVjBusxT1pdBWXt9MUTVN4OlI1B1frlJ
         lyQaAQ+SpepI8dpHwf9Kv5wa+MA/WPOwha+BuEVZyQUiDFAEAvh9SOgVIaN4hSNWnCHY
         USgXo1jxYALRdfQVJngAjQOU662SJS4H4gCeq0F6hu1tfhOCs2C92xv0edO2ZPGaVOk7
         XvEA==
X-Gm-Message-State: AOJu0Yz6uEN3Y0pBjPazmbFNEGwDZZJvAKJvGeelBPl4aZf7FBVXtXe0
	VPFBv1RCMMjKME9ALJcc7P+yTpn7sk1+4tSqY9h7Pa2sVgczRw7MjTMK
X-Gm-Gg: AR+sD11BdYceVf97igga7OhoaHdrpB5Wao4hSAlo2uHUp2yQyMpfAGWrGblB4lJJxcS
	3EmTpg36xdOieXSjRq8iB3useTOcX1AKKWpw8iySXlDPVNVrl0uFZEU7g1vJ4DlfC23UXp5ONST
	/wXJs1DYmwJVndtvgpYqwhyZLHq3KYuy+BJzRIO+l1Y+6fe8Hhofii7PAQwHQ0PBEVMjWO4C8uI
	fJDfT9VzYgE3HQI8OL6e8UGCn9KDLClgKf7M/H6CX/O5sGy+yNWNcQ397AZenEqNfRjhEfb9R3P
	TrGvmuLNHaU4SCTyt2oa9JplZ9la9NBwacM4h45Tz3eWSHeCP2a5qw9za4fqarGRKYv5UII1uGv
	dcdgxCAvFgLSldgJprV4US4NtvXzUWwb/abYzqWXMtmQvrZb4gWndqtFVi9E4O+9dQFdZNt6diy
	gVqONbqFgO0o0C6Thigd34/RqCbyCNlAUb
X-Received: by 2002:a05:6000:480d:b0:47f:77dc:aaa2 with SMTP id ffacd0b85a97d-47f77dcac77mr16194164f8f.45.1784711418687;
        Wed, 22 Jul 2026 02:10:18 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com ([2a01:7d0:4800:7:bc9c:3808:e25e:32ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm4406792f8f.9.2026.07.22.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:10:18 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net-next v2 1/2] net: wwan: add minimalistic IOCTls support also to QCDM port
Date: Wed, 22 Jul 2026 11:04:50 +0200
Message-ID: <20260722090931.2637025-2-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722090931.2637025-1-dnlplm@gmail.com>
References: <20260722090931.2637025-1-dnlplm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream libqcdm requires IOCTLs support to work, so add the current
AT minimalistic support also to the QCDM port.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ccce2ad74128..8168239e52c3 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1046,7 +1046,8 @@ static long wwan_port_fops_ioctl(struct file *filp, unsigned int cmd,
 	struct wwan_port *port = filp->private_data;
 	int res;
 
-	if (port->type == WWAN_PORT_AT) {	/* AT port specific IOCTLs */
+	if (port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM) {
+		/* AT and QCDM port specific IOCTLs */
 		res = wwan_port_fops_at_ioctl(port, cmd, arg);
 		if (res != -ENOIOCTLCMD)
 			return res;
-- 
2.43.0

