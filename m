Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD515CD7E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184590; cv=none; b=aaQh4prZCfVgZAPyVYsFJZYxNOmZzLK95cqZ+/zeE/2z1RUFouJxTibmHe8iXrQCiHIc7/Uchy457tGPkdtdZTsV19ZXFGCyV5zVTcSqxar1maiOwsdvkySg5Q6A1WGAg9c1F9OxjMM0QHGEgTDvpIPARYAE5rxegdB2x7bvR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184590; c=relaxed/simple;
	bh=8wexlKF2KBEDhMHyebDWrWVilOwUJmumuN4ezz2B8AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaNxzg0bjL9M227UTAYNQOfLty7gRt4xrOCNkd0hXHap8+hf3G0C6d/WHEpqRbYNbUVfsHanbQg0Xn83l3E5F1a1hkyU27jSYaQUO57NB7st1tSAYK+Eek0d5ZDwFyAIjQXBT0IWwozwu+k4sQIVPcJPg4E0IiLCPmKzSc4lXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqEYqxDe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqEYqxDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B0C19423;
	Tue, 10 Mar 2026 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773184589;
	bh=8wexlKF2KBEDhMHyebDWrWVilOwUJmumuN4ezz2B8AM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kqEYqxDeuzXbdUOAtp8Q4SxveYif25oGoNMP6le8zm6VpHOFCPU/ehhOdT2+6vHZ8
	 m2QL9NA272q4yBLlMPApPa3EdjmyiAnN+XjrGTxFkB1tqVvRNgBv9EcCc//ZrnQLDy
	 y6n2Uod2Gkx/PBzRhFoGwh/UnmcFpWEnKeVUx1mzfJxo8mJu5M0fdihGRVemFJVQwL
	 2mM2H/3L+JLOaDVGpW8+Ro2nJC1A02FnpyMu7g1ObUR0GZ8wCyjJ6Dgg5sFTaZb1O0
	 UjCXlNi22zETTATJx09G++WFUzo2OoXMJsW+Pw0TG2WD3E0HXjAEA5y0f8tPxMy+a3
	 FalWlhoeZFx0g==
Message-ID: <5f8d37f7-a395-4143-8580-56f7d6f77656@kernel.org>
Date: Tue, 10 Mar 2026 17:16:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] neighbour: restore protocol != 0 check in pneigh
 update
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>
References: <cover.1772894876.git.sd@queasysnail.net>
 <38c61de1bb032871a886aff9b9b52fe1cdd4cada.1772894876.git.sd@queasysnail.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <38c61de1bb032871a886aff9b9b52fe1cdd4cada.1772894876.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 3:59 PM, Sabrina Dubroca wrote:
> Prior to commit dc2a27e524ac ("neighbour: Update pneigh_entry in
> pneigh_create()."), a pneigh's protocol was updated only when the
> value of the NDA_PROTOCOL attribute was non-0. While moving the code,
> that check was removed. This is a small change of user-visible
> behavior, and inconsistent with the (non-proxy) neighbour behavior.
> 
> Fixes: dc2a27e524ac ("neighbour: Update pneigh_entry in pneigh_create().")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/core/neighbour.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

good find. Thanks, Sabrina

Reviewed-by: David Ahern <dsahern@kernel.org>

