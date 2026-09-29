Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F129502568
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677838; cv=none; b=gN9j97u0vxITIEJoHzM0nTa8WbdE0pRoo23o5nUM2h0JZp7L6XvX4+Idr63qgkFbpde1JQy5xYXvwreuoNl2Y8Iei5px5LrALmVhgtqmykw2Fbr48BwPmMemIee1H50MJVuChoVMu/gaDaOX+Fj3nefZY0QS2eOn+jDNggwf+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677838; c=relaxed/simple;
	bh=4VV0sYUPcrLrvl2pe9MwsxI2Bn8JEwXuRaw+zprKO44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T22NCGRc1a8NFvvYj5AGy4LtnVk6tgQESUZaClExRjQVB8oQocYTYexqDEV+vx5RLYy2PNF9v+7jmjuqUibJ1JgyNv0rcyP0AJ6+wIUHEMcGWAzwWnBffc//jkKwcd5I+GVBL7Riwllvnu/gps+oNF8HKA2u0i6ibD2rGoFRh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=n8hKBQKU; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="n8hKBQKU"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so2303977c88.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790677822; x=1791282622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfKvJF8vdXJVwY7ZKMBEaJZ1dk9XDpI98eqlwvPGKQ0=;
        b=n8hKBQKUan1GR2heWMBwMdE8D6cDyNYcJTtjaZSIOYMByMvNpWeKFYVa2PtbdXsh1A
         th8tK4R7pU13f7+9r+r8PF6kboxTq0lzu31yvaUezB73eINDTqrg1tnHeUFxXM7xUsiZ
         LxKWSQaR48qsXiC2uc7G7prWuEaokbAARFNm1hO5MAIST9ZTjZ5QUPf3HujjMabCLGLG
         G8anelmYGGSsllGmgKUXUYggXdsMXsEcIF3CUWQtykkNEBV3Bp/PSKAFgFuOUTTUB15o
         +ABAZa+gcYNsDTV24Y+2jE1sMRza2goTnXeHzYdtASimlvc2zXCqk4BtiMTwDmQOjABy
         faqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677822; x=1791282622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfKvJF8vdXJVwY7ZKMBEaJZ1dk9XDpI98eqlwvPGKQ0=;
        b=j1eO6SY5Ekoyn9C92sm2oDeXac5U/QeTYsLxJiLHlcuMkiX/L5VxxsMIhozqlz5NWV
         d+vhEZMe4zR+nbmDtFYSZDa/3bs75rZxmSAWcO5w7lwFUY4FPR+jQ7Q4i5lB4QVoiFW1
         dNi5XHdZzJPcrBukbCwpryuyBoEoTg2WNEXaPv+y3qlVI4V4WatN4P8QqTOaz8yqvgux
         i1nqipNiNh0/8MW6QI4I4ZLepuP0Ev3/HasxrvtIKRhrtOyW8KmMnqMO6Ytz4+2Y1Vgd
         BmGaO2t6FzLavMbjqYsOSPsy40Qn+9h2EYFjTMM0LRynt9OLikJK9BT23Gc/bCH12tTW
         ZaFA==
X-Gm-Message-State: AFuF++mkPs3jkZkUp98I18sWFinoVKEfNIhUx88YLS8hWJuJNKPuN4jK
	1HRYhNOgyknPSKh1/EabAsglotnjiy/RzH1zoqdZx9jAhLCs3sKYZRKKjv8j4jnt+m1QnbKpm4a
	TlJagsrhHPMNFdX+TbVTzkO9hDgK+Ho6gOPhRlcPWUM0nIfKS4KTipUGvngN78MYXSE55zKDS
X-Gm-Gg: AYBFou0T5yeZBnhGJitNF1oKa6m0vMIvyYBUJu6EoXxf25lbAL/w5Ci5j0BFQKmTAPe
	+X+KWW6vJ2rPNby4YG6lMcLYbGQ3cTzoFwOSsLlvWcywwH8hPPkwDdqDmjizE/S4Zc/lGq8yAz6
	GaIqEh4PazKHYVKEj+Ur3UPZ/NtIYkRCQZz9ALGxbyCPw+9f2kRE5dOq2NHEoQjWQVesJrmFujK
	cLp+AW2KpQRorgh4UjWgjFAyOQIIbd42N21c1UrbA0EPHu5JhKInIEtWG1QbzKKrcllQNwWHmlL
	N43VIH9yLAx/KHBahdgfAOuHIdnIdI32DloaY55e4oPMJSzO8k/P3loKSU6VjCwHrW75uaJgHBM
	vs+ifnd3Uggg8F04meCLbqYUozrHq/obLjrX2Qr0rzqJC8e2nYGWKM7sP0SGc2zg8EQueAMXfVV
	eZj38Jwl0K2hfrDUT0T4L1P5S2b8PEEmCi3iPcxw3arsGNVAr87WKxD+S+L7A8ObbbhKztIi3zb
	DnpilBTklEE56qTTACjnA==
X-Received: by 2002:a05:7022:220e:b0:143:296a:4e58 with SMTP id a92af1059eb24-146cfec8688mr19710265c88.27.1790677821169;
        Tue, 29 Sep 2026 03:30:21 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm35238825eec.19.2026.09.29.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:30:20 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: net_test: add tests for bounded GSO segmentation
Date: Tue, 29 Sep 2026 18:30:08 +0800
Message-ID: <20260929103008.2006188-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.3638f2d1c29b1@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com> <20260928044102.1004310-6-wang.zhan@smartx.com> <willemdebruijn.kernel.3638f2d1c29b1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 19:59:54 -0400 Willem de Bruijn wrote:
> > +	GSO_TEST_BOUNDED,
> > +	GSO_TEST_BOUNDED_MULTI,
> > +	GSO_TEST_BOUNDED_ONE_MSS,
>
> nit: bound is not a helpful name for this feature.
>
> The default segments to a stream of skbs of MSS 1, so segmenting to
> a stream of skbs larger MSS to me is not bounding. Quite the opposite.
>
> Not a comment only about this test patch.
>
> Perhaps partial or re-segmentation better captures it.

Agreed.  I think re-segmentation is descriptive enough.  Partial is
already for NETIF_F_GSO_PARTIAL.

> > +	{
> > +		/*
> > +		 * One MSS per skb is what the unbounded path produces, so a
> > +		 * bound of a single segment must not change the output.
> > +		 */
>
> so setting max_segs = 0 is equivalent to setting max_segs = 1.

Right.  The default is one MSS per skb, so 0 and 1 behave the same.
