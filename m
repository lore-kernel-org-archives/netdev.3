Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773636;
	b=Te5GyKfYvkncrmwHARVsUD5gu33wGYsTVgb3zKWsApBzfvnpBumFfUK6GgL4DuVyOV4E
	 vXkg4/QVD2y5oK0bbBec289d2+gr3zlrstLk+MZ9pQn919KLdPdfochcXNsVqPYVqm9+Q
	 qaP2DjUM0RqrnXyBOaFkOQmeMho4qvWzBPiXF+/Yi+uSK6KzZiArWKR1QU4lL0P+BdcwZ
	 F0FHPuaoDs2dRdD2K4PrY9R7X1FeLXH1IorJBrX9w+aL/x4GpFPQ9ocWNGFilBOd75x3O
	 hVnKsEP7sSWCPYuQe3IHJq9Zr5pOP5eQRaA4yUiQMxzx+ja1CwgxwRmw1+adJuzt6gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NSC/0UBqsHBUxojcMDjRPSsTZlmrWmRR2YvHBxYsfFY=;
	b=AGUPUpP1QYi1BKpSny5t+IQ5IrLVzBvLAha7SzQ6VUTRc2/L118eyT3U4X5vFdWdke5m
	 M8sYTtIV8fqQFGzlt39vVoEq9SXeEvZK/HJkeDrQnuzWfkm3an1+54wkQz5+O6X3g3/DE
	 Iojg8S2nQ5oTPnynrfO+gfmDDqy5skweXmW/uxu2Ddw2Vu1SDmRPhLtXhuPZ22K2IJZCh
	 wHWXo3eE1BrsU/+FzbIp5dMC2aj3VOBrJVjuf5ttWNaqEsfjlLOlgNy7VmgGtvaFfiytm
	 fdHL8s/kMmboDGZaa9X8gVRLPVizQRBfqL6XgXR4va5jPtX1n9UlvD4kxgzN0TNHeuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="S+d/J/Wl";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F217606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F217606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S+d/J/Wl
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14394530ec6so557064c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793773634; x=1794378434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSC/0UBqsHBUxojcMDjRPSsTZlmrWmRR2YvHBxYsfFY=;
        b=S+d/J/WlJRNCpBsfW4bmC6NRLzKerZngGI7ryYluGCIQicyRzYIeW0FxSQrrq6iQfs
         XpkkaTkORuL4jo/EZ71DM1RLLYBz37U6TAiRS3Kx7I1hHJNzo7u1aY0E8wTvBFuAS0kW
         51CdSq8lnp4zahUDi/eKvCJArYlROECM35fE5+1aeHTZkq+Ouxjck2ao74zDsQg+DTSg
         MDx4tQqyNcup6zzVFf0X1DNZ9a4jxW2Kkh5tWIL63roGZARTVYQ3c0iCVdZJ+0nTHdMS
         jeua6LhDQgaqKk+HGdf6ylzvFUHMCx7+eiJVsdX1IHSf0iwcCE2lzq6OgrHhnEymGMdr
         rJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773634; x=1794378434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSC/0UBqsHBUxojcMDjRPSsTZlmrWmRR2YvHBxYsfFY=;
        b=Oy/xngKJcfpIFRZVC9jC64MRYy6oy+omHzwsu+v3Ce1r24fsbu5fMHByW8WY6teMhy
         MF82cTm8YyYFKjGRs7BfGyaBzpP6jB6pAAAuDGu03DOOiKBX4p4SiTHKIbv3mS3Nmnzc
         F6wV3/ajP41G46yjWt+Y2n6FKRrVRnED3jraywn1oxRF4QP+ZSRGO8fbAKap8j+CiuOW
         rg60N5G59AsYQJZIe+upMasxVkp+5OF1k4z+bwzUxKUcO5Qkmok36QysaOurZ+Z1VA7b
         lEbRqH7J/6bObJILBCA6F7otMV7CqGO+7Zl3H4zRacaqHhKrhHv5S12sXcvPMzNFtj/p
         WJ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzNQ2sUlgVOZAcznkWHv8dzW+wrPO/RHejHRa95JgNKa6NEoqj9k43iDkH0l0Vzdfwne5rOgVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lvv9zEacRjpU5yxPSi4EZJImW4e1sD5yUnQ8lPz/fV24DexDI
	klNyEQR9SonNzsGqxYeHqnH2Ko/R0NMrSkfXDi//MlZ7SKXRdGqCGEQE0m/XKC8wJCQ=
X-Gm-Gg: AYBFou3+EGK5ej3b5wYUfJ+g5jSQdPrVsRSMFctpjbpSyxQ3zQ1WLSAObMi+ZZ40U6S
	mjLaYnCVzjUToc5W6GwsZPn/8rhzxiN5ZHaC/2RAzBJ0nKCfCTtqrK+WqMyHUphTHiTav+0g2S6
	Lwdnrmr72yWRMl66ZC5EY/zZ0GXIUZ78irvQ9j4cm7AJbrB7/sgsyHnUcTEdtIYWcBM30YQnyfY
	K3wT0enhPEd5T5ff56+tGGae17PikdicMajRp/bGDFNeHsMAwx0VCK75DfEhs67qgaFweFnVQcH
	HEm6GPQS3JXW4ozmWtjlDaGxl7LTIgtG5cY4+kOgKLt2nM3CZtLO/zKXL1yeSYRT/OH6cW9ghvi
	s3iKvtNlEqH/zfnii0A0Xo3Yw1pcBgaQvm9PiAA0gbnlQCfVFv6exEGR2kOaiT6JbQOVFtCS6Yg
	fR2uqB7ylKPTc8xmNBzWkL/08Pr6D3EmLcySSz6iqFwk90TCwV7PyAsm5Gpx3LDHACBMSUZDjfr
	NsGl503KF1c+B2j1sYY2hBfBFRowROlwLhw0U0RIlge8fUHNF6dDYEP6aUYvCtNPh3AXu5hbp4Y
	aJ3chhlfX6hIGlBoJ03N76fJhf3jW/eKxLsSlS/z8vcWkxK/PcbgoCeIQay4mkt5vi2YXzpB0PA
	5eaPtEE6BECX40+Hf6tjPFxLu/SkJ9WSLz73U
X-Received: by 2002:a05:7022:b887:b0:143:2719:f800 with SMTP id a92af1059eb24-1ac5f742576mr20295191c88.40.1793773633660;
        Tue, 03 Nov 2026 22:27:13 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2f7sm4955756c88.9.2026.11.03.22.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:27:13 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: netdev-bot+sinfo@kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	pkaligineedi@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow rules query
Date: Wed,  4 Nov 2026 15:27:03 +0900
Message-ID: <20261104062704.1882348-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179377314801.488859.9571867900418118906@kernel.org>
References: <179377314801.488859.9571867900418118906@kernel.org>
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

Hi,

Hardware: not tested on real gVNIC hardware.  The overflow was
reproduced with a KUnit harness that feeds
gve_adminq_process_flow_rules_query() crafted device replies under KASAN
(x86_64, kunit.py on QEMU); the harness is not part of the patch.

Best regards,
Yehyeong Lee
