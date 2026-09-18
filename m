Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CC3B47DC
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723983; cv=none; b=nN9v/pHumW8D/xmgBewuuZ4EZ7V1ZxzEs4dRn0J1iin/rd6FJeyMaM3b7karf5HvZH/UcExgGXJRspQFpGcInCYXq7cjOD61kpeUvV7Ncdq9pkrJGKKo9YqT/ydLcwFin3PhAgi3KyoheEbKBYzzw7YWY3fueaFh0dw9AnVatAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723983; c=relaxed/simple;
	bh=2eNy1FvBMksFt2IPq3VF9EAi8OgxbCVkxwLS5hwpJT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH6dN2RlHmYsAo7ThdJg5ojW/2e5/C9Z59EZbOslU8plfmAOD3VLlRElPcQADEbTx4qFK46A47PriZLrVm4CPed882MgKo06JEcqirb9opRQ8M6VuRrRcFb8m/I49ERjC2UrnXj16OgioCNSOa1ArHKh4Ek+MQeoGACPJrgtmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=om8dEg4Q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="om8dEg4Q"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so480487a91.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789723977; x=1790328777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8yzNGPLdIBY7Ww7r8AiZ2JnqOoJONRxP6AczcjFYP0=;
        b=om8dEg4QPAEx9UKDImQbALLHlrVeTR8i1pJ5rkFpgQiCQGM4c6wATbJbBcv0hOCuNJ
         miBI3JHB68ynmskArNoXUG9FiMy9HGGvkOso6/zUmXuvyIaEm4yfqSvvZDudysTY6liH
         OLb0+2PsSxuGLuoV49nLtchLgE+hRekuM1ffA3y8ZKTjkXWmvzHhGubOqCqqhh8UL0Xn
         n8OK9GbQfA+tc4korsTK5mbCOvLPK3L9yftuV4FgA97BwtQNPDkNN8xSS/UBEj7HDNA2
         uS5UM1e2KY78CWZLqyNgqmsbb2qE5lIs0mUIej53dO3WbKBRR56Q9Rgs9H8a5NXrzgW0
         Cokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723977; x=1790328777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8yzNGPLdIBY7Ww7r8AiZ2JnqOoJONRxP6AczcjFYP0=;
        b=jfjigGtoE+BrJqG5cMeTH5wfPnRAU1F2T2Cxfo85pYjtvpWmYUVGXwQvNfETMETUT0
         U07WutEij8Ce528rEsu3guEdCi7zFZG1NgEuRadM8lh/Lq9Qt6+PkLwF0x9Vyf5kTkwX
         O9XKpEPTdvQGFOsIQ0RFyyFpoD84nCgi42S+AmjzOKQGpSFlTCxoi/gC3k1myhWVCYsO
         AVevpAb5+uF5XOB7haX1CIjbWU0wddYVSeR3nwtp0Uyiu0ufrj+ZBzdFoXlOhLXFLea5
         59HfIUs0K/VueIfIoLDXktKJg0u6S9ftx3raS6BjWB9fIt4V63VXbMh8Fh7ZcTxPvsLg
         Yyng==
X-Gm-Message-State: AFuF++mYD18d22piu5bxidpTj6vJTSqSCa7rSpmHUjIMYL+EzgtfgX6C
	0W6fDcD/+VQ8rWdgciCzkDn9/XCTADlNC3Wr4O3oGZlW4i4eaAKCRHmzwM8ayVvLc4f7DnT1JDr
	3AHYsdg==
X-Gm-Gg: AYBFou02a6miaFpn/jjGfitvKYnOjgGs0rn5LHxZH2vwFEG+NJYK2nEHSRnjibWEYVk
	n9CmdyBLDFiDjYxM6ipNG4An5nr9UbbRVQ701KgxAgX8JuwA3x158hrYLDA9wF06bPF5n5Sgmu3
	Ysb3PC5atMHQJ/+mB/mPFU0/HS4X/lsBPuNacmitbhDgi5Jr84ti4+kiDZ2hXPNwlCJko9/CSyy
	C89Z39CKz3mnEqByQjuqlO07qbXd/AfNUonOx4Mh6wB4SisuwjY0xMWUsjm2J/h6u5OPcDPXgNF
	pn54QQ1pJg8JeTc2wwKAm/Z6rBUBFzQpOXSaYURtF6ORdgN2ggFIxbFcMBRjmWFJuEPDkSz5CZZ
	hEcpMCAupgTm0OFSL/R5FXULLZpsy/tzQDMuIBOd9xIJKVk6Of7kZMWgVdnwE+VOl7k3LUa+Pud
	yKxvv/IQ2cGJOuR2qEuSrEbWpLL55c4zaOVnFzaWPAFLHKxrY0j8sTZHJf5+LJVCxWfX/HaCqiM
	F4N6Uta/A==
X-Received: by 2002:a17:90b:3cd0:b0:39d:cbb1:c96f with SMTP id 98e67ed59e1d1-39e54d36cb7mr4629171a91.18.1789723977049;
        Fri, 18 Sep 2026 02:32:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287be968sm3294994eec.26.2026.09.18.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:32:56 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	vega@nebusec.ai,
	milkory@outlook.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: arp: reject unterminated device names
Date: Fri, 18 Sep 2026 17:32:16 +0800
Message-ID: <7f570426c2fe95743f017cf1a14cdc7ace42851a.1789648438.git.milkory@outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789648438.git.milkory@outlook.com>
References: <cover.1789648438.git.milkory@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

The ARP ioctl copies a user-provided struct arpreq into a stack object. Its
arp_dev field may contain IFNAMSIZ bytes without a NUL terminator.

Such input is passed to dev_get_by_name_rcu() or __dev_get_by_name(), where
strcmp() can read past the end of the stack object when a matching
alternative interface name exists.

Reject non-terminated device names with -EINVAL before the lookup to
prevent the out-of-bounds read.

Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zijie Huang <milkory@outlook.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv4/arp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d409f606aec0..9e3cf46b7f6c 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1278,6 +1278,8 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 		err = copy_from_user(&r, arg, sizeof(struct arpreq));
 		if (err)
 			return -EFAULT;
+		if (strnlen(r.arp_dev, IFNAMSIZ) == IFNAMSIZ)
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
-- 
2.47.3
