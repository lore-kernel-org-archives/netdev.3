Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F24EE86C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452806; cv=none; b=QQYenJ6AP3mVPp7pnAmCdVHivWXtGmQ+1tfPIvfYsHsXiOoDTPTWOeJ6Q68/wnfZCXz3RmPIXbChKhWXUlvXf4NJvImVsVnMunu+5RDte2q6VyhvmYQ2O3c/wJr71zqFZWlqRNOPaUdS19FI7ucD1PQEmG8OxW1ZttEJS2qHGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452806; c=relaxed/simple;
	bh=evoNCG15G6WzqrwbqEvAz0ljT6c3gDzGnnAZfhprhjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAEcsqKyOuEzdbzemPKdziNpvOEIecaIgTUrQ6Y46oDOXAaPvDupApZyW6Z5hkI7+4bkXabOp5CpK1eZbNntLeQzCXLJCknI48UtHqjB13kgGGONWXlOXRJtaYRasIsNSHwvX4UmcEELKUZV7iWVw/k7/SWQhZPwhznDFb+1+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQJoh5ae; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQJoh5ae"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4843886fc9cso5348f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452802; x=1789057602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WsLtkV3HpWQM29hlh8OFg5JwIeyXX1Q1ZnZhfhuQco=;
        b=LQJoh5ae4uPmZpT/U62CJ/7VQoJp4z5793rl66WQ4cuOzV4sOu0/BKIenLyZqGFHJ4
         gsGrfUme9f7BSYM/GHRjocyr/vW8Oa9Ql96elyUb3DfhlQC1VjvCOgJ7o6+c9Lgz0iKv
         q7S+ubR9gkmB14cQfFyx9GUgYshpNEzENaiIBpe57KjsISBWTECUYVsd7NedBTF39gRk
         OYNa8WTN1LRGPAwLrRmdUViB1hBORkBoAhD81kpw0d0ie/BEp3zP53ZyfecsdjwtVcK3
         t9WM2bmLzhi8VDzk6wllfOl+04PKjtMAF6WUWhBkY/9muSZoOhgpCHIhsJ5gNjtd0hYM
         Jxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452802; x=1789057602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WsLtkV3HpWQM29hlh8OFg5JwIeyXX1Q1ZnZhfhuQco=;
        b=ayrnuxcB5sAtj+FWWawg4MM2n4yDWGN2olUK3XLiqDqbDW3cYf3h5RnFd1ZFmAOGpc
         fQFwCvEN6k22MQaDWFwHIycVtaKlmUJ801HLWvGfnAjAOx1Aq3ZFBTnAEV4MSjgo2YvK
         KKRknSGDgRM8zj7ESZEwdZtBqKKG1whgMVD3Fwdt0y8ykaHFlYG9GQDU77w/lFUXeU6T
         upyHQkjRTYSYSkJ2c5PzNWqUjVoZK9ebbHaNHPq4Pl8F2CZpbwZkhK4fa59Yp+TBMCYv
         XeFnrpg4jjr09UIzFe+WBmI7A4OKxV3NimKjukMdi31CBiLzC/uSx30KCr0j2Z9SW5Wr
         mMWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzT9rzTYj6JGRDrqwSY1z+PkPMeyzCl0/gZqDhvZPGzFuQEet1mIVz9Bk61NIzaBJHB16iu0Cw=@vger.kernel.org
X-Gm-Message-State: AFuF++mHV3JisfZGAb6EFhBis+qu2UPMVXOh+f/0PvPSLCqqwgqS4DZA
	6kZri1swLzC/zOn0/vyaj1XPpacvqW0YQ0M9vxfxbzNhHoJhJQqERTKepn7hPLD6TuR0ZQ==
X-Gm-Gg: AYBFou1Ig+acTRqpnzXaGWiBl3tFUhwZMUJbtRsMoaomwr/CXvhrXjJvFPlBNIRGTkb
	Oqm/rI/UFGnMc2mDaiDD86idAdPpCn7S6FweBEEVcGFEm4jw4VRcgD8zLkgnTl9BhjbZgpgtmY6
	yyK3m6/5LsFtiOcT3Nsc5R4qBMlLowe/esiFHQVAFa4d+J6uIy9rA0WeFrbQSQUL0eyqiWi2mxA
	4yMwoYfeXMO7X+hGbLMdNidHQP8tH0eCxLjQ8Gysb4IrqrO6bvEngaJxiX9Tefx+ziHySMhMtvY
	1rp62JvrG+0kUXMwZRi0FWA8N/tjfYKETAk/6z9n/yU7jsB8yOFplqbMfJ/aiaK1b4dsUXbxjjP
	WDTy3Z4Hj0G4UY3jL3HknFYrs04Ri+2GCzEPxI4oi47QxDgwkX5JBy/HQnWD2l4twNSJWkySMME
	HagQABt+P+lcV+HHnniAJyo9FKo06A5nsARS7Hus2w1w==
X-Received: by 2002:a05:6000:2dca:b0:485:847f:fd8f with SMTP id ffacd0b85a97d-48587084cd8mr212759f8f.2.1788452801985;
        Thu, 03 Sep 2026 09:26:41 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:124b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e6f604sm14930575f8f.2.2026.09.03.09.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:41 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 03 Sep 2026 17:26:04 +0100
Subject: [PATCH net-next v4 5/7] netconsole: show empty string for an unset
 IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-netcons_ipv6-v4-5-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
In-Reply-To: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

An unset address (local_ip/remote_ip), now denoted by AF_UNSPEC,
currently shows "0.0.0.0" in configfs. Print an empty string instead,
which is more clear.

In netconsole_print_banner() we can be even more explicit about it, as
we don't have the risk of userspace trying to parse it.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index abcc8515ddd2..1f18d0a7d2dd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -718,14 +718,18 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 	struct netpoll *np = &nt->np;
 
 	np_info(np, "local port %d\n", nt->local_port);
-	if (nt->local_ip.family == AF_INET6)
+	if (nt->local_ip.family == AF_UNSPEC)
+		np_info(np, "local IP unset\n");
+	else if (nt->local_ip.family == AF_INET6)
 		np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.in6);
 	else
 		np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip);
 	np_info(np, "interface name '%s'\n", np->dev_name);
 	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
 	np_info(np, "remote port %d\n", nt->remote_port);
-	if (nt->remote_ip.family == AF_INET6)
+	if (nt->remote_ip.family == AF_UNSPEC)
+		np_info(np, "remote IP unset\n");
+	else if (nt->remote_ip.family == AF_INET6)
 		np_info(np, "remote IPv6 address %pI6c\n", &nt->remote_ip.in6);
 	else
 		np_info(np, "remote IPv4 address %pI4\n", &nt->remote_ip.ip);
@@ -863,6 +867,8 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
+	if (nt->local_ip.family == AF_UNSPEC)
+		return sysfs_emit(buf, "\n");
 	if (nt->local_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
@@ -873,6 +879,8 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
+	if (nt->remote_ip.family == AF_UNSPEC)
+		return sysfs_emit(buf, "\n");
 	if (nt->remote_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else

-- 
2.55.0

