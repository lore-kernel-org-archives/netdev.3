Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D204A3D28
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265220; cv=none; b=hcPxGf8UwAshVwXE0oNOEasnmI+oqVGisJxxGcKvwHVQLR/zYmtuw/CHpXwPKlnrojjPziqwhANSnWZvbp6HDKzpO8g6o9yhrXnt5ghdaMiNfz2ww5WA41i26l6jjqsG31WwIZTU0ZzfYJoDPlgmFJnNC3k8KLe7K29DetUCpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265220; c=relaxed/simple;
	bh=8VgmXckMQ331yIs4PXkVQaEHD3DrdlRoE+mdYQ7euGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3VH5gCJKiNZnOXHdZ27+k/AgQR27Cdah0zJWWxBb/vfn2/0rZUJdhgGLyBAVk80Awoz2psDubsYVlLXUABoWBIVeWQEcLSEvcTpOUazhKyx51QmVmXcAc4HbotdYGaY4WbMAtO11dp5lJQ0NlrCl8jRSgTttTrcb4bMO2k/mRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2IQdTei; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2IQdTei"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso498886a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265218; x=1790870018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QggfrTboxxrg20hN00zR5F9PqHatXU0SzQLE4m57RkY=;
        b=A2IQdTei535IFgS4hBEnl7TFlcicwM14IUQZGxRSZnVHMJ8y5JKphUbdpjJbcw0kcr
         rkb0IfG8/NUi+jDlLxgOyQPDujBjgYoNcxr/y8iVzBXbITX1NNh3V6TejpjXnJQYgw6N
         6XPWJxuvDfiYNdA0jsJZqGUqQnc4gYWUivxQn3at4kDZe86jp30KEF8bLXLlhRSP2SvT
         BPhhacARLmQWHW1zetjqgmSnKU7YvGq0ZOU2zZr0ta4dEt8MQoa7xKiMypXenQUu+Ef1
         3HlaZmd2MORQLvKX8u0HJT5LyU3Df1/+rsxq9ava3X+j24Gsl5EwHatqiDIB124oxQHO
         sbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265218; x=1790870018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QggfrTboxxrg20hN00zR5F9PqHatXU0SzQLE4m57RkY=;
        b=P63gCIU3suZEegAnLRCpaoZOsa9sITuyieuiheQNOjgWvFi3j7O619lLlTUlGYboWM
         qMkyLqjaEH8idGqH6jNC5Y6oUvPwj+nK2elgUMwbmGka2NCBMjh1wp3VkK3EI/Yu408M
         oGlag6YSP1em95nd26qDfDCXYROzSLiD4gjxWlK9mC/OfX7Fg9u//etyjLCnYkfndQZ6
         X1Ld3Tjbl8U/C374thvjq0bKoCogQfiYDBVPE/zJIGVfEyMbRJrx9vdL8dwysbNV0P8G
         OhSdVP2SaXZ3R0EbTV9FN8LHXbrlWQcCRQuVRtBHZLIenqzCBX6CwKWeydovN7FnMGJD
         lW+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzg7XC+Sba96UtvxvpvGutGRZO02TvCXn/ozqAoeKO/pD+BMgdp02Vt3FS35sU3UvKiY1sdWkg=@vger.kernel.org
X-Gm-Message-State: AFuF++l9zROPFbH62PVaqNjg/ctUyiGHTgio0BvNo/MPzZ6G8RFZRhaw
	FC0du+uaKuN13GKiurWG7LrrBrPd8htQ0t6Ph8glAkJ5o/3+DGDvPIIc
X-Gm-Gg: AYBFou1l5LyZd/HSUOJanLaUpnD02oouta9oEVtAkh3dz6jDlJ3rpYQ0/VFC32VX+If
	xJexlxnPUyWAcCFdp0EG9s6v7x9rgQQdcszhW59gBdujSAUSQ63J7TKq8Jos/2t8C1rC6RQU+HB
	B9aI5tjwVDe8nr0axObhwQrlM/vKl0/83pKYFyuSn1Rk/ZP/JVErrnO2bARiI4+gaNeqnfNwRsf
	kFFrsqqSjDY+kxXpg8f51taEyIkijsxuWrMgwZGKGYuKvWztocFBDrSVFcpBS3HGaOt4lCz9ke5
	FELknnQlYESAkG8Ktc+B13aeqIQ33YMXBuqKzNlFrwjUGJx75bwAPnd8x6eQJIsPdohfWj+WZsb
	0HdO3uTCnurkAQb7F4a25WIcvPMgXMMxEWHwtXPEPDo5GL15vl6hwK4ft9IDmrvngTqKrnnmbh1
	0XGuCuRW0EByDn+rJsFyV/POnMmTxq+fUXLin2wDhsSnTKzekHjGKfY96J9QF4dG/+
X-Received: by 2002:a05:6a20:430f:b0:3d3:ae40:51e8 with SMTP id adf61e73a8af0-3de0e762846mr3018790637.28.1790265218520;
        Thu, 24 Sep 2026 08:53:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f406238sm2956438a12.26.2026.09.24.08.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:53:37 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:53:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: add test for netdev
 instance lock ordering on unregister
Message-ID: <arVHYddvTQziO_Ws@devvm7509.cco0.facebook.com>
References: <20260923223545.3815583-1-kuba@kernel.org>
 <20260923223545.3815583-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923223545.3815583-2-kuba@kernel.org>

On 09/23, Jakub Kicinski wrote:
> Dismantle two netns holding a dummy and a netkit pair registered in
> opposite order. unregister_netdevice_many_notify() takes the instance
> locks of all the devices at once, nesting the two kinds of devices one
> way for the first netns and the other way for the second. With lockdep
> enabled this used to trigger a circular locking report.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
