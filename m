Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79991395D8B;
	Sat, 19 Sep 2026 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860612; cv=none; b=JgJKAxooeuZ41YUlND5FRKjBSpZPNQHDZ3TMlT9SN8tjqwkDj/RS7+j/kesIaP85fOcbdxBRjRbt1iRZe5DQS0t1te8J6KzBgJCWwP2yJCqzeD/YmWT0ThDxH4oBSMlieBXVvvbjfXibDv6RoOCKVusBnmeVcq09nNIOn5HJnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860612; c=relaxed/simple;
	bh=3hQctuO59Dt7EOs6uUIvxDIVa3eiBi/3JK8RPJ9YT90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVUtm5hZqhqhxb45NL8J+HcTA9vPi4/5OZ1am+JMp/1hW1U0PmTybDN2jHXtkcnpRo9p/ukaFPwfaHcx+dothVnhCwgStBZx/mfnMUXYA8EmrSbtsuHgxR6pGf3r9R1EhJ7B/s/A0PXP14ruKyyD6Vpgvb17YErf8WIlbZpTpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNMbDMC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNMbDMC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819CF1F000FF;
	Sat, 19 Sep 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789860611;
	bh=gm0oE85PoetXaG9kJFCrsJSqdCRfiSelk9Kq+1ydbT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CNMbDMC1ZhcJzl0b151mRU6oMZbUUfjoRhbsv09wFoMdOpTqZsGYwpEHmN6Yb7WIT
	 Aapj4DbnbATjmkTntg/vX17iFP8wc2ZaKaNLuqA2mfn1pH561rB2b+l8HS+2arJMq6
	 wUlWlSsTepSPINvwaQuVGrq/aQ++E/4eB5PHLHzI/uTmUqtIWvNQdRE2PyyXam3TBi
	 Fi0k/EoheJuQRVJ3KVwn6sSz6vokFjZxYJfel83am/ld6BAbuzBfUg/W2TjpzAPe4X
	 VEzP22FLs4Jq00sTylJUMdJxqttLexRPFaUUELdnjITYep7PYJMMjoh8ETulfIdfpu
	 TZpZg1t5Vko7Q==
Date: Sat, 19 Sep 2026 16:30:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v28 net-next 03/10] net/nebula-matrix: add channel layer
Message-ID: <20260919163009.7ee9f339@kernel.org>
In-Reply-To: <20260914123429.56596-4-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-1-illusion.wang@nebula-matrix.com>
	<20260914123429.56596-4-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 20:34:17 +0800 illusion.wang wrote:
> +static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
> +{
> +	u32 hash;
> +
> +	if (bucket_size == 0 || bucket_size == 1)
> +		return 0;
> +
> +	hash = jhash(key, key_size, 0);
> +
> +	/* Use bitmask if bucket_size is a power of 2 */
> +	if ((bucket_size & (bucket_size - 1)) == 0)
> +		return hash & (bucket_size - 1);
> +	return hash % bucket_size;
> +}

I asked you to remove the hash table implementation, I think you only
removed the hashing function. You should probably use Xarray here.
Maybe rhashtable, but I don't really see why.

I will apply the first 2 patches to make the series a little shorter.
Please don't take that as an invitation to add more patches to the
series.

Also, if you have a good LLM you can try these prompts:
https://github.com/kuba-moo/ai-prompts/blob/main/driver-upstreaming-prompts.md
to generate the code for you. I used them with Opus 5 recently and
the patches it produced only needed minor modifications. The split
was excellent.
