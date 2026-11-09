Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227061;
	b=3/dAqoTfYaPdLCk7GtTy6AGokSRt76YrrqvvvzI3qaSzXCZTndBoJvLBNFDu5WRD7egF
	 Rg0Dn4T+84eVS4IEe/cP4pmWhfic0VZJz8AR+VsrpIsyzahbpaBxhbprMl4WLRxQVLlOJ
	 yhR48tU/bbdazUPMDVO7+OFC8/SB7hMYrwXtmL35AgQeWzXGlGZHIafte3XUjIRmz+LWx
	 0S+1fkrA9GJDODeUjv9O/Tn1EihBgm6CTmNCxmOjwP2fVg29ak+vHecOn4NJ8A+02swbW
	 SwNSCNo8SBtlCKmPEX5TSOehRsgsbOltAXI2XuL0hjkRsamdPGyVJZ6b48HNUOAnvVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227061;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ze6IvR7GkOD1+y/mxYYxG3sGa0/ogKBWjT4JtvkLT+A=;
	b=mNzUiOF8WYRuRNZHfOEbvt7w+dejOqeOaBu8QmxDvWXYZH8g3esUq8fKd4ClHju47VHD
	 ShLQyX8hzrFQhCq5b+qyO7wiqEGseP3+VZYwk0EaJsSyzYMxYS4x9x8uAQbVm1oobG+cm
	 cBhnPOd2nOwc1IRaCdaC1cNc8RXF6JhepB12mBXPihbd6PP1Ekne4dXsPCZiKEi6mDh8f
	 /YLd6KymJKjDRbaKeVKbEJR3lTQ/02wMdn2bDFtKkLir34kdVIgypmkhmz+u0hxFgEDhU
	 p0Jrxc7kjypldjoUmOpFZVy1LncBXNsu8MWk2chEW7ClV2qKsRuImnp61Rg4S2SPT3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpOh1YLG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406F606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpOh1YLG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450251F0089F;
	Mon,  9 Nov 2026 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227060;
	bh=Ze6IvR7GkOD1+y/mxYYxG3sGa0/ogKBWjT4JtvkLT+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZpOh1YLGBPYls2wzMXkO6PRVKcP2rUcKinKSbmaPaCyL8k9h0GXZffr2xNxtAM2RW
	 8QPdaBaUsvkee3lwv+lbcL93/T6ZPOQceXnpSavk1zIAH5I7DSXLxRE2V6J1Oa2aZW
	 F9qn/Svo4ZM+TvOYlof0WvtwaKLoXMYSDgH1IB++4cRWYHj8hoLoWDDAQK46id9IOi
	 I5DCgQt5zRBbiU/0NKWvLdXykxiLBXi0hLm74s0dKH09if5WlIOnsp31K8ThWTI4Yg
	 Ie+rk3e7f8bUlLfCQtzmFw1yPdJT0DzxkqKBjmdjFrcxwKc9lItBayMB7pIQXiWcRT
	 JrCSfYrbZrbNQ==
Message-ID: <ecd91efe-dd83-4890-8e55-ae04aa744d4c@kernel.org>
Date: Mon, 9 Nov 2026 13:24:15 +0100
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
Subject: Re: [PATCH v2 net-next 2/2] mptcp: Don't call
 tcp_update_recv_tstamps() if not needed.
Content-Language: fr
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Mat Martineau <martineau@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20261105215209.3160316-1-kuniyu@google.com>
 <20261105215209.3160316-3-kuniyu@google.com>
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
In-Reply-To: <20261105215209.3160316-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 05/11/2026 22:51, Kuniyuki Iwashima wrote:
> As with TCP, __mptcp_recvmsg_mskq() also always triggers
> tcp_recv_timestamp() if skb has hwtstamp.
> 
> Accessing sk->sk_tsflags incurs unnecessary costs for sockets
> that do not need RX tstamp.
> 
> Let's check SOCK_RCVTSTAMP and SOCK_TIMESTAMPING_ANY under
> lock_sock().

Thank you for also fixing MPTCP!

> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/mptcp/protocol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a22e9388e0e..797797ce4e88 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2189,7 +2189,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>  			}
>  		}
>  
> -		if (MPTCP_SKB_CB(skb)->has_rxtstamp) {
> +		if (MPTCP_SKB_CB(skb)->has_rxtstamp &&
> +		    tcp_want_rx_tstamp_cmsg(sk)) {

It is "strange" to call a TCP helper on an MPTCP socket (and not on a
TCP subflow), and that's why I preferred the previous name (sk_*). But I
understand you got asked to change that name, so better not to change it
again just for MPTCP I suppose :)

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

