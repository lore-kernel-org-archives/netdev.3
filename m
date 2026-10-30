Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334574;
	b=aVkid/MvwlDSLgmwW4cLX600CIF89XvAV807lPNyQn1kReunbk2Ft2ap1Av/KZFmEiZj
	 MQC/jPGQn81gym5riooglCXRwobpz+t1SkztL5ieE13qgr42taP5+ARN3yAf8HftvSG9m
	 1QV+mm/MyrWHtqRKZFb+5NTYRDZih71jE4gSnhyyhsvujfVYt/ZbyPRJgJWMBNIOoUJ0W
	 vCPjez8W/uZ7IEEo7YYhwTOp/5D32OwrPyiqt1f/OabIaPpSzVQQ79cEEk94k+VlUjMYJ
	 cI0LXF3qImVJKoqh5s2ir3Fw3Dxrp8JGIJ+vzQb1yIeG48T/eQiN8cnhP4TceeDDCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=yOe6nzWyNcIlt7NWS6TuZMY4sWPW8+LPI0vMC0YbM4k7JSl0OK5svzL0eBuErfXWo9QQ
	 9iRAnTGoEOEXtdSKzK9OZMyl4Z4ON30B5nKR3sp/bJF3wJL31GdwC18QtChF13VSd/WJm
	 4HSKMqtp8MYSeK1Qe350Z8BXas4hGqmE8dHX+EtXOUzppEFpF9xe4NoAHGPBggIfqXKX7
	 T1lnEV1gyoukObrJKKUwL654XvEDseVww5DBPvCqsDcAHXgSmM/aysLd+cux1XbY4zJvJ
	 V0y7MTDNpKbhZT2danUBfaGZ76/zxscTxjN4IySHoOQNKrz9a7aM/AovTC6bae74s8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7f8Fvkp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A69606A31C;
	Fri, 30 Oct 2026 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7f8Fvkp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D531F00A02;
	Fri, 30 Oct 2026 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334574;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B7f8FvkpbLCNtk4o43uqiwD1kH1rf2gXbEP7ANjoVSWceYIv1U747o5qVWMuZ5sx8
	 TEWmkBTX59ynkIxvp0V8L4LyO5wHG+c21G9YKDXn4tNdKAgmpzYkUJH8C3pv3zASDR
	 xnsTlmQTPKB/bVH2M8Lp5pnuOrYDcLAf4mQPJ1Kdr78mNxjDUIldwp60IxlR0MUvug
	 y3mmvlYSPaNGT1Ztwa33/7NGnU88BqEIKAZHq4qIXtiVhgdVAagcPrnnWZqmrO43JZ
	 8edQvkPi0eLaRNybvTtsrCVtU9r/mxK6F+Lj27azmTp9Qci+2inapgLVXM3E1erMpb
	 QZfSNdASRs/lw==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: 
 Re: [PATCH] macsec: reject frames that decapsulate into runt Ethernet frames
Date: Fri, 30 Oct 2026 04:29:33 +0000
Message-ID: <179333457341.3327.16640756707963486239@kernel.org>
In-Reply-To: <20261030042237.74106-1-kylebot@openai.com>
References: <20261030042237.74106-1-kylebot@openai.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
