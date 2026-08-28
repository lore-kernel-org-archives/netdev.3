Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BA3911AB
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886907; cv=none; b=WH/A1QsDZTrDUcGvrDORW6vKEhwIf1cZrvb1FxSrIkkR0ti4DnfKsMF2eroWi41pdnl9NWBjELKAbrv3ZywgaO0PcC6DNsBLU+1j1zWoLUVRRP17GV9EUGg54VAJ9y6lSuU69gv01Fev5Y9rzf0bEsJKYZBTuwQDlMGz3AznvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886907; c=relaxed/simple;
	bh=yUa3Hro+MdJZiWBpMPxBnVciF+EbzJuiaZoNiXMvROI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZX4qf5zd74R+ZLHoVgCDMYiGDCea6RbtzjOO6D+qjc4k7TsA/lEf87RX/cohfDODf3l9DU1jRoQDlRJ5r+t3fuaSFh/Jl7V2OqhYtbcAAnDZykjXS13aV2mgNgeVvlpcAGlBNbn2DSSS8w83hM3SAocayVxYtp5lN6ZLx9p2Zvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kehrhWx3; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kehrhWx3"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yUa3Hro+MdJZiWBpMPxBnVciF+EbzJuiaZoNiXMvROI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787886894; v=1; x=1788491694;
 b=kehrhWx3snTYnmhUkHFtA7UTAzfqBqFkqYKzA4DFvGyX6F8pfiQN9TSnPeH4aifbwzrddyjq
 aXktoqeJdS6f1PEwKRLdrmJ6c9xBYLYN3S8CXXm3LgPKoeaFp5hY50VU6XRFxuMEA3avmByR2ST
 0nkQHRHtZ8b/FZLyikIuSvxA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a9c4a572758bbc32;
	Fri, 28 Aug 2026 03:14:54 +0000
X-Mizu-Trace-ID: a9c4a572758bbc32
X-Migadu-Flow: FLOW_OUT
Message-ID: <451c8ea9-dc48-4ec4-a35a-76707c3bd580@linux.dev>
Date: Fri, 28 Aug 2026 11:14:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] tcp: fix use-after-free in
 do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, edumazet@google.com,
 ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: kuniyu@google.com, horms@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com,
 andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
 tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
References: <cover.1787870710.git.blbllhy@gmail.com>
 <65fd3816ed5d541d9edd4bf4fcf97104a2cf907a.1787870710.git.blbllhy@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <65fd3816ed5d541d9edd4bf4fcf97104a2cf907a.1787870710.git.blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/28/26 7:55 AM, Cen Zhang (Microsoft) wrote:
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>    BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>    Read of size 8 at addr ffff888013701258 by task exploit/149
>     do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>     tcp_getsockopt+0x91/0xf0
>     __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
> the icsk_ca_ops pointer.
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: AutonomousCodeSecurity@microsoft.com
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

