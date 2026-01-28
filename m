Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEC37416A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623593; cv=none; b=Y0wciFVpN6yaEvfUhVDXo/QsMR9Mta5bHog16vOrG8lLLdwgfGWd2jJcWMJ3lhAygI9m/eDYZlLShcZ0UUBefdJ0vkUKMlntsIarxWqqQ70HZuWzlCa41SynEVw9aSITP3KPPdWgSmQ1tp1fm9hEEHKEotFxRSHZISE8/XpWa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623593; c=relaxed/simple;
	bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNqfiofPQO4wDCJNbHj0/2uF7BKgey1+w6Z8CIUvRjsxTXJm9NwnzUQ+Y4VfRYVwzg3jsfinagNdxUGvLDmKpU7qPYU5JdAi4xElUgZq9qZZTMAi0P93Ha6AfMk1DB4UmEuPQ8bl99zQoE9/xYou3KXkPP9JJVHJZcrArYAam9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H8mWeFsS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H8mWeFsS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c6a50c17fdso15810485a.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769623591; x=1770228391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
        b=H8mWeFsSdwADWoWWfEA0w+bwR8tO5PHsGO8YFyoPYpDKG0sMyli8Ex3dHcuo63SAE5
         r4Gn6lEHuyjoUITTiyG053SeObk1eqjhP5AGP/tx3s1n/WvyZEqqNNkdn1NUNZYB7Mj8
         1majS3rb6gLXjS9Kl/S4X/nshAyAfPVXIRkGKYhVU/ks0d1NMjTPrD3WCLJmYjQ7egD6
         x97U1qiMggsHkQCrXUdyxC1z1FymH3HVJjnhE46eO9UXV+l7ZKoGhkW9xrMgkFTt2Q52
         NAvCR/D387hBy/DvGoiX1EYiWKTjqS4Pw8T3QNUVmojUjIalMdRtayzMk2OEBNPw2Lzo
         IcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623591; x=1770228391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
        b=JQnYVNMoeAiuGAVHVlCOqW3J2NTowyZG+v2ivp1PCCUT3cVpMfZCBK5IdgsRwtb2Jk
         pVzrFxfbCkD8CEJGCMTryn3vM15tvSsaAj6Z/mc+dgtZLXoXkgb7bPRXassOAOzt5j1+
         BsOz1WuQ/APc+If5Z5eU0kRFZ6810bjEGg9eGdb+W3wRlMhWRZn11kKnNm778IDWQp4p
         FzylgOGzgn0xuoh9PGk5qXaw6qztp6iSdmkUPzW1ZKVhoZ9CvH4PcS+BdLeV1mnkeL4O
         RMq3sT/WXXGL9iaecAIf6FVrJ73sW4i6BDWt7IM77YA9RchsmYGh12sv0rJDuleXSXbk
         txRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw33P9o+D1LI7JPya7mwnMqnW+O91EIbftp2GCl4qioaPeG1QzSgwS1sww46Q22g6SvYhtfTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LfXhZAKk/0QALfbO24CZFX198oh1g0ZB2fsbFapGOxpNH9iJ
	kt3HjLHKYdLGfIrtGF1e6Cc11H6e9t5r7Ds2Mmf3lcUGQ/AMtN33GfT14r7xPdMrcT8=
X-Gm-Gg: AZuq6aJy/4SE8fiUYZKbHECZ/rU/TzAMTML1nqtzH2cV5im5CxoaUnMOsCNsFXyeJHl
	QGmvAeKI7EUnj+KnBT9L2RqC5p+RJUtVhjUTaTfuyYzLgKNscTOpUw7O5feLi2ZDCyHUgYE+6t9
	vBXP432iYgOwImaWWWtARwYjNIS/OKbhvBtvK5MTLQ9Rroqrf2tusHPBhLAcslVUqOFupB6Hx1T
	d+19HqHI6XWIqzuApJAPtG/X38e1BAxlrh/LaIYJldgQjQK0KZTdZVvEqhkXpBedksbS+Szb9qt
	7i/ns4GsDCZSBezAF595Yq5iFSqRFB2kSpY6n6P5LNLfGSE4cCSURg0NB/UxTInifIAUsI/DrSM
	7IeDDXWkYG/1/z/wCvcpcgpIcf0NKWlmh+5uNBxCORUEOMVNrAi9vK4w4MlzbjcyUvuFgb3SJp+
	2/p0kkDD0HhrJmu9J7Dv+rCo8sVVA2V0vMR/UmhmJVCIxcRkNFv6hycQQrDf44ktuQ5c4=
X-Received: by 2002:ae9:f404:0:b0:8c7:136e:bad7 with SMTP id af79cd13be357-8c7136ebb3cmr341643785a.85.1769623591045;
        Wed, 28 Jan 2026 10:06:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm21598586d6.45.2026.01.28.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:06:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl9vx-00000009aHB-3e3a;
	Wed, 28 Jan 2026 14:06:29 -0400
Date: Wed, 28 Jan 2026 14:06:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260128180629.GT1641016@ziepe.ca>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128034558.GA126415@j66a10360.sqa.eu95>

On Wed, Jan 28, 2026 at 11:45:58AM +0800, D. Wythe wrote:

> By leveraging vmalloc_huge() and the proposed helper to increase the
> page_size in ib_map_mr_sg(), each MTTE covers a much larger contiguous
> physical block.

This doesn't seem right, if your goal is to take a vmalloc() pointer
and convert it to a MR via a scatterlist and ib_map_mr_sg() then you
should be asking for a helper to convert a kernel pointer into a
scatterlist.

Even if you do this in a naive way and call the
sg_alloc_append_table_from_pages() function it will automatically join
physically contiguous ranges together for you.

From there you can check the resulting scatterlist and compute the
page_size to pass to ib_map_mr_sg().

No need to ask the MM for anything other than the list of physicals to
build the scatterlist with.

Still, I wouldn't mind seeing a helper to convert a kernel pointer
into a scatterlist because I have see that opencoded in a few places,
and maybe there are ways to optimize that using more information from
the MM - but it should be APIs used only by this helper not exposed to
drivers.

Jason
