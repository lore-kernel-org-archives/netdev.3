Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F529B781;
	Fri,  4 Sep 2026 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488537; cv=none; b=n2bmi1rY/GnRuHc53+F2mdQ4ZMRZ6tBxgWSTKXHvpFOYx92awzWzSDhtL+wPRcmALch04SaVuYhZueVry6G57EzOrYIa/YR13B0CM16pHsB0zknybLgJINmvlz29HwrYESc2Hds5d33Po/Woq4YmYfgkTZzwDE9Z7KnZX16EDNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488537; c=relaxed/simple;
	bh=0DWG2eCUW3sueuerg1t5CUu9lIQ6B0lP3SjGmdrkKqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USllKg55KpsZvbz+/Sir3XU6nHqrOjaVaHyRO8JVs61lE2UPZzWnvD60JDRxgFuvoKE1SSLLdlWOKcWmsLR/In2A8WlZAu5EPK/9DMAtdiRP8r+4B+Ixcr2AY89yuwxv5CiWFuCFf159Cr6UxYpFmoHqMuGXfPEhTEIopUhaKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqVG7S59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqVG7S59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3C61F00A3D;
	Fri,  4 Sep 2026 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788488535;
	bh=bcwp5IXXvkf/u+IT74sYYSTFbfezc49q1HAn4c9s5so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BqVG7S59T2kmOHB2S8dzSOrnyDyp/+fVEkiqOSPbFOsEov5dEiNs9SD7GRsR8rt/h
	 qu2RIYJsugnoasN34fx/0IhfCelDBPNl9GzYFbQqCMWpeiM/hPH5y+HNAkHJMrjQgN
	 AONbYv1dy2nMstj4f3Z5vvx8Z5SnRCcrIK3fFMbWm+f4V/XO07G825DqlmZDIvQs6p
	 PZ9nto8NJFYQCz7rK5MtMZ6wEediI/l+ugVoE4OLQt9aJASfrqA3KNiSnkgB8abWPq
	 TGZOEZ+5WOmEE12+Mot/CqEc7IZddonEoiIMqH7riyUryR2mz4CYgxZaQmIQU6FJu6
	 SWkBqeuzF85Xw==
Date: Thu, 3 Sep 2026 19:22:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: devmem: replace gen_pool with
 freelist
Message-ID: <20260903192214.3db2fef0@kernel.org>
In-Reply-To: <20260831183529.2517322-2-sdf@fomichev.me>
References: <20260831183529.2517322-1-sdf@fomichev.me>
	<20260831183529.2517322-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:35:28 -0700 Stanislav Fomichev wrote:
>  	struct dma_buf *dmabuf;
> -	unsigned int sg_idx, i;
> -	unsigned long virtual;
> +	struct dmabuf_genpool_chunk_owner *owner;
> +	unsigned int sg_idx;

reverse xmas tree

The idea makes sense, but indeed hard to merge this without any perf
data to support..

I'll mark this as deferred since it's reaching the top of the queue 
for us, please repost when ready.

(BTW for some reason NIPA started showing flakes in qlease around the
time this got into testing branch, but it can't be the reason. Maybe
my split of the GRO test reordered something.)
