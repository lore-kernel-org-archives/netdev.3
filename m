Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077D332EDE
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117086; cv=none; b=StApo/TegGPy25zpDTubiTLB8tk7tsZU574cWrUEzCP1y0Hu9R4vLuf9CYopTBaNRo7keYXk8lwu0biiF+329pUd994hX4hZsm0eUKi0YyiPoHzmFt9iZgtndVCabHOu+l6qprBr2nNwwQbWGu20s//7gUokix+l3Msabu3bTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117086; c=relaxed/simple;
	bh=ye7kpK2zWmIcTnbG26joWR7AQj3PWyaMFUw2iAtZX7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntew7QQ1YFyBswVnqF+hqwda/iM319aZV4HI145Cj96k0qdEFt1cwLxURDzHs8d29P73/ojd75mxXSlviPima33FoMvm7Br9Kp4jJspwsEI1fxU4yica7b+1mNAhM6lqlkzTEBWpXuxvr8ogM0Y4fabuFLKrulDhEoZ6tnU9ue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xETSL/CI; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xETSL/CI"
Message-ID: <67ad3005-f515-4ac6-840d-ded8c2e765b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780117072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WftpDmkUseUPqI6KNYiMSpF6LyvvnhSZDSRyHeruLWA=;
	b=xETSL/CIVF5Tu8garZw1ou0tgbk4IQaSJmVYTpg8VgIa1kwULyTUefrp68cPQb/s6wmsoo
	jqqoLgvEAwfLeRNJ4kggAc0USIJazjiNY3GvGriV8Dre9X1XogbiagyXL07IOLYN78J9q7
	OGT6CFGI+p5vsLLN39DZyVU/OGrXFzM=
Date: Sat, 30 May 2026 12:57:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>,
 'Daniel Borkmann ' <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org
References: <20260529203909.1222164-1-martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260529203909.1222164-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/30/26 4:39 AM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau<martin.lau@kernel.org>
>
> I am making a life change and will take a long break
> from my current work, so I will step down from the "M:" responsibility.
>
> I am currently a "R:" in "BPF [GENERAL]", this part stays unchanged.
> I am folding most of the parts into "BPF [GENERAL]".
>
> For "BPF [BTF]", it is long overdue as I am no longer involved.
> It is folded into the "BPF [GENERAL]".
>
> The "BPF [STORAGE & CGROUPS]" will also be covered by "BPF [GENERAL]".
>
> For struct_ops, its usage is no longer limited to networking,
> so this naturally should move back to "BPF [GENERAL]".
>
> For the reuseport, it will continue to be maintained together
> by "BPF [GENERAL]" and the "NETWORKING [SOCKETS]".
>
> For other "BPF [NETWORKING]...", I am moving myself to "R:".
>
> Thanks!


Thank you Martin, and best wishes for your long break.

I really appreciate all your guidance and help over the years.

My first kernel commit was guided by you, and I am still very grateful 
for that.

Thanks again, and take care!


