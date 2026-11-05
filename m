Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892772;
	b=3gJ4W2ukPqKHwn7xWhWH5a13n6mnZCDhlpA4VvFuk+KxC71icADiYupVDDZ1N648N/gn
	 dA9S4bdzzjgDygRg9JIp/WI0Jtp10Lb7yTFkz7RuQ0woY6p6x494tlAWkCS59Jlck+V5c
	 q9h6H6PMHIuqj+Y5VR+U9GSgS8E9qDYqCzgnMvRbCQRmVfwdO+CpdDVH8704HBCn41Ij0
	 JJIvrHyYNT7kXciSWDUmfxiqufJQalQemi+YSP/qUu8y6FuNNgtFac20wvLStJTlgi06T
	 DTk6Ct47okCl1marCZRFUe26Gx+2pT3QnlAYT4dN9LFnR9Ji3ME+qS/bkneKQdi7riw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892772;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Chemical-Abaft:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=l1y03LKwED8ZduwAbGwCiRWWK0EB6JTtYi+MQr5n6rc=;
	b=p0X41uAFCdbZ1R2MTdG1nrz2wJxKruBnHxylKGVvrDTDRMGPmDm88stt5tiyZV7nkW9a
	 L2/hkteTzgOQssAxaPQbr5fqbgDho/FxwnDOkvM2P7mZXF9UQhLhjKsaH87z10WAU8wsS
	 e9mBDOPL1LQbs1upgTYJHbqroedSatH2AbF9BsZiRa1rs1ywmJeAbLMPpKiQOUP39gaZo
	 prRwn7nIxvf5+jo4ecuLVNVxC4wEje8rYnX+//NK46p4eRtZ6waegPrrZF8NhOS55tAdE
	 Tz0NoSpDGVJCvYgt8mOMbTG808cSRUIgZRmP3NE9MJNI8mvtge0GGefDshI7EtuHNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=qU1oqjtV;
	arc=none smtp.remote-ip=23.83.209.151
Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF9606EE8A;
	Thu,  5 Nov 2026 15:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADF9606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=qU1oqjtV
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BAD1A405ED;
	Thu, 05 Nov 2026 15:32:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.99.188.114])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 03E8640A73;
	Thu, 05 Nov 2026 15:32:45 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Abaft: 166461fe4d6674fb_1793892765466_11164343
X-MC-Loop-Signature: 1793892765466:1908407538
X-MC-Ingress-Time: 1793892765466
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.114 (trex/8.0.2);
	Thu, 05 Nov 2026 15:32:45 +0000
Received: from offworld (unknown [190.113.127.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4jL5sl3CQzzWW;
	Thu,  5 Nov 2026 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793892764;
	bh=l1y03LKwED8ZduwAbGwCiRWWK0EB6JTtYi+MQr5n6rc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qU1oqjtV3XWLiUTZXJFfCY9ulHDxB7xdY0SIZP3nP1RKbbUFdRy69KJom6R6Qjh5u
	 lnFl7Dbc9oMG811FQf0m5LW597SYjIykXKaIZ99q7CVoFEjXMSQ+nsP2+7QTca69/q
	 7PXIvPdvwS/vXU+T6gtHVdVjPRxaYVWmHtHNROKpcuqLotiXYgAOjFAw49OFFFDzlk
	 egPUd6+Kwa2m2P9xNuw6E3XsCpPZVWAr6Lbx8/GiDKoXIS12F+8jnXfXKVw6gADSZH
	 CGSgC6BjLTa9+HOcBJ9eg2ptX3RGQ0aI8GC1nv6Q8DVRikHBuzhTNLkn+BkpdZ0Jpq
	 bzKa+RMO+izjg==
Date: Thu, 5 Nov 2026 07:32:39 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Simon Horman <horms@kernel.org>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, kuba@kernel.org,
	pabeni@redhat.com, anisa.su@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mctp: accept MSG_CMSG_COMPAT in recvmsg
Message-ID: <20261105153239.qmqroxth43ncnln5@offworld>
References: <20261101200331.1956836-1-dave@stgolabs.net>
 <20261105135808.GS865646@horms.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261105135808.GS865646@horms.kernel.org>
User-Agent: NeoMutt/20220429

On Thu, 05 Nov 2026, Simon Horman wrote:

>On Sun, Nov 01, 2026 at 12:03:31PM -0800, Davidlohr Bueso wrote:
>> 32-bit userspace running on a 64-bit kernel is unable to receive MCTP
>> messages on an AF_MCTP socket, even though sending succeeds. There is
>> nothing for MCTP to do with it beyond not rejecting it, as af_packet,
>> af_key and can/isotp already do, for example.
>
>Hi Davidlohr,
>
>Thanks for your patch.
>
>As prompted elsewhere by a bot, it would be good if the patch description
>included some information about how this was found. And also to what
>extent the fix has been tested. I know you answered that already but
>I'm going to ask for a v2 for other reasons. And it would be good
>to include that detail there.

Thanks for taking a look.

So I don't think the changelog should be mentioning random userspace
programs for testing/verifying this - as the bot email suggested, just
replying there should be enough.

>
>>
>> Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>This seems to be a fix that effects users. Which I believe you have
>reproduced. As such I'd lean towards this being for net, CCed to stable.
>
>Subject: [PATCH net v2] ...
>
>Otherwise, it should be for net-next.
>
>Subject: [PATCH net-next v2] ...

Will do.

>
>> ---
>>  net/mctp/af_mctp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
>> index 8af5e2b3c8d1..aa22c0860712 100644
>> --- a/net/mctp/af_mctp.c
>> +++ b/net/mctp/af_mctp.c
>> @@ -292,8 +292,7 @@ static int mctp_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>
>Strangely this patch has been mangled - the original code is 7 rather than
>8 lines long. (s/,8/,7). Because of this it could not be applied by our
>CI which then did not run the usual tests.

Yeah I messed that up (noticed sashiko couldn't apply it either), not
sure what happened.

Thanks,
Davidlohr
