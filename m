Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645486;
	b=r12PtVs7UvJJPG/HsW+6kgDWo1Hsul05jOOxGsARKhdC1TFnzjGGSOIPAsAjx711LwG1
	 ULbCrDpf4gwtJSdQiHKHAPDAqh68UZ6tVPFn9+1SE6agI1QYif+wkF2dDHSw2hr/q96c4
	 Lj0PM6OdFwNUyoJlfsPBwWur10huyoyIpSWQdCrKtEsWHqj4XWTa1ZifeZs5KTT01hAfj
	 JiXI/yPWocvQFsqB+uzLFD0+KUWrq6rV3u5CAjVAR2qrsXZOvJeEMoWQXA+aJ8+nbVqz5
	 p4H9QjEFvKVY07eUdboctqh8Ia9ec/n8tjSJjVCvpUWrnUotDo5IabK5kNtLMFLeEgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K0QN4y4jnTFtdyn65vGrqyDwOyuHW8lCb5pwYreuDyI=;
	b=UBMXpfosPDEpcu6u38iUUIumeuqi74v2PbvXg5y36HDRNDHzD4QboKVHqn1Yrejzj0fv
	 c7fhUCbfT642SRcKR7sKVBcY7TKobjNQfRPEPJB/0694SAWYj7r0ZrA4h+BBFoXUu68qd
	 hdHT42C6BYD/myoRJI4SBxWs2esAUjjs3qP4lKSpNWFMZi91DXTLXfBY2Hp1RIv4eNNQr
	 5ddRd0oL++0ZSMCnJnhhmYyDao6uHTvsLB63XcVzIyvbEXFFuUobatfRCC+8/jTC35sKL
	 CFXl8T4PIjxyydns5OILFfPe3qNxqGfJuJQvyoOxtxtCq2+m29c7PTzpQ5rEekTrixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHSslzd+;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B8606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 146B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHSslzd+
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1adbf62dd31so3532288c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645485; x=1794250285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0QN4y4jnTFtdyn65vGrqyDwOyuHW8lCb5pwYreuDyI=;
        b=LHSslzd+GXSoMMIs4rr/hOYVBXwaBM5MEy44lC/3WM4aBxQthqpVdVSR9lEntfWR81
         bB1zPwHzu6rxQr7sHSvsFsVeD2pV1ncGm+YKKAcGShriWqr1ygibYjsYrP1RuIjVWR7m
         /SqgBOIWevUT9TDl1khaBVBZAgNVl5rrnXkXkE6Jrq+ptCGNXEVuHA2Mq0/vwJcKj2bj
         4i+mEcsL8Uz/tHBg4B07+RYniOSqC4lAZB1w4tQ8IjaJmcUhv3t0nsxWBX9AnDHvhp93
         VAAHwPUtc2pVKS18ttsWrntrpefVIm4yFk44VNJiy/+33gBKgnqp3sZft2vcboIKUG3f
         sucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645485; x=1794250285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K0QN4y4jnTFtdyn65vGrqyDwOyuHW8lCb5pwYreuDyI=;
        b=O/RsY4/wVl3IMThgxu6Pu6wKij7RgufLVG+gQzgZq8tvPH0cWEId/lkFLwB5C5RbQJ
         1DqoFEqrHZ+c1PclcwzvkgwYhtD/eNnNQUQU00p34UhB1zkzJWQ7j/aZdFK4FVB+d0Ow
         qiBOgaKe53XbfLNk3cKDi1/+aMWjK9bcz7qDwEv3dK/j5FuAI52kH4D3046z9I+EPM3B
         8gI4ZbrsuUD8tbJQsgdSsr0GSS1j5Q0nchuDlLfKil6KiZ5mjHVn5qeyz2MZEF7OEiC1
         9cONe2IXaybC8fi2213p7pTEK8UEVxrfK6OyOM1T0BEzu5IhdUnfRTbCN/KjKXvV983v
         L0sA==
X-Forwarded-Encrypted: i=1; AKwUvBxVoCejP224BRO7gwET79vIYabgpqB+G8ijYA/Z7vA89ogbplVbORgVS9reGozcciTuybffFEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgzPBT+pgFyviRILFA9/UC7W+NUnQ/4KurqW0sShOVEKcw26Ow
	deoB8kil1vzvDEAQHUaTixXFZQW853WMSUf2Dg1QhsnEZ9mf6/HDxcoo
X-Gm-Gg: AYBFou2FYqk07UKScJMeZBuDuK8rEhzBy8hHWCO6C9P8JiQrDitgzkb6ty+s/VvFyh/
	3e9cvTxtne5h3AAz40puEnN3AVbgioE8TjvhMXnQQoFFSY1Hk82nHvO58g98ne1+F0DQSRk3iOv
	7Ebc/S5sZ6nzcp6FfdD1qHXbFtAhokQtUkcNz8rKdoQMjQDCFRkQjnt93sRpKMbcqBAy167qbI+
	5r1smjPOrkzfZu28bSxzW849eewZxGxkGb1T6Y0Crt3IKG+aNG3ZGmXkQ3frCz+TQ950fVH3nv9
	I6M8tsWVyklmqXxNGACB3/LgBkG6UDOCd03QehEPNGBtlyqZyAlU+OIDyypGmRZ9ieVkuuAK/sr
	4wjTNW7IXdKtqT+gPyuNhZdfDSnGI54UHk86yFfSFT9JDKede70bVUZL8vAGLPl10HqHnKcnr2/
	42ihKqTgF37LhxVaDjQ7TTC1+v0JYnsA6mJr8s4i2+HIJNOTDRCM0pbfOz+PvC7ZhRyPirkY9uo
	VozMB8tLPEomEBRxMz3VUmb8qh3lXvV02MvZBTU874KE5042vK0zMRTjHCTJeNKXeDWjp2lhiab
	HyzADLaEXYc0lfM2h2hnZP2+4WOsZyd74Qfvh3drou8BL1PtC7lMErULDtikxZvpf5ZtZVu9w77
	CxDZcRCWhlOMahEuoHL9l1K7G1rTvDHY7kWJnzyEAgCKTdw==
X-Received: by 2002:a05:701b:2091:20b0:148:bc4a:8356 with SMTP id a92af1059eb24-1ac5d5aae1fmr16081901c88.28.1793645485021;
        Mon, 02 Nov 2026 10:51:25 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:4808:7aa2:ac97:30e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm34625198c88.20.2026.11.02.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:51:24 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH ethtool v2 1/2] netlink: rings: require a value for hds-thresh
Date: Mon,  2 Nov 2026 10:51:20 -0800
Message-ID: <20261102185122.1357927-2-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102185122.1357927-1-dave.seddon.ca@gmail.com>
References: <20261102185122.1357927-1-dave.seddon.ca@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hds-thresh (-G) takes a value, but its parser entry sets min_argc to 0.
Given as the last word on the line, the value handler reads the NULL
that ends argv and the error message prints it:

  # ethtool -G eth0 hds-thresh
  ethtool (-G): invalid value '(null)' for parameter 'hds-thresh'

Set min_argc to 1, as every other value-taking parameter does, so the
parser reports the missing value itself:

  # ethtool -G eth0 hds-thresh
  ethtool (-G): no value for parameter 'hds-thresh'

Only the message changes: the exit status was already 1 and no request
was sent.

Fixes: 66e5dcf295c0 ("ethtool: Add support for configuring hds-thresh")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 netlink/rings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/rings.c b/netlink/rings.c
index 5c695ab..22552df 100644
--- a/netlink/rings.c
+++ b/netlink/rings.c
@@ -202,7 +202,7 @@ static const struct param_parser sring_params[] = {
 		.arg		= "hds-thresh",
 		.type		= ETHTOOL_A_RINGS_HDS_THRESH,
 		.handler	= nl_parse_direct_u32,
-		.min_argc	= 0,
+		.min_argc	= 1,
 	},
 	{}
 };
-- 
2.56.0

