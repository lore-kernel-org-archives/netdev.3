Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC136495D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963652; cv=none; b=NSuCnLGvKJPf9PcpZaAGEWWlaszWBeG2siFUIMCP/uNptWFdXb3qnT1Ow/9snm4xzlcR9ZeqhDS4XrsjzZhdmoNG4Xy2Vwd8jh5lRlsYV224T4GeYjdhOht4un1lbeaRkPGC/kmV67bgU4gjBFNbDPjHlJCzs/Pt39WNUVHkFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963652; c=relaxed/simple;
	bh=Keo+Uf96fFdaulWA4oibMtL7z5MHBt0b6K1Iv0Vr6Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONXTme4QUG4IqkSjMogwqZ4SEvQzrJuYEfh5tjnwLRzzYE0osLrNpbzfzivOWGGqKKPqFp8cQmfq/L4t/fiSiU5d2vqdh4qUnxAYJVt65gr+nMjtLXwJd0btUAHxcCXITArfb7fWIx85DYS11eTozZbqn2y/u3YqeA4rFgddevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajog3ugN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajog3ugN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C3C2BCAF;
	Thu, 23 Apr 2026 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776963652;
	bh=Keo+Uf96fFdaulWA4oibMtL7z5MHBt0b6K1Iv0Vr6Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ajog3ugN3+lRmy0Jj9QedUiHYXqJp/aQna1usyAOZ6wng/NcObCDOYdUiyWydU8PI
	 VORpGtE9WiNtVD1QzvAWkCos7hDt6SYMiCqjWAGEdUVrvYq3jBuJdYbjChqBqYfXVl
	 7ARQkqmg2DHrPoRbGaAkIlq7IovHAmrnBGhiDmWRo/7kfJqdMnrrfpBN2P+xNYQaxZ
	 HqWX4XWJpbROo80vLKBdJp4Lv1O/A9Ql9SloEioqv9wVGVXOeyVr0d+zN3gh1j+b+m
	 pcY6QMYXxqAIzAMICQQdggiQoyEms2yZ1HXCEsZE243oiYDFn0xRZqYavR3JlB8ico
	 xt3aEL6eFTT5w==
Date: Thu, 23 Apr 2026 18:00:46 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	andreas.a.roeseler@gmail.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	caoruide123@gmail.com
Subject: Re: [PATCH net v2] ipv4: icmp: validate reply type before using
 icmp_pointers
Message-ID: <20260423170046.GG900403@horms.kernel.org>
References: <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>

On Tue, Apr 21, 2026 at 12:16:31PM +0800, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> That value is outside the range covered by icmp_pointers[], which only
> describes the traditional ICMP types up to NR_ICMP_TYPES.
> 
> Avoid consulting icmp_pointers[] for reply types outside that range, and
> use array_index_nospec() for the remaining in-range lookup. Normal ICMP
> replies keep their existing behavior unchanged.
> 
> Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> changes in v2:
> use array_index_nospec()
> v1 link: https://lore.kernel.org/all/efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has generated a review of this patch.  I do not believe the
problems flagged there need to be addressed as the array indexes used in
those cases have are always valid.  However, I would appreciate it if you
could look over this.
