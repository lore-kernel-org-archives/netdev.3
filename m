Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793410103;
	b=aTMaateYw9iOaT3dAvOdWRv7KDt/awG5/flj+AAGp8PUbifIi3sn9wauEHMgqJUKhr7/
	 e0VGAjMYN6U1960gUoO7uCgZKFyXwv/6koA8V0QvtQRrRsrfZr86FqP5Xvq206oII3dck
	 U+K4CG90+93tWHMd/6l9WjnTGOUjSo5DujX47FbubZDE1UTVN9dZ6/dFHK6j0rb0QG7Ml
	 9i8twiaEDOkC32NkqJh14cqJ8pEVpQ1tkVxY58bgr3fc2CM75qH5j6XmSfNKtY/5L7OEy
	 cdZlpRPqy34OZR82AZBIZhE6ZevshMYgD7U/dOajPdKspjjfXEqPS0qm9rVrjFky8GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410103;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=a6ooV5rVY1GQuE6ouKZNNisI0guDE/GpOjIpdYXk4Rs=;
	b=TeHeuH234Sy00nq4O58w2R5oIkoAtQN6C3QFbxI4UyZlnGJOydDDkDQ+xO5nWuxWUD/b
	 HircdMoyyLmcHzadYwr96sLi8UHSye6FIvpmMEbIT5nInh9AoLZ1RX0kdEJZCZ/PAPhj/
	 SBNbJsSOWjJvwsQJ7eICZauBjAvVbozqAnsbuP9BpHeBjrfR0hZi6nuAWXcn8vKopOkKc
	 HyShYreJhwTjWMnrf1zR2zQNNXkG34IuNaFXqINCriKMtg51Rwe6MDOEeswMhlNcj4+tU
	 hrknG+qVYQBlnTdSOtx2Qdn2I6jtEbdlxRnTv6vsXGmvVWrVEbei4U+/mERwFZzqvuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pq9hKRpu;
	arc=none smtp.remote-ip=95.215.58.234
Received: from mta1.migadu.com (out-234.mta1.migadu.com [95.215.58.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5F606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 01:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pq9hKRpu
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3UXlybLI0iJDYqrDEMOmBWP5abFQsCQpxQAYz2OkJnc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793410100; v=1; x=1794014900;
 b=Pq9hKRpuxr+cse55KGlwBn9UFzX5RIiJ1S35PW1gNCjs0PtQj8h6TeVzFoalPYOH9HIbQEbp
 L2iK2eodgtisxDXfBuuqNCl2dJbsPMaZGJDw3H9zHuZminoWJ4nt2nch5lnWSmU7gGgGQPLNHKl
 9agD44Txr2eIAuuH5lPUvoDQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1701bc76d040e0a1;
	Sat, 31 Oct 2026 01:28:19 +0000
X-Mizu-Trace-ID: 1701bc76d040e0a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <84396bab-166b-435f-9663-0aa2939de3fc@linux.dev>
Date: Sat, 31 Oct 2026 09:28:10 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ppp: remove SC_MUST_COMP
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, norbert@doyensec.com,
 hataegu0826@gmail.com, paulus@ozlabs.org, Brice.Goglin@ens-lyon.org,
 akpm@osdl.org, Matt_Domsch@dell.com, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029074935.40509-1-qingfang.deng@linux.dev>
 <179339596607.3131.10030375792154782283@kernel.org>
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <179339596607.3131.10030375792154782283@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/2026 5:32 AM, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Does the fix need the define to be removed from the UAPI header?
> 
> PPPIOCSFLAGS already masks the user value with the kernel-internal
> SC_FLAG_BITS:
> 
> drivers/net/ppp/ppp_generic.c:ppp_ioctl() {
>      ...
> 		ppp->flags = val & SC_FLAG_BITS;
>      ...
> }
> 
> Removing the bit from SC_FLAG_BITS (and SC_MASK), together with the two
> checks, looks like enough to stop SC_DC_ERROR from being stored as a
> config flag.
> 
> Deleting the define is a separate change at the source level. Userspace
> that includes <linux/ppp-ioctl.h>, directly or through <linux/if_ppp.h>,
> and refers to SC_MUST_COMP would no longer build.
> 
> The commit message calls the flag unused, but the evidence is that one
> pppd integration from 2005 never landed upstream. That does not rule out
> out-of-tree pppd MPPE forks or other daemons that use the name.
> 
> With the Fixes: tag pointing at a 2005 commit, this header change will
> likely be backported to the stable kernel-headers as well.
> 
> Would it work to keep the define, with a comment that the kernel ignores
> it and that it aliases SC_DC_ERROR, while still dropping it from
> SC_FLAG_BITS and SC_MASK and removing the checks?

I found no trace of existing users (searched GitHub). Even _if_ there 
are any, _and_ SC_MUST_COMP does not alias SC_DC_ERROR, the logic is 
still flawed - received packets are silently dropped without noticing 
the userspace.

If the goal is to prevent the removal from backports, I may split out 
the removal part into a net-next patch.
