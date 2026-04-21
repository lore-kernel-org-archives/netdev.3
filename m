Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274737F8A7
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751731; cv=none; b=EtLx07Mq0Bta1txJEBzGpy2m5Zse8eOeyWxhcQ7kflggwwjHXgn5xYyP0E081hbxp10SJCtrjf2m34NzHrAbQKrdwa5s3CXx5dGtIX+KfI4wcxJkTKO80Fmvd770W/0J0UPs/Sk6pYyBs3BjgHQcj9YPgdqQcSW1hqGEHDwDMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751731; c=relaxed/simple;
	bh=y08LmNT23FE3sl4qQWSMnrRe4JaYObKox3rtolEE7zo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=lFQ+gS59+Ui0R6/VyRJ7flAqS9uZpjAKjCdDTNm+URNRmk6gCO+XpYVYSzmFZnuPI4kinuUHR6lUMQ8j5RxhrvQ8lZN068ZyWs6AjinwZrao/TTRWiXBcpm3LFDciFnsoBIkK5ZJzOH+NsxkIww0lc/IDk1WZOzwsJpDhRLM7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEgdMTA3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEgdMTA3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb38e86cf2so365242785a.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776751729; x=1777356529; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y08LmNT23FE3sl4qQWSMnrRe4JaYObKox3rtolEE7zo=;
        b=CEgdMTA3w0AtCNVguoSrXrMlAz834H3XaRggZF9K2r4gnmzlK9/qMNIlg1A/IaUD+d
         uKKfLrLjcBtcYmms785cq+kkwf2NWJNa9LUkGvKcSWjp2afJ+TTv1mlX9cWFwpaKBvk7
         4Fc/nqKy9ziwQ0+5YZcgexPYQnWLQojbcsy4Rr4xkvFSLxO7HUXOXagnBtMoespWkBr4
         F1t8zuf4CLusfA5tlG/6+rrT9lGfNkEntYj5bUzs8Ugr5vYec983k9/cxuOkvTZ0/0nW
         torxYCsiAL98n3xXWUKJLmQQGP4YMkkdKjQhmOCFknoyzQCNhFUBslZjsclO7PgFOrsO
         2BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776751729; x=1777356529;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y08LmNT23FE3sl4qQWSMnrRe4JaYObKox3rtolEE7zo=;
        b=HVQ/toNSdpuSo1J81uATP4+wvnuq9s0y5yVOe4SpQeet8ysPBCtLOOOApiX4328mm7
         wCEDX2sYmv78HiWIHZqoqZJtZcR22zK3u1tq9IWA6XT4+4hEqEMBaCQbEuxE5oDYwMjS
         +CQh/lFZeli8bBSlxikKkui7+LhdyWn+Yil/vE/Z4WRKY8rbSBH6MuH79UG6Xj1yqMsP
         mXfF8b9FZeLnWZknzYmqlKSSO5fsq2HXB25/xxQLI3QKggUuLDVRzOpcYbqp+XILFqod
         nMaNMFh8eFgiD3fHKAMAq+ctlZRDHRMCJyOjMZg5Yz4897aqn3DKimsRNqIhX1NRfeUe
         c2VA==
X-Gm-Message-State: AOJu0YwyXxikAhtebEDgeAfNc9VNTNMuz2+LeZBn9q62vzfM9vTGkurn
	+zrqSjtIm1htG0+w4+WZut7ZxUfQliBYWWazche3Lyenbia8U3U3eEZwMIEIVflXvj965g==
X-Gm-Gg: AeBDies741TwyQBrx7eHssXZaF0t6lhFWP3laJrwiwf5EF95hsK+63mnOKAvNoBZybl
	GmBydgVo7UUpcACJeiki+7vnmpNuYX98jwdR7eI1pizxwqwdgvuYpJHsUiTybW82WVSsDIuC1wi
	WbNECeUVKO2JVDxniFnTqdIYCtugbOCozDhAqdWQwwKViW/5oERm948zWM/nzZyHclRfsRLIEJe
	hbSF8SM1SRjXlSI73zi7NRf/r27SvkzAHCrYIFKbKvmRzNoGYfmrwoVxPvpFWtZHdO5ihmar2NS
	Q6uOjct76HyYW8yQS7wPyhQX31j+YBBlB6qWET6FI1KG/j3OAogoR2WtczM5MVkzixMKy7K1ERs
	SpBIZrL7yu2Pho//CS2R26hN0UxqN7p3lp3PJ53lUYyMxwzXoV0gqXbhn0Z2F1O4xqjA8Tw8aKQ
	P+hJk43/OXoI2QmgKvMG3adO3yPpKFqXSDnDlrcLcCldkS0Ny/C90BBnK8OvqIoXqecUsE8Lg=
X-Received: by 2002:a05:620a:29c3:b0:8cd:942e:82dc with SMTP id af79cd13be357-8e7916b2195mr2239159285a.41.1776751728666;
        Mon, 20 Apr 2026 23:08:48 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb7acsm1043084185a.28.2026.04.20.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:08:48 -0700 (PDT)
Message-ID: <69e71470.050a0220.2e5f9.2bfa@mx.google.com>
Date: Mon, 20 Apr 2026 23:08:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4458957450386200218=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org, jreuter@yaina.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net] ax25: fix OOB read after address header strip in ax25_rcv()
In-Reply-To: <20260421054858.732939-1-ashutoshdesai993@gmail.com>
References: <20260421054858.732939-1-ashutoshdesai993@gmail.com>

--===============4458957450386200218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, Apr 21, 2026 at 05:48:58 +0000, Ashutosh Desai wrote:
> [PATCH v5 net] ax25: fix OOB read after address header strip in ax25_rcv()

Please ignore this patch. A net-deletions patch removing the entire ax25
and amateur radio subsystem was posted earlier today. This fix is no
longer needed.

--===============4458957450386200218==--
