Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673275;
	b=0Ycy4Sh1tO++ms7qQSk4hu/J5irahaH+pc0EzPlpe1acOr5bV+z1GWMitHpe3nOjXhYK
	 t4LywE4UL9vQpLegmwsQIO10GL/KhxHUKugYF+bzjy+QIzxve3q4u6otDv8qHb2jGP5hD
	 XXteGYklRpYVwFkUtflvlJLFqFzhGGy1JjiL1HDTPDkK0WN1HN+twSLkhJ9BxLC6cwV+D
	 y6p1BtYZdoZwD1Vo3FLaZ6UjGDwDFUHf87cqVJXCcvcVoThIEzpjiYZ95IAP4HS6fdN0q
	 fD3YpjGOjxVEG5nUuPik+oeKy73+mJ+8NPEZ2qO0itBmyM7LQ5rYh6Xj8Xrz8m9l8CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673275;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
	b=E3pxcALJlahhBaG21nekSloguLRmAv08I/1YWgEHkdvouO5wK3sXq4mYYhMbpI0A3wu6
	 S9qNJEeLb/hrp49RI80QX4ZxXlew/8/i+ZVSVIfLrhlHrvrKsBErqhphDGkh/I/YvMEBS
	 Dluwnh97NscA96Dj1hl1TYL4MrjrqRIEYdURVJVBrOt6U141nO6SfxoRsJBbYnPSsTiwS
	 v0U+4MXeBaksxngwnPL5B4qi9NC3f0/aQrvxjDCvD27Mfs26aBX4nIfQGs+xNTcxTIsZl
	 11obXskkb0eI0yMm6FXOlF0k9AZZ/DA64e0gCLuOzqPvRJA7zOtpngaPMTUU8r0HXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="aKUa/bJG";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NwrUaG83;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88FA606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKUa/bJG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NwrUaG83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
	b=aKUa/bJGvKUDfqIbEIQMHvmW56C0T0v6AU4DjxSmaL34C03BHBvShsq22/FFSQUIwByqOA
	0jbMl38VAIUeTlFcHaYx4QhPiZ6KTXXxmdpkDIsxDidtwpc/gx6fs2BLG72VFsOhoXg1vF
	3pHJtAJ+iJYvivZ2J/LFHxgP/SyaQH8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Y8jAS6mNMQe25cynwWdjwA-1; Thu, 22 Oct 2026 12:47:47 +0000
X-MC-Unique: Y8jAS6mNMQe25cynwWdjwA-1
X-Mimecast-MFC-AGG-ID: Y8jAS6mNMQe25cynwWdjwA_1792673266
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so1197396f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792673266; x=1793278066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
        b=NwrUaG83jbWFrqnQu/YcUypkM8/sZ6PVE2zAiyG7lltsynKLGijmKSFuV98vnQvc5/
         FXYTQ4v0sixejO3NdShq8G8kluFCAioZAGIokPSkIUvnYRhXx1VRLKIvwR3QFHapG39c
         WTxuntCzeowy3iIMruugR8Heo1r6vKJiwIXXqsBJ+DDBPfdetwhiTxFtmaKDD13fmlz5
         6/EtCRp00L8ba/V18qeZvcWpLTGkGsWHSBUwhcz9XrFk1QK1s2RfumC/B3sKzti1zn4v
         FHP7PM6wFeM4wGHx0aIVE5wxc+u1flROu+toAK99KciJddYpXQhPihw/uR2eeQ0Y6/Nm
         fIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673266; x=1793278066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
        b=h4nEXWbrz64IzR3tWuRn6q7Rlh3iUvwiP+y8pLau1DpCZ/0jE+goCp3MhW45ruH1SU
         kpKzaQZao3mv5yNQKbMqwLdlKRZpP+R66f1BJzqN3cUfOi4FXphCy5ePNLzPzs/GYPGR
         NE3KyG5/SZla9EKkMGZ84IIKMcRNyrk0sIuWDyouzj5+2xQ0PnqgAqZvgr0knFTmtrdX
         sOxeiFNxg2C4/2FZ3Pq2MmWhd/XIAt+LZkIvS+2Ai15qhe2ci02uYr9OkjUtlN+r+EyT
         +ssDEGB6OX+XuqUcpPIyrT7TuQ0NwklZslOyG3IwlteWI2Esyo296l1wr+O+jD0Tx4B+
         ONwg==
X-Forwarded-Encrypted: i=1; AKwUvBxR9uyJKBuFFBuXWLe7Z5yv2bv255GZGJqI9Q7n1xymmobmeQwdfc+aT55wjMgbA4aqTj61l8E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjspVAKJ5yibhPe4rQCafMv30/Es1pXl8C6+c1ZqJx+akfdTvh
	2I9Fzy7IhTxCiwpgHxpZUr5KVfUQtR38xG1ncHNnm40Pe7j3CDcgkHXcSuAQ/P0P7ImI8uxpkJC
	OtYXkn565NRv/p0ynV8p/FYDoHtBrmIf9ZAdWQfFrALCj4wfA5L9/NKSL6A==
X-Gm-Gg: AYBFou33noR+8il1sIA+L0fd+nxZrA+95ysxrTVHhSl7dN0zjRo22irxublyokZP6Uh
	ao+T2jea1NXNOl6/xQi+farTv9BtsFuoY8UjYstPKZ0RIvYvomar4aLIjbe4+ZvsSylPwg7EHeQ
	dl6UtmjuoxV5oV2ocxrI2svnZpWZo+M2bS8QRB2XvRDEvf7EWgcsbeM9a7Biy/w1bHQoLywxodQ
	xjI1teduJ8BB9DSf9guJRYGMAojl5OrZITR2KRSAYc3SNf9ZBHCVwbPw2GJqGaA6gGoaTPYP7T1
	L4cQHMCnmsd+7ByF8y7iTBG2W7cQliU8KNRNUFKsgalmAhCU3N2rvdXe3ALhmSz5hPBT87nJPpd
	Fwtq7YH06z6kkySUZ+Ly2gIGoNMfO8vvn30X9BIDfzSMkrziJEfbgAYBOmffBh8TEJZeHGGYvHg
	==
X-Received: by 2002:a5d:5f05:0:b0:48d:f14a:917d with SMTP id ffacd0b85a97d-48e264c96c4mr10362142f8f.16.1792673266272;
        Thu, 22 Oct 2026 05:47:46 -0700 (PDT)
X-Received: by 2002:a5d:5f05:0:b0:48d:f14a:917d with SMTP id ffacd0b85a97d-48e264c96c4mr10362076f8f.16.1792673265657;
        Thu, 22 Oct 2026 05:47:45 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e2esm11945581f8f.30.2026.10.22.05.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:47:45 -0700 (PDT)
Message-ID: <51c656b8-2801-4edf-bbb8-f5e4309e910c@redhat.com>
Date: Thu, 22 Oct 2026 14:47:44 +0200
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
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
 <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 13:19, Oliver Hartkopp wrote:
> On 22.10.26 10:37, Paolo Abeni wrote:
>> On 10/22/26 01:07, Marc Kleine-Budde wrote:
>>> Hello netdev-team,
>>>
>>> this is a pull request of 11 patches for net-next/main and obsoletes
>>> pull-request: linux-can-next-for-7.4-20261021.
>>>
>>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>>> CAN-XL devices.
>>>
>>> A patch by Sang-Heon Jeon removes a redundant NULL check before
>>> netdev_hold() in the CAN RAW protocol.
>>>
>>> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
>>> for the correct CAN CC/FD frames.
>>>
>>> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
>>> any context in several CAN helper functions.
>>>
>>> A series by Oliver Hartkopp et al fixes several problems in the CAN
>>> net-layer:
>>>
>>> 3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
>>> pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
>>> calculation after a statistics reset. Followed by a patch to remove
>>> kernel pointers from the output.
>>>
>>> The last 2 patches are by Oliver Hartkopp as well, they convert the
>>> unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
>>> protect the CAN receive lists with a per-device lock.
>> I'm wrapping-up the net-next PR right now, and this will not make the
>> cut. Still all the material here, after forwarding the trees post PR,
>> looks like 'net' worthy. We could merge it afterwards.
> 
> Thanks Paolo!
> 
> Yes the patches are indeed mostly 'net' worthy fixes.
> 
> Unfortunately sashiko-bot complained about something new in my patch 11/11 and suggests to move some release_sock() calls 4 lines down behind sk_error_report(sk) :-/

Talking about the obsoleted version, right?
> Would you like to have that re-spin PR to be named as "net" PR ?
> And when would it be best to be sent?
No need to respin just for changing the prefix tag, we can apply
this one to net as needed. Generally speaking we are trying to
avoid unneeded reposting to avoid nipa resources overloading.

Thanks,

Paolo

