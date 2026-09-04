Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E338645E;
	Fri,  4 Sep 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508764; cv=none; b=prUNMGGmJ4Fkq7yRaIMFBX8GafKbb8edLRa5iVxgHopp+xQXcAkQabE/1+2VU5lNOLLVUPWBlH1ibuBOLZrWRepvx0+ca2jXzJKC6KnuhMVOoM/mBftCA5M+2SQliSH+F23blnPBuBym2PURDXWgnIuRXBGDzmnTCxSvnsEHfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508764; c=relaxed/simple;
	bh=dZFbbZ/FfU1mA74+4zOcwpBb10yqmocCior0qsHa6QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR38cwMMttbmB7CueF22nb9zIQZpaQgDfAT2Bupm2hjeW//LZJp8mLyXt88KDtI8NSQBzZal1TLQZ5/6EtWxWhvNeFLvlwvtBhyrxuBmkMfK2/BJoWgs6NNVKTlEP2EyiIcChznLoEUIOwS7xPs4tsFOppyHhDaOsSIkWgd4VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oJ0jt6Jr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NXIcd0DX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BUFWUxR4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zgybB2hp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oJ0jt6Jr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NXIcd0DX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BUFWUxR4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zgybB2hp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 313F020347;
	Fri,  4 Sep 2026 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788508757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCFN2GQ7njfE+7S01Ptbv3wCACgbkHy+tcYWuh48068=;
	b=oJ0jt6JrIqsIecVgr8D3p6wuTHBDFjrfGeV5GgVGCA0krUFlOjIseiPuw+gw/O+IsX2QX0
	LnMd0GNUE1UBJH1oEf/o0lh26TgAS9/oHbE83mhvdz+VN3uFcNtI8uw7g+bg+F5B66ooYp
	eRSer55E28zXYdyf+zEoKf8Ynhw6M7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788508757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCFN2GQ7njfE+7S01Ptbv3wCACgbkHy+tcYWuh48068=;
	b=NXIcd0DXbRPy/HAERqfE+Qxc309Bypz679wobFnyI/X2AHjAucuFlk0Z4ogagHUonTEtH5
	FVgVVAyHfC0D8sDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788508753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCFN2GQ7njfE+7S01Ptbv3wCACgbkHy+tcYWuh48068=;
	b=BUFWUxR4BOA7bRrRJajCVCYsg3+9HfQz5phXAw4nL2wmeImHq9nFcpFtYlGrItK7M810Mz
	dmfNYkQZm+VM7gTsH6BQF50Po/c0gK+iV1jDuFGl3nBIKKc0oSXzGRpgSyHazkNe1ZRfSt
	xsDdbL20zZfE0BGq7AEntLgPl0bNORo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788508753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCFN2GQ7njfE+7S01Ptbv3wCACgbkHy+tcYWuh48068=;
	b=zgybB2hpMwj9vt3q26OYsbJSROutHA2JgDDER9OnN767j7anQqdY8d00Vvne9xyGLp7U4R
	ZY5iLvB3j7Gf+gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA5113678;
	Fri,  4 Sep 2026 07:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D61DH1B6mmoPLgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 04 Sep 2026 07:59:12 +0000
Message-ID: <817eea24-87ae-43d0-9742-a275a446f523@suse.de>
Date: Fri, 4 Sep 2026 09:58:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
To: Junjie Cao <junjie.cao@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260904030112.450920-1-junjie.cao@intel.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260904030112.450920-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,intel.com:email,imap1.dmz-prg2.suse.org:helo]

On 9/4/26 5:01 AM, Junjie Cao wrote:
> The forwarding paths report an expired TTL or hop limit as
> SKB_DROP_REASON_IP_INHDR, the reason otherwise used for a header that is
> malformed (ip_input.c, exthdrs.c, br_netfilter). Nothing else in the drop
> path separates the two: IPSTATS_MIB_INHDRERRORS covers both, and the TTL
> check runs before NF_INET_FORWARD, so netfilter tracing stops at
> PREROUTING and never sees the drop.
> 
> The Fedora bug linked below shows how that reads in practice. The
> reporter took kfree_skb(reason=IP_INHDR, loc=ip_forward) to mean the
> software header checksum check had failed, and worked through RX checksum
> offload, tc csum actions and both libvirt firewall backends before the
> drops turned out to be replies arriving with TTL 1. ip_forward() never
> verifies the header checksum; that runs earlier, in ip_rcv_core(), and
> reports IP_CSUM.
> 
> TTL expiry is not a corner case -- every traceroute through a Linux
> router goes through too_many_hops.
> 
> The three loopback hop limit checks in exthdrs.c drop with no reason at
> all; give them the new one.
> 
> IPSTATS_MIB_INHDRERRORS stays as it is: RFC 1213 counts time-to-live
> exceeded under ipInHdrErrors. The drop reason has no such constraint.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2517131
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
