Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124C40F739
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291406; cv=none; b=ad7RYocpaaQpWfaZCZLbuU75uCdVihb71wNlgxVIKLSEA0XhWXPUPUH019EOPYgR3MzxpbjG5H+LOb7OArW62e3SuLRcpwXByJRUVlnunO+Jw2JTGF0e5lITTr5uMPM5bO42a+Bhw5Pi2kQzABgCU7ejfMQB17OzTlkVXUjwDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291406; c=relaxed/simple;
	bh=kHC2Xdh5JCbAecjkoX2Gwca+4TSdKE01ODm/DBNE7w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvgPhwwVLNDr/Awqp+dq86voheHxzACQcYeHJIuK1FhE3jdYGJlC0T7KbYcUE/e3YuSaQ40dYPhkqdXXqaTY+VSaf6l3ahPqpHlszqo6EIbpX5zvlas5J84PQowZONSDa0xBlt8v+7oSJG4rRdSZyOHJyh10LgyfMvqKVLWhzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5XXN7eb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5XXN7eb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso4934285ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787291404; x=1787896204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EI8ItGluMH8AITavEdNDRQiSjM/o1uNkJ767ug3KvQ0=;
        b=I5XXN7ebEW0FLk3Cw0hX3T5CHYUNVfIb4o4BIISb9zFSrxN5h/DyobpBKnEKTec/yr
         feYZDXhvM06ZeerWNWvVFLVcblibzky1FbSYMC94V+Q0ws61eTN55o1YUfc+pgVaLj/2
         T7vIwUdbxT1fRHoMhLDfvIBVWSlcsNMKZrSyEAu7GEQkZhJ+U3pLwudzRo/I0YsWop5j
         xn5HGAdk+/b9v6NHPpVWbDtNe1Ya8Zss0jM1tec84W31se7UNDHNRjpbO/zMVzxvAHAE
         mRrvDmHGUeMsflKiwQTmV9bY1p8KfAxyljrJydAqyR5zZLtwkJx3fxv1p8X8k3MADpXE
         K+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787291404; x=1787896204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EI8ItGluMH8AITavEdNDRQiSjM/o1uNkJ767ug3KvQ0=;
        b=Rgzz1aSUEYGXiaevN9HtRnHlIJpkTJcsKio20Tb+eNAd9bglfXoDqatmzGtFgb+ir8
         d6P4nyvCc/WOZKgZ82hARYp58kV238wwBTK6T1Zj/Za3GhDS+kq8Jfo/wzqMNtMnWdLs
         vxOAFOT1c+9crdGUOzDZZlyaOuolazHco1bI1o6x4hp1ZLh+n+Xpd//KDRkq9XB6VS5s
         5U5/GYeCo7WuBmkDeAl8ni1ysZbMwEHSD8xVgydkTdXS1/f9koqcBgo2cquh1VnGmgDc
         /leQCr/wi2lprHUCuiIbDfhkJtgb6n8tkWoqMC4H8m+Ulbxd/h9Z57kUuAg84fosPkKd
         g6rQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSQzT32D1rDB8Ed+f9t/e4IG68f1V8fSw5Rd3piiOxKtPmC3CEvSfFjIUp9zCrqVXmSrcgjJk=@vger.kernel.org
X-Gm-Message-State: AFuF++k7twpGaKtNDODCvXEQPmYfYtg1HjWZ7awJvL65gYSOA+486btg
	NT3d5oHrc0HT1NYt9PRizlbRTpyRhWpv4KD6r7+tlZ/Mnqfyr/lpKBvYP33fGpmcKPI=
X-Gm-Gg: AR+sD10LGXZFXU688JAG4/zr7pjh/ckWQqrk4Glnh+txAn6u9QwuEbgH1SSg+JjgxxC
	2ufvvqnw5O3DZJc0ULOGt41n8rkXShcIQVpUlsESJns9h6sXjQ5RdodxZSQf5nZjbvjhD1JwM2p
	KutFBLRnWwMU361i539bN/bNJAyCM0dOMWuti/46T40YhVmmoOeF7WBZ5aV9TC5We2BAuyxRI53
	l1yo6UdogzNyig2kP1l4E4lrwHsOm1v2mPZK9rW4M015qpSF/BfvwgYIYro7zgxFny4tSfuc/VO
	0WCNwqyTFSMyXgzwfL+2BvWWFa4I4Ky5dya9d8oNAvwCIKmz7aJzugcPzditW7xwSJAkzWzls90
	MYovjAHDbLNd3cI/rqXEIhL/mXJu4p7ZpW577cJ902VzvFqnkzexZ0qC8k1xT8GzTAtLOxUe6yF
	bZ3VfMGAUSOrEYQzjrloV83m0ho+7a/+ZmJP7aINdjXaI9oHEwy7VvyyNuaWpNWyiwVpFe3m2/1
	I1vd50da/IQDaDWmYlW5HVSbW7wpsFPfw==
X-Received: by 2002:a17:90b:224f:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-395c354d445mr6625847a91.2.1787291404298;
        Thu, 20 Aug 2026 22:50:04 -0700 (PDT)
Received: from Ellen ([114.8.222.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c18fa7sm1817538a91.14.2026.08.20.22.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:50:03 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:49:58 +0700
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ynl: allow u8 sub-type for indexed array
Message-ID: <aofnBqguz-1A-oNF@Ellen>
References: <20260820110904.28645-1-hilalrahmatullah11@gmail.com>
 <20260820110042.0f12ac26@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820110042.0f12ac26@kernel.org>

On Thu, Aug 20, 2026 at 11:00:42AM -0700, Jakub Kicinski wrote:
> On Thu, 20 Aug 2026 18:09:03 +0700 Hilal Rahmatullah wrote:
> > add u8 as supported subtype for indexed array, this is required
> > for attribute NL80211_STA_INFO_CHAIN_SIGNAL serialization.
> 
> Could you please send this as part of a series which adds that field?
> Otherwise it's a bit hard to review

Surely! I'll work on it
