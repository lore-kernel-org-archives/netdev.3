Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10C14A91
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660390; cv=none; b=R0DZ5zcyrZEQeKtqhy4aqiczLmAj/Oo9MbVETI8Vky+6QGjA+aLDrJVRDLWWqmIfgVnr1oDMjgKpaLhGTCOzSjReJvLvlhHgURj8i1gZLdmV+8tz9O3Y/nEiDFqr7GPuc9B4zcVG9ShyC2xBNEa4vnP0Jd0GVUyMq6KdJxhpkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660390; c=relaxed/simple;
	bh=t533MWAjxekx1RdhNKfbpM/O6kjNk+pdE1l8KJDfeb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMOq0ekcXCh3Tv406sl9PKmSYk5JhJMNhVH1daCVLeEyUyeX8N/BgzFjXg5/ypbDDAkMjnD0vdvlIEX2BeT0KABZh1mLinXgGQgEEcCJccAA8QE3u3cRq2pCK8vxCG8M6bILTG/7LWGEkbAji3QZ3iUpT/Dm1JgElf1ldeQCzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqyrUj1D; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqyrUj1D"
Message-ID: <285ba391-1d23-41be-8cc4-e2874fbcb1af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760660385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2x7hwEg4kXyGUAy6uSa91M7KYOv6YwYGll5TDIncFg=;
	b=RqyrUj1D56mcLYbMpUohK2wRlgWEojwCL4YrImFR8tyId9kUVrPITZA8EFNX/J2XpunGNP
	xlEAnAFAYSzqGtxlq8dUf94xQiqMVUV7TD9P0N+8vUDb2HrozXR7H1Fr1jIhOgEHLMdHLp
	OJnsq9vZqus+O3MR7efO+n014z6nPfo=
Date: Thu, 16 Oct 2025 17:19:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with
 struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251016204503.3203690-1-ameryhung@gmail.com>
 <20251016204503.3203690-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251016204503.3203690-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/16/25 1:45 PM, Amery Hung wrote:
> Each associated programs except struct_ops programs of the map will take
> a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set,
> is always valid. However, it is not guaranteed whether the map members
> are fully updated nor is it attached or not. For example, a BPF program
> can be associated with a struct_ops map before map_update. The

Forgot to ask this, should it at least ensure the map is fully updated 
or it does not help in the use case?

> struct_ops implementer will be responsible for maintaining and checking
> the state of the associated struct_ops map before accessing it.

