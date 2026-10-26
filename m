Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032276;
	b=tueheOcGS473yWP6sAGAU+QawlcpEanAVT/H1KOndBBsooy4xGElC/kP1aN2NvntqeqB
	 xzZ8As07jjxyfPkL9YaHsOIioTIQ0gSapbY0xaDGIGZtb2SHZiKG60MvZN+fZeCpvSTJ5
	 9lcXVFppdWn8ACoiGCJSHuQqPcarxzGcWEaY/tnMU3tyK1IMlR5AEv3e2XFAovI0jTESB
	 xAz5R3u7De8Xmwq7H3t3Eo5JkXqaFwmNL2zttV7iujwiWtG/t0IzOg04rKtMkX+agrsKt
	 khSA0ojf2My0sF1jT97iuOvbghxHnfyYh4fVVH5OHVjxTnQyOPi6d6QeHucXnJYsvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032276;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=72t4ZPEzLJcRzpEbum0CSL6u2zZCitOJdKXXiEuKcBQ=;
	b=F0ZB6CVnlA7eOaJb59djYk47nfvjheBqpI6ICSI/yEER+9pasB25lnJSxejWptOo/TqV
	 Wpa4SRQHzJ11BNypipwTrlY1ufUePje623IM+b589X0TIkgkJt+8qYY+0CvUGYTBSxInq
	 Ec4/3+Bz2AScApHWh9J48xataZRp9c5ZMzUPnqkRWSh4pMIbrXuKFkyk/z9kOZ99xxwrW
	 zqWJ+3yysoVBAd0pCmMK+od0mJO9B19voiETf/CwtM/ncQHrR2xDbkR4DGtqqNnsWVNrf
	 08rqJLOm9PxGAlfApVP2F2DfZpxNWNtyp36Ftitwo50ZRiNfXdbEAXKee5OZK1tTqLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d9iPFK6a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=URuDVZfZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d9iPFK6a;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=URuDVZfZ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A993606A31A;
	Mon, 26 Oct 2026 16:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A993606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d9iPFK6a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=URuDVZfZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d9iPFK6a;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=URuDVZfZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A48902225A;
	Mon, 26 Oct 2026 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793032273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72t4ZPEzLJcRzpEbum0CSL6u2zZCitOJdKXXiEuKcBQ=;
	b=d9iPFK6aH9G7eFwt6ycw+8p+zXIRWKBOUlY0H3zvmfTNyyzV5FqfY0MoZK2ZoIhk102g1n
	Elr2EfZbINOdMyflAmBfLP5YMMnP49M6T8rfQRb8OV4JabAHAXxbxO+ylu06Xf6+LykpKY
	of6Cb8ZPCU+tiOKDTvb87Fov5uspR50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793032273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72t4ZPEzLJcRzpEbum0CSL6u2zZCitOJdKXXiEuKcBQ=;
	b=URuDVZfZlD+f97mS6WIHas3+Gr74GDGyB11W86ug+BKiQHMd3p3q+A7KC2+02uBaDwna7L
	rMzSlsg0X2kx27Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793032273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72t4ZPEzLJcRzpEbum0CSL6u2zZCitOJdKXXiEuKcBQ=;
	b=d9iPFK6aH9G7eFwt6ycw+8p+zXIRWKBOUlY0H3zvmfTNyyzV5FqfY0MoZK2ZoIhk102g1n
	Elr2EfZbINOdMyflAmBfLP5YMMnP49M6T8rfQRb8OV4JabAHAXxbxO+ylu06Xf6+LykpKY
	of6Cb8ZPCU+tiOKDTvb87Fov5uspR50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793032273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72t4ZPEzLJcRzpEbum0CSL6u2zZCitOJdKXXiEuKcBQ=;
	b=URuDVZfZlD+f97mS6WIHas3+Gr74GDGyB11W86ug+BKiQHMd3p3q+A7KC2+02uBaDwna7L
	rMzSlsg0X2kx27Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3793513319;
	Mon, 26 Oct 2026 16:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OsZIAlGA32qZOQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 26 Oct 2026 16:31:13 +0000
Message-ID: <b24c7e91-7fba-428f-b76b-ba19b07ad1d1@suse.de>
Date: Mon, 26 Oct 2026 17:29:51 +0100
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
Subject: Re: [BUG] devlink: region trigger leaks a permanent snapshot id slot
 on every successful auto-id capture
To: Guikun Yang <yangguikun19@qq.com>, Jiri Pirko <jiri@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_BE912BA710539F285F9FCF28E854ABEFCD07@qq.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <tencent_BE912BA710539F285F9FCF28E854ABEFCD07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[qq.com,nvidia.com,intel.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

On 10/25/26 5:27 AM, Guikun Yang wrote:
> Hi Jiri, Jacob,
> 
> devlink_nl_cmd_region_trigger() (net/devlink/region.c) allocates a
> snapshot id via __devlink_region_snapshot_id_get() when the request
> does not carry DEVLINK_ATTR_REGION_SNAPSHOT_ID, then creates the
> snapshot.  On the success path it returns without ever releasing the
> caller's reference, so the id's refcount stays at 2 instead of dropping
> to the snapshot-only 1.
> 
> __devlink_region_snapshot_id_get() is documented as:
> 
>   *	Note that the caller of this function counts as a 'user', in order to
>   *	avoid race conditions.  The caller must release its hold on the
>   *	snapshot by using devlink_region_snapshot_id_put.
> 
> The netlink trigger is its own caller, and nothing in the kernel holds
> the id after the command returns, so the hold is never released.
> 
> Consequences, per successful auto-id trigger:
> 
>    xa_alloc(&devlink->snapshot_ids, id, xa_mk_value(1))   /* count = 1 */
>    __devlink_region_snapshot_create()                     /* count = 2 */
>    ... success, no put ...
> 
> Later, when the snapshot is deleted, devlink_region_snapshot_del()
> calls __devlink_snapshot_id_decrement(), bringing the count to 1.
> Since it is not zero, the id is NOT erased from the xarray:
> 
>   *	If the count reaches zero, erase this id from the xarray, freeing it
>   *	up for future re-use by devlink_region_snapshot_id_get().
> 
> The slot stays occupied forever.  Every subsequent attempt to use that
> particular id fails:
> 
>    - __devlink_snapshot_id_insert() rejects it with -EEXIST (xa_load()
>      finds the stale entry), so a user can never explicitly re-create a
>      snapshot with that id;
>    - reading or deleting "the snapshot with that id" returns -ENOENT,
>      so there is also no way to clean the stale entry up.
> 

Yes, this is right. I am sending a patch. I reproduced it on netdevsim 
and Intel E825-C with ice driver.

Not sure if it is worth writing a selftest, might consider it as a 
follow-up.

Thanks,
Fernando.

