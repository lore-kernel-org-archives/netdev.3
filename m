Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148166;
	b=UoXVcDM+ujGuZPfu11yTeNHaRGHYn1Lr0Tau8sKW6cFmoM/0ryIgP7L8uedEAGO81TmM
	 g6rye1jxQLnuftkEd9ai1+juy6KI0+2KRz0HkGa+9B+439LvjsbQbYURA4phVLy5W+O8o
	 XOG1y7DdwCePoqonUB52chUZYhTUyE+FHMIIELpIVbGbz0021UrStPstfIy8KirM+F966
	 iqrGfIlxksYXiKgJ+h7g9nuJOLqhLGavKJO0hb915uK88G7VmDjs4ehWYJhkFxT/foiC1
	 hMQe2sT+yQH2zHfCZCcN/4ZocHQttocpTot69Ydd7uYarFCuxaYaWcMbKzCT+exZM+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148166;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=HJV8KOTl4NyfmFqWmI11SWRTSVe2eKyjEMsQjqAfySE=;
	b=toduQNP2TzCUfaIt62nfKUXRg1oSTJi8EwGi0RSgx4D4DCcHhjV7NkbL2yhPwXL1OS4V
	 XBjkrNFS+j89vnnDT6XsQ1ZUzsAg1b3oCkSv0LJXlBof17EHhgB6W4S5kuuYQaZcdIRgO
	 +l31Y04RJXau1OXoAySY7KvEwLZU3roQVsDo+2iYCLoYP0OpEcUUcquECU0iw4w0nL2Kn
	 pU7Pq1Z0Gu/AeL3Pv8txaUuAu4n5TyvAdLpdE5Ipfbw3vmvtAQj8EgSiqhHzdAMiNAABo
	 8PlU2Xm4x9pXjMzUKPpn0+0jUnx8Lm7iYHN5v4H6We3Mh9PlM4hr5YOVrJpYY6crgug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=kMaHHtVd;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA2606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=kMaHHtVd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HJV8KOTl4NyfmFqWmI11SWRTSVe2eKyjEMsQjqAfySE=; b=kMaHHtVdMsI7QGzVWOB2cZ5Akr
	eoUMpdS5eupkbMpKkyOnrGA9qXtcDPQnAYW1vb877BzPDBOraPNW+ckNRZT+GDTXJ4oa79wkCrU4u
	+3NM2zumG+8JP5SdWkhG/JTiWVbL6AGN0/vGAlJOd3bE3jtXBGdeRtjHj0m2IceT+Vx6pqY78r2eb
	MgkueT+CQ7kL0bOdHZZT7YmAl/sSjmeZoY7g5Z+oQtp3KPXMZXr46KMZXq9HlW+KFSn2q1MExAVIT
	AANxgOpFKOOeT9JYGh+lYgO3SzDh1s/tbGLxw7keHDgKKQ3Z3xXMnIkJdWM2zZgIptTuen5IqbY4C
	FaapV20Q==;
Received: from [::1] (port=55088 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xQ3tb-00000008NLG-3lw1;
	Sun, 08 Nov 2026 15:29:23 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 08 Nov 2026 15:29:23 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>, Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec 0/7] xfrm: fix ESP IV generation and ESN
 authentication
In-Reply-To: <auwuggdz_TCwtlqN@gauss4>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <auwuggdz_TCwtlqN@gauss4>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <0241f2f197159d7dfb0144035b51a1b1@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-05 08:21, Steffen Klassert wrote:
> On Wed, Sep 30, 2026 at 02:45:17PM +0000, Jérémy Jean wrote:
>> Hello,
>> 
>> This series fixes nonce reuse in AES-GCM and ESN authentication errors
>> in the IPv4 and IPv6 ESP offload paths:
>> * 1/7 and 2/7: Save the current sequence number before incrementing 
>> it,
>>                so that GCM IV construction prevents nonce reuse,
>> * 3/7: Use the current sequence for software AAD and hardware offload,
>> * 4/7: Give each early GSO segment a private secpath,
>> * 5/7: Use the packet sequence directly for mlx5 IV generation,
>> * 6/7: Segment untrusted GSO packets before allocating sequence 
>> numbers,
>> * 7/7: Keep the sequence counter unchanged after full ESN overflow.
>> 
>> Note that triggering the bug fixed by 7/7 is impractical: it requires
>> processing about 2^64 packets under a single key. Yet, I still believe
>> it's cleaner to fix it.
>> 
>> On the crypto side, as a reminder, reusing a nonce under the same GCM
>> key is catastrophic for security: it exposes the XOR of the plaintexts
>> and can reveal GCM authentication key, which opens the possibilty for
>> an adversary to forge ciphertexts without recovering the AES key.
>> 
>> This series combines and extends these two individual reports:
>> * 
>> https://lore.kernel.org/all/20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr/
>> * 
>> https://lore.kernel.org/all/20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr/
>> 
>> Recent discussion with Sabrina Dubroca may also be of interest:
>> https://lore.kernel.org/all/c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr/T/#u
>> 
>> Regards,
>> Jérémy
>> 
>> ---
>> 
>> Jérémy Jean (7):
>>   xfrm: esp6: use the current sequence number for the IV
>>   xfrm: esp4: use the current sequence number for the IV
>>   xfrm: esp: use the current sequence number for AAD and offload
>>   xfrm: prevent AES-GCM nonce reuse after early GSO
>>   net/mlx5e: Use the packet sequence number for the IPsec IV
>>   xfrm: segment untrusted GSO packets before sequence allocation
>>   xfrm: leave the sequence counter unchanged on ESN overflow
> 
> Please rebase your patchset along with the proposed changes to
> the current ipsec tree so it can get applied eventually.
> 
> Thanks!

Thanks for the reminder, I have just submitted a v2 rebased on the
latest commit from the ipsec tree.

Link: 
https://lore.kernel.org/all/20261108142652.1330952-1-Jeremy.Jean@oss.cyber.gouv.fr/

Regards,
Jérémy
