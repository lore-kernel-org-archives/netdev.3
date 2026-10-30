Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334597;
	b=TZQ+hAXQRhKzVPNozJBPYL0poYXQqvXbMhBW0EFc7kS1f70Dp0QUDfSoEGMjkYitHb4w
	 eai/R+/v5k86GUSJ2P905ltdYKZ0j7tIN6SY9myjkU6IaiPrHvEp04dC0SAbxXXtJzfTV
	 7kzisK6TVxtiKcptGs/nrcFjFQJobyLbDWMykV2jF4OtE+HOwRcslVtJyzalUXbbi6BWm
	 Jr1KN9ymzpq0HN3NxRsT9+ahf5IrHM37jqUP6zzOeV7Gzyay4h7T/lfV1W86ktkhmoOye
	 cGKhb6urBsSR//ds3FvlQnrRDF8a3A/hVYhGE03Hpnk3OuImdPMcWeoY/QIbzWgfopQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=ENajvyEokn0mXtv1NaG0qq/dzgwfNJbwDl8m1fXuB5jqF4Ql9QFTgTdAesjLmEvp9CCt
	 ZEXyU2qlZHZaYKmis4w5wwgX70Z1Fm3achIXn0Vu02vc8B3D1ILoAUYgi5zqcGJsWUcMh
	 mQa74pDb5ypXH/4GnMofshB25RGoyUYi8pVwbkcNPWSbf6xPtL3CKEhYusRLA6Av04jLK
	 RxugplfiGakwul8b8yJ+r27Hl8cS0IooFtbskUbSDke5a7K1WXTDIxHhc6TfKvvDDMe4f
	 1eEjTNKkulvHTVqKlyVzEb0neylB8YJx+hZNNJtkgnEMGMNfKFc2zBK+Wt3+5YKyspw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FScFQM7Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B4606A31E;
	Fri, 30 Oct 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FScFQM7Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C093A1F0093A;
	Fri, 30 Oct 2026 04:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334597;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FScFQM7ZdrELcNO4Ops7J2H+84yigvpiBpxLjLivIsbw/3VtblpIa3qIopDfptqDN
	 gTeHvoipK36d2P45XgBcMo+vY4T0aUp20CCm6PKSMcmubFDu/42WjK9Ma0sMwWPOE1
	 vfI3Vy00pj0qiqzWpmdxRUqMs3E/rxLZGynO/exRH12G+hkWo63VafZIZMlNFyYSlH
	 Guot0dUrcoUPX0viI++tanPYAookOEELRr7iXPAXhtjW1NNxc5W2f0AAKAbbUJSomw
	 oxP0AZ0WDmRxTQHCJpvNsBrF+SMijg9o2XfyKNOLy3U1wWK4yrlSJw6ggKB+iXsL0R
	 sAshb/pJussxw==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] net: openvswitch: make transport checksums writable
Date: Fri, 30 Oct 2026 04:29:56 +0000
Message-ID: <179333459630.3327.17629856282918906224@kernel.org>
In-Reply-To: <20261030042304.74291-1-kylebot@openai.com>
References: <20261030042304.74291-1-kylebot@openai.com>
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
