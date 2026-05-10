Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAD24886A;
	Sun, 10 May 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427921; cv=none; b=ozB9TDG9vv+tL2v/NskXz4zF89e8zJaO1qNegDDv4Bedxpg4VD7GS4aSJluQ9m/wtstRVyxe98TEcGNxKOIuIKaL4xeAoYbV/luxsjWWTdcVj3IIBVp9szlMoc1M4wLM3vuKtm7CtL1WhxvsB6bCh7mwgSejt/V2sKkwPYmOxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427921; c=relaxed/simple;
	bh=TOsx3GwWQv2ZQronrWI31p5VMwMdImgcimzYMlnzxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EorBRRgv8QpbHIe0/CippiWn1r5LIlADee8MMRJASFd24p3WSGCn2aaKacilUG3LwMiDrpOnsvuHOVypatsDF6KUOG6Xj9htYZoC/IgOOr0tE/fSSdgS/ONhYWs7PiijrL37kV+gwlYcVLjNb8UIcKM/IjlA5YCMgKuRDwl4NKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBlrIHLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBlrIHLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DDDC2BCB8;
	Sun, 10 May 2026 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427921;
	bh=TOsx3GwWQv2ZQronrWI31p5VMwMdImgcimzYMlnzxuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PBlrIHLtbZLx7dOpGJs/e3YlMwB8sTnvGdFBvzXH+HUaVkBlnHFs2FO5FhCbySOI2
	 P5lYfDLVby+IdiSgZxI0YtyVM4c05YbSNO2k6gfPHQ5PtXQDBa1Lh94gXSLGYqD2aD
	 gKVkt1/h232siZFz+xbwExc5iVx8RZWy0ldkkUS8zvJEIi+vytTZsijxShqQjcr0KT
	 QXGIPUudH0dCQ31kFyjVr7FfNAPhCCOJe/R1NRuX049dyJrV8SPYmMXDgCgj9bmeqL
	 NzTP2PtSd41RAOEIdZ2r/LOWrVSJAeNU6Rht2bm48q/REHsr6pJncanlgdFpVYkad8
	 vqlodqgM+Xwnw==
Date: Sun, 10 May 2026 08:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <20260510084520.476745b5@kernel.org>
In-Reply-To: <af2kdW2F1gJ9U-Gg@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
>  			    sp->hdr.securityIndex != 0 &&
> -			    skb_cloned(skb)) {
> +			    (skb_cloned(skb) ||
> +			     skb_has_frag_list(skb) ||
> +			     skb_has_shared_frag(skb))) {

We seem to be getting a lot of fixes for this issue, and this one is
incorrect :| Writing to _any_ frags is incorrect. You have to copy
if skb is not linear. skb_ensure_writable()
