Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500284;
	b=mVr9ll0fb/+hAyZR0rzw4oAPIA5WfAM10xd7caXLUCB9v5Hl3Sw8avQ8DWSDhium8vo8
	 FVlUJMpBkfF2au0cywgumynpamYF8pyG4hUyN/pE0BcJATrei7ZHbAqQQw3IBI34qu55f
	 Wy4AtInqteJBzqmN+mg78vvKLQ8JwnqCNJsRWQqmMavrTXOvVPh7mGK0nj0MQhgdpP1gj
	 sDXsqKjzn3uPgUc0nugJ9fkAkt2VLCajOddxx+iE5N53X0tHmLxAcYH2IFek34aSi01Ui
	 CRargSbRt7KvPs+RBHxzGoN1wFSBVYuwz6R/nVB/n570KRlzlKpnE2txXySSgxhBkBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9m7K9K9LtL761eVrSTnykdQPje31prtt54RRFaowtjE=;
	b=px1hnc0THg6mR4UTyYbrelyVElJeIPkiNkNUUkS76eQnwX121LNbY2Q61JDuFN2vBSeC
	 Fbx7YPpyYC+poaq5GNqnoYnkfXAiMsvZw1Wrut+08bzEE1sGA88ItiB4WyNQEyN96jfrP
	 Z/vR06mKQWdUmnkyzucKY7oqMlq4Q8Ha9dDKUmlV5oculQRXtChTZUy2cGks3WFaZrzvR
	 oX5u9+F0KATzKgEf0Elpr1jrfJmUPm4XPybp6OefKCOSVNLCFhIQ53GN+Y+osE4bwUHX+
	 zA8dmlr42sArU3s1jmEUEI7LctZ723KbNL+bWgj7Ke4srW8puVWvjEd8v6YIA+SG6xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="cYH8El/v";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86E606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA86E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cYH8El/v
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so2846995a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794500283; x=1795105083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9m7K9K9LtL761eVrSTnykdQPje31prtt54RRFaowtjE=;
        b=cYH8El/vM0c2A5+6y9XzQCoxGgTV1g3bbYkJ9Pkn+phPxvFcTI2NhnNpoyYTNv3oVt
         Oafs/qULEz0YrHyRE+G24rf0cbaM8eVEB7ZpadIH1HEkwBFIJ53Zxml9XcdCdEtL6BDj
         9tUl8zEdJJt+4BbFtAOlof5VNkXRVnObmUYZOL+gHNcrHqSCYrI0QQuKgJmqXLQWoG3L
         y2gOsBlZ+LKDmcUmZFJ12MSxZGBLkacWKDG/guXQKrOUD9TDIlc5nUeSsxdXqWpcVl6p
         9yoM/wk/07Mq2gOUuSBXj1QqLvu7yCsZJMJOzqL0vBwTdIgwF7FYTJpfhWFJGdehUkEt
         kdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500283; x=1795105083;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m7K9K9LtL761eVrSTnykdQPje31prtt54RRFaowtjE=;
        b=FkiDZIdA/ZPWAzaIum4HxGPXtX1VY6XhANKD5orlPlo1pDdgbefRqlZa7CfRj4GqWt
         y6fOM0+lULHAj7nOvKQdDwpSz3+FI8HZ21OlfCefqnH56T+Zk4huEo2Fz1cNI9qRXZpj
         dATGCcY8TFvI4MYN5jgNjIsJofQc9AkgB+Qqm7Xn6+H4YlFgUEN7e/Q4YIDWP3kem8Mp
         FrgRUNY2dTp4VckIkeEipx0O2tbQKIdVoohnecvex1Z19Q5IkULBZcLT+jqgLV3RzuRS
         SMKq0lLybKAtX4narAoNPun6M6vJ3yIEVlQ6QeRlu0pMj86MydRV6G7NVoK+t1rQtrc5
         rHQw==
X-Gm-Message-State: APuU4Z/OwqT2Ps1vfgBd2Et+GSntE81XfQv3rWLOQBRXBQbLAf3Zl5yP
	ANCuD9OPKJIOOR5jAY0y8/lhT9+1LLeFnEGNYbgz5PAVGG2ZHBuoniPRLjtxy3ZWb8w=
X-Gm-Gg: AYBFou25bi1sSwMe5m+g5cujwgJSCCfF4SaGQCuETgaM281D1D6QRwgfe/O8MTED12E
	xHl42gKoei2d+53MsmJZwctGbdnQdF5CSSagCJcYoa+KJtwNL3XMjJ5F0KH5sVgIMl9G6C1VSod
	Ko+19sGqZ5+XoHggbJ5rIpav9iUS5kQA670tmgP28fLxMG9fFMdY57QjxTowZHJjR2h9HRUFq+z
	raTCB6Y0muKkVWZvJN8/cennL0ZtsbDyQ1EmybTFW47RJ6FZwb4AFOUnrbC6HduVvR3Lpc1rfXK
	m2HENnXEZB0Kx+ArCj90zcIN3ZMPqtTRbSilHG/GZLvaukm/txXz236E4ANJD+apW3R09kItpA4
	wjKBJTXp9o+0mdVaLkzWXGhb6s1aE8fz6c/B2Av654iRxBagqzNjnJ/kxJwKkth0ddksgbSIi49
	kWoTEEUnXS37TzFEY4RlDodsPFbuW5n4XNI+6UPyaiLYneZ/Z845w3hV2tpK98EAOPF1Dd+0L5W
	xsm2OQTefemNmMX3lEpcUteAgCLs3FXzVywy5dIgw5Ly6tDBDpdlnMhKukTxWAnWm7xfOGDplea
	fnLcMzppZnlz2xnSWd4czHLCsOYMAKtZIe6rEb/vM0XRu6xKVA++3EKAONRIonS5652pV2IM4N4
	=
X-Received: by 2002:a17:90b:4a8a:b0:3b0:cc3e:68b5 with SMTP id 98e67ed59e1d1-3b182efabfemr6090892a91.21.1794500282480;
        Thu, 12 Nov 2026 08:18:02 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm5132750a91.5.2026.11.12.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:02 -0800 (PST)
Date: Thu, 12 Nov 2026 08:17:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/3] ipv6: return EMSGSIZE when first route in
 dump does not fit
Message-ID: <20261112081758.70426a67@phoenix.local>
In-Reply-To: <20261112153115.GA3255418@shredder>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
	<20261110172925.3293312-3-stephen@networkplumber.org>
	<20261112153115.GA3255418@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 17:31:15 +0200
Ido Schimmel <idosch@nvidia.com> wrote:

> > 
> > Return -EMSGSIZE in this case, as IPv4 does. This depends on the
> > rtnl_dumpit() fix in the previous patch.
> > 
> > Fixes: beb1afac518d ("net: ipv6: Add support to dump multipath routes via RTA_MULTIPATH attribute")
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> FWIW, given that "It takes some non real world stuff to do this", I
> think these patches can be routed via net-next.

The exaggerated security argument is that malicious root in network namespace
can do this and hide/crash ip commands and/or routing daemons in other namespace.
Once again the analyzer is stretching pretty far to argue that.
But then again with the current "lets chain $.01 vulnerabilities" world maybe not.
