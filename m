Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032914;
	b=szpJikSQynIiwKRR3aEmmliAIJH5cqpi0Z94SBhmLB1jTVvrYSD0wb6IJAlHM2lMxOhW
	 1/MUielx2n88vNd+2fM0JxC43dBt43jb5Ia7UXKgSvFJoEfVH7eDqJIlgcEMZg23/mZo8
	 uU0MLzm47RbioR/ZJQMxEEfskizpDFvj0KpIi9avgf7zW6yOCZC8z2DgGmbad7OG02jZ6
	 rHyx4Gyodd//auHvUqEDHLkm9S1hYayAP5NWXzPgifiKmt0i37EfoxwY3LBqFmCknMMww
	 jm7ENSeHG67N0BI6/q2QODzd++6ANBpC7qcbW8+5tL9GSJernlk/6lJQ76Z6I50d0rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032914;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8BLz7jh82X3kdchLvuHLNEr+rBE+RRJ328lUpRRqtMc=;
	b=XvOUP+LxcTmsp4U3XKP7uSAQJNjJWy4gHWmuUz6lcbWCWWxaYodAnaVMV6pUNn8xdGVS
	 QLcojzbmGEiw6sd7M61nENxB8eLHkpN3DefXRYbuotI18aormUL5FwiweYerYmDWei1fp
	 r1/FyAacTIAOiGIK88iOD/gvlyhJnIs3vjQdUs9QD4NnEqNfuuvcU6kbMQkoD3Y04yWBV
	 tdhv3oicZpZjFTVmlcBOpOh2+Xv2tXajnQifS60QFqjt9VLadokjLjUbVJnYmVB4v79TK
	 +b/UNHuRi+wlJzwrlJkLpXEMqVekob4oFTze0CNRFjAlo/C++QAfXwvzMWbuF9+uZ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C31mKlqm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26A606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C31mKlqm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1536A1F01825;
	Mon, 26 Oct 2026 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032913;
	bh=8BLz7jh82X3kdchLvuHLNEr+rBE+RRJ328lUpRRqtMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C31mKlqmmGChkrRoChZhow2IssRlgZh16JtLFdntmdsehTtlJoDbktckN4zLPey/C
	 zve9q/GRNhIRloqgfUzDXNt/NsuE7ImcO0hn12jxA7m/tjtv/jhS53bSJWjwVvUmaY
	 zCoeRthQ57QfZcVHfxUBK3YJaJUD+xTyT8Xtbnej0jt/plDFv7pnl6uSG1yV5fmulB
	 tIYVwbbL77n7KFNUfQzMYxXBwsWmkZBUyLQ+WsmkZJ+9oVo6N66OGP010Rkm9j2l5B
	 YbowwSvSs8XyhOuCYquHD/FLpcm4/Y/+lLwsieD9nQ2WmXwdanXslJzhNMIbGevu6t
	 AJR9ePI7I/AEA==
Message-ID: <a9e4655a-0a12-4b40-9641-36e7acc2cdcd@kernel.org>
Date: Mon, 26 Oct 2026 17:41:51 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] Google's Netdev-CI: a few flaky tests
Content-Language: fr
To: Sheena Mohan <sheenamo@google.com>
Cc: Willem de Bruijn <willemb@google.com>, Netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <224334a7-150e-4794-af72-596c3821558c@kernel.org>
 <CADWJPTundpvzkpJrxva=M+6YF4zQ9dRSY78Xypi9B1NuH58Usw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADWJPTundpvzkpJrxva=M+6YF4zQ9dRSY78Xypi9B1NuH58Usw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sheena,

On 24/10/2026 19:49, Sheena Mohan wrote:
> On Fri, Oct 23, 2026 at 9:02 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Sheena,
>>
>> I hope you are doing well.
>>
>> While looking at the results on the Netdev CI for the Google runners, I
>> notice some tests are quite flaky or constantly failing. I marked them
>> as "ignored" on the Netdev CI while this is being investigated.
>>
>> - IDPF: psp-py started to a month ago. I guess you are monitoring the
>>   results, but then if it is normal, it might be easier if you block the
>>   known bad tests from running on your side. Just in case, a few links:
>>
>>   https://netdev.bots.linux.dev/flakes.html?tn-needle=psp-py&br-pfx=net-next-hw&ld-remote=google-idpf
>>
>>   Because the previous branch didn't get tested, the regression might be
>>   due to the modifications introduced in the previous branch as well:
>>
>>   https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-09-23--16-00.html
>>   https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-09-23--08-00.html
>>
>>
>> - GVE: "queues-py" test started to fail recently: I *think* it is a
>>   regression due to the following patch that has just been dropped, but
>>   we will only know that in a couple of hours:
>>
>>   https://lore.kernel.org/20261021155611.68473-1-phx0fer@gmail.com
>>
>>   https://netdev.bots.linux.dev/contest.html?remote=google-gve&executor=gve-nipa&test=queues-py
>>
>>   https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-10-22--00-00.html
>>
>>
>> - GVE: A few tests are unstable for a while and have been ignored: do
>>   you mind looking at them, please?
>>
>>   https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0&br-pfx=net-next-hw&ld-remote=google-gve
>>
>>
>> - IDPF: sometimes, it takes ~4h to run the results (+1h to start).
>>   That's fine because we have a 6h window, but just wondering: is it
>>   normal? (The GVE runner seems to start quicker, but I guess that's
>>   because one is on bare metal and the other in a VM)
>>
>> Thank you for your help!
>>
>> Cheers,
>> Matt
> 
> Hi Matt,
> 
> Thanks for reaching out and flagging these issues. Here is an update
> on each of the items:
> 
> IDPF
> 
>   - psp-py: We agree that blocking known bad tests on our side is
> best. While we resolve these
>     failures, we will disable the failing test cases to reduce noise
> on the CI dashboard.
>   - Run/Setup Duration: The longer setup and execution times are due
> to running in a bare metal
>     environment. We are looking into optimizing this to reduce the duration.

Thank you!

> GVE
> 
>   - queues-py: We also noticed this failure recently. Since it is
> suspected to be a kernel
>     regression, we will continue monitoring the results.

It looks like the issue has been fixed when the bad patch has been removed.

>   - Unstable/Ignored Tests:
>       - devmem-py: Should be fixed by patch 4 of the series recently
> sent upstream:
>         https://lore.kernel.org/netdev/20261023204706.3112215-5-hramamurthy@google.com/T/#m0f075c545d9de1c0ad3bd95da0f009a82e80b6c5

Great! Indeed, it looks good so far.

>       - napi-id-py & bond-options-sh: We will investigate both tests.

When fixes are applied or unstable tests are blocked on your side, do
you mind pinging me so I can remove them from this ignore list, please?

  https://netdev.bots.linux.dev/contest/filters-hw.json

Cheers,
Matt
