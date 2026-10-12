Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4066383300
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812315; cv=none; b=WvWUBfdBmMZix/aiGDxLC3TdvjiSVQvuVnqk5u9vk2weqcQBXAvpxrvXpmbUF0x4qwUSGJVbKroxtyQbVQmSS1rcUEzDJKY2+v8p/FDHQ/bL+GQ3OUeLQyhmvgY1HXIsjCHiOPi4A47Q4djCpttgj9e1ooC5kEqo+hTf/BBVgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812315; c=relaxed/simple;
	bh=aSnCXbZM8BYBAMBqwPXMqAAZYfgHkX/jiSwoFupHskU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX7V68MnCBUOLhjDCsfA7N5pNkrVj7cLN+7GxXsJUmoaQzJd6eObDOXCe932vfZ7pXpJCaK84xlpmV76YT1/yWoIwxqpk36aevtOqwzRLezjjw8OfDWi+jlZfb3pj7FP3t76DilKGVKkr3pFd1Tp6BnBYFu/Y0i6R9AhgIB+aSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DDzCUCFt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DDzCUCFt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so19740455e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812312; x=1792417112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HE8jVH9zuQDEEoUJ0njDiO8FruebfwpUiWYdsTL+13c=;
        b=DDzCUCFtPQ1CO/I2KfuLfaEZ1KJOR5awlS/z5KBZXEzUT4XkHdD0Hichv28kGXAhPb
         R0LYN3rbMLNAgGkz4dGa/vr9vQpT62IbjhXxDFFVMkPdzxDXjdh3YiQndFCz+NZaTc5S
         FqmEWI35X/BA3AiwbTLGyu3Uabls/rBweFO2bo/Mtnmwmu0MpC5/N22aRp3iLX/Pa0tI
         TDUyAdV6Ir3HDTHen/okxUvZxJsscndP8oyanECxPzrL4jwaDJ7dMSQBZcZ8OT84rLYU
         zRCUUzOdk7JM58O/LpSNqtuu6UpQmAAnFC0Asvg081p58WjW3HE9QOSnRVRXyfU9EhGa
         J98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812312; x=1792417112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HE8jVH9zuQDEEoUJ0njDiO8FruebfwpUiWYdsTL+13c=;
        b=N1qh3G7qzOSsxELa0dY4efsBxJAyvcBxhqM+2z5Hqz75g3k2Vmov3CWoRoc9cFnAww
         83Ira4SiWsJAuD5YCVQO3DdbwU7e69PVrY0vEaNui3HmkEx1EfXZDMbbZwKtzVObtKEO
         QQb5FnahgbdNLNH5wFR8Nnf1Hmbr+Ln84/NyyPnUCPmWU+CNn3+CDXwzSdjJJ8SGfeKW
         EJB29bhf/s5IlfNzjmjkRev8HNqtvjCSFwl5PjONDqs/X/vKJzOTldJhWNZoIYCSYFza
         C9jct0En2LqT7aZxndMrTq/8xFMTEA6N/+I5fxngZnUcWVGgOlmUNXbyTBp8JAe3hUD4
         5H+A==
X-Gm-Message-State: AFq9FYJ4yUowTa6xyKUJApajyeVpyxQ0IMOf1p9AZ52F8j+rRHuJOW4Q
	gvr3xfIyliHjzvBr1g/SiqEJvpbWffBGqwiGqh10MITzlycoxLjBIdk7Uc+Ig0j0WoC2GkxizKh
	S43dku1dLrCf2zOgqOisHj0Nj1nuhBdVTFHZdbAu9zod13eRiRmKz54+pTtE2bsQIc3k=
X-Gm-Gg: AYBFou0bmmCeee4teUfY1q2R5+HzzYZVzmJQFiTNKGR44JqVvtyf9l58u7SfziTTOqp
	nys1ns6S7a07100jPNVRkFj/ZnBRRM1MQHVRaeQpCJ08+mjXnizXQhrliVmPg04urhysi/bOWcp
	cHajT+HyrXdIf8ev3JlBXTOwMKkYm9wybQpGuPc341wm4zIgXpvsyNupA4gJnTJx0YrswHARatK
	tcBANkT76JFdXEgvADpJVUvBSGwMrbP5CUilHPqj3CfrS2kDMNJ2ehE8lpiAWkQleqaCz6WMsAZ
	ZmXKu9FNNqf9r12yDGBSMAO3RnjtX3kRzJfZzRZ23CER7yLf2qTdT823f8BiafOfyzf+lAqVZP5
	coqPW4njufWAmVgAz1owA5iOIc/luWWROem1/0RzcG39Z8Ghk5vKVeH7f2VO73brGc8LKEo4gzn
	6U8eoAYXmZuzk5+QP7mH0XMrcC2cFTTF5znc2PnXzx1v5MDRjS4yEG64Z6+GZNluxmflRDzBKL/
	JOyeqaT/Uc=
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a18e49886amr205846595e9.10.1791812309804;
        Mon, 12 Oct 2026 06:38:29 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 6/6] MAINTAINERS: ovpn: add Ralf Lici as reviewer
Date: Mon, 12 Oct 2026 15:38:03 +0200
Message-ID: <20261012133809.2477063-7-antonio@openvpn.net>
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

Ralf has authored 39 of the ovpn commits merged so far, second only to
the maintainer, and is already involved in the review of most changes
posted to the list. Add him as designated reviewer so that he is CCed
on incoming patches.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Acked-by: Ralf Lici <ralf@mandelbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 509b35b5a0e7..9e5fa06b2b51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20537,6 +20537,7 @@ F:	drivers/irqchip/irq-or1k-*
 
 OPENVPN DATA CHANNEL OFFLOAD
 M:	Antonio Quartulli <antonio@openvpn.net>
+R:	Ralf Lici <ralf@mandelbit.com>
 R:	Sabrina Dubroca <sd@queasysnail.net>
 L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
-- 
2.55.0

