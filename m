Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADA42DA56
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380476; cv=none; b=XcMcjn/hw8/SRVbGE85TaVbhwZccMVeVj/aU6LJw+QQHK0IUwl30O9Uqr/45M4LHusfl5V0g9akl3JFIZbfPWw0EsUmhPFOcbN2bGCWgEW+sbmGyA2CfoJAtFiOGmeB/INsMjsAbFDGIqcWHmSjWUtVlgEp5vclVAyiMHTRo9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380476; c=relaxed/simple;
	bh=Nf8019ikvXpuawmVRnTiH/eAUfA2qq1dCBgswbuW8v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWEfkRc3nx9A1vv7n4n1S0N2UohFKqsAx/CfEJS1+E9MG/tDRBuMo7Zl7I+ewvLQvsflpLA4FTOdp2ecQu7e4P1mkWwDJ+7kI3XjLl1zoNpEYrVq7JikIsn812MstY6xBQ8Tc642I2vaD+FbpVds//eXNMsuJogda4mRQbhJAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqus/4u2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqus/4u2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe76491b8so186953f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380472; x=1786985272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dwa/MBE6L/+MukVwCaR5+lFDiikCNLSp9oEd4ORAtSk=;
        b=pqus/4u2Bhb+RNQdsN07NmCAea9L+1OrkbclnCd2o/VNDSdemzSJd4hF76JngKfiyc
         cA+MnURyl8NETEdnjcjTKZAEy9X4pw5KiOznYpehr0K3UulG4QGnNrvrrxNJ0UkRKTo3
         HnCA6e9J+ZV9EKvMygT23gVmIiC1NHixNvPzgRYt5tyQDsJNk7SXQSfrnIK8x5nlbxk6
         R5uwIljG1N3c9y/BB5UNXa+ctRwxnCn6n2JmnK5dMS7mSyrWast8ZybhMQQdC+N1C4JI
         qFI4eb3NNx72hsrL3ZNVHHiNZamW0IMlDByJOy/ooNaK8N9ALof0RiR3MVeP9+DgNZTf
         AWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380472; x=1786985272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dwa/MBE6L/+MukVwCaR5+lFDiikCNLSp9oEd4ORAtSk=;
        b=ju2qxUJ5std+xvhrNhAyeDK7jD99xvqvRByGgoGgPNIXQSNnZHhasDRKf6BXb8K3A/
         Xz1EDKKZCDwlF3ZIqHlKakswRjeG5Y2AFfng0LuYRvU0O5xj6RUizFCVM6NgcQr943gE
         IexQqw0NtkLR5xfg8tBtvN+2alH7AZDSgAkzz31V4wVz/y8pwhnm6ORYHhXpzHJ+WrzS
         vRKuym7aEDuenhs+g30wV3qoFCwVqx8/F4Tf7lBBJvHt+jig2SwwgXrq8zt7n08E3qYB
         3FBWwfvVUadjN6dNwDh8Xp9i+lM0t2d2D/Vv33TK6YhwfzFTjMnmQv5BfJ5YR4ZP5Rdo
         mYPg==
X-Gm-Message-State: AOJu0Yy+3hrF8V/OHoA+0556DuP4WcV0T2kAL7K91zBkOmRi3XXppv6J
	ldy944y0rUlRJR25Pn849yVbNknF59avF3skORbRt0FMm/ju1eY8j3uu
X-Gm-Gg: AR+sD10R26Hko42e4cZkRBDyTTHWsZK1DxozCKPfZD92advy8kPE/zChbpnrToBTeeR
	toUWsquOZNH3FO6NezKw3/leQpUE7wHJKbXVyyrDs1N0xhd/8mJ91RbTUA7ITABlV6hu71tvGXF
	1VOnw7gQALEd8fLyWi2I6RU3ob8oNLb2/DhNJuFSSBeGTjnkKxmgRmE5yjuMI4uSXQF0OWvaOzg
	jrQMv2Aqx42bTMThqM/uieX1J+VH8PaeQ3bBJ6B5ZGXbDlXDMoKWlj17a0tTElOti3FLkMcjc5W
	S0I+Pv6Q0X/GEz0piVmRTuK7GolyfNwGmMbmf/2GLbbeoEz2LiZ1OMgwlRDDsxltzd+9frVsO8z
	zUctzuPqNWnoToQqBdWvupPP8CvegU4zZediI5PNU4LmYNJ7eIsi9NRTdm46fjpmz5QCwRFKo4H
	JzI0ZCFW4noZfhEMra5WUNpxWglPTo8v53AWD2xuZFt7PxscKxRpfkUQ==
X-Received: by 2002:a05:6000:220d:b0:47e:96f2:52a8 with SMTP id ffacd0b85a97d-47fec4e31b9mr31500906f8f.1.1786380472224;
        Mon, 10 Aug 2026 09:47:52 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:692b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm35460643f8f.17.2026.08.10.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:47:51 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 10 Aug 2026 17:47:29 +0100
Subject: [PATCH net-next v2 5/6] netconsole: show empty string for an unset
 IP address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-netcons_ipv6-v2-5-3d4fc987a90f@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
In-Reply-To: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

An unset address (local_ip/remote_ip), now denoted by AF_UNSPEC,
currently shows "0.0.0.0" in configfs. Print an empty string instead,
which is more clear.

In netconsole_print_banner() we can be even more explicit about it, as
we don't have the risk of userspace trying to parse it.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 054c39066043..0418031b6bc9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -705,14 +705,18 @@ static void netconsole_print_banner(struct netconsole_target *nt)
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
@@ -850,6 +854,8 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
+	if (nt->local_ip.family == AF_UNSPEC)
+		return sysfs_emit(buf, "\n");
 	if (nt->local_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
@@ -860,6 +866,8 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
+	if (nt->remote_ip.family == AF_UNSPEC)
+		return sysfs_emit(buf, "\n");
 	if (nt->remote_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else

-- 
2.55.0

