Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6125A2BB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924479; cv=none; b=FAQRd6fGGqNfx5KVpLupYZMcYK3i/5abevRQeS6826HAM4UAPKDRZVbyYxVMcWSBTXFDKmmYSvxDT3VXdvTLECu07WTKE0EMbZHuehACzvcbG71quw/e3tFV17vMdoNJGLcbBGW16ijyMufqPokMOrx4X5ev001SDhZl+uSnGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924479; c=relaxed/simple;
	bh=D1bGgDLTsoM4sMHZzIX6xiFO2h0wOvXawHu7jT5o9Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeVLw3wzjvu6+F3luYqwdWuIH9pxtSjTuuaHDH0bKAKLwWIdrXscUjQtkjY5rE5BqI07X//tXeRD6EjMZPdUL7hTtfG1TaZ2k4Fig1LMMvtRabUqg7aD3rmp5M5cm8SzkXPv7AHeQ8rYsH77Hx/tkZyxm5iVIs5WjgLpweSJ4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLYDfwK+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLYDfwK+"
Message-ID: <0e89ceb5-a2ae-4e7c-8fe2-5b6a89ba6ac5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780924475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5cjOvMp5+XOuezkcj/1kNRUJs/JtZaiXyIj/tVZEek=;
	b=PLYDfwK+/LOc9sdOejSTfW46zTnoYbJl6ZUncdH5ISqhh7yHv7sH7VIxrcaSxtjKjaxm17
	j9n+6D/J5kdeEADJV10jjNwTamG91smxR+5MkGYgiTFyLYIGQerJwINkh69ETSxfmXEfSq
	Zmh5HU4ebnXsMc6C/n8qgWNGZ3jP0AA=
Date: Mon, 8 Jun 2026 21:14:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
To: xietangxin <xietangxin@yeah.net>, Willy Tarreau <w@1wt.eu>,
 Eric Dumazet <edumazet@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Zhouyan Deng <dengzhouyan_nwpu@163.com>, Florian Westphal <fw@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
 <aiaOor1JLLu5Xn75@1wt.eu> <90cb7e92-2451-4c67-9f35-6ff96b7efd77@yeah.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <90cb7e92-2451-4c67-9f35-6ff96b7efd77@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 8:51 PM, xietangxin wrote:
>
> On 6/8/2026 5:42 PM, Willy Tarreau wrote:
>> On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
>>> On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
>>>>
>>>> Hi Eric and netdev,
>>>>
>>>> I noticed a significant TCP performance regression (QPS drop) when using
>>>> iptables MASQUERADE with the `--random-fully` option, and I have bisected
>>>> it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
>>>> (tcp: secure_seq: add back ports to TS offset).
>>>>
>>>> Here is the benchmark environment and test results.
>>>> Environment:
>>>> - Client & Server: 2 VMs
>>>> - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
>>>> - Benchmark tool: wrk (short-lived connections with "Connection: close")
>>>>
>>>> Test Commands
>>>> 1. With random-fully:
>>>>     # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
>>>>     # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
>>>> 2. Without random-fully:
>>>>     # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
>>>>     # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
>>>>
>>>> Test Results (QPS):
>>>> 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
>>>>     - with random-fully:    18145.74, 15006.39, 15716.67
>>>>     - without random-fully: 18556.36, 16339.22, 21506.02
>>>>
>>>> 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
>>>>     - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
>>>>     - without random-fully: 17310.75, 20279.85, 18399.48
>>>>
>>>> Is this performance degradation an expected side-effect of the security fix,
>>>> or is there any sysctl param we should tune when `--random-fully` is
>>>> required for high-concurrency short connections?
>>> Hi Tangxin
>>>
>>> I do not know why that patch would affect MASQUERADE performance.
>>>
>>> Pablo, Florian, do you have an idea?
>> I suspect it's because MASQUERADE can shuffle the ports around and
>> break the end-to-end mapping. With host-based ISN the increments
>> remain positive regardless of the ports, while with port-based
>> increments if you shuffle ports around, two consecutive uses of
>> the same port can end up showing a decreasing ISN, and some
>> outgoing SYN will get an ACK instead of a SYN-ACK, then send an
>> RST, and a SYN again, causing a degradation.
>>
>> I'm not saying this is necessarily what happens here but based on the
>> commit message description I suspect that this is what's happening
>> here. There's always a tradeoff between ISN secrecy and reliability
>> unfortunately.
>>
>> Willy
> Hi,
>
> Willy, your hypothesis is 100% correct!
> I captured the packets during the benchmark on the bad commit,
> and the trace perfectly shows the "SYN -> ACK -> RST".
>
> Here is the key snippet of the packet trace (Client: 10.0.0.2, Server: 10.0.0.1):
>
> // 1. First connection closes, Server sends last ACK(410615916), entering TIME_WAIT.
> 12105 08:54:39.128861 10.0.0.1 -> 10.0.0.2 TCP 80 → 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827652 TSecr=370383870
>
> // 2. ~200ms later, next short-conn reuses port 47824 via MASQUERADE --random-fully
> 47637 08:54:39.332281 10.0.0.2 -> 10.0.0.1 TCP 47824 → 80 [SYN] Seq=559739866 TSval=4137539723 TSecr=0
>
> // 3. Server is sends a ACK with the old connection's expected ACK(410615916).
> 48591 08:54:39.337692 10.0.0.1 -> 10.0.0.2 TCP 80 → 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827858 TSecr=370383870
>
> // 4. Client receives the unexpected old ACK, responds with RST, and has to retry the connection.
> 48600 08:54:39.337799 10.0.0.2 -> 10.0.0.1 TCP 47824 → 80 [RST] Seq=410615916 Win=0
>
>
> Are there any architectural recommendations we should consider here,
> or is this considered an acceptable trade-off for security?


It's classic PAWS problem when packets go through NAT/Gateway.

Can you test the performance with following different two configs (client) ?

     sysctl -w net.ipv4.tcp_timestamps=2

     sysctl -w net.ipv4.tcp_timestamps=0

