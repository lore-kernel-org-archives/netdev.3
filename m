Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AF19C566
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054742; cv=none; b=MReEOi0ySC6o5UHVjNg65bfMR7Ddd1sI1FHjq/78FcqrgZ/L87KHoaXgnJRAXNQIxrug3Whi6v/JhfNYJNZU6ieEOzCV/CknpdblDyVvBUggACyRbEqI2UvmHfXbDnQVzDryMAYnLWGQI6cKZmE4+3St3Ws7667+AfA9KFxdplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054742; c=relaxed/simple;
	bh=xlDB4MPkVdLuI2GV9cUxuF4brdnzQHOqYmeiGc9qJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp8SYUhQIITfaCVIs2G1orzIgkvAcUgaiKJsrT+2unKN0gVoLO2Ji4flgu1LyMnWKQryws+keJe4JRPwVHAzQL8jerH7V17s9/P5erAedFHT63diR7TPRsoPB03QaijREaqeroOoEuYd3DOOZVXXTXr8VcQRKHfmpMhEnfUQylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1QT2o4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1QT2o4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C5C4CEF7;
	Sat, 21 Mar 2026 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054742;
	bh=xlDB4MPkVdLuI2GV9cUxuF4brdnzQHOqYmeiGc9qJwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1QT2o4KDasw0DGp5mODgOFjMcmofshsGsU8JrYCNuNv0dXLg6JZAkKYZi0ZFmWay
	 OLHQCRJww1zcg8hdpmQMI1ygnX7FDPe9ezc4iD8PCIFabUrW/Hap/uY/BsV9zq0Ktv
	 I6/D1jL7oAu2PiWDadYuS2iv2OVNIB50G56tcMpmbtNY5RMfT+GTXYFbpvLihvrBNJ
	 MPNZhjR9Xx3ves9aIZmfnZukUsWxEowlkEFARa6cWr4NgGBNYY9+LzGj8oePNAOk7r
	 K1ze1Edta7Zl5M8+Rvgx2Cne26Uy2AMy+e2rgj8avmveyycyjs9dp1OTDgct3x/Yja
	 N9hJXXByRGddA==
Date: Fri, 20 Mar 2026 17:59:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, David
 Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Onyshchuk <oandrew@meta.com>
Subject: Re: [PATCH net] udp: Fix wildcard bind conflict check when using
 hash2
Message-ID: <20260320175900.0a7801bb@kernel.org>
In-Reply-To: <CAAVpQUA2JhaewkprZHccQQu20XgnHmMgZ_q6AZWCP-V+e_YS4A@mail.gmail.com>
References: <20260319181817.1901357-1-martin.lau@linux.dev>
	<CAAVpQUA2JhaewkprZHccQQu20XgnHmMgZ_q6AZWCP-V+e_YS4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 16:07:10 -0700 Kuniyuki Iwashima wrote:
> Confirmed this fixes the buggy scenario, thanks !

Should we start a selftest for UDP wildcard bind behavior
or extend bind_wildcard.c or it's odd to ask for it now?
