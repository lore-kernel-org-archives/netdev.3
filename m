Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636E3F5BC7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682729; cv=pass; b=DxXKwoa02/+NDgKAxj/JR+PWpbcfvnOz1Jd8KNPmfvUJEqOHORcjkDECQttv6ehiBtlMV9bCOoLMYF/1/PiA1G4PE9n8/WMLPfTNxbtp52eBHl2MPG/b2tvFJYVBQT07IFWJJiUXvFvHtaH9RSimd+A4BfTDlFToiPy1EYG8njM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682729; c=relaxed/simple;
	bh=M/G3T9rnVSPx6HC6z/zLA2iuwCt7IDG5Tz2AaPMOYdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cua4USOzLqMEXdH7wqhUOpOYzWXZkAO/FImhQEhtqZNPqx+7TxBaH7x9F4q7nLQOSOI8Xi+NOh73nKjaUHYHtEfCyOauf7Rr/x2wbgyoRzoveteUC6XWilVOCvRrGMBcU2z/4XOlCHn3hiSy8N4jfB/DL8Xr+ISWMk/l9egN+7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9lem2jR; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9lem2jR"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c9ff1cso8150785a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789682727; cv=none;
        d=google.com; s=arc-20260327;
        b=NNinV5bpCw+ZNY3cSLjgS27l3ioJxrZT73sVt7kqDRGaNkZW82XGwEFUeNAa7hPuRV
         Tu3MiB2DGr8q6PWNpXCsSxlv7IoJrzUunWxpfOch8wq7YY7yfzUo5R0N5S1qWrdtjxYk
         XRcm/Z/erDpUPIHOmgbBdsC/54l2rXGzc0Rfhlzj15tIQ5Y2oHvUIPjgHY3LjUbVP9rT
         JSV4l5GXYa4y2gYEt1HXmWQwYzqnqjWkitUaVmQUOn+UOyDQKzx4q/5UAr0TKnD7Qn+r
         dZCz7Mp/5l1ySZkzDhdyug294g+y3tA/7Gm3TwjvAyrJdUbx5jcZPh3CXTu0cSB7aS3c
         P1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L1caQE/GddzF2POA3lrIPiiJqtABGBhiQ4joZPVEJNQ=;
        fh=RwVhDxjvyk2001G5fwk0z+snjopFhFTf3NhChk8ifuc=;
        b=B/ts9QnNFpNCZhIOaL7r/ZrBNSqzLnq81tOpWDE+p/ufO6TtRkKKivV9H/3z286i04
         kPjG8i3X4jx+c87uylVcke3nsBnmItdxMFBYUBowU5UG7o5nMRR6v6j3VvtkvI+Jf3Zo
         vObqRdr2evM0c36dVpbgpg7zGHflRga1geeDlw0Qxy7vIsOy9XakMNLZ211yk98qNiVO
         IVPSqlTbtZh804nF0aVv1r/zI2ZTliJ4PGNOFnXY9uGsAI4fGTCd23SxuSSXxGVVqfvy
         We5FlUQDRlyfyy9Qfm3i+RXuM1Ge9oX7rRYPaeScXq/G4+z8hVxlmyl57QQfvxea0d2M
         ltXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682727; x=1790287527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1caQE/GddzF2POA3lrIPiiJqtABGBhiQ4joZPVEJNQ=;
        b=b9lem2jRBN4Tl59NqLjmFeqGQjdFcSzfQT0Q8pJLGSeQCHkRUpgQnbbxcBJSYfqQOX
         cA7DcfIeQgPDn9h7Tg8N9SNygCESvEYudPAneU1AlZ/mEgWnWCthSPnu6TpNvP8kOFhn
         lbPSHDJ7b9S+dzzaFTAKrGroKc9nX7+EjtwxPQ/SikVu5BRl8NzYnexT7lv3Y4+JX4oX
         RQf3wRQU01CY5iezwrSS/pgRDOLWncWkv8kiceTf/iZRUDW+GMXE7PAWe+qhNGA7o3V9
         WrwF4WM+OXPsDWmoQhjweTCUZqc/ykeTrSjdo4MES0SMvU0KpjF4IuwlCnNWlMVVh5aF
         k90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682727; x=1790287527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L1caQE/GddzF2POA3lrIPiiJqtABGBhiQ4joZPVEJNQ=;
        b=0zfov9UhB+ZHtFkkW8zv8Z8GflrFRM37OB6yFS+YwwwC2RzuLq9ed939bU76m5aqLm
         IztyKHmbU8tJULoXh9nBObgNl5OLBORr+lvMmqM7xvEghODIkp7/JsP/Aj1tU/99JEtk
         mmcHxuLaFFlwkSlajgiOOiDQgIK4V5QN+Ggtvws1odIDWjaZo/+tHv0aVcDgCpkZTFKJ
         YCL9Kan35+BK34Rc3x8w5u+wlqUcTHUbm9o6b6rd1nGbaXrv2Ic3te3QBILq9kag9gC1
         LxMO2LxPrJMNXXqa3YivSKgd+Z8OTjrPtTttOIdHnZyhUpaUKSQECjXFoU1eyfsi0vdN
         tZiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrZJmx02ZydJghhz7YlhwvXVQe1DRTyPjh5YNTLR1o2fQRfLzaJsL81PnfO0Lf+oY6CBYNAvg=@vger.kernel.org
X-Gm-Message-State: AFuF++l1kJJG9/lw65B6k/8vXGAPa5lD7Jz25mUi/L6PnRyrRvTVK5cl
	JrcLXxm8qzwp+yUwYElcx29qf+7mQnnLYTDyUfQm46wL005TRchlqzSG57ufUc5fogaxW25P5VV
	WToEVUlUUGdIyqCHzOIu/QTqwmrezO/0=
X-Gm-Gg: AYBFou2y1qPDC/8nlk/pkIE+vhGG1hZ5uT92cRg795DWzaCyJUMDNHUpRCOZnhthryi
	RGrNmZmZPTUXYx8ppkGH/egIUFKAGFVrLD+XXBeCWS4poBbpJmY64k64zYd2FA55J2NDPrwcMqN
	37ta9lYbqawidig/lSCM0/hb4zLlXLPs8cOBOas+5qpS6sa+Lpxe+6tH9VNt0lpfKL0KmRAsRuv
	CYHum9mf1pHj57uCc8EmiD0emOIcS4iD4oiUVcpvjN+TB7wk/WBN8Q7dQk+Wru5J/8yREhGH8Jo
	m4kFt6F44ANajn3/p1u7uyKbpPiA9coqIBfXErjgZXvbCo6ob4AeWZOpDzoCw0Wbu3Jw6KBURhK
	dmk3E5xGt96CQww==
X-Received: by 2002:a05:620a:1a03:b0:93b:d7ed:ff66 with SMTP id
 af79cd13be357-93bdc8b4b75mr58597785a.58.1789682726891; Thu, 17 Sep 2026
 15:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-ynl-robustness-v2-1-c6125003b21e@gmail.com> <m2ecesp96s.fsf@gmail.com>
In-Reply-To: <m2ecesp96s.fsf@gmail.com>
From: tmbates12 <tmbates12@gmail.com>
Date: Thu, 17 Sep 2026 18:05:14 -0400
X-Gm-Features: AcwNN1UTcZtpgBWu-l9JcuTibvJTD2u0xKrtDq6SchAt3r9hDKLxzygEQyk7zds
Message-ID: <CAC4WM+xhyTLcRMvrW-=Zmu0+=5dFpoZn7-oye7qcVPuk_2GvaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netlink: specs: fix duplicate if/then keys in
 netlink-raw schema
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sep 2026 09:35:07 +0100, Donald Hunter wrote:
> Good catch. We have a lint check on the specs but not the schemas. Maybe
> need to add that.

Agreed, there definitely is a gap there, as tools/net/ynl/Makefile is
only pulling in yaml from the specs dir:

  SPECDIR=../../../Documentation/netlink/specs
  lint:
      yamllint $(SPECDIR)

The default profile is rather noisy on the schemas, with both errors
and warnings, mostly brackets, line-length and truthy. With this patch
applied:

  $ yamllint -f parsable Documentation/netlink/*.yaml | wc -l
  460
  $ yamllint -f parsable Documentation/netlink/*.yaml | grep -c '\[error\]'
  386

So it'd be worth having a .yamllint config scoped just for the schemas
so we're not chasing a bunch of smaller things, while still checking
for any structure breaking ones (such as the one addressed in this
patch). I'd be happy to put this together as a follow-up if that
sounds useful.
