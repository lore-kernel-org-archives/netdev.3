Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334220;
	b=4Dppi7S2NXYmhhRN4OisrHAqBtf82OdHH1hI81djU+BLDKDMkKdseo4ToOBAiF4O11sJ
	 nUNWkGrCWLfzdKgmUDMOJiDL9l30KPScXdPle1xoPukze7dQ4WMMhKJOImgrCgCmLjnGu
	 K/wawdopxC/PkZAxBlqs+q2cdH/DZeJl9OTkrFNDdM9I/RWtaBlMvla+QANjUFKfMaNb3
	 IwtOcxk00gz604K2UW4TCogHkT7471wpPxkl8MdXIdCdiL9B7QOLSvrjzqGT/wO05O3Hy
	 1/aQDbC2sAZkGpESbXYjw4zsW0oIJKaZHgW0WmsoGTVXIn3eRpqRpwwFMQJRdMqZRDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334220;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=FqGpb8ASJjGZGCbDFlTmIsRpaKcigRdpswbQloDyCuFECJgfxFCGSbNRCHJppo+1O2V0
	 /ikYiqMYJbLKAqVhHcE9YV+iCUmoS1Eft+7gPGRna8XuP1rKvgyIWE5KJzAUeEYEvgdMO
	 pJDRJFVfc7Ei7MTMVOHg8qQcTiJ1DnmGHhSW6h4VGwVyoSW/VRzdgEYXkjSeTNwDpkokL
	 vd0yq7/cfrifHDn1nIGGoAVtznzYX9XtprLTUdyRwSW5aEqPIci6NCaMvNWBnFuUHWbm0
	 sp7upiIwVQjSur7U0aOCBFkF8ZeC66oDkIfyCBpDsZGAMpf6QjmBTeZpThVtezpBL6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsXK6bbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC9606A32E;
	Fri, 30 Oct 2026 04:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsXK6bbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BCB1F0093A;
	Fri, 30 Oct 2026 04:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334219;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YsXK6bbOzXUMZ/wete0Psp0EzFiQsyyHsynFc9bDziHqlzA7CAHLIWrKfwYAmXlEl
	 jJDETxybXhJxuVh2CcWprRDsHEr2QkK6Ile49vIywND+jPK6i/NKd5UiTg36AUd3xg
	 dWm5VkMET+gBLNaGBg5fXx9K+hCIeKFsAskFLAPOEg8hT5MfkTkBI0XvkFGJgG4Gom
	 YQTIJXRpBxbX4Zij6BhcZ+aS6wrVjZEI88wFWw10fsZYFPLE4lILcXDEHbluw+EqeY
	 6ks3TFN615mxrP+h9y05lnisQ4iEN9+Prwtz224G51ML9cEgIVLm/4eh1rCrlmlRE7
	 w0RphTarSdqnQ==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-afs@lists.infradead.org, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] rxrpc: Serialize client connection IDR updates
Date: Fri, 30 Oct 2026 04:23:38 +0000
Message-ID: <179333421888.3327.3209075506845971151@kernel.org>
In-Reply-To: <20261030042129.73690-1-kylebot@openai.com>
References: <20261030042129.73690-1-kylebot@openai.com>
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
