Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053F36A35A;
	Thu, 10 Sep 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006995; cv=none; b=DcsKsG87Kj9tHT0hiOma54L2sbY8inpGY4lvks+zVt3egWzVOarPTnB1Q9i5B6ls5v1Ekqpyxxs27GbC9/K855xi0bUHcI44Wy9m5vJJG48LKNL+NeLCZgh99ACGd/+1TA9Zmq6d2X67Dk5+nqdXcJ4OCFwx7GQs//Vsxi2qDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006995; c=relaxed/simple;
	bh=yaOc+4xdwpaaKP/g36V5RFJL0tTvL6py9/BcVMfMZ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8Yhk3Q3KQ1ZDBxGAemQC9/4ST5QYg76VgpZcsopcu4LsfV2EohS3NA2Jk+Rc8nJZDAq8XTFA0FkCiYIy4gBi1Y7OOI6cCg7mlpTPXd/1JaC9teFa468MBDPKPDdwxsj6tn5kbNEtfL9XPm+dsQqOTYTp540vE59kjHI+Gmkpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHXHaSji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHXHaSji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D97B1F000FF;
	Thu, 10 Sep 2026 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006994;
	bh=MQKSFqRWagxnTFMhT2vsNzHf6n6nghvL1auU9ieMg9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UHXHaSjimXAIJZOfeVcklTYHxnEVnQb+4apbfjPreURCkoKoJ5lxaZUsXnIW4WdjX
	 m618QCM7sWo8ZHzpWagM7/okWW0w7DkKjuJWH3TZFTpOWFMWQRPaMUbjrvuElo5qUU
	 5jiFIGKcoGgSiTuLa46FZpXeN0+2sSgWo/ny+hFS97PSwqViUTnh+IAKrcgexK0e8W
	 bgJyjBcd+w2AJ6MNp5pOjBjMPk78xVAZG23xqZYH4mGonbZYBvIWxlqB9xayKrgZqY
	 YFEJ/zsVROGUq9bjPIaj2oCrOlWO+j4CyResa1GxSQERVQ4TyDR+g+HRlbw5sxJpgJ
	 v5WTNXaXXwz0w==
Date: Wed, 9 Sep 2026 19:23:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Fernando Fernandez Mancera <fmancera@suse.de>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
Message-ID: <20260909192313.0d4bd54b@kernel.org>
In-Reply-To: <20260907030133.482834-1-junjie.cao@intel.com>
References: <20260907030133.482834-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 11:01:33 +0800 Junjie Cao wrote:
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -128,6 +128,7 @@
>  	FN(PSP_INPUT)			\
>  	FN(PSP_OUTPUT)			\
>  	FN(RECURSION_LIMIT)		\
> +	FN(IP_TTL_EXCEEDED)		\
>  	FNe(MAX)

These entries are not strict uAPI, let's not append at the end cause it
gets messy. Please add the new field after IP_INVALID_DEST
-- 
pw-bot: cr
