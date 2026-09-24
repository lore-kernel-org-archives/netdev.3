Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8C470117
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268531; cv=none; b=PWBpt+33oOL9Le2SjmbU4G7NPAUACLH0pehstQXzZMxS+5onuIMXDxvxkvXOZNC1hzF/Ou3vZwfuEx2mgJeSimur9mT2mkAzlSnZpjNRcT5gMyrkR4+KP7hKyOOKepU5UDgwHevsSF+2EAgHxvhdX8+TWvLKfHqnOHUMZIHK9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268531; c=relaxed/simple;
	bh=mqes7ZYrl2lYyjMcrHhRtIa50AQ5sg7+ntR+sAcUwDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzmOv30JvEi/60Nj4uRF+4Uf1f9xNniYpxxSDgR56MXVqoF807yM3OVauCcvYIxYSmFqa1BVemssItDzpuYUms4JJftdjfZoTpsTUmDAFuhqZ6ALXNQW4qwJ/9UYh8oUH5RjVXEaWH+GdgFU1pclAq66axbzKcLbHD+a3PudCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smn+UAeb; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smn+UAeb"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso54378a91.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790268529; x=1790873329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+DqoVPMC1bGDO9h3M5Mbmf5AArk4lb3H8ksC9nEumo=;
        b=Smn+UAebUp7oCrjwzqRBg5OR3PUsU0ugFwcfVvX/wjAJg5VuoLhtWGbqerwn6fyWSO
         QYe/TbhvaQVtW9c7CJtf3QMnM4fLktC9XcizBnEy3oCsfLeDXbunNbWB8mV9y63YQOPl
         Pzkp1TXAyPy7rqYPJAyFTRja4QuYUOs7GDVesLi0rIv0jM9LGPId0O4axP1qySd9bkPa
         cwwAFHBdLvJCuvzpVzV4g99X5yXSS1rUr78ApWZfaxs5R5bo80uRY7dPvtxgsk4n4XXf
         9ZDSERliNJdVRyj9cKsdqO4EhahDI0dkMqoBb0zBPFKgF3xPUammP+/twVxknFzVpkmj
         hoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268529; x=1790873329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N+DqoVPMC1bGDO9h3M5Mbmf5AArk4lb3H8ksC9nEumo=;
        b=wcRBjFKkpVFG58W7vKGv0ntSZAd+L0l3jxLoMR3hLE3nbCMzLPSR/FKFdREKjrp9Kh
         YjhNeNSydVIbmuK8GmfGLAYQywGw2t8mNfW4BthOLRa9QwtOq+IjowWccuT7Jvbq2wj3
         uEp/bbhog8ZxOg41g6XjY9E5S3bJQ0hLx44vMCR7ByaPocC+HmX7c4T3J2ROAtwH0cTU
         yFuEToBFBjfyW/CzS9JZ8n2sb80q3vqApDJbIm5brvSgvOs0xYH2lz3gxBgtFZBIOhWo
         YFXF10zVDBNVTFtuVuXCFM3T33njjtv4eqVxnduGDTJxRrQnc8LeaSFE63ak0fzmEu/L
         mKHQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1tMR5yRLa0pCUitTeygxYH/lCWxtlMnM2mzMW7sL1pKPKJBmIoTsORUIpAX15vWmskiqJ/S0=@vger.kernel.org
X-Gm-Message-State: AFuF++k6ccFeB4qBUBO/HWtiUqSU1L/A0bCo+DjJ5qnsSxfGbu2iAlKl
	pBBnSAfb8XtnAI4oxf+6IlhQYzoW97CtERsy3RG1teFl84XOyiqf3tsE
X-Gm-Gg: AYBFou1dKZWRjZSuBJrKUrMU1JAJ/+OtpMw5SiuDfmxLpQ1CUk/OcuACKW3vqlgiGle
	thU/AGvbhVJqsksR+ZI1zRpXPE9KQE4JHmOUqcHzTXlv2zCeubuAwzhYyAevkbwnSmi0C1XLnCI
	HyqFdkfKI5bOUl9nZ8MexMhS3e10F9RJWjshkd9muSKAri3BhRidfU3kUwrX5VVe715/Yc5oBx4
	PdmDJw3sSBOKH4S3k19CpiMoJwDLyDDLuv+hSVcsyuuQDPlhMELI5ggL3Ca+d+azhQSBl80CK/l
	9Ub2Y6Qng3PYK948jhNODzuddyqOD2Pbt8/js5wB6vmLVnYLy+1KRUR5fHCZS8Clsc+esNuxsN9
	1o3yul1lPuAA6Il4sFcOKAFBoW7FTI1hAE9p0HtNTgP2oJV0XZt7e8OZcZ7zQRKYjYTcIpj3uz7
	S7vbadOhZCeu1RU5JbNJX6fc1oONl94HpZ8nX6QAxcGJCONJyS2LFNeEleuPFVLhBD
X-Received: by 2002:a17:90b:51c1:b0:39e:1692:34bc with SMTP id 98e67ed59e1d1-3a098ad4cd1mr2485547a91.1.1790268529341;
        Thu, 24 Sep 2026 09:48:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm5891202a91.7.2026.09.24.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:48:49 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:48:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, axboe@kernel.dk, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist
 helpers
Message-ID: <arVTvlvKsBRNG2aQ@devvm7509.cco0.facebook.com>
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-2-sdf@fomichev.me>
 <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>
 <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>

On 09/24, Pavel Begunkov wrote:
> On 9/24/26 16:02, Mina Almasry wrote:
> > On Tue, Sep 22, 2026 at 1:43 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > 
> > > io_uring zero-copy receive and devmem both maintain a bounded LIFO for
> > > net_iovs in a contiguous area. Store the freelist in struct net_iov_area
> > > and provide common push and pop helpers.
> > > 
> > > Leave synchronization to area owners. Keep devmem's area adjacent to its
> > 
> > This could be a follow up change, but I think synchronization should
> > be provided by the netmem/niov infra, rather than the area owners. TBH
> > the infra providing an unsynchronized data structure and letting the
> > area owner use it and shoot themselves in the foot feels error prone.
> > For now we could use a comment.
> 
> I don't think we want it. The duplication is minor, but I'm not set
> on the per area index array approach, and it'd make changing it
> more difficult.

Do you want me to not touch iou in this patch at all? Or are you talking
about potential future synchronization part?

I don't see how this is making changing it more difficult, the freelist is
now behind push/pop which you can freely change, and both UAPIs benefit
from a faster/better freelist.
