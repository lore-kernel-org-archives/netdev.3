Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E843B9956
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735775; cv=none; b=sNJ9y20dmxtRj+yf3etH9RkOBKvyjlpX+AxN/95rOKuYiW8TyWCyogx8WVGuDKlTqz8kzyPejL1TmVdclICyOftE09NOUUN0Z8vBvPj5x9WFgPHMkbShyiqO9OnOZXZ/zVBRdRS8N8GpUGszawhlyckq5KBLrxCHzrNGmY+dQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735775; c=relaxed/simple;
	bh=EnBn/4jGc6fz/BczIiYdHjSaoMWGvEFwgnzOS2Bp7kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcJTj3G4Hb24/ZfzBz3GaM256so818nMQ/gdIEK+oRggVtPOKZmEGPFufOQFH9IbsVpsk9S9+JIi263Dc85UP5JcreOo4ByrVY3xVTNoRzWljJkB1RklRDgPzk2qfLQoXO+nIu0hNaCJC+kuzk1cq+aqT80webIF7EQ5Zt4Fb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEHeMVEa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEHeMVEa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495773ee3edso1077345e9.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735769; x=1787340569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REPk3sv6pnIpoq+hx39FYxJfdGolBo9DSKR94k2Jioc=;
        b=UEHeMVEa0QQ9/VnQ7o6LCb6zu23AUblHtBgbdbhlmSnFcgsPnOy5Yq8pXwcsV/+fN0
         yEBpKxKwkU1rhIVhpLUrnRvIXotoVnIewNi3yE579lcgNxJZT1xtihluEEN4oM50m+n4
         6eBTmYn/hCmyY9D6zPc44ZvwkoJJ87N5vnRNhfEwyywDq8/KzoWd5ThHDK38snbR/O/v
         A0Ou4TCsOg0om6G6b8FvhNfVZcvAGiQKpcc++AvwWBNkFfsMhF6JByWZ4gF6Gx8BL9Ki
         Urge6pBL/4p8V54VJhHRTvKw00C/cwpQpnVH+KMGplLu6MOYZy4WCPCFnb1tWuFZfe96
         9GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735769; x=1787340569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REPk3sv6pnIpoq+hx39FYxJfdGolBo9DSKR94k2Jioc=;
        b=Da62g91zGzGY3+JENDY7ogDaJJVd8FJCgwU9HhUVKS84n6MJyTCd3Enyqy7xhWxrBL
         0hpKH9zffYjdODaFBwn1dT32ShbR7Cp30NH3R+dI+IrI/+hzvbDYZAe4b9+liEBZJmd1
         rpQayQu34KeAfsgAWkpahJ9YahqOsV8U66DQt0Fvm7CVavXHuEcGg+TaluqU01iIiUbE
         5OTpJVCDZq7aL/S/ZGRBrxFgnX48f3qyiqji5Q3nnMuVfVOScObJXp+iXOTbTbSEg0fa
         KxCBQYlKHqtfeQcDqQzAlEFmtux94Yuw9oBUiTvolKzE0mWW6LHFczDjviRmwUe76NE6
         r1Hw==
X-Forwarded-Encrypted: i=1; AHgh+RoYtv7p9q/LBWUHwv/bTIu7T5xeyYtX2wUrapkLR0GUzi7MNcyQqgFoozMSTpCZ5WxK+CHpsDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oStTP9qfLP2XDBvMDyKDnch5yKx1OJjrffrYelQM6t+Hdxlc
	jxSPAn2slycfuA4zmZGf57ENLsSvHfkUUvmwqFilwE7Mgqbc+l0quNGF
X-Gm-Gg: AR+sD11UFwah7ju5YycidgsnWJQpaulzjeg2bLMaD3YXmDd5tS6YZSBgABff8rJgm4Z
	H1sDtDEprCJbDZoM2vmc9zgPyQtUm/Gwkgk0LSC8pKyF7Ukev6iQWf5/X0PuyH7BL8iiy2TQvpl
	ekOqNWDlsqu3510NYNECVNdX2pvvEChJsLVgFDPxWxRdg9Jq0CpNvJB2bNVJ5BMRhmt8NBLBVo2
	7Nlbb+3MLhdQtDku36zWwzFEEkfMGIZhKc+6CqcjgUeuDaMCItpg67VesXP2AXGBVX/PLPfG+oQ
	8edGcYuUVlgHKQfXnAp6vmMWt/Du1TOVcewOG7CVonNEm4bCtwD2azWhF4S91l/OXrmTLV6LIsL
	iTgow/ZJovFEOHE+XgrMjLXY6x+UFMZDNUAz9+2cDph1vsuHTRIYF+bub/vXzU7XmEpTjgU6he6
	jasH4ClsjVyX4gcQTvIFfqEuC3Q2D8N46ySPQjQIzCqhM=
X-Received: by 2002:a05:600c:4fd2:b0:499:73ca:c419 with SMTP id 5b1f17b1804b1-4998796a152mr54134925e9.4.1786735768844;
        Fri, 14 Aug 2026 12:29:28 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:391e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b36370sm63708695e9.4.2026.08.14.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:29:28 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 14 Aug 2026 20:28:58 +0100
Subject: [PATCH net-next v3 7/7] docs: netconsole: document local_ip
 auto-selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com>
References: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
In-Reply-To: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

An unset local_ip is auto-populated from the egress interface at enable
time, but any value the user writes, including 0.0.0.0, is used as-is.
This deviates from the behavior prior to "netconsole: use the address
family instead of the ipv6 flag", which interpreted 0.0.0.0 as unset.

Document this so the distinction between "unset" and "set to 0.0.0.0" is
clear.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 Documentation/networking/netconsole.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 4ab5d7b05cf1..694bca4803d5 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -141,6 +141,11 @@ The interface exposes these parameters of a netconsole target to userspace:
 	transmit_errors	Number of packet send errors		(read-only)
 	=============== =================================       ============
 
+local_ip is optional: if it is left unset, netconsole derives a source
+address from the egress interface when the target is enabled. Writing any
+value to it, including 0.0.0.0, uses that value verbatim and disables the
+automatic selection.
+
 The "enabled" attribute is also used to control whether the parameters of
 a target can be updated or not -- you can modify the parameters of only
 disabled targets (i.e. if "enabled" is 0).

-- 
2.55.0

