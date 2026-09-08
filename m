Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851C58FD1D;
	Tue,  8 Sep 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888359; cv=none; b=osPuUEpH4YgZ4iUXSCcO63Xd1yU2XzZeraEICPzKoLqY3FJLnDzs6K7wiwasi6U8sGx+3UokZornMJCQNF59gbogxJMjVflVCzs/EmgXVub+DXKdOrmWkUo+ZZ76A0mi/o+J7afxeh8mA6AHDGMZs6yiwhvNZQ55FaJ2Y32iLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888359; c=relaxed/simple;
	bh=KV+P1GR5UC9sJ0F+5QY1pcXLH4BWW4rPFQTylAnrHpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9xshNQ+GA9B76Nj6h0nswQ6QZ7aH0VA8FI9vwwWTkr3PUVND7qPaojvWCk97SBuANQYPqaR4NPzmvkeWF58KVs1XBWsU1WaTLkm6ts3nUgJrOCKvhyaBjkwHmAxrfJKqFW5lSawzxw4RD2SsSksZb39V4Xd02yGbCFyEauknYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD+IPPTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD+IPPTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBC11F00A3A;
	Tue,  8 Sep 2026 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888358;
	bh=nScoxQtdxykKU9QZOPMgNZaJVcGJcoE6oBnNk2LcKH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZD+IPPTdaHsyN1+Rt6vgGjcGaTkRi5iZfksMqNBL3XwnEaLW/TB7QwEHrWH4Rdg9+
	 U4Xfu02g6fNnXi9N6jsC4fVnSoykBdLEXu31+uXN0GI+EML0+6qkwFMMWJ/ZdyivP2
	 +ngE8A9dG4NENHyZukoZuVqKeLCbUgYSCpLTuATcux/AeLW/7rAachagGUWEZ8Gao7
	 eh8DMixyRxZ78ytFFaVk7/F/8jx2U/BvkII7h14glZR9sRr7DBdyaZwtbb2HQIRBWR
	 Fzj7DXhDroa4CKw/W0hNAuldGsjqv/eL+UGIrcBpS36J6zkTM1nuwF2vbFoIqUSuwG
	 T/ZiKjk1J7mXw==
Message-ID: <fecc9c2f-c083-406a-b6a1-55b0b0d2798a@kernel.org>
Date: Tue, 8 Sep 2026 19:25:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] tcp: fix data-race in tcp_recv_should_stop
Content-Language: fr
To: quanyeyang@proton.me, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

Thank you for this patch.

On 08/09/2026 04:59, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> BUG: KCSAN: data-race in do_recvmmsg / mptcp_recvmsg
> 
> read-write (marked) to 0xffff8880134d391c of 4 bytes by task 2619 on cpu 1:
>  instrument_atomic_read_write include/linux/instrumented.h:113 [inline]
>  sock_error include/net/sock.h:2565 [inline]
>  do_recvmmsg+0x50c/0x580 net/socket.c:3049
>  __sys_recvmmsg net/socket.c:3144 [inline]
>  __do_sys_recvmmsg net/socket.c:3167 [inline]
>  __se_sys_recvmmsg net/socket.c:3160 [inline]
>  __x64_sys_recvmmsg+0x161/0x180 net/socket.c:3160
>  x64_sys_call+0x19c7/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:300
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff8880134d391c of 4 bytes by task 2620 on cpu 0:
>  tcp_recv_should_stop include/net/tcp.h:3086 [inline]
>  mptcp_recvmsg+0x54d/0xd50 net/mptcp/protocol.c:2466
>  inet_recvmsg+0x204/0x210 net/ipv4/af_inet.c:894
>  sock_recvmsg_nosec net/socket.c:1151 [inline]
>  sock_recvmsg+0x11a/0x140 net/socket.c:1173
>  ____sys_recvmsg+0x14b/0x3c0 net/socket.c:2933
>  ___sys_recvmsg+0x116/0x160 net/socket.c:2975
>  __sys_recvmsg net/socket.c:3008 [inline]
>  __do_sys_recvmsg net/socket.c:3014 [inline]
>  __se_sys_recvmsg net/socket.c:3011 [inline]
>  __x64_sys_recvmsg+0xeb/0x160 net/socket.c:3011
>  x64_sys_call+0x1319/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:48
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x0000006b -> 0x00000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 2620 Comm: syz.2.33 Not tainted 7.2.0-g39d4f32c5d53 #76 PREEMPT(full)
> Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014

Just to avoid some confusions, this has been reported by MPTCP syzkaller
instances, not by Syzbot. So just not to have people trying to get more
details on the wrong website:

Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

