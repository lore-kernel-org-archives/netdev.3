Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C92EBB84;
	Fri, 11 Sep 2026 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152117; cv=none; b=J6kO3tLVrsowags8C/GaaCHrtAlq0NB0h3O5mTXa6Albsm442xmnkN+iOv037TqLdFVedBwJ5uPQyOogXJqYOKeuqfV4WZtai91J1NvJfVVeIfK5JUtLBNCdnQwB5cO8TQ+xzMsbhL0tf+dmyuo10Gng8yfpynJeTcYDQAAEVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152117; c=relaxed/simple;
	bh=GU3HVbWvMuk5BYOYxHSjKK3L1+JcDqIPoatgfbJRJXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiaovKv2W3gUvooAV7Y/MxLg1x0cVdrgXqo5180X8vL95unxTUCiMNEfxfzqp/5bkF0Tr6t3Qt5qiER4yWmjRSVO+KXBapyySW8vahfqr1iEnHQvMsqeDudfO/ifxaK08FsHg5sIyqwPhCw+qHY+6OkfK0c35uaGE8Hr9ysb9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RkY/M0mS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlq1Qg4Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ms4mfNdu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1HRb21j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RkY/M0mS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlq1Qg4Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ms4mfNdu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1HRb21j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61E0B21D08;
	Fri, 11 Sep 2026 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789152109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0gb1YTzyq1tY8Su9YkmnVJWgy1TkvTwTxxXy9SCpjo=;
	b=RkY/M0mSQDtBwqIu6f/fIc29Amt/L8mUaFwnHx0GIwah9Lzw/pNGlorIFjfrEOSXWVkH7Q
	GlheZ17kgncviUXpcaqC1WryqKQUfloiSZ9/LpyY/kBJJEnqjbHcNfSVn4RciI24eGVnqg
	TKxQP8HMZ5JDjuGHNxmWMcBB5CSb58E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789152109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0gb1YTzyq1tY8Su9YkmnVJWgy1TkvTwTxxXy9SCpjo=;
	b=wlq1Qg4QibM0Nx9TOoJ7itJSTMV2mU3MqDiCInKrVBCNHhApf4+FRz4Rtkzoul+9lvUb7i
	UEtjI2UQT7ejN1DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789152105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0gb1YTzyq1tY8Su9YkmnVJWgy1TkvTwTxxXy9SCpjo=;
	b=Ms4mfNducoXCdJdwgneA930TXB6lfwJEeLdqj+a/+gyLPolyAdvQwKtYKzxeTmImdfxBJ+
	p0CviZSbqz9XVvXwhL8ePfQ1f7gAFlHr2rBcP2QBE0wbns+N47l2LDu6nSV5IfRxpitZZT
	ad67zye62h/9XjaeScPg3PMVyV3l3Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789152105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0gb1YTzyq1tY8Su9YkmnVJWgy1TkvTwTxxXy9SCpjo=;
	b=t1HRb21jf6dXlxt4qlVQM0JwQp+OHn2WmSxNuC3U1RcaI0tQ7A6zjqjE1Bii0IC6O3Bb1A
	+f6M/tqvTZHjeyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60FFB132D3;
	Fri, 11 Sep 2026 18:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5yPcFGhLpGpifgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 11 Sep 2026 18:41:44 +0000
Message-ID: <fcb24a94-d62d-4166-b51b-4585a021500b@suse.de>
Date: Fri, 11 Sep 2026 20:41:10 +0200
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

I think yes but when it makes sense. Of course, that is something a bit 
hard to judge IMHO. I tried to use it when it makes sense, like for 
stubs or for functions that are protocol agnostic but contains a small 
part related to IPv4/IPV6. I was willing to avoid code duplication as 
much as possible.

