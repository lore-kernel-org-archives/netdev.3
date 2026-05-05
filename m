Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51237B014
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012211; cv=none; b=mUXbj5fL7Gt978oo3tYCgAGUkuwQN9frs/TBIFQIavGGlx0HQBNwxkPtXS9TpAkJlIBU1XMFeZSqVl/za4FYAku4UsbTFAlHMHg68+nASqIqiB/c3xvoYEKQ6zP4BO8sowqB2J1h14YrbKB/34kx2BNC/AfKDVhLANPMN5bDR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012211; c=relaxed/simple;
	bh=GXAqV88x5Xb+YY4JsTGo8ZAGmXq01eSpP5hn0qhUHXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuqHMeBiQNXzJA5d4vGgcIR+d5+yGck1NCYQmCIzy9c72lPjEhpzzvbSQQhqa+HeZBuPJj8PwGCHb3LWQjlD75AqLG+5a/ol0a76fgjh09bAslIupMhbibma+LiPlt70Pa8GlIX12xGdrA1Iw+p1dg7bLH2eEXXmcHcyWZS6HVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xh14gR5A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mm10QH9Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KeSHvNa8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ctv9iLuE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xh14gR5A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mm10QH9Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KeSHvNa8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ctv9iLuE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49BDF5CCC6;
	Tue,  5 May 2026 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778012208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5H3oEICDII07SLyMpBM+uO6NZsICwMRuPSRu6pSEqWM=;
	b=xh14gR5AcwfnWFZQfOX6HVafj0vcAwTxYS8f3h+p1UTCssW3eq+g5BrpTKofEShb2yrQ3r
	KtbziU3370CCf2XegAYcpwFefLbRR9o94r51JV3znPkwKIN7kXe9tgjKDy2pt4aDyp3pxv
	lQkWrtmx1q2Un7TtUa9ivI7HlvJHPD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778012208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5H3oEICDII07SLyMpBM+uO6NZsICwMRuPSRu6pSEqWM=;
	b=mm10QH9Zpfs3Ty/kaAR8qTH9De4AOtSY5ACu5ywVkLhfF3Nzgvpi9dtEzouVTwZTF5i5Mz
	0GCnYaMMcX4nuGDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778012207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5H3oEICDII07SLyMpBM+uO6NZsICwMRuPSRu6pSEqWM=;
	b=KeSHvNa8BA/831WPfwi44f0T1Lko13m+9yTOi+7k07PE2vUt/7IOR9niMNQF3Ekj4laDBy
	5Wx8h4Qnc6QiOLU1T/j1M1hzU3Dp9PatWyJrsC9uuvfk5iWH+tJ4mN6OpJng+AMrP8SHvg
	8ku08bvlUDeU2AmvGbfg9ib7XsHbrkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778012207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5H3oEICDII07SLyMpBM+uO6NZsICwMRuPSRu6pSEqWM=;
	b=ctv9iLuE2s/RHJWMS/FR0kAKUUcThHis9ls2avIYzm0FyIt2fR5I85Rj598qeVcHf8MN8u
	9oOXIRgR1Z3S/3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C05D593A3;
	Tue,  5 May 2026 20:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oDOkIi5Q+mmmYwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 05 May 2026 20:16:46 +0000
Message-ID: <f88004e6-4a92-4c32-8259-1aea572eb6d6@suse.de>
Date: Tue, 5 May 2026 22:16:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alyssa Ross <hi@alyssa.is>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260503192515.290900-2-hi@alyssa.is>
 <5f676587-fcdd-4704-9523-07a7fd98455a@suse.de> <878q9zdz6s.fsf@alyssa.is>
 <d299649e-d01e-451a-b604-76c8662f1ecc@suse.de>
 <20260504170912.174235db@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260504170912.174235db@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 5/5/26 2:09 AM, Jakub Kicinski wrote:
> On Mon, 4 May 2026 17:01:43 +0200 Fernando Fernandez Mancera wrote:
>>> Yes, it appears you're right.  I had only tested on ARM.  In that case,
>>> perhaps it make sense to instead set this to m in the arm64 defconfig, to
>>> preserve the previous situation, but I can also see the value in
>>> reducing platform discongruity by letting it change to y on arm64 too.
>>
>> Changing it on arm64 defconfig would make sense to me too. We should
>> probably visit other configs that might be in the same situation. That
>> in my opinion would qualify a net tree fix as you proposed initially.
> 
> Right. I think the fix as posted makes sense. Tunnel drivers should
> be =m. If other arches default to =y that's likely an oversight.
> Fedora and I suspect all other distros (and "prod kernels") set SIT=m.
> 

Yes. I checked and every distro I saw is setting this. This make sense, 
thanks Jakub.
