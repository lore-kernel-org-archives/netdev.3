Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953493EB0FA
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651405; cv=none; b=CpB0GZuW/tnSD5O3f5VzgWXPhCc3XGQN4c6AE8Ais0BWntpYye/7gjLpRWIjDtIEu94QMYr3Nx/wwJjcm+cWbD+tI8KFNLyJJQdIQ31YHoxkREPEKsJQ+3Y7fzcS0gOOdYRzNJzaS61XNh4Xhp3QWT6hmsVzYosyu2E/Rhmmn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651405; c=relaxed/simple;
	bh=/V06hOjEBqJ5VaajoDDmcKwxjFuqY4c6vD4MhLEdaGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF97TdBWP4MV17qLYwZLc9rExun4eSM3XUN8O2Bm13iXC8+Ftl30yNUXbB5XERWeeNhiqXutbPRxz8gEExegSxwLj6OALdtNrkIkjtz9dNDt4I2pHCRTzhVLlo205vNlxhjWKk2z4/51UCVDiJjE8pl55pv+5erXO0NYiN7pivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFpM1iqk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=erzyVfUR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFpM1iqk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="erzyVfUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787651402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tpyj8dIw3CBXmhU3ta0FkLHroDi4PulumPCufqq2tc=;
	b=VFpM1iqksANoZ+wCSekyf6uMC4GlQSeOFbPXzhVAVzRelvYye//rhBatkVdUNgFlqtTJOg
	tAKk6CNeOxS+JIjeJwpFZsZ8u59X6p2ePCYEJS/hzdQySDDLPW8nQhV9JwxleNQchlXqnq
	+4zSTwXee033tjsz2egx9K/JOCeNV+E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-4x6xiTimOJugEmF-7ljHkw-1; Tue, 25 Aug 2026 05:49:58 -0400
X-MC-Unique: 4x6xiTimOJugEmF-7ljHkw-1
X-Mimecast-MFC-AGG-ID: 4x6xiTimOJugEmF-7ljHkw_1787651397
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a3e6916a5eso2625069a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787651397; x=1788256197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+tpyj8dIw3CBXmhU3ta0FkLHroDi4PulumPCufqq2tc=;
        b=erzyVfURvGRooxhjR8kvpK8y0IDRkUVIGuCihAC6DS5jBwapXVu0Pho42LZBUetneN
         CSpvp3tVgnXxH6TzWWGjf1Ct/EpXncr83jGP/gTUyuwmj1WOnr4dVnxVTDgsqyWP7nQu
         AznOpfvKAVhYUlGOSM0p13IbxU2LK8eSw3XKhty497mOArV2amqF3GromzMjXs3Ktrmw
         p1DEeMKyVYgZxSDtyUGrshlAwBXd6QGRXENbtEj42yQYg2UvkvL/jabcK+doRnwmupGG
         ZKdSohLUisL2I6olZT3Zah3RVnkeRcn3RprHDzdD1jIjSHjsYH8qe6B0TfN6wj12fX2T
         IXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651397; x=1788256197;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tpyj8dIw3CBXmhU3ta0FkLHroDi4PulumPCufqq2tc=;
        b=k2xePbIqXft0P6O4kudEgrQI+rkYZsQm5bL3sLYSwAgSmHr4EpxIT4xnxRuCiiNp0Q
         biXSCR8vct9zey2cy+IHAaE4tEi3rKhkSTaNUS8/FJfTXIcfosrDb7JnGQQoX1vBXYst
         Bbqle220wsk03OnUixn+XEjo0IxGsZ4N+GvaTxJdYtMlnIJFriP+H773mUVoMSyQjVJX
         lsIu1Y9NNTJnjwXA9/jN1Gw7xbYHzKvjPr88bruRw0rrosxqvb3tmpvagET8frly0XFA
         qHRoXSdcKWJijTEuYba9jyMcEUuKoNlGH63WRV8gWXxoZF4oiOB202lxr2vyvQgnz8nv
         uX9A==
X-Forwarded-Encrypted: i=1; AHgh+RriFBip4an7Z/xXXPnVnr+yARW6svnYsVx+JABCnP7pWl/tL9ptjoNXI6xnPOzhRcMVODhVgE8=@vger.kernel.org
X-Gm-Message-State: AFuF++mGBMmyQwFkERxVQL8UO0UtTJaHrn+QfRHQoyKg8FgUc6z6XDbn
	NNbo85tpIzm85nsA2fztWpKAmi6DZV59+NxIMrUS1965Cs1i/UDqmwsyD+/B0Zf51aqB07LAYdv
	TsnEzjX3+f97CrjY/U5BLO6iyzfnTiLWr4cPs+VhydBfeSPIaS2hfPYJOcA==
X-Gm-Gg: AR+sD12FgLe+h6QDpkZ7OZ0d/wa5xh2brtidK+nPmckBoZBvLD/dheDr51Yvq0Ej0bF
	3iBgI2qJNUDkVPJbgV3YQfJO4jy1ZzCjJOxC/KX/Vi+xYN+qyzjpyGfHmOPcVNWR8LXqv3h+lah
	cUgZTaE2LQkwwPJZxufnQBfa6n4ihxWW+hHwQBfFymuMd67Mwm63jDifrLsye3zCyYHa4Ep2n+8
	dzT0fTQV/ezLOIri8o2c4eIJoO7HcbhmT2aDjJCN3FkMGtlTlhsInrIi6LzGB3tNqqL+hWYFgRC
	VqHpBOQdf88/LVxrzT3JG7co25iwT/+i4S03Y3SGA/Ez87XofhZWrxBRRY0kk50qhq4ZmsWx542
	mDxs8WRFS4K3wIM29gF4/dQv1uyFILN9No9Ip7KuUr3YtmLP7tslRQ+VDobkP5rLb3qGWJuNS
X-Received: by 2002:a05:6402:274a:b0:6a1:f95b:8cef with SMTP id 4fb4d7f45d1cf-6a582b1476emr29509922a12.4.1787651397245;
        Tue, 25 Aug 2026 02:49:57 -0700 (PDT)
X-Received: by 2002:a05:6402:274a:b0:6a1:f95b:8cef with SMTP id 4fb4d7f45d1cf-6a582b1476emr29509821a12.4.1787651396750;
        Tue, 25 Aug 2026 02:49:56 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00108asm19468925a12.2.2026.08.25.02.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:49:55 -0700 (PDT)
Message-ID: <fa099131-8ef8-4586-b9d2-b6ac287caca3@redhat.com>
Date: Tue, 25 Aug 2026 11:49:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Kyle Switch <kyle.switch@motor-comm.com>, Frank.Sae@motor-comm.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260824025625.2688693-1-kyle.switch@motor-comm.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260824025625.2688693-1-kyle.switch@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 4:56 AM, Kyle Switch wrote:
> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.
> It also adds a new exported phylib helper,genphy_c45_template_testmode(),
> plus two new definitions in the MDIO uAPI header.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


