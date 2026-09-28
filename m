Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530203B0AE4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597914; cv=pass; b=rDhsVCaVxvjZBpI9+0WSa7GLe1NF9HoTZHZt/M7NsZAs/8WfIl5nKBV8+T6KbLh/rQZSEnSF4Vcp3q5bo9nTLaZeiyMmOewWndI9gEyxNO5gmHQLUcC7j9dilS5qOHCtn+7zKdJfbhSGOB6p9oqzMnXp5lTbNPFVZOz+EZLTVcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597914; c=relaxed/simple;
	bh=V6HjbSIA0+Y2ZwCyDnLN+EEAB1LmUxOqge9wnemkGrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9761+Pt/lKjUYDPSIZkmq2WmIGLUszg+8FhOVDkDQbm4G6evKLr1whyf/zIhRCnoh0WIfod+2LZdvL1bgNOXeaZE7rtu+zJE46ks2udC0DJsqy2wsoIebfv+Y5eec6V6M+4dhO0ILZ6ZeLxuI/kGStm0l2RclEQi6x2uyv2vso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggDTCvMc; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggDTCvMc"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64d20990fso26875391fa.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597907; cv=none;
        d=google.com; s=arc-20260327;
        b=KhjZqWaZucwCjR2mEkWbxnsqD1Zh+Pmv60WqvDiQrnfYJ+k5aIySWrvYSW8Yha9IdA
         qjkKRz3mqqLdcnFsnmgyNDhMjB55lKmoslDoUXOnl5id4XWCx24UdJmqe++6VSoErLfL
         AO30fXDb04k2O+Hle1D3s9NX6b6qDbqKREW1mfJATKqrePt/IWmXdPpNjLxUM74IxGKK
         QAUI1xgN1MlJrLm1QYrDa6SRrb9feTml+6yuWA61w+H+t7rLYeX3D1YehKMVDU2QyPdd
         s1ZkBryrGX1Mb/ss5882OoTO7Luyq74ylvbtkEtGU7vsJ3wObX3N2PEyY4Wg88ibLYMF
         Z3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V6HjbSIA0+Y2ZwCyDnLN+EEAB1LmUxOqge9wnemkGrc=;
        fh=lATW28XanKjbLrsJ5l9hJdY/1ch8aQqFWRdldTFW5Ds=;
        b=ra3mdfZ0LgGfxXWYvXSjbJImSOOXnImyl4dSyX3znqq98raBfJNCY6tefoUrg2Fee/
         YpPDWNemKXT6jfMrRzHg6zVQ157/XCmy2afyrEan+R/cOBIQePbw5yGuJlX7W8Gqoz82
         cst6XEJPHvNYfI9TDRNwxsje1WBQKz4Ub6jE4piB4Ag+DSmC0BuoO5jhLylQgcbDDwym
         fH9drXxf7erGrJD/vCc2qx/utf/8K18RavyDaB/3tV8e9Fe1ZFsj7aHL/WjMkuN3biE2
         kG1qNyn/rqYsaa0vSSVgpMeAnyqsn1s0swl1YQ0+oTD3ZnaLIO9ZucHNFTrX9YVNEbQ3
         qnWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597907; x=1791202707; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6HjbSIA0+Y2ZwCyDnLN+EEAB1LmUxOqge9wnemkGrc=;
        b=ggDTCvMc87teue6kRgDl/HJL1j2olytfImFBsoanEZjkyKpv6D+/vJSmVsyFunRY3F
         s0KclcbvSlL9kYWOXJsTIL44QmD9JH9hUSSau2gNe+t/qCFLLz9HFWeC5AHAX+/74viY
         tjFf5WaqQx0F5Bab07+aXXojP97hOSAUKojgjm9NU9U/Dis7+8nd0j55WrmqMmsV6YlL
         Ichv+aYxbd+E7EAJhiU0S1so5GsGby9p7GD7Pp5sdBGgnajjYvvN9oikQzkuPJb2UDpL
         Eg5NXbBWk0mkXr6eXC7a+3W3suzeI+zAo80K1E3g5SMrXWiXlQZO68/ENDjNC0sVPbij
         uvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597907; x=1791202707;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V6HjbSIA0+Y2ZwCyDnLN+EEAB1LmUxOqge9wnemkGrc=;
        b=mQs/KNIGM68IbQHGQh+VquPiEMM0QFpgI64FePXkhU9hBg7cLNnMZUl6OGRn9qzukj
         wcHuPnaBfn1mMpYPgVekxwPn2EusNJIKYKGtD+1CkJC54cQw8Sawu1XZ+oCpYyiRP078
         FBO7k6RF3BZ9+V80mfmeK6riL1buQzYoerRdnYos+wlIeWYXdKrb/YmJx/UryPLTtQh+
         dwPqW+UTA6NBrFB8bAeJnqqyP01ihzTOegbVcTIp7Bd2qszYMjKCHMm6G8IH24tPquT8
         LyIftSHPLLZ5huqgsslUHsc1xHrW17HKfaRdTiFN0RqQdYcNq0cQfyPCl6c35o4LcAeU
         OUkw==
X-Forwarded-Encrypted: i=1; AKwUvBwXa/zoBQC5RRwTE/mWyKwyvNG/j00iTJSzdg9fHtd01iSsdFnFPxTLzcm3ttbcBtgxuS+ZXRg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQAnqJx6pgPdOO1LGGFgMNbseq9h7ykv3vkwh2Ch/dUAkXgc1T
	RHOGjs6DDS77v+s6ndIEa0AQrTrzbxWjNDOSnMBaZpmu+7w5tJbP9H9T0l3VoHr+jms7oVzG9iS
	cNCpr9ZH42k/BuOIb8mTuEKftTKxjGjQ=
X-Gm-Gg: AYBFou2NFmlyTSOc+03NhaPdHHiqMEiTQPAdPwwLJRaaVVnasqKn6ah62Y6S0gCtp28
	HrGAedtvZMUiaDnPXaaSau742Hknw/PeT9TY6InBGO2jtbSauSfbJ/+GDYrzEk3j30kZfUKQxzt
	9514HAoSWLRDQEI3DjZKrKqqEOGg8H+MMli91tSQw6G92gFZ9+Ji0sf9c5wumPpSNk3P09/4MAA
	XOqIyrqw3IE8IU3idMiAic7XOvXvwMOH9YTqFxTz5lg6ydgHgIEk2dfCAaAkWlan5rfJFNVMhSx
	DfQEdBkud1SxVbIy/QeyB6e7EhNzaNXFsL//IHpx3KKDl7AIi1EcUuVWEAIlV4h+0yvWRwrca7F
	a1krd1SMWPZ4Ldr9IIL9MBWRG826LHQOQOxGzzbb2DA==
X-Received: by 2002:a05:651c:509:b0:3a1:51e6:fe5c with SMTP id
 38308e7fff4ca-3a63de1882fmr28825211fa.13.1790597906996; Mon, 28 Sep 2026
 05:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924011554.3494-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260924011554.3494-1-sigefriedhyy@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Mon, 28 Sep 2026 21:18:20 +0900
X-Gm-Features: AclHuK_Bo0nUb_h1v37TnseownwCulJ_aL1hcoodmB-NEy2KT06jfSsRCrSTQ4U
Message-ID: <CA+7S2vKCxcQMA_7E3iHMm79v_mz=z-eERZHzTquo9-HJqZQiuA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] rtnetlink: dump link-layer multicast addresses
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko's comments for v7 arrived late:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924011554.3494-1-sigefriedhyy%40gmail.com

I went through all of them. The only one I will take is the spec doc
wording in patch 4: the ifa-index filter and the zero header fields
are unconditional for AF_PACKET only, AF_INET and AF_INET6 apply them
with NETLINK_GET_STRICT_CHK. I will fix that in v9.

The others are either pre-existing, already discussed in earlier
versions, or not an issue.
