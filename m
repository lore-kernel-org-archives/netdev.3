Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695224;
	b=mPtk6UoELe0VNd+a/6JGvMA6XGayq7a3INPZczP+nRAI11trc84p8tXQbVANlr0FZYMS
	 vXuWJSVgHfZVMgFNJEZIYyKdSJ/xZ+D6/QrtBWX3a8vZtK+N3JrFOl0D9/Q9zNb3DSlfO
	 JYn+LY6CK+pY+8pdOhc+1s6kM63VEkrDs2tIzSYS2ZA7p3+eURlHIzg7z89ssODUWUV44
	 XitJUqspuXoO2rtU934rbFQ0Sbg86y9J4Tq3rh3ppVORcwrfdpeuP/0rRvAuTdY6AoixE
	 tAfnSKKXtqn7QXdDxlSvYioTP85beWy3PMtqnNem2pLYW4r+9gqwuRxw6spV81MsKAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=GfDDKfeStG6fy+Jj7J3VfCr9+DWXcTw+jJ+F94QlR6F274PqRxvVSULRcj12oTBfMy05
	 xIQouQDdLnhbSwLR8Z5AXbDtLouqVmGdO3cBViHKRnTGou5kV1BOS8EVn9rQhoX701+9a
	 bKx7cTmiwuJ24w+PVycZPZm2GmMI8fGBxT9UDr1zaSHcR5ScCod/kX0mOCZVW0C57qFcy
	 jJBvJhqAkz1HhwiT10CbJ7fMD/NTcCSWyEUhgUUIIREhmzKY6UTuN7LF2qGaAGthomo1v
	 z8OWC/SEBk81/UNt5Z6U6RaM6mj4oAfpNtNOyeVylTILQDnEvWX5762s7mYAORO1eUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rhnb1Kuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE85606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rhnb1Kuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9C01F01825;
	Thu, 22 Oct 2026 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695224;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rhnb1KufJsks3u1WvNLkU86ysSl7CROpb9WQNO5ilYBRYEmEQbqZ6IQqDBXCVifuO
	 njQ2IVXLfvU81HYB1UJpXXo3k9t9OmuH1un+Xlv+seQtI8kqHs/twDVuChiMUoF/xg
	 8LqEFis+FpIN1H+B//sLUPzyXSnLfFJjHdxlv+cfe2AWBWLSBuNXy4mSIAkDvDvRxW
	 1xHaU98BFUX+72U+8OKWzHB3/dejOizKZOTlxdqBCaUCCBJmycZvUcHLfKN4dfKijy
	 tzm1+dhkdJR7GTnNbmiTLTLsV15Bc5Eb//1biDp5O41+OzPAA8Efc+eAzUWOzvbV8o
	 FfpnU0gQ+EQnw==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
Subject: Re: [PATCH net 0/1] rxrpc: fix null-security challenge leak
Date: Thu, 22 Oct 2026 18:53:43 +0000
Message-ID: <179269522324.3290.14429115095311549674@kernel.org>
In-Reply-To: <cover.1792694708.git.zhilinz@nebusec.ai>
References: <cover.1792694708.git.zhilinz@nebusec.ai>
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
