Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170513E6392
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142996; cv=none; b=Y5L8bY3QUQlvGWdtrQwzg56W4aLtLc2Hl8dBz2rMryUWAte3ddiS8fA55fDQ+LGEjlTDF5VJOgX3854WtsBHNY0FMHaq9+voopIyHaplyKXjmRHyR7bWh6ByXFgOth9qLw0w9axW92+obD+QB8HmaEX8YPGk8oMDo3/M3t4RFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142996; c=relaxed/simple;
	bh=kTDH5S4ysmo2sFaieTu2UjAmwNg8TwOXckYezAXHhh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZHaVoUkR5HeGxl3G+Hp5YsrgG3D9NUNA2QkPfXnjV/cK6kDWdvAxHp+iKaykHeZHk6QcH+sSRnfzxicB/1lxi8e5zxpabZoG9xiitp9Y59fYkgru7BqGn4Es+BcR2tkLGUWv5nvnyjDMHbCViJR2Hibxn0bDq4ZIq61HUkHniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=b3GviCnP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="b3GviCnP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso16645725e9.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785142993; x=1785747793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=edzEg2J/oLqzfs9TMR6atfH/lM7LkpfPbZs2uM8pJC4=;
        b=b3GviCnPq9i1aD7Y5y7bzKgg6il0W8m9XaPJQ4I12+i4aM5U6hRMuNxR65SpN7uUHQ
         PWnxjTKHglMT3cV+qGust9WX/AL2ARb8BKzITWhH8Vh121IvbLyE3dAKYnDNm9GGZ1pe
         6hJ5U102tnuCTKYGutx5K+IuXtT/NE+AL8XrT0tWppE8Z0LndTSrSPMSw3QrO5E3CDOH
         Ypzn5IVWR0x3oRtAyqN2N2ESOCYQH0oi8Ggm1mTvLI7vtBxBg0w2FqiCifuHZni5/e57
         BT227eFMxD0Uq4pu2DXaipPgvWnq23gJCyk2ERmhKXNtOcpYOSKuQyH6cK2zDOMIDjI+
         n0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785142993; x=1785747793;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edzEg2J/oLqzfs9TMR6atfH/lM7LkpfPbZs2uM8pJC4=;
        b=smYt2aZxwAa78zEzBgS5P+CgT1UrH+cq7Tq17yjN03AKoRcnEtO81q060d58LUC+bs
         Mvnuk2haTC74g2hUMh9Es/Ot15kIrBle5izvH0XMScARtSE6T6b1xGvcvcw6YJ38s8Cj
         d0Fwgv79OKkdwzyzwcF6uKuJMIHLRlEeBpJBJrfmeo9frCAEdtgsq2oHGPAqytc9wFyQ
         BFKBbHy6Rf33QEqd6QBO23Gm29DjoRPHTy0fKdGLY42DDBF87AQN7T3HngqWZm5yq0Mk
         fsiYcUdh83qr8P3xl0P9wAc6sgQyTG1yj9osDi8JMYahEg8q6laaZ97sRUfLHfaUQoL0
         rAEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmA646EKwOIOIhNOZ/VaYTd7v0unj6ZxAMIlT86+lxiw5r0Jz3SHflg+6DXVPyPHzQ0EYfQB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQtQpyuDkhvDsrSgn+uWErQBdkVHYjGLFv1ycaAlHON391Cn9
	qIz3aOLSJM9oF2tQYC9fK5rkAp6bSGmgcbpF/zGDi00dSu2HTaoL9jgkWrgOkMqlWRQ=
X-Gm-Gg: AR+sD13jLNLtWlF6Lt8Y9fm0iITuBRyJTIFoQbhRvu4wh6g0Dfq+mnhSd++CsCOmHcc
	oS9MVk5FFck5FvI3j3WFfDJawCuDxx2xmmTp7IFNIgBK9hthVDI2o/lP5zW7QIw+Nhvuky+17/t
	j9obzSpU6F2ADU9wrZGGn8OcIsYUucXe+4jVfE6XKEyYCzgBIMVgFV/RdklAsRvofM6p3ne74tG
	CDNv7Tkw/lhBUDlAbQ70xYDFo4mhn6e/Q3ET1/ZIC05rV+ZcvifFVy0y3BCHlX/fdd8g9PtmfzW
	dRjU2aJkrwX3zXdGt5/6b6isLLq/zIILKTeHFM/bvBugdxzfX+i9MCWHCnkWvCdmb5PsDNvVA28
	/WDqECsKP98UYFM9IaJpDqSCz7LnzoV5eRDgrL+xDMd1id5Z0rX8FaOYxxZtohPuTDZWPuU7fBQ
	==
X-Received: by 2002:a05:600c:3113:b0:493:c8f7:3631 with SMTP id 5b1f17b1804b1-496b570dacdmr90046155e9.22.1785142992910;
        Mon, 27 Jul 2026 02:03:12 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ed5f93sm333309535e9.1.2026.07.27.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:03:11 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:03:06 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	daniel@iogearbox.net, almasrymina@google.com, matttbe@kernel.org,
	skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 2/3] selftests/net: ncdevmem: add -b option
 to set rx-page-size on bind
Message-ID: <amceyvCsHb_B1-Of@penguin>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-2-7975f62cdfbb@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-tcpdm-large-niovs-v6-2-7975f62cdfbb@meta.com>

On Fri, Jul 24, 2026 at 02:21:16PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add -b <bytes> to request a non-default niov size via
> NETDEV_A_DMABUF_RX_PAGE_SIZE. When the value exceeds PAGE_SIZE,
> udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
> hugepage produces one naturally-aligned sg entry.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
