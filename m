Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715236;
	b=WF95aFM3956BRDmNdxSsBtPGax6QuRLr0pDJUdyUXAvmF26GtNXNcAu52ZN1BJB6sO0Z
	 Gzmc3phJUIRHmt20UmlhD9+0WojpBPrRKFhQW4Nn40ESLudgy1yz2I6Uigvx2lt8+EjKw
	 GoE2qN0hUIgAaiBgjHKsPnoW5XRGS7ltU2KN80NOZcv+mIyVtR34i8rr+P7GL2rRjsQFG
	 DeXKku3n5o5wXNDE5d38SyBQUxSRhJ2FL71b+DT2WJAmUn8x4vSfB2vJLekChWXcVtd1K
	 i8JCS1oQa/aiXPwwFunUJwQNs48a2LUsyUTX+q2ScNun/l29QfMtqsdcI23FDC+Fm9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715236;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
	b=xjRjYABz2P5xEJ+o2GDpyw93KcpIfAcKGkecmRxSL50+JWtddVsv790e3LypmwZThHv9
	 dDPSzJp+Z2IzQ7VUN4CnOPhucdwFxPca0XYT1h/S0HDSxKH7bvOSyD+EBuw4ntCQsPQqJ
	 x1IepAjZ9bqEfL3Rye+NyzC8PIZmA/pOwgX8uesAFEU7sFSdzVb83wFsl3g12pGsAoXsg
	 SAHsL4DAv+Dj0f3STrTv27WRfzsVF6TqRIHp6GtnquEHTtcRiGaSdx7dWURRXQj8lX0rY
	 CQrRancmqNDaVuhAKSxtqwTsxCsa6NJ8a6jdmORvVi0/1CDnvOtYjejimRZysOqX3cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TtqHjydb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AVQjKBA1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34319606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34319606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TtqHjydb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AVQjKBA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793715230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
	b=TtqHjydbmamDVjJ1zrJuz99NaZtZkIBTnf+TLS5dwN1ZVqQCN3iUiq+2jYgSt82kZC214e
	xrvI7XnR3Jc/wb6lSWrSYGjNGwH5F8YuGNf+Rij7jmpW0PzMEsV3X3nSlKt9C15auluPSw
	2AJlM2NZkpurOqM6hVyKNQug4zA2tRs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Ru2Uhh5ZNdedr8BUyPZmlw-1; Tue, 03 Nov 2026 09:13:49 -0500
X-MC-Unique: Ru2Uhh5ZNdedr8BUyPZmlw-1
X-Mimecast-MFC-AGG-ID: Ru2Uhh5ZNdedr8BUyPZmlw_1793715228
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so3593408f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793715228; x=1794320028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
        b=AVQjKBA169gUofMYoGO/GaCNAEe/QzKNwVBrNO7GBtMqBtvImftjx1cbGwTyNvWBql
         mWUaMvK/O4H7J1Kn85BnLrXYLiElLeqT1dxNj/YacPyiyOXBoDdEqIcRcuiclkPuvKG3
         P9IfR0q9rCuY355Hi9vQPeXpQpxm1tkk6YnrYM+H4KdvYXvt8E9Cw3Et2B1CzojdR4DT
         /B2AvFQE0MW0GZpgIdrFLe0qagDY4wAz6GULGhwcFRJkJ1KAOwuv+Mbf+ggscTj3hEk/
         hH2W6ZbT1nhrZkdS1C2vW2SES4pLxjBSMfZ8h7amydZvPJs6WijkAgO5LMqpjmQZFfKF
         u8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715228; x=1794320028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
        b=BA5DheeEFdo2OoQlQuTosAJJZJSUx1hOUI2sM2oi05iEW05M3wGEziUEqHigtO6EtQ
         h/2AIs8xdJ/Kxl+ulAEQ/urIdHNVq+w1bbttCKvjnKYBV6So0y3x/5tiXlAH3BsG7lw7
         pumhw2/lJ0zZ4AoxFgbNm7kCdRj+FijWfjF/JOXfEYVKScPP/r7NvHJ+fgWY4IbT17vh
         x0cxlc9V0fUHf2Qh1MQGxFdJeWFL3x/0Ha1Zih0OuQNwqr/BkgoMvQLpSloxZB8mkzYk
         msRx/pZAcDrXzaiZ2kiHjnDAv/8tpJVxfDSkpCXIrDyR2zr/tcUCCmuIDMKVCUMVOFRV
         /j1A==
X-Forwarded-Encrypted: i=1; AKwUvByXViIvwo3845tj+kexrF6VpXgBV8Av3n620BgBTt3yocDCUZ39nlyAclKeXN7jzGtHChE7gs4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mvJ+9j2qkdwIy9SPKpi5ITij3hZj+C+ao0Vjq2RtThy5D9Gtm
	pY4IXBEC37eAoCwJUP89IXfC0xhQAFnw0hHQud2Mqr3D46sugdMGX20Y1lufDN1dR6O6Xl7OmQP
	q1nvhBn6kwSx7AhvwcktltKctgiUK+FY7TFSsNJgmLeKVPoFeUwolVsCmdg==
X-Gm-Gg: AYBFou28RsdNbQIaJ0gyuNClWFlZ2e67OTno/iqdzgZUZEpV2rR/xG4/kkDEQ3t+ueS
	PNUQAM41fn0VSSUqSa2tlL7ujIMzPXehEANqNOblNHVi+80mJ9d0BjtZueNLHrjGu02bVLVbx4N
	dYhA4zWC0WXD5VUieUfYjlVROVkEEoZtEoru5avBhzs9FYJyTHS9ks8RySxYz5Kvk+JDdwytrXd
	46R2YYC8g+qfTpZFIZZfY/257KnQUotEjU95NPcduw8wb2fSDQp2I+Wi4oQePDDRkH5S5/8NFBg
	obI/uZuEJtwt6ODAFfOM6Z09NVmSly0IRdvCRujqFZIJDE/ZlgkihVTs7WStFABoD0C/YvriE9U
	GRzKYXB/BjQAGu99x5VoJH+2VDND984l2vz2AGFRvGnWcOVlnrTD56TcSILqyAGHl+cH7ooGUAa
	srjhHGyW36EIQFVcTjAHZ9y8I9d9eP4h9GS6tXEeFrjGA=
X-Received: by 2002:a05:6000:40c7:b0:48d:f1b3:c02e with SMTP id ffacd0b85a97d-48e6e5016f1mr30505643f8f.25.1793715227744;
        Tue, 03 Nov 2026 06:13:47 -0800 (PST)
X-Received: by 2002:a05:6000:40c7:b0:48d:f1b3:c02e with SMTP id ffacd0b85a97d-48e6e5016f1mr30505585f8f.25.1793715227337;
        Tue, 03 Nov 2026 06:13:47 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9a3b1sm27222574f8f.44.2026.11.03.06.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:13:46 -0800 (PST)
Message-ID: <d0b6c2ba-34f2-4750-92c3-fb65c82cbc9e@redhat.com>
Date: Tue, 3 Nov 2026 15:13:45 +0100
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
Subject: Re: [PATCH] vsock: reject negative tv_usec in
 SO_VM_SOCKETS_CONNECT_TIMEOUT
To: Stefano Garzarella <sgarzare@redhat.com>, phind.uet@gmail.com
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030064428.73930-1-phind.uet@gmail.com>
 <auSIGIZctLp1oOhf@sgarzare-redhat>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <auSIGIZctLp1oOhf@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 13:09, Stefano Garzarella wrote:
> On Fri, Oct 30, 2026 at 02:43:50PM +0800, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> The timeval validation checks tv_usec < USEC_PER_SEC but not
>> tv_usec >= 0, so a negative tv_usec makes the timeout computation
>> wrap into a bogus value, later tripping "schedule_timeout: wrong
>> timeout value" instead of being rejected.
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>
> 
> This blank line shouldn't be there, maybe it can be fixed when the net
 > maintainers apply this patch, so please wait their comments before sending a v2.

No need to repost: I fixed it while applying the patch.

/P

