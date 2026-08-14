Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCA46EF97
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711023; cv=none; b=seH+1fza7sSidjBm3P2Grx26QSHwG7q2qilGa964zj4VQdxrLMRBgLT6PWO1RYCnUfmUQDCI5GGPDm+Z3cDcFoz1PVTvrnxgnxAjG/k+ZHPe9osUH5ptMN09jD02cETope+VMND8K7Z9ItcBIzA3e49uGJGOoyHS4E+ZIMZC9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711023; c=relaxed/simple;
	bh=zbCPmLSYPzSecacm2kZhMaPNfy6mLvOWBvNzT7UcJyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJclBd5l2FoEyCfhDg9/331sVnaOeJi3I6drkLngb5YgEwnb2XOFjOZkdiabblKJeERxwWtNjFhi0nHV2wdROls4kyyHVo4WTu65GIQ+3s5I529OVcHpqWdm4+/pltOIreUfzH7OUJGzrM4EXUpH9GANPleMUqwL1KXfP8m6tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=n6f9/T+0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="n6f9/T+0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso26267085ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1786711016; x=1787315816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CjBGjaEFFchL1KWOeP5fpFy0zzjwwZigEt2JZsjGGs=;
        b=n6f9/T+0RXh/7a3fr0yU7FYRHFHgAuxhGnbo8w0KcTB039sW7VuMEYMPZTghao4HDz
         1SjHHJsvIPUHJisNgZC/ztmRmNSvNgXXtbNpfnCjfXY9P5Ed04QnTA80U4yvJCnAIu7E
         D6stMa40wVAonLTvxJNxHK5Xx06A5KmNzpCK+rPFISRnsOD8XrFSjOal4qtwu1ElKrUw
         K7tAkYeojbEbDKrCu6t5DL/Ido+1VODPfSEMqXawo8XIT5ZSQEcGz/HVMS2l00yfwGWz
         dQRo7I1ovXzxuQF1pAi57V6XgrEoXe5DbAbt3Z6KUi5EtTXQRY/BeIGwxf28Kuv+jMb3
         s57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711016; x=1787315816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CjBGjaEFFchL1KWOeP5fpFy0zzjwwZigEt2JZsjGGs=;
        b=oDatjgpZp7xWJ2GU9yHeq+8lbJbEF+HL40hgCmFrHMMMGEuNgTXPKjYuxh8nTB9e4g
         JK62tb7Ds9dH63eWJclj6UITma6EM01Gh0A421aa2zEP7R/sAsqCGWaABHIAz4C9aPBn
         OM/RsigMFTQrYaGV3micK2UbJa0H26XlmVcinO2TWT48+K4XD177nZTSUrHTfjEJij9a
         fMUuuMSWFLf5PyQ8w6WslzNDeGhc/t+KGMQaifygW/kdE3nmcLHAr8qs69yBKBhSJq+A
         dPGV+fdzZvIFog9ZOB4CN+9JjmoYwrg8IZDlztpPbEYxYqlX1e4hjaiGG5XdrfzG9tJX
         JsMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlJl50BW6vcoCEqxwkDnhN72NajriZfC6KfjZg7q0YHIjY6NRU2OXPtECFpM7EBLE1Qltesf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1NvlMgW+MC6FzKsiQnP2Gs6kl5XXWI/C0Jmi/ud3+g2XIwP6
	dgonGX+Zqs/wA4WUK2d7Q4i3eAlIVxTV//3w4uw+8W+MvZvKPAin0h7TEJDNR18NBsYhf4mGSfX
	i2GWnYFey2rfqpLK2Atr7k9w6FkcjMKnPtx98HM6yW1t6VSGNz8fnMVDWVvVvClQYVgQgI9QszI
	0=
X-Gm-Gg: AR+sD13da2I7xoQy91+efP4hhan47rzsspKb7I47xVxNjeI3tcqIv9JfySe6Ejiogq0
	tsj7i9wcAsPJe28KEwIJ3gCapSztKzvgRKlf6tAuit7ZY3Ak4iQPJiAF/yekbmQcULDK9kkjp1M
	IHVQSxnTxilh+IZz1PJW04KrkonXWoSU22+JmxmofRnFf71wsYfAXc7XTBckfqkBAfzNKT4Tr3P
	CYilQxX55ZIl1QfRclJxnA5M15ShCeHxqKj/DDsOwF4upTpXOOKyRtMI060n+g9cK9V4lgK+ycl
	iMmdRL1IwlfJ9Iy6cbxIio5Wp8ENVmk47R2MtJ0haObOkSYfP6QRq2TliMloa3msMfX6KN8OxrS
	lKfZtEYRbeyZEYOqeEyG6wN4FD7lUg1fawrRmNBfMaXERbfFwqfUVNPjNLAmiGjt5Q6W94L5mqk
	EXx7D2ahwNA0dmrI3TyVyDeCNIv5ApadOQPFFJq0qT5jDj6E4BmUIr/hO/kXMEaNGH1BYielFMc
	g==
X-Received: by 2002:a17:902:db03:b0:2d3:c3b:c7cc with SMTP id d9443c01a7336-2d37f5d0f8fmr136484435ad.3.1786711015671;
        Fri, 14 Aug 2026 05:36:55 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5ff42b7sm4827969eec.7.2026.08.14.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:36:55 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	keyong.sun@smartx.com,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] openvswitch: enable ops lock for internal ports
Date: Fri, 14 Aug 2026 20:36:39 +0800
Message-ID: <20260814123639.3815307-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9f1d9db6-a39d-4c3b-aa94-9a70e979ce71@ovn.org>
References: <20260812123003.3634034-1-wang.zhan@smartx.com> <20260812164156.6bde8f4e@kernel.org> <20260813074007.3669651-1-wang.zhan@smartx.com> <9f1d9db6-a39d-4c3b-aa94-9a70e979ce71@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 19:55:27 +0200 Ilya Maximets wrote:
> I'd say this is more indicative of the issues in other places, like mlx5
> driver.  IIRC, it can call synchronize_net under rtnl many times in a row
> causing any other application that needs rtnl to stall.  We've seen this
> behavior blocking OVS in ovn-kubernetes setups many times in the past few
> years and it needs to be addressed in the driver.
>
> While we could avoid rtnl here, it won't save us in other operations that
> do require rtnl.

Right. As Jakub pointed out, mlx5 slowness was one of the reasons for
introducing unlocked ethtool operations. However, netdev sysfs operations
can still invoke driver callbacks while holding RTNL on current upstream,
so contention from slow callbacks has not been fully removed. I agree that
long RTNL holds should ultimately be addressed at their source.

> This doesn't sound right.  netdev_linux_set_ol() is only called if userspace
> TSO is enabled, and that doesn't make much sense for the kernel datapath.
> But also, userspace datapath doesn't create internal type devices, it creates
> tap devices instead.  So, it doesn't look like a real use case, unless I'm
> missing something.

userspace-tso-enable is a global setting. Kernel and userspace datapaths
can coexist in the same ovs-vswitchd. In this setup, enabling it for the
userspace datapath also causes netdev_linux_construct() to probe ports
belonging to the kernel datapath, including internal ports. This is what
the current code does and is the path we observed.

As a side note, perhaps this probing should be limited to ports used by
the userspace datapath?

> All in all, the change itself may be fine, but I'm not sure it actually helps
> with anything in a grand scheme of things.

I agree that it is not the primary fix for long RTNL holds. I had treated
this as a straightforward conversion to per-netdev ops locking. If this
conversion is not considered worthwhile on its own, I'm fine with dropping
the patch.
