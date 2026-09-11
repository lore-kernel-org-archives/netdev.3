Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BC3E1696;
	Fri, 11 Sep 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093678; cv=none; b=a1qQIKg+NXPOXAJeUvMZEaUP81TBrdtlQ+tstEvQo4af/kVZ+y5UKvIqTHDXythbtqdVTWqWLLdNxG1qItYdIF3/blLzy2T+hzOyTE6aljtL9Eaecuy/wCkGTBeqGsKSn3UA63FYSxTbI04pReUcQOyeeYm99yuw9PNPnWal0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093678; c=relaxed/simple;
	bh=pgFxqGAQp+Jbjst2v4JxQJa+SsIy1azpU0PNq1V9v3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtQf/R0o09TLhQRrHTLphScY9SXC6wnfG7l5/d9v1mWdGCRJiJc0hP7GNmxiwP+eXlK/RVVrzJJ8htZHpCa2YJGgxhfM+DNJvmWfZuJW9OkS/YUpSUCR8f07jmRZFHveCATxB6/FDTcCkKiwAnuKNfOKn3l54WYmMTViCnz81/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS3m3l4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS3m3l4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29EC1F000FF;
	Fri, 11 Sep 2026 02:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093677;
	bh=5bIHO22EN02/QGzQPQr8hCNfeNYUgRxD5Afm9q+ev7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KS3m3l4s8h6zsC9Pph7GfeaD7l4EL5yHL98YFMFbFTT3vpgsM08WjxwoBPxV2IWi8
	 3i27RlkIeQuZobe0PbTgVlvaQEnlZg1fVNsjooyZgmZVUNkmmCV80iMJBXUn57c+u3
	 rNnC8mXTz6oFGpvQbW9VwzJtdWCBzng+kG0tfn6BUjM6BJJgLgsmn2TEJ+3WPaAWZv
	 FcaVxDIlNayrSKP19OVzZmlhMPZeV1XgM1bAyxiwfIcaxyBBESzA18QI5FEaIdLmYt
	 6Ytl8PTRphmk4k+xMplVdGCkMl8yTSlruQ6a66CFWHLmFdwSSpG/pGgXtK73R6KI1Q
	 Pz9ZYrmL3z6ig==
Date: Thu, 10 Sep 2026 19:27:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taylor Bates <tmbates12@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] tools: ynl: fix uapi generation for
 anonymous enums with documented entries
Message-ID: <20260910192756.60854af6@kernel.org>
In-Reply-To: <20260908-ynl-robustness-v1-4-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
	<20260908-ynl-robustness-v1-4-f255214c0f30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 19:45:10 -0400 Taylor Bates wrote:
> However, this check still passes for anonymous enums since
> enum.has_doc() still evaluates as true, so they still take the kdoc
> code path.
> 
> As a result, this path attempts to hang the entry docs off of
> enum.enum_name (which is of type None), raising a TypeError.
> Both the ovs_datapath.yaml and ovs_flow.yaml specs will fail to
> generate uapi headers in today's tree:

The generator only supports what's needed for in-tree families.
Any changes have to be reviewed in the same series as the specs
that need them.
