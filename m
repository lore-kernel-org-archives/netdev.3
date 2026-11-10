Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316275;
	b=Ed8D4osKKCkrEIXg3bGh5KovakiTedFg9/tya4L4fq9px0whA28EQGvRtdTLUOD3wNFI
	 0vPQztgcbKAC+kCrr4/dJpnG1VZ1VUqv8MSAmOtzBllrzp7m0EhdJ5rpzDmjgFO8VyJqO
	 4N+fM1NipkgzCzEkS21Ryovtx2jU5z6nc1Mpuf//atYhH+1ojssvAhm3zrmTHPrRI9a7P
	 wCcd1yNYGor+9G4B/uB8IIW+7azMC7EhaH3uYDu7yQJ8nw8RJHeEyJvZ5LQy/RHktuBxW
	 KQobqpdth/OcybE2TtwH39nukuEHclM05xdHXIA8pGfZ4RzysUmo8jrVpsDug9Ktmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316275;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=Ywo8zhGzurnB0+Bm1NB4f5c8ywPLDjkCLjyZnnvvMJc=;
	b=5JASzqapXCJvXnikZqsMxTNxWL8/qSqOcdEd3yPT5c5LwWQJOHTxj72opL98QVWDFQrG
	 Nuqg9KXO81qmkzJaN2yfu5w7EFQadTkP37URB948vFv2Nj8Q2d+msN/c0DwSRaQbyLP2E
	 V9ECyX83/JrGYE0jS0D2bh/cCHcz3vDaYCeZObNJcPGB6g1EgXHLTSA+f2KANPZp77TJt
	 u8JFolAQeRcxQq1l6NskeP6ZGi0fbjR+PJqqP8zJbuNUcg2vTe/DpW4Y0A2J33T0I98Uw
	 Vyp3ORdWjowxlQ4CdBBzfUXetS+gtl13P7WCF+hhTyk1FCMmhsFF+R06eKkTXSsz96w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jdY7Yitw;
	arc=none smtp.remote-ip=195.10.208.51
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCD606A754;
	Tue, 10 Nov 2026 13:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BCD606A754
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jdY7Yitw
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jP6V50dwnzNm;
	Tue, 10 Nov 2026 14:11:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794316269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywo8zhGzurnB0+Bm1NB4f5c8ywPLDjkCLjyZnnvvMJc=;
	b=jdY7Yitwbi+ltrSQ0gamlZgwm7eIHDroKHARvrlArEXJDJDSYVEXHnWTSYnKCEAN4HeWPG
	HWQHfRCTn/ON8DKcB5PDcvH1zSHkmjTOZMPd4pS1TtEGYvuHgGO39jDkamrt+/ZjNJBXVx
	DGZtz4atUuvP8UN9oDDSWMEJkPe1L3DmRjd5FBaPKebj3sD1rDyagyr2KRGaYfzDCy3cnf
	2gyjLc5ZUSvx1LSo7xJZSC/ssM0PI3GB+CWWHkpWoAQQhbv1vExQkGHUhPLglQjyLiKGsK
	yu8UmWH6ZgPqw3xh5Dry7AJ4Bd9ft/AsELrnL65NLSpJH2vIRFeBHPWSaNbxfA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <48cd2ec5-c3a1-4733-82bc-9c1df5ba3577@mandelbit.com>
Date: Tue, 10 Nov 2026 14:11:07 +0100
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
Subject: Re: [PATCH net] udp_tunnel: don't treat IPv4 sockets bound to an
 address as wildcard
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Alice Mikityanska <alice.kernel@fastmail.im>, linux-kernel@vger.kernel.org
References: <20261110113306.3698438-1-antonio@mandelbit.com>
 <179431059548.488859.9340944150774199097@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179431059548.488859.9340944150774199097@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jP6V50dwnzNm

Hi there, humans and not! :-)

On 10/11/2026 12:36, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 

The issue was discovered by an AI coding assistant during code
inspection, while working on extending the UDP tunnel GRO lookup fast
path (more on this in the coming days..).

It was then triggered on an unmodified kernel (current net): a UDP
socket loses the datagrams sent to its port when an IPv4 fou socket
bound to another address uses the same port:

   ip netns add rx; ip netns add tx
   ip link add vtx netns tx type veth peer name vrx netns rx
   ip -n rx addr add 10.9.0.1/24 dev vrx; ip -n rx addr add 10.9.0.2/24 
dev vrx
   ip -n tx addr add 10.9.0.3/24 dev vtx
   ip -n rx link set vrx up; ip -n tx link set vtx up
   ip netns exec rx ethtool -K vrx gro on
   ip netns exec tx ethtool -K vtx tso off tx-udp-segmentation off
   ip -n rx fou add port 5556 ipproto 4 local 10.9.0.1

   # then....
   # rx: UDP socket bound to 10.9.0.2:5556 by some $software;
   # tx: one UDP_SEGMENT send of 32 datagrams of 1040 bytes to it,
   # each a valid IPv4/TCP segment of one flow (quite unusual..but possible)

Without the patch the bound socket receives none of the 32 datagrams:
the GRO lookup fast path hands them to fou's gro_receive, which merges
them as one inner TCP flow, and the aggregate is then completed for the
plain socket.

Datagrams of the same size that don't look like IPv4 arrive
intact. With the patch all 32 arrive. (Tracing the GRO path with debug
prints in a modified kernel confirmed that sequence.)

The fix was tested:
* with that reproducer
* with a check that fou on the IPv4 wildcard, fou bound to an IPv6 
address and both vxlan sockets (IPv4 and IPv6-only) are still registered 
for the fast path as before (using a debug print on registration)
* with the ovpn selftests on a debug kernel (lockdep, KASAN).

[If needed, the reproducer script is available on request]

All in all, not a critical bug, but still something worth fixing, IMHO.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

