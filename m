Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F53D6CA3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762944; cv=none; b=Cgeof/Aqzl2LkiAdLvmNXzINoOnRAA8BHav0zH1Zo+gCviCs5yTt3zSRFnGyJ4IhN7Q1Ry3YYwJ/Pu4SnLjgYmiPPBMulNtLL1iKyDzo+6io0kgrP98nndIyoAKWuDG+6ZRAFRXTetHeXosfGvQ7quHn4O10E1gKxK+cvww7Yd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762944; c=relaxed/simple;
	bh=IsvLHUOZul8w0fwJh2bAqclGMkUs8QtIPB6vt5r/1vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPIarvunW4VwFOtFzul5hr/4I2ykWDFiliG95pnb+B0G8zoQE+KyKuAXXs9BNdhrxpcV0ou7mNYJPkBIW2Fv5DjNHW9xdOYAeC04Onc/c1FDp6dOlqf0pY/78iUVXiLL8BwUdWzRy50vbXb2EwFcRTjYzMd0/mrBl9RZEeDu3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PBVnrQbl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ew4rNJxp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYVJJC1v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5oHIJAeB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PBVnrQbl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ew4rNJxp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYVJJC1v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5oHIJAeB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A563821C2C;
	Wed, 30 Sep 2026 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790762935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCDdElIcjPybRLjGACBbvGRF9c63glJwdO8SkOJQmks=;
	b=PBVnrQblJc4agrEAYvNu7PiSxvpCgj3Ndr2OOU523Ei1hoOSALcTtZFxdqbLj6hkGTrY88
	LidiGeoETNGjsX/5tgh19bkNJPMSfpAUI7fBvy+gMQype+kFjyM4fs4765ZcIHeQ+P3v9Z
	s88p4Q0akcWjG0jp8/vgsopIRMyw4hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790762935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCDdElIcjPybRLjGACBbvGRF9c63glJwdO8SkOJQmks=;
	b=ew4rNJxp62PsAmzgQvyDWaF9TjnidsRhxhc+3gt6PVtOM5M9f42f+FuKIGsNkGySyWHZON
	fjn6bZY9xtzEvVCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790762931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCDdElIcjPybRLjGACBbvGRF9c63glJwdO8SkOJQmks=;
	b=aYVJJC1va76cJ7/VX6GVbvUEmxlqG+JZA5zhiTSn/XO+7kWe14d29NKqz+mjdr/zUNar0K
	xydlGQ0I8tSAxKrqdjtFGgL9X3T64eMGBDtbfADYvjLPoPkCJt21NmifRWdCmqvNacJkZ7
	jkobeacUb88Lc52EEkgAhc2SC+zHnJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790762931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCDdElIcjPybRLjGACBbvGRF9c63glJwdO8SkOJQmks=;
	b=5oHIJAeBxeCkflM0QBQsJEQOvVnHDvAkB+XB68XqPplLbTJdOBfmGLeChjXYRdNc+zyx60
	DMXBu8lI+gZfyHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6D09136AD;
	Wed, 30 Sep 2026 10:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XfPiLLLfvGrhZAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 10:08:50 +0000
Message-ID: <ebcfbfae-7bac-459c-ac2c-2a5ce2a39aa1@suse.de>
Date: Wed, 30 Sep 2026 12:07:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: fix NULL deref when joining a group without a
 socket
To: Jiri Benc <jbenc@redhat.com>
Cc: Wentao Luo <luowentao077@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Antonio Quartulli <antonio@openvpn.net>
References: <b397156b-c184-4061-a9d5-52cce5c4f07e@gmail.com>
 <b3682f3b-f895-4843-815f-7f8a09530ba3@suse.de>
 <20260930080353.0ccae75b@griffin>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260930080353.0ccae75b@griffin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,google.com,openvpn.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On 9/30/26 8:03 AM, Jiri Benc wrote:
> On Tue, 29 Sep 2026 17:27:01 +0200, Fernando Fernandez Mancera wrote:
>> On 9/29/26 2:22 PM, Wentao Luo wrote:
>>> vxlan_sock_add() ignores -EAFNOSUPPORT when creating the IPv6 socket
>>> of a metadata device, so the device can come up with vn6_sock NULL
>>> after ipv6.disable=1. A later IPv6 multicast join still uses that
>>> socket. vxlan_igmp_join() dereferences it and oopses.
>>>
>>> This was observed on an external vnifilter device by adding an IPv6
>>> group while the device was up:
>>>
>>>     BUG: KASAN: null-ptr-deref in vxlan_igmp_join+0xb8/0x18c
>>>     Read of size 8 at addr 0000000000000010 by task bridge/729
>>>     Call trace:
>>>      show_stack+0x18/0x24 (C)
>>>      dump_stack_lvl+0x78/0x90
>>>      print_report+0x468/0x5cc
>>>      kasan_report+0xa4/0xf0
>>>      __asan_load8+0x7c/0xd0
>>>      vxlan_igmp_join+0xb8/0x18c
>>>      vxlan_vni_update_group+0x2b4/0x390
>>>      vxlan_process_vni_filter+0xfe0/0x1750
>>>      vxlan_vnifilter_process+0x218/0x270
>>>      rtnetlink_rcv_msg+0x1ec/0x514
>>>      netlink_rcv_skb+0xc0/0x1f0
>>>      rtnetlink_rcv+0x18/0x24
>>>      netlink_unicast+0x4b8/0x558
>>>      netlink_sendmsg+0x2b8/0x584
>>>      ...
>>>
>>> Return -EAFNOSUPPORT from vxlan_igmp_join() and vxlan_igmp_leave()
>>> when the address family has no socket. The same leave path runs while
>>> rolling back a failed join.
>>>
>>> Fixes: d074bf960044 ("vxlan: correctly handle ipv6.disable module
>>> parameter")
> 
> While I've introduced my share of bugs over the years, this one is not
> introduced by my commit. Commit d074bf960044 specifically checks for
> the metadata mode and leaves the ipv6 socket as NULL only in the
> metadata mode. In the metadata mode, there's no multicast and the
> vxlan_igmp_* functions are never reached. This was introduced by a
> different commit.
> 
> With the current commit message:
> 
> Nacked-by: Jiri Benc <jbenc@redhat.com>
> 
> Please find the real cause, fix the Fixes header and resubmit.
> 

That is fair, thanks Jiri. I didn't realize when commit d074bf960044 was 
written, metadata mode did not support multicast. It seems the real 
Fixes header should be:

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata 
device")

This commit introduced the multicast support for metadata mode and 
missed the NULL check.

> Thanks,
> 
>   Jiri

