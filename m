Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459F44A416
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292737; cv=none; b=MolnM+Yfg8/6qkblKCuEklsgm+WCvmlTDiWVuYcdjOfNoen5BOxeydMLkBs8DFYnVAhWQYmqGX9i6FAN22ObV6a1+rgSqlI5/xcR2g4CRiLaicyTDaSx3ZHFaScVVabcWZ1M1E97jetIiobgvyMSbp18TG3z1KTTzYmwqLRvDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292737; c=relaxed/simple;
	bh=MGdskzSxiD/sw5yijXuFD+ea1ERwLtruXpAWf4rJoKw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DZr16eT5DPCKPnuLZAiXLH8JJYX/58Kdf4nRwZBwavsyHTBuxNueIIzZ2E3rqkGUgSb0PP1eRGU0mKji6gAS1ICypnzHJMj9MfJNIW1e6TIaF8ZAmRfqOvHKLokFRkRkLjrGkYxDjbnzUZzHGe2KuYfiHe3g4hMtTsqnm/z9Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=S8+Wf7Th; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYsXmG1f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="S8+Wf7Th";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYsXmG1f"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 953B51D0004B;
	Tue,  1 Sep 2026 15:58:53 -0400 (EDT)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Tue, 01 Sep 2026 15:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788292732;
	 x=1788379132; bh=HtBurZwaMJiQvnqDWg1tU15j20OMcl43cDl3tYDzqnM=; b=
	S8+Wf7ThrHIK+esmrlnat2sh/nk72Ag7bHCTQxQL11LTmLTuFn5CO2jcdCFeCvmk
	J9nL7YSGSN920AGOn90p82DBq3vCpPOdyA6xZPzwkMRE6prf9q3UF6NACiNUxjGj
	nDpF5yam8vYB5eeo1uYnSbtss/1dEVoaqXs0XtCwDQI5Lf6m0Tfb9xvSMYFnd51H
	9LGdPHZTntXDofKVzFIHxcn+DUJB6tTBNqmpJcRyvBuROk7iw7EdiI5A8riUMjkO
	QEF4y+SogoW0eLWr9fbVctJHno0CkdqOtkI1NGRzhE08duybG78MGMmFbuhdCglC
	ZZp7eavEdyDzYXt4/5AiDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788292732; x=
	1788379132; bh=HtBurZwaMJiQvnqDWg1tU15j20OMcl43cDl3tYDzqnM=; b=m
	YsXmG1f15cQjiMJxSD19Ptajvuwi0tzeTgzgFPPnz8aM3zLp+U2bT4j5J+zDcUYn
	MtIb/cxu6vjq64RRLbOoIXGTBEx0UDOv77sa8JBNVjJP5vTL7O4XLsqq3ZoY9FVQ
	tJiTShelMIdZ5dL2u2fcvSegZKgyqCKXCIVIme5FnegrqqpSeWwejrZjTTzGKlya
	1L+Vl7OI0cUcCdU0uE2MY/D/K2QQAVFjcs3QulRaUyhynfDJMZAiqSj0ctobF1fB
	2QB088dF40Nj8fmAiDPpBsudWYZwhW17xgXUUHqLZghwW4aP1jwvB6hLyqLRqFBv
	fi2ouxUQikeYPvUN67XJg==
X-ME-Sender: <xms:dy6XamYamL1OoTQTFdUnjTaN18mB2oFUCp42EM3dMdTQnAv14PWvag>
    <xme:dy6XakO1EQdFCzrUOEwIBZdzra_IHYhg33gBpSgagi_p-W6bX1tvm9YuSrTHLIUj2
    rVVkN_47hkqR8fhmebC1NnJFNF7Z-SZ8hnpKbdc5kZrtXsNzz4OINcw>
X-ME-Proxy-Cause: dmFkZTFIHQXSi4Mh6AHi8Mqru8yFrihET0luYnl2VjfLYDmNlqPiiN3ud+DyjDTr5iKVoU
    gIXQJaLXLPyJIrtnZm1RZgw9LS3UN37nNKIza0+tjEqL+8piH4cK50rmi8GfYkOmyxSTYP
    LNGCO3tM55AcJZSUkKAvg+tBY0KY0xqarZyfhQ+hIq6jy8brwpBYejZL9a2HFtwfgdGfTd
    FcZj1bbP6KqXtTYSP0pXlgFs0nYlzEWWD8qeH7MLW151G7laNuoONSX1mkEgO9NbDGIxLH
    4VjySY0K0NJgOXoKKct1Yyz+CleLFGKml7JjK+ibgxpIxTWE0qIW1cgieKouQT+XWwElUL
    xQkQ781rJzPFfkRN6Bv6zEPRtabk2FCa3LRb7Kvdjp17TeiwoDv3PjtxzuuXPW6Sq90+6h
    qMd/U57jjwTP6+w/Pc8J9e0ej6V+AlxdrhJCNRI5NM+a8RedHYnm9JwZvEq88uwiXVI74w
    VfSOLq2Uo8UH2m/V/Gy74VV7hZpsG++n5Gk1vHezPxXANmmFw1ZmEWGO43G/2jSt7N9SKU
    IWxJFjmI73u1LbeDnLFKe+LVo8uhLu8rQsdXQSRJAsMiYuRvXluTQ44Tx4neIQ/4WuIaeu
    uAzkReH6aiRHqemcUZXa5yFwFBR4ITVbiKKsnU3A2mtdR/1tkk3RLZp1W4WA
X-ME-Proxy: <xmx:eS6Xaiq4aMYQNwYEwwuRfAZp8Lj94XgXaQSwwDevIktEybixMXg7rQ>
    <xmx:eS6XanLFMSijjP5Cn-CjYWhxpKrRvgmDcI2lL0yrwqbfW5CGSTcwHg>
    <xmx:eS6XalOIl06E-IsWyEYTnsJH0ltdkCihRVdnzzv_oS6cIPQjB_ey8w>
    <xmx:eS6XakrpLU_4gCxQVc1ygai8KHDsn94QX24V543mkDwR1-yID4_oMw>
    <xmx:fC6Xal0mONOwPSTyNh5B4cGlChZezN9XsUuhT0nwvbIkH8Rz9XQ-x9Wn>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id ED4892F8003D; Tue,  1 Sep 2026 15:58:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQCaIXmGAEe7
Date: Tue, 01 Sep 2026 22:58:26 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Jakub Kicinski" <kuba@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Cc: "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>,
 "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
 "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <b9144a73-a079-4442-91a5-bd5a5557dd0a@app.fastmail.com>
In-Reply-To: <e01d7fc0-cc3f-4a52-a587-f9087f1c787d@app.fastmail.com>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
 <20260825200215.90326-4-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.3645a45d69737@gmail.com>
 <20260827122856.4b6eeb96@kernel.org>
 <e01d7fc0-cc3f-4a52-a587-f9087f1c787d@app.fastmail.com>
Subject: Re: [PATCH net v4 3/4] selftests: net: Test UDP length overflow with PMTU
 discover and big MTU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 28, 2026, at 23:35, Alice Mikityanska wrote:
> On Thu, Aug 27, 2026, at 22:28, Jakub Kicinski wrote:
>> On Wed, 26 Aug 2026 13:18:18 -0400 Willem de Bruijn wrote:
>>> > +def check_dmesg_clean(func: str) -> bool:
>>> > +    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
>>> > +        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
>>> > +    return res.returncode != 0 and dmesg.returncode == 0
>>> > +
>>> > +
>>> > +@contextmanager  
>>> 
>>> Interesting approach. In ksft the built-in defer() mechanism may be
>>> preferred. Not sure.
>>
>> +1 small preference towards defer() if Alice is willing.
>> It's be more idiomatic for our selftests
>
> No problem, I can switch to defer, thanks for the suggestion.

I replaced try-finally with defer, but I also kept dummy_netdev() with
@contextmanager, because otherwise it leads to code repetition between
the two tests (even if I put ip setup into a function) and increases
indent by two levels (because it would be no longer possible to compact
these four with statements into one). I.e.:

    with (
        NetNS() as ns,
        dummy_netdev(ns, 65556 + 20 * ipv6, ipv6),
        NetNSEnter(ns),
        socket.socket(af, socket.SOCK_DGRAM) as fd,
    ):

vs

    with NetNS() as ns:
        ip('link add dummy type dummy', ns=ns)    # this repeats
        with defer(ip, 'link del dummy', ns=ns):  # and this
            ip_setup(ns, 65556 + 20 * ipv6, ipv6)
            with (
                NetNSEnter(ns),
                socket.socket(af, socket.SOCK_DGRAM) as fd,
            ):

I think the first one is better. And yes, I need to scope defer with
with, otherwise it's scheduled after ns is deleted. I haven't found any
other selftest that would do that, but I see this functionality is
implemented in the defer class. Hope that works for you, respinnning :)

>> More importantly ruff check and pylink --disable=R have to be clean
>> for new tests. The test cases need a docstring explaining what they are
>> trying to test. The helpers can probably get a _ prefix to mark them
>> as private and silence the warning.
>
> Got it, will do. I thought it was OK, because all tests I saw didn't
> have docstrings.
>
>> -- 
>> pw-bot: cr
