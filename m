Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336387;
	b=FbAeDZvSMHRigUwcv99CwmV8MAwPcjAdNuBtLCvo0l47eskzN+Fe+caeHb2jRyLBx6hV
	 8mffTr5xFuL5l2m+DBOchPk2Jlae0sieyyU9jgb0mQZUOKiCLXKC9xPSMSgJb4zpV7ou/
	 h2dpYf/V3XIA9BL/cRzcoI55jqqCKp/szCOo7ZVnVcbPYWN4pbJ1Ye+adT+AMfIf4YwoG
	 NPpkv3y2ZuQ0hFioamaZlgUCbPHCosOg5ShdUCjWvqZsbd4UOcd+z3BUs2bCP85ROjk3b
	 y7ZjjRSQFwyjNpWH60j/fyBM7H0bN2UiV/RDKbqdCl6Xb7MDmmYhF+OiXsc+zrdazVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336387;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oyI17NyOJM0kt1UrI0kaEX09J0O+FpQi8tnW/h78oqA=;
	b=gFBR1lZstcJAG5Q6dqNEtFEIPubyfGugp6+AL+wleL9OhpphHV2C8u99Z5TUZmF6Dsgr
	 yptncNlPX16Ph5XMokkK5OFmYHoOcpuc0460ukD8a2LimNlw9zy6stExCUi68F03DMZGW
	 4y9QUpODY3VMCX8d3cILepmgk1UBO4ehfeM7BulnbvhylIUbCPTLn+4DhM5XVp+S9aMlk
	 uena/fC3iP/N4OH9Azv4xpg2Kh5ljQUo284E2REvXCNh68wHL3RsYldP/Tmk2HfDMBPAg
	 sGm60UwH2HvBzQvbLldws6WbL8uDo36jWtyGv0Pg6hA7BdLSqnr6GhUxJmlOWZ8lmPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baIC7iy4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E99606A32A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baIC7iy4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEAE1F0089F;
	Tue, 10 Nov 2026 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336386;
	bh=oyI17NyOJM0kt1UrI0kaEX09J0O+FpQi8tnW/h78oqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=baIC7iy4wwywttcDxGBgNQ5REey7p8iFkRhnAN+dmwLq8FSpOYs1Yqg6Pfc8FamGq
	 eFyMamXvqcyGCEFIKtqSmJUE4vE3z3u3tDqHPU616dxDNhgw/MsuNkvrrzYzQI10dd
	 2LEOnZ+V0ZilWZ+rau4eryXuivZIiXe/KO+8z8PDHW0ruvQ1xvsmB63qwLrI9i3MyT
	 nRUXSGJXC2udzQY3VKIbOUQXnAZKp9VVurfWqi2ZrAEjGjy5RaF6Rb7b566rX9W2Jd
	 5wANSbKnYd5mcTfXsIZ7Q57WtMzu6ky10e28EawERvPDwY5LdnEcMCZ0wqbwwSdt/p
	 b7oYlHsPXvPOQ==
Message-ID: <8362f907-4e8e-4514-bff6-f0bf8fd22f57@kernel.org>
Date: Tue, 10 Nov 2026 19:46:19 +0100
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
Subject: Re: [PATCH v1 net 1/3] tcp: Clear DEFER_CONNECT before tcp_connect()
 and in tcp_abort().
Content-Language: fr
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>,
 Wei Wang <weiwan@google.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20261107235720.3129212-1-kuniyu@google.com>
 <20261107235720.3129212-2-kuniyu@google.com>
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
In-Reply-To: <20261107235720.3129212-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 08/11/2026 00:56, Kuniyuki Iwashima wrote:
> When TFO is enabled, tcp_v[46]_connect() sets sk->sk_state to
> TCP_SYN_SENT and puts the socket into ehash without calling
> tcp_connect().
> 
> Then, tcp_fastopen_defer_connect() sets DEFER_CONNECT, and
> the first write()/sendmsg() will call tcp_connect() and send
> SYN with data if possible.
> 
> If tcp_abort() kills a socket before the first write()/sendmsg(),
> the unhashed socket can still call it and send SYN in TCP_CLOSE.
> 
> Also, DEFER_CONNECT is cleared after __inet_stream_connect().
> 
> So, blocking write()/sendmsg() can release lock_sock() in
> inet_wait_for_connect() while DEFER_CONNECT is set, and
> tcp_poll() could set EPOLLOUT even after SYN is sent.
> 
> Let's clear DEFER_CONNECT in tcp_abort() and right before
> tcp_connect() in tcp_sendmsg_fastopen().

Thank you for the fix!

It looks like we can still have the race with MPTCP:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107235720.3129212-1-kuniyu%40google.com

But that's not blocking this series here, so for the MPTCP part:

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


Just to avoid a deadlock, are you planning to fix the issue on MPTCP
side as well? If not, I can look at that later on when I can.

(Perhaps by checking if the msk and ssk's DEFER_CONNECT flag is no
longer aligned in mptcp_sendmsg_fastopen(), under the ssk lock? If not,
clear the msk one, report the error, release the lock and return? BTW,
it looks like we also forgot to clear the DEFER_CONNECT flag in
mptcp_disconnect() as well...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

