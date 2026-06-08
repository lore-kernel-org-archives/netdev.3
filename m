Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69A26ED3C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923196; cv=none; b=b1tAK0agpwfY6FsV242x7g2+qmn13ZRLK69UB5q8MHTDB51Voc+MSz/YDv5lyfuwxDKViQ9654ACiQ773VfrKj2obR0RDtjYjVfE9dsKxxz9K+iV6vOfh43DXxlQ72hdCBkvthNggciGvRwaoYCCIzxWyZP5SeNISfGUykQG0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923196; c=relaxed/simple;
	bh=luI0GsFa6DCkgbP67Z8N7DXes6KLAeSwTMwWR8ROd7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1Rm7cRsMb0NUvfii5ZvhiyOTjiRfvknrSKqeUCr2MUQGzKIZunGF4H/zHnGoWg2RAGN0zj4ptyhDWYPTxGbNXkgqhT5TCplmrKbY9LTZ15FRrAdZGSxcW4FMYnFwQwmjDXuA459mSMgQgEK/ciYSL86127XgzVryfVs0ZZAaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iwyxNQ+7; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iwyxNQ+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=8ozhxclJCR2a/uQDARSrOxgUqlHwEZbradvhvehImBg=;
	b=iwyxNQ+7871Op3wg6eDZrpTcm5BHARpGlsZbytNcWO27jVG6NCmYps/Gp8OwTg
	UGbQZBgHC/BdOZ+0lUZibA+TJbQifXN8ru/oWdsZ8ga/SG1J+OKor6IDxSfs+EY9
	9Fl05z1C64tINsX7TjR9W7lqVSpb2R3GWonEVeyRbtQkM=
Received: from [100.70.220.18] (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgBX_0rOuiZqy0sIAA--.13885S2;
	Mon, 08 Jun 2026 20:51:27 +0800 (CST)
Message-ID: <90cb7e92-2451-4c67-9f35-6ff96b7efd77@yeah.net>
Date: Mon, 8 Jun 2026 20:51:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
To: Willy Tarreau <w@1wt.eu>, Eric Dumazet <edumazet@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Zhouyan Deng <dengzhouyan_nwpu@163.com>, Florian Westphal <fw@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
 <aiaOor1JLLu5Xn75@1wt.eu>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <aiaOor1JLLu5Xn75@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgBX_0rOuiZqy0sIAA--.13885S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw15Cw17ur4xZFyUJrW5Jrb_yoWrGw17pF
	yFkFnFyFWDJrWayrn2k3WjvF1YvrZ3XryDW3sYg3srAas0ka40vanYgrWj9a4jkr4vkrW2
	va1qqrsrtFZ5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiOBAHO2omutDYiAAA3i



On 6/8/2026 5:42 PM, Willy Tarreau wrote:
> On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
>> On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
>>>
>>>
>>
>>> Hi Eric and netdev,
>>>
>>> I noticed a significant TCP performance regression (QPS drop) when using
>>> iptables MASQUERADE with the `--random-fully` option, and I have bisected
>>> it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
>>> (tcp: secure_seq: add back ports to TS offset).
>>>
>>> Here is the benchmark environment and test results.
>>> Environment:
>>> - Client & Server: 2 VMs
>>> - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
>>> - Benchmark tool: wrk (short-lived connections with "Connection: close")
>>>
>>> Test Commands
>>> 1. With random-fully:
>>>    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
>>>    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
>>> 2. Without random-fully:
>>>    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
>>>    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
>>>
>>> Test Results (QPS):
>>> 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
>>>    - with random-fully:    18145.74, 15006.39, 15716.67
>>>    - without random-fully: 18556.36, 16339.22, 21506.02
>>>
>>> 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
>>>    - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
>>>    - without random-fully: 17310.75, 20279.85, 18399.48
>>>
>>> Is this performance degradation an expected side-effect of the security fix,
>>> or is there any sysctl param we should tune when `--random-fully` is
>>> required for high-concurrency short connections?
>>
>> Hi Tangxin
>>
>> I do not know why that patch would affect MASQUERADE performance.
>>
>> Pablo, Florian, do you have an idea?
> 
> I suspect it's because MASQUERADE can shuffle the ports around and
> break the end-to-end mapping. With host-based ISN the increments
> remain positive regardless of the ports, while with port-based
> increments if you shuffle ports around, two consecutive uses of
> the same port can end up showing a decreasing ISN, and some
> outgoing SYN will get an ACK instead of a SYN-ACK, then send an
> RST, and a SYN again, causing a degradation.
> 
> I'm not saying this is necessarily what happens here but based on the
> commit message description I suspect that this is what's happening
> here. There's always a tradeoff between ISN secrecy and reliability
> unfortunately.
> 
> Willy
Hi,

Willy, your hypothesis is 100% correct!
I captured the packets during the benchmark on the bad commit,
and the trace perfectly shows the "SYN -> ACK -> RST".

Here is the key snippet of the packet trace (Client: 10.0.0.2, Server: 10.0.0.1):

// 1. First connection closes, Server sends last ACK(410615916), entering TIME_WAIT.
12105 08:54:39.128861 10.0.0.1 -> 10.0.0.2 TCP 80 → 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827652 TSecr=370383870

// 2. ~200ms later, next short-conn reuses port 47824 via MASQUERADE --random-fully
47637 08:54:39.332281 10.0.0.2 -> 10.0.0.1 TCP 47824 → 80 [SYN] Seq=559739866 TSval=4137539723 TSecr=0

// 3. Server is sends a ACK with the old connection's expected ACK(410615916).
48591 08:54:39.337692 10.0.0.1 -> 10.0.0.2 TCP 80 → 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827858 TSecr=370383870

// 4. Client receives the unexpected old ACK, responds with RST, and has to retry the connection.
48600 08:54:39.337799 10.0.0.2 -> 10.0.0.1 TCP 47824 → 80 [RST] Seq=410615916 Win=0


Are there any architectural recommendations we should consider here,
or is this considered an acceptable trade-off for security?

-- 
Best regards,
Tangxin Xie

