Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238439BFF1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280587; cv=pass; b=Ex0Bagd8Dcy02B/I8wv8xTYilXrNmEH4Nll01VlezzyKaffw21Co9P+y0NtjhSDftDoE7Re5S2JiqFbc2cqoRlEKyNjWwoownVjPZmbmWBbXKdR0b8TdLwnI5Ed42zcMT3qRHs8yQ8gfebVfrhJ+97rmvApoYBM0FBD15cv/0wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280587; c=relaxed/simple;
	bh=Yz7JoaE6iquvpn6Unqqgb8gnd/A0MQ5SqMi49sUK7Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCBvaID+F8cFW99XU3rCr71lwNGqXMDL3/HlRgMCzs7om2YoOymwMO9wW9w/oYEJrsn+natD8tYIgD4GUs+6FWTvPjJGZScmVq8VaexuhZDxV4bfjhJem1aOo0jts9TVK81Zwgxjn6HFdDPz7RquJnPcc0h09+aH09dbSBl0mxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=CsmGZND0; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="CsmGZND0"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab50so104374c88.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790280569; cv=none;
        d=google.com; s=arc-20260327;
        b=qda9jGld5tDW7B0+3PSws0g1DnyaxVZn3CDRWy5xfVTV0lgR60eSRHiNLBVGIhegdF
         uoN7gC8fBLyCdXS//TvO47438ROdnminRXXk71zkGCCeRVc+YeYB7qfRx2Pr0QfaXxmZ
         7czsj72BESc7W2dT5UBRdg7WnyIhWt/8jD4/k07OJicPfB7UffbCb3lUunP41u1SgfXD
         d1b2VlTz5RzJk0LxR+kmEZwSX9F4KTYPQHJtTo2ORzr7KjYWFCI3bkvBJrPiJMp3gR07
         if9xNKOxdFS882EltPmcnnjNFIFJCkJBuFFVkgYzXwlQe4Qg9xle2secqxX21qy64w6Z
         o3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yz7JoaE6iquvpn6Unqqgb8gnd/A0MQ5SqMi49sUK7Zg=;
        fh=JaU+33gRGUclVpX+NsTFH+F0QFvgWpHy0c7cHW7ObCo=;
        b=IJlhz7hKwt2uvUgC1hZ5bca/ahxVGRmDR5UWumBotrE0GNs89DSSSinJcafcj2sofI
         ee68Qvrlqa9I+cNGb0KnZJlJTiR6l3IdGVZk4K4VqyaVRDrw63bHaixgPl+qbreJMSfD
         yNyDB17QYjEUq8MYAstkECXitRJGx/EhsI2VkICX4GIJI9dtJLr84efwi+4qbJYkrkYJ
         w9PU1vM/SL0WQXKpgZI2XAX6yWp1xNkcyfzqRu8e7mowV8Heb9oUXsgZFFBy0hNXPawo
         n3+YbF5h4ebbQ0Oda345YdWaX8Fno5zW7iRmp3UnDYbiT8y5JyySflWZfHFvzE/T0Grq
         Fx7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790280569; x=1790885369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yz7JoaE6iquvpn6Unqqgb8gnd/A0MQ5SqMi49sUK7Zg=;
        b=CsmGZND0PTP1Jx3EJ4ZBqzwG+Jsi3/5sVOUyjApydhdJekVPYnAM241dyHZiTzN1ul
         HBYls6tPNKlbrLwRuj2JX0jueuLlzMh74X2rTlXjsEP/IsuwLR8XWrkL6x6TqIwf0Emz
         8oaNvdZhYlnzsVo8RTPCwHss9/49IV+aMhGiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280569; x=1790885369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yz7JoaE6iquvpn6Unqqgb8gnd/A0MQ5SqMi49sUK7Zg=;
        b=zSiiWDVbXq0855EKxX/Ujo46Hj+aVI63JhTI/qsIJful8no/d5GYTkLc14oHdIGVT4
         6cJ6kPdS/1iNaxDwH1a4qHvubYi0YEEBMzLjPwPWSqIZoe5zVmYAdRx5rErPKIBzp1ew
         Z0CJobub2ZZtEpehCdWJQQG623Mp2Weaa3l+YLbUjHLwPtfarueuz+rmBxUWNbRT8UJZ
         DKnou2l7N0F7YPJYMMo3DF0vqn7C7V7XyMdHUVJy3zqrrETtFyjWrvofjv8v8BFhAO9H
         LBrJ0bxjetrknWuMyd3YX23UO5q6u6vhZNa3cyic3+9Ns/F2ZiNyHgGIDb5arKZZHY1N
         29Qg==
X-Forwarded-Encrypted: i=1; AKwUvByvAQvfOcuFzgK2orDzrlDHdvr7SZ7rKoI45+2vXpcCwWosVsxT8woiN2wLlHx45+ipwizaRuw=@vger.kernel.org
X-Gm-Message-State: AFuF++m80RBcB3G2y4ioSFPavIiMokvT7A9vqCsosHAqy/FOrPdba3Fp
	bMkIv882WcirIuiYLTec7twUK4nkPDufkbsxXgBGdmTwbo0NXWufJzTCabsEg7D1tUG72Ypzvb1
	VIJ770Ct/bZQZ8mbd3+rbLXkmPDDIcC8zzyFOxwxX
X-Gm-Gg: AYBFou0O1aUh9LEZRVjwjaq/7nA+u7yJW0KPe+QH7pd/1iVlGI30oV/ibq6KJ2Y9SBz
	iDVZdt3OqH2aPIwu6+B0GfaB7wweHZhOQgU8NWgB3nLv+lHvKDfg7GsA7suhPVFTVLVfZtXGTor
	hKtNu9ttoQk3whCS4as54x2Fh2lejw9FKawVCkWFXMaDq4bR2L1LIIfSoPCjzODwNShfzb6mdVW
	bBawoqiGzVKJ2fclEoV4zotV9TWGMRLbD+atSiQUGXBgL0ybzOwWeOgv1hZvnPALKS6BVRsOdDB
	kq86ODeoVjOWvEbhWrq03jUteN+ehgClWKyVNfo+DaqsdvruGXHGCJD9L9VX1/o5Zufg+DhSvqu
	ZVr8Gt2vp1UqgIeHV3E3pjTDsGaCKDYko/IuyBzmMZ0df1XfCk4fMmW3WXI72Kfx6e9iDcWZWRW
	3oaWqjDbOb5CZep8RgIEY0OBjTwed6lA==
X-Received: by 2002:a05:701b:21c8:b0:143:5c2a:e488 with SMTP id
 a92af1059eb24-14503f6e17amr2557112c88.0.1790280568819; Thu, 24 Sep 2026
 13:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-K1TH.v1.20260922072206@mojatatu.com.2> <20260924103222.239e3d45@kernel.org>
In-Reply-To: <20260924103222.239e3d45@kernel.org>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Thu, 24 Sep 2026 16:09:16 -0400
X-Gm-Features: AclHuK8ging8rJ9iMqohghr3xW3SMPxgAhfGgpncxPI1dVhA27YT_H20sVXYQKs
Message-ID: <CAAFAkD8goF-B2qP41roK8OipD7TRzZfVEdFDPxHddB5Tm6VhCQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: tc-testing: add duplicate action
 delete batch test
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	hybris <hybris@mojatatu.ai>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 1:32=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yielding
Back-end Review & Insight System <hybris@mojatatu.com> wrote:
>
> On Tue, 22 Sep 2026 12:33:59 -0400 Jamal Hadi Salim wrote:
> > Subject: [PATCH net 2/2] selftests: tc-testing: add duplicate action de=
lete batch test
>
> ah, here's the 2/2 patch. Patchwork did not figure it out either :(

repost? (2/2 was stuck on some ether).

cheers,
jamal
