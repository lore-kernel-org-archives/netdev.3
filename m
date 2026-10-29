Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.207.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312674;
	b=q6vHCRQynkgkvBi1lkwmYj3SbM4tkeeJppTxSek5xMvZbEddY3fZ1sNiO3gXzi+W435N
	 JFWEWz7BTm1Qm88TI2rFKJ1KuiwGpCUY77dSUtBAVQoZL9Ewzhr28oka7pYdmZX8GMNGP
	 XwKW9vAtm/PJuv4q79SCjtmwblWeRWnWQXY+rVLW+hiXMzk0leLmQ71dsS6Esw6o92x8t
	 GPy4KIjQhQfXEyDMv+C/7zvdBwaPw/JNF6eZQMDBKYEe8y0eBK+VnG4cQYIHTgSMZs4J/
	 0BQFNDNq6dyxLnrXftsrB/btYtI3KCjsp5XOOo99oOBQOq+Rcu6fVPQCL06xoNeqzjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312674;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Smtpcorp-Track:Feedback-ID:
	 X-Report-Abuse;
	bh=dyT+ihmZRHBjmheITrRDtgrZmMUouv6nHmymzXaKw9Y=;
	b=gcVQx0gGglfvXvnlKz12B12d8IIMuNWg0QRg4CTEiqUxTnXs1rJDBaHo919Qjkl6LbNO
	 LBjzx6b/4R0EpUpjMBv5XJmK9nyWu21PHvzO9C8XsERmCYk3wuylM0RirDxFc8IzLAeFE
	 9sD6ySe6TsWzdKuvhBNeEX1WASgjPQc/YXcfbrcBJxECgg1tW7AkasnodYb6i9L2Nbu8M
	 HdfoC2ngtnycFAu64MOW1XE0q7uckrBnK8Ix1e9h29c4YL8Mnbel7nUaXehb7o9Xun4dV
	 pGAorWzTO5toBICIxwxXDEWP8JvdZhtFm3XeFUWAyKSAWLESR4Wmya4lta92Vk8fGdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shangen.org;
	spf=pass smtp.mailfrom=em879706.shangen.org;
	dkim=pass header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=zbUmFN3V;
	dkim=pass header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=Q3r7EgAx;
	arc=none smtp.remote-ip=103.47.207.181
Received: from a2i949.smtp2go.com (a2i949.smtp2go.com [103.47.207.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63771606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 22:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63771606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shangen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em879706.shangen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=zbUmFN3V;
	dkim=pass (2048-bit key, unprotected) header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=Q3r7EgAx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=miusa0.a1-4.dyn; x=1793313573; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=dyT+ihmZRHBjmheITrRDtgrZmMUouv6nHmymzXaKw9Y=; b=zbUmFN3VwbLPP9AWt5fmaeLfqB
	TwG8RX9L8EE3+NnIZ2pH0d7eugBRGcvNnfr59KIlPK0ssmhIrx3bMC1Z7ZYn6pxO+FIZqZDMzOyj2
	tFt85Oun+TGwte+GcLeJHUu4ouxSrmQgPlS5HVeeLsHcq2ikWTcOhhMqZrTq3QBqIIj31o3dtdeIx
	qW2MhcdGlNKOHbTcvukyTIcnS0dizOHIP0nj+0XnG6jEBSg5h/us0BstH44n4aRVAe9z7nE1XGV2E
	wI+EE35zLsDq1zpFOCAfryn4oyMsNW9YR4no/LoAOa6MNzblGMrKUE0GyAv70ELZ10zEuEUQZ03mo
	4oAoEqkw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shangen.org;
 i=@shangen.org; q=dns/txt; s=s879706; t=1793312673; h=from : subject :
 to : message-id : date;
 bh=dyT+ihmZRHBjmheITrRDtgrZmMUouv6nHmymzXaKw9Y=;
 b=Q3r7EgAxwJSH/WkhF+acCEPmNU3FngUTsfmeUuZRVYJl+duDsT1IhpITE36crV2PyJUjh
 j3rZxqtRPO+gCLXrtKyXttJc5A9RHO6qDSJcM20GgpqdbptlpFoaTeKRD/2/PXOOYUkSoR1
 t8HBNQhJf+GScVthyK24Pj2qRuV83f7rsWq6ayv99lOkHOq1vNRzWmcHwwWAQDip9wpIhrm
 ekMAEJqBifH+3at8UuYBhZtR2HsnDjHnNHFBaLUOce+wigntKhF+WEnSlsNCobdBVSlgqTY
 8jO3DTRZL5b/kw68PyJp3nH9A6gTmTO2XFNmP4flI48xnuvZR2DTqdtIDeuA==
Received: from [10.45.33.53] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <sim@shangen.org>)
 id 1xMYXQ-gL4TgZ-AO; Thu, 29 Oct 2026 22:24:00 +0000
Received: from [10.195.244.224] (helo=sse-laptop.lan)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
 (Exim 4.100.1) (envelope-from <sim@shangen.org>)
 id 1xMYXP-4o5NDgrmO6N-dUpy; Thu, 29 Oct 2026 22:23:59 +0000
From: Shang En Sim <sim@shangen.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Shang En Sim <sim@shangen.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Queue "bpf: Size backward jumps by the insns they jump over" for
 stable
Date: Thu, 29 Oct 2026 17:23:38 -0500
Message-ID: <20261029222340.870378-1-sim@shangen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
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
X-Smtpcorp-Track: SHGqxlBjM558.-LIfyv5PHE-Z.6nd95wHFKT0
Feedback-ID: 879706m:879706aL5FzMA:879706s0ZNmKxbwB
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi,

Could you queue this fix for stable?

  commit ebf0ab370bcdcd17f4faa204e1d2cc8e817ca6b1
  bpf: Size backward jumps by the insns they jump over

It fixes the x86 JIT stopping its sizing passes before jumps converge, which
makes a valid program fail to load with -ENOTSUPP and "bpf_jit: fatal error".

I reproduced the failure on 6.18.59 (CONFIG_BPF_JIT_ALWAYS_ON=y) with the
selftest program from a938f51d3522: the load fails with errno 524 and
"bpf_jit: fatal error" in dmesg, and the same program loads with the fix
applied.

Thanks,
Shang En Sim
