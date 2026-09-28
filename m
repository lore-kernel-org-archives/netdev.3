Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD124C33E7;
	Mon, 28 Sep 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602235; cv=none; b=onS4HDYvG0b8P4R8EdeCmsT0jRbsTDXelTPIf9TylDHHTL2d7QVz6aF3kuw+PAbyiJdoBY795+ZBcCOTKqZYBhxUYpupkbce/SVcOjwmo9L263XaOI4bf4JAxKpzJ/RRNMFiEaQ8oxu+8FObTQOojziRh96VbFif7n0QDF4dXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602235; c=relaxed/simple;
	bh=/ZIXZq9gRx4ZJup2TfQnH0cmF0/yFx/QaEHq8/WCZ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTzibCF8um2W04deUqxkmsisPqGpSJB214IECnGtOioZyLqFMs27I3968fL7ByKAZOpV0+pqNI2KPxklBmUpJ453jnd5Tc7srKGoXhV5Klu6bU5PCt6q5tc9+WTWX6sxO7ePCUrRmwA2B0Y/uZuui0Y7uKeNhMeQLvvVrogRouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tLDTICqy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q9ZKCrV8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2JO0koV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wdoZ9c8L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tLDTICqy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q9ZKCrV8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2JO0koV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wdoZ9c8L"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 516281FB5A;
	Mon, 28 Sep 2026 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790602226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Re47rdueS6MfKXdWSNMHebvUMcQJ0WKpeHv2nD7W32I=;
	b=tLDTICqyru3Vk3A6zWUWBzvlRzewBL10yY/x2IQc8ROxKcRFqkNXK6wSszq3pYECnKENg5
	43ejcCKV7R6useO4Kh95C4icKabUkr9nWO2OHvSc+rXtKX3W2Ni0huT8iWwoqAiLDdfLFb
	9Zgl8v3RtkgSoApi8RTX0MYUp79jbXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790602226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Re47rdueS6MfKXdWSNMHebvUMcQJ0WKpeHv2nD7W32I=;
	b=Q9ZKCrV8UfPHlP7E2nGtKNtvF6zKPEtOK5B+yH6vtKZoP4Jpb+aERlwSYRMwqOFMsR8tji
	7wdsj4Weim9nFPCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790602222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Re47rdueS6MfKXdWSNMHebvUMcQJ0WKpeHv2nD7W32I=;
	b=e2JO0koVUzBycs+mdld9ZgjCalTW4IUSgpWn2eLxJ9aNePZdMrmxTiD7xwPXtSuxJQuKW8
	1ZzXHUoVYdVOm96WZ1jf3x7v0W6XqXXGWFJNx7DGMmhgggvZNdnfIGCt1S6RQUtIg/VgWW
	M5XeSUQTEBHBWnvCTaRTX+4x7rAOVD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790602222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Re47rdueS6MfKXdWSNMHebvUMcQJ0WKpeHv2nD7W32I=;
	b=wdoZ9c8LyAoE+gINU/Hns4R1MyJ4Ytqe9GsjXs98SF1v2Y5LRK0cgar3tUQGtvclGd0jL4
	GYUBxN5bh9bO+/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FA4B1340F;
	Mon, 28 Sep 2026 13:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xjXhCO1rumqiPQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 13:30:21 +0000
Message-ID: <77efdf03-8960-484a-a804-83c3253f6145@suse.de>
Date: Mon, 28 Sep 2026 15:29:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13 net-next] net: inet: relocate ip_generic_getfrag and
 guard IPv4 socket logic
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Richard Gobert <richardbgobert@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Jeff Layton <jlayton@kernel.org>,
 Qi Tang <tpluszz77@gmail.com>, linux-kernel@vger.kernel.org
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-4-fmancera@suse.de>
 <aqMeeDnj4pcuvz7-@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aqMeeDnj4pcuvz7-@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,nvidia.com,gmail.com,pengutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 9/10/26 11:19 PM, Stanislav Fomichev wrote:
> On 09/10, Fernando Fernandez Mancera wrote:
>> To enable compiling the INET subsystem without IPv4, shared generic
>> utilities must be relocated and IPv4 socket logic must be guarded for
>> CONFIG_IPV4.
>>
>> This patch moves the generic ip_generec_getfrag() from ip_output.c to
>> af_inet.c. It also introduces CONFIG_IPV4 guards around af_inet.c to
>> reject IPv4-specific ioctls, protocol registrations and bind requests.
>> The same guard is added to reject IPv4-mapped IPv6.
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv4/af_inet.c   | 96 +++++++++++++++++++++++++++++++++++++-------
>>   net/ipv4/ip_output.c | 18 ---------
>>   net/ipv6/af_inet6.c  |  5 +++
>>   net/ipv6/datagram.c  | 12 ++++++
>>   4 files changed, 99 insertions(+), 32 deletions(-)
>>
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index d9421ac38d78..b0c48ba544bf 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -129,6 +129,28 @@
>>   int disable_ipv6_mod;
>>   EXPORT_SYMBOL(disable_ipv6_mod);
>>   
>> +/* Keep the function here for now as it is generic, it should be moved
>> + * to a common L3 place
>> + */
>> +int
>> +ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
>> +{
>> +	struct msghdr *msg = from;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		if (!copy_from_iter_full(to, len, &msg->msg_iter))
>> +			return -EFAULT;
>> +	} else {
>> +		__wsum csum = 0;
>> +
>> +		if (!csum_and_copy_from_iter_full(to, len, &csum, &msg->msg_iter))
>> +			return -EFAULT;
>> +		skb->csum = csum_block_add(skb->csum, csum, odd);
>> +	}
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ip_generic_getfrag);
>> +
>>   /* The inetsw table contains everything that inet_create needs to
>>    * build a new socket.
>>    */
>> @@ -425,8 +447,10 @@ int inet_release(struct socket *sock)
>>   		if (!sk->sk_kern_sock)
>>   			BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk);
>>   
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   		/* Applications forget to leave groups before exiting */
>>   		ip_mc_drop_socket(sk);
>> +#endif
>>   
>>   		/* If linger is set, we don't return until the close
>>   		 * is complete.  Otherwise we return immediately. The
>> @@ -478,6 +502,7 @@ EXPORT_SYMBOL(inet_bind);
>>   int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
>>   		u32 flags)
>>   {
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
>>   	struct inet_sock *inet = inet_sk(sk);
>>   	struct net *net = sock_net(sk);
>> @@ -570,6 +595,9 @@ int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
>>   		release_sock(sk);
>>   out:
>>   	return err;
>> +#else
>> +	return -EAFNOSUPPORT;
>> +#endif
>>   }
>>   
>>   int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
>> @@ -962,18 +990,24 @@ EXPORT_SYMBOL(inet_shutdown);
>>   int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>>   {
>>   	struct sock *sk = sock->sk;
>> -	int err = 0;
>> -	struct net *net = sock_net(sk);
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   	void __user *p = (void __user *)arg;
>> -	struct ifreq ifr;
>> +	struct net *net = sock_net(sk);
>>   	struct rtentry rt;
>> +	struct ifreq ifr;
>> +#endif
>> +	int err = 0;
>>   
>>   	switch (cmd) {
>>   	case SIOCADDRT:
>>   	case SIOCDELRT:
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   		if (copy_from_user(&rt, p, sizeof(struct rtentry)))
>>   			return -EFAULT;
>>   		err = ip_rt_ioctl(net, cmd, &rt);
>> +#else
>> +		err = -EOPNOTSUPP;
>> +#endif
>>   		break;
>>   	case SIOCRTMSG:
>>   		err = -EINVAL;
>> @@ -981,18 +1015,26 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>>   	case SIOCDARP:
>>   	case SIOCGARP:
>>   	case SIOCSARP:
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   		err = arp_ioctl(net, cmd, (void __user *)arg);
>> +#else
>> +		err = -EOPNOTSUPP;
>> +#endif
>>   		break;
>>   	case SIOCGIFADDR:
>>   	case SIOCGIFBRDADDR:
>>   	case SIOCGIFNETMASK:
>>   	case SIOCGIFDSTADDR:
>>   	case SIOCGIFPFLAGS:
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   		if (get_user_ifreq(&ifr, NULL, p))
>>   			return -EFAULT;
>>   		err = devinet_ioctl(net, cmd, &ifr);
>>   		if (!err && put_user_ifreq(&ifr, p))
>>   			err = -EFAULT;
>> +#else
>> +		err = -EOPNOTSUPP;
>> +#endif
>>   		break;
>>   
>>   	case SIOCSIFADDR:
>> @@ -1001,9 +1043,13 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>>   	case SIOCSIFDSTADDR:
>>   	case SIOCSIFPFLAGS:
>>   	case SIOCSIFFLAGS:
>> +#if IS_ENABLED(CONFIG_IPV4)
>>   		if (get_user_ifreq(&ifr, NULL, p))
>>   			return -EFAULT;
>>   		err = devinet_ioctl(net, cmd, &ifr);
>> +#else
>> +		err = -EOPNOTSUPP;
>> +#endif
> 
> (passing by comment)
> 
> Don't we have a coding style rule to avoid ifdef conditional in C code?
> Should we add some new devinet4_ioctl/etc wrappers that we can conditionally
> compile out in the headers?

I agree here.. and went on a different direction for the upcoming v2. I 
decided to rely on DCE (Dead Code Elimination) to avoid using ifdef 
conditional. I think the v2 looks much better (to be sent in some minutes).

Thanks!
