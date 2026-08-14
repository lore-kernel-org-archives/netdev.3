Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DE39DBC9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735775; cv=none; b=YNWPjPIj1A57dqNl8g6+5xCgKEJL3kDCEB6EGmND9GOTCqcq1f47V6Sls6r/gy/1C49+fsIscEJm+bwmFVEoIX3NsNI9FecZWfnKs4E8sErHIxJzDgYaI2b+sdSKxJF2IpkI5hHhyQTxAWVYcdEIYg+z0g9gX4OqvQYsdDSuRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735775; c=relaxed/simple;
	bh=evoNCG15G6WzqrwbqEvAz0ljT6c3gDzGnnAZfhprhjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMZBvM+kuzva4S7eOsTOZRCD27SkdqqVinKdAApTkXYoeZiUgsVlr2PANvV19txhtjpH9kyW5JtfqEQPYToeRpdncr0O+LRUpRRc40EfnN3PmDKl53VSB9nWPL6mGnk4LfjdOUnUX3vuZGIEIBTJncY3WQT84g4RdV6nk1qxs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh/8GNMw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh/8GNMw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47c2ae992beso105670f8f.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735767; x=1787340567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WsLtkV3HpWQM29hlh8OFg5JwIeyXX1Q1ZnZhfhuQco=;
        b=Rh/8GNMwTeGKZnluGyJdrLcmeOmei1Ra5kbhVi2rpAzg+wzIMIP/RRtfGsxnJ0N0Kr
         VWk8BMDwkBJUFjv8Bx3wxZh2BslRcXwSmQHSddxme7ewLREYWBpvM3g19UF+u8bgV5JR
         G8kl3W/afCqeDSEHNXurNECvVvdcdaYc7571HCoXFtcGZtoFJqbPtjfNjFxiQ6kuwKMh
         vTDGttRGX1tvVNUS8rsXTezVM52Lux6AQWgDHRBgjjI7N96PuBnWtjT30M9bEbZaB0zR
         7xCriOMrhdQOhcFxgnSbc7neL+iy0ICGSQaSEChX2cbP5e8LN0Goa8euwYPCp6KzzwYa
         K5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735767; x=1787340567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WsLtkV3HpWQM29hlh8OFg5JwIeyXX1Q1ZnZhfhuQco=;
        b=oZuAH37tItFYp5HlHaXUbtv0nZhirTMU/Wv+KpGmxsN1chDYyzD34bK2J+k0R+tKNA
         ELno7y/x/MZsoMpC6ouFG6W9zuKcfs+B6M8BAM9a72FoMM8/2t93o5ObYfcl8ONPu3XM
         pEqCHo8uJEH1UlY+9W9e0Gcd3XDBigRNC6QSFDanjItX5EVvGK2PaAfhAPfUwsNpLDaF
         6pQRFNN2ZLRwdfj98nZmGkBIgcTT0Om1MEQE9Pzt0gDGfHOc3R+zuMoXs73j2ArN6D2b
         Gwp3XuVOQPmwRF2lFSmbrUFvI2l6K7r3wUzaxzOYwEO5QdnbsCLAWhmiCnlFoOtRhkxn
         f03A==
X-Forwarded-Encrypted: i=1; AHgh+RqSw67xwGFTzMCbwD0Dssl3S/SNzdp8huo65KZ+RgjTLpGWns7XzGrqhFJYwpjsb6rmxWcgXUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywsQR77iUAgVVKU7JqoYjcEkYmb7QWLWHJyxfzrtuSQ2nZ/j5W
	uAt2rPH08JKWW2lrIN1cRM6yGB7NrPDwldY5LgD86cssycEC+0nxJ8Jz
X-Gm-Gg: AR+sD10G5GUw+aTouXezpgbyGcIBtRgLHvPEWeAJn+7xm27hvfuGCo55iHCMwZcdgWK
	ur5UXOfE7LJb4zP1zdSdwENxQ45n3GSnGBwilTi/q74S0nm3MUgr4VrcFL/SdgWhWmCYIssHKwj
	LQQ1FvNOUjAiyHTEBqtihIMq1+O/yxVaiCN1u8EYbmv0SA3++25dNIm/pdVtJ3Zd7DHo+jooUM+
	Aje21576zazqwdJHEZ4a3+AO4UPBUIyavAD0F82EdQo+VMyf0DjnZlYVOD0drp5s47tlgiY0W7x
	5BCnZzgOh6YQd+RaVanb9lOvR9vwefLcx+dUiHBKyltXbhhzh+rtIXo3xvAjIfp5aosB5Ile5Hb
	rV1ff4klKl/f9YmaERtD+C0SQxZKPSfGkk9vjpMIlNTh6Q/djOaDJ4zYSdJaRncNCLoy6CbCN1M
	ZEBNuNPfczXVc+Od4xqnxKszPbpsI6wLRGE9fMRJH1pQg=
X-Received: by 2002:a05:6000:288e:b0:47f:921f:397f with SMTP id ffacd0b85a97d-4816078a831mr5570171f8f.4.1786735766602;
        Fri, 14 Aug 2026 12:29:26 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:391e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219e12sm9464228f8f.10.2026.08.14.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:29:26 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 14 Aug 2026 20:28:56 +0100
Subject: [PATCH net-next v3 5/7] netconsole: show empty string for an unset
 IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-netcons_ipv6-v3-5-bc0915e8c75f@gmail.com>
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

