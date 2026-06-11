Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C773361675
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159309; cv=none; b=BljPM9ASomcl7kAIVyjyRhuRuTWX5i6+YYpGPDre6UhvaIirT4k2REFrUeEUZpYkqdZOnR7Mo/AnT+1w02Uo73dGs1Iksv/1pu9gJksO92/Fgq73F/jWpwgMCniHIfSbDIzaFFurNa8fSP8r09COLEfkvMygBqtipWDhUfLVW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159309; c=relaxed/simple;
	bh=3p5/zBKQSq/8Sd7Hp4YXbXSAYly8oMx7d8QOAsa4m+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHSx/Iu2aEpEyJ64QR8CRbIWZkB9IZb9EkO3X0Xd1dcdZBCGVnccQipBsZt3Z894qYFhaxmEnd/Zfenqc1mK/edsPzwoB/7NlnIPOSZ/FMQhoXrzQYw1QIPrlIDyOkgTNjd0HJOcHBsYVWkrHuigpK72PHoX68ZdB02MFdmcB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWlvFJvV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWlvFJvV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso52331215ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159306; x=1781764106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkNt/cERKxxqu5aD9ajaN/R2nzygZFTIYInKnabH6x4=;
        b=LWlvFJvVP201dSCCa8bKqJDkpYl3vLNeVmQAPv1SG8GwvlqSHqNSdMltRCn1kC1UEk
         Jse9QljUkN2zKhLe6iPK7kJoSVw79fiPuwOB7ZshZc1r8RYVu1fV7nExXUyQGBxV3m83
         iKoWJJ8aXvwEFiOwGeAkZFXvPgw/+RWNRlK4X4i9ljXzrIoqfVnVUcNvE/OWfvCVs4jR
         PEOvyLrpyFOYi8Wn285UPsVqcGkEEG1GxMv8SarXxx8SE4Hjg8IJQHcncApkl8EeB5hP
         lY0tpAIREmnLbAFVGAILnH4FS+TU+b31ak824DWQhno3Xs4Wv9+npiRNVEoPF1XJNq9o
         6iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159306; x=1781764106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkNt/cERKxxqu5aD9ajaN/R2nzygZFTIYInKnabH6x4=;
        b=jvNidDBaGWDWFVtWe6ZbxTDyOzQ8LI3bFOwqH8xgIjUG1+OG2H+C8Eml+wj84/5FzD
         /7fcnRwU8cGz1sqRYkyacoEqMAe/nXO8uxSrkWJg4v2vYScpNDRb0c56Lv7n9ytNkUkG
         yqpDKRq4wWghHyudpAh3Cp4IxU2V0uJf9wmIL3yo/h3UOGMWKQHAMtXUirNZ7hVC8Gbn
         8lqNc5mVWnlxV30h27l/Ct5ijL1q6ZbF/x2D8AQ255r2XIbMx3dUNuI08EN4T1UpD1PN
         LCKQ/LbiejuLUfQykq5s4LLKDnzbvv3FWKjvJWi88nPLR8JWDKIL0dDBvjJYnWjLEuZ9
         vPqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YcmsHaXa0gFJVj4Zx9GKqjX1HPPRcvTpn3rTJvA58miPaXstyah2SSJAdOQADzu0T/YbyBlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxanm+I7C3i7rOQxkJjtbSCWdvZny1A/FyNUBgpGcx1136WAIzq
	0slYSiXLK8dn3yHH1v+skIc2t5ZjWAtNxst8RH6Lj3iUsHu4hcbyYSwf
X-Gm-Gg: Acq92OE95PxNNYlCtLK6lTmcDX3sZZftt8owNZrf5YpdYYDWpD2k0Aha0FrmAjnE6yU
	w9lve1IE3iJwpvExpFeitBJsVPqoPfIeTSvZ48KIdBFPm+BaN2NaqYAhRKqbTT0+6XY7bAr+d1n
	MA30wxWfVwIfTShaLpf/Ne7L7z9dEcrh368bknfaZ5ldu/I0mB+oV707ftB8kLacnFtHY7vxLb6
	5IGZNITBXquxECmV/KwhMqHJAO//SPjaQVFkeshlvmaAN5vjqnS7+RJGJBfXzdeFUQJGW0xdNbp
	3/t4waMwW/BkFPwrOSNwnTpyST8KeY6yf22FXGJ13d1XbC8HtqFnyuKCfNCT6B8rwLmbQMaUEi7
	BrxtkG/H2CIj4ibm8NGMxMz4aSqcgKOVI624lmO2RDdJ3Tk9Vku/uZNGrYUH9yueztNNonewGE1
	eSZJHIBtPvQ/uNrNUu0mxkzzivJXzmaOwadzaFjP4jePPT6DiZLwZhGxvRp9M=
X-Received: by 2002:a17:902:d2c8:b0:2c0:ee6c:c53c with SMTP id d9443c01a7336-2c2f0b21db3mr17479015ad.1.1781159306435;
        Wed, 10 Jun 2026 23:28:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 2/7] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:09 +0800
Message-Id: <20260611062814.2528793-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipip_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..e7378569bd5b 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.34.1

