Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23D23184F
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971032; cv=none; b=lrdHk0vCTlPo411lGATntCrqyrlk3hfTIgxLXY2dgsYWCpJy1+Ubg9UUlJRKwH1BYwXqItdWGu5PgObxJAsBakQpe+1Ukada+6D/fIubuutC4xjUHWZ/PR8axtC+nmhPxHtFL3ZHD4B211wDM0MQp2YMO98kArlUaEkFdFnkjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971032; c=relaxed/simple;
	bh=UJauCrYozLDJnmamAMtW+Ho4D7gK7x/YeAXGr+aRHuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFKQQ9n7cj0N4SHNyTNH+C+Unq0pYFDhiwyrporZ449wl3IU+8HvEPc3V1lSF/vBS2TVoMkoG5huiW1FF552Tv6CO9UokEBnzDNJ55DGmW96XhZ1jTKyVhVmMLkom3+iU953Pt/G0TpjZYG8zgJ4pqB9egtBEgjG5vofXsaBPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Laq+mjsW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Laq+mjsW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so6639615b3a.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745971030; x=1746575830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov7WvUwg7vp5fmEn1HEPoojJfBNQUnK8cGdgZwbGJgM=;
        b=Laq+mjsW4kZC9RQeI/1Z6V/sk+v51HrhRBeEK6nhaoZ6wuSPj2QPUY+JFyam0hUZoe
         0UcNNLZoaWI10xXu0PvkXnnziFsLF4w6CgOXNQc3IXxz95nqN2giPmtk7nag6BPck4q9
         nHY71C++gXS7xY0SL1WXi9yP1pwfporkOjt94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971030; x=1746575830;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ov7WvUwg7vp5fmEn1HEPoojJfBNQUnK8cGdgZwbGJgM=;
        b=L7hALZNV43P3B3mTkA9IAeQRK8qjymi1g/UKkQVNLvmxJIaffmPk8SJCDKFNcWhGcK
         FrOBS59bWSq4azMGotjJqmNeFHAxaoly36s/0PPK7rbV8vpEJ2Z8PPC6yhDEQeyCJrVF
         /P7NDxbq9onJGwckIx8T00/AdmssWvBd/t5hWc++Ut6MK8GZkP4SNycZaOEU7OPYkAl5
         4xo9tYYetNlXZkJBpLhjYsZ0QmBvQktqM6G/zCG8Ae8y2OiPf8ZFrpp0QgZ40wbSte0r
         xVMZpyW7k54u23gqebWFKkeepM3NMij4aMM3uUeQGTeniqJ8SoOLKgDLFr4j3wF74i4n
         lbtw==
X-Forwarded-Encrypted: i=1; AJvYcCWyk2Fz4d8fjZtdUcuhCMZVL8r7dImzO6+5ei5Z7jKOv7VcbJJWRSTZCIsgdufvYS0ASBBXFw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAYK4Ulxd4H7ynQvextKmLgCHCXe102rtmXjd9KiYO25GpI19
	Z+2rGPvM7WzqFXmRcdMRdK4Y2Fwo4i47k8vrtVDDTiiTlgLbppJzRgGZugMxDo1bQ+sLFRPgz8Q
	m
X-Gm-Gg: ASbGncsRoZIKe7W66UJ2s2U6Yx6T0l3doFxkQLQUyY89q7w7N4qI435NbR3cHCEG+DI
	Dz9VtD//wHm5EI1XJg8obfdQ4qg63SLpSRWNFzNT13TfacP2gDGfnKL9XyR4hUDgDzrDS5pPIku
	uPhVXukCnrzuhv+6PGLOLu0Be7SRQYp0qYfpyjONZfoAaKsgEBTzo6hWIMnKcMxxV8GhuHmmwhI
	jnvTFfiBAsFor6iow8hJnBhjzWkY/YydUc6QTbGSR63JB1BUuNV6NkcFjyArmK+JdVzdBPvfP6W
	n+wgkQB/zhBL2Zbn5v3SFWf2zUxiQnD5Z0Dgns+VNFhXGStPVGyAB3CO7epiBIWHV9qt+diCM/a
	wMq8kNiLImH2q
X-Google-Smtp-Source: AGHT+IGfn8YmOzKc8w+eTbXBTqInnTGC8s0WT/hr7wPUzgO8j/W8j+pe3EpZTXf0qVC8/qHYlxvsRg==
X-Received: by 2002:a05:6a20:c892:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-20aa4685b1bmr708430637.38.1745971030394;
        Tue, 29 Apr 2025 16:57:10 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a30fecsm307052b3a.89.2025.04.29.16.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:57:09 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:57:07 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] Add support to set napi threaded for
 individual napi
Message-ID: <aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250429222656.936279-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429222656.936279-1-skhawaja@google.com>

On Tue, Apr 29, 2025 at 10:26:56PM +0000, Samiullah Khawaja wrote:

> v6:
>  - Set the threaded property at device level even if the currently set
>    value is same. This is to override any per napi settings. Update
>    selftest to verify this scenario.
>  - Use u8 instead of uint in netdev_nl_napi_set_config implementation.
>  - Extend the selftest to verify the existing behaviour that the PID
>    stays valid once threaded napi is enabled. It stays valid even after
>    disabling the threaded napi. Also verify that the same kthread(PID)
>    is reused when threaded napi is enabled again. Will keep this
>    behaviour as based on the discussion on v5.

This doesn't address the feedback from Jakub in the v5 [1] [2]:

 - Jakub said the netlink attributes need to make sense from day 1.
   Threaded = 0 and pid = 1234 does not make sense, and

 - The thread should be started and stopped.

[1]: https://lore.kernel.org/netdev/20250425201220.58bf25d7@kernel.org/
[2]: https://lore.kernel.org/netdev/20250428112306.62ff198b@kernel.org/
