Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42843F8D3
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428106; cv=none; b=ItGT2ifYbRXTb5XucR4xWp0xFzjOXPtrkVHGYmiQQnG0rxjouRN+FEQBiawHTjSV86ASHehyPqVc1NzlZYI64c7H6h3BtMBneYnO/yBxJImNZXrA0RFXehsSrt8gTMV+AlJLqsmilYAcnk+CNkeyXQXSdF/0eXpUjvZlAXY4pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428106; c=relaxed/simple;
	bh=Prrq3lRrNtjBMcFNoLT6vy0bmYe4ExXeIRC0llIkt7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V62tkykvD+KCRSxoa7EMI9KZbCO9NFRY1o5porjeMgAN0NFqL7hQuu/1YnNyoB9mohYu/e4a4o+j21dzI8T5mfW9lcWCnZutYSo0VSJqePOl0aKmevdJtGfS9J3W4SV+ov9JjiZBGlifnG3jJlek/qvu+NGCxNTh54fIuPqMREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=aD1x7KZO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="aD1x7KZO"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38511175ad3so34777a91.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785428104; x=1786032904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sc7/PIL5nmBZuTJI/qyxnyFN7S+kHFcyfHQ2vtF45hE=;
        b=aD1x7KZOof0CcjkO3K2mWdjMAAFm27fqdl7lL9hKPfT7nYI/samOcztz60bwQqvTPE
         wFyQsC7b70zbV5K6ObSxMVMDfwqRXrBLb+8MozDJ/MVkPH7qUbhzdEAUYxKLYSGqxLMA
         5coRJy5pRS4vLsXDunzwN4PDIYvKWsQaMEE4QtGTOtlUDa9ijQJETS4xUHaQJh42o1+1
         q31yDnWZcszUH53+AQZNb9dPr94O6Qmme1jJDcEh4rAaH8Sn3X/Peq6mLw+6bFRTYFCN
         aE5yGr82pAMRs/cmeZkd42a4dpwg2XgrW0bhcBbOM8re1S7ktPRrEAFLhrYcnD/FtP/f
         WbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428104; x=1786032904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sc7/PIL5nmBZuTJI/qyxnyFN7S+kHFcyfHQ2vtF45hE=;
        b=LdxBiiHpaGjPLi7ztHJGgybs/InrvriDGXdsEa845oOMdohRml1655OIbkEwWD5AFe
         HuZGqOtEEVJ+C5R4xyhqCV6Qbzk75gKuCx19D9o5vERkIp6auvGLCEwzQp31KFda0psg
         7Ec+yXyBnfBjTO1+nGR0dj76ClAE2Og/fzKTQ1j3/gczvWKjX00DkpKCcCkh8AXwGEWs
         DJWx7kmbdf77sxlVepPJuGf0Eyo8P6+PwCMWVfRhBMNklHvq27pv74x1KAeKPO2HlXOd
         yeSoJXKGImJ0X5ySELUxRDb5FIQ7ORCw91qhH162Y2RMATEPjTjC2upUM+CUhSrqEI+a
         J/Mg==
X-Forwarded-Encrypted: i=1; AHgh+RrW8iVs0tREpq7x3jPzrAvyVHvJTu0QIEwKJaH034mOuQnH5A9tsDZWa2GoJ1st6FQ7ge8+69Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdErDqJ9GsK+rKB9QKXN8Pnu27Sxwx4vWrORvwAQcu3cic7Z8k
	+9dVKj6vNFaFb1xNMkEQSy+RtwvOFrdBQXT8Ds7TUHfXqo5kPcqVdRpoPGAcqgE+LQI=
X-Gm-Gg: AR+sD10hoUYs7PRX4zcdS664UOWdXIlN9yYP4pkkTqoZa4QEfrkJ2IBjd2Su9MhAHWi
	aQuk0yRwvQO7Tfpzl08r5VSguafLH2ubQl4xCaavQoGnt4aFfUP1uN83OxPn8JeAAwsDnd0SqXT
	wUwSUxLytvzE8mZ9quiGdkW9HxpwyaitUhWrFUv80Vnba6+4Q+NQcFJ0LU6y0KvX0JO0SdK+6sL
	Ci5dpBOctTpYbnOv84H9cLBh+VkFQzGoXMzb7E+el2uQ+nq0QEfOhUXMi1y09XA/M72BOGWnbXX
	i0IqT+ehA70dop1xT7MHSRv2sSciQI3i5oL+t4hS2GpGN3q6ie2G2jl4GLK5ufnyB+NfJG1pbry
	OTojhxc1Zv1INxcRwb5WrHEHcpRK2LBi4X60Cued3N/T6/TQeoNej5xPFMQ1tIhL7i+5a5uthgY
	ndcmJL05C774KiUQGNuNZFeYWH+MnI29wuzx09slu0awCCXQPhPi8E
X-Received: by 2002:a17:90b:582c:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38f9bdd2f2dmr2888847a91.13.1785428103654;
        Thu, 30 Jul 2026 09:15:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38faba8491esm4092a91.2.2026.07.30.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:15:02 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:15:02 -0700
From: Joe Damato <joe@dama.to>
To: Hidayath Khan <hidayath@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, wintera@linux.ibm.com,
	aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] s390/qeth: validate user buffer length in SNMP and
 ARP query ioctls
Message-ID: <amt4hhb/IZwi+0PE@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Hidayath Khan <hidayath@linux.ibm.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, wintera@linux.ibm.com, aswin@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260730142216.218309-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730142216.218309-1-hidayath@linux.ibm.com>

On Thu, Jul 30, 2026 at 04:22:16PM +0200, Hidayath Khan wrote:
> qeth_snmp_command() and qeth_l3_arp_query() allocate a buffer sized by
> a user-supplied length (udata_len) without checking a lower bound, then
> set udata_offset to a fixed non-zero value and pass both to a reply
> callback. The callback bounds-checks the copy with
> 
>         if ((udata_len - udata_offset) < len)
> 
> Both fields are u32, so a udata_len smaller than udata_offset makes the
> subtraction wrap and the check pass, and the following memcpy() writes
> past the allocation. A udata_len of 0 also yields ZERO_SIZE_PTR from
> kzalloc(), which the existing NULL check does not catch.
> 
> Reject buffers smaller than udata_offset before allocating, so the
> callback subtraction can no longer underflow.
> 
> Fixes: 4a71df50047f ("qeth: new qeth device driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 3 +++
>  drivers/s390/net/qeth_l3_main.c   | 5 +++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>
