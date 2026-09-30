Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B84FC8D2
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777071; cv=none; b=UurVcMfkTYFQK8PmcZNSshHc9QyQm0qyvyq09yEHAnWvhqIseWFYE/wyb50releWiY3nQnu6XHttPw/2IEBJgGkLuNStOqpMfQkluLvbeY5AwwJpGVYEwhEAyDkXu/S964NYqde034hM5069CdmQ5s+rJ+9HtD1ALbMNuHWFXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777071; c=relaxed/simple;
	bh=bTlzFUOoLsXskjH0l1jHEaOdwVBHaDbBueIFIf22uqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLH1iPQMCMSmXOCeINR9rJE0oXMc+Jxxlb9LGs9vMNJE0mAVacP91bNhuM9vJbXExqe92CILLoM2Q43ftvA8TvsA19aUzyrDxGQGj0IL61uhj4BgUbfgNPd1dVp9iTTUoN8fJ5N+wPAEbP3XweWaEoDtLnKs1E0kDpk6Ur/5RU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLDxzch2; arc=none smtp.client-ip=91.218.175.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLDxzch2"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bTlzFUOoLsXskjH0l1jHEaOdwVBHaDbBueIFIf22uqg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790777052; v=1; x=1791381852;
 b=PLDxzch2ec2p6D4FVQCLPVsLWq5ZWa4793ufHKeJzNyLvZrjsEPLgXJToksBIiIT882h7ApP
 JSo6dZ+EsdoIzupXmXa4e1uRvIiB+6WWvY5eT4359lgxPhoYEpt3f9NHYSSjxQQFxrYUuiJlwKG
 zPjuCTU03srTUQMaJSLCpLwY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4463098d89d469e3;
	Wed, 30 Sep 2026 14:04:02 +0000
X-Mizu-Trace-ID: 4463098d89d469e3
X-Migadu-Flow: FLOW_OUT
Message-ID: <79fda08f-46e5-4f98-8051-92dbebb1de73@linux.dev>
Date: Wed, 30 Sep 2026 22:03:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
References: <20260930100937.206377-1-jiayuan.chen@linux.dev>
 <20260930100937.206377-4-jiayuan.chen@linux.dev>
 <CANn89iLwivMvNWC0oDgmQgTcKjrj_Ar8deh7Bc2jqyRXwv52tQ@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLwivMvNWC0oDgmQgTcKjrj_Ar8deh7Bc2jqyRXwv52tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/30/26 7:21 PM, Eric Dumazet wrote:
> On Wed, Sep 30, 2026 at 12:10 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> beta_scale and cube_factor are computed once at module init, and they
>> need 1024 - beta and bic_scale * 10 to be positive: beta == 1024 or
>> bic_scale == 0 crash right there, beta > 1024 or a negative bic_scale
>> gives garbage or wraps to 0. Negative beta can also make beta_scale 0.
>> Reject them.
>>
>> A small beta also gives a small beta_scale, and (cwnd * scale) >> 3
>> truncates to 0 for a tiny cwnd (e.g. 2), so the TCP friendliness loop
>> never ends. Clamp delta to 1.
>>
>> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>> Target net-next since it is not a big problem.
>> ---
>>   net/ipv4/tcp_cubic.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>> index 119bf8cbb007c..2f04dca5be095 100644
>> --- a/net/ipv4/tcp_cubic.c
>> +++ b/net/ipv4/tcp_cubic.c
>> @@ -298,7 +298,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>>          if (tcp_friendliness) {
>>                  u32 scale = beta_scale;
>>
>> -               delta = (cwnd * scale) >> 3;
> I would prefer not adding a test in the fast path to work around
> silly module parameters.
>
> beta_scale is computed once at module init, we can make sure it is >= 8
> there. tcp_snd_cwnd() is >= 1, so delta would be >= 1.


Agreed. beta_scale is 8 / alpha_cubic, so >= 8 just caps alpha_cubic
at 1


>
> With the integer divisions, beta_scale >= 8 iff beta >= 512,
> so the default beta (717 -> beta_scale = 15) is not affected.
>
>
>> +               delta = max((cwnd * scale) >> 3, 1U);
>>                  while (ca->ack_cnt > delta) {           /* update tcp cwnd */
>>                          ca->ack_cnt -= delta;
>>                          ca->tcp_cwnd++;
>> @@ -504,6 +504,11 @@ static int __init cubictcp_register(void)
>>
>>          BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
>>
>> +       if (beta < 0 || beta >= BICTCP_BETA_SCALE || bic_scale <= 0) {
> bic_scale * 10 can overflow if bic_scale > INT_MAX / 10


Right, will add it.


>> +               pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n", beta, bic_scale);
>> +               return -EINVAL;
>> +       }
>> +
> Something like this (untested) :
>
> if (beta < 0 || beta >= BICTCP_BETA_SCALE ||
>     bic_scale <= 0 || bic_scale > INT_MAX / 10) {
>      pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n",
>        beta, bic_scale);
>      return -EINVAL;
> }
> /* Precompute a bunch of the scaling factors that are used per-packet
> * based on SRTT of 100ms
> */
> beta_scale = 8*(BICTCP_BETA_SCALE+beta) / 3
> / (BICTCP_BETA_SCALE - beta);
> /* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >= 1 */
> beta_scale = max(beta_scale, 8U);
>
> Thanks.
